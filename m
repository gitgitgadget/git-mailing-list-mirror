Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0461C1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 20:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbeBZUl4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 15:41:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:37694 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753672AbeBZUly (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 15:41:54 -0500
Received: (qmail 29346 invoked by uid 109); 26 Feb 2018 20:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Feb 2018 20:41:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16204 invoked by uid 111); 26 Feb 2018 20:42:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Feb 2018 15:42:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Feb 2018 15:41:52 -0500
Date:   Mon, 26 Feb 2018 15:41:52 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, stolee@gmail.com
Subject: Re: [PATCH] sha1_name: fix uninitialized memory errors
Message-ID: <20180226204151.GA12598@sigill.intra.peff.net>
References: <CAP8UFD0CesVk8FjX-=unwSO6u0pi1-Usm1yVW5hs5FHi=8Timg@mail.gmail.com>
 <1519657007-215623-1-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519657007-215623-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 09:56:47AM -0500, Derrick Stolee wrote:

> diff --git a/sha1_name.c b/sha1_name.c
> index 611c7d2..44dd595 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -546,17 +546,12 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
>  	 * nearby for the abbreviation length.
>  	 */
>  	mad->init_len = 0;
> -	if (!match) {
> -		nth_packed_object_oid(&oid, p, first);
> +	if (!match && nth_packed_object_oid(&oid, p, first))
>  		extend_abbrev_len(&oid, mad);
> -	} else if (first < num - 1) {
> -		nth_packed_object_oid(&oid, p, first + 1);
> +	else if (first < num - 1 && nth_packed_object_oid(&oid, p, first + 1))
>  		extend_abbrev_len(&oid, mad);
> -	}

I think including the nth_packed_object_oid() in the main if-else chain
works out, but it's kind of tricky.

In the code before, we'd hit the "first < num - 1" conditional only when
we didn't match something. But now we also hit it if we _did_ match
something, but nth_packed_object_oid() didn't work.

But this works out the same if we assume any match must also succeed at
nth_packed_object_oid(). Which in turn implies that checking the result
of nth_packed_object_oid() in the "else if" is redundant (though we
already clamp it to "num - 1", so we'd expect it to always succeed
anyway).

So I think this behaves well, but I wonder if the two-level conditionals
like:

  if (!match) {
	if (nth_packed_object_oid(&oid, p, first))
		extend_abbrev_len(&oid, mad);
  } else if ...

are easier to reason about.

-Peff
