Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759320408E
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413024; cv=none; b=I22G0lR9vrREhljPtAQKNye2aY3MPIuGvfWchV/kmHkAz/h5uV5WHX9wqEVLNbYJmJ3nL3G8rRuSecsFb/vgaBDRdx78FGzwuJy0x2Hl6EYIGBoPUqiWDSA8jBYsMy6ourMu2IiK+PD6t48RB2DwlH9VuLd9rjDVvp6uEWALHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413024; c=relaxed/simple;
	bh=Fp0UMYc8ofYVdLUB0eqRm5Jh9tO3UM6bQZIkzm6khOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqE6kA/zJ/kswEnoFBUi84WP41u/rD/m1UKrPcclcmRBiH0eS+fyNfJtSAR0t17CwJW7wXKggVkqzHhbdfRgWFxzpExMwOuzH2xbkBb6j4QKg1p3GyubuzKyi/SYjNR+dxiKytuX+/Rj6yUMszRK5ruF06GJWST8UP7wkuYQZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bhMypwqd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bhMypwqd"
Received: (qmail 25794 invoked by uid 109); 9 Jan 2025 08:57:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Fp0UMYc8ofYVdLUB0eqRm5Jh9tO3UM6bQZIkzm6khOw=; b=bhMypwqdvIsIZuXgULLm56EmnCwrYv0iQZOC5G8c9/atdF+Jvb/K4oWkR/3ZUl9wa7rou7ThY+w5Io7o+TPff85Wj5uc/GxwkzJyXkP0M9Sk/YDCF0i+71VQCYcpb2OBG2iPF1WPv2AUi+M7Fzp6BFRAgcBWbFtAQoR6JJcaMyX2NK1F5EzMGKqBuMlUbR3speHsxxRbbRCHoa+T50HGhSQwGbva7Y6kGMKyCM1EPgslYp1OE3ssjKRQWkXAWfFBSHKxO5DRq9AVh5EPO+AwFozLbrMg7NHVpFlhUCoCw8K4z8ZPdvZyY7V/z8YY39iPQKo7VKDYHWuCj6MC83Oq2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:57:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20498 invoked by uid 111); 9 Jan 2025 08:57:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:57:00 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:57:00 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 14/14] tree-diff: make list tail-passing more explicit
Message-ID: <20250109085700.GN2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

The ll_diff_tree_paths() function and its helpers all take a pointer to
a list tail, possibly add to it, and then return the new tail. This
works but has two downsides:

  - The top-level caller (diff_tree_paths() in this case) has to make a
    fake combine_diff_path struct to act as the list head. This is
    especially weird here, as it's a flexible-sized struct which will
    have an empty FLEX_ARRAY field. That used to be a portability
    problem, though these days it is legal because our FLEX_ARRAY macro
    over-allocates if necessary. It's still kind of ugly, though.

  - Besides the name "tail", it's not immediately obvious that the entry
    we pass around will not be examined by each function. Using a
    pointer-to-pointer or similar makes it more obvious we only care
    about the pointer itself, not its contents.

We can solve both by passing around a pointer to the tail instead. That
gets rid of the return value entirely, though note that because of the
recursion we actually need a three-star pointer for this to work.

The result is fairly readable, as we only need to dereference the tail
in one spot. If we wanted to make it simpler we could wrap the tail in a
struct, which we pass around.

Another option is to convert combine_diff to use our generic list_head
API. I tried that and found the result became much harder to read
overall. It means that _all_ code that looks at combine_diff_path
structs needs to be modified, since the "next" pointer is now inside a
list_head which has to be dereferenced with list_entry(). And we lose
some type safety, since we're just passing around a list_head struct
everywhere, and everybody who looks at it has to specify the type to
list_entry themselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-diff.c | 47 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index f5ec19113c..60c558c2b5 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -48,8 +48,8 @@
 		free((x)); \
 } while(0)
 
