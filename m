Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC1A1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 02:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdBNCcW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 21:32:22 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50636 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751288AbdBNCcS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Feb 2017 21:32:18 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7B6AD280B6;
        Tue, 14 Feb 2017 02:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487039517;
        bh=1P5AvTcxuCjxR7ddM0V5rRYw2iKGw1YCNipZ3aN/94Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKF7zchcuLB21aLP2HfHjEfXBYX94/ZxyMC50+iusX812iXlc4Krng7X+fVp7S+EC
         Co7LOiukjDxe3ryrwPQz/YPtXh3AqYpZexNsOxuM0vRjRwCDFuPUdAwl0pnolfVkjV
         qvjcyMORtgR6gCQsRF9wU96NLwD8ZXoh5X1zmIZCdFO4OAd4Hjled60W3F/i3nMTQc
         qkwWewXJpE49Tab3o7RMenao83I0JlFOCiQ2RG7FITtatPwovgIvE4os8tqb0JzdE4
         PGs9uRFOcrIHUj6+PaQsNnSBsjp3SMe0ORF7xNFh+TIHqzAE4Qa7NH+dn4uYCd/wUF
         rC50uPzwkS0HvvNmP4hRMzVqxajph2NL9MtEfhVTZ6dOnuWJpooPxHPLbwv2+bFMh3
         nLdUF7nnz8eXbxo+vd0vEiHSyGnQdAxkPwZcZw8pKKmsK6sByzRBVeaky4EQp1KH8Z
         +uLekAe68XJORjQroiz+broQvOlSIhHts9vbHzivc4/h1CNVHxd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/19] builtin/merge: convert to struct object_id
Date:   Tue, 14 Feb 2017 02:31:31 +0000
Message-Id: <20170214023141.842922-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170214023141.842922-1-sandals@crustytoothpaste.net>
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Additionally convert several uses of the constant 40 into
GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge.c | 134 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 66 insertions(+), 68 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a96d4fb501..099cfab447 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -244,7 +244,7 @@ static void drop_save(void)
 	unlink(git_path_merge_mode());
 }
 
-static int save_state(unsigned char *stash)
+static int save_state(struct object_id *stash)
 {
 	int len;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -265,7 +265,7 @@ static int save_state(unsigned char *stash)
 	else if (!len)		/* no changes */
 		return -1;
 	strbuf_setlen(&buffer, buffer.len-1);
-	if (get_sha1(buffer.buf, stash))
+	if (get_oid(buffer.buf, stash))
 		die(_("not a valid object: %s"), buffer.buf);
 	return 0;
 }
@@ -305,18 +305,18 @@ static void reset_hard(unsigned const char *sha1, int verbose)
 		die(_("read-tree failed"));
 }
 
-static void restore_state(const unsigned char *head,
-			  const unsigned char *stash)
+static void restore_state(const struct object_id *head,
+			  const struct object_id *stash)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
 
-	if (is_null_sha1(stash))
+	if (is_null_oid(stash))
 		return;
 
-	reset_hard(head, 1);
+	reset_hard(head->hash, 1);
 
