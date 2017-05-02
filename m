Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF312207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdEBBDA (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:03:00 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35917 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdEBBC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:02:59 -0400
Received: by mail-pf0-f181.google.com with SMTP id q66so37099730pfi.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pIOXIJeSFlgvEGJcU6HYwAsFOpO6+nRqRvoGKIvlAy0=;
        b=BRWk02mGMIbVTg5BjyLStpqI/tbnt7WWXM4xzM47GsUr1woH4kFBsiWSdDsyzbe+l0
         pp7vEw0mAM/MHzm4oByJqGDPlzIzIkkIMCsi95T0zucHQnNX4HjLYpU1sFKqykqNUhvI
         UKrl/sbKm3l9fytZlAdZ1JFKJ3UMczA3rb9y7jcbRWEuqh5uKb93LupbMC6JD9bPxtNv
         en23eIxa8LPFpnWhXklyB6+9S4TI6UXZMSTyBnjn3IyrnrcV1NByoddGbnK7nvhRmHRF
         +34rnyvKZDTlTJjfGaHFlTYw1rWbr7a9KsJ7vsG+WrnbfVayeGop2iNGVdPaisCSGNmR
         E4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pIOXIJeSFlgvEGJcU6HYwAsFOpO6+nRqRvoGKIvlAy0=;
        b=DoqzbcA2HZ/y9ZjLiY/uoZo9jmp2if+DXHCTcf2wGGkFI1wjoiNMaKz5KglYJRmAPo
         k2RyoqofzNwYx8HYneUccWkU0sBJ8e/AAK0U7AeiYyt0PVr721Zucl3buJCuuShw7DCU
         232ijfPfZzEdkHCUZjOiX6y6KkkeThBeOMlZt1Gb31nhcs5QSwJXGNgEEaiOueZZkOY/
         NzAOXhI63ijnqDsgtidIW/+JL+jqyFg0Mpwp8xUH2ckBPLQFk/Bvp2/TzNnjANgNmWli
         iAUtGvlNjBIEOOoBWdffN2GQ4EYIsU5E7hjY9jBIDUIFB9bEOKCot4C1zP3nWYXwB6jA
         cIEg==
X-Gm-Message-State: AN3rC/7oUrG8eiUdtlVqHCYMjStCdoA5jyp4rXdnUsgT3bW4DCcJDvEX
        CON4oc6xLoREoS4w
X-Received: by 10.98.65.132 with SMTP id g4mr28857055pfd.187.1493686973554;
        Mon, 01 May 2017 18:02:53 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm13532526pfa.56.2017.05.01.18.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:02:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 6/6] submodule: refactor logic to determine changed submodules
Date:   Mon,  1 May 2017 18:02:39 -0700
Message-Id: <20170502010239.179369-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170502010239.179369-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are currently two instances (fetch and push) where we want to
determine if submodules have changed given some revision specification.
These two instances don't use the same logic to generate a list of
changed submodules and as a result there is a fair amount of code
duplication.

This patch refactors these two code paths such that they both use the
same logic to generate a list of changed submodules.  This also makes it
easier for future callers to be able to reuse this logic as they only
need to create an argv_array with the revision specification to be using
during the revision walk.

Change-Id: Ie2381bd3eaecf5cec62e127df470f27a44ea47da
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 247 ++++++++++++++++++++++++++----------------------------------
 1 file changed, 105 insertions(+), 142 deletions(-)

diff --git a/submodule.c b/submodule.c
index 057695e64..7eaa3d384 100644
--- a/submodule.c
+++ b/submodule.c
@@ -617,6 +617,94 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	return submodule_from_path(null_sha1, ce->name);
 }
 
