Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44480201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbdGCS4R (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:56:17 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52964 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752293AbdGCSzx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3C317280B0;
        Mon,  3 Jul 2017 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108147;
        bh=j5jNTdb2mXWDvi/VCHFWBtzTj24a0aSAo/VeRJz7DcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYLZLzVWUAZMXhxSOE/vLdZfHHzX9QlZZIz9EoFb2oBqSnbYAe21VxKLf3lgwY9dc
         9MgMf8NVa9SCSi3MzvAHoD20Hpf4G2kjz/sfq4iONeTLkx42CsW7DVAKdTdRrVPHPw
         MtMhc1B8a6p/9hu0kHA4fZWGwHPuaF6eqURP0LL3DQXEj0X4hIoDJkVLogl/bCsZm2
         SVOzNh9KcGWCFTlPKCf4amodcMbGNThU6YUXzReSm5vre918OaWU7Oxln3lQhnfOuQ
         Chg0n5JXfn8XI/1Ps7Mg/r3a9LZdkMY+H1Yv0sLIabhvMnS3RrZNrVSMH3ZBSl7MiS
         L2rc32oAmm8EHlzEQJrQ7udw0vldQEIIrm5x8rBFQaLbtECZy+Sqq4M02moqv/mf47
         x6GxdHrNwKQqHGLSNy8NlmTsZWQQeeUVqvuabaIROKz4gpaYC7X/xslL7KuKPqVS+u
         NPh41hPvQwHB33HMIrEsP1M6jVQIQ1E5oV/Ok+uumLD4O9KdLS5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 03/12] submodule: convert submodule config lookup to use object_id
