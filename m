Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBDA1F404
	for <e@80x24.org>; Sat, 25 Aug 2018 08:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeHYMOT (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 08:14:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:55842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726027AbeHYMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 08:14:18 -0400
Received: (qmail 6369 invoked by uid 109); 25 Aug 2018 08:36:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Aug 2018 08:36:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2677 invoked by uid 111); 25 Aug 2018 08:36:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 04:36:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 04:36:03 -0400
Date:   Sat, 25 Aug 2018 04:36:03 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/9] convert "oidcmp() == 0" to oideq()
Message-ID: <20180825083602.GA2251@sigill.intra.peff.net>
References: <20180825080031.GA32139@sigill.intra.peff.net>
 <20180825080715.GC737@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180825080715.GC737@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 25, 2018 at 04:07:15AM -0400, Jeff King wrote:

> diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
> index 5869979be7..548c02336d 100644
> --- a/contrib/coccinelle/object_id.cocci
> +++ b/contrib/coccinelle/object_id.cocci
> @@ -108,3 +108,9 @@ expression E1, E2;
>  @@
>  - hashcpy(E1.hash, E2->hash)
>  + oidcpy(&E1, E2)
> +
> +@@
> +expression E1, E2;
> +@@
> +- oidcmp(E1, E2) == 0
> ++ oideq(E1, E2)
>
> [...]
>
> diff --git a/cache.h b/cache.h
> index f6d227fac7..d090f71706 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1100,7 +1100,7 @@ static inline int is_empty_blob_sha1(const unsigned char *sha1)
>  
>  static inline int is_empty_blob_oid(const struct object_id *oid)
>  {
> -	return !oidcmp(oid, the_hash_algo->empty_blob);
> +	return oideq(oid, the_hash_algo->empty_blob);
>  }

By the way, one interesting thing I noticed is that coccinelle generates
the hunk for cache.h for _every_ file that includes it, and the
resulting patch is annoying to apply. I think this is related to the
discussion we were having in:

  https://public-inbox.org/git/20180802115522.16107-1-szeder.dev@gmail.com/

Namely that we might do better to invoke one big spatch (and let it
parallelize internally) instead of one perfile. Presumably that would
also avoid looking at the headers repeatedly (which would be both faster
and produce better output).

I'm not planning to pursue that immediately, so just food for thought at
this point.

-Peff
