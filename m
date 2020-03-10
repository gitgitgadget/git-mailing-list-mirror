Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBFCC10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4103C2146E
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCJSHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:07:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:35540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726436AbgCJSHu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 14:07:50 -0400
Received: (qmail 25126 invoked by uid 109); 10 Mar 2020 18:07:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Mar 2020 18:07:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13530 invoked by uid 111); 10 Mar 2020 18:17:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Mar 2020 14:17:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Mar 2020 14:07:48 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-slab: clarify slabname##_peek()'s return value
Message-ID: <20200310180748.GC549010@coredump.intra.peff.net>
References: <20200310153049.3482-1-szeder.dev@gmail.com>
 <20200310175446.GB549010@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310175446.GB549010@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 10, 2020 at 01:54:46PM -0400, Jeff King wrote:

> I also wondered if we could make life easier for the caller by
> collapsing these cases. I.e., always returning a zero-initialized value,
> and never NULL.
> [...]
> But that would get a bit awkward, because peek() returns a pointer, not
> a value (as it should, because the type we're storing may be a compound
> type, which we generally avoid passing or returning by value).  So we'd
> actually need to return a pointer to a zero-initialized dummy value. Not
> impossible, but getting a bit odd.

I was a little curious how it would look. Code-wise it's not too bad,
but if anybody ever wrote to the dummy entry, that would cause confusing
bugs. Possibly peek() could return a pointer-to-const.

The code savings in the callers are not all that much (I didn't convert
all sites, but you can see that it just saves a few lines in each case).

So it's probably not worth the churn, but if anybody is really excited
about it, I can polish it into a real patch.

diff --git a/blame.c b/blame.c
index 29770e5c81..3ae42a1edd 100644
--- a/blame.c
+++ b/blame.c
@@ -15,11 +15,7 @@ static struct blame_suspects blame_suspects;
 
 struct blame_origin *get_blame_suspects(struct commit *commit)
 {
-	struct blame_origin **result;
-
-	result = blame_suspects_peek(&blame_suspects, commit);
-
-	return result ? *result : NULL;
+	return *blame_suspects_peek(&blame_suspects, commit);
 }
 
 static void set_blame_suspects(struct commit *commit, struct blame_origin *origin)
diff --git a/commit-slab-decl.h b/commit-slab-decl.h
index adc7b46c83..4b951e7b2f 100644
--- a/commit-slab-decl.h
+++ b/commit-slab-decl.h
@@ -13,6 +13,7 @@ struct slabname {							\
 	unsigned stride;						\
 	unsigned slab_count;						\
 	elemtype **slab;						\
+	elemtype dummy;							\
 }
 
 /*
diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 5c0eb91a5d..505c21599a 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -22,6 +22,7 @@ scope void init_ ##slabname## _with_stride(struct slabname *s,		\
 	s->slab_size = COMMIT_SLAB_SIZE / elem_size;			\
 	s->slab_count = 0;						\
 	s->slab = NULL;							\
+	memset(&s->dummy, 0, sizeof(elemtype));				\
 }									\
 									\
 scope void init_ ##slabname(struct slabname *s)				\
@@ -50,15 +51,15 @@ scope elemtype *slabname## _at_peek(struct slabname *s,			\
 	if (s->slab_count <= nth_slab) {				\
 		unsigned int i;						\
 		if (!add_if_missing)					\
-			return NULL;					\
+			return &s->dummy;				\
 		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
 		for (i = s->slab_count; i <= nth_slab; i++)		\
 			s->slab[i] = NULL;				\
 		s->slab_count = nth_slab + 1;				\
 	}								\
 	if (!s->slab[nth_slab]) {					\
 		if (!add_if_missing)					\
-			return NULL;					\
+			return &s->dummy;				\
 		s->slab[nth_slab] = xcalloc(s->slab_size,		\
 					    sizeof(**s->slab) * s->stride);		\
 	}								\
diff --git a/commit.c b/commit.c
index a6cfa41a4e..49d86435a5 100644
--- a/commit.c
+++ b/commit.c
@@ -289,11 +289,6 @@ const void *get_cached_commit_buffer(struct repository *r, const struct commit *
 {
 	struct commit_buffer *v = buffer_slab_peek(
 		r->parsed_objects->buffer_slab, commit);
-	if (!v) {
-		if (sizep)
-			*sizep = 0;
-		return NULL;
-	}
 	if (sizep)
 		*sizep = v->size;
 	return v->buffer;
