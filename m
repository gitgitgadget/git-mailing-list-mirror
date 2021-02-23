Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C064DC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6933664E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhBWS3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:29:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:41938 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233929AbhBWS3h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 13:29:37 -0500
Received: (qmail 26697 invoked by uid 109); 23 Feb 2021 18:28:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 18:28:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2211 invoked by uid 111); 23 Feb 2021 18:28:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 13:28:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 13:28:54 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] Makefile: build "$(FUZZ_OBJS)" in CI, not under
 "all"
Message-ID: <YDVJZnmTiBYZ4iPM@coredump.intra.peff.net>
References: <20210201111715.10200-1-avarab@gmail.com>
 <20210223114132.24345-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210223114132.24345-7-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:41:32PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Adding $(FUZZ_OBJS) as a dependency on "all" was intentionally done in
> 5e472150800 (fuzz: add basic fuzz testing target., 2018-10-12).
> 
> Rather than needlessly build these objects which aren't required for
> the build every time we make "all", let's instead move them to be
> built by the CI jobs.
> 
> The goal is to make sure that we don't inadvertently break these, we
> can accomplish that goal by building them in CI, rather than slowing
> down every build of git for everyone everywhere.

The current state is that regular devs are responsible for avoiding
compile breakages in the fuzz objects, even if they don't care
themselves. Your earlier patches turned this into: regular devs are not
on the hook for breaking fuzz objects; they are the responsibility of
fuzz people. I'm OK with either of those, but this approach seems to me
like the worst of both worlds. ;)

If you do a refactor, you are still on the hook for breaking the fuzz
objects because CI will fail (and you have to investigate it, and fix it
for CI to remain a useful tool). But instead of finding out about the
problem quickly as you're working, instead you push up what you think is
a finished result, and then from minutes to hours later you get a
notification telling you that oops, you missed a spot. I find that the
shorter the error-fix-compile cycle is, the less time I waste waiting or
context-switching.

If we had a ton of fuzz object files that took forever to build, the
savings on each build might be worth it. But AFAICT (from timing "make
clean; make -j1" before and after), we are saving less than 1% of the
build time (which is way less than the run-to-run noise).

It doesn't seem like the right tradeoff to me. (Likewise, if other
CI-only checks we have, like coccinelle, could be run at a similar cost,
I'd recommend sticking them into the default developer build).

One thing we _could_ do is stop building fuzz objects as part of "all",
but include them for DEVELOPER=1 builds (which includes CI). That keeps
them from hurting normal users (who don't actually need them), but
prevents bitrot. It doesn't address your original motivation though (you
as a developer would probably still be building them).

-Peff
