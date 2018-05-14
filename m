Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D5961F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeENK7Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:59:16 -0400
Received: from ao2.it ([92.243.12.208]:53778 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752544AbeENK7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:59:03 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fIBBp-000751-GV; Mon, 14 May 2018 12:58:49 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fIBC0-0002C3-Dv; Mon, 14 May 2018 12:59:00 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH 01/10] config: make config_from_gitmodules generally useful
Date:   Mon, 14 May 2018 12:58:14 +0200
Message-Id: <20180514105823.8378-2-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The config_from_gitmodules() function is a good candidate for
a centralized point where to read the gitmodules configuration file.

Add a repo argument to it to make the function more general, and adjust
the current callers in cmd_fetch and update-clone.

As a proof of the utility of the change, start using the function also
in repo_read_gitmodules which was basically doing the same operations.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/fetch.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 config.c                    | 13 +++++++------
 config.h                    | 10 +---------
 submodule-config.c          | 16 ++++------------
 5 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7ee83ac0f..a67ee7c39 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1445,7 +1445,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
-	config_from_gitmodules(gitmodules_fetch_config, NULL);
+	config_from_gitmodules(gitmodules_fetch_config, the_repository, NULL);
 	git_config(git_fetch_config, NULL);
 
 	argc = parse_options(argc, argv, prefix,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c2403a915..9e8f2acd5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1602,7 +1602,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 	suc.prefix = prefix;
 
-	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
+	config_from_gitmodules(gitmodules_update_clone_config, the_repository, &max_jobs);
 	git_config(gitmodules_update_clone_config, &max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
diff --git a/config.c b/config.c
index 6f8f1d8c1..8ffe29330 100644
--- a/config.c
+++ b/config.c
@@ -2173,17 +2173,18 @@ int git_config_get_pathname(const char *key, const char **dest)
 }
 
 /*
- * Note: This function exists solely to maintain backward compatibility with
- * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
- * NOT be used anywhere else.
+ * Note: Initially this function existed solely to maintain backward
+ * compatibility with 'fetch' and 'update_clone' storing configuration in
+ * '.gitmodules' but it turns out it can be useful as a centralized point to
+ * read the gitmodules config file.
  *
  * Runs the provided config function on the '.gitmodules' file found in the
  * working directory.
  */
-void config_from_gitmodules(config_fn_t fn, void *data)
+void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
 {
-	if (the_repository->worktree) {
-		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
+	if (repo->worktree) {
+		char *file = repo_worktree_path(repo, GITMODULES_FILE);
 		git_config_from_file(fn, file, data);
 		free(file);
 	}
diff --git a/config.h b/config.h
index cdac2fc73..43ce76c0f 100644
--- a/config.h
+++ b/config.h
@@ -215,15 +215,7 @@ extern int repo_config_get_maybe_bool(struct repository *repo,
 extern int repo_config_get_pathname(struct repository *repo,
 				    const char *key, const char **dest);
 
-/*
- * Note: This function exists solely to maintain backward compatibility with
- * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
- * NOT be used anywhere else.
- *
- * Runs the provided config function on the '.gitmodules' file found in the
- * working directory.
- */
-extern void config_from_gitmodules(config_fn_t fn, void *data);
+extern void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data);
 
 extern int git_config_get_value(const char *key, const char **value);
 extern const struct string_list *git_config_get_value_multi(const char *key);
diff --git a/submodule-config.c b/submodule-config.c
index d87c3ff63..f39c71dfb 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -577,19 +577,11 @@ void repo_read_gitmodules(struct repository *repo)
 {
 	submodule_cache_check_init(repo);
 
-	if (repo->worktree) {
-		char *gitmodules;
-
-		if (repo_read_index(repo) < 0)
-			return;
-
-		gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
-
-		if (!is_gitmodules_unmerged(repo->index))
-			git_config_from_file(gitmodules_cb, gitmodules, repo);
+	if (repo_read_index(repo) < 0)
+		return;
 
-		free(gitmodules);
-	}
+	if (!is_gitmodules_unmerged(repo->index))
+		config_from_gitmodules(gitmodules_cb, repo, repo);
 
 	repo->submodule_cache->gitmodules_read = 1;
 }
-- 
2.17.0

