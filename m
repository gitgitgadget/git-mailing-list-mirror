Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E7C07E9C
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8D6610CC
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhGDJIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 05:08:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:41126 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhGDJIS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 05:08:18 -0400
Received: (qmail 8050 invoked by uid 109); 4 Jul 2021 09:05:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 04 Jul 2021 09:05:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5967 invoked by uid 111); 4 Jul 2021 09:05:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Jul 2021 05:05:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 4 Jul 2021 05:05:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] khash: clarify that allocations never fail
Message-ID: <YOF55hIKhRrwrZah@coredump.intra.peff.net>
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
 <3778fb28-ed19-e90e-216a-d29d72305155@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3778fb28-ed19-e90e-216a-d29d72305155@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 03, 2021 at 02:57:30PM +0200, René Scharfe wrote:

> We use our standard allocation functions and macros (xcalloc,
> ALLOC_ARRAY, REALLOC_ARRAY) in our version of khash.h.  They terminate
> the program on error instead, so code that's using them doesn't have to
> handle allocation failures.  Make this behavior explicit by turning
> kh_resize_ into a void function and removing the related unreachable
> error handling code.

Thanks, this looks good to me.

>  	SCOPE khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret) \
>  	{																	\
>  		khint_t x;														\
>  		if (h->n_occupied >= h->upper_bound) { /* update the hash table */ \
>  			if (h->n_buckets > (h->size<<1)) {							\
> -				if (kh_resize_##name(h, h->n_buckets - 1) < 0) { /* clear "deleted" elements */ \
> -					*ret = -1; return h->n_buckets;						\
> -				}														\
> -			} else if (kh_resize_##name(h, h->n_buckets + 1) < 0) { /* expand the hash table */ \
> -				*ret = -1; return h->n_buckets;							\
> +				kh_resize_##name(h, h->n_buckets - 1); /* clear "deleted" elements */ \
> +			} else { \
> +				kh_resize_##name(h, h->n_buckets + 1); /* expand the hash table */ \
>  			}															\

I had to read this over again carefully, because the second "else-if"
makes the conversion less obvious. I think the original would have been
easier to read as:

  if (something) {
    if (do_option_one())
        ...error...
  } else {
    if (do_option_two())
        ...error...
  }

instead of:

  if (something) {
    if (do_option_one())
        ...error...
  } else if (do_option_two())
        ...error...
  }

All of which is to say the conversion here is correct, and I think as a
bonus the resulting code is easier to follow. ;)

-Peff
