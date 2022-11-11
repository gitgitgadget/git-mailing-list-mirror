Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB5AC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 23:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiKKXTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 18:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiKKXTm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 18:19:42 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3018B7BE42
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:19:39 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1668208778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qRZla9Ifkcmnyr5M/1NFipFszcmkeN1aZ961z8WYoOU=;
        b=GT8WTwB4odJXq6H3Bxey4qIPbOTTorCGHhY/y6Uf60HeDw9+ZXYv9yiq41bm8nX+ZhMciH
        tDTYPi1BzlAkMQcGGz6VWg0/6TlMENyPvew99HQbdFOjCAZanJ8RDkXlNTSs2H46yrzDgq
        AiOFHem+eym05rJTwqw25XIfC2avuvk=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, derrickstolee@github.com
Subject: [PATCH v2] maintenance: improve error reporting for unregister
Date:   Fri, 11 Nov 2022 16:19:10 -0700
Message-Id: <20221111231910.26769-1-ronan@rjp.ie>
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
Changes in v2:
 - Moved configset declaration with the other declarations
 - Extract configset initialization from conditional so it is always
   initialized before it is cleared. It is still deferred until after
   the command arguments are sanity checked.

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
index 1709355bce5a..c32a5f28cca9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1543,6 +1543,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	int found = 0;
 	struct string_list_item *item;
 	const struct string_list *list;
+	struct config_set cs;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_unregister_usage, 0);
@@ -1550,19 +1551,23 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	if (!config_file) {
+	git_configset_init(&cs);
+	if (config_file) {
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

