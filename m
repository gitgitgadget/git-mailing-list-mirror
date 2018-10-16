Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 727481F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJQCFk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:05:40 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:48574 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:05:39 -0400
Received: by mail-io1-f73.google.com with SMTP id v12-v6so22359031iob.15
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eKZosNxwNfmoclJwZLY9ORZilz4Ns8/QFzalhLMUAAs=;
        b=tjVRzI//rXF4N29OiYQS4Ev8+e3DpMpj3NwQUnzL3FRNMmo61IRPbAy2JC/JXz14ZB
         BvH4wmTb0/K2T6a+9z9da33rXUuxiIPD02wSdNpviPUu5QDpmZIOe3nfZ9+pIt0B7jzN
         6WaFPQ3dJsuVGng04icOez8TqH7OGS5QKs1DeVRWvY5X82LZRMBe7bpoYTBofaS87HuB
         pCGEUFrfBFxs3+KnEnUu/P2rYE9PGBWc3iKAudfTIk9wL60edCDrnkkmuKUcsS0uTSXX
         yT8A64lLmnL8jsn6dJXckS/7c92wYenyRKQUlpG1BakKznXRA8yVcyCzk/A6rIegoIpp
         GR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eKZosNxwNfmoclJwZLY9ORZilz4Ns8/QFzalhLMUAAs=;
        b=HVolLpl/XjbQ9rcncbup7xTO/TAEk9tfXavNTR+w/ZiKSx9vjLzL1LiZhBpJ4WIjPA
         dMhKdG2wS9jnxt9Qg7l8MmwfQ2HJV5MKVaigG9hKeRLVdEtIy5fp/oWCjMb2cy+p8hfE
         RmboSlJI6iVrMt0LKroeDapWk1n6gztfm7Z6YqW2PS6p3Efg3ealc+D6Wm3ltA4fUswT
         8Q8GiyEqkGrvsOcsxYKxgqW41dQRcs+TbV4rLuuzDZKyEMqFX5+yoVO47XM/OlcKyLdB
         bRIjv+4SRsWbOWoj5qglPEtfwxw6zeSfYGOQjhOjaiqQUsTH/ekOys2x3YHzV+Spsm79
         XzzQ==
X-Gm-Message-State: ABuFfohNuxXqgtkYBX7yGrkRA2eJw6w8xgZXHYosGp0851pK06lxwAMR
        1sZAZrwZKinSWr6l8AJI3H7BadyTwZqG
X-Google-Smtp-Source: ACcGV625ktWiwLU0U3WuBD4WgTJsvF4k25FRLCX08GvpcElkLwpPo5yMB3PjNKauFYPZkphQEiSi5CaEp4oi
X-Received: by 2002:a24:6cc2:: with SMTP id w185-v6mr16037836itb.5.1539713640103;
 Tue, 16 Oct 2018 11:14:00 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:24 -0700
In-Reply-To: <20181016181327.107186-1-sbeller@google.com>
Message-Id: <20181016181327.107186-7-sbeller@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 6/9] repository: repo_submodule_init to take a submodule struct
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing a struct repository for a submodule for some revision
of the superproject where the submodule is not contained in the index,
it may not be present in the working tree currently either. In that
siutation giving a 'path' argument is not useful. Upgrade the
repo_submodule_init function to take a struct submodule instead.

While we are at it, overhaul the repo_submodule_init function by renaming
the submodule repository struct, which is to be initialized, to a name
that is not confused with the struct submodule as easily.

Also move its documentation into the header file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/grep.c                               | 17 +++++++-----
 builtin/ls-files.c                           | 12 +++++----
 repository.c                                 | 27 ++++++++------------
 repository.h                                 | 11 ++++++--
 t/helper/test-submodule-nested-repo-config.c |  8 +++---
 5 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 7da8fef31a..ba7634258a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -418,7 +418,10 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 			  const struct object_id *oid,
 			  const char *filename, const char *path)
 {
-	struct repository submodule;
+	struct repository subrepo;
+	const struct submodule *sub = submodule_from_path(superproject,
+							  &null_oid, path);
+
 	int hit;
 
 	/*
@@ -434,12 +437,12 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 		return 0;
 	}
 
-	if (repo_submodule_init(&submodule, superproject, path)) {
+	if (repo_submodule_init(&subrepo, superproject, sub)) {
 		grep_read_unlock();
 		return 0;
 	}
 
-	repo_read_gitmodules(&submodule);
+	repo_read_gitmodules(&subrepo);
 
 	/*
 	 * NEEDSWORK: This adds the submodule's object directory to the list of
@@ -451,7 +454,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * store is no longer global and instead is a member of the repository
 	 * object.
 	 */
-	add_to_alternates_memory(submodule.objects->objectdir);
+	add_to_alternates_memory(subrepo.objects->objectdir);
 	grep_read_unlock();
 
 	if (oid) {
@@ -476,14 +479,14 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-				object->type == OBJ_COMMIT, &submodule);
+				object->type == OBJ_COMMIT, &subrepo);
 		strbuf_release(&base);
 		free(data);
 	} else {
-		hit = grep_cache(opt, &submodule, pathspec, 1);
+		hit = grep_cache(opt, &subrepo, pathspec, 1);
 	}
 
