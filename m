Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA641F453
	for <e@80x24.org>; Mon, 29 Oct 2018 14:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJ2XUg (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:20:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:59014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725977AbeJ2XUg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:20:36 -0400
Received: (qmail 20715 invoked by uid 109); 29 Oct 2018 14:31:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 14:31:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18075 invoked by uid 111); 29 Oct 2018 14:30:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 10:30:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 10:31:41 -0400
Date:   Mon, 29 Oct 2018 10:31:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com
Subject: Re: [PATCH v2 10/10] read-cache.c: initialize copy_len to shut up
 gcc 8
Message-ID: <20181029143140.GG17668@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
 <20181027173008.18852-11-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027173008.18852-11-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 07:30:08PM +0200, Nguyễn Thái Ngọc Duy wrote:

> It was reported that when building with NO_PTHREADS=1,
> -Wmaybe-uninitialized is triggered. Just initialize the variable from
> the beginning to shut the compiler up (because this warning is enabled
> in config.dev)
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  read-cache.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index ba870bc3fd..4307b9a7bf 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1746,7 +1746,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>  	size_t len;
>  	const char *name;
>  	unsigned int flags;
> -	size_t copy_len;
> +	size_t copy_len = 0;
>  	/*
>  	 * Adjacent cache entries tend to share the leading paths, so it makes
>  	 * sense to only store the differences in later entries.  In the v4
> @@ -1786,8 +1786,6 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>  				die(_("malformed name field in the index, near path '%s'"),
>  					previous_ce->name);
>  			copy_len = previous_len - strip_len;
> -		} else {
> -			copy_len = 0;
>  		}
>  		name = (const char *)cp;
>  	}

Yes, this silences the compiler warning I saw (and is exactly the same
patch I wrote to get past it the other day ;) ).

-Peff
