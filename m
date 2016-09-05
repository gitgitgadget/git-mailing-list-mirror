Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9AB20705
	for <e@80x24.org>; Mon,  5 Sep 2016 20:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964912AbcIEUJs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:09:48 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42992 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964904AbcIEUIb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2B5C7280B7;
        Mon,  5 Sep 2016 20:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106110;
        bh=/vaX4fB1bWcGIarTVAazlWcj5hZRDCo18oK7Rk55rb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6di2AlcO3167JHH7LH2O7xoGBH7eTC+x1+2sD+yUUHEIzZurrWns/301UVTPIu4Q
         Xt7cSiwjdGccIsap07P2o3uZ4uc4R5LGYEyLgGNrSdsERxdVwGmruTRU8oEnH4cRWK
         2GIhcRvLVUCIUN+TptO+06VnNmbtb5/zIQ/mJUXT/kPlDFa/c96gP9RwBxlhaz9L+3
         XUA+jjh0HMDqq97BFS409jvyqtLs2dX0hRqMhMZmMbab1U2Mn6to9TV7BQpl6N/R5M
         6IFtR3QP18AYQA+noHCrhqW7irWbpiMd+RnN2LZpFzv7i7bY4lt+BnvzkztICju/Px
         nZ6EK2kR4e0b1u/2tN4q552Cc767CNfVBc5zs8Zui/6eSpboIO2X1m+QhxXufF4g5B
         oGJ6Qtrzv6MuNYLPQ2I9w/xy1b20ecNx16kZ/O3uTuM3vxRVPv4MIFTelV64k0MMu/
         0BXBYUeQ3LyU1ZMOCwygWOGDRfPlPkeIjSvVOqkV6c6ui/1m6F3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 18/20] builtin/am: convert to struct object_id
