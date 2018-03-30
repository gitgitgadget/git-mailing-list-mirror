Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF151F404
	for <e@80x24.org>; Fri, 30 Mar 2018 21:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeC3VYX (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 17:24:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:49486 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752571AbeC3VYW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 17:24:22 -0400
Received: (qmail 750 invoked by uid 109); 30 Mar 2018 21:24:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 21:24:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 613 invoked by uid 111); 30 Mar 2018 21:25:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 17:25:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 17:24:20 -0400
Date:   Fri, 30 Mar 2018 17:24:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 12/13] pack-objects: shrink delta_size field in struct
 object_entry
Message-ID: <20180330212419.GJ14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-13-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-13-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:52AM +0100, Nguyễn Thái Ngọc Duy wrote:

> Allowing a delta size of 64 bits is crazy. Shrink this field down to
> 31 bits with one overflow bit.
> 
> If we find an existing delta larger than 2GB, we do not cache
> delta_size at all and will get the value from oe_size(), potentially
> from disk if it's larger than 4GB.

Since we have a fallback, we can put this slider wherever we want.
Probably something like 20 bits would be plenty, if we ever needed to
squeeze in a few more small-bit items.

> @@ -2004,10 +2006,12 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>  	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
>  	if (!delta_buf)
>  		return 0;
> +	if (delta_size >= (1 << OE_DELTA_SIZE_BITS))
> +		return 0;

This is the other spot that needs to be "1U".

How come this doesn't get a pdata->oe_delta_size_limit like we have
pdata->oe_size_limit? Would we want a matching
$GIT_TEST_OE_DELTA_SIZE_BITS to test it, too?

-Peff
