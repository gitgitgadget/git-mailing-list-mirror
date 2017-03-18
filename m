Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90C72095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbdCRVWi (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:22:38 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46152 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751115AbdCRVWe (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:22:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B74AF280BA;
        Sat, 18 Mar 2017 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872003;
        bh=00IIZJ1/YjglkC8YAqWxY+MI5U9T5TCFcqhx1B5/ihA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=02gCOtmvb2Z2uKpMPIEdSdLV5DIMF94SGH726koD4KhVEmpQ119b5R/LVJnwKeZl8
         x+TXyJw+E1a36Da3FRkAmtArzruTEGRlTrXWeKxygSxAmh/zajka5515XtNhY66TMv
         GUgP4b/L4DeHzDBF4f+r4NXJWuKMsvcKK9W2z2JjSH8DrVpeDAwa2eKDegSZOjVwsx
         zs2vx0g4KfMsLDLuJ+WCKf5hB6Gd2xZCAd2siXYYADdIJ7xQcS0NXCPHvw7r+sv2RH
         e1qVeOGNxM7LeJ+dDGYKdJos2p30aTHjoCWEMXWkVTzsAC9mpu++9RQOkJ7w0phVE1
         ktcevUpaEipMT3RSkUOazA6ApfSV8NpCKD6nVxw45Nb353Fye1ZK/gZBet134St9iZ
         Gh8GaewbmHHlZKP1uv2OKmRBoETMGqaUxf0AkkwocS+54YhFZf8/0s1alk7TCPPz/f
         6pplkKu1OPQV9FnTBpRD1ltU6zHRlQAO8LAJyqjgHEIR5Sn+t4F
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/20] builtin/pull: convert to struct object_id
Date:   Sat, 18 Mar 2017 21:19:47 +0000
Message-Id: <20170318211954.564030-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert virtually all uses of unsigned char [20] to struct object_id.
Leave all the arguments that come from struct sha1_array, as these will
be converted in a later patch.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pull.c | 72 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a9f7553f30..704ce1f042 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -515,7 +515,7 @@ static int run_fetch(const char *repo, const char **refspecs)
  * "Pulls into void" by branching off merge_head.
  */
 static int pull_into_void(const unsigned char *merge_head,
-		const unsigned char *curr_head)
+		const struct object_id *curr_head)
 {
 	/*
 	 * Two-way merge: we treat the index as based on an empty tree,
@@ -526,7 +526,7 @@ static int pull_into_void(const unsigned char *merge_head,
 	if (checkout_fast_forward(EMPTY_TREE_SHA1_BIN, merge_head, 0))
 		return 1;
 
-	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
+	if (update_ref("initial pull", "HEAD", merge_head, curr_head->hash, 0, UPDATE_REFS_DIE_ON_ERR))
 		return 1;
 
 	return 0;
@@ -647,7 +647,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
  * current branch forked from its remote tracking branch. Returns 0 on success,
  * -1 on failure.
  */
-static int get_rebase_fork_point(unsigned char *fork_point, const char *repo,
+static int get_rebase_fork_point(struct object_id *fork_point, const char *repo,
 		const char *refspec)
 {
 	int ret;
@@ -678,7 +678,7 @@ static int get_rebase_fork_point(unsigned char *fork_point, const char *repo,
 	if (ret)
 		goto cleanup;
 
-	ret = get_sha1_hex(sb.buf, fork_point);
+	ret = get_oid_hex(sb.buf, fork_point);
 	if (ret)
 		goto cleanup;
 
@@ -691,24 +691,24 @@ static int get_rebase_fork_point(unsigned char *fork_point, const char *repo,
  * Sets merge_base to the octopus merge base of curr_head, merge_head and
  * fork_point. Returns 0 if a merge base is found, 1 otherwise.
  */
-static int get_octopus_merge_base(unsigned char *merge_base,
-		const unsigned char *curr_head,
+static int get_octopus_merge_base(struct object_id *merge_base,
+		const struct object_id *curr_head,
 		const unsigned char *merge_head,
-		const unsigned char *fork_point)
+		const struct object_id *fork_point)
 {
 	struct commit_list *revs = NULL, *result;
 
-	commit_list_insert(lookup_commit_reference(curr_head), &revs);
+	commit_list_insert(lookup_commit_reference(curr_head->hash), &revs);
 	commit_list_insert(lookup_commit_reference(merge_head), &revs);
-	if (!is_null_sha1(fork_point))
-		commit_list_insert(lookup_commit_reference(fork_point), &revs);
+	if (!is_null_oid(fork_point))
+		commit_list_insert(lookup_commit_reference(fork_point->hash), &revs);
 
 	result = reduce_heads(get_octopus_merge_bases(revs));
 	free_commit_list(revs);
 	if (!result)
 		return 1;
 
-	hashcpy(merge_base, result->item->object.oid.hash);
+	oidcpy(merge_base, &result->item->object.oid);
 	return 0;
 }
 
@@ -717,16 +717,16 @@ static int get_octopus_merge_base(unsigned char *merge_base,
  * fork point calculated by get_rebase_fork_point(), runs git-rebase with the
  * appropriate arguments and returns its exit status.
  */
-static int run_rebase(const unsigned char *curr_head,
+static int run_rebase(const struct object_id *curr_head,
 		const unsigned char *merge_head,
-		const unsigned char *fork_point)
+		const struct object_id *fork_point)
 {
 	int ret;
-	unsigned char oct_merge_base[GIT_SHA1_RAWSZ];
+	struct object_id oct_merge_base;
 	struct argv_array args = ARGV_ARRAY_INIT;
 
-	if (!get_octopus_merge_base(oct_merge_base, curr_head, merge_head, fork_point))
-		if (!is_null_sha1(fork_point) && !hashcmp(oct_merge_base, fork_point))
+	if (!get_octopus_merge_base(&oct_merge_base, curr_head, merge_head, fork_point))
+		if (!is_null_oid(fork_point) && !oidcmp(&oct_merge_base, fork_point))
 			fork_point = NULL;
 
 	argv_array_push(&args, "rebase");
@@ -756,8 +756,8 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
 
-	if (fork_point && !is_null_sha1(fork_point))
-		argv_array_push(&args, sha1_to_hex(fork_point));
+	if (fork_point && !is_null_oid(fork_point))
+		argv_array_push(&args, oid_to_hex(fork_point));
 	else
 		argv_array_push(&args, sha1_to_hex(merge_head));
 
@@ -770,8 +770,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
 	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
-	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
-	unsigned char rebase_fork_point[GIT_SHA1_RAWSZ];
+	struct object_id orig_head, curr_head;
+	struct object_id rebase_fork_point;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -794,8 +794,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (file_exists(git_path("MERGE_HEAD")))
 		die_conclude_merge();
 
-	if (get_sha1("HEAD", orig_head))
-		hashclr(orig_head);
+	if (get_oid("HEAD", &orig_head))
+		oidclr(&orig_head);
 
 	if (!opt_rebase && opt_autostash != -1)
 		die(_("--[no-]autostash option is only valid with --rebase."));
@@ -805,15 +805,15 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
-		if (is_null_sha1(orig_head) && !is_cache_unborn())
+		if (is_null_oid(&orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!autostash)
 			require_clean_work_tree(N_("pull with rebase"),
 				_("please commit or stash them."), 1, 0);
 
-		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
-			hashclr(rebase_fork_point);
+		if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
+			oidclr(&rebase_fork_point);
 	}
 
 	if (run_fetch(repo, refspecs))
@@ -822,11 +822,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_dry_run)
 		return 0;
 
-	if (get_sha1("HEAD", curr_head))
-		hashclr(curr_head);
+	if (get_oid("HEAD", &curr_head))
+		oidclr(&curr_head);
 
-	if (!is_null_sha1(orig_head) && !is_null_sha1(curr_head) &&
-			hashcmp(orig_head, curr_head)) {
+	if (!is_null_oid(&orig_head) && !is_null_oid(&curr_head) &&
+			oidcmp(&orig_head, &curr_head)) {
 		/*
 		 * The fetch involved updating the current branch.
 		 *
@@ -837,15 +837,15 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		warning(_("fetch updated the current branch head.\n"
 			"fast-forwarding your working tree from\n"
-			"commit %s."), sha1_to_hex(orig_head));
+			"commit %s."), oid_to_hex(&orig_head));
 
-		if (checkout_fast_forward(orig_head, curr_head, 0))
+		if (checkout_fast_forward(orig_head.hash, curr_head.hash, 0))
 			die(_("Cannot fast-forward your working tree.\n"
 				"After making sure that you saved anything precious from\n"
 				"$ git diff %s\n"
 				"output, run\n"
 				"$ git reset --hard\n"
-				"to recover."), sha1_to_hex(orig_head));
+				"to recover."), oid_to_hex(&orig_head));
 	}
 
 	get_merge_heads(&merge_heads);
@@ -853,10 +853,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!merge_heads.nr)
 		die_no_merge_candidates(repo, refspecs);
 
-	if (is_null_sha1(orig_head)) {
+	if (is_null_oid(&orig_head)) {
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
-		return pull_into_void(*merge_heads.sha1, curr_head);
+		return pull_into_void(*merge_heads.sha1, &curr_head);
 	}
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
@@ -865,7 +865,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		struct commit_list *list = NULL;
 		struct commit *merge_head, *head;
 
-		head = lookup_commit_reference(orig_head);
+		head = lookup_commit_reference(orig_head.hash);
 		commit_list_insert(head, &list);
 		merge_head = lookup_commit_reference(merge_heads.sha1[0]);
 		if (is_descendant_of(merge_head, list)) {
@@ -873,7 +873,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			opt_ff = "--ff-only";
 			return run_merge();
 		}
-		return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
+		return run_rebase(&curr_head, *merge_heads.sha1, &rebase_fork_point);
 	} else {
 		return run_merge();
 	}
