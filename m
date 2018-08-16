Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC681F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeHPUj0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:39:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:57838 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728312AbeHPUj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:39:26 -0400
Received: (qmail 10401 invoked by uid 109); 16 Aug 2018 17:39:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 17:39:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17868 invoked by uid 111); 16 Aug 2018 17:39:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 13:39:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 13:39:34 -0400
Date:   Thu, 16 Aug 2018 13:39:34 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/7] speeding up cat-file by reordering object access
Message-ID: <20180816173934.GC882@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
 <fc30f98e-0aa0-89d3-ee32-3d86cc5b342a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc30f98e-0aa0-89d3-ee32-3d86cc5b342a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 10:05:04AM -0400, Derrick Stolee wrote:

> One thing that I realized while reading it is that the multi-pack-index is
> not integrated into the for_each_packed_object method. I was already going
> to work on some cleanups in that area [1][2].
> 
> When using the new flag with the multi-pack-index, I expect that we will
> want to load the pack-files that are covered by the multi-pack-index
> (simply, the 'packs' array) and use the same mechanism to traverse them in
> order. The only "strange" thing about this is that we would see duplicate
> objects when traversing the pack-files directly but not when traversing the
> multi-pack-index (since it de-duplicates when indexing).

I think that makes sense. We already see duplicates from
for_each_packed_object() when they're in multiple packs, and callers
just need to be ready to deal with it (and depending on what you're
doing, you may actually _want_ the duplicates).

Thanks for thinking through the implications for other topics. I hadn't
even considered how this would interact with midx.

-Peff
