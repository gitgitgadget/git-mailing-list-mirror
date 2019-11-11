Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8BE1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 14:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKKO2B (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 09:28:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:44526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726913AbfKKO2B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 09:28:01 -0500
Received: (qmail 20596 invoked by uid 109); 11 Nov 2019 14:28:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 14:28:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7044 invoked by uid 111); 11 Nov 2019 14:31:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 09:31:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 09:28:00 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pack-objects: avoid pointless oe_map_new_pack() calls
Message-ID: <20191111142800.GA1934@sigill.intra.peff.net>
References: <20191111111249.GA31169@sigill.intra.peff.net>
 <01605e2d-5ea7-037d-b25f-3774b88d059d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01605e2d-5ea7-037d-b25f-3774b88d059d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 08:42:47AM -0500, Derrick Stolee wrote:

> > The current test in p5303 sadly doesn't notice this problem, since it
> > maxes out at 1000 packs. If we add a new test to it at 2000 packs, it
> > does show the improvement:
> > 
> >   Test                      HEAD^               HEAD
> >   ----------------------------------------------------------------------
> >   5303.12: repack (2000)    26.72(39.68+0.67)   15.70(28.70+0.66) -41.2%
> 
> And these numbers don't really show a quadratic improvement, probably due
> to the test itself needing to do the work to create 2000 packs.

No, the 2000-pack setup happens in a separate (untimed) test.

The reason this improvement is less extreme is that we're only hitting
the extra oe_map_new_pack() call for a subset of the objects. The first
1023 packs have an index field (and because of the way we generate the
packs, I think that includes the "big" initial pack), so not every
object triggers the problem.

This was spurred by a couple of real cases where maintenance had fallen
behind and we had accrued a lot of packs (and of course we wanted to
repack to get out of the bad situation, which became a chicken and egg).
One of those real-world cases with 15,000 packs dropped from ~11 hours
to ~5 minutes.

I'm actually amazed we didn't notice this before (the problem started in
v2.18, which we deployed at GitHub over a year ago). But we try to avoid
ending up with that many packs in the first place, and even when we did,
automated maintenance _usually_ dug them out by itself if you were
patient enough.

> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks!

-Peff
