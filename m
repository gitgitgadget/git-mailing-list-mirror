Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563772055E
	for <e@80x24.org>; Sat, 28 Oct 2017 18:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdJ1SQF (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 14:16:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55562 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751465AbdJ1SQA (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 14:16:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 46D266044B;
        Sat, 28 Oct 2017 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509214559;
        bh=WNAInnDDPCZhs1B5DncdDnGrYBfh5WF0gAJE5Xobx2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=H2mCVfImpntir1qIk5byNS+Sp5wwY7whkXVUyDVpeSR7v75TgDAiYa+dnWzzsjA5Q
         XeuJoNAnrNyZBtRcHH8DtLpMzQrphpBLPeAPWm+OtSWQDV9TPsqMK3MdYdYzU9Xf5B
         1yByVIVBz1EzzTHgX3cVHmI5muZyrR/Xb3/Txn4aJhGqIFUOIQwt+TBNqAIVBcYtiM
         QVCf/7NvPD4ZKjLc5OYfCgUmj09nEo26PFCCBAIXEpEnkWBFIWK3fu3UFJJZ9JO15Y
         k4fvpHgbVdvdpzfXgNlnQWldF5hSQ/E/kjh3EuPGQudLLpxqBKH6Q01tCk8yv0gXPa
         DD59Hb4z6CAF9kQp3NRiEkKDKhi0pC/QKX15TJGGu5RTjop0upIrwN3/YdHUVkiLcz
         dYUGZCn6ijrnTlwWXkSY86JNpFcxCUNpVSzv3K654pmoRjrCjZ1Y5UPMs6es9PzEsX
         /1BWaK79bFy14EzpeQtkFLYRdK4k/ox+g8uwF+ATCc584DiMC+v
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 4/4] Switch empty tree and blob lookups to use hash abstraction
Date:   Sat, 28 Oct 2017 18:12:39 +0000
Message-Id: <20171028181239.59458-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc2
In-Reply-To: <20171028181239.59458-1-sandals@crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
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
index d7513f5375..7f71974b79 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1433,7 +1433,7 @@ static void write_index_patch(const struct am_state *state)
 	if (!get_oid_tree("HEAD", &head))
 		tree = lookup_tree(&head);
 	else
-		tree = lookup_tree(&empty_tree_oid);
+		tree = lookup_tree(current_hash->empty_tree);
 
 	fp = xfopen(am_path(state, "patch"), "w");
 	init_revisions(&rev_info, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index fc4f8fd2ea..e7878fa62e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -516,7 +516,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 		tree = parse_tree_indirect(old->commit ?
 					   &old->commit->object.oid :
-					   &empty_tree_oid);
+					   current_hash->empty_tree);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
 		tree = parse_tree_indirect(&new->commit->object.oid);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
diff --git a/builtin/diff.c b/builtin/diff.c
index f5bbd4d757..2419de1770 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -380,7 +380,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				add_head_to_pending(&rev);
 				if (!rev.pending.nr) {
 					struct tree *tree;
-					tree = lookup_tree(&empty_tree_oid);
+					tree = lookup_tree(current_hash->empty_tree);
 					add_pending_object(&rev, &tree->object, "HEAD");
 				}
 				break;
diff --git a/builtin/pull.c b/builtin/pull.c
index 6f772e8a22..7bb96cb5a0 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -541,7 +541,7 @@ static int pull_into_void(const struct object_id *merge_head,
 	 * index/worktree changes that the user already made on the unborn
 	 * branch.
 	 */
-	if (checkout_fast_forward(&empty_tree_oid, merge_head, 0))
+	if (checkout_fast_forward(current_hash->empty_tree, merge_head, 0))
 		return 1;
 
 	if (update_ref("initial pull", "HEAD", merge_head->hash, curr_head->hash, 0, UPDATE_REFS_DIE_ON_ERR))
diff --git a/cache.h b/cache.h
index bce57c74c4..28906468fa 100644
--- a/cache.h
+++ b/cache.h
@@ -1056,22 +1056,22 @@ extern const struct object_id empty_blob_oid;
 
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
index 4e0980caa8..b5d95ea5c3 100644
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
index 1d3f8f0d22..4547e15b8c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2081,7 +2081,7 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(&empty_tree_oid);
+		tree = lookup_tree(current_hash->empty_tree);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/notes-merge.c b/notes-merge.c
index 4352c34a6e..aab27121cb 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -595,7 +595,7 @@ int notes_merge(struct notes_merge_options *o,
 	bases = get_merge_bases(local, remote);
 	if (!bases) {
 		base_oid = &null_oid;
-		base_tree_oid = &empty_tree_oid;
+		base_tree_oid = current_hash->empty_tree;
 		if (o->verbosity >= 4)
 			printf("No merge base found; doing history-less merge\n");
 	} else if (!bases->next) {
diff --git a/sequencer.c b/sequencer.c
index f2a10cc4f2..b910165a82 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -347,7 +347,7 @@ static int read_oneliner(struct strbuf *buf,
 
 static struct tree *empty_tree(void)
 {
-	return lookup_tree(&empty_tree_oid);
+	return lookup_tree(current_hash->empty_tree);
 }
 
 static int error_dirty_index(struct replay_opts *opts)
@@ -705,7 +705,7 @@ static int is_original_commit_empty(struct commit *commit)
 				oid_to_hex(&parent->object.oid));
 		ptree_oid = &parent->tree->object.oid;
 	} else {
-		ptree_oid = &empty_tree_oid; /* commit is root */
+		ptree_oid = current_hash->empty_tree; /* commit is root */
 	}
 
 	return !oidcmp(ptree_oid, &commit->tree->object.oid);
@@ -958,7 +958,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	} else {
 		unborn = get_oid("HEAD", &head);
 		if (unborn)
-			oidcpy(&head, &empty_tree_oid);
+			oidcpy(&head, current_hash->empty_tree);
 		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, 0))
 			return error_dirty_index(opts);
 	}
diff --git a/submodule.c b/submodule.c
index 63e7094e16..218cbf6227 100644
--- a/submodule.c
+++ b/submodule.c
@@ -587,7 +587,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule)
 {
-	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
+	const struct object_id *old = current_hash->empty_tree, *new = current_hash->empty_tree;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
-- 
2.15.0.rc2

