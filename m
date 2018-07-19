Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB191F597
	for <e@80x24.org>; Thu, 19 Jul 2018 17:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbeGSRsG (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:48:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731751AbeGSRsG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:48:06 -0400
Received: (qmail 1057 invoked by uid 109); 19 Jul 2018 17:04:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 17:04:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12694 invoked by uid 111); 19 Jul 2018 17:04:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 13:04:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 13:04:00 -0400
Date:   Thu, 19 Jul 2018 13:04:00 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180719170400.GC4868@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719151640.GA24997@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 05:16:42PM +0200, Duy Nguyen wrote:

> On Thu, Jul 19, 2018 at 07:57:37AM +0200, Duy Nguyen wrote:
> > I thought 2M was generous but I was obviously wrong. I'd like to see
> > the biggest delta size in this pack and whether it's still reasonable
> > to increase OE_DELTA_SIZE_BITS. But if it's very close to 4GB limit
> > then we could just store 64-bit delta size in a separate array.
> 
> I realize now that these two options don't have to be mutually
> exclusive and I should provide a good fallback in terms of performance
> anyway.

Yeah, this is what I had assumed was happening in the original code. :)

> +void oe_prepare_delta_size_array(struct packing_data *pack)
> +{
> +	int i;
> +
> +	/*
> +	 * nr_alloc, not nr_objects to align with realloc() strategy in
> +	 * packlist_alloc()
> +	 */
> +	ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
> +
> +	for (i = 0; i < pack->nr_objects; i++)
> +		pack->delta_size[i] = pack->objects[i].delta_size_;
> +}

This iterator should probably be a uint32_t, to match nr_objects.

The rest of the patch looks OK to me. From Elijah's failure report there
clearly is _some_ problem where we end up with a truncated write of a
delta. But I don't see it from code inspection, nor could I reproduce
it.

-Peff
