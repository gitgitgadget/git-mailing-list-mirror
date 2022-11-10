Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15A0C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 22:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiKJWxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 17:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJWxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 17:53:30 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43E7272
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 14:53:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1668120801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FQqOPpaTXSMn+SEbIz3nrrZ34iBLNSaCM689jmrao4g=;
        b=veqZqrgURowGbEGot1wnuEL35H+f0rpAw+WxfcVRjUfvx927YMP6p8m/k7sdaaa2vFQDFu
        DEJpJgVCP6I3mj/z50ZewzTdjYXju8/aEavBHHmOW/o9HLfI5z3Upluy+bCCD0ynGCesKx
        A0zbxnQ4mEh3eNf0rs4OjRTuJ0tq3e4=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Cc:     me@ttaylor.com
Subject: [PATCH] maintenance: improve error reporting for unregister
Date:   Thu, 10 Nov 2022 15:53:10 -0700
Message-Id: <20221110225310.7488-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously the unregister command would only check the standard paths to
determine if the repo was registered. We should check the provided path
when available instead.

Signed-off-by: Ronan Pigott <ronan@rjp.ie>
---

These are the changes from v3 of the --config-file patchset in patch
form instead, as requested.

 Documentation/git-maintenance.txt |  2 +-
 builtin/gc.c                      | 22 ++++++++++++++--------
 t/t7900-maintenance.sh            |  6 +++++-
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index eb3ae9fbd599..805e5a2e3a04 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -53,7 +53,7 @@ register::
 	Initialize Git config values so any scheduled maintenance will start
 	running on this repository. This adds the repository to the
 	`maintenance.repo` config variable in the current user's global config,
-	or the config specified by --config option, and enables some
+	or the config specified by --config-file option, and enables some
 	recommended configuration values for `maintenance.<task>.schedule`. The
 	tasks that are enabled are safe for running in the background without
 	disrupting foreground processes.
diff --git a/builtin/gc.c b/builtin/gc.c
index 1709355bce5a..56b107e7f0b9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1550,19 +1550,24 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	if (!config_file) {
+	struct config_set cs;
+	if (config_file) {
+		git_configset_init(&cs);
+		git_configset_add_file(&cs, config_file);
+		list = git_configset_get_value_multi(&cs, key);
+	} else {
 		list = git_config_get_value_multi(key);
-		if (list) {
-			for_each_string_list_item(item, list) {
-				if (!strcmp(maintpath, item->string)) {
-					found = 1;
-					break;
-				}
+	}
+	if (list) {
+		for_each_string_list_item(item, list) {
+			if (!strcmp(maintpath, item->string)) {
+				found = 1;
+				break;
 			}
 		}
 	}
 
-	if (found || config_file) {
+	if (found) {
 		int rc;
 		char *user_config = NULL, *xdg_config = NULL;
 		if (!config_file) {
@@ -1585,6 +1590,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		die(_("repository '%s' is not registered"), maintpath);
 	}
 
+	git_configset_clear(&cs);
 	free(maintpath);
 	return 0;
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 091da683a8af..823331e44a03 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -517,7 +517,11 @@ test_expect_success 'register and unregister' '
 
 	test_must_fail git maintenance unregister 2>err &&
 	grep "is not registered" err &&
-	git maintenance unregister --force
+	git maintenance unregister --force &&
+
+	test_must_fail git maintenance unregister --config-file ./other 2>err &&
+	grep "is not registered" err &&
+	git maintenance unregister --config-file ./other --force
 '
 
 test_expect_success !MINGW 'register and unregister with regex metacharacters' '
-- 
2.38.1