-static struct combine_diff_path *ll_diff_tree_paths(
-	struct combine_diff_path *tail, const struct object_id *oid,
+static void ll_diff_tree_paths(
+	struct combine_diff_path ***tail, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt,
 	int depth);
@@ -134,10 +134,10 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
  *	 t,  tp		-> path modified/added
  *			   (M for tp[i]=tp[imin], A otherwise)
  */
-static struct combine_diff_path *emit_path(struct combine_diff_path *tail,
-	struct strbuf *base, struct diff_options *opt, int nparent,
-	struct tree_desc *t, struct tree_desc *tp,
-	int imin, int depth)
+static void emit_path(struct combine_diff_path ***tail,
+		      struct strbuf *base, struct diff_options *opt,
+		      int nparent, struct tree_desc *t, struct tree_desc *tp,
+		      int imin, int depth)
 {
 	unsigned short mode;
 	const char *path;
@@ -219,8 +219,8 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *tail,
 			keep = opt->pathchange(opt, p);
 
 		if (keep) {
-			tail->next = p;
-			tail = p;
+			**tail = p;
+			*tail = &p->next;
 		} else {
 			free(p);
 		}
@@ -239,13 +239,12 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *tail,
 
 		strbuf_add(base, path, pathlen);
 		strbuf_addch(base, '/');
-		tail = ll_diff_tree_paths(tail, oid, parents_oid, nparent, base, opt,
-					  depth + 1);
+		ll_diff_tree_paths(tail, oid, parents_oid, nparent, base, opt,
+				   depth + 1);
 		FAST_ARRAY_FREE(parents_oid, nparent);
 	}
 
 	strbuf_setlen(base, old_baselen);
-	return tail;
 }
 
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
@@ -358,8 +357,8 @@ static inline void update_tp_entries(struct tree_desc *tp, int nparent)
 			update_tree_entry(&tp[i]);
 }
 
-static struct combine_diff_path *ll_diff_tree_paths(
-	struct combine_diff_path *tail, const struct object_id *oid,
+static void ll_diff_tree_paths(
+	struct combine_diff_path ***tail, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt,
 	int depth)
@@ -463,8 +462,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			}
 
 			/* D += {δ(t,pi) if pi=p[imin];  "+a" if pi > p[imin]} */
-			tail = emit_path(tail, base, opt, nparent,
-					 &t, tp, imin, depth);
+			emit_path(tail, base, opt, nparent,
+				  &t, tp, imin, depth);
 
 		skip_emit_t_tp:
 			/* t↓,  ∀ pi=p[imin]  pi↓ */
@@ -475,8 +474,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		/* t < p[imin] */
 		else if (cmp < 0) {
 			/* D += "+t" */
-			tail = emit_path(tail, base, opt, nparent,
-					 &t, /*tp=*/NULL, -1, depth);
+			emit_path(tail, base, opt, nparent,
+				  &t, /*tp=*/NULL, -1, depth);
 
 			/* t↓ */
 			update_tree_entry(&t);
@@ -491,8 +490,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 						goto skip_emit_tp;
 			}
 
-			tail = emit_path(tail, base, opt, nparent,
-					 /*t=*/NULL, tp, imin, depth);
+			emit_path(tail, base, opt, nparent,
+				  /*t=*/NULL, tp, imin, depth);
 
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
@@ -505,20 +504,16 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		free(tptree[i]);
 	FAST_ARRAY_FREE(tptree, nparent);
 	FAST_ARRAY_FREE(tp, nparent);
-
-	return tail;
 }
 
 struct combine_diff_path *diff_tree_paths(
 	const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
-	struct combine_diff_path head, *p;
-	/* fake list head, so worker can assume it is non-NULL */
-	head.next = NULL;
-	p = ll_diff_tree_paths(&head, oid, parents_oid, nparent, base, opt, 0);
-	return p;
+	struct combine_diff_path *head = NULL, **tail = &head;
+	ll_diff_tree_paths(&tail, oid, parents_oid, nparent, base, opt, 0);
+	return head;
 }
 
 /*
-- 
2.48.0.rc2.413.gc1c80375a3
