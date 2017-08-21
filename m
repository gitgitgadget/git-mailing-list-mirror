Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E37A20899
	for <e@80x24.org>; Mon, 21 Aug 2017 00:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbdHUAAd (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 20:00:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57060 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753430AbdHUAAc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Aug 2017 20:00:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 246B5280AF
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503273631;
        bh=1cFHdIFTd67zj7SxLUadBwbalVcVwOweTXndq0iNX/s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=armaEdtRHRNGgSGgClAAYYAQ8QJtASNqNjCw+v9sZ6moYwEKsHAT/sQxNrq6lQQhn
         QULdM4XMd0yT4OjrPtLwt9QyrUR431pncVqDeR3eZxp3wtwe2oMAoJZBd1LsJjOmLC
         2BzqRosK9CMTdICy2M3A9lIIS2Bb2aYeEJ9YWIRlKMsCgIpTdp5HvgwHMzcsV4k0nR
         i5eDLAf+mJqLyAoL6tYi6M4NchwynlAt+LIFB1/7eIwlgIdznGzUE42UIOTacOtJXx
         w8V6JkmTeDA/icyEIa6AlEAoz53QrJimkOfyq7uXrB75FcYGF3wdvYG4BmoG5OyPUc
         xpvvkDYcNYOy4DEafXYabHM25ZXpv+WXS8OlwH32B32zaRBtgXmAAT7UZD+V5w+PyW
         FuGsEh95Ab+YeceapvwOVZQmM1rBYcDE7djBFhznY+VfwPKQPC49ZBzUZVo42fbnSE
         9g0+Pd9pUCNjbuo7/gUJSDW/7rfGWjZuoSWGT1HmBbHlGUpbifW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 6/6] Switch empty tree and blob lookups to use hash abstraction
Date:   Mon, 21 Aug 2017 00:00:22 +0000
Message-Id: <20170821000022.26729-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <20170821000022.26729-1-sandals@crustytoothpaste.net>
References: <20170821000022.26729-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch the uses of empty_tree_oid and empty_blob_oid to use the
current_hash abstraction that represents the current hash algorithm in
use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c       | 2 +-
 builtin/checkout.c | 2 +-
 builtin/diff.c     | 2 +-
 builtin/pull.c     | 2 +-
 cache.h            | 8 ++++----
 diff-lib.c         | 2 +-
 merge-recursive.c  | 2 +-
 notes-merge.c      | 2 +-
 sequencer.c        | 6 +++---
 submodule.c        | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 40cc6d6fe8..347b30bd1f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1435,7 +1435,7 @@ static void write_index_patch(const struct am_state *state)
 	if (!get_oid_tree("HEAD", &head))
 		tree = lookup_tree(&head);
 	else
-		tree = lookup_tree(&empty_tree_oid);
+		tree = lookup_tree(current_hash->empty_tree);
 
 	fp = xfopen(am_path(state, "patch"), "w");
 	init_revisions(&rev_info, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d75ac66c7..efdec232b7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -515,7 +515,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 		tree = parse_tree_indirect(old->commit ?
 					   &old->commit->object.oid :
-					   &empty_tree_oid);
+					   current_hash->empty_tree);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
 		tree = parse_tree_indirect(&new->commit->object.oid);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
diff --git a/builtin/diff.c b/builtin/diff.c
index 7cde6abbcf..4cb5d23899 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -382,7 +382,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				add_head_to_pending(&rev);
 				if (!rev.pending.nr) {
 					struct tree *tree;
-					tree = lookup_tree(&empty_tree_oid);
+					tree = lookup_tree(current_hash->empty_tree);
 					add_pending_object(&rev, &tree->object, "HEAD");
 				}
 				break;
