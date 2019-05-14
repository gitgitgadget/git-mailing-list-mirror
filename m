Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA451F461
	for <e@80x24.org>; Tue, 14 May 2019 00:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfENAYN (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:24:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36456 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbfENAYM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 20:24:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C61F360822;
        Tue, 14 May 2019 00:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557793450;
        bh=TlbC/tVQ/AUhI66bSwUfO41yMQ4vF6rZIkXKBfC6+Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=exyF8xc+c0jfuIcwiANChnGCVPy5uiK0qARC9+/uYm+61e3Ox+eVuEfK+fcERHgad
         V9RqbxxZ3d9CfDC1lJJ+O4mdy/WBvSahAFqJqWyc2MDyCs1nwOUdEII1qo8+fYTPTZ
         Oq+sXCZoGdVsTCmKsDexNXYfLSyWB2G8hN9iUgZj6AY2rUOriA6wuEogol7l9t0YW7
         JgjrPJFsLoWQauTJO0t7iVxlkTZL6f+BuYAiOzGSClgljA+XuBc/ueWhQQBAJAyTFZ
         O2tCCA8FCHeuzeD9slNJTTakObtjY5iVXdlZ0MbCPq66jRS9Nt2iCrGrZGvwvqQNW4
         20tcGnztvQrSEeH3hEHSdXeLYB79kYVD8ncdVXdwGfe2SougpQBaET6bQJX8nd5DhH
         9q1DyTrZWHJTXwmi/2l9yJYZA6YYhUCc1T8bd7ZWJpwYNhXqn1Xp8ydC2OAa1Pcfbc
         gL681gp1FPhLB+BdEj9usJvt+xqm3ahbyNfZePlJevFuPOXtD59
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 6/7] config: allow configuration of multiple hook error behavior
Date:   Tue, 14 May 2019 00:23:31 +0000
Message-Id: <20190514002332.121089-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190514002332.121089-1-sandals@crustytoothpaste.net>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a variety of situations in which a user may want an error
behavior for multiple hooks other than the default. Add a config option,
hook.<name>.errorBehavior to allow users to customize this behavior on a
per-hook basis. Provide options for the default behavior (exiting
early), executing all hooks and succeeding if all hooks succeed, or
executing all hooks and succeeding if any hook succeeds.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 config.c       |  27 +++++++++++++
 run-command.c  |  42 +++++++++++++++++---
 run-command.h  |   5 +++
 t/lib-hooks.sh | 106 ++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 173 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index c2846df3f1..9cba4061a9 100644
--- a/config.c
+++ b/config.c
@@ -19,6 +19,7 @@
 #include "utf8.h"
 #include "dir.h"
 #include "color.h"
+#include "run-command.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1093,6 +1094,29 @@ int git_config_color(char *dest, const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_hook_config(const char *key, const char *value)
+{
+	const char *hook;
+	size_t key_len;
+	uintptr_t behavior;
+
+	key += strlen("hook.");
+	if (strip_suffix(key, ".errorbehavior", &key_len)) {
+		hook = xmemdupz(key, key_len);
+		if (!strcmp(value, "stop-on-first"))
+			behavior = HOOK_ERROR_STOP_ON_FIRST;
+		else if (!strcmp(value, "report-any-error"))
+			behavior = HOOK_ERROR_REPORT_ANY_ERROR;
+		else if (!strcmp(value, "report-any-success"))
+			behavior = HOOK_ERROR_REPORT_ANY_SUCCESS;
+		else
+			die(_("invalid mode for hook %s error behavior: %s"), hook, value);
+		string_list_insert(&hook_error_behavior, hook)->util = (void *)behavior;
+		return 0;
+	}
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value, void *cb)
 {
 	/* This needs a better name */
@@ -1450,6 +1474,9 @@ int git_default_config(const char *var, const char *value, void *cb)
 	    starts_with(var, "committer."))
 		return git_ident_config(var, value, cb);
 
+	if (starts_with(var, "hook."))
+		return git_default_hook_config(var, value);
+
 	if (starts_with(var, "i18n."))
 		return git_default_i18n_config(var, value);
 
diff --git a/run-command.c b/run-command.c
index 191d6f6f7e..70fb19a55b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1308,6 +1308,8 @@ int async_with_fork(void)
 #endif
 }
 
+struct string_list hook_error_behavior = STRING_LIST_INIT_NODUP;
+
 /*
  * Return 1 if a hook exists at path (which may be modified) using access(2)
  * with check (which should be F_OK or X_OK), 0 otherwise. If strip is true,
@@ -1401,18 +1403,48 @@ int for_each_hook(const char *name,
 		  void *data)
 {
 	struct string_list paths = STRING_LIST_INIT_DUP;
-	int i, ret = 0;
+	int i, hret = 0;
+	uintptr_t behavior = HOOK_ERROR_STOP_ON_FIRST;
+	struct string_list_item *item;
+	/* Use -2 as sentinel because failure to exec is -1. */
+	int ret = -2;
+
+	item = string_list_lookup(&hook_error_behavior, name);
+	if (item)
+		behavior = (uintptr_t)item->util;
 
 	find_hooks(name, &paths);
 	for (i = 0; i < paths.nr; i++) {
 		const char *p = paths.items[i].string;
 
-		ret = handler(name, p, data);
-		if (ret)
-			break;
+		hret = handler(name, p, data);
+		switch (behavior) {
+			case HOOK_ERROR_STOP_ON_FIRST:
+				if (hret) {
+					ret = hret;
+					goto out;
+				}
+				break;
+			case HOOK_ERROR_REPORT_ANY_SUCCESS:
+				if (ret == -2)
+					ret = 1;
+				if (!hret)
+					ret = 0;
+				break;
+			case HOOK_ERROR_REPORT_ANY_ERROR:
+				if (ret == -2)
+					ret = 0;
+				if (hret)
+					ret = hret;
+				break;
+			default:
+				BUG("unknown hook error behavior");
+		}
 	}
