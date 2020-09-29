Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89030C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A60207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="AREaq1RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgI2QN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgI2QN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 12:13:26 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7852C061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kn26iDIHNUTCs8bDSVuSD72WkTwF3FfRU9AWhLPrJq4=; b=AREaq1RKQvC4Dtg0vSyVvzPEcE
        Cmg8kp5xUrY41MBO/DUd4zHjnKZZ1VilgJBQ/62ONRukH2pFEHBWTTPdbjaYW8Rj22xgUFfvLUooA
        q+RbiKgoA+WKJNBBbIEG5J7TRv2V7eZkiJZgy42oxeeuwlkphaSWpIe4clEDzUoOHJDQ=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1kNHx7-0004AY-Od; Tue, 29 Sep 2020 15:54:05 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 2/7] submodule: use separate submodule repositories
Date:   Tue, 29 Sep 2020 16:53:45 +0100
Message-Id: <20200929155350.49066-3-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929155350.49066-1-andrew@adoakley.name>
References: <20200929155350.49066-1-andrew@adoakley.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit allows `git fetch --recuse-submodules` to work correctly
with partial clones, including the case where it is only the parent
repository that is a partial clone.

Using a separate repository with its own object store should allow
any objects that need to be fetched from a promisor or an alternate
object store to work correctly.

Replacing get_submodule_ref_store with get_main_ref_store for the
correct repo makes the refs store lookup objects in the correct repo
(for at least the cases relevant for a fetch).  We still can't fetch
objects from promisor remotes, but do_oid_object_info_extended detects
this and fails gracefully.

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 submodule.c | 105 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 45 deletions(-)

diff --git a/submodule.c b/submodule.c
index 543b1123ae..3889dc7d9a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -89,11 +89,11 @@ int is_staging_gitmodules_ok(struct index_state *istate)
 	return 1;
 }
 
-static int for_each_remote_ref_submodule(const char *submodule,
+static int for_each_remote_ref_submodule(struct repository *subrepo,
 					 each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_remote_ref(get_submodule_ref_store(submodule),
-					fn, cb_data);
+       return refs_for_each_remote_ref(get_main_ref_store(subrepo), fn,
+				       cb_data);
 }
 
 /*
@@ -879,6 +879,27 @@ static void free_submodules_oids(struct string_list *submodules)
 	string_list_clear(submodules, 1);
 }
 
+static struct repository* get_changed_submodule_repo(struct repository *r,
+						     const char *name_or_path)
+{
+	const struct submodule *submodule;
+	struct repository *subrepo;
+
+	submodule = submodule_from_name(r, &null_oid, name_or_path);
+	if (!submodule) {
+		/* Not a named submodule, try just using the path */
+		return open_submodule(name_or_path);
+	}
+
+	subrepo = xmalloc(sizeof(*subrepo));
+	if (repo_submodule_init(subrepo, r, submodule)) {
+		free(subrepo);
+		return NULL;
+	}
+
+	return subrepo;
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
@@ -895,7 +916,6 @@ static int append_oid_to_argv(const struct object_id *oid, void *data)
 struct has_commit_data {
 	struct repository *repo;
 	int result;
-	const char *path;
 };
 
 static int check_has_commit(const struct object_id *oid, void *data)
@@ -916,28 +936,22 @@ static int check_has_commit(const struct object_id *oid, void *data)
 		return 0;
 	default:
 		die(_("submodule entry '%s' (%s) is a %s, not a commit"),
-		    cb->path, oid_to_hex(oid), type_name(type));
+		    cb->repo->submodule_prefix, oid_to_hex(oid),
+		    type_name(type));
 	}
 }
 