diff --git a/builtin/pull.c b/builtin/pull.c
index 9b86e519b1..4fa5db2fc9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -537,7 +537,7 @@ static int pull_into_void(const struct object_id *merge_head,
 	 * index/worktree changes that the user already made on the unborn
 	 * branch.
 	 */
-	if (checkout_fast_forward(&empty_tree_oid, merge_head, 0))
+	if (checkout_fast_forward(current_hash->empty_tree, merge_head, 0))
 		return 1;
 
 	if (update_ref("initial pull", "HEAD", merge_head->hash, curr_head->hash, 0, UPDATE_REFS_DIE_ON_ERR))
diff --git a/cache.h b/cache.h
index d759824803..23d2e29fcd 100644
--- a/cache.h
+++ b/cache.h
@@ -1051,22 +1051,22 @@ extern const struct object_id empty_blob_oid;
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
-	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
+	return !hashcmp(sha1, current_hash->empty_blob->hash);
 }
 
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
-	return !hashcmp(oid->hash, EMPTY_BLOB_SHA1_BIN);
+	return !oidcmp(oid, current_hash->empty_blob);
 }
 
 static inline int is_empty_tree_sha1(const unsigned char *sha1)
 {
-	return !hashcmp(sha1, EMPTY_TREE_SHA1_BIN);
+	return !hashcmp(sha1, current_hash->empty_tree->hash);
 }
 
 static inline int is_empty_tree_oid(const struct object_id *oid)
 {
-	return !hashcmp(oid->hash, EMPTY_TREE_SHA1_BIN);
+	return !oidcmp(oid, current_hash->empty_tree);
 }
 
 /* set default permissions by passing mode arguments to open(2) */
diff --git a/diff-lib.c b/diff-lib.c
index 2a52b07954..0575f4cb1b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -216,7 +216,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
 				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
-					       &empty_tree_oid, 0,
+					       current_hash->empty_tree, 0,
 					       ce->name, 0);
 				continue;
 			}
diff --git a/merge-recursive.c b/merge-recursive.c
index 1494ffdb82..981fb668f9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2043,7 +2043,7 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(&empty_tree_oid);
+		tree = lookup_tree(current_hash->empty_tree);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/notes-merge.c b/notes-merge.c
index c12b354f10..5b1e2ef8d6 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -597,7 +597,7 @@ int notes_merge(struct notes_merge_options *o,
 	bases = get_merge_bases(local, remote);
 	if (!bases) {
 		base_oid = &null_oid;
-		base_tree_oid = &empty_tree_oid;
+		base_tree_oid = current_hash->empty_tree;
 		if (o->verbosity >= 4)
 			printf("No merge base found; doing history-less merge\n");
 	} else if (!bases->next) {
diff --git a/sequencer.c b/sequencer.c
index f5e85a398d..86961a29cb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -345,7 +345,7 @@ static int read_oneliner(struct strbuf *buf,
 
 static struct tree *empty_tree(void)
 {
-	return lookup_tree(&empty_tree_oid);
+	return lookup_tree(current_hash->empty_tree);
 }
 
 static int error_dirty_index(struct replay_opts *opts)
@@ -703,7 +703,7 @@ static int is_original_commit_empty(struct commit *commit)
 				oid_to_hex(&parent->object.oid));
 		ptree_oid = &parent->tree->object.oid;
 	} else {
-		ptree_oid = &empty_tree_oid; /* commit is root */
+		ptree_oid = current_hash->empty_tree; /* commit is root */
 	}
 
 	return !oidcmp(ptree_oid, &commit->tree->object.oid);
@@ -956,7 +956,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	} else {
 		unborn = get_oid("HEAD", &head);
 		if (unborn)
-			oidcpy(&head, &empty_tree_oid);
+			oidcpy(&head, current_hash->empty_tree);
 		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, 0))
 			return error_dirty_index(opts);
 	}
diff --git a/submodule.c b/submodule.c
index 27de65a4a0..12ad6b1338 100644
--- a/submodule.c
+++ b/submodule.c
@@ -656,7 +656,7 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *o)
 {
-	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
+	const struct object_id *old = current_hash->empty_tree, *new = current_hash->empty_tree;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 	struct strbuf submodule_dir = STRBUF_INIT;
