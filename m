Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7BEC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9057C60F58
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhHPWXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 18:23:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:49214 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhHPWXc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 18:23:32 -0400
Received: (qmail 26012 invoked by uid 109); 16 Aug 2021 22:23:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 22:23:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19651 invoked by uid 111); 16 Aug 2021 22:22:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 18:22:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 18:22:59 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Message-ID: <YRrlQwLENaWs8zWm@coredump.intra.peff.net>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
 <YRaYnDR6RlgJRr/P@coredump.intra.peff.net>
 <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com>
 <YRqwIAL/JgJp+RyI@coredump.intra.peff.net>
 <01c501d792df$5fcb24b0$1f616e10$@nexbridge.com>
 <YRrSXhbaZMLMq+1/@coredump.intra.peff.net>
 <01d001d792e9$55f45470$01dcfd50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01d001d792e9$55f45470$01dcfd50$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 05:54:44PM -0400, Randall S. Becker wrote:

> Running git-send-email reports completion 162. The code variable is
> optimized out but looks like it also is 162 when returning. The
> WIFEXITED(status) code did not appear to execute, although I think
> that also was optimized out. finish_command ret is 162. So perl looks
> like it is completing with a bad completion code. This percolates up
> to git, which also reports the same value.

OK, at least that absolves git.c. :)

> I went to the perl maintainer on this subject. What I got back was
> that die is not guaranteed to return a specific value other than 0 for
> success and non-zero for failure. There are platforms where the return
> might known and has meaning but that is not portable. According to the
> current official perl documentation:
> 
> "die raises an exception. Inside an eval the exception is stuffed into
> $@ and the eval is terminated with the undefined value. If the
> exception is outside of all enclosing evals, then the uncaught
> exception is printed to STDERR and perl exits with an exit code
> indicating failure. If you need to exit the process with a specific
> exit code, see exit."

Ouch. I mean, sure, if you need a specific code, I get that die is not a
good tool. But getting arbitrary values seems kind of weird and
unfriendly. The perldoc for die does say it gives you $! (errno), or $?
(the last child exit value) if appropriate. So it's not completely
arbitrary, but I think your errno value may just be unlucky.

> So assuming that a signal occurred because the value is between 129
> and 192 is not correct in the case of perl. Could we do something like
> test_expect_perl_die that does not perform the signal check at line
> 980 in test-lib-functions.sh so just checks 0 vs. non-zero, which
> would be semantically correct no matter what the platform?
> Alternatively, and possibly better, the die could be caught and then
> exit() called in git-send-email, as in:
> 
> eval { die "Something bad happened" };
> exit(255) if $@;

Yeah, I think we are better to get a consistent exit code from perl.
There are a few options here:

 - wrapping in an eval works, as you showed above. It's a little awkward
   to wrap the whole script, though.

 - there's $SIG{__DIE__}, but the manpage warns against using it. You
   can use it something like this:

     sub catch_top {
       CORE::die @_ if $^S; # in an eval; use regular die
       CORE::die @_ if !defined $^S; in perl's parser
       print STDERR "@_\n";
       exit 255; # or whatever we want
     }
     $SIG{__DIE__} = \&catch_top;

 - you can hook die() like this:

     BEGIN { *CORE::GLOBAL::die = \&my_die; }

   but I expect would still need to check that you're not in an eval, as
   above.

  - The SIG{__DIE__} docs mention using an END{} block, but I'm not sure
    how you determine if we hit a die or not (at that point, $@ won't
    actually be set).

I've used the catch_top() thing before and it does work (it's just ugly
that you have to deal with $^S).

I guess yet another alternative is that we could avoid using perl's
die() in favor of our own custom-named function. It seems like that may
confuse folks who come later, though.

-Peff
