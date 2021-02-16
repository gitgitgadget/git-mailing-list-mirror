Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314CC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD6664EAD
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhBPX7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:59:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:35204 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBPX65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 18:58:57 -0500
Received: (qmail 15514 invoked by uid 109); 16 Feb 2021 23:58:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 23:58:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30901 invoked by uid 111); 16 Feb 2021 23:58:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 18:58:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 18:58:16 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 5/8] p5303: measure time to repack with keep
Message-ID: <YCxcGKo7kyLwVvw+@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <b5081c01b53beb568ef2e59956d25b36be9f24d0.1612411124.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5081c01b53beb568ef2e59956d25b36be9f24d0.1612411124.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 10:59:13PM -0500, Taylor Blau wrote:

> From: Jeff King <peff@peff.net>
> 
> This is the same as the regular repack test, except that we mark the
> single base pack as "kept" and use --assume-kept-packs-closed. The

I don't think that option exists anymore. I guess we are just using
--stdin-packs, which causes us to mark a pack as kept.

I think we could just mark it in the filesystem and use
--honor-pack-keep, which would make it independent of your new feature.
At first I was going to say "but it doesn't matter either way", but...

> theory is that this should be faster than the normal repack, because
> we'll have fewer objects to traverse and process.
> 
> Here are some timings on a recent clone of the kernel. In the
> single-pack case, there is nothing do since there are no non-excluded
> packs:
> 
>   5303.5: repack (1)                          57.42(54.88+10.64)
>   5303.6: repack with --stdin-packs (1)       0.01(0.01+0.00)
> 
> and in the 50-pack case, it is much faster to use `--stdin-packs`, since
> we avoid having to consider any objects in the excluded pack:
> 
>   5303.10: repack (50)                        71.26(88.24+4.96)
>   5303.11: repack with --stdin-packs (50)     3.49(11.82+0.28)
> 
> but our improvements vanish as we approach 1000 packs.
> 
>   5303.15: repack (1000)                      215.64(491.33+14.80)
>   5303.16: repack with --stdin-packs (1000)   198.79(380.51+7.97)
> 
> That's because the code paths around handling .keep files are known to
> scale badly; they look in every single pack file to find each object.

Well, part of it is just that with 1000 packs we have 20 times as many
objects that are actually getting packed with --stdin-packs, compared to
the 50-pack case. IIRC, each pack is a fixed-size slice and then the
residual is put into the .keep pack. So the fact that the time gets
closer to a full repack as we add more packs is expected: we are asking
pack-objects to do more work!

For showing the impact of the optimizations in patches 7 and 8, I think
doing a full repack with --honor-pack-keep is a better test. Because
then we're always doing a full traversal, and most of the work continues
to scale with the repo size (though obviously not the actual shuffling
of packed bytes around). That would get rid of the weird "no work to do"
case in the single-pack tests, too.

-Peff
