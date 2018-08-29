Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C8A1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeH3BTL (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:19:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:32872 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727363AbeH3BTL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:19:11 -0400
Received: (qmail 20726 invoked by uid 109); 29 Aug 2018 21:20:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 21:20:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18895 invoked by uid 111); 29 Aug 2018 21:20:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 17:20:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 17:20:25 -0400
Date:   Wed, 29 Aug 2018 17:20:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] patch-delta: fix oob read
Message-ID: <20180829212025.GB29880@sigill.intra.peff.net>
References: <20180829205857.77340-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829205857.77340-1-jannh@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 10:58:55PM +0200, Jann Horn wrote:

> If `cmd` is in the range [0x01,0x7f] and `cmd > top-data`, the
> `memcpy(out, data, cmd)` can copy out-of-bounds data from after `delta_buf`
> into `dst_buf`.
> 
> This is not an exploitable bug because triggering the bug increments the
> `data` pointer beyond `top`, causing the `data != top` sanity check after
> the loop to trigger and discard the destination buffer - which means that
> the result of the out-of-bounds read is never used for anything.
> 
> Also, directly jump into the error handler instead of just breaking out of
> the loop - otherwise, data corruption would be silently ignored if the
> delta buffer ends with a command and the destination buffer is already
> full.

Nice catch. The patch looks good to me, but just to lay out my thought
process looking for other related problems:

We have two types of instructions:

  1. Take N bytes from position P within the source.

  2. Take the next N bytes from the delta stream.

In both cases we need to check that:

  a. We have enough space in the destination buffer.

  b. We have enough source bytes.

So this:

> diff --git a/patch-delta.c b/patch-delta.c
> index 56e0a5ede..283fb4b75 100644
> --- a/patch-delta.c
> +++ b/patch-delta.c
> @@ -51,13 +51,13 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
>  			if (unsigned_add_overflows(cp_off, cp_size) ||
>  			    cp_off + cp_size > src_size ||
>  			    cp_size > size)
> -				break;
> +				goto bad_length;
>  			memcpy(out, (char *) src_buf + cp_off, cp_size);

Covers 1a (cp_size > size) and 1b (cp_off + cp_size > src_size), plus
the obvious overflow possibility.

And then here:

>  		} else if (cmd) {
> -			if (cmd > size)
> -				break;
> +			if (cmd > size || cmd > top - data)
> +				goto bad_length;
>  			memcpy(out, data, cmd);

We had previously dealt with 2a (cmd > size), but failed to handle 2b,
which you've added. We don't need to deal with over/underflow here,
because our subtraction is on pointers to the same buffer.

> @@ -75,6 +75,7 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
>  
>  	/* sanity check */
>  	if (data != top || size != 0) {
> +		bad_length:
>  		error("delta replay has gone wild");
>  		bad:
>  		free(dst_buf);

And I agree that jumping straight here is a good idea.

Overall, very nicely done.

-Peff
