Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6F091F404
	for <e@80x24.org>; Tue, 14 Aug 2018 11:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbeHNNwa (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 09:52:30 -0400
Received: from ao2.it ([92.243.12.208]:42906 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbeHNNwa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 09:52:30 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fpX7U-0007ZS-MA; Tue, 14 Aug 2018 13:04:12 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fpX90-0004e1-HH; Tue, 14 Aug 2018 13:05:46 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v3 1/7] submodule: add a print_config_from_gitmodules() helper
Date:   Tue, 14 Aug 2018 13:05:19 +0200
Message-Id: <20180814110525.17801-2-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814110525.17801-1-ao2@ao2.it>
References: <20180814110525.17801-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new print_config_from_gitmodules() helper function to print values
from .gitmodules just like "git config -f .gitmodules" would.

This will be used by a new submodule--helper subcommand to be able to
access the .gitmodules file in a more controlled way.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 submodule-config.c | 25 +++++++++++++++++++++++++
 submodule-config.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index fc2c41b947..eef96c4198 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -682,6 +682,31 @@ void submodule_free(struct repository *r)
 		submodule_cache_clear(r->submodule_cache);
 }
 
+static int config_print_callback(const char *key_, const char *value_, void *cb_data)
+{
+	char *key = cb_data;
+
+	if (!strcmp(key, key_))
+		printf("%s\n", value_);
+
+	return 0;
+}
+
+int print_config_from_gitmodules(const char *key)
+{
+	int ret;
+	char *store_key;
+
+	ret = git_config_parse_key(key, &store_key, NULL);
+	if (ret < 0)
+		return CONFIG_INVALID_KEY;
+
+	config_from_gitmodules(config_print_callback, the_repository, store_key);
+
+	free(store_key);
+	return 0;
+}
+
 struct fetch_config {
 	int *max_children;
 	int *recurse_submodules;
diff --git a/submodule-config.h b/submodule-config.h
index dc7278eea4..ed40e9a478 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -56,6 +56,8 @@ void submodule_free(struct repository *r);
  */
 int check_submodule_name(const char *name);
 
+int print_config_from_gitmodules(const char *key);
+
 /*
  * Note: these helper functions exist solely to maintain backward
  * compatibility with 'fetch' and 'update_clone' storing configuration in
-- 
2.18.0

