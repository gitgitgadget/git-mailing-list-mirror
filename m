Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7DF71F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934381AbeFVQ1g (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:27:36 -0400
Received: from ao2.it ([92.243.12.208]:53080 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934349AbeFVQ1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:27:35 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fWOtn-0007WY-2o; Fri, 22 Jun 2018 18:26:59 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fWOuK-00053N-Dr; Fri, 22 Jun 2018 18:27:32 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 6/7] submodule-config: reuse config_from_gitmodules in repo_read_gitmodules
Date:   Fri, 22 Jun 2018 18:26:55 +0200
Message-Id: <20180622162656.19338-7-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180622162656.19338-1-ao2@ao2.it>
References: <20180622162656.19338-1-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reuse config_from_gitmodules in repo_read_gitmodules to remove some
duplication and also have a single point where the .gitmodules file is
read.

The change does not introduce any new behavior, the same gitmodules_cb
config callback is still used which only deals with configuration
specific to submodules.

The config_from_gitmodules function is moved up in the file —unchanged—
before its users to avoid a forward declaration.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 submodule-config.c | 50 +++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index e50c944eb..ce204fb53 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -591,6 +591,23 @@ static void submodule_cache_check_init(struct repository *repo)
 	submodule_cache_init(repo->submodule_cache);
 }
 
+/*
+ * Note: This function is private for a reason, the '.gitmodules' file should
+ * not be used as as a mechanism to retrieve arbitrary configuration stored in
+ * the repository.
+ *
+ * Runs the provided config function on the '.gitmodules' file found in the
+ * working directory.
+ */
+static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
+{
+	if (repo->worktree) {
+		char *file = repo_worktree_path(repo, GITMODULES_FILE);
+		git_config_from_file(fn, file, data);
+		free(file);
+	}
+}
+
 static int gitmodules_cb(const char *var, const char *value, void *data)
 {
 	struct repository *repo = data;
@@ -608,19 +625,11 @@ void repo_read_gitmodules(struct repository *repo)
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
@@ -672,23 +681,6 @@ void submodule_free(struct repository *r)
 		submodule_cache_clear(r->submodule_cache);
 }
 
-/*
- * Note: This function is private for a reason, the '.gitmodules' file should
- * not be used as as a mechanism to retrieve arbitrary configuration stored in
- * the repository.
- *
- * Runs the provided config function on the '.gitmodules' file found in the
- * working directory.
- */
-static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
-{
-	if (repo->worktree) {
-		char *file = repo_worktree_path(repo, GITMODULES_FILE);
-		git_config_from_file(fn, file, data);
-		free(file);
-	}
-}
-
 struct fetch_config {
 	int *max_children;
 	int *recurse_submodules;
-- 
2.18.0

