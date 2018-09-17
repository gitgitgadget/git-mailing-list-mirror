Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD4C1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 14:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeIQThT (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:37:19 -0400
Received: from ao2.it ([92.243.12.208]:50075 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbeIQThR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:37:17 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g1uBX-0001bT-9T; Mon, 17 Sep 2018 16:07:31 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g1uDg-00010r-C2; Mon, 17 Sep 2018 16:09:44 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v5 2/9] submodule: factor out a config_set_in_gitmodules_file_gently function
Date:   Mon, 17 Sep 2018 16:09:33 +0200
Message-Id: <20180917140940.3839-3-ao2@ao2.it>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917140940.3839-1-ao2@ao2.it>
References: <20180917140940.3839-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
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
index f70b7f1baf..61a555e920 100644
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
index dd7f1b9a46..3921927aa1 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -49,6 +49,7 @@ const struct submodule *submodule_from_path(struct repository *r,
 					    const char *path);
 void submodule_free(struct repository *r);
 int print_config_from_gitmodules(const char *key);
+int config_set_in_gitmodules_file_gently(const char *key, const char *value);
 
 /*
  * Returns 0 if the name is syntactically acceptable as a submodule "name"
diff --git a/submodule.c b/submodule.c
index a2b266fbfa..2e97032f86 100644
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
2.19.0

