Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D1EC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiKHTuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKHTuB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:50:01 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD13E65857
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:49:59 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1667936998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGzRtLbrieVerfCJ4FcCn1xeTKZQ4dfEi9oIMgW0T54=;
        b=kULcGjudyf40QHft/sECQvSjRzmHbC3xAkTlJ+VmcVZAlyDvdk0XAP7pwUnVyYMKaXhmiB
        M0aaCdGSg2oFt2qQFZE5XL1FmEDkJvah0/93faglcNVUjo2FybtICk1KdhSfTCfbkbNUPv
        4j9Yd6sp6psgzDKcNxwdC9BYLCrXf+Y=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Cc:     me@ttaylor.com, derrickstolee@github.com
Subject: [PATCH v2 2/2] maintenance: add option to register in a specific config
Date:   Tue,  8 Nov 2022 12:49:30 -0700
Message-Id: <20221108194930.25805-3-ronan@rjp.ie>
In-Reply-To: <20221108194930.25805-1-ronan@rjp.ie>
References: <20221108194930.25805-1-ronan@rjp.ie>
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
 Documentation/git-maintenance.txt | 14 ++++-----
 builtin/gc.c                      | 51 +++++++++++++++++++------------
 t/t7900-maintenance.sh            | 15 +++++++++
 3 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index bb888690e4..eb3ae9fbd5 100644
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
+	or the config specified by --config option, and enables some
+	recommended configuration values for `maintenance.<task>.schedule`. The
+	tasks that are enabled are safe for running in the background without
+	disrupting foreground processes.
 +
 The `register` subcommand will also set the `maintenance.strategy` config
 value to `incremental`, if this value is not previously set. The
diff --git a/builtin/gc.c b/builtin/gc.c
index 24ea85c7af..1709355bce 100644
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
@@ -1542,24 +1550,29 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	list = git_config_get_value_multi(key);
-	if (list) {
-		for_each_string_list_item(item, list) {
-			if (!strcmp(maintpath, item->string)) {
-				found = 1;
-				break;
+	if (!config_file) {
+		list = git_config_get_value_multi(key);
+		if (list) {
+			for_each_string_list_item(item, list) {
+				if (!strcmp(maintpath, item->string)) {
+					found = 1;
+					break;
+				}
 			}
 		}
 	}
 
-	if (found) {
+	if (found || config_file) {
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
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 96bdd42045..091da683a8 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -500,6 +500,21 @@ test_expect_success 'register and unregister' '
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
 	git maintenance unregister --force
-- 
2.38.1

