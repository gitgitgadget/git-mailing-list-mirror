Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3697AC34047
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0757D2173E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBRUaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:30:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:47180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726401AbgBRUaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:30:17 -0500
Received: (qmail 20147 invoked by uid 109); 18 Feb 2020 20:30:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 20:30:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22260 invoked by uid 111); 18 Feb 2020 20:39:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 15:39:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 15:30:16 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/15] pack-bitmap: implement BLOB_NONE filtering
Message-ID: <20200218203016.GF21774@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182236.GM150965@coredump.intra.peff.net>
 <800e4714-200e-6256-5538-ef39f6d9246c@gmail.com>
 <ffb700bf-862c-8a40-453b-9d7adb638798@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffb700bf-862c-8a40-453b-9d7adb638798@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 02:36:55PM -0500, Derrick Stolee wrote:

> > I wondered why you chose to extend these tests instead of using
> > p5600-partial-clone.sh, but I guess this script definitely creates
> > the bitmap for the test. When I tested p5600-partial-clone.sh below,
> > I manually repacked the Linux repo to have a bitmap:
> > 
> > Test                          v2.25.0               HEAD                    
> > ----------------------------------------------------------------------------
> > 5600.2: clone without blobs   79.81(111.34+11.35)   36.00(69.37+7.30) -54.9%
> > 5600.3: checkout of result    45.56(114.59+4.81)    46.43(80.50+5.41) +1.9% 
> > 
> > Perhaps results for these tests would also be appropriate for your
> > commit messages?
> 
> And speaking of valuable performance tests to update: should we take
> the loop of fetch tests in p5311-pack-bitmaps-fetch.sh and make
> equivalent versions in p5600-partial-clone.sh? It would be good to
> make sure that the incremental fetches also improve in this scenario.

I don't think it would make sense to add them permanently, since p5600
doesn't necessarily have bitmaps in effect.

But in any case, those tests are mostly about pack-objects realizing
when we can use on-disk deltas due to the presence of bitmaps. If we're
avoiding sending blobs, then that cuts out a huge chunk of opportunity
for it to make any improvement (it might still have some impact because
of trees, though). So I'd expect the effect to be muted.

I dunno. It's true that I just hypothesized a result which we could
confirm. But the perf tests are quite expensive to run (and p5311 is one
of the more expensive ones). I'm not sure that repeating those tests
combined with partial clones carries a lot of regression-testing value
to merit adding that expense to all future runs.

-Peff
