Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D033BC43219
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiKITH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiKITH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:07:27 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38A61F615
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:07:25 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1668020844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkW1pcJnv3O6KUSdtnK87a5Sy/0z+Ek+SiZtWy6ucZY=;
        b=d10KwHUifa8gPI7a6f1Gu1/XLJnBYbWckvF/sMyXD5YOUUldwktqTqzu6UbCOzn02Dp18s
        2ivQmhM78pkJVteDWqWYmyicOy8iJBkQW14RfsUy7kSuafUXmSaVFWC2B0czwbx1wnhm66
        6XKSyRGUaoDSn1mD668i/IpDgN3B+Ck=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Cc:     me@ttaylor.com, derrickstolee@github.com
Subject: [PATCH v3 2/2] maintenance: add option to register in a specific config
Date:   Wed,  9 Nov 2022 12:07:08 -0700
Message-Id: <20221109190708.22725-3-ronan@rjp.ie>
In-Reply-To: <20221109190708.22725-1-ronan@rjp.ie>
References: <20221109190708.22725-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

maintenance register currently records the maintenance repo exclusively
within the user's global configuration, but other configuration files
may be relevant when running maintenance if they are included from the
global config. This option allows the user to choose where maintenance
repos are recorded.

Signed-off-by: Ronan Pigott <ronan@rjp.ie>
---
 Documentation/git-maintenance.txt | 14 +++++-----
 builtin/gc.c                      | 45 ++++++++++++++++++++++---------
 t/t7900-maintenance.sh            | 21 ++++++++++++++-
 3 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index bb888690e4..805e5a2e3a 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -50,13 +50,13 @@ stop::
 	the background maintenance is restarted later.
 
 register::
-	Initialize Git config values so any scheduled maintenance will
-	start running on this repository. This adds the repository to the
-	`maintenance.repo` config variable in the current user's global
-	config and enables some recommended configuration values for
-	`maintenance.<task>.schedule`. The tasks that are enabled are safe
-	for running in the background without disrupting foreground
-	processes.
+	Initialize Git config values so any scheduled maintenance will start
+	running on this repository. This adds the repository to the
+	`maintenance.repo` config variable in the current user's global config,
+	or the config specified by --config-file option, and enables some
+	recommended configuration values for `maintenance.<task>.schedule`. The
+	tasks that are enabled are safe for running in the background without
+	disrupting foreground processes.
 +
 The `register` subcommand will also set the `maintenance.strategy` config
 value to `incremental`, if this value is not previously set. The
diff --git a/builtin/gc.c b/builtin/gc.c
index 24ea85c7af..56b107e7f0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1454,13 +1454,15 @@ static char *get_maintpath(void)
 }
 
 static char const * const builtin_maintenance_register_usage[] = {
-	"git maintenance register",
+	"git maintenance register [--config-file <path>]",
 	NULL
 };
 
 static int maintenance_register(int argc, const char **argv, const char *prefix)
 {
+	char *config_file = NULL;
 	struct option options[] = {
+		OPT_STRING(0, "config-file", &config_file, N_("file"), N_("use given config file")),
 		OPT_END(),
 	};
 	int found = 0;
@@ -1497,12 +1499,16 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 
 	if (!found) {
 		int rc;
-		char *user_config, *xdg_config;
-		git_global_config(&user_config, &xdg_config);
-		if (!user_config)
-			die(_("$HOME not set"));
+		char *user_config = NULL, *xdg_config = NULL;
+
+		if (!config_file) {
+			git_global_config(&user_config, &xdg_config);
+			config_file = user_config;
+			if (!user_config)
+				die(_("$HOME not set"));
+		}
 		rc = git_config_set_multivar_in_file_gently(
-			user_config, "maintenance.repo", maintpath,
+			config_file, "maintenance.repo", maintpath,
 			CONFIG_REGEX_NONE, 0);
 		free(user_config);
 		free(xdg_config);
@@ -1517,14 +1523,16 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 }
 
 static char const * const builtin_maintenance_unregister_usage[] = {
-	"git maintenance unregister [--force]",
+	"git maintenance unregister [--config-file <path>] [--force]",
 	NULL
 };
 
 static int maintenance_unregister(int argc, const char **argv, const char *prefix)
 {
 	int force = 0;
+	char *config_file = NULL;
 	struct option options[] = {
+		OPT_STRING(0, "config-file", &config_file, N_("file"), N_("use given config file")),
 		OPT__FORCE(&force,
 			   N_("return success even if repository was not registered"),
 			   PARSE_OPT_NOCOMPLETE),
@@ -1542,7 +1550,14 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	list = git_config_get_value_multi(key);
+	struct config_set cs;
+	if (config_file) {
+		git_configset_init(&cs);
+		git_configset_add_file(&cs, config_file);
+		list = git_configset_get_value_multi(&cs, key);
+	} else {
+		list = git_config_get_value_multi(key);
+	}
 	if (list) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
@@ -1554,12 +1569,15 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 
 	if (found) {
 		int rc;
-		char *user_config, *xdg_config;
-		git_global_config(&user_config, &xdg_config);
-		if (!user_config)
-			die(_("$HOME not set"));
+		char *user_config = NULL, *xdg_config = NULL;
+		if (!config_file) {
+			git_global_config(&user_config, &xdg_config);
+			config_file = user_config;
+			if (!user_config)
+				die(_("$HOME not set"));
+		}
 		rc = git_config_set_multivar_in_file_gently(
-			user_config, key, NULL, maintpath,
+			config_file, key, NULL, maintpath,
 			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
 		free(user_config);
 		free(xdg_config);
@@ -1572,6 +1590,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		die(_("repository '%s' is not registered"), maintpath);
 	}
 
+	git_configset_clear(&cs);
 	free(maintpath);
 	return 0;
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 96bdd42045..823331e44a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -500,9 +500,28 @@ test_expect_success 'register and unregister' '
 	git config --global --get-all maintenance.repo >actual &&
 	test_cmp before actual &&
 
+	git config --file ./other --add maintenance.repo /existing1 &&
+	git config --file ./other --add maintenance.repo /existing2 &&
+	git config --file ./other --get-all maintenance.repo >before &&
+
+	git maintenance register --config-file ./other &&
+	test_cmp_config false maintenance.auto &&
+	git config --file ./other --get-all maintenance.repo >between &&
+	cp before expect &&
+	pwd >>expect &&
+	test_cmp expect between &&
+
+	git maintenance unregister --config-file ./other &&
+	git config --file ./other --get-all maintenance.repo >actual &&
+	test_cmp before actual &&
+
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