-	args[2] = sha1_to_hex(stash);
+	args[2] = oid_to_hex(stash);
 
 	/*
 	 * It is OK to ignore error here, for example when there was
@@ -376,10 +376,10 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 
 static void finish(struct commit *head_commit,
 		   struct commit_list *remoteheads,
-		   const unsigned char *new_head, const char *msg)
+		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
-	const unsigned char *head = head_commit->object.oid.hash;
+	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
@@ -397,7 +397,7 @@ static void finish(struct commit *head_commit,
 		else {
 			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
 			update_ref(reflog_message.buf, "HEAD",
-				new_head, head, 0,
+				new_head->hash, head->hash, 0,
 				UPDATE_REFS_DIE_ON_ERR);
 			/*
 			 * We ignore errors in 'gc --auto', since the
@@ -416,7 +416,7 @@ static void finish(struct commit *head_commit,
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename = DIFF_DETECT_RENAME;
 		diff_setup_done(&opts);
-		diff_tree_sha1(head, new_head, "", &opts);
+		diff_tree_sha1(head->hash, new_head->hash, "", &opts);
 		diffcore_std(&opts);
 		diff_flush(&opts);
 	}
@@ -431,7 +431,7 @@ static void finish(struct commit *head_commit,
 static void merge_name(const char *remote, struct strbuf *msg)
 {
 	struct commit *remote_head;
-	unsigned char branch_head[20];
+	struct object_id branch_head;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf bname = STRBUF_INIT;
 	const char *ptr;
@@ -441,25 +441,25 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	strbuf_branchname(&bname, remote);
 	remote = bname.buf;
 
-	memset(branch_head, 0, sizeof(branch_head));
+	oidclr(&branch_head);
 	remote_head = get_merge_parent(remote);
 	if (!remote_head)
 		die(_("'%s' does not point to a commit"), remote);
 
-	if (dwim_ref(remote, strlen(remote), branch_head, &found_ref) > 0) {
+	if (dwim_ref(remote, strlen(remote), branch_head.hash, &found_ref) > 0) {
 		if (starts_with(found_ref, "refs/heads/")) {
 			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
-				    sha1_to_hex(branch_head), remote);
+				    oid_to_hex(&branch_head), remote);
 			goto cleanup;
 		}
 		if (starts_with(found_ref, "refs/tags/")) {
 			strbuf_addf(msg, "%s\t\ttag '%s' of .\n",
-				    sha1_to_hex(branch_head), remote);
+				    oid_to_hex(&branch_head), remote);
 			goto cleanup;
 		}
 		if (starts_with(found_ref, "refs/remotes/")) {
 			strbuf_addf(msg, "%s\t\tremote-tracking branch '%s' of .\n",
-				    sha1_to_hex(branch_head), remote);
+				    oid_to_hex(&branch_head), remote);
 			goto cleanup;
 		}
 	}
@@ -590,8 +590,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	return git_diff_ui_config(k, v, cb);
 }
 
-static int read_tree_trivial(unsigned char *common, unsigned char *head,
-			     unsigned char *one)
+static int read_tree_trivial(struct object_id *common, struct object_id *head,
+			     struct object_id *one)
 {
 	int i, nr_trees = 0;
 	struct tree *trees[MAX_UNPACK_TREES];
@@ -606,13 +606,13 @@ static int read_tree_trivial(unsigned char *common, unsigned char *head,
 	opts.verbose_update = 1;
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
-	trees[nr_trees] = parse_tree_indirect(common);
+	trees[nr_trees] = parse_tree_indirect(common->hash);
 	if (!trees[nr_trees++])
 		return -1;
-	trees[nr_trees] = parse_tree_indirect(head);
+	trees[nr_trees] = parse_tree_indirect(head->hash);
 	if (!trees[nr_trees++])
 		return -1;
-	trees[nr_trees] = parse_tree_indirect(one);
+	trees[nr_trees] = parse_tree_indirect(one->hash);
 	if (!trees[nr_trees++])
 		return -1;
 	opts.fn = threeway_merge;
@@ -626,9 +626,9 @@ static int read_tree_trivial(unsigned char *common, unsigned char *head,
 	return 0;
 }
 
-static void write_tree_trivial(unsigned char *sha1)
+static void write_tree_trivial(struct object_id *oid)
 {
-	if (write_cache_as_tree(sha1, 0, NULL))
+	if (write_cache_as_tree(oid->hash, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 }
 
@@ -781,7 +781,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 
 static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 {
-	unsigned char result_tree[20], result_commit[20];
+	struct object_id result_tree, result_commit;
 	struct commit_list *parents, **pptr = &parents;
 	static struct lock_file lock;
 
@@ -792,15 +792,15 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 		return error(_("Unable to write index."));
 	rollback_lock_file(&lock);
 
-	write_tree_trivial(result_tree);
+	write_tree_trivial(&result_tree);
 	printf(_("Wonderful.\n"));
 	pptr = commit_list_append(head, pptr);
 	pptr = commit_list_append(remoteheads->item, pptr);
 	prepare_to_commit(remoteheads);
-	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
-			result_commit, NULL, sign_commit))
+	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree.hash, parents,
+			result_commit.hash, NULL, sign_commit))
 		die(_("failed to write commit object"));
-	finish(head, remoteheads, result_commit, "In-index merge");
+	finish(head, remoteheads, &result_commit, "In-index merge");
 	drop_save();
 	return 0;
 }
@@ -809,12 +809,12 @@ static int finish_automerge(struct commit *head,
 			    int head_subsumed,
 			    struct commit_list *common,
 			    struct commit_list *remoteheads,
-			    unsigned char *result_tree,
+			    struct object_id *result_tree,
 			    const char *wt_strategy)
 {
 	struct commit_list *parents = NULL;
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char result_commit[20];
+	struct object_id result_commit;
 
 	free_commit_list(common);
 	parents = remoteheads;
@@ -822,11 +822,11 @@ static int finish_automerge(struct commit *head,
 		commit_list_insert(head, &parents);
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
-	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
-			result_commit, NULL, sign_commit))
+	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree->hash, parents,
+			result_commit.hash, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
-	finish(head, remoteheads, result_commit, buf.buf);
+	finish(head, remoteheads, &result_commit, buf.buf);
 	strbuf_release(&buf);
 	drop_save();
 	return 0;
@@ -854,18 +854,18 @@ static int suggest_conflicts(void)
 }
 
 static struct commit *is_old_style_invocation(int argc, const char **argv,
-					      const unsigned char *head)
+					      const struct object_id *head)
 {
 	struct commit *second_token = NULL;
 	if (argc > 2) {
-		unsigned char second_sha1[20];
+		struct object_id second_oid;
 
-		if (get_sha1(argv[1], second_sha1))
+		if (get_oid(argv[1], &second_oid))
 			return NULL;
-		second_token = lookup_commit_reference_gently(second_sha1, 0);
+		second_token = lookup_commit_reference_gently(second_oid.hash, 0);
 		if (!second_token)
 			die(_("'%s' is not a commit"), argv[1]);
-		if (hashcmp(second_token->object.oid.hash, head))
+		if (oidcmp(&second_token->object.oid, head))
 			return NULL;
 	}
 	return second_token;
@@ -1038,7 +1038,7 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 		die_errno(_("could not close '%s'"), filename);
 
 	for (pos = 0; pos < merge_names->len; pos = npos) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		char *ptr;
 		struct commit *commit;
 
@@ -1048,16 +1048,16 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 		else
 			npos = merge_names->len;
 
-		if (npos - pos < 40 + 2 ||
-		    get_sha1_hex(merge_names->buf + pos, sha1))
+		if (npos - pos < GIT_SHA1_HEXSZ + 2 ||
+		    get_oid_hex(merge_names->buf + pos, &oid))
 			commit = NULL; /* bad */
