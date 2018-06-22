Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3520A1F597
	for <e@80x24.org>; Fri, 22 Jun 2018 16:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934392AbeFVQ1i (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:27:38 -0400
Received: from ao2.it ([92.243.12.208]:53076 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934345AbeFVQ1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:27:34 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fWOtm-0007WV-St; Fri, 22 Jun 2018 18:26:58 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fWOuK-00053L-9z; Fri, 22 Jun 2018 18:27:32 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 5/7] submodule-config: pass repository as argument to config_from_gitmodules
Date:   Fri, 22 Jun 2018 18:26:54 +0200
Message-Id: <20180622162656.19338-6-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180622162656.19338-1-ao2@ao2.it>
References: <20180622162656.19338-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Generlize config_from_gitmodules to accept a repository as an argument.

This is in preparation to reuse the function in repo_read_gitmodules in
order to have a single point where the '.gitmodules' file is accessed.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 submodule-config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 6a9f4b6d1..e50c944eb 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -680,10 +680,10 @@ void submodule_free(struct repository *r)
  * Runs the provided config function on the '.gitmodules' file found in the
  * working directory.
  */
-static void config_from_gitmodules(config_fn_t fn, void *data)
+static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
 {
-	if (the_repository->worktree) {
-		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
+	if (repo->worktree) {
+		char *file = repo_worktree_path(repo, GITMODULES_FILE);
 		git_config_from_file(fn, file, data);
 		free(file);
 	}
@@ -714,7 +714,7 @@ void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
 		.max_children = max_children,
 		.recurse_submodules = recurse_submodules
 	};
-	config_from_gitmodules(gitmodules_fetch_config, &config);
+	config_from_gitmodules(gitmodules_fetch_config, the_repository, &config);
 }
 
 static int gitmodules_update_clone_config(const char *var, const char *value,
@@ -728,5 +728,5 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 
 void update_clone_config_from_gitmodules(int *max_jobs)
 {
-	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
+	config_from_gitmodules(gitmodules_update_clone_config, the_repository, &max_jobs);
 }
-- 
2.18.0

