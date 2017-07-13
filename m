Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A312027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbdGMXt7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:49:59 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59678 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752966AbdGMXtl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 64AC9280B0;
        Thu, 13 Jul 2017 23:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989774;
        bh=rOOCnzdBRoMPePS9Yz6NxtLP+DXvnibuS8Rv0LvBOSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vyo9JTrbXvqDHNP64B4p4wnJRlxjpIMn+jsXku/b6W3ruCiD3MNOk+eDHM0H+jYkn
         GqxiPJoAY228Gx6f6KkWDykfmqCnTVyvMSAas0nx2FDNgOv6UFkqisdydq8ltK6idR
         n6jgJqrm0vzkZPxHxZeq+x0Q5zKAbtg8SHVrghRiVThpnfEEJAcLp18HtPI31HZWY5
         QyLQculWNSDEOUFewPCAvmHU83TV6VhBd49ftVcPTnCUxDqsEPdRvMN4sRHhV+SK8N
         IEo9yy3+r7rXFoGvBgPdMUQ4mxkYlSiW0JJF4coJuvbtZuzx1tllI1g8pLryNraudy
         TxnqadZdq3eCgDujUv6fBpqR4+zf7uu8L0AJnUTkBROfQZQtRei/AAMhs+hG7lbpAY
         Qvw/Dl/xbVnBJLCBuRU1/30CtGYSLH13AL/AQaFi8pgrMhExJZV32YUMmzQF6UZ4AB
         OjHWlFF6sN5Vmu2lr8Ms+tJU5cq5+p8/t9EVeROOj/sHHyzZVW+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 03/13] submodule: convert submodule config lookup to use object_id
Date:   Thu, 13 Jul 2017 23:49:20 +0000
Message-Id: <20170713234930.949612-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/grep.c                   |  4 ++--
 builtin/submodule--helper.c      |  8 ++++----
 config.c                         | 12 ++++++------
 config.h                         |  4 ++--
 repository.c                     |  2 +-
 submodule-config.c               | 38 +++++++++++++++++++-------------------
 submodule-config.h               | 12 ++++++------
 submodule.c                      | 32 ++++++++++++++++----------------
 submodule.h                      |  2 +-
 t/helper/test-submodule-config.c | 10 +++++-----
 10 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fa351c49f4..89fcb5b337 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -653,7 +653,7 @@ static int grep_submodule(struct grep_opt *opt, const struct object_id *oid,
 		 */
 		if (oid) {
 			const struct submodule *sub =
-					submodule_from_path(null_sha1, path);
+					submodule_from_path(&null_oid, path);
 			if (sub)
 				path = git_path("modules/%s", sub->name);
 
@@ -862,7 +862,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
 			submodule_free();
-			gitmodules_config_sha1(real_obj->oid.hash);
+			gitmodules_config_oid(&real_obj->oid);
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path)) {
 			hit = 1;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6abdad3294..af871f14e7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -350,7 +350,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	} else
 		displaypath = xstrdup(path);
 
-	sub = submodule_from_path(null_sha1, path);
+	sub = submodule_from_path(&null_oid, path);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -476,7 +476,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
 		usage(_("git submodule--helper name <path>"));
 
 	gitmodules_config();
-	sub = submodule_from_path(null_sha1, argv[1]);
+	sub = submodule_from_path(&null_oid, argv[1]);
 
 	if (!sub)
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -795,7 +795,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
-	sub = submodule_from_path(null_sha1, ce->name);
+	sub = submodule_from_path(&null_oid, ce->name);
 
 	if (suc->recursive_prefix)
 		displaypath = relative_path(suc->recursive_prefix,
@@ -1060,7 +1060,7 @@ static const char *remote_submodule_branch(const char *path)
 	gitmodules_config();
 	git_config(submodule_config, NULL);
 
-	sub = submodule_from_path(null_sha1, path);
+	sub = submodule_from_path(&null_oid, path);
 	if (!sub)
 		return NULL;
 
diff --git a/config.c b/config.c
index a9356c1383..014151d032 100644
--- a/config.c
+++ b/config.c
@@ -1460,9 +1460,9 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
 	return do_config_from(&top, fn, data);
 }
 
