Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D7CC83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbjHaGXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbjHaGXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:23:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D19BCFE
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:22:27 -0700 (PDT)
Received: (qmail 21169 invoked by uid 109); 31 Aug 2023 06:22:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:22:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3021 invoked by uid 111); 31 Aug 2023 06:22:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:22:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:22:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/10] tree-diff: respect max_allowed_tree_depth
Message-ID: <20230831062208.GI3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When diffing trees, we recurse to handle subtrees. That means we may run
out of stack space and segfault. Let's teach this code path about
core.maxTreeDepth in order to fail more gracefully.

As with the previous patch, we have no way to return an error (and other
tree-loading problems would just cause us to die()). So we'll likewise
call die() if we exceed the maximum depth.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6700-tree-depth.sh |  9 +++++++++
 tree-diff.c           | 23 +++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/t/t6700-tree-depth.sh b/t/t6700-tree-depth.sh
index f5d284b16e..e410c41234 100755
--- a/t/t6700-tree-depth.sh
+++ b/t/t6700-tree-depth.sh
@@ -81,4 +81,13 @@ test_expect_success 'default limit for rev-list fails gracefully' '
 	test_must_fail git rev-list --objects big >/dev/null
 '
 
+test_expect_success 'limit recursion of diff-tree -r' '
+	git $small_ok diff-tree -r $EMPTY_TREE small &&
+	test_must_fail git $small_no diff-tree -r $EMPTY_TREE small
+'
+
+test_expect_success 'default limit for diff-tree fails gracefully' '
+	test_must_fail git diff-tree -r $EMPTY_TREE big
+'
+
 test_done
diff --git a/tree-diff.c b/tree-diff.c
index 8fc159b86e..46107772d1 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -7,6 +7,7 @@
 #include "hash.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "environment.h"
 
 /*
  * Some mode bits are also used internally for computations.
@@ -45,7 +46,8 @@
 static struct combine_diff_path *ll_diff_tree_paths(
 	struct combine_diff_path *p, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
-	struct strbuf *base, struct diff_options *opt);
+	struct strbuf *base, struct diff_options *opt,
+	int depth);
 static void ll_diff_tree_oid(const struct object_id *old_oid,
 			     const struct object_id *new_oid,
 			     struct strbuf *base, struct diff_options *opt);
@@ -196,7 +198,7 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	struct strbuf *base, struct diff_options *opt, int nparent,
 	struct tree_desc *t, struct tree_desc *tp,
-	int imin)
+	int imin, int depth)
 {
 	unsigned short mode;
 	const char *path;
@@ -302,7 +304,8 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 
 		strbuf_add(base, path, pathlen);
 		strbuf_addch(base, '/');
-		p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
+		p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt,
+				       depth + 1);
 		FAST_ARRAY_FREE(parents_oid, nparent);
 	}
 
@@ -423,12 +426,16 @@ static inline void update_tp_entries(struct tree_desc *tp, int nparent)
 static struct combine_diff_path *ll_diff_tree_paths(
 	struct combine_diff_path *p, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
-	struct strbuf *base, struct diff_options *opt)
+	struct strbuf *base, struct diff_options *opt,
+	int depth)
 {
 	struct tree_desc t, *tp;
 	void *ttree, **tptree;
 	int i;
 
+	if (depth > max_allowed_tree_depth)
+		die("exceeded maximum allowed tree depth");
+
 	FAST_ARRAY_ALLOC(tp, nparent);
 	FAST_ARRAY_ALLOC(tptree, nparent);
 
@@ -522,7 +529,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 
 			/* D += {δ(t,pi) if pi=p[imin];  "+a" if pi > p[imin]} */
 			p = emit_path(p, base, opt, nparent,
-					&t, tp, imin);
+					&t, tp, imin, depth);
 
 		skip_emit_t_tp:
 			/* t↓,  ∀ pi=p[imin]  pi↓ */
@@ -534,7 +541,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		else if (cmp < 0) {
 			/* D += "+t" */
 			p = emit_path(p, base, opt, nparent,
-					&t, /*tp=*/NULL, -1);
+					&t, /*tp=*/NULL, -1, depth);
 
 			/* t↓ */
 			update_tree_entry(&t);
@@ -550,7 +557,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			}
 
 			p = emit_path(p, base, opt, nparent,
-					/*t=*/NULL, tp, imin);
+					/*t=*/NULL, tp, imin, depth);
 
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
@@ -572,7 +579,7 @@ struct combine_diff_path *diff_tree_paths(
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
-	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
+	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt, 0);
 
 	/*
 	 * free pre-allocated last element, if any
-- 
2.42.0.561.gaa987ecc69