-static int submodule_has_commits(struct repository *r,
-				 const char *path,
+static int submodule_has_commits(struct repository *subrepo,
 				 struct oid_array *commits)
 {
-	struct has_commit_data has_commit = { r, 1, path };
+	struct has_commit_data has_commit = { subrepo, 1 };
 
 	/*
-	 * Perform a cheap, but incorrect check for the existence of 'commits'.
-	 * This is done by adding the submodule's object store to the in-core
-	 * object store, and then querying for each commit's existence.  If we
-	 * do not have the commit object anywhere, there is no chance we have
-	 * it in the object store of the correct submodule and have it
-	 * reachable from a ref, so we can fail early without spawning rev-list
-	 * which is expensive.
+	 * Perform a check for the existence of 'commits' in the submodule's
+	 * object store.  If we do not have the commit object, there is no
+	 * chance we have it reachable from a ref, so we can fail early without
+	 * spawning rev-list which is expensive.
 	 */
-	if (add_submodule_odb(path))
-		return 0;
-
 	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
 
 	if (has_commit.result) {
@@ -956,7 +970,7 @@ static int submodule_has_commits(struct repository *r,
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
-		cp.dir = path;
+		cp.dir = subrepo->submodule_prefix;
 
 		if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) || out.len)
 			has_commit.result = 0;
@@ -967,11 +981,12 @@ static int submodule_has_commits(struct repository *r,
 	return has_commit.result;
 }
 
-static int submodule_needs_pushing(struct repository *r,
-				   const char *path,
+static int submodule_needs_pushing(struct repository *subrepo,
 				   struct oid_array *commits)
 {
-	if (!submodule_has_commits(r, path, commits))
+	const char *path = subrepo->submodule_prefix;
+
+	if (!submodule_has_commits(subrepo, commits))
 		/*
 		 * NOTE: We do consider it safe to return "no" here. The
 		 * correct answer would be "We do not know" instead of
@@ -985,7 +1000,7 @@ static int submodule_needs_pushing(struct repository *r,
 		 */
 		return 0;
 
-	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
+	if (for_each_remote_ref_submodule(subrepo, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct strbuf buf = STRBUF_INIT;
 		int needs_pushing = 0;
@@ -1032,20 +1047,18 @@ int find_unpushed_submodules(struct repository *r,
 
 	for_each_string_list_item(name, &submodules) {
 		struct oid_array *commits = name->util;
-		const struct submodule *submodule;
-		const char *path = NULL;
-
-		submodule = submodule_from_name(r, &null_oid, name->string);
-		if (submodule)
-			path = submodule->path;
-		else
-			path = default_name_or_path(name->string);
+		struct repository *subrepo;
 
-		if (!path)
+		subrepo = get_changed_submodule_repo(r, name->string);
+		if (!subrepo)
 			continue;
 
-		if (submodule_needs_pushing(r, path, commits))
-			string_list_insert(needs_pushing, path);
+		if (submodule_needs_pushing(subrepo, commits))
+			string_list_insert(needs_pushing,
+					   subrepo->submodule_prefix);
+
+		repo_clear(subrepo);
+		free(subrepo);
 	}
 
 	free_submodules_oids(&submodules);
@@ -1060,7 +1073,12 @@ static int push_submodule(const char *path,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
-	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
+	struct repository *subrepo = open_submodule(path);
+	int have_remote = for_each_remote_ref_submodule(subrepo, has_remote, NULL);
+	repo_clear(subrepo);
+	free(subrepo);
+
+	if (have_remote > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		strvec_push(&cp.args, "push");
 		if (dry_run)
@@ -1219,22 +1237,19 @@ static void calculate_changed_submodule_paths(struct repository *r,
 
 	for_each_string_list_item(name, changed_submodule_names) {
 		struct oid_array *commits = name->util;
-		const struct submodule *submodule;
-		const char *path = NULL;
-
-		submodule = submodule_from_name(r, &null_oid, name->string);
-		if (submodule)
-			path = submodule->path;
-		else
-			path = default_name_or_path(name->string);
+		struct repository *subrepo;
 
-		if (!path)
+		subrepo = get_changed_submodule_repo(r, name->string);
+		if (!subrepo)
 			continue;
 
-		if (submodule_has_commits(r, path, commits)) {
+		if (submodule_has_commits(subrepo, commits)) {
 			oid_array_clear(commits);
 			*name->string = '\0';
 		}
+
+		repo_clear(subrepo);
+		free(subrepo);
 	}
 
 	string_list_remove_empty_items(changed_submodule_names, 1);
-- 
2.26.2

