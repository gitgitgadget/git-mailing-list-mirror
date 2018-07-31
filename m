Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9ABB1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeGaVGC (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:06:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:37674 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728800AbeGaVGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:06:02 -0400
Received: (qmail 2281 invoked by uid 109); 31 Jul 2018 19:24:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 19:24:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4838 invoked by uid 111); 31 Jul 2018 19:24:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 15:24:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 15:24:15 -0400
Date:   Tue, 31 Jul 2018 15:24:15 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport: report refs only if transport does
Message-ID: <20180731192415.GC3372@sigill.intra.peff.net>
References: <20180729121900.GA16770@sigill.intra.peff.net>
 <20180730225601.107502-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180730225601.107502-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 03:56:01PM -0700, Jonathan Tan wrote:

> Commit 989b8c4452 ("fetch-pack: put shallow info in output parameter",
> 2018-06-28) allows transports to report the refs that they have fetched
> in a new out-parameter "fetched_refs". If they do so,
> transport_fetch_refs() makes this information available to its caller.
> 
> Because transport_fetch_refs() filters the refs sent to the transport,
> it cannot just report the transport's result directly, but first needs
> to readd the excluded refs, pretending that they are fetched. However,
> this results in a wrong result if the transport did not report the refs
> that they have fetched in "fetched_refs" - the excluded refs would be
> added and reported, presenting an incomplete picture to the caller.

This part leaves me confused. If we are not fetching them, then why do
we need to pretend that they are fetched?

I think I am showing my lack of understanding about the reason for this
whole "return the fetched refs" scheme from 989b8c4452, and probably
reading the rest of that series would make it more clear. But from the
perspective of somebody digging into history and finding just this
commit, it probably needs to lay out a little more of the reasoning.

> Thanks for the reproduction recipe, Peff. Here's a fix. It can be
> reproduced with something using a remote helper's fetch command (and not
> using "connect" or "stateless-connect"), fetching at least one ref that
> requires a ref update and at least one that does not (as you can see
> from the included test).

Ah, that explains why I couldn't reproduce it with another repository; I
was using a direct git-upload-pack fetch, which wouldn't trigger the
remote helper code.

> diff --git a/transport.c b/transport.c
> index fdd813f684..2a2415d79c 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1230,17 +1230,18 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs,
>  	struct ref **heads = NULL;
>  	struct ref *nop_head = NULL, **nop_tail = &nop_head;
>  	struct ref *rm;
> +	struct ref *fetched_by_transport = NULL;
>  
>  	for (rm = refs; rm; rm = rm->next) {
>  		nr_refs++;
>  		if (rm->peer_ref &&
>  		    !is_null_oid(&rm->old_oid) &&
>  		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid)) {
> -			/*
> -			 * These need to be reported as fetched, but we don't
> -			 * actually need to fetch them.
> -			 */
>  			if (fetched_refs) {
> +				/*
> +				 * These may need to be reported as fetched,
> +				 * but we don't actually need to fetch them.
> +				 */

So it's really this comment that leaves me the most puzzled.

> @@ -1264,10 +1265,25 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs,
>  			heads[nr_heads++] = rm;
>  	}
>  
> -	rc = transport->vtable->fetch(transport, nr_heads, heads, fetched_refs);
> -	if (fetched_refs && nop_head) {
> -		*nop_tail = *fetched_refs;
> -		*fetched_refs = nop_head;
> +	rc = transport->vtable->fetch(transport, nr_heads, heads,
> +				      fetched_refs ? &fetched_by_transport : NULL);
> +	if (fetched_refs) {
> +		if (fetched_by_transport) {
> +			/*
> +			 * The transport reported its fetched refs. Pretend
> +			 * that we also fetched the ones that we didn't need to
> +			 * fetch.
> +			 */
> +			*nop_tail = fetched_by_transport;
> +			*fetched_refs = nop_head;
> +		} else if (!fetched_by_transport) {
> +			/*
> +			 * The transport didn't report its fetched refs, so
> +			 * this function will not report them either. We have
> +			 * no use for nop_head.
> +			 */
> +			free_refs(nop_head);
> +		}

This part makes sense to me based on the description (and on the
assumption that reporting those nop refs is useful in the first place ;)
).

So I think your fix here is probably the right thing, but I'm just left
confused by the background a bit.

-Peff
