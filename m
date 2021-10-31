Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C545C433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 08:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038D860F58
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 08:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhJaIcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 04:32:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:50476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhJaIcW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 04:32:22 -0400
Received: (qmail 28542 invoked by uid 109); 31 Oct 2021 08:29:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 31 Oct 2021 08:29:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8149 invoked by uid 111); 31 Oct 2021 08:29:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 31 Oct 2021 04:29:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 31 Oct 2021 04:29:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
Message-ID: <YX5T+wt0hSkxkLHA@coredump.intra.peff.net>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 31, 2021 at 12:32:26AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Remove the hardcoded lists of objects in favor of using
> $(wildcard). This means that every time a built-in, test tool etc. is
> added we won't need to patch the top-level Makefile, except for the
> few remaining cases where the asset in question would make it onto one
> of our list of exceptions.
> 
> Ever since 81b50f3ce40 (Move 'builtin-*' into a 'builtin/'
> subdirectory, 2010-02-22) this has been relatively easy to do (and
> even before that we could glob builtin-*.c). This pattern of
> exhaustively enumerating files was then carried forward for
> e.g. TEST_BUILTINS_OBJS in efd71f8913a (t/helper: add an empty
> test-tool program, 2018-03-24).
> 
> One reason not to do this is that now a new *.c file at the top-level
> will be immediately picked up, so if a new *.c file is being worked on
> "make" will error if it doesn't compile, whereas before that file
> would need to be explicitly listed in the Makefile. I think than small
> trade-off is worth it.

A more general way of thinking about this is that we are switching from
"ignore source files by default" to "stick source files into LIB_OBJS by
default". So it's helpful if you were going to stick that file into
LIB_OBJS, but harmful otherwise.

Your "new *.c file" example is one case, because it wouldn't have been
added _yet_. And I agree it's probably not that big a deal in practice.

The other cases are ones similar to what you had to exclude from
LIB_OBJS manually here:

> +LIB_OBJS += $(filter-out \
> +	$(ALL_COMPAT_OBJS) \
> +	git.o common-main.o $(PROGRAM_OBJS) \
> +	$(FUZZ_OBJS) $(CURL_OBJS),\
> +	$(patsubst %.c,%.o,$(wildcard *.c)))

So if I wanted to add a new external program source but forgot to put it
into PROGRAM_OBJS, the default would now be to pick it up in LIB_OBJS.
That's weird and definitely not what you'd want, but presumably you'd
figure it out pretty quickly because we wouldn't have built the command
you expected to exist.

Likewise, there's an interesting tradeoff here for non-program object
files. The current Makefile does not need to mention unix-socket.o
outside of the NO_UNIX_SOCKETS ifdef block, because that's where we
stick it in LIB_OBJS. After your patch, it gets mentioned twice: in that
same spot, but also as an exception to the LIB_OBJS rule (via the
ALL_COMPAT_OBJS variable above).

So we're trading off having to remember to do one thing (add stuff to
LIB_OBJS) for another (add stuff to the exception list). Now one of
those happens a lot more than the other, which is why you get such a
nice diffstat. So it might be worth the tradeoff.

I don't have a very strong opinion either way on this. I felt like we'd
discussed this direction before, and came up with this thread from the
archive:

  https://lore.kernel.org/git/20110222155637.GC27178@sigill.intra.peff.net/

There it was coupled with suggestions to actually change the file
layout. That could make some of those exceptions go away (say, if all of
LIB_OBJS was in "lib/"), but it's a bigger change overall. So I offer it
here mostly for historical context / interest.

I didn't see anything obviously wrong in the patch, but two comments:

>  - De-indent an "ifndef" block, we don't usually indent their
>    contents.

Quite a lot of existing conditional blocks are indented, but I think for
conditional inclusions of one entry in a larger list (where the rest of
the list isn't indented), this makes sense. And that's what you changed
here.

> +# LIB_OBJS: compat/* objects that live at the top-level
> +ALL_COMPAT_OBJS += unix-socket.o
> +ALL_COMPAT_OBJS += unix-stream-server.o
> +ALL_COMPAT_OBJS += sha1dc_git.o

I think "compat" is a misnomer here. For one thing, they're by
definition not "compat/*" objects, because they're not in that
directory. ;) But more importantly, the interesting thing about them is
not that they're compatibility layers, but that they're part of a
conditional compilation. I.e., we might or might not want them, which
will be determined elsewhere in the Makefile, so they must not be part
of the base LIB_OBJS set.

Probably CONDITIONAL_OBJS or something might be more descriptive. That
_could_ be used to include things like CURL_OBJS, but there's probably
value in keeping those in their own list anyway.

Likewise, they could go into a conditional-src/ directory (or some
less-horrible name) to keep them distinct without needing an explicit
list in the Makefile. That's sort of the flip-side of putting all the
other LIB_OBJS ones into lib/.

-Peff
