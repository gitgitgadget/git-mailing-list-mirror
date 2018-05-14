Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E42B1F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeENK7E (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:59:04 -0400
Received: from ao2.it ([92.243.12.208]:53780 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752484AbeENK7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:59:02 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fIBBp-000752-Jk; Mon, 14 May 2018 12:58:49 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fIBC0-0002C5-Hw; Mon, 14 May 2018 12:59:00 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH 02/10] submodule: factor out a config_gitmodules_set function
Date:   Mon, 14 May 2018 12:58:15 +0200
Message-Id: <20180514105823.8378-3-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new config_gitmodules_set function to write config values to the
.gitmodules file.

This is in preparation for a future change which will use the function
to write to the .gitmodules file in a more controlled way instead of
using "git config -f .gitmodules".

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

Not sure about the name, and maybe it can go in config.c for symmetry with
config_from_gitmodules?

 submodule.c | 22 +++++++++++++++-------
 submodule.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/submodule.c b/submodule.c
index 74d35b257..7cfae89b6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -80,6 +80,18 @@ static int for_each_remote_ref_submodule(const char *submodule,
 					fn, cb_data);
 }
 
+int config_gitmodules_set(const char *key, const char *value)
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
 /*
  * Try to update the "path" entry in the "submodule.<name>" section of the
  * .gitmodules file. Return 0 only if a .gitmodules file was found, a section
@@ -89,6 +101,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 {
 	struct strbuf entry = STRBUF_INIT;
 	const struct submodule *submodule;
+	int ret;
 
 	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
@@ -104,14 +117,9 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, "submodule.");
 	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
-	if (git_config_set_in_file_gently(GITMODULES_FILE, entry.buf, newpath) < 0) {
-		/* Maybe the user already did that, don't error out here */
-		warning(_("Could not update .gitmodules entry %s"), entry.buf);
-		strbuf_release(&entry);
-		return -1;
-	}
+	ret = config_gitmodules_set(entry.buf, newpath);
 	strbuf_release(&entry);
-	return 0;
+	return ret;
 }
 
 /*
diff --git a/submodule.h b/submodule.h
index e5526f6aa..8a252e514 100644
--- a/submodule.h
+++ b/submodule.h
@@ -35,6 +35,7 @@ struct submodule_update_strategy {
 
 extern int is_gitmodules_unmerged(const struct index_state *istate);
 extern int is_staging_gitmodules_ok(struct index_state *istate);
+extern int config_gitmodules_set(const char *key, const char *value);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
 extern void stage_updated_gitmodules(struct index_state *istate);
-- 
2.17.0

