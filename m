Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF01B202AC
	for <e@80x24.org>; Mon, 10 Jul 2017 07:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbdGJH1J (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 03:27:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:35204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752427AbdGJH1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 03:27:08 -0400
Received: (qmail 4118 invoked by uid 109); 10 Jul 2017 07:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 07:27:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3668 invoked by uid 111); 10 Jul 2017 07:27:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 03:27:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 03:27:01 -0400
Date:   Mon, 10 Jul 2017 03:27:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use DIV_ROUND_UP
Message-ID: <20170710072701.cqzztww6mrqr7sli@sigill.intra.peff.net>
References: <4d2c274a-f6cb-6ea5-304f-51a3152cc436@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d2c274a-f6cb-6ea5-304f-51a3152cc436@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 08, 2017 at 12:35:35PM +0200, René Scharfe wrote:

> Convert code that divides and rounds up to use DIV_ROUND_UP to make the
> intent clearer and reduce the number of magic constants.

Sounds like a good idea.

> -	auto_threshold = (gc_auto_threshold + 255) / 256;
> +	auto_threshold = DIV_ROUND_UP(gc_auto_threshold, 256);

DIV_ROUND_UP(n,d) is defined as (n+d-1)/d. So this is clearly a
mechanical conversion and thus correct. And most cases are like this,
but...

> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index 2dc9c82ecf..06c479f70a 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -210,8 +210,8 @@ size_t ewah_add(struct ewah_bitmap *self, eword_t word)
>  void ewah_set(struct ewah_bitmap *self, size_t i)
>  {
>  	const size_t dist =
> -		(i + BITS_IN_EWORD) / BITS_IN_EWORD -
> -		(self->bit_size + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
> +		DIV_ROUND_UP(i + 1, BITS_IN_EWORD) -
> +		DIV_ROUND_UP(self->bit_size, BITS_IN_EWORD);

...this first one is a bit trickier. Our "n" in the first one is now
"i+1".  But that's because the original was implicitly canceling the
"-1" and "+1" terms.

So I think it's a true mechanical conversion, but I have to admit the
original is confusing. Without digging I suspect it's correct, though,
just because a simple bug here would mean that our ewah bitmaps totally
don't work. So it's probably not worth spending time on.

> [...]

And all the others are straight-forward and obviously correct. So this
patch looks good to me.

-Peff