-		else if (memcmp(merge_names->buf + pos + 40, "\t\t", 2))
+		else if (memcmp(merge_names->buf + pos + GIT_SHA1_HEXSZ, "\t\t", 2))
 			continue; /* not-for-merge */
 		else {
-			char saved = merge_names->buf[pos + 40];
-			merge_names->buf[pos + 40] = '\0';
+			char saved = merge_names->buf[pos + GIT_SHA1_HEXSZ];
+			merge_names->buf[pos + GIT_SHA1_HEXSZ] = '\0';
 			commit = get_merge_parent(merge_names->buf + pos);
-			merge_names->buf[pos + 40] = saved;
+			merge_names->buf[pos + GIT_SHA1_HEXSZ] = saved;
 		}
 		if (!commit) {
 			if (ptr)
@@ -1117,9 +1117,7 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
-	unsigned char result_tree[20];
-	unsigned char stash[20];
-	unsigned char head_sha1[20];
+	struct object_id result_tree, stash, head_oid;
 	struct commit *head_commit;
 	struct strbuf buf = STRBUF_INIT;
 	const char *head_arg;
@@ -1138,13 +1136,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch = branch_to_free = resolve_refdup("HEAD", 0, head_sha1, NULL);
+	branch = branch_to_free = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
 	if (branch && starts_with(branch, "refs/heads/"))
 		branch += 11;
-	if (!branch || is_null_sha1(head_sha1))
+	if (!branch || is_null_oid(&head_oid))
 		head_commit = NULL;
 	else
-		head_commit = lookup_commit_or_die(head_sha1, "HEAD");
+		head_commit = lookup_commit_or_die(head_oid.hash, "HEAD");
 
 	init_diff_ui_defaults();
 	git_config(git_merge_config, NULL);
@@ -1242,7 +1240,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * to forbid "git merge" into a branch yet to be born.
 		 * We do the same for "git pull".
 		 */
-		unsigned char *remote_head_sha1;
+		struct object_id *remote_head_oid;
 		if (squash)
 			die(_("Squash commit into empty head not supported yet"));
 		if (fast_forward == FF_NO)
@@ -1254,9 +1252,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die(_("%s - not something we can merge"), argv[0]);
 		if (remoteheads->next)
 			die(_("Can merge only exactly one commit into empty head"));
-		remote_head_sha1 = remoteheads->item->object.oid.hash;
-		read_empty(remote_head_sha1, 0);
-		update_ref("initial pull", "HEAD", remote_head_sha1,
+		remote_head_oid = &remoteheads->item->object.oid;
+		read_empty(remote_head_oid->hash, 0);
+		update_ref("initial pull", "HEAD", remote_head_oid->hash,
 			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 		goto done;
 	}
@@ -1270,7 +1268,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * additional safety measure to check for it.
 	 */
 	if (!have_message &&
-	    is_old_style_invocation(argc, argv, head_commit->object.oid.hash)) {
+	    is_old_style_invocation(argc, argv, &head_commit->object.oid)) {
 		warning("old-style 'git merge <msg> HEAD <commit>' is deprecated.");
 		strbuf_addstr(&merge_msg, argv[0]);
 		head_arg = argv[1];
@@ -1422,7 +1420,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
-		finish(head_commit, remoteheads, commit->object.oid.hash, msg.buf);
+		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
 		drop_save();
 		goto done;
 	} else if (!remoteheads->next && common->next)
@@ -1441,9 +1439,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			/* See if it is really trivial. */
 			git_committer_info(IDENT_STRICT);
 			printf(_("Trying really trivial in-index merge...\n"));
-			if (!read_tree_trivial(common->item->object.oid.hash,
-					       head_commit->object.oid.hash,
-					       remoteheads->item->object.oid.hash)) {
+			if (!read_tree_trivial(&common->item->object.oid,
+					       &head_commit->object.oid,
+					       &remoteheads->item->object.oid)) {
 				ret = merge_trivial(head_commit, remoteheads);
 				goto done;
 			}
@@ -1495,14 +1493,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	    /*
 	     * Stash away the local changes so that we can try more than one.
 	     */
-	    save_state(stash))
-		hashclr(stash);
+	    save_state(&stash))
+		oidclr(&stash);
 
 	for (i = 0; i < use_strategies_nr; i++) {
 		int ret;
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
-			restore_state(head_commit->object.oid.hash, stash);
+			restore_state(&head_commit->object.oid, &stash);
 		}
 		if (use_strategies_nr != 1)
 			printf(_("Trying merge strategy %s...\n"),
@@ -1547,7 +1545,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 
 		/* Automerge succeeded. */
-		write_tree_trivial(result_tree);
+		write_tree_trivial(&result_tree);
 		automerge_was_ok = 1;
 		break;
 	}
@@ -1559,7 +1557,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (automerge_was_ok) {
 		ret = finish_automerge(head_commit, head_subsumed,
 				       common, remoteheads,
-				       result_tree, wt_strategy);
+				       &result_tree, wt_strategy);
 		goto done;
 	}
 
@@ -1568,7 +1566,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * it up.
 	 */
 	if (!best_strategy) {
-		restore_state(head_commit->object.oid.hash, stash);
+		restore_state(&head_commit->object.oid, &stash);
 		if (use_strategies_nr > 1)
 			fprintf(stderr,
 				_("No merge strategy handled the merge.\n"));
@@ -1581,7 +1579,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		; /* We already have its result in the working tree. */
 	else {
 		printf(_("Rewinding the tree to pristine...\n"));
-		restore_state(head_commit->object.oid.hash, stash);
+		restore_state(&head_commit->object.oid, &stash);
 		printf(_("Using the %s to prepare resolving by hand.\n"),
 			best_strategy);
 		try_merge_strategy(best_strategy, common, remoteheads,
-- 
2.11.0

