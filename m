Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200081F453
	for <e@80x24.org>; Thu, 25 Oct 2018 16:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJZAwL (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:52:11 -0400
Received: from mail.ao2.it ([92.243.12.208]:44392 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeJZAwL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=p2HFyzIGchIk1Ll8kLB4fQC5cjgKIbnt1TGrF62jmZg=;
        b=bEHnLuP3RFGjDnmKEy0Dr7eSIf2eqFuFvgycqQYn5Tp4lyEILs/dZJDuVapJBw7Fs5bcn0MLYr5I8hHZDV6jxVc1kjoa2FUUP3Zawdk+MlYtYni7O+9QFA2M5u10Jc05JksDS5PdAiqIKH+dXbDLsVE1Q3V3amR0bbV+2J11zm6vyWOUHA/SpgcBfGIArx8xdtKxJTWBYG9f9dqR6YJXtgcioyajQy6JvexdxTnIGwKQ9Ssk2gklk1bq7YbDIuSqU1JD/dp8STcGTJlzIvOepmY8O1F8dG8Ps4mW7kb+WIOdCOaXnxmRz6gvn3o7tCm6deghjSYQabGXuJF3ItGd3g==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gFiKn-0003Kq-NK; Thu, 25 Oct 2018 18:18:09 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1gFiL5-0004VD-4W; Thu, 25 Oct 2018 18:18:27 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v7 02/10] submodule: factor out a config_set_in_gitmodules_file_gently function
Date:   Thu, 25 Oct 2018 18:18:05 +0200
Message-Id: <20181025161813.17252-3-ao2@ao2.it>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025161813.17252-1-ao2@ao2.it>
References: <20181025161813.17252-1-ao2@ao2.it>
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
index e36d4e2271..329c0b44f6 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -717,6 +717,18 @@ int print_config_from_gitmodules(struct repository *repo, const char *key)
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
index 031747ccf8..4dc9b0771c 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -49,6 +49,7 @@ const struct submodule *submodule_from_path(struct repository *r,
 					    const char *path);
 void submodule_free(struct repository *r);
 int print_config_from_gitmodules(struct repository *repo, const char *key);
+int config_set_in_gitmodules_file_gently(const char *key, const char *value);
 
 /*
  * Returns 0 if the name is syntactically acceptable as a submodule "name"
diff --git a/submodule.c b/submodule.c
index d9d3046689..24a49eae61 100644
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
2.19.1

