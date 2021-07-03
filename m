Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E38BC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20043615FF
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhGCKlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 06:41:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:40650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhGCKlC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 06:41:02 -0400
Received: (qmail 2398 invoked by uid 109); 3 Jul 2021 10:38:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 Jul 2021 10:38:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32732 invoked by uid 111); 3 Jul 2021 10:38:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 Jul 2021 06:38:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 3 Jul 2021 06:38:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] khash: clarify that allocations never fail
Message-ID: <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 03, 2021 at 12:05:46PM +0200, René Scharfe wrote:

> We use our standard allocation functions and macros (xcalloc,
> ALLOC_ARRAY, REALLOC_ARRAY) in our version of khash.h.  They terminate
> the program on error, so code that's using them doesn't have to handle
> allocation failures.  Make this behavior explicit by replacing the code
> that handles allocation errors in kh_resize_ and kh_put_ with BUG calls.

Seems like a good idea.

We're very sloppy about checking the "ret" field from kh_put_* for
errors (it's a tri-state for "already existed", "newly added", or
"error"). I think that's not a problem because as you show here, we
can't actually hit the error case. This makes that much more obvious.

Two nits if we wanted to go further:

> diff --git a/khash.h b/khash.h
> index 21c2095216..84ff7230b6 100644
> --- a/khash.h
> +++ b/khash.h
> @@ -126,7 +126,7 @@ static const double __ac_HASH_UPPER = 0.77;
>  			if (h->size >= (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5)) j = 0;	/* requested size is too small */ \
>  			else { /* hash table size to be changed (shrink or expand); rehash */ \
>  				ALLOC_ARRAY(new_flags, __ac_fsize(new_n_buckets)); \
> -				if (!new_flags) return -1;								\
> +				if (!new_flags) BUG("ALLOC_ARRAY failed");				\

I converted this in b32fa95fd8 (convert trivial cases to ALLOC_ARRAY,
2016-02-22), but left the now-obsolete error-check.

But a few lines below...

>  				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32_t)); \
>  				if (h->n_buckets < new_n_buckets) {	/* expand */		\
>  					REALLOC_ARRAY(h->keys, new_n_buckets); \

These REALLOC_ARRAY() calls are in the same boat. You dropped the error
check in 2756ca4347 (use REALLOC_ARRAY for changing the allocation size
of arrays, 2014-09-16).

Should we make the two match? I'd probably do so by making the former
match the latter, and just drop the conditional and BUG entirely.

> @@ -181,10 +181,10 @@ static const double __ac_HASH_UPPER = 0.77;
>  		if (h->n_occupied >= h->upper_bound) { /* update the hash table */ \
>  			if (h->n_buckets > (h->size<<1)) {							\
>  				if (kh_resize_##name(h, h->n_buckets - 1) < 0) { /* clear "deleted" elements */ \
> -					*ret = -1; return h->n_buckets;						\
> +					BUG("kh_resize_" #name " failed");					\
>  				}														\
>  			} else if (kh_resize_##name(h, h->n_buckets + 1) < 0) { /* expand the hash table */ \
> -				*ret = -1; return h->n_buckets;							\
> +				BUG("kh_resize_" #name " failed");						\

After the first hunk, does kh_resize_*() ever return anything but 0? If
not, can we drop its return entirely, making it more clear that it's not
expected to fail? Both for human readers, but also for the compiler
(which could then alert us at compile-time if we missed any error
cases).

-Peff
