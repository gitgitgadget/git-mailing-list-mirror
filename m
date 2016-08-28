Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE811F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932510AbcH1X2w (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:52 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41044 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756089AbcH1X2G (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 561FF280B0;
        Sun, 28 Aug 2016 23:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426884;
        bh=QNkaRLzm6DJ5e3XyeoUYILbolXS5n6vYC9Yc0oJZD+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLvFWE3NYnSnO5hpQzswQwchnyprZjYqPvrPCHORqyWNbfyLcel9WjRU50X9YjlSb
         UaNyH0ypjTIJ951HP8STTvc/1SgON55rNlqnuMlE5QCcEl3bgtAVuif7CbZCmnycXP
         NSEJTi5VqDUu45847LOV9m5Ao/0CYep8qYmn1TQpVKY6VEnC4UR0PZ2nIe3KzNOaoi
         seg4NEQ0XzIQgCyrsXrKQ/hASs6TE89CX1jxXsmeq4OVB0H8On7UjQhedV461/d1Hk
         0Lmkyko0YftESwEhO55Dm2jX265WyG66F07Llagb6CmV7vDEQ5bP52Kld91lxxersM
         d5BYiwbZ5v44+OMAZfpe/Dj9cLuPtPoT5WIQ+yFD4F0QzjHF5vbnVos+JSWnRRQJTn
         53ksnZtwizMywi65lDzwIvv2yV6g+aOV7QgCLr1eCIZvZExzIZwyXRhbT4fEPHdeKy
         jgS03DjmCx27EOya2rv2FWA118yswblebXtXLc9T0poG40E5blY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 09/20] builtin/checkout: convert some static functions to struct object_id
Date:   Sun, 28 Aug 2016 23:27:46 +0000
Message-Id: <20160828232757.373278-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all the static functions that are not callbacks to struct
object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/checkout.c | 66 +++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9523ffa..ec85af56 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -175,9 +175,9 @@ static int checkout_merged(int pos, struct checkout *state)
 	const char *path = ce->name;
 	mmfile_t ancestor, ours, theirs;
 	int status;
-	unsigned char sha1[20];
+	struct object_id oid;
 	mmbuffer_t result_buf;
-	unsigned char threeway[3][20];
+	struct object_id threeway[3];
 	unsigned mode = 0;
 
 	memset(threeway, 0, sizeof(threeway));
@@ -186,18 +186,18 @@ static int checkout_merged(int pos, struct checkout *state)
 		stage = ce_stage(ce);
 		if (!stage || strcmp(path, ce->name))
 			break;
-		hashcpy(threeway[stage - 1], ce->oid.hash);
+		oidcpy(&threeway[stage - 1], &ce->oid);
 		if (stage == 2)
 			mode = create_ce_mode(ce->ce_mode);
 		pos++;
 		ce = active_cache[pos];
 	}
-	if (is_null_sha1(threeway[1]) || is_null_sha1(threeway[2]))
+	if (is_null_oid(&threeway[1]) || is_null_oid(&threeway[2]))
 		return error(_("path '%s' does not have necessary versions"), path);
 
-	read_mmblob(&ancestor, threeway[0]);
-	read_mmblob(&ours, threeway[1]);
-	read_mmblob(&theirs, threeway[2]);
+	read_mmblob(&ancestor, threeway[0].hash);
+	read_mmblob(&ours, threeway[1].hash);
+	read_mmblob(&theirs, threeway[2].hash);
 
 	/*
 	 * NEEDSWORK: re-create conflicts from merges with
@@ -226,9 +226,9 @@ static int checkout_merged(int pos, struct checkout *state)
 	 * object database even when it may contain conflicts).
 	 */
 	if (write_sha1_file(result_buf.ptr, result_buf.size,
-			    blob_type, sha1))
+			    blob_type, oid.hash))
 		die(_("Unable to add merge result for '%s'"), path);
-	ce = make_cache_entry(mode, sha1, path, 2, 0);
+	ce = make_cache_entry(mode, oid.hash, path, 2, 0);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
@@ -241,7 +241,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	int pos;
 	struct checkout state;
 	static char *ps_matched;
-	unsigned char rev[20];
+	struct object_id rev;
 	struct commit *head;
 	int errs = 0;
 	struct lock_file *lock_file;
