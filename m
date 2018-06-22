Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191BE1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934377AbeFVQ1x (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:27:53 -0400
Received: from ao2.it ([92.243.12.208]:53094 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934382AbeFVQ1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:27:37 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fWOtn-0007WW-10; Fri, 22 Jun 2018 18:26:59 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fWOuK-00053H-2J; Fri, 22 Jun 2018 18:27:32 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 3/7] submodule-config: add helper to get 'update-clone' config from .gitmodules
Date:   Fri, 22 Jun 2018 18:26:52 +0200
Message-Id: <20180622162656.19338-4-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180622162656.19338-1-ao2@ao2.it>
References: <20180622162656.19338-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper function to make it clearer that retrieving 'update-clone'
configuration from the .gitmodules file is a special case supported
solely for backward compatibility purposes.

This change removes one direct use of 'config_from_gitmodules' for
options not strictly related to submodules: "submodule.fetchobjs" does
not describe a property of a submodule, but a behavior of other commands
when dealing with submodules, so it does not really belong to the
.gitmodules file.

This is in the effort to communicate better that .gitmodules is not to
be used as a mechanism to store arbitrary configuration in the
repository that any command can retrieve.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/submodule--helper.c |  8 ++++----
 submodule-config.c          | 14 ++++++++++++++
 submodule-config.h          |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bd250ca21..d450b81da 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1562,8 +1562,8 @@ static int update_clone_task_finished(int result,
 	return 0;
 }
 
-static int gitmodules_update_clone_config(const char *var, const char *value,
-					  void *cb)
+static int git_update_clone_config(const char *var, const char *value,
+				   void *cb)
 {
 	int *max_jobs = cb;
 	if (!strcmp(var, "submodule.fetchjobs"))
@@ -1613,8 +1613,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 	suc.prefix = prefix;
 
-	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
-	git_config(gitmodules_update_clone_config, &max_jobs);
+	update_clone_config_from_gitmodules(&max_jobs);
+	git_config(git_update_clone_config, &max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
diff --git a/submodule-config.c b/submodule-config.c
index ef292eb7c..46fb454ae 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -716,3 +716,17 @@ void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
 	};
 	config_from_gitmodules(gitmodules_fetch_config, &config);
 }
+
+static int gitmodules_update_clone_config(const char *var, const char *value,
+					  void *cb)
+{
+	int *max_jobs = cb;
+	if (!strcmp(var, "submodule.fetchjobs"))
+		*max_jobs = parse_submodule_fetchjobs(var, value);
+	return 0;
+}
+
+void update_clone_config_from_gitmodules(int *max_jobs)
+{
+	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
+}
diff --git a/submodule-config.h b/submodule-config.h
index cff297a75..b6f19d0d4 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -67,5 +67,6 @@ int check_submodule_name(const char *name);
 extern void config_from_gitmodules(config_fn_t fn, void *data);
 
 extern void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules);
+extern void update_clone_config_from_gitmodules(int *max_jobs);
 
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.18.0

