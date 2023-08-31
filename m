Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D00C83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbjHaGW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbjHaGWp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:22:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A4E4A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:22:06 -0700 (PDT)
Received: (qmail 21163 invoked by uid 109); 31 Aug 2023 06:21:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:21:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3015 invoked by uid 111); 31 Aug 2023 06:21:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:21:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:21:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/10] read_tree(): respect max_allowed_tree_depth
Message-ID: <20230831062155.GG3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read_tree() function reads trees recursively (via its read_tree_at()
helper). This can cause it to run out of stack space on very deep trees.
Let's teach it about the new core.maxTreeDepth option.

The easiest way to demonstrate this is via "ls-tree -r", which the test
covers. Note that I needed a tree depth of ~30k to trigger a segfault on
my Linux system, not the 4100 used by our "big" test in t6700. However,
that test still tells us what we want: that the default 4096 limit is
enough to prevent segfaults on all platforms. We could bump it, but that
increases the cost of the test setup for little gain.

As an interesting side-note: when I originally wrote this patch about 4
years ago, I needed a depth of ~50k to segfault. But porting it forward,
the number is much lower. Seemingly little things like cf0983213c (hash:
add an algo member to struct object_id, 2021-04-26) take it from 32,722
to 29,080.

Signed-off-by: Jeff King <peff@peff.net>
---
 sparse-index.c        | 2 +-
 t/t6700-tree-depth.sh | 9 +++++++++
 tree.c                | 9 +++++++--
 tree.h                | 1 +
 wt-status.c           | 2 +-
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 1fdb07a9e6..3578feb283 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -391,7 +391,7 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 		strbuf_setlen(&base, 0);
 		strbuf_add(&base, ce->name, strlen(ce->name));
 
-		read_tree_at(istate->repo, tree, &base, &ps,
+		read_tree_at(istate->repo, tree, &base, 0, &ps,
 			     add_path_to_index, &ctx);
 
 		/* free directory entries. full entries are re-used */
diff --git a/t/t6700-tree-depth.sh b/t/t6700-tree-depth.sh
index d4d17db2ae..93ec41df03 100755
--- a/t/t6700-tree-depth.sh
+++ b/t/t6700-tree-depth.sh
@@ -63,4 +63,13 @@ test_expect_success 'default limit for git-archive fails gracefully' '
 	test_must_fail git archive big >/dev/null
 '
 
+test_expect_success 'limit recursion of ls-tree -r' '
+	git $small_ok ls-tree -r small &&
+	test_must_fail git $small_no ls-tree -r small
+'
+
+test_expect_success 'default limit for ls-tree fails gracefully' '
+	test_must_fail git ls-tree -r big >/dev/null
+'
+
 test_done
diff --git a/tree.c b/tree.c
index c745462f96..990f9c9854 100644
--- a/tree.c
+++ b/tree.c
@@ -10,11 +10,13 @@
 #include "alloc.h"
 #include "tree-walk.h"
 #include "repository.h"
+#include "environment.h"
 
 const char *tree_type = "tree";
 
 int read_tree_at(struct repository *r,
 		 struct tree *tree, struct strbuf *base,
+		 int depth,
 		 const struct pathspec *pathspec,
 		 read_tree_fn_t fn, void *context)
 {
@@ -24,6 +26,9 @@ int read_tree_at(struct repository *r,
 	int len, oldlen = base->len;
 	enum interesting retval = entry_not_interesting;
 
+	if (depth > max_allowed_tree_depth)
+		return error("exceeded maximum allowed tree depth");
+
 	if (parse_tree(tree))
 		return -1;
 
@@ -74,7 +79,7 @@ int read_tree_at(struct repository *r,
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
 		retval = read_tree_at(r, lookup_tree(r, &oid),
-				      base, pathspec,
+				      base, depth + 1, pathspec,
 				      fn, context);
 		strbuf_setlen(base, oldlen);
 		if (retval)
@@ -89,7 +94,7 @@ int read_tree(struct repository *r,
 	      read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret = read_tree_at(r, tree, &sb, pathspec, fn, context);
+	int ret = read_tree_at(r, tree, &sb, 0, pathspec, fn, context);
 	strbuf_release(&sb);
 	return ret;
 }
diff --git a/tree.h b/tree.h
index 1b5ecbda6b..cc6ddf51b3 100644
--- a/tree.h
+++ b/tree.h
@@ -44,6 +44,7 @@ typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const c
 
 int read_tree_at(struct repository *r,
 		 struct tree *tree, struct strbuf *base,
+		 int depth,
 		 const struct pathspec *pathspec,
 		 read_tree_fn_t fn, void *context);
 
diff --git a/wt-status.c b/wt-status.c
index 5b1378965c..996f8635c3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -739,7 +739,7 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			ps.max_depth = -1;
 
 			strbuf_add(&base, ce->name, ce->ce_namelen);
-			read_tree_at(istate->repo, tree, &base, &ps,
+			read_tree_at(istate->repo, tree, &base, 0, &ps,
 				     add_file_to_list, s);
 			continue;
 		}
-- 
2.42.0.561.gaa987ecc69

