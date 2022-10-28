Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39174C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 05:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ1FcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 01:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ1FcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 01:32:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A6E1AC1F5
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 22:32:08 -0700 (PDT)
Received: (qmail 19393 invoked by uid 109); 28 Oct 2022 05:32:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Oct 2022 05:32:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31525 invoked by uid 111); 28 Oct 2022 05:32:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Oct 2022 01:32:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Oct 2022 01:32:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Message-ID: <Y1tpVqWn5yMYbE21@coredump.intra.peff.net>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
 <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
 <221026.8635badbz5.gmgdl@evledraar.gmail.com>
 <Y1su99Kc0ex1W7bX@coredump.intra.peff.net>
 <221028.86sfj88xdq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221028.86sfj88xdq.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 04:04:12AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I think this particular case is tricky in that direction, because it's a
> > big set of dependencies that aren't necessarily one-to-one. E.g.,
> > builtin/log.c needs to depend on git-log.txt, but also on git-show.txt
> > and git-format-patch.txt.
> 
> I was thinking of just a generated usage-strings.c or whatever. I.e. one
> file with every usage string in it. Then you don't need to hunt down
> which thing goes in which file. We'll just have a variable named
> "builtin_format_patch_usage". Include it in "builtin.h" and it doesn't
> matter if that's in builtin/log.c or builtin/format-patch.c.

Yes, though you have the opposite problem, then: what are the source
files that can produce that usage-strings.c? If your answer is
"Documentation/git-*.txt", then that is a recipe for flaky dependencies.

We already have one such for config-list.h. Try this:

  # introduce a new file
  printf 'foo.bar::\n\ta fake config var\n' \
    >Documentation/config/foo.txt

  # it shows up in the output, as expected
  make
  ./git help --config-for-completion | grep foo

  # now drop it
  rm Documentation/config/foo.txt

  # oops; make won't rebuild anything, and it's still there
  make
  ./git help --config-for-completion | grep foo

The bug is that config-list.h depends on a glob. So we notice when a
file changes, but not when one goes away. And this isn't just
hypothetical. Files come and go as you "git checkout" around history (or
bisect). I don't remember the details, but I'm pretty sure I've gotten
false positive test failures out of this before (maybe a topic branch
with a bogus entry that broke t0012 or t9902, and then moving back to
master doesn't fix it?).

So I'd prefer to avoid introducing more flakiness if we can. You might
be able to piggy back on command-list.txt in this case (that's what
makes command-list.h not flaky).

> It does mean you need to rebuild the C code for other built-ins every
> time one of the SYNOPSIS sections changes, but doesn't happen too often.

If it's a c/h combo that only makes the variable names public (not the
contents of the strings they point to), then it would only trigger a
rebuild when a command is added or removed.

> I think I either did or was planning to take it out of cache.h as part
> of that, we put way too much in cache.h.
> 
> Even advice.c depends on cache.h for its advice.h *sigh*.
> 
> Trying it just now putting advice.h in builtin.h instead leaves 10
> top-level files not-compiling (and they just need the header).
> 
> I think it's fine to include common utilties in our "included by
> everything" headers, but if we've got ~500 *.c files and something is
> only needed by ~20 of them (as in this case) we should probably just
> include it in those 20.

Oh, definitely, we should be shrinking cache.h, and not adding more to
it. Especially not generated stuff.

> >> 	make file-that-does-not-use-generated-header.o
> >> 
> >>    It sucks a bit to have e.g. every *.o depend on command-list.h, when
> >>    we only use it in 1-2 places, ditto the other headers.
> > But that is already true of non-generated headers. If your system
> > doesn't support computed deps, then all objects depend on all headers.
> 
> ... this does not build e.g. command-list.h:
> 
> 	make clean
> 	make grep.o
> 
> But this does:
> 
> 	make clean
> 	make help.o
> 
> Because we've manually declared that.

Right, but...does grep.o actually need command-list.h? If it doesn't
(and that seems to be the case), then all is working as intended. If
grep included some other header that included command-list.h, then yeah,
that would be a bug. But that is true whether grep.c includes it
directly or not. Any Makefile dependency needs to take into account
recursive includes.

> > Yes, that sucks for you. But almost nobody actively develops on such a
> > system, and people building Git to use rarely notice (because they are
> > doing an initial build, or jumping versions, both of which generally
> > require recompilation anyway).
> 
> I guess I'm "almost nobody" :) Not because I don't use computed deps,
> but because I tend to e.g. do large interactive rebases with:
> 
> 	git rebase -i 'make grep.o'
> 
> Or some other subset of our built assets/objects.

I do that all the time, too. But with computed deps, it works (by which
I mean it rebuilds only stuff needed by grep.o).

I'm not even sure what we're talking about anymore. If you are saying
that no, we don't want to just say "everything depends on foo.h that is
generated", I agree. That is wrong to do, and we should specify the
minimal dependencies where appropriate (and take care to keep that set
as small as is feasible using small C interfaces).

If you're saying "for people without computed dependencies, everything
will want to rebuild shell scripts", then I don't care. We decided long
ago that maintaining a manual list of header dependencies was not worth
doing, and people with sub-par compilers will have to suffer.

In the email you're replying to, I was trying to express the second one.
But it sounds like you thought I was trying to argue against the first
one.

-Peff
