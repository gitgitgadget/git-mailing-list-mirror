Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A92F2D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412720; cv=none; b=FSzG45wfaelgy1LFcu0UM38KKryFhcGODc2uK1gb9j9HuZQjrJOmGxD+NmtYWeC0viiqfzKtPXUhRUDR58gZA1q5ZHZDyXrV3SCVle4KFFEsI/aMwN3Oq34zopfzZS0e5Fo2FiTLoQVnfgDqXhlKBJCJEsBDGfnYS78dAj6MjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412720; c=relaxed/simple;
	bh=gTE5d8PKA8+Rmat3t8Mwnv2RrbJlNgsYlfQXOOzGVL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbVfqBjg1y5kI1rve/G2mx/GQ+7zM+Z+vwKUQhoukLgWbCC9WcuLTx3t5VJ+z0eYNcJ40PlJE/626+hYaH37CihmRiFQoxiJxQylnfuHSIe4MBOIQ5S+5j1a7asf5fO2fmfsYIeVDt0HsB2Bf24SRKZWTx4bBSiBue7GSc+X/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J1mb+chz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J1mb+chz"
Received: (qmail 25749 invoked by uid 109); 9 Jan 2025 08:51:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gTE5d8PKA8+Rmat3t8Mwnv2RrbJlNgsYlfQXOOzGVL4=; b=J1mb+chzyUPZMcZO8qm4hrg++PAyEJAPRj6t6MKe1f8CyKmIXRUAwirOoHpZFQrShAgOdnxAlEZSYs0EFv9bSed4E2UdNI637wBZvKX2QOXEg0K60h8DfVz2eYZoA2oimi3fU9D+wdP01FSq/q8Afo9+YyLeh8xFqkOPAGcPBGsTqe6YJk5haUCcgDJDPDnNdSTTFST16YuF3slh7guwp+vr0hlX1/+aTNi9vQkccbFYZIwly6drQj0ASX+qvUos2GN9pVKX3A7/kKdpGOsSKvCdacC6yIU1+e517sOi2MdJx/0fERg7dsCZqFDUiE7DqfoVdqoFn30spbqKH37ghw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:51:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20420 invoked by uid 111); 9 Jan 2025 08:51:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:51:56 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:51:56 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 11/14] tree-diff: drop list-tail argument to diff_tree_paths()
Message-ID: <20250109085156.GK2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

The internals of the path diffing code, including ll_diff_tree_paths(),
all take an extra combine_diff_path parameter which they use as the tail
of a list of results, appending any new entries to it.

The public-facing diff_tree_paths() takes the same argument, but it just
makes the callers more awkward. They always start with a clean list, and
have to set up a fake head struct to pass in.

Let's keep the public API clean by always returning a new list. That
keeps the fake struct as an implementation detail of tree-diff.c.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c |  9 +++------
 diff.h         |  2 +-
 tree-diff.c    | 14 ++++++++------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index f21e1f58ba..9527f3160d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1428,22 +1428,19 @@ static struct combine_diff_path *find_paths_multitree(
 {
 	int i, nparent = parents->nr;
 	const struct object_id **parents_oid;
-	struct combine_diff_path paths_head;
+	struct combine_diff_path *paths;
 	struct strbuf base;
 
 	ALLOC_ARRAY(parents_oid, nparent);
 	for (i = 0; i < nparent; i++)
 		parents_oid[i] = &parents->oid[i];
 
-	/* fake list head, so worker can assume it is non-NULL */
-	paths_head.next = NULL;
-
 	strbuf_init(&base, PATH_MAX);
-	diff_tree_paths(&paths_head, oid, parents_oid, nparent, &base, opt);
+	paths = diff_tree_paths(oid, parents_oid, nparent, &base, opt);
 
 	strbuf_release(&base);
 	free(parents_oid);
-	return paths_head.next;
+	return paths;
 }
 
 static int match_objfind(struct combine_diff_path *path,
diff --git a/diff.h b/diff.h
index 32ad17fd38..7831ed1a2b 100644
--- a/diff.h
+++ b/diff.h
@@ -462,7 +462,7 @@ const char *diff_line_prefix(struct diff_options *);
 extern const char mime_boundary_leader[];
 
 struct combine_diff_path *diff_tree_paths(
-	struct combine_diff_path *p, const struct object_id *oid,
+	const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt);
 void diff_tree_oid(const struct object_id *old_oid,
diff --git a/tree-diff.c b/tree-diff.c
index 18e5a16716..e99e40da18 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -510,11 +510,14 @@ static struct combine_diff_path *ll_diff_tree_paths(
 }
 
 struct combine_diff_path *diff_tree_paths(
-	struct combine_diff_path *p, const struct object_id *oid,
+	const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
-	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt, 0);
+	struct combine_diff_path head, *p;
+	/* fake list head, so worker can assume it is non-NULL */
+	head.next = NULL;
+	p = ll_diff_tree_paths(&head, oid, parents_oid, nparent, base, opt, 0);
 	return p;
 }
 
@@ -631,14 +634,13 @@ static void ll_diff_tree_oid(const struct object_id *old_oid,
 			     const struct object_id *new_oid,
 			     struct strbuf *base, struct diff_options *opt)
 {
-	struct combine_diff_path phead, *p;
+	struct combine_diff_path *paths, *p;
 	pathchange_fn_t pathchange_old = opt->pathchange;
 
-	phead.next = NULL;
 	opt->pathchange = emit_diff_first_parent_only;
-	diff_tree_paths(&phead, new_oid, &old_oid, 1, base, opt);
+	paths = diff_tree_paths(new_oid, &old_oid, 1, base, opt);
 
-	for (p = phead.next; p;) {
+	for (p = paths; p;) {
 		struct combine_diff_path *pprev = p;
 		p = p->next;
 		free(pprev);
-- 
2.48.0.rc2.413.gc1c80375a3