-	repo_clear(&submodule);
+	repo_clear(&subrepo);
 	return hit;
 }
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7f9919a362..4d1649c1b3 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -206,17 +206,19 @@ static void show_files(struct repository *repo, struct dir_struct *dir);
 static void show_submodule(struct repository *superproject,
 			   struct dir_struct *dir, const char *path)
 {
-	struct repository submodule;
+	struct repository subrepo;
+	const struct submodule *sub = submodule_from_path(superproject,
+							  &null_oid, path);
 
-	if (repo_submodule_init(&submodule, superproject, path))
+	if (repo_submodule_init(&subrepo, superproject, sub))
 		return;
 
-	if (repo_read_index(&submodule) < 0)
+	if (repo_read_index(&subrepo) < 0)
 		die("index file corrupt");
 
-	show_files(&submodule, dir);
+	show_files(&subrepo, dir);
 
-	repo_clear(&submodule);
+	repo_clear(&subrepo);
 }
 
 static void show_ce(struct repository *repo, struct dir_struct *dir,
diff --git a/repository.c b/repository.c
index 5dd1486718..aabe64ee5d 100644
--- a/repository.c
+++ b/repository.c
@@ -166,30 +166,23 @@ int repo_init(struct repository *repo,
 	return -1;
 }
 
-/*
- * Initialize 'submodule' as the submodule given by 'path' in parent repository
- * 'superproject'.
- * Return 0 upon success and a non-zero value upon failure.
- */
-int repo_submodule_init(struct repository *submodule,
+int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
-			const char *path)
+			const struct submodule *sub)
 {
-	const struct submodule *sub;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf worktree = STRBUF_INIT;
 	int ret = 0;
 
-	sub = submodule_from_path(superproject, &null_oid, path);
 	if (!sub) {
 		ret = -1;
 		goto out;
 	}
 
-	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", path);
-	strbuf_repo_worktree_path(&worktree, superproject, "%s", path);
+	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", sub->path);
+	strbuf_repo_worktree_path(&worktree, superproject, "%s", sub->path);
 
-	if (repo_init(submodule, gitdir.buf, worktree.buf)) {
+	if (repo_init(subrepo, gitdir.buf, worktree.buf)) {
 		/*
 		 * If initilization fails then it may be due to the submodule
 		 * not being populated in the superproject's worktree.  Instead
@@ -201,16 +194,16 @@ int repo_submodule_init(struct repository *submodule,
 		strbuf_repo_git_path(&gitdir, superproject,
 				     "modules/%s", sub->name);
 
-		if (repo_init(submodule, gitdir.buf, NULL)) {
+		if (repo_init(subrepo, gitdir.buf, NULL)) {
 			ret = -1;
 			goto out;
 		}
 	}
 
-	submodule->submodule_prefix = xstrfmt("%s%s/",
-					      superproject->submodule_prefix ?
-					      superproject->submodule_prefix :
-					      "", path);
+	subrepo->submodule_prefix = xstrfmt("%s%s/",
+					    superproject->submodule_prefix ?
+					    superproject->submodule_prefix :
+					    "", sub->path);
 
 out:
 	strbuf_release(&gitdir);
diff --git a/repository.h b/repository.h
index 9f16c42c1e..a9c7a5baa5 100644
--- a/repository.h
+++ b/repository.h
@@ -116,9 +116,16 @@ void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
 void initialize_the_repository(void);
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
-int repo_submodule_init(struct repository *submodule,
+
+/*
+ * Initialize the repository 'subrepo' as the submodule given by the
+ * struct submodule 'sub' in parent repository 'superproject'.
+ * Return 0 upon success and a non-zero value upon failure.
+ */
+struct submodule;
+int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
-			const char *path);
+			const struct submodule *sub);
 void repo_clear(struct repository *repo);
 
 /*
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index a31e2a9bea..bc97929bbc 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -10,19 +10,21 @@ static void die_usage(int argc, const char **argv, const char *msg)
 
 int cmd__submodule_nested_repo_config(int argc, const char **argv)
 {
-	struct repository submodule;
+	struct repository subrepo;
+	const struct submodule *sub;
 
 	if (argc < 3)
 		die_usage(argc, argv, "Wrong number of arguments.");
 
 	setup_git_directory();
 
-	if (repo_submodule_init(&submodule, the_repository, argv[1])) {
+	sub = submodule_from_path(the_repository, &null_oid, argv[1]);
+	if (repo_submodule_init(&subrepo, the_repository, sub)) {
 		die_usage(argc, argv, "Submodule not found.");
 	}
 
 	/* Read the config of _child_ submodules. */
-	print_config_from_gitmodules(&submodule, argv[2]);
+	print_config_from_gitmodules(&subrepo, argv[2]);
 
 	submodule_free(the_repository);
 
-- 
2.19.0

