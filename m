Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2A11F516
	for <e@80x24.org>; Tue, 26 Jun 2018 10:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934507AbeFZKra (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 06:47:30 -0400
Received: from ao2.it ([92.243.12.208]:57527 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934343AbeFZKr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 06:47:29 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fXlUm-0002X0-JG; Tue, 26 Jun 2018 12:46:48 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fXlVO-0002Zt-1r; Tue, 26 Jun 2018 12:47:26 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v2 1/6] config: move config_from_gitmodules to submodule-config.c
Date:   Tue, 26 Jun 2018 12:47:05 +0200
Message-Id: <20180626104710.9859-2-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626104710.9859-1-ao2@ao2.it>
References: <20180626104710.9859-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The .gitmodules file is not meant as a place to store arbitrary
configuration to distribute with the repository.

Move config_from_gitmodules() out of config.c and into
submodule-config.c to make it even clearer that it is not a mechanism to
retrieve arbitrary configuration from the .gitmodules file.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 config.c           | 17 -----------------
 config.h           | 10 ----------
 submodule-config.c | 17 +++++++++++++++++
 submodule-config.h | 11 +++++++++++
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/config.c b/config.c
index a0a6ae198..fa78b1ff9 100644
--- a/config.c
+++ b/config.c
@@ -2172,23 +2172,6 @@ int git_config_get_pathname(const char *key, const char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
-/*
- * Note: This function exists solely to maintain backward compatibility with
- * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
- * NOT be used anywhere else.
- *
- * Runs the provided config function on the '.gitmodules' file found in the
- * working directory.
- */
-void config_from_gitmodules(config_fn_t fn, void *data)
-{
-	if (the_repository->worktree) {
-		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
-		git_config_from_file(fn, file, data);
-		free(file);
-	}
-}
-
 int git_config_get_expiry(const char *key, const char **output)
 {
 	int ret = git_config_get_string_const(key, output);
diff --git a/config.h b/config.h
index 626d4654b..b95bb7649 100644
--- a/config.h
+++ b/config.h
@@ -215,16 +215,6 @@ extern int repo_config_get_maybe_bool(struct repository *repo,
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
-
 extern int git_config_get_value(const char *key, const char **value);
 extern const struct string_list *git_config_get_value_multi(const char *key);
 extern void git_config_clear(void);
diff --git a/submodule-config.c b/submodule-config.c
index 388ef1f89..b431555db 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -671,3 +671,20 @@ void submodule_free(struct repository *r)
 	if (r->submodule_cache)
 		submodule_cache_clear(r->submodule_cache);
 }
+
+/*
+ * Note: This function exists solely to maintain backward compatibility with
+ * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
+ * NOT be used anywhere else.
+ *
+ * Runs the provided config function on the '.gitmodules' file found in the
+ * working directory.
+ */
+void config_from_gitmodules(config_fn_t fn, void *data)
+{
+	if (the_repository->worktree) {
+		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
+		git_config_from_file(fn, file, data);
+		free(file);
+	}
+}
diff --git a/submodule-config.h b/submodule-config.h
index ca1f94e2d..5148801f4 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -2,6 +2,7 @@
 #define SUBMODULE_CONFIG_CACHE_H
 
 #include "cache.h"
+#include "config.h"
 #include "hashmap.h"
 #include "submodule.h"
 #include "strbuf.h"
@@ -55,4 +56,14 @@ void submodule_free(struct repository *r);
  */
 int check_submodule_name(const char *name);
 
+/*
+ * Note: This function exists solely to maintain backward compatibility with
+ * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
+ * NOT be used anywhere else.
+ *
+ * Runs the provided config function on the '.gitmodules' file found in the
+ * working directory.
+ */
+extern void config_from_gitmodules(config_fn_t fn, void *data);
+
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.18.0

