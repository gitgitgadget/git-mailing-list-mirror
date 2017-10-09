Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F6A20373
	for <e@80x24.org>; Mon,  9 Oct 2017 13:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbdJINdT (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 09:33:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:46872 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751741AbdJINdR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 09:33:17 -0400
Received: (qmail 14411 invoked by uid 109); 9 Oct 2017 13:27:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 13:27:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16262 invoked by uid 111); 9 Oct 2017 13:33:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 09:33:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Oct 2017 09:33:10 -0400
Date:   Mon, 9 Oct 2017 09:33:10 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2] cleanup: fix possible overflow errors in binary search
Message-ID: <20171009133309.lslwg2uorbhnygqp@sigill.intra.peff.net>
References: <bd3c5fe2-ac6a-b978-163b-da07208b879c@gmail.com>
 <20171008182937.69205-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171008182937.69205-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2017 at 02:29:37PM -0400, Derrick Stolee wrote:

> A common mistake when writing binary search is to allow possible
> integer overflow by using the simple average:
> 
> 	mid = (min + max) / 2;
> 
> Instead, use the overflow-safe version:
> 
> 	mid = min + (max - min) / 2;
> 
> This translation is safe since the operation occurs inside a loop
> conditioned on "min < max". The included changes were found using
> the following git grep:
> 
> 	git grep '/ *2;' '*.c'
> 
> Making this cleanup will prevent future review friction when a new
> binary search is contructed based on existing code.

Thanks, this version looks good to me.

> diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
> index d4121f2f4..98342b831 100644
> --- a/compat/regex/regex_internal.c
> +++ b/compat/regex/regex_internal.c
> @@ -613,7 +613,7 @@ re_string_reconstruct (re_string_t *pstr, int idx, int eflags)
>  	      int low = 0, high = pstr->valid_len, mid;
>  	      do
>  		{
> -		  mid = (high + low) / 2;
> +		  mid = low + (high - low) / 2;
>  		  if (pstr->offsets[mid] > offset)
>  		    high = mid;
>  		  else if (pstr->offsets[mid] < offset)

This one is a do-while, so it's less obvious that "high" is always more
than "low" when entering the loop. But one assumes it is so, since the
binary search wouldn't work otherwise.

-Peff