-int git_config_from_blob_sha1(config_fn_t fn,
+int git_config_from_blob_oid(config_fn_t fn,
 			      const char *name,
-			      const unsigned char *sha1,
+			      const struct object_id *oid,
 			      void *data)
 {
 	enum object_type type;
@@ -1470,7 +1470,7 @@ int git_config_from_blob_sha1(config_fn_t fn,
 	unsigned long size;
 	int ret;
 
-	buf = read_sha1_file(sha1, &type, &size);
+	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
 		return error("unable to load config blob object '%s'", name);
 	if (type != OBJ_BLOB) {
@@ -1488,11 +1488,11 @@ static int git_config_from_blob_ref(config_fn_t fn,
 				    const char *name,
 				    void *data)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
-	if (get_sha1(name, sha1) < 0)
+	if (get_oid(name, &oid) < 0)
 		return error("unable to resolve config blob '%s'", name);
-	return git_config_from_blob_sha1(fn, name, sha1, data);
+	return git_config_from_blob_oid(fn, name, &oid, data);
 }
 
 const char *git_etc_gitconfig(void)
diff --git a/config.h b/config.h
index 0352da117b..827f2b0e4a 100644
--- a/config.h
+++ b/config.h
@@ -39,8 +39,8 @@ extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
-extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
-				     const unsigned char *sha1, void *data);
+extern int git_config_from_blob_oid(config_fn_t fn, const char *name,
+				    const struct object_id *oid, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern void read_early_config(config_fn_t cb, void *data);
diff --git a/repository.c b/repository.c
index edca907404..1617467568 100644
--- a/repository.c
+++ b/repository.c
@@ -158,7 +158,7 @@ int repo_submodule_init(struct repository *submodule,
 	struct strbuf worktree = STRBUF_INIT;
 	int ret = 0;
 
-	sub = submodule_from_cache(superproject, null_sha1, path);
+	sub = submodule_from_cache(superproject, &null_oid, path);
 	if (!sub) {
 		ret = -1;
 		goto out;
diff --git a/submodule-config.c b/submodule-config.c
index 37cfcceb95..89de1d6a53 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -417,19 +417,19 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
-int gitmodule_sha1_from_commit(const unsigned char *treeish_name,
-				      unsigned char *gitmodules_sha1,
+int gitmodule_oid_from_commit(const struct object_id *treeish_name,
+				      struct object_id *gitmodules_oid,
 				      struct strbuf *rev)
 {
 	int ret = 0;
 
-	if (is_null_sha1(treeish_name)) {
-		hashclr(gitmodules_sha1);
+	if (is_null_oid(treeish_name)) {
+		oidclr(gitmodules_oid);
 		return 1;
 	}
 
-	strbuf_addf(rev, "%s:.gitmodules", sha1_to_hex(treeish_name));
-	if (get_sha1(rev->buf, gitmodules_sha1) >= 0)
+	strbuf_addf(rev, "%s:.gitmodules", oid_to_hex(treeish_name));
+	if (get_oid(rev->buf, gitmodules_oid) >= 0)
 		ret = 1;
 
 	return ret;
@@ -440,13 +440,13 @@ int gitmodule_sha1_from_commit(const unsigned char *treeish_name,
  * revisions.
  */
 static const struct submodule *config_from(struct submodule_cache *cache,
-		const unsigned char *treeish_name, const char *key,
+		const struct object_id *treeish_name, const char *key,
 		enum lookup_type lookup_type)
 {
 	struct strbuf rev = STRBUF_INIT;
 	unsigned long config_size;
 	char *config = NULL;
-	unsigned char sha1[20];
+	struct object_id oid;
 	enum object_type type;
 	const struct submodule *submodule = NULL;
 	struct parse_config_parameter parameter;
@@ -466,28 +466,28 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		return entry->config;
 	}
 
-	if (!gitmodule_sha1_from_commit(treeish_name, sha1, &rev))
+	if (!gitmodule_oid_from_commit(treeish_name, &oid, &rev))
 		goto out;
 
 	switch (lookup_type) {
 	case lookup_name:
-		submodule = cache_lookup_name(cache, sha1, key);
+		submodule = cache_lookup_name(cache, oid.hash, key);
 		break;
 	case lookup_path:
-		submodule = cache_lookup_path(cache, sha1, key);
+		submodule = cache_lookup_path(cache, oid.hash, key);
 		break;
 	}
 	if (submodule)
 		goto out;
 
-	config = read_sha1_file(sha1, &type, &config_size);
+	config = read_sha1_file(oid.hash, &type, &config_size);
 	if (!config || type != OBJ_BLOB)
 		goto out;
 
 	/* fill the submodule config into the cache */
 	parameter.cache = cache;
-	parameter.treeish_name = treeish_name;
-	parameter.gitmodules_sha1 = sha1;
+	parameter.treeish_name = treeish_name->hash;
+	parameter.gitmodules_sha1 = oid.hash;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
 			config, config_size, &parameter);
@@ -496,9 +496,9 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
 	switch (lookup_type) {
 	case lookup_name:
-		return cache_lookup_name(cache, sha1, key);
+		return cache_lookup_name(cache, oid.hash, key);
 	case lookup_path:
-		return cache_lookup_path(cache, sha1, key);
+		return cache_lookup_path(cache, oid.hash, key);
 	default:
 		return NULL;
 	}
@@ -540,14 +540,14 @@ int parse_submodule_config_option(const char *var, const char *value)
 	return submodule_config_option(the_repository, var, value);
 }
 
-const struct submodule *submodule_from_name(const unsigned char *treeish_name,
+const struct submodule *submodule_from_name(const struct object_id *treeish_name,
 		const char *name)
 {
 	submodule_cache_check_init(the_repository);
 	return config_from(the_repository->submodule_cache, treeish_name, name, lookup_name);
 }
 
-const struct submodule *submodule_from_path(const unsigned char *treeish_name,
+const struct submodule *submodule_from_path(const struct object_id *treeish_name,
 		const char *path)
 {
 	submodule_cache_check_init(the_repository);
@@ -555,7 +555,7 @@ const struct submodule *submodule_from_path(const unsigned char *treeish_name,
 }
 
 const struct submodule *submodule_from_cache(struct repository *repo,
-					     const unsigned char *treeish_name,
+					     const struct object_id *treeish_name,
 					     const char *key)
 {
 	submodule_cache_check_init(repo);
diff --git a/submodule-config.h b/submodule-config.h
index bc45a25e85..5f52e6567b 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -34,15 +34,15 @@ extern int parse_submodule_config_option(const char *var, const char *value);
 extern int submodule_config_option(struct repository *repo,
 				   const char *var, const char *value);
 extern const struct submodule *submodule_from_name(
-		const unsigned char *commit_or_tree, const char *name);
+		const struct object_id *commit_or_tree, const char *name);
 extern const struct submodule *submodule_from_path(
-		const unsigned char *commit_or_tree, const char *path);
+		const struct object_id *commit_or_tree, const char *path);
 extern const struct submodule *submodule_from_cache(struct repository *repo,
-						    const unsigned char *treeish_name,
+						    const struct object_id *treeish_name,
 						    const char *key);
-extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
-				      unsigned char *gitmodules_sha1,
-				      struct strbuf *rev);
+extern int gitmodule_oid_from_commit(const struct object_id *commit_oid,
+				     struct object_id *gitmodules_oid,
+				     struct strbuf *rev);
 extern void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index da2b484879..f39cb4f6ea 100644
--- a/submodule.c
+++ b/submodule.c
@@ -69,7 +69,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (gitmodules_is_unmerged)
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(null_sha1, oldpath);
+	submodule = submodule_from_path(&null_oid, oldpath);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
 		return -1;
@@ -103,7 +103,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (gitmodules_is_unmerged)
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(null_sha1, path);
+	submodule = submodule_from_path(&null_oid, path);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), path);
 		return -1;
@@ -147,7 +147,7 @@ static int add_submodule_odb(const char *path)
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
-	const struct submodule *submodule = submodule_from_path(null_sha1, path);
+	const struct submodule *submodule = submodule_from_path(&null_oid, path);
 	if (submodule) {
 		if (submodule->ignore)
 			handle_ignore_submodules_arg(diffopt, submodule->ignore);
@@ -270,14 +270,14 @@ void repo_read_gitmodules(struct repository *repo)
 	free(gitmodules_path);
 }
 
-void gitmodules_config_sha1(const unsigned char *commit_sha1)
+void gitmodules_config_oid(const struct object_id *commit_oid)
 {
 	struct strbuf rev = STRBUF_INIT;
-	unsigned char sha1[20];
+	struct object_id oid;
 
-	if (gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
-		git_config_from_blob_sha1(git_modules_config, rev.buf,
-					  sha1, NULL);
+	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
+		git_config_from_blob_oid(submodule_config, rev.buf,
+					 &oid, NULL);
 	}
 	strbuf_release(&rev);
 }
@@ -293,7 +293,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 	const struct string_list *sl;
 	const struct submodule *module;
 
-	module = submodule_from_cache(repo, null_sha1, path);
+	module = submodule_from_cache(repo, &null_oid, path);
 
 	/* early return if there isn't a path->module mapping */
 	if (!module)
@@ -738,7 +738,7 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	if (!should_update_submodules())
 		return NULL;
 
-	return submodule_from_path(null_sha1, ce->name);
+	return submodule_from_path(&null_oid, ce->name);
 }
 
 static struct oid_array *submodule_commits(struct string_list *submodules,
@@ -1166,9 +1166,9 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		submodule = submodule_from_path(null_sha1, ce->name);
+		submodule = submodule_from_path(&null_oid, ce->name);
 		if (!submodule)
-			submodule = submodule_from_name(null_sha1, ce->name);
+			submodule = submodule_from_name(&null_oid, ce->name);
 
 		default_argv = "yes";
 		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
@@ -1544,7 +1544,7 @@ int submodule_move_head(const char *path,
 	if (old && !is_submodule_populated_gently(path, error_code_ptr))
 		return 0;
 
-	sub = submodule_from_path(null_sha1, path);
+	sub = submodule_from_path(&null_oid, path);
 
 	if (!sub)
 		die("BUG: could not get submodule information for '%s'", path);
@@ -1826,7 +1826,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 
 	real_old_git_dir = real_pathdup(old_git_dir, 1);
 
-	sub = submodule_from_path(null_sha1, path);
+	sub = submodule_from_path(&null_oid, path);
 	if (!sub)
 		die(_("could not lookup name for submodule '%s'"), path);
 
@@ -1882,7 +1882,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		* superproject did not rewrite the git file links yet,
 		* fix it now.
 		*/
-		sub = submodule_from_path(null_sha1, path);
+		sub = submodule_from_path(&null_oid, path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
 		connect_work_tree_and_git_dir(path,
@@ -2025,7 +2025,7 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 	}
 	if (!is_git_directory(buf->buf)) {
 		gitmodules_config();
-		sub = submodule_from_path(null_sha1, submodule);
+		sub = submodule_from_path(&null_oid, submodule);
 		if (!sub) {
 			ret = -1;
 			goto cleanup;
diff --git a/submodule.h b/submodule.h
index 623ce6ad77..93411bdffd 100644
--- a/submodule.h
+++ b/submodule.h
@@ -48,7 +48,7 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 void load_submodule_cache(void);
 extern void gitmodules_config(void);
 extern void repo_read_gitmodules(struct repository *repo);
-extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
+extern void gitmodules_config_oid(const struct object_id *commit_oid);
 extern int is_submodule_active(struct repository *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index c6c57bba0d..e13fbcc1b5 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -41,7 +41,7 @@ int cmd_main(int argc, const char **argv)
 	git_config(git_test_config, NULL);
 
 	while (*arg) {
-		unsigned char commit_sha1[20];
+		struct object_id commit_oid;
 		const struct submodule *submodule;
 		const char *commit;
 		const char *path_or_name;
@@ -50,14 +50,14 @@ int cmd_main(int argc, const char **argv)
 		path_or_name = arg[1];
 
 		if (commit[0] == '\0')
-			hashclr(commit_sha1);
-		else if (get_sha1(commit, commit_sha1) < 0)
+			oidclr(&commit_oid);
+		else if (get_oid(commit, &commit_oid) < 0)
 			die_usage(argc, argv, "Commit not found.");
 
 		if (lookup_name) {
-			submodule = submodule_from_name(commit_sha1, path_or_name);
+			submodule = submodule_from_name(&commit_oid, path_or_name);
 		} else
-			submodule = submodule_from_path(commit_sha1, path_or_name);
+			submodule = submodule_from_path(&commit_oid, path_or_name);
 		if (!submodule)
 			die_usage(argc, argv, "Submodule not found.");
 