-
+out:
 	string_list_clear(&paths, 0);
+	if (ret == -2)
+		return 0;
 	return ret;
 }
 
diff --git a/run-command.h b/run-command.h
index 15974e26d4..879ebb768f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -63,6 +63,11 @@ int finish_command(struct child_process *);
 int finish_command_in_signal(struct child_process *);
 int run_command(struct child_process *);
 
+#define HOOK_ERROR_STOP_ON_FIRST 1
+#define HOOK_ERROR_REPORT_ANY_ERROR 2
+#define HOOK_ERROR_REPORT_ANY_SUCCESS 3
+extern struct string_list hook_error_behavior;
+
 /*
  * Returns the paths to all hook files, or NULL if all hooks are missing or
  * disabled.
diff --git a/t/lib-hooks.sh b/t/lib-hooks.sh
index 721250aea0..c1d7688313 100644
--- a/t/lib-hooks.sh
+++ b/t/lib-hooks.sh
@@ -121,7 +121,7 @@ test_multiple_hooks () {
 		! test -f "$OUTPUTDIR/c"
 	'
 
-	test_expect_success "$hook: multiple hooks, all successful" '
+	test_expect_success "$hook: multiple hooks, all successful by default" '
 		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
 		rm -f "$HOOK" &&
 		create_multihooks 0 0 0 &&
@@ -131,7 +131,40 @@ test_multiple_hooks () {
 		test -f "$OUTPUTDIR/c"
 	'
 
-	test_expect_success "$hook: hooks after first failure not executed" '
+	test_expect_success "$hook: multiple hooks, all successful with stop-on-first" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		test_config "hook.$hook.errorbehavior" stop-on-first &&
+		rm -f "$HOOK" &&
+		create_multihooks 0 0 0 &&
+		$cmd content-stop-on-first &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: multiple hooks, all successful with report-any-error" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		test_config "hook.$hook.errorbehavior" report-any-error &&
+		rm -f "$HOOK" &&
+		create_multihooks 0 0 0 &&
+		$cmd content-report-any-error &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: multiple hooks, all successful with report-any-success" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		test_config "hook.$hook.errorbehavior" report-any-success &&
+		rm -f "$HOOK" &&
+		create_multihooks 0 0 0 &&
+		$cmd content-report-any-success &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: hooks after first failure not executed by default" '
 		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
 		create_multihooks 0 1 0 &&
 		$must_fail $cmd more-content &&
@@ -140,6 +173,75 @@ test_multiple_hooks () {
 		! test -f "$OUTPUTDIR/c"
 	'
 
+	test_expect_success "$hook: hooks after first failure not executed with stop-on-first" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		test_config "hook.$hook.errorbehavior" stop-on-first &&
+		create_multihooks 0 1 0 &&
+		$must_fail $cmd more-content-stop-on-first &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		! test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: hooks after first failure executed with report-any-error" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		test_config "hook.$hook.errorbehavior" report-any-error &&
+		create_multihooks 0 1 0 &&
+		$must_fail $cmd more-content-report-any-error &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: hooks after first failure executed with report-any-success" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		test_config "hook.$hook.errorbehavior" report-any-success &&
+		create_multihooks 0 1 0 &&
+		$cmd more-content-report-any-success &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: failing hooks by default" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		create_multihooks 1 1 1 &&
+		$must_fail $cmd most-content &&
+		test -f "$OUTPUTDIR/a" &&
+		! test -f "$OUTPUTDIR/b" &&
+		! test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: failing hooks with stop-on-first" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		test_config "hook.$hook.errorbehavior" stop-on-first &&
+		create_multihooks 1 1 1 &&
+		$must_fail $cmd most-content-stop-on-first &&
+		test -f "$OUTPUTDIR/a" &&
+		! test -f "$OUTPUTDIR/b" &&
+		! test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: failing hooks with report-any-error" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		test_config "hook.$hook.errorbehavior" report-any-error &&
+		create_multihooks 1 1 1 &&
+		$must_fail $cmd most-content-report-any-error &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		test -f "$OUTPUTDIR/c"
+	'
+
+	test_expect_success "$hook: failing hooks with report-any-success" '
+		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
+		test_config "hook.$hook.errorbehavior" report-any-success &&
+		create_multihooks 1 1 1 &&
+		$must_fail $cmd most-content-report-any-success &&
+		test -f "$OUTPUTDIR/a" &&
+		test -f "$OUTPUTDIR/b" &&
+		test -f "$OUTPUTDIR/c"
+	'
+
 	test_expect_success POSIXPERM "$hook: non-executable hook not executed" '
 		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
 		create_multihooks 0 1 0 &&
