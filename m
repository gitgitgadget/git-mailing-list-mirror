Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02EEE201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754484AbdEQMz2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:55:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:53578 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754061AbdEQMzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 08:55:15 -0400
Received: (qmail 3493 invoked by uid 109); 17 May 2017 12:55:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 12:55:12 +0000
Received: (qmail 9179 invoked by uid 111); 17 May 2017 12:55:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 08:55:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 08:55:10 -0400
Date:   Wed, 17 May 2017 08:55:10 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 04/23] prefix_ref_iterator: don't trim too much
Message-ID: <20170517125510.qmy2qvyxuup25zw6@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <eecc015af8d7ed71223b591b13847fdb56ee69f0.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eecc015af8d7ed71223b591b13847fdb56ee69f0.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:27PM +0200, Michael Haggerty wrote:

> diff --git a/refs/iterator.c b/refs/iterator.c
> index bce1f192f7..f33d1b3a39 100644
> --- a/refs/iterator.c
> +++ b/refs/iterator.c
> @@ -292,7 +292,19 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		if (!starts_with(iter->iter0->refname, iter->prefix))
>  			continue;
>  
> -		iter->base.refname = iter->iter0->refname + iter->trim;
> +		if (iter->trim) {
> +			/*
> +			 * If there wouldn't be at least one character
> +			 * left in the refname after trimming, skip
> +			 * over it:
> +			 */
> +			if (memchr(iter->iter0->refname, '\0', iter->trim + 1))
> +				continue;

It took me a minute to figure out the logic here. You're looking for the
end-of-string within the trim boundary, which would be an indication
that the string itself is smaller than the boundary.

But what if it returns true, and the string really is shorter than the
trim size? That would mean we pass a size to memchr that is longer than
the buffer we pass. Is that legal?

I suspect it's undefined behavior according to the standard, though I'd
guess in practice it would be fine. But if I'm understanding it
correctly, this is the same check as:

  if (strlen(iter->iter0->refname) <= iter->trim)

which seems a lot more obvious to me and doesn't fall afoul of weird
standard issues. The only downside I see is that it would read to the
end of string when yours could stop at iter->trim bytes. I have no idea
if that would be measurable (it might even be faster because strlen()
only has one condition to loop on).

-Peff