Date:   Mon,  5 Sep 2016 20:08:09 +0000
Message-Id: <20160905200811.697889-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert uses of unsigned char [20] to struct object_id.  Rename the
generically-named "ptr" to "old_oid" and make it const.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c | 140 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 739b34dc..1b4829a1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -108,7 +108,7 @@ struct am_state {
 	size_t msg_len;
 
 	/* when --rebasing, records the original commit the patch came from */
-	unsigned char orig_commit[GIT_SHA1_RAWSZ];
+	struct object_id orig_commit;
 
 	/* number of digits in patch filename */
 	int prec;
@@ -428,8 +428,8 @@ static void am_load(struct am_state *state)
 	read_commit_msg(state);
 
 	if (read_state_file(&sb, state, "original-commit", 1) < 0)
-		hashclr(state->orig_commit);
-	else if (get_sha1_hex(sb.buf, state->orig_commit) < 0)
+		oidclr(&state->orig_commit);
+	else if (get_oid_hex(sb.buf, &state->orig_commit) < 0)
 		die(_("could not parse %s"), am_path(state, "original-commit"));
 
 	read_state_file(&sb, state, "threeway", 1);
@@ -555,14 +555,14 @@ static int copy_notes_for_rebase(const struct am_state *state)
 	fp = xfopen(am_path(state, "rewritten"), "r");
 
 	while (!strbuf_getline_lf(&sb, fp)) {
-		unsigned char from_obj[GIT_SHA1_RAWSZ], to_obj[GIT_SHA1_RAWSZ];
+		struct object_id from_obj, to_obj;
 
 		if (sb.len != GIT_SHA1_HEXSZ * 2 + 1) {
 			ret = error(invalid_line, sb.buf);
 			goto finish;
 		}
 
-		if (get_sha1_hex(sb.buf, from_obj)) {
+		if (get_oid_hex(sb.buf, &from_obj)) {
 			ret = error(invalid_line, sb.buf);
 			goto finish;
 		}
@@ -572,14 +572,14 @@ static int copy_notes_for_rebase(const struct am_state *state)
 			goto finish;
 		}
 
-		if (get_sha1_hex(sb.buf + GIT_SHA1_HEXSZ + 1, to_obj)) {
+		if (get_oid_hex(sb.buf + GIT_SHA1_HEXSZ + 1, &to_obj)) {
 			ret = error(invalid_line, sb.buf);
 			goto finish;
 		}
 
-		if (copy_note_for_rewrite(c, from_obj, to_obj))
+		if (copy_note_for_rewrite(c, from_obj.hash, to_obj.hash))
 			ret = error(_("Failed to copy notes from '%s' to '%s'"),
-					sha1_to_hex(from_obj), sha1_to_hex(to_obj));
+					oid_to_hex(&from_obj), oid_to_hex(&to_obj));
 	}
 
 finish:
@@ -985,7 +985,7 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 static void am_setup(struct am_state *state, enum patch_format patch_format,
 			const char **paths, int keep_cr)
 {
-	unsigned char curr_head[GIT_SHA1_RAWSZ];
+	struct object_id curr_head;
 	const char *str;
 	struct strbuf sb = STRBUF_INIT;
 
@@ -1053,10 +1053,10 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	else
 		write_state_text(state, "applying", "");
 
-	if (!get_sha1("HEAD", curr_head)) {
-		write_state_text(state, "abort-safety", sha1_to_hex(curr_head));
+	if (!get_oid("HEAD", &curr_head)) {
+		write_state_text(state, "abort-safety", oid_to_hex(&curr_head));
 		if (!state->rebasing)
-			update_ref("am", "ORIG_HEAD", curr_head, NULL, 0,
+			update_ref_oid("am", "ORIG_HEAD", &curr_head, NULL, 0,
 					UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		write_state_text(state, "abort-safety", "");
@@ -1081,7 +1081,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
  */
 static void am_next(struct am_state *state)
 {
-	unsigned char head[GIT_SHA1_RAWSZ];
+	struct object_id head;
 
 	free(state->author_name);
 	state->author_name = NULL;
@@ -1099,11 +1099,11 @@ static void am_next(struct am_state *state)
 	unlink(am_path(state, "author-script"));
 	unlink(am_path(state, "final-commit"));
 
-	hashclr(state->orig_commit);
+	oidclr(&state->orig_commit);
 	unlink(am_path(state, "original-commit"));
 
-	if (!get_sha1("HEAD", head))
-		write_state_text(state, "abort-safety", sha1_to_hex(head));
+	if (!get_oid("HEAD", &head))
+		write_state_text(state, "abort-safety", oid_to_hex(&head));
 	else
 		write_state_text(state, "abort-safety", "");
 
@@ -1145,17 +1145,17 @@ static void refresh_and_write_cache(void)
  */
 static int index_has_changes(struct strbuf *sb)
 {
-	unsigned char head[GIT_SHA1_RAWSZ];
+	struct object_id head;
 	int i;
 
-	if (!get_sha1_tree("HEAD", head)) {
+	if (!get_sha1_tree("HEAD", head.hash)) {
 		struct diff_options opt;
 
 		diff_setup(&opt);
 		DIFF_OPT_SET(&opt, EXIT_WITH_STATUS);
 		if (!sb)
 			DIFF_OPT_SET(&opt, QUICK);
-		do_diff_cache(head, &opt);
+		do_diff_cache(head.hash, &opt);
 		diffcore_std(&opt);
 		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
 			if (i)
@@ -1362,7 +1362,7 @@ static int parse_mail(struct am_state *state, const char *mail)
  * Sets commit_id to the commit hash where the mail was generated from.
  * Returns 0 on success, -1 on failure.
  */
-static int get_mail_commit_sha1(unsigned char *commit_id, const char *mail)
+static int get_mail_commit_oid(struct object_id *commit_id, const char *mail)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *fp = xfopen(mail, "r");
@@ -1374,7 +1374,7 @@ static int get_mail_commit_sha1(unsigned char *commit_id, const char *mail)
 	if (!skip_prefix(sb.buf, "From ", &x))
 		return -1;
 
-	if (get_sha1_hex(x, commit_id) < 0)
+	if (get_oid_hex(x, commit_id) < 0)
 		return -1;
 
 	strbuf_release(&sb);
@@ -1464,12 +1464,12 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 static void write_index_patch(const struct am_state *state)
 {
 	struct tree *tree;
-	unsigned char head[GIT_SHA1_RAWSZ];
+	struct object_id head;
 	struct rev_info rev_info;
 	FILE *fp;
 
-	if (!get_sha1_tree("HEAD", head))
-		tree = lookup_tree(head);
+	if (!get_sha1_tree("HEAD", head.hash))
+		tree = lookup_tree(head.hash);
 	else
 		tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
 
@@ -1499,19 +1499,19 @@ static void write_index_patch(const struct am_state *state)
 static int parse_mail_rebase(struct am_state *state, const char *mail)
 {
 	struct commit *commit;
-	unsigned char commit_sha1[GIT_SHA1_RAWSZ];
+	struct object_id commit_oid;
 
-	if (get_mail_commit_sha1(commit_sha1, mail) < 0)
+	if (get_mail_commit_oid(&commit_oid, mail) < 0)
 		die(_("could not parse %s"), mail);
 
-	commit = lookup_commit_or_die(commit_sha1, mail);
+	commit = lookup_commit_or_die(commit_oid.hash, mail);
 
 	get_commit_info(state, commit);
 
 	write_commit_patch(state, commit);
 
-	hashcpy(state->orig_commit, commit_sha1);
-	write_state_text(state, "original-commit", sha1_to_hex(commit_sha1));
+	oidcpy(&state->orig_commit, &commit_oid);
+	write_state_text(state, "original-commit", oid_to_hex(&commit_oid));
 
 	return 0;
 }
@@ -1665,9 +1665,8 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  */
 static void do_commit(const struct am_state *state)
 {
-	unsigned char tree[GIT_SHA1_RAWSZ], parent[GIT_SHA1_RAWSZ],
-		      commit[GIT_SHA1_RAWSZ];
-	unsigned char *ptr;
+	struct object_id tree, parent, commit;
+	const struct object_id *old_oid;
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author;
 	struct strbuf sb = STRBUF_INIT;
@@ -1675,14 +1674,14 @@ static void do_commit(const struct am_state *state)
 	if (run_hook_le(NULL, "pre-applypatch", NULL))
 		exit(1);
 
-	if (write_cache_as_tree(tree, 0, NULL))
+	if (write_cache_as_tree(tree.hash, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
-	if (!get_sha1_commit("HEAD", parent)) {
-		ptr = parent;
-		commit_list_insert(lookup_commit(parent), &parents);
+	if (!get_sha1_commit("HEAD", parent.hash)) {
+		old_oid = &parent;
+		commit_list_insert(lookup_commit(parent.hash), &parents);
 	} else {
-		ptr = NULL;
+		old_oid = NULL;
 		say(state, stderr, _("applying to an empty history"));
 	}
 
@@ -1694,7 +1693,7 @@ static void do_commit(const struct am_state *state)
 		setenv("GIT_COMMITTER_DATE",
 			state->ignore_date ? "" : state->author_date, 1);
 
-	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
+	if (commit_tree(state->msg, state->msg_len, tree.hash, parents, commit.hash,
 				author, state->sign_commit))
 		die(_("failed to write commit object"));
 
@@ -1705,14 +1704,15 @@ static void do_commit(const struct am_state *state)
 	strbuf_addf(&sb, "%s: %.*s", reflog_msg, linelen(state->msg),
 			state->msg);
 
-	update_ref(sb.buf, "HEAD", commit, ptr, 0, UPDATE_REFS_DIE_ON_ERR);
+	update_ref_oid(sb.buf, "HEAD", &commit, old_oid, 0,
+			UPDATE_REFS_DIE_ON_ERR);
 
 	if (state->rebasing) {
 		FILE *fp = xfopen(am_path(state, "rewritten"), "a");
 
-		assert(!is_null_sha1(state->orig_commit));
-		fprintf(fp, "%s ", sha1_to_hex(state->orig_commit));
-		fprintf(fp, "%s\n", sha1_to_hex(commit));
+		assert(!is_null_oid(&state->orig_commit));
+		fprintf(fp, "%s ", oid_to_hex(&state->orig_commit));
+		fprintf(fp, "%s\n", oid_to_hex(&commit));
 		fclose(fp);
 	}
 
@@ -2033,30 +2033,30 @@ static int merge_tree(struct tree *tree)
  * Clean the index without touching entries that are not modified between
  * `head` and `remote`.
  */
-static int clean_index(const unsigned char *head, const unsigned char *remote)
+static int clean_index(const struct object_id *head, const struct object_id *remote)
 {
 	struct tree *head_tree, *remote_tree, *index_tree;
-	unsigned char index[GIT_SHA1_RAWSZ];
+	struct object_id index;
 
-	head_tree = parse_tree_indirect(head);
+	head_tree = parse_tree_indirect(head->hash);
 	if (!head_tree)
-		return error(_("Could not parse object '%s'."), sha1_to_hex(head));
+		return error(_("Could not parse object '%s'."), oid_to_hex(head));
 
-	remote_tree = parse_tree_indirect(remote);
+	remote_tree = parse_tree_indirect(remote->hash);
 	if (!remote_tree)
-		return error(_("Could not parse object '%s'."), sha1_to_hex(remote));
+		return error(_("Could not parse object '%s'."), oid_to_hex(remote));
 
 	read_cache_unmerged();
 
 	if (fast_forward_to(head_tree, head_tree, 1))
 		return -1;
 
-	if (write_cache_as_tree(index, 0, NULL))
+	if (write_cache_as_tree(index.hash, 0, NULL))
 		return -1;
 
-	index_tree = parse_tree_indirect(index);
+	index_tree = parse_tree_indirect(index.hash);
 	if (!index_tree)
-		return error(_("Could not parse object '%s'."), sha1_to_hex(index));
+		return error(_("Could not parse object '%s'."), oid_to_hex(&index));
 
 	if (fast_forward_to(index_tree, remote_tree, 0))
 		return -1;
@@ -2084,14 +2084,14 @@ static void am_rerere_clear(void)
  */
 static void am_skip(struct am_state *state)
 {
-	unsigned char head[GIT_SHA1_RAWSZ];
+	struct object_id head;
 
 	am_rerere_clear();
 
-	if (get_sha1("HEAD", head))
-		hashcpy(head, EMPTY_TREE_SHA1_BIN);
+	if (get_oid("HEAD", &head))
+		hashcpy(head.hash, EMPTY_TREE_SHA1_BIN);
 
-	if (clean_index(head, head))
+	if (clean_index(&head, &head))
 		die(_("failed to clean index"));
 
 	am_next(state);
@@ -2109,21 +2109,21 @@ static void am_skip(struct am_state *state)
 static int safe_to_abort(const struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
-	unsigned char abort_safety[GIT_SHA1_RAWSZ], head[GIT_SHA1_RAWSZ];
+	struct object_id abort_safety, head;
 
 	if (file_exists(am_path(state, "dirtyindex")))
 		return 0;
 
 	if (read_state_file(&sb, state, "abort-safety", 1) > 0) {
-		if (get_sha1_hex(sb.buf, abort_safety))
+		if (get_oid_hex(sb.buf, &abort_safety))
 			die(_("could not parse %s"), am_path(state, "abort_safety"));
 	} else
-		hashclr(abort_safety);
+		oidclr(&abort_safety);
 
-	if (get_sha1("HEAD", head))
-		hashclr(head);
+	if (get_oid("HEAD", &head))
+		oidclr(&head);
 
-	if (!hashcmp(head, abort_safety))
+	if (!oidcmp(&head, &abort_safety))
 		return 1;
 
 	error(_("You seem to have moved HEAD since the last 'am' failure.\n"
@@ -2137,7 +2137,7 @@ static int safe_to_abort(const struct am_state *state)
  */
 static void am_abort(struct am_state *state)
 {
-	unsigned char curr_head[GIT_SHA1_RAWSZ], orig_head[GIT_SHA1_RAWSZ];
+	struct object_id curr_head, orig_head;
 	int has_curr_head, has_orig_head;
 	char *curr_branch;
 
@@ -2148,20 +2148,20 @@ static void am_abort(struct am_state *state)
 
 	am_rerere_clear();
 
-	curr_branch = resolve_refdup("HEAD", 0, curr_head, NULL);
-	has_curr_head = !is_null_sha1(curr_head);
+	curr_branch = resolve_refdup("HEAD", 0, curr_head.hash, NULL);
+	has_curr_head = !is_null_oid(&curr_head);
 	if (!has_curr_head)
-		hashcpy(curr_head, EMPTY_TREE_SHA1_BIN);
+		hashcpy(curr_head.hash, EMPTY_TREE_SHA1_BIN);
 
-	has_orig_head = !get_sha1("ORIG_HEAD", orig_head);
+	has_orig_head = !get_oid("ORIG_HEAD", &orig_head);
 	if (!has_orig_head)
-		hashcpy(orig_head, EMPTY_TREE_SHA1_BIN);
+		hashcpy(orig_head.hash, EMPTY_TREE_SHA1_BIN);
 
-	clean_index(curr_head, orig_head);
+	clean_index(&curr_head, &orig_head);
 
 	if (has_orig_head)
-		update_ref("am --abort", "HEAD", orig_head,
-				has_curr_head ? curr_head : NULL, 0,
+		update_ref_oid("am --abort", "HEAD", &orig_head,
+				has_curr_head ? &curr_head : NULL, 0,
 				UPDATE_REFS_DIE_ON_ERR);
 	else if (curr_branch)
 		delete_ref(curr_branch, NULL, REF_NODEREF);
