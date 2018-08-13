Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB72A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeHMUzJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:55:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:53188 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728547AbeHMUzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:55:09 -0400
Received: (qmail 9788 invoked by uid 109); 13 Aug 2018 18:11:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 18:11:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10831 invoked by uid 111); 13 Aug 2018 18:11:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 14:11:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 14:11:49 -0400
Date:   Mon, 13 Aug 2018 14:11:49 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        SZEDER Gabor <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 1/7] Add delta-islands.{c,h}
Message-ID: <20180813181149.GA10013@sigill.intra.peff.net>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
 <20180812051151.6425-2-chriscool@tuxfamily.org>
 <2113c74c-b230-6ea1-a980-d6d008bac759@ramsayjones.plus.com>
 <CAP8UFD1tX+rAxQc47o-50Kzo6hnX9mTWH2BPSq9HiO_OgBzYTw@mail.gmail.com>
 <7a780fe9-e8bf-804a-82e6-8df81cd5c41c@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a780fe9-e8bf-804a-82e6-8df81cd5c41c@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 01:17:18PM +0100, Ramsay Jones wrote:

> >>> +struct island_bitmap {
> >>> +     uint32_t refcount;
> >>> +     uint32_t bits[];
> >>
> >> Use FLEX_ARRAY here? We are slowly moving toward requiring
> >> certain C99 features, but I can't remember a flex array
> >> weather-balloon patch.
> > 
> > This was already discussed by Junio and Peff there:
> > 
> > https://public-inbox.org/git/20180727130229.GB18599@sigill.intra.peff.net/
> > 
> 
> That is a fine discussion, without a firm conclusion, but I don't
> think you can simply do nothing here:
> 
>   $ cat -n junk.c
>        1	#include <stdint.h>
>        2	
>        3	struct island_bitmap {
>        4		uint32_t refcount;
>        5		uint32_t bits[];
>        6	};
>        7	
>   $ gcc --std=c89 --pedantic -c junk.c
>   junk.c:5:11: warning: ISO C90 does not support flexible array members [-Wpedantic]
>     uint32_t bits[];
>              ^~~~
>   $ gcc --std=c99 --pedantic -c junk.c

Right, whether we use the FLEX_ALLOC macros or not, this needs to be
declared with FLEX_ARRAY, not an empty "[]".

I'm fine either way on using the FLEX_ALLOC macros.

> >> ... Ah, OK, trg_ => target.
> > 
> > I am ok to replace "trg" with "target" (or maybe "dst"? or something
> > else) and "src" with "source" if you think it would make things
> > clearer.
> 
> If it had been dst_ (or target), I would not have had a 'huh?'
> moment, but it is not all that important.

FWIW, these are all inherited from try_delta(), etc, in the existing
code. I'm fine with using another term, but we should probably do it
universally. And if we do, probably "base" is a better name than "src",
since the direction depends on which part of the relationship you are
considering. I'm not sure what that makes "dst".

-Peff