+static struct oid_array *submodule_commits(struct string_list *submodules,
+					   const char *path)
+{
+	struct string_list_item *item;
+
+	item = string_list_insert(submodules, path);
+	if (item->util)
+		return (struct oid_array *) item->util;
+
+	/* NEEDSWORK: should we have oid_array_init()? */
+	item->util = xcalloc(1, sizeof(struct oid_array));
+	return (struct oid_array *) item->util;
+}
+
+static void collect_changed_submodules_cb(struct diff_queue_struct *q,
+					  struct diff_options *options,
+					  void *data)
+{
+	int i;
+	struct string_list *changed = data;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct oid_array *commits;
+		if (!S_ISGITLINK(p->two->mode))
+			continue;
+
+		if (S_ISGITLINK(p->one->mode)) {
+			/*
+			 * NEEDSWORK: We should honor the name configured in
+			 * the .gitmodules file of the commit we are examining
+			 * here to be able to correctly follow submodules
+			 * being moved around.
+			 */
+			commits = submodule_commits(changed, p->two->path);
+			oid_array_append(commits, &p->two->oid);
+		} else {
+			/* Submodule is new or was moved here */
+			/*
+			 * NEEDSWORK: When the .git directories of submodules
+			 * live inside the superprojects .git directory some
+			 * day we should fetch new submodules directly into
+			 * that location too when config or options request
+			 * that so they can be checked out from there.
+			 */
+			continue;
+		}
+	}
+}
+
+/*
+ * Collect the paths of submodules in 'changed' which have changed based on
+ * the revisions as specified in 'argv'.  Each entry in 'changed' will also
+ * have a corresponding 'struct oid_array' (in the 'util' field) which lists
+ * what the submodule pointers were updated to during the change.
+ */
+static void collect_changed_submodules(struct string_list *changed,
+				       struct argv_array *argv)
+{
+	struct rev_info rev;
+	const struct commit *commit;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(argv->argc, argv->argv, &rev, NULL);
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
+
+	while ((commit = get_revision(&rev))) {
+		struct rev_info diff_rev;
+
+		init_revisions(&diff_rev, NULL);
+		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
+		diff_rev.diffopt.format_callback_data = changed;
+		diff_tree_combined_merge(commit, 1, &diff_rev);
+	}
+
+	reset_revision_walk();
+}
+
+static void free_submodules_oids(struct string_list *submodules)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, submodules)
+		oid_array_clear((struct oid_array *) item->util);
+	string_list_clear(submodules, 1);
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
@@ -729,92 +817,31 @@ static int submodule_needs_pushing(const char *path, struct oid_array *commits)
 	return 0;
 }
 
-static struct oid_array *submodule_commits(struct string_list *submodules,
-					    const char *path)
-{
-	struct string_list_item *item;
-
-	item = string_list_insert(submodules, path);
-	if (item->util)
-		return (struct oid_array *) item->util;
-
-	/* NEEDSWORK: should we have oid_array_init()? */
-	item->util = xcalloc(1, sizeof(struct oid_array));
-	return (struct oid_array *) item->util;
-}
-
-static void collect_submodules_from_diff(struct diff_queue_struct *q,
-					 struct diff_options *options,
-					 void *data)
-{
-	int i;
-	struct string_list *submodules = data;
-
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		struct oid_array *commits;
-		if (!S_ISGITLINK(p->two->mode))
-			continue;
-		commits = submodule_commits(submodules, p->two->path);
-		oid_array_append(commits, &p->two->oid);
-	}
-}
-
-static void find_unpushed_submodule_commits(struct commit *commit,
-		struct string_list *needs_pushing)
-{
-	struct rev_info rev;
-
-	init_revisions(&rev, NULL);
-	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = collect_submodules_from_diff;
-	rev.diffopt.format_callback_data = needs_pushing;
-	diff_tree_combined_merge(commit, 1, &rev);
-}
-
-static void free_submodules_oids(struct string_list *submodules)
-{
-	struct string_list_item *item;
-	for_each_string_list_item(item, submodules)
-		oid_array_clear((struct oid_array *) item->util);
-	string_list_clear(submodules, 1);
-}
-
 int find_unpushed_submodules(struct oid_array *commits,
 		const char *remotes_name, struct string_list *needs_pushing)
 {
-	struct rev_info rev;
-	struct commit *commit;
 	struct string_list submodules = STRING_LIST_INIT_DUP;
 	struct string_list_item *submodule;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	init_revisions(&rev, NULL);
-
 	/* argv.argv[0] will be ignored by setup_revisions */
 	argv_array_push(&argv, "find_unpushed_submodules");
 	oid_array_for_each_unique(commits, append_oid_to_argv, &argv);
 	argv_array_push(&argv, "--not");
 	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
 
-	setup_revisions(argv.argc, argv.argv, &rev, NULL);
-	if (prepare_revision_walk(&rev))
-		die("revision walk setup failed");
-
-	while ((commit = get_revision(&rev)) != NULL)
-		find_unpushed_submodule_commits(commit, &submodules);
-
-	reset_revision_walk();
-	argv_array_clear(&argv);
+	collect_changed_submodules(&submodules, &argv);
 
 	for_each_string_list_item(submodule, &submodules) {
-		struct oid_array *commits = (struct oid_array *) submodule->util;
+		struct oid_array *commits = submodule->util;
+		const char *path = submodule->string;
 
-		if (submodule_needs_pushing(submodule->string, commits))
-			string_list_insert(needs_pushing, submodule->string);
+		if (submodule_needs_pushing(path, commits))
+			string_list_insert(needs_pushing, path);
 	}
 
 	free_submodules_oids(&submodules);
+	argv_array_clear(&argv);
 
 	return needs_pushing->nr;
 }
