Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D9C1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934394AbeFVQ1j (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:27:39 -0400
Received: from ao2.it ([92.243.12.208]:53072 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934312AbeFVQ1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:27:34 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fWOtm-0007WT-MS; Fri, 22 Jun 2018 18:26:58 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fWOuJ-00053F-Tp; Fri, 22 Jun 2018 18:27:31 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 2/7] submodule-config: add helper function to get 'fetch' config from .gitmodules
Date:   Fri, 22 Jun 2018 18:26:51 +0200
Message-Id: <20180622162656.19338-3-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180622162656.19338-1-ao2@ao2.it>
References: <20180622162656.19338-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper function to make it clearer that retrieving 'fetch'
configuration from the .gitmodules file is a special case supported
solely for backward compatibility purposes.

This change removes one direct use of 'config_from_gitmodules' in code
not strictly related to submodules, in the effort to communicate better
that .gitmodules is not to be used as a mechanism to store arbitrary
configuration in the repository that any command can retrieve.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/fetch.c    | 15 +--------------
 submodule-config.c | 28 ++++++++++++++++++++++++++++
 submodule-config.h |  2 ++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669a..92a5d235d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -93,19 +93,6 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, cb);
 }
 
-static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
-{
-	if (!strcmp(var, "submodule.fetchjobs")) {
-		max_children = parse_submodule_fetchjobs(var, value);
-		return 0;
-	} else if (!strcmp(var, "fetch.recursesubmodules")) {
-		recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
-		return 0;
-	}
-
-	return 0;
-}
-
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
 {
 	/*
@@ -1433,7 +1420,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
-	config_from_gitmodules(gitmodules_fetch_config, NULL);
+	fetch_config_from_gitmodules(&max_children, &recurse_submodules);
 	git_config(git_fetch_config, NULL);
 
 	argc = parse_options(argc, argv, prefix,
diff --git a/submodule-config.c b/submodule-config.c
index b431555db..ef292eb7c 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -688,3 +688,31 @@ void config_from_gitmodules(config_fn_t fn, void *data)
 		free(file);
 	}
 }
+
+struct fetch_config {
+	int *max_children;
+	int *recurse_submodules;
+};
+
+static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
+{
+	struct fetch_config *config = cb;
+	if (!strcmp(var, "submodule.fetchjobs")) {
+		*(config->max_children) = parse_submodule_fetchjobs(var, value);
+		return 0;
+	} else if (!strcmp(var, "fetch.recursesubmodules")) {
+		*(config ->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
+		return 0;
+	}
+
+	return 0;
+}
+
+void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
+{
+	struct fetch_config config = {
+		.max_children = max_children,
+		.recurse_submodules = recurse_submodules
+	};
+	config_from_gitmodules(gitmodules_fetch_config, &config);
+}
diff --git a/submodule-config.h b/submodule-config.h
index 5148801f4..cff297a75 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -66,4 +66,6 @@ int check_submodule_name(const char *name);
  */
 extern void config_from_gitmodules(config_fn_t fn, void *data);
 
+extern void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules);
+
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.18.0

