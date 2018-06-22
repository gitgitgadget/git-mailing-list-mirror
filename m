Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B5A1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934398AbeFVQ1r (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:27:47 -0400
Received: from ao2.it ([92.243.12.208]:53098 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934377AbeFVQ1i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:27:38 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fWOtn-0007Wg-Bt; Fri, 22 Jun 2018 18:26:59 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fWOuK-00053P-HF; Fri, 22 Jun 2018 18:27:32 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 7/7] submodule-config: cleanup backward compatibility helpers
Date:   Fri, 22 Jun 2018 18:26:56 +0200
Message-Id: <20180622162656.19338-8-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180622162656.19338-1-ao2@ao2.it>
References: <20180622162656.19338-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use one callback per configuration setting to handle the generic options
which have to be supported for backward compatibility.

This removes some duplication and some support code at the cost of
parsing the .gitmodules file twice when calling the fetch command.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 submodule-config.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index ce204fb53..0a5274891 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -681,36 +681,20 @@ void submodule_free(struct repository *r)
 		submodule_cache_clear(r->submodule_cache);
 }
 
-struct fetch_config {
-	int *max_children;
-	int *recurse_submodules;
-};
-
-static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
+static int gitmodules_recurse_submodules_config(const char *var,
+						const char *value, void *cb)
 {
-	struct fetch_config *config = cb;
-	if (!strcmp(var, "submodule.fetchjobs")) {
-		*(config->max_children) = parse_submodule_fetchjobs(var, value);
-		return 0;
-	} else if (!strcmp(var, "fetch.recursesubmodules")) {
-		*(config ->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
+	int *recurse_submodules = cb;
+	if (!strcmp(var, "fetch.recursesubmodules")) {
+		*recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
 		return 0;
 	}
 
 	return 0;
 }
 
-void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
-{
-	struct fetch_config config = {
-		.max_children = max_children,
-		.recurse_submodules = recurse_submodules
-	};
-	config_from_gitmodules(gitmodules_fetch_config, the_repository, &config);
-}
-
-static int gitmodules_update_clone_config(const char *var, const char *value,
-					  void *cb)
+static int gitmodules_fetchobjs_config(const char *var, const char *value,
+				       void *cb)
 {
 	int *max_jobs = cb;
 	if (!strcmp(var, "submodule.fetchjobs"))
@@ -718,7 +702,14 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
+
+void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
+{
+	config_from_gitmodules(gitmodules_fetchobjs_config, the_repository, &max_children);
+	config_from_gitmodules(gitmodules_recurse_submodules_config, the_repository, &recurse_submodules);
+}
+
 void update_clone_config_from_gitmodules(int *max_jobs)
 {
-	config_from_gitmodules(gitmodules_update_clone_config, the_repository, &max_jobs);
+	config_from_gitmodules(gitmodules_fetchobjs_config, the_repository, &max_jobs);
 }
-- 
2.18.0

