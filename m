Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299191F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934386AbeFVQ1h (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:27:37 -0400
Received: from ao2.it ([92.243.12.208]:53082 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934377AbeFVQ1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:27:35 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fWOtn-0007Wa-2l; Fri, 22 Jun 2018 18:26:59 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fWOuK-00053J-6d; Fri, 22 Jun 2018 18:27:32 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 4/7] submodule-config: make 'config_from_gitmodules' private
Date:   Fri, 22 Jun 2018 18:26:53 +0200
Message-Id: <20180622162656.19338-5-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180622162656.19338-1-ao2@ao2.it>
References: <20180622162656.19338-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that 'config_from_gitmodules' is not used in the open, it can be
marked as private.

Hopefully this will prevent its usage for retrieving arbitrary
configuration form the '.gitmodules' file.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 submodule-config.c |  8 ++++----
 submodule-config.h | 12 +++++-------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 46fb454ae..6a9f4b6d1 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -673,14 +673,14 @@ void submodule_free(struct repository *r)
 }
 
 /*
- * Note: This function exists solely to maintain backward compatibility with
- * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
- * NOT be used anywhere else.
+ * Note: This function is private for a reason, the '.gitmodules' file should
+ * not be used as as a mechanism to retrieve arbitrary configuration stored in
+ * the repository.
  *
  * Runs the provided config function on the '.gitmodules' file found in the
  * working directory.
  */
-void config_from_gitmodules(config_fn_t fn, void *data)
+static void config_from_gitmodules(config_fn_t fn, void *data)
 {
 	if (the_repository->worktree) {
 		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
diff --git a/submodule-config.h b/submodule-config.h
index b6f19d0d4..dc7278eea 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -57,15 +57,13 @@ void submodule_free(struct repository *r);
 int check_submodule_name(const char *name);
 
 /*
- * Note: This function exists solely to maintain backward compatibility with
- * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
- * NOT be used anywhere else.
+ * Note: these helper functions exist solely to maintain backward
+ * compatibility with 'fetch' and 'update_clone' storing configuration in
+ * '.gitmodules'.
  *
- * Runs the provided config function on the '.gitmodules' file found in the
- * working directory.
+ * New helpers to retrieve arbitrary configuration from the '.gitmodules' file
+ * should NOT be added.
  */
-extern void config_from_gitmodules(config_fn_t fn, void *data);
-
 extern void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules);
 extern void update_clone_config_from_gitmodules(int *max_jobs);
 
-- 
2.18.0

