Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43E001F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbeHBQTO (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:19:14 -0400
Received: from ao2.it ([92.243.12.208]:54929 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbeHBQTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:11 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv8-0006hx-KW; Thu, 02 Aug 2018 15:45:38 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwQ-0002h9-P8; Thu, 02 Aug 2018 15:46:58 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 02/12] submodule: factor out a config_set_in_gitmodules_file_gently function
Date:   Thu,  2 Aug 2018 15:46:24 +0200
Message-Id: <20180802134634.10300-3-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802134634.10300-1-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new config_set_in_gitmodules_file_gently() function to write
config values to the .gitmodules file.

This is in preparation for a future change which will use the function
to write to the .gitmodules file in a more controlled way instead of
using "git config -f .gitmodules".

The purpose of the change is mainly to centralize the code that writes
to the .gitmodules file to avoid some duplication.

The naming follows git_config_set_in_file_gently() but the git_ prefix
is removed to communicate that this is not a generic git-config API.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 submodule-config.c | 12 ++++++++++++
 submodule-config.h |  1 +
 submodule.c        | 10 +++-------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 6f6f5f9960..702d40dd6b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -707,6 +707,18 @@ int print_config_from_gitmodules(const char *key)
 	return 0;
 }
 
+int config_set_in_gitmodules_file_gently(const char *key, const char *value)
+{
+	int ret;
+
+	ret = git_config_set_in_file_gently(GITMODULES_FILE, key, value);
+	if (ret < 0)
+		/* Maybe the user already did that, don't error out here */
+		warning(_("Could not update .gitmodules entry %s"), key);
+
+	return ret;
+}
+
 struct fetch_config {
 	int *max_children;
 	int *recurse_submodules;
diff --git a/submodule-config.h b/submodule-config.h
index 6fec3caadd..074e74a01c 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -57,6 +57,7 @@ void submodule_free(struct repository *r);
 int check_submodule_name(const char *name);
 
 extern int print_config_from_gitmodules(const char *key);
+extern int config_set_in_gitmodules_file_gently(const char *key, const char *value);
 
 /*
  * Note: these helper functions exist solely to maintain backward
diff --git a/submodule.c b/submodule.c
index 2a6381864e..2af09068d7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -89,6 +89,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 {
 	struct strbuf entry = STRBUF_INIT;
 	const struct submodule *submodule;
+	int ret;
 
 	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
@@ -104,14 +105,9 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, "submodule.");
 	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
-	if (git_config_set_in_file_gently(GITMODULES_FILE, entry.buf, newpath) < 0) {
-		/* Maybe the user already did that, don't error out here */
-		warning(_("Could not update .gitmodules entry %s"), entry.buf);
-		strbuf_release(&entry);
-		return -1;
-	}
+	ret = config_set_in_gitmodules_file_gently(entry.buf, newpath);
 	strbuf_release(&entry);
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.18.0

