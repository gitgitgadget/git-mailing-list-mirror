Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279A7C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080B961554
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhGCKrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 06:47:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:40668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhGCKrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 06:47:00 -0400
Received: (qmail 2447 invoked by uid 109); 3 Jul 2021 10:44:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 Jul 2021 10:44:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 474 invoked by uid 111); 3 Jul 2021 10:44:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 Jul 2021 06:44:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 3 Jul 2021 06:44:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] khash: clarify that allocations never fail
Message-ID: <YOA/iSCcnzB9f3ax@coredump.intra.peff.net>
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
 <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 03, 2021 at 06:38:27AM -0400, Jeff King wrote:

> On Sat, Jul 03, 2021 at 12:05:46PM +0200, René Scharfe wrote:
> 
> > We use our standard allocation functions and macros (xcalloc,
> > ALLOC_ARRAY, REALLOC_ARRAY) in our version of khash.h.  They terminate
> > the program on error, so code that's using them doesn't have to handle
> > allocation failures.  Make this behavior explicit by replacing the code
> > that handles allocation errors in kh_resize_ and kh_put_ with BUG calls.
> 
> Seems like a good idea.
> 
> We're very sloppy about checking the "ret" field from kh_put_* for
> errors (it's a tri-state for "already existed", "newly added", or
> "error"). I think that's not a problem because as you show here, we
> can't actually hit the error case. This makes that much more obvious.

Actually a quad-state, looking at the code (it distinguishes "in table
but deleted", though I don't think I've ever seen a case where that is
useful).

> Two nits if we wanted to go further:

In patch form (mostly because I was curious if I was missing any cases;
I'd probably squash it in with yours):

diff --git a/khash.h b/khash.h
index 84ff7230b6..fad486c966 100644
--- a/khash.h
+++ b/khash.h
@@ -74,7 +74,7 @@ static const double __ac_HASH_UPPER = 0.77;
 	void kh_destroy_##name(kh_##name##_t *h);					\
 	void kh_clear_##name(kh_##name##_t *h);						\
 	khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); \
-	int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
+	void kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
 	khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
 	void kh_del_##name(kh_##name##_t *h, khint_t x);
 
@@ -116,7 +116,7 @@ static const double __ac_HASH_UPPER = 0.77;
 			return __ac_iseither(h->flags, i)? h->n_buckets : i;		\
 		} else return 0;												\
 	}																	\
-	SCOPE int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets) \
+	SCOPE void kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets) \
 	{ /* This function uses 0.25*n_buckets bytes of working space instead of [sizeof(key_t+val_t)+.25]*n_buckets. */ \
 		khint32_t *new_flags = NULL;										\
 		khint_t j = 1;													\
@@ -173,18 +173,15 @@ static const double __ac_HASH_UPPER = 0.77;
 			h->n_occupied = h->size;									\
 			h->upper_bound = (khint_t)(h->n_buckets * __ac_HASH_UPPER + 0.5); \
 		}																\
-		return 0;														\
 	}																	\
 	SCOPE khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret) \
 	{																	\
 		khint_t x;														\
 		if (h->n_occupied >= h->upper_bound) { /* update the hash table */ \
 			if (h->n_buckets > (h->size<<1)) {							\
-				if (kh_resize_##name(h, h->n_buckets - 1) < 0) { /* clear "deleted" elements */ \
-					BUG("kh_resize_" #name " failed");					\
-				}														\
-			} else if (kh_resize_##name(h, h->n_buckets + 1) < 0) { /* expand the hash table */ \
-				BUG("kh_resize_" #name " failed");						\
+				kh_resize_##name(h, h->n_buckets - 1); /* clear "deleted" elements */ \
+			} else { \
+				kh_resize_##name(h, h->n_buckets + 1); /* expand the hash table */ \
 			}															\
 		} /* TODO: to implement automatically shrinking; resize() already support shrinking */ \
 		{																\
