Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC8C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7E61D02
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhF2C3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:29:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:35718 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhF2C3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:29:24 -0400
Received: (qmail 17705 invoked by uid 109); 29 Jun 2021 02:26:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Jun 2021 02:26:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23252 invoked by uid 111); 29 Jun 2021 02:26:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Jun 2021 22:26:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Jun 2021 22:26:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Message-ID: <YNqE8BIRF6NeYQcd@coredump.intra.peff.net>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local>
 <8735t93h0u.fsf@evledraar.gmail.com>
 <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
 <87r1gs1hfx.fsf@evledraar.gmail.com>
 <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
 <871r8r1hwe.fsf@evledraar.gmail.com>
 <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
 <87fsx6xn0b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsx6xn0b.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 25, 2021 at 11:49:14AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Ah, right. Thanks for refreshing me.
> >
> > TBH, I don't find this that serious a problem. Your compile will fail.
> > But is rebuilding in the middle of a test run something it's important
> > to support seamlessly? It seems like a bad practice in the first place.
> 
> Yeah I think so, and I think it's good practice, it enabled development
> workflows that you and Junio clearly don't use (which is fine), but
> which are useful to others. For me it would result in more total
> testing, and earlier catching of bugs, not less.
> 
> Quoting an earlier mail of yours[1]:
> 
>     I think having the test suite loudly complain is a good way to
>     remind you that you have not in fact run the whole suite on a given
>     build.
> 
> It's useful as you're programming you save/compile, and have the tests
> run in a loop in the background, and are alerted if they start
> failing.
> 
> That's not really possible with git currently without having that loop
> continually push to another workdir, making it work in one checkout
> helps for some workflows.

I actually _do_ have a workflow like this, but as you might guess, it
involves a separate workdir. I have a loop going in one terminal waiting
for new commits, which it then checks out on a detached HEAD and tests.

So I'm definitely sympathetic to this kind of continuous testing. My
questioning was really about doing it in a hacky way where you're not
actually sure what's been tested and what hasn't. If you're not willing
to test just committed states, then it gets a lot harder (OTOH, I'd
expect a ton of spurious failures there as you have half-finished
states). But if you are, then I think making sure you've tested each
commit fully has huge value, because then you can cache the results.

I'm not sure if the "only test committed states" thing is a deal-breaker
for you or not. If not, the script I use is at:

  https://github.com/peff/git/blob/meta/ci

which is really just a glorified infinite loop with some inotify
hackery. It relies on this program to do the caching:

  https://github.com/mhagger/git-test

A nice extra thing you can do is use the same cache with "git rebase -x"
as a final check of each patch in a series before you send it out. If
the CI loop was running continuously in the background, then it's just a
noop of "yes, we already tested this".

> Yes it could allow you to run format-patch and send-email while you're
> 50% through a full loop, or not just run the full tests then, but at
> some point I think we've got to assume some basic competency from
> people. We also have CI running the full tests, and I could have just
> run tests 0000-5000, compiled, and then run 5001-9999.

Yeah, I can see the view that running the test suite as a basic sanity
check may have value, if it's backed by more careful testing later (and
certainly while I'm developing, I wouldn't hesitate to run a subset of
the test suite to see how my work is progressing).

My main point was that I don't see much reason to do work to make that
kind of continuous "make test" work with simultaneous recompiles and
test-runs, if we can encourage people to do it more robustly with a
single compile-and-test-run loop. Maybe adding in the extra workdir
there makes it too heavy-weight? (Certainly my "ci" script is overkill,
but it seems like a loop of "reset to the current branch tip, compile,
run" in a worktree would be the minimal thing).

-Peff