@@ -374,8 +374,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	read_ref_full("HEAD", 0, rev, NULL);
-	head = lookup_commit_reference_gently(rev, 1);
+	read_ref_full("HEAD", 0, rev.hash, NULL);
+	head = lookup_commit_reference_gently(rev.hash, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
 	return errs;
@@ -808,11 +808,11 @@ static int switch_branches(const struct checkout_opts *opts,
 	int ret = 0;
 	struct branch_info old;
 	void *path_to_free;
-	unsigned char rev[20];
+	struct object_id rev;
 	int flag, writeout_error = 0;
 	memset(&old, 0, sizeof(old));
-	old.path = path_to_free = resolve_refdup("HEAD", 0, rev, &flag);
-	old.commit = lookup_commit_reference_gently(rev, 1);
+	old.path = path_to_free = resolve_refdup("HEAD", 0, rev.hash, &flag);
+	old.commit = lookup_commit_reference_gently(rev.hash, 1);
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
 
@@ -860,7 +860,7 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 struct tracking_name_data {
 	/* const */ char *src_ref;
 	char *dst_ref;
-	unsigned char *dst_sha1;
+	struct object_id *dst_oid;
 	int unique;
 };
 
@@ -871,7 +871,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	memset(&query, 0, sizeof(struct refspec));
 	query.src = cb->src_ref;
 	if (remote_find_tracking(remote, &query) ||
-	    get_sha1(query.dst, cb->dst_sha1)) {
+	    get_oid(query.dst, cb->dst_oid)) {
 		free(query.dst);
 		return 0;
 	}
@@ -884,13 +884,13 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	return 0;
 }
 
-static const char *unique_tracking_name(const char *name, unsigned char *sha1)
+static const char *unique_tracking_name(const char *name, struct object_id *oid)
 {
 	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
 	char src_ref[PATH_MAX];
 	snprintf(src_ref, PATH_MAX, "refs/heads/%s", name);
 	cb_data.src_ref = src_ref;
-	cb_data.dst_sha1 = sha1;
+	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	if (cb_data.unique)
 		return cb_data.dst_ref;
@@ -902,12 +902,12 @@ static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
 				struct checkout_opts *opts,
-				unsigned char rev[20])
+				struct object_id *rev)
 {
 	struct tree **source_tree = &opts->source_tree;
 	const char **new_branch = &opts->new_branch;
 	int argcount = 0;
-	unsigned char branch_rev[20];
+	struct object_id branch_rev;
 	const char *arg;
 	int dash_dash_pos;
 	int has_dash_dash = 0;
@@ -973,7 +973,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
 
-	if (get_sha1_mb(arg, rev)) {
+	if (get_sha1_mb(arg, rev->hash)) {
 		/*
 		 * Either case (3) or (4), with <something> not being
 		 * a commit, or an attempt to use case (1) with an
@@ -1022,15 +1022,15 @@ static int parse_branchname_arg(int argc, const char **argv,
 	setup_branch_path(new);
 
 	if (!check_refname_format(new->path, 0) &&
-	    !read_ref(new->path, branch_rev))
-		hashcpy(rev, branch_rev);
+	    !read_ref(new->path, branch_rev.hash))
+		oidcpy(rev, &branch_rev);
 	else
 		new->path = NULL; /* not an existing branch */
 
-	new->commit = lookup_commit_reference_gently(rev, 1);
+	new->commit = lookup_commit_reference_gently(rev->hash, 1);
 	if (!new->commit) {
 		/* not a commit */
-		*source_tree = parse_tree_indirect(rev);
+		*source_tree = parse_tree_indirect(rev->hash);
 	} else {
 		parse_commit_or_die(new->commit);
 		*source_tree = new->commit->tree;
@@ -1108,9 +1108,9 @@ static int checkout_branch(struct checkout_opts *opts,
 
 	if (new->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		int flag;
-		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
+		char *head_ref = resolve_refdup("HEAD", 0, oid.hash, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
 			die_if_checked_out(new->path, 1);
@@ -1118,11 +1118,11 @@ static int checkout_branch(struct checkout_opts *opts,
 	}
 
 	if (!new->commit && opts->new_branch) {
-		unsigned char rev[20];
+		struct object_id rev;
 		int flag;
 
-		if (!read_ref_full("HEAD", 0, rev, &flag) &&
-		    (flag & REF_ISSYMREF) && is_null_sha1(rev))
+		if (!read_ref_full("HEAD", 0, rev.hash, &flag) &&
+		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
 			return switch_unborn_to_new_branch(opts);
 	}
 	return switch_branches(opts, new);
@@ -1232,14 +1232,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 * remote branches, erroring out for invalid or ambiguous cases.
 	 */
 	if (argc) {
-		unsigned char rev[20];
+		struct object_id rev;
 		int dwim_ok =
 			!opts.patch_mode &&
 			dwim_new_local_branch &&
 			opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new, &opts, rev);
+					     &new, &opts, &rev);
 		argv += n;
 		argc -= n;
 	}
