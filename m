Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA11C83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjHaGXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345071AbjHaGW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:22:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC99DE67
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:22:16 -0700 (PDT)
Received: (qmail 21166 invoked by uid 109); 31 Aug 2023 06:22:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:22:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3018 invoked by uid 111); 31 Aug 2023 06:22:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:22:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:22:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/10] list-objects: respect max_allowed_tree_depth
Message-ID: <20230831062203.GH3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tree traversal in list-objects.c, which is used by "rev-list
--objects", etc, uses recursion and may run out of stack space. Let's
teach it about the new core.maxTreeDepth config option.

We unfortunately can't return an error here, as this code doesn't
produce an error return at all. We'll die() instead, which matches the
behavior when we see an otherwise broken tree.

Note that this will also generally reject such deep trees from entering
the repository from a fetch or push, due to the use of rev-list in the
connectivity check. But it's not foolproof! We stop traversing when we
see an UNINTERESTING object, and the connectivity check marks existing
ref tips as UNINTERESTING. So imagine commit X has a tree
with maximum depth N. If you then create a new commit Y with a tree
entry "Y:subdir" that points to "X^{tree}", then the depth of Y will be
N+1. But a connectivity check running "git rev-list --objects Y --not X"
won't realize that; it will stop traversing at X^{tree}, since that was
already reachable.

So this will stop naive pushes of too-deep trees, but not carefully
crafted malicious ones. Doing it robustly and efficiently would require
caching the maximum depth of each tree (i.e., the longest path to any
leaf entry). That's much more complex and not strictly needed. If each
recursive algorithm limits itself already, then that's sufficient.
Blocking the objects from entering the repo would be a nice
belt-and-suspenders addition, but it's not worth the extra cost.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c        | 8 ++++++++
 t/t6700-tree-depth.sh | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/list-objects.c b/list-objects.c
index e60a6cd5b4..c25c72b32c 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -14,13 +14,15 @@
 #include "packfile.h"
 #include "object-store-ll.h"
 #include "trace.h"
+#include "environment.h"
 
 struct traversal_context {
 	struct rev_info *revs;
 	show_object_fn show_object;
 	show_commit_fn show_commit;
 	void *show_data;
 	struct filter *filter;
+	int depth;
 };
 
 static void show_commit(struct traversal_context *ctx,
@@ -118,7 +120,9 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			t->object.flags |= NOT_USER_GIVEN;
+			ctx->depth++;
 			process_tree(ctx, t, base, entry.path);
+			ctx->depth--;
 		}
 		else if (S_ISGITLINK(entry.mode))
 			; /* ignore gitlink */
@@ -156,6 +160,9 @@ static void process_tree(struct traversal_context *ctx,
 	    !revs->include_check_obj(&tree->object, revs->include_check_data))
 		return;
 
+	if (ctx->depth > max_allowed_tree_depth)
+		die("exceeded maximum allowed tree depth");
+
 	failed_parse = parse_tree_gently(tree, 1);
 	if (failed_parse) {
 		if (revs->ignore_missing_links)
@@ -349,6 +356,7 @@ static void traverse_non_commits(struct traversal_context *ctx,
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
+			ctx->depth = 0;
 			process_tree(ctx, (struct tree *)obj, base, path);
 			continue;
 		}
diff --git a/t/t6700-tree-depth.sh b/t/t6700-tree-depth.sh
index 93ec41df03..f5d284b16e 100755
--- a/t/t6700-tree-depth.sh
+++ b/t/t6700-tree-depth.sh
@@ -72,4 +72,13 @@ test_expect_success 'default limit for ls-tree fails gracefully' '
 	test_must_fail git ls-tree -r big >/dev/null
 '
 
+test_expect_success 'limit recursion of rev-list --objects' '
+	git $small_ok rev-list --objects small >/dev/null &&
+	test_must_fail git $small_no rev-list --objects small >/dev/null
+'
+
+test_expect_success 'default limit for rev-list fails gracefully' '
+	test_must_fail git rev-list --objects big >/dev/null
+'
+
 test_done
-- 
2.42.0.561.gaa987ecc69

