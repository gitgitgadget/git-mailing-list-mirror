Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EF7C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 21:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiG1VJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiG1VJl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 17:09:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF50D77A41
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 14:09:39 -0700 (PDT)
Received: (qmail 19178 invoked by uid 109); 28 Jul 2022 21:09:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jul 2022 21:09:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17574 invoked by uid 111); 28 Jul 2022 21:09:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jul 2022 17:09:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jul 2022 17:09:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Message-ID: <YuL7EotrIpnOn5BT@coredump.intra.peff.net>
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
 <YuGPeHn9wfF6tWA5@coredump.intra.peff.net>
 <220728.86o7x9jhrp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220728.86o7x9jhrp.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 28, 2022 at 06:54:37PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > There's really no reason to split the "address" and "undefined" builds
> > into two jobs. We expect them to pass, and if one fails, having the
> > results split is not likely to give any extra information. So I think
> > one job with SANITIZE=address,undefined is fine, and reclaims some of
> > the extra CPU we're spending.
> 
> I'll do that in a re-roll, pending a resolution of the naming discussion
> at:
> https://lore.kernel.org/git/220728.86sfmljhyx.gmgdl@evledraar.gmail.com/

Thanks. FWIW, I have no opinion on the job naming. ;)

> But note that it *does* give you extra information to split them up
> currently, i.e. the "test_expect_failure" that you get with "undefined"
> isn't conflated with the non-changes that SANITIZE=address flags (sans
> outstanding recent breakage) in the test report.
> 
> But just having that "TODO" test sitting there will suck less than
> potentially having CI run much longer, or taking up resources from
> concurrent CI runs, so I'll do this.

My hope would be that we'd identify and fix cases where this flagged,
even in expect_failure, and so any state like you describe would be
temporary. In the long term, we should be able to assume that these
don't trigger warnings in the existing code base, and optimize in that
direction.

> We also leave a lot of CI performance on the table by e.g. doing "chain
> lint" in every single test run (except Windows), there *are* platform
> edge-cases there like with SANITIZE=address, but I wonder if we should
> just declare it good enough to do it in 1-2 jobs.

I'd be fine with that, but I think chain lint isn't actually that
expensive. The original in-shell bits are super cheap. The extra
sed process is measurable, but I think I blunted the worst of it in the
2d86a96220 (t: avoid sed-based chain-linting in some expensive cases,
2021-05-13).

Still, that patch should make it easy to time things just by setting
GIT_TEST_CHAIN_LINT_HARDER=0 in various jobs. It does seem to buy ~100s
of CPU time per test run on my Linux box. That's not a lot in the grand
scheme, but perhaps adds up. And I could believe it's much worse on
Windows. Maybe worth seeing how it performs in the actual CI
environments.

> Ditto TEST_NO_MALLOC_CHECK=1 & --no-bin-wrappers, but we can think about
> all of those some other time....

I'd be surprised if the malloc checking itself is all that expensive,
though it does look like we call getconf and expr once per test there
for setup. We could almost certainly hoist that out and call it once per
script.

-Peff