@@ -931,61 +958,6 @@ int push_unpushed_submodules(struct oid_array *commits,
 	return ret;
 }
 
-static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
-{
-	int is_present = 0;
-	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
-		/* Even if the submodule is checked out and the commit is
-		 * present, make sure it is reachable from a ref. */
-		struct child_process cp = CHILD_PROCESS_INIT;
-		const char *argv[] = {"rev-list", "-n", "1", NULL, "--not", "--all", NULL};
-		struct strbuf buf = STRBUF_INIT;
-
-		argv[3] = sha1_to_hex(sha1);
-		cp.argv = argv;
-		prepare_submodule_repo_env(&cp.env_array);
-		cp.git_cmd = 1;
-		cp.no_stdin = 1;
-		cp.dir = path;
-		if (!capture_command(&cp, &buf, 1024) && !buf.len)
-			is_present = 1;
-
-		strbuf_release(&buf);
-	}
-	return is_present;
-}
-
-static void submodule_collect_changed_cb(struct diff_queue_struct *q,
-					 struct diff_options *options,
-					 void *data)
-{
-	int i;
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		if (!S_ISGITLINK(p->two->mode))
-			continue;
-
-		if (S_ISGITLINK(p->one->mode)) {
-			/* NEEDSWORK: We should honor the name configured in
-			 * the .gitmodules file of the commit we are examining
-			 * here to be able to correctly follow submodules
-			 * being moved around. */
-			struct string_list_item *path;
-			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
-			if (!path && !is_submodule_commit_present(p->two->path, p->two->oid.hash))
-				string_list_append(&changed_submodule_paths, p->two->path);
-		} else {
-			/* Submodule is new or was moved here */
-			/* NEEDSWORK: When the .git directories of submodules
-			 * live inside the superprojects .git directory some
-			 * day we should fetch new submodules directly into
-			 * that location too when config or options request
-			 * that so they can be checked out from there. */
-			continue;
-		}
-	}
-}
-
 static int append_oid_to_array(const char *ref, const struct object_id *oid,
 			       int flags, void *data)
 {
@@ -1006,45 +978,36 @@ void check_for_new_submodule_commits(struct object_id *oid)
 
 static void calculate_changed_submodule_paths(void)
 {
-	struct rev_info rev;
-	struct commit *commit;
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
+	const struct string_list_item *item;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(NULL, NULL))
 		return;
 
-	init_revisions(&rev, NULL);
 	argv_array_push(&argv, "--"); /* argv[0] program name */
 	oid_array_for_each_unique(&ref_tips_after_fetch,
 				   append_oid_to_argv, &argv);
 	argv_array_push(&argv, "--not");
 	oid_array_for_each_unique(&ref_tips_before_fetch,
 				   append_oid_to_argv, &argv);
-	setup_revisions(argv.argc, argv.argv, &rev, NULL);
-	if (prepare_revision_walk(&rev))
-		die("revision walk setup failed");
 
 	/*
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_paths".
 	 */
-	while ((commit = get_revision(&rev))) {
-		struct commit_list *parent = commit->parents;
-		while (parent) {
-			struct diff_options diff_opts;
-			diff_setup(&diff_opts);
-			DIFF_OPT_SET(&diff_opts, RECURSIVE);
-			diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
-			diff_opts.format_callback = submodule_collect_changed_cb;
-			diff_setup_done(&diff_opts);
-			diff_tree_sha1(parent->item->object.oid.hash, commit->object.oid.hash, "", &diff_opts);
-			diffcore_std(&diff_opts);
-			diff_flush(&diff_opts);
-			parent = parent->next;
-		}
+	collect_changed_submodules(&changed_submodules, &argv);
+
+	for_each_string_list_item(item, &changed_submodules) {
+		struct oid_array *commits = item->util;
+		const char *path = item->string;
+
+		if (!submodule_has_commits(path, commits))
+			string_list_append(&changed_submodule_paths, path);
 	}
 
+	free_submodules_oids(&changed_submodules);
 	argv_array_clear(&argv);
 	oid_array_clear(&ref_tips_before_fetch);
 	oid_array_clear(&ref_tips_after_fetch);
-- 
2.13.0.rc1.294.g07d810a77f-goog

