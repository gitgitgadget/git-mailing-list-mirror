Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8AA1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 06:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeFIGEk (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 02:04:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:39792 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753144AbeFIGEk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 02:04:40 -0400
Received: (qmail 18899 invoked by uid 109); 9 Jun 2018 06:04:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 06:04:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 857 invoked by uid 111); 9 Jun 2018 06:04:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 02:04:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 02:04:38 -0400
Date:   Sat, 9 Jun 2018 02:04:38 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 1/2] pack-bitmap: remove bitmap_git global variable
Message-ID: <20180609060437.GA30224@sigill.intra.peff.net>
References: <cover.1528397984.git.jonathantanmy@google.com>
 <d4d4fec265c1c53e14da465904d93e559ff2c17d.1528397984.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4d4fec265c1c53e14da465904d93e559ff2c17d.1528397984.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 12:04:13PM -0700, Jonathan Tan wrote:

> Remove the bitmap_git global variable. Instead, generate on demand an
> instance of struct bitmap_index for code that needs to access it.
> 
> This allows us significant control over the lifetime of instances of
> struct bitmap_index. In particular, packs can now be closed without
> worrying if an unnecessarily long-lived "pack" field in struct
> bitmap_index still points to it.
> 
> The bitmap API is also clearer in that we need to first obtain a struct
> bitmap_index, then we use it.

I think this is the right direction, and overall it looks pretty good.
There's one call that gave me pause:

> -int prepare_bitmap_git(void)
> +struct bitmap_index *prepare_bitmap_git(void)
>  {
> -	if (bitmap_git.loaded)
> -		return 0;
> +	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));

This function used to be idempotent, so any code which wanted to use the
global bitmap_git could call it "just in case". After your patch, it's
not. I think it's probably OK, since such functions would generally now
take a bitmap_git argument and use that (e.g., rebuild_existing_bitmaps
works that way after your patch).

> -	if (!open_pack_bitmap())
> -		return load_pack_bitmap();
> +	if (!open_pack_bitmap(bitmap_git) && !load_pack_bitmap(bitmap_git))
> +		return bitmap_git;
>  
> -	return -1;
> +	return NULL;
>  }

We probably need to free(bitmap_git) before returning NULL here (this is
still in prepare_bitmap_git()).

> @@ -662,12 +686,11 @@ int prepare_bitmap_walk(struct rev_info *revs)
>  	struct bitmap *wants_bitmap = NULL;
>  	struct bitmap *haves_bitmap = NULL;
>  
> -	if (!bitmap_git.loaded) {
> -		/* try to open a bitmapped pack, but don't parse it yet
> -		 * because we may not need to use it */
> -		if (open_pack_bitmap() < 0)
> -			return -1;
> -	}
> +	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
> +	/* try to open a bitmapped pack, but don't parse it yet
> +	 * because we may not need to use it */
> +	if (open_pack_bitmap(bitmap_git) < 0)
> +		return NULL;

Ditto here (and probably other error returns lower in the function, but
I didn't go through it carefully).

-Peff