Date:   Mon,  3 Jul 2017 18:55:24 +0000
Message-Id: <20170703185533.51530-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
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
 submodule-config.c               | 36 ++++++++++++++++++------------------
 submodule-config.h               | 10 +++++-----
 submodule.c                      | 32 ++++++++++++++++----------------
 submodule.h                      |  2 +-
 t/helper/test-submodule-config.c | 10 +++++-----
 9 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index f752f642f..397b5f049 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -652,7 +652,7 @@ static int grep_submodule(struct grep_opt *opt, const struct object_id *oid,
 		 */
 		if (oid) {
 			const struct submodule *sub =
-					submodule_from_path(null_sha1, path);
+					submodule_from_path(&null_oid, path);
 			if (sub)
 				path = git_path("modules/%s", sub->name);
 
@@ -861,7 +861,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
 			submodule_free();
-			gitmodules_config_sha1(real_obj->oid.hash);
+			gitmodules_config_oid(&real_obj->oid);
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path)) {
 			hit = 1;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8517032b3..45cb93287 100644
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
index 1cd40a5fe..eb2dae5fb 100644
--- a/config.c
+++ b/config.c
@@ -1466,9 +1466,9 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
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
@@ -1476,7 +1476,7 @@ int git_config_from_blob_sha1(config_fn_t fn,
 	unsigned long size;
 	int ret;
 
-	buf = read_sha1_file(sha1, &type, &size);
+	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
 		return error("unable to load config blob object '%s'", name);
 	if (type != OBJ_BLOB) {
@@ -1494,11 +1494,11 @@ static int git_config_from_blob_ref(config_fn_t fn,
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
index 9e038cce2..033920048 100644
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
diff --git a/submodule-config.c b/submodule-config.c
index d8f8d5ea3..ad2c447b8 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -402,19 +402,19 @@ static int parse_config(const char *var, const char *value, void *data)
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
@@ -425,13 +425,13 @@ int gitmodule_sha1_from_commit(const unsigned char *treeish_name,
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
@@ -451,28 +451,28 @@ static const struct submodule *config_from(struct submodule_cache *cache,
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
@@ -481,9 +481,9 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
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
@@ -515,14 +515,14 @@ int parse_submodule_config_option(const char *var, const char *value)
 	return parse_config(var, value, &parameter);
 }
 
-const struct submodule *submodule_from_name(const unsigned char *treeish_name,
+const struct submodule *submodule_from_name(const struct object_id *treeish_name,
 		const char *name)
 {
 	ensure_cache_init();
 	return config_from(&the_submodule_cache, treeish_name, name, lookup_name);
 }
 
-const struct submodule *submodule_from_path(const unsigned char *treeish_name,
+const struct submodule *submodule_from_path(const struct object_id *treeish_name,
 		const char *path)
 {
 	ensure_cache_init();
diff --git a/submodule-config.h b/submodule-config.h
index d434ecdb4..ab37558e7 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -27,12 +27,12 @@ extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_submodule_config_option(const char *var, const char *value);
 extern const struct submodule *submodule_from_name(
-		const unsigned char *commit_or_tree, const char *name);
+		const struct object_id *commit_or_tree, const char *name);
 extern const struct submodule *submodule_from_path(
-		const unsigned char *commit_or_tree, const char *path);
-extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
-				      unsigned char *gitmodules_sha1,
-				      struct strbuf *rev);
+		const struct object_id *commit_or_tree, const char *path);
+extern int gitmodule_oid_from_commit(const struct object_id *commit_oid,
+				     struct object_id *gitmodules_oid,
+				     struct strbuf *rev);
 extern void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index 71e0c5a85..d3fee650a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -68,7 +68,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (gitmodules_is_unmerged)
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(null_sha1, oldpath);
+	submodule = submodule_from_path(&null_oid, oldpath);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
 		return -1;
@@ -102,7 +102,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (gitmodules_is_unmerged)
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(null_sha1, path);
+	submodule = submodule_from_path(&null_oid, path);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), path);
 		return -1;
@@ -146,7 +146,7 @@ static int add_submodule_odb(const char *path)
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
-	const struct submodule *submodule = submodule_from_path(null_sha1, path);
+	const struct submodule *submodule = submodule_from_path(&null_oid, path);
 	if (submodule) {
 		if (submodule->ignore)
 			handle_ignore_submodules_arg(diffopt, submodule->ignore);
@@ -255,14 +255,14 @@ void gitmodules_config(void)
 	}
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
@@ -282,7 +282,7 @@ int is_submodule_initialized(const char *path)
 	char *key = NULL;
 	char *value = NULL;
 	const struct string_list *sl;
-	const struct submodule *module = submodule_from_path(null_sha1, path);
+	const struct submodule *module = submodule_from_path(&null_oid, path);
 
 	/* early return if there isn't a path->module mapping */
 	if (!module)
@@ -727,7 +727,7 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	if (!should_update_submodules())
 		return NULL;
 
-	return submodule_from_path(null_sha1, ce->name);
+	return submodule_from_path(&null_oid, ce->name);
 }
 
 static struct oid_array *submodule_commits(struct string_list *submodules,
@@ -1155,9 +1155,9 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		submodule = submodule_from_path(null_sha1, ce->name);
+		submodule = submodule_from_path(&null_oid, ce->name);
 		if (!submodule)
-			submodule = submodule_from_name(null_sha1, ce->name);
+			submodule = submodule_from_name(&null_oid, ce->name);
 
 		default_argv = "yes";
 		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
@@ -1533,7 +1533,7 @@ int submodule_move_head(const char *path,
 	if (old && !is_submodule_populated_gently(path, error_code_ptr))
 		return 0;
 
-	sub = submodule_from_path(null_sha1, path);
+	sub = submodule_from_path(&null_oid, path);
 
 	if (!sub)
 		die("BUG: could not get submodule information for '%s'", path);
@@ -1815,7 +1815,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 
 	real_old_git_dir = real_pathdup(old_git_dir, 1);
 
-	sub = submodule_from_path(null_sha1, path);
+	sub = submodule_from_path(&null_oid, path);
 	if (!sub)
 		die(_("could not lookup name for submodule '%s'"), path);
 
@@ -1871,7 +1871,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		* superproject did not rewrite the git file links yet,
 		* fix it now.
 		*/
-		sub = submodule_from_path(null_sha1, path);
+		sub = submodule_from_path(&null_oid, path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
 		connect_work_tree_and_git_dir(path,
@@ -2014,7 +2014,7 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 	}
 	if (!is_git_directory(buf->buf)) {
 		gitmodules_config();
-		sub = submodule_from_path(null_sha1, submodule);
+		sub = submodule_from_path(&null_oid, submodule);
 		if (!sub) {
 			ret = -1;
 			goto cleanup;
diff --git a/submodule.h b/submodule.h
index cbe5c1726..5110caff4 100644
--- a/submodule.h
+++ b/submodule.h
@@ -46,7 +46,7 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
 void load_submodule_cache(void);
 extern void gitmodules_config(void);
-extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
+extern void gitmodules_config_oid(const struct object_id *commit_oid);
 extern int is_submodule_initialized(const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index c6c57bba0..e13fbcc1b 100644
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
 
