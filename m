Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF221FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 11:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168447AbdDXL3g (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 07:29:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:38985 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166361AbdDXL3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 07:29:34 -0400
Received: (qmail 24413 invoked by uid 109); 24 Apr 2017 11:29:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 11:29:30 +0000
Received: (qmail 5718 invoked by uid 111); 24 Apr 2017 11:29:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 07:29:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 07:29:28 -0400
Date:   Mon, 24 Apr 2017 07:29:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] add SWAP macro
Message-ID: <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 28, 2017 at 10:38:21PM +0100, René Scharfe wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 87237b092b..66cd466eea 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -527,6 +527,16 @@ static inline int ends_with(const char *str, const char *suffix)
>  	return strip_suffix(str, suffix, &len);
>  }
>  
> +#define SWAP(a, b) do {						\
> +	void *_swap_a_ptr = &(a);				\
> +	void *_swap_b_ptr = &(b);				\
> +	unsigned char _swap_buffer[sizeof(a)];			\
> +	memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));		\
> +	memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a) +		\
> +	       BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)));	\
> +	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));		\
> +} while (0)

What should:

  SWAP(foo[i], foo[j]);

do when i == j? With this code, it ends up calling

  memcpy(&foo[i], &foo[j], ...);

which can cause valgrind to complain about overlapping memory. I suspect
in practice that noop copies are better off than partial overlaps, but I
think it does still violate the standard.

Is it worth comparing the pointers and bailing early?

A related question is whether the caller should ever be asking to swap
something with itself. This particular case[1] comes from
prio_queue_reverse(). I suspect its "<=" could become a "<", but I
haven't thought it through carefully.

-Peff

[1] http://public-inbox.org/git/CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com/
