Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367CEC433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CBA64DD3
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhCAJki (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 04:40:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:47860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234038AbhCAJkU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 04:40:20 -0500
Received: (qmail 4547 invoked by uid 109); 1 Mar 2021 09:39:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Mar 2021 09:39:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21731 invoked by uid 111); 1 Mar 2021 09:39:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Mar 2021 04:39:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Mar 2021 04:39:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] Makefile: build "$(FUZZ_OBJS)" in CI, not under
 "all"
Message-ID: <YDy2WMMg4asR8E4B@coredump.intra.peff.net>
References: <20210201111715.10200-1-avarab@gmail.com>
 <20210223114132.24345-7-avarab@gmail.com>
 <YDVJZnmTiBYZ4iPM@coredump.intra.peff.net>
 <87wnusj6gt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnusj6gt.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 28, 2021 at 09:13:54PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > The current state is that regular devs are responsible for avoiding
> > compile breakages in the fuzz objects, even if they don't care
> > themselves. Your earlier patches turned this into: regular devs are not
> > on the hook for breaking fuzz objects; they are the responsibility of
> > fuzz people. I'm OK with either of those, but this approach seems to me
> > like the worst of both worlds. ;)
> >
> > If you do a refactor, you are still on the hook for breaking the fuzz
> > objects because CI will fail (and you have to investigate it, and fix it
> > for CI to remain a useful tool). But instead of finding out about the
> > problem quickly as you're working, instead you push up what you think is
> > a finished result, and then from minutes to hours later you get a
> > notification telling you that oops, you missed a spot. I find that the
> > shorter the error-fix-compile cycle is, the less time I waste waiting or
> > context-switching.
> >
> > If we had a ton of fuzz object files that took forever to build, the
> > savings on each build might be worth it. But AFAICT (from timing "make
> > clean; make -j1" before and after), we are saving less than 1% of the
> > build time (which is way less than the run-to-run noise).
> >
> > It doesn't seem like the right tradeoff to me. (Likewise, if other
> > CI-only checks we have, like coccinelle, could be run at a similar cost,
> > I'd recommend sticking them into the default developer build).
> 
> It's mainly psychological and doesn't contribute much to overall build
> time as a percentage, but I find it grating that the last thing I see
> before I switch away from that terminal when firing off a build on a
> slower GCC farm box I can only use -j1 on, is these fuzz objects taking
> 2-3 seconds to build, knowing I'm wasting time on something I'll never
> need.

Sure, I find it annoying, too. And I am totally fine with saying "nope,
let them bitrot if nobody cares enough about them to build". That is
after all what happens with a bunch of stuff in compat/, or custom code
like NO_PTHREADS, or with/without pcre, curl, etc.

This just seems like a bad middle ground.

> I think when we build something we should narrowly be compiling only the
> things we need, not running some sort of pseudo-CI on every developer's
> computer. We can have CI or other targets for that.
> 
> Besides, if we were going for some sane cost-benefit here we'd have
> targets to try compiling with NO_CURL=1 or some other conditional setups
> that are actually common in the wild.

Right. So that mostly just argues to me for not compiling them ever
unless they are needed. I.e., dropping the CI part of your patch.

> > One thing we _could_ do is stop building fuzz objects as part of "all",
> > but include them for DEVELOPER=1 builds (which includes CI). That keeps
> > them from hurting normal users (who don't actually need them), but
> > prevents bitrot. It doesn't address your original motivation though (you
> > as a developer would probably still be building them).
> 
> Please no. A very good thing about how DEVELOPER=1 works is that we're
> not doing anything extra except advisory compilation flags. It's turned
> on for "production" builds in a lot of settings because of that.

I'm not convinced that we should limit the DEVELOPER flag for this
reason in general. The point of the flag is to add extra linting,
including stopping the build if need be. If that is in tension with
somebody using it for production builds, I would always choose improving
the developer experience.

That said, I don't at all care about linting the fuzz code, so I don't
think it's a very compelling case.

-Peff
