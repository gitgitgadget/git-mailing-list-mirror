Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2C2F2D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412792; cv=none; b=pnhvkxIuxO/BsFcOyS5njfEkrHn6A6w3gHJPd5p1mpgPIvqSsaKlA0aSMrpWqlOxdMCnKkabPvbP/iWPpbB8KEYxfJMi9olvcP26yDotp/pMvpSYDTcPI3jE9VXYyhd9AGe3VtxZE7l3DbxH6kqeXBeSOG63IOw8ypumfJEQTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412792; c=relaxed/simple;
	bh=lR5cAHruZWZd/kWh+G/5ofRgUnJJCkE8Wg080qF/O0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIrwgKY4LlXmuiO0ul+av4IBJMzPIdoFnd48hO//JUQo9XDMrn9D4sQQIOxPQgcmLhhANl4vL+tWpA2gx3mQPVANTm3P0nFFcivGdiHuMpnF7gFNAdUkAesw+khHVnZsDn8sLc+xApJzYU5v1JqXb+sAyEBnHLs8klTx+ZIyWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V15/UoH/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V15/UoH/"
Received: (qmail 25761 invoked by uid 109); 9 Jan 2025 08:53:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=lR5cAHruZWZd/kWh+G/5ofRgUnJJCkE8Wg080qF/O0Q=; b=V15/UoH/8xlyMrspC6bX+5YBwcb+EwOq5J0nMyn6lXlGOsHJt5SeXVKBCdgmfDsac57weyrOpQRIIfmny7eGJbI+rFlClxtebRAWRA9cZ5acLOPOyMb/lPFyZSNd/HXVZOk9514fYNO8lwA9APj13MmOvXx0cKHK4K2e+lfLb/ESKFEIJBWgWdtJ3bb/zJpUyRnH3nxhbNn3Zu3fhTsDrhwt795bXP7W4t5nh8Ifu34MET67JXZPLyO1ykuCfOEdAr/gWsqWjjba44DJlW+xASD7qbITo+E1ezRdI9OWW6bNBjP90l1S9us2iUg2YqW2LPmbAZZj4CCIKytQtui1YQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:53:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20425 invoked by uid 111); 9 Jan 2025 08:53:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:53:09 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:53:09 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 12/14] tree-diff: use the name "tail" to refer to list tail
Message-ID: <20250109085309.GL2748836@coredump.intra.peff.net>
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

The ll_diff_tree_paths() function and its helpers all append to a
running list by taking in a pointer to the old tail and returning the
new tail. But they just call this argument "p", which is not very
descriptive.

It gets particularly confusing in emit_path(), where we actually add to
the list, because "p" does double-duty: it is the tail of the list, but
it is also the entry which we add. Except that in some cases we _don't_
add a new entry (or we might even add it and roll it back) if the path
isn't interesting. At first glance, this makes it look like a bug that
we pass "p" on to ll_diff_tree_paths() to recurse; sometimes it is
getting the new entry we made and sometimes not!

But it's not a bug, because ll_diff_tree_paths() does not care about the
entry itself at all. It is only using its "next" pointer as the tail of
the list.

Let's swap out "p" for "tail" to make this obvious. And then in
emit_path() we'll continue to use "p" for our newly allocated entry.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-diff.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index e99e40da18..a1a611bef6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -49,7 +49,7 @@
 } while(0)
 
 static struct combine_diff_path *ll_diff_tree_paths(
-	struct combine_diff_path *p, const struct object_id *oid,
+	struct combine_diff_path *tail, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt,
 	int depth);
@@ -134,7 +134,7 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
  *	 t,  tp		-> path modified/added
  *			   (M for tp[i]=tp[imin], A otherwise)
  */
-static struct combine_diff_path *emit_path(struct combine_diff_path *p,
+static struct combine_diff_path *emit_path(struct combine_diff_path *tail,
 	struct strbuf *base, struct diff_options *opt, int nparent,
 	struct tree_desc *t, struct tree_desc *tp,
 	int imin, int depth)
@@ -177,13 +177,14 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 
 	if (emitthis) {
 		int keep;
-		struct combine_diff_path *pprev = p;
+		struct combine_diff_path *pprev = tail, *p;
 
 		strbuf_add(base, path, pathlen);
 		p = combine_diff_path_new(base->buf, base->len, mode,
 					  oid ? oid : null_oid(),
 					  nparent);
-		pprev->next = p;
+		tail->next = p;
+		tail = p;
 		strbuf_setlen(base, old_baselen);
 
 		for (i = 0; i < nparent; ++i) {
@@ -222,7 +223,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		if (!keep) {
 			free(p);
 			pprev->next = NULL;
-			p = pprev;
+			tail = pprev;
 		}
 	}
 
@@ -239,13 +240,13 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 
 		strbuf_add(base, path, pathlen);
 		strbuf_addch(base, '/');
-		p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt,
-				       depth + 1);
+		tail = ll_diff_tree_paths(tail, oid, parents_oid, nparent, base, opt,
+					  depth + 1);
 		FAST_ARRAY_FREE(parents_oid, nparent);
 	}
 
 	strbuf_setlen(base, old_baselen);
-	return p;
+	return tail;
 }
 
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
@@ -359,7 +360,7 @@ static inline void update_tp_entries(struct tree_desc *tp, int nparent)
 }
 
 static struct combine_diff_path *ll_diff_tree_paths(
-	struct combine_diff_path *p, const struct object_id *oid,
+	struct combine_diff_path *tail, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt,
 	int depth)
@@ -463,8 +464,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			}
 
 			/* D += {δ(t,pi) if pi=p[imin];  "+a" if pi > p[imin]} */
-			p = emit_path(p, base, opt, nparent,
-					&t, tp, imin, depth);
+			tail = emit_path(tail, base, opt, nparent,
+					 &t, tp, imin, depth);
 
 		skip_emit_t_tp:
 			/* t↓,  ∀ pi=p[imin]  pi↓ */
@@ -475,8 +476,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		/* t < p[imin] */
 		else if (cmp < 0) {
 			/* D += "+t" */
-			p = emit_path(p, base, opt, nparent,
-					&t, /*tp=*/NULL, -1, depth);
+			tail = emit_path(tail, base, opt, nparent,
+					 &t, /*tp=*/NULL, -1, depth);
 
 			/* t↓ */
 			update_tree_entry(&t);
@@ -491,8 +492,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 						goto skip_emit_tp;
 			}
 
-			p = emit_path(p, base, opt, nparent,
-					/*t=*/NULL, tp, imin, depth);
+			tail = emit_path(tail, base, opt, nparent,
+					 /*t=*/NULL, tp, imin, depth);
 
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
@@ -506,7 +507,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	FAST_ARRAY_FREE(tptree, nparent);
 	FAST_ARRAY_FREE(tp, nparent);
 
-	return p;
+	return tail;
 }
 
 struct combine_diff_path *diff_tree_paths(
-- 
2.48.0.rc2.413.gc1c80375a3

