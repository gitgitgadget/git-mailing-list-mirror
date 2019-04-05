Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BEF20248
	for <e@80x24.org>; Fri,  5 Apr 2019 22:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDEWAI (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 18:00:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:49208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726124AbfDEWAI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 18:00:08 -0400
Received: (qmail 18988 invoked by uid 109); 5 Apr 2019 22:00:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 22:00:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30470 invoked by uid 111); 5 Apr 2019 22:00:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 18:00:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 18:00:06 -0400
Date:   Fri, 5 Apr 2019 18:00:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 1/2] sha1-file: support OBJECT_INFO_FOR_PREFETCH
Message-ID: <20190405220005.GA10312@sigill.intra.peff.net>
References: <20190326220906.111879-1-jonathantanmy@google.com>
 <cover.1553895166.git.jonathantanmy@google.com>
 <068861632b85179d2a5a5ceb966e951a78b27141.1553895166.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <068861632b85179d2a5a5ceb966e951a78b27141.1553895166.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 02:39:27PM -0700, Jonathan Tan wrote:

> Teach oid_object_info_extended() to support a new flag that inhibits
> fetching of missing objects. This is equivalent to setting
> fetch_is_missing to 0, calling oid_object_info_extended(), then setting
> fetch_if_missing to whatever it was before. Update unpack-trees.c to use
> this new flag instead of repeatedly setting fetch_if_missing.
> 
> This new flag complicates things slightly in that there are now 2 ways
> to do the same thing. But this eliminates the need to repeatedly set a
> global variable, and more importantly, allows prefetching to be done in
> parallel (in the future); hence, this patch.

Sorry I'm a little late to review this. I don't have any critical
comments, so if this gets ignored, I'll live with it.

> +/*
> + * Do not attempt to fetch the object if missing (even if fetch_is_missing is
> + * nonzero). This is meant for bulk prefetching of missing blobs in a partial
> + * clone. Implies OBJECT_INFO_QUICK.
> + */
> +#define OBJECT_INFO_FOR_PREFETCH (32 + OBJECT_INFO_QUICK)

Mostly I found the name and semantics of this flag to be a little
confusing. Really what we want is to tell oid_object_info() not do any
on-demand fetching for us. That seems like a thing that we might
eventually want for other purposes (e.g., a diff operation that could
produce a real blob diff but would be happy outputting a less-detailed
tree diff).

If it were just OBJECT_INFO_NO_FETCH or similar, that tells more clearly
what it does, and would make sense in more contexts.

I suspect that QUICK would be the norm when used with it, though I
probably would have kept the two orthogonal for the sake of simplicity
and clarity.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 22c41a3ba8..381b0cd65e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -404,20 +404,21 @@ static int check_updates(struct unpack_trees_options *o)
>  		 * below.
>  		 */
>  		struct oid_array to_fetch = OID_ARRAY_INIT;
> -		int fetch_if_missing_store = fetch_if_missing;
> -		fetch_if_missing = 0;
>  		for (i = 0; i < index->cache_nr; i++) {
>  			struct cache_entry *ce = index->cache[i];
> -			if ((ce->ce_flags & CE_UPDATE) &&
> -			    !S_ISGITLINK(ce->ce_mode)) {
> -				if (!has_object_file(&ce->oid))
> -					oid_array_append(&to_fetch, &ce->oid);
> -			}
> +
> +			if (!(ce->ce_flags & CE_UPDATE) ||
> +			    S_ISGITLINK(ce->ce_mode))
> +				continue;
> +			if (!oid_object_info_extended(the_repository, &ce->oid,
> +						      NULL,
> +						      OBJECT_INFO_FOR_PREFETCH))
> +				continue;
> +			oid_array_append(&to_fetch, &ce->oid);

Here we get rid of the global set/restore dance, which is nice. But
there's also a behavior change, as we've picked up QUICK. I think that's
probably the right thing to do, but I was a bit surprised not to see any
discussion in the commit message.

-Peff
