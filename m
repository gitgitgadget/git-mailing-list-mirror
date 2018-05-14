Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646E61F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeENK7N (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:59:13 -0400
Received: from ao2.it ([92.243.12.208]:53801 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752554AbeENK7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:59:03 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fIBBq-00075Q-GB; Mon, 14 May 2018 12:58:50 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fIBC1-0002CN-Dm; Mon, 14 May 2018 12:59:01 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH 09/10] submodule: support reading .gitmodules even when it's not checked out
Date:   Mon, 14 May 2018 12:58:22 +0200
Message-Id: <20180514105823.8378-10-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the .gitmodules file is not available in the working directory, try
using HEAD:.gitmodules from the index. This covers the case when the
file is part of the repository but for some reason it is not checked
out, for example because of a sparse checkout.

This makes it possible to use at least the 'git submodule' commands
which *read* the gitmodules configuration file without fully populating
the work dir.

Writing to .gitmodules wills still require that the file is checked out,
so check for that in config_gitmodules_set.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

I am doing the is_gitmodules_hidden() check in the open for now, I am not sure
whether it is approprate to do that inside stage_updated_gitmodules.

 builtin/mv.c                |  2 ++
 builtin/rm.c                |  7 +++++--
 builtin/submodule--helper.c | 21 ++++++++++++++++++++-
 cache.h                     |  1 +
 config.c                    | 15 +++++++++++++--
 submodule.c                 | 15 +++++++++++++++
 submodule.h                 |  1 +
 7 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 7a63667d6..41fd9b7be 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -83,6 +83,8 @@ static void prepare_move_submodule(const char *src, int first,
 		die(_("Directory %s is in index and no submodule?"), src);
 	if (!is_staging_gitmodules_ok(&the_index))
 		die(_("Please stage your changes to .gitmodules or stash them to proceed"));
+	if (is_gitmodules_hidden(&the_index))
+		die(_("cannot work with hidden submodule config"));
 	strbuf_addf(&submodule_dotgit, "%s/.git", src);
 	*submodule_gitfile = read_gitfile(submodule_dotgit.buf);
 	if (*submodule_gitfile)
diff --git a/builtin/rm.c b/builtin/rm.c
index 5b6fc7ee8..e3526a342 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -284,9 +284,12 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
 		list.entry[list.nr].name = xstrdup(ce->name);
 		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
-		if (list.entry[list.nr++].is_submodule &&
-		    !is_staging_gitmodules_ok(&the_index))
+		if (list.entry[list.nr++].is_submodule) {
+		    if (!is_staging_gitmodules_ok(&the_index))
 			die (_("Please stage your changes to .gitmodules or stash them to proceed"));
+		    if (is_gitmodules_hidden(&the_index))
+			die(_("cannot work with hidden submodule config"));
+		}
 	}
 
 	if (pathspec.nr) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index de5caa776..b3bdb4b66 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1873,6 +1873,9 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		if (read_cache() < 0)
 			die(_("index file corrupt"));
 
+		if (is_gitmodules_hidden(&the_index))
+			die(_("cannot stage changes to hidden submodule config"));
+
 		stage_updated_gitmodules(&the_index);
 
 		if (write_locked_index(&the_index, &lock_file,
@@ -1897,8 +1900,24 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Equivalent to ACTION_SET in builtin/config.c */
-	if (argc == 3)
+	if (argc == 3) {
+		struct object_id oid;
+
+		/* 
+		 * If the .gitmodules file is not in the work tree but it is
+		 * in the index, stop, as writing new values and staging them
+		 * would blindly overwrite ALL the old content.
+		 *
+		 * Do not use is_gitmodules_hidden() here, to gracefully
+		 * handle the case when .gitmodules is neither in the work
+		 * tree nor in the index, i.e.: a new GITMODULES_FILE is going
+		 * to be created.
+		 */
+		if (!file_exists(GITMODULES_FILE) && get_oid(GITMODULES_BLOB, &oid) >= 0)
+			die(_("cannot change unchecked out .gitmodules, check it out first"));
+
 		return config_gitmodules_set(argv[1], argv[2]);
+	}
 
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 0c1fb9fbc..6d45b0cbb 100644
--- a/cache.h
+++ b/cache.h
@@ -417,6 +417,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
 #define GITMODULES_FILE ".gitmodules"
+#define GITMODULES_BLOB "HEAD:.gitmodules"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
diff --git a/config.c b/config.c
index 8ffe29330..7d9744622 100644
--- a/config.c
+++ b/config.c
@@ -2184,8 +2184,19 @@ int git_config_get_pathname(const char *key, const char **dest)
 void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
 {
 	if (repo->worktree) {
-		char *file = repo_worktree_path(repo, GITMODULES_FILE);
-		git_config_from_file(fn, file, data);
+		struct git_config_source config_source = { 0 };
+		const struct config_options opts = { 0 };
+		struct object_id oid;
+		char *file;
+
+		file = repo_worktree_path(repo, GITMODULES_FILE);
+		if (file_exists(file))
+			config_source.file = file;
+		else if (get_oid(GITMODULES_BLOB, &oid) >= 0)
+			config_source.blob = GITMODULES_BLOB;
+
+		config_with_options(fn, data, &config_source, &opts);
+
 		free(file);
 	}
 }
diff --git a/submodule.c b/submodule.c
index 7cfae89b6..83d0ca5a6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -50,6 +50,21 @@ int is_gitmodules_unmerged(const struct index_state *istate)
 	return 0;
 }
 
+/*
+ * Check if the .gitmodules file is in the index but it is marked as hidden,
+ * like for example via a sparse checkout.
+ */
+int is_gitmodules_hidden(const struct index_state *istate)
+{
+	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
+
+	if (pos >= 0) {
+		return ce_skip_worktree(istate->cache[pos]);
+	}
+
+	return 0;
+}
+
 /*
  * Check if the .gitmodules file has unstaged modifications.  This must be
  * checked before allowing modifications to the .gitmodules file with the
diff --git a/submodule.h b/submodule.h
index 8a252e514..4ec9a3781 100644
--- a/submodule.h
+++ b/submodule.h
@@ -34,6 +34,7 @@ struct submodule_update_strategy {
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
 extern int is_gitmodules_unmerged(const struct index_state *istate);
+extern int is_gitmodules_hidden(const struct index_state *istate);
 extern int is_staging_gitmodules_ok(struct index_state *istate);
 extern int config_gitmodules_set(const char *key, const char *value);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
-- 
2.17.0

