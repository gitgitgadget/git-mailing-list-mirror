Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1579BC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E835B60FED
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhHLVT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 17:19:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:46058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236417AbhHLVTU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 17:19:20 -0400
Received: (qmail 25127 invoked by uid 109); 12 Aug 2021 21:18:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 21:18:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25605 invoked by uid 111); 12 Aug 2021 21:18:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 17:18:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 17:18:52 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 25/25] p5326: perf tests for MIDX bitmaps
Message-ID: <YRWQPDd2S6Hi/2Ge@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <82e8133bf4f6ecf2ca509f6d9e2e0d369d7f19e3.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82e8133bf4f6ecf2ca509f6d9e2e0d369d7f19e3.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 05:20:28PM -0400, Taylor Blau wrote:

> These new performance tests demonstrate effectively the same behavior as
> p5310, but use a multi-pack bitmap instead of a single-pack one.
> 
> Notably, p5326 does not create a MIDX bitmap with multiple packs. This
> is so we can measure a direct comparison between it and p5310. Any
> difference between the two is measuring just the overhead of using MIDX
> bitmaps.
> 
> Here are the results of p5310 and p5326 together, measured at the same
> time and on the same machine (using a Xenon W-2255 CPU):

Neat. I think having separate perf regression tests for regular and mix
bitmaps will be useful, but being able to compare the pack and mix
versions is a cherry on top.

There was one funny number:

>     5310.2: repack to disk                                96.78(93.39+11.33)
>     5326.2: setup multi-pack index                        78.99(75.29+11.58)

In p5310, that step is repacking and writing bitmaps. With the midx,
it's repacking, then writing a midx with bitmaps. I'd expect the latter
to be strictly slower than the former, but here it's faster.

Running the code locally, I got similar results (with p5310 just a tiny
bit faster). So it may have just been noise or some other timing issue.

  As an aside, I think that test is a little bit bogus due to
  GIT_PERF_REPEAT_COUNT; the first trial will generate bitmaps from
  scratch, and then subsequent runs will reuse partial results. It
  probably should "rm -f .git/objects/*.bitmap" within the test. We can
  deal with that separately, though.

-Peff
