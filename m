Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451B31F597
	for <e@80x24.org>; Fri, 20 Jul 2018 05:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeGTGRC (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 02:17:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:53634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727041AbeGTGRC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 02:17:02 -0400
Received: (qmail 28103 invoked by uid 109); 20 Jul 2018 05:30:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 05:30:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19940 invoked by uid 111); 20 Jul 2018 05:30:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 01:30:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 01:30:32 -0400
Date:   Fri, 20 Jul 2018 01:30:32 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180720053031.GA16126@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home>
 <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
 <20180719172358.GD4868@sigill.intra.peff.net>
 <20180719173135.GA24563@duynguyen.home>
 <20180719182442.GA5796@duynguyen.home>
 <CABPp-BEo1Ar17uwX=ib8iVYosdwhTXhdMWvi7kgqDb3iPQoj5Q@mail.gmail.com>
 <20180720052829.GA3852@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720052829.GA3852@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 01:28:29AM -0400, Jeff King wrote:

> @@ -162,8 +166,10 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
>  
>  		if (!pdata->in_pack_by_idx)
>  			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
> +		pack_delta_lock(pdata);
>  		if (pdata->delta_size)
>  			REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc);
> +		pack_delta_unlock(pdata);
>  	}

This made me wonder if in_pack_by_idx needs a similar lock. But
actually, I don't think either is necessary. We only allocate new
entries during the counting phase, not during the threaded delta search.

So this hunk could be dropped (and the system CPU benefit I saw is just
from reduced lock contention).

-Peff
