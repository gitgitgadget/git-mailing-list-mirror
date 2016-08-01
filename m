Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A811F855
	for <e@80x24.org>; Mon,  1 Aug 2016 16:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbcHAQsM (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 12:48:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:52538 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754115AbcHAQrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 12:47:53 -0400
Received: (qmail 5778 invoked by uid 102); 1 Aug 2016 16:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 12:47:27 -0400
Received: (qmail 14588 invoked by uid 107); 1 Aug 2016 16:47:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 12:47:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 12:47:24 -0400
Date:	Mon, 1 Aug 2016 12:47:24 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
Message-ID: <20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
References: <579CEF77.9070202@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <579CEF77.9070202@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 08:18:31PM +0200, René Scharfe wrote:

> The result of st_mult() is the same no matter the order of its
> arguments.  It invokes the macro unsigned_mult_overflows(), which
> divides the second parameter by the first one.  Pass constants
> first to allow that division to be done already at compile time.

I'm not opposed to this, as it's easy to do (though I suspect new calls
may be introduced that violate it).

But if we really are worried about the performance of st_mult(), I
think:

  static inline size_t st_mult(size_t a, size_t b)
  {
	size_t result;
	if (!__builtin_mul_overflow(a, b, &result))
		die("whoops!");
	return result;
  }

is the right direction. I just haven't gotten around to producing a
polished patch.

> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 58ac0a5..73d003a 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -541,7 +541,7 @@ void diffcore_rename(struct diff_options *options)
>  				rename_dst_nr * rename_src_nr, 50, 1);
>  	}
>  
> -	mx = xcalloc(st_mult(num_create, NUM_CANDIDATE_PER_DST), sizeof(*mx));
> +	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));

I didn't look at all of the calls, but I wonder if it is a natural
pattern to put the constant second.  Since multiplication is
commutative, it would be correct for st_mult() to just flip the order of
arguments it feeds to unsigned_mult_overflows().

That may introduce the same inefficiency in other callsites, but I
wonder if it would be fewer.

-Peff
