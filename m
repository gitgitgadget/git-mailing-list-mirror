Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE531FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 12:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbdFMMEx (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 08:04:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:61674 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752249AbdFMMEv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 08:04:51 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lvkwm-1durW73FaW-017V5t; Tue, 13
 Jun 2017 14:04:39 +0200
Date:   Tue, 13 Jun 2017 14:04:39 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 6/6] Use the early config machinery to expand aliases
In-Reply-To: <cover.1497355444.git.johannes.schindelin@gmx.de>
Message-ID: <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RQJQ/5FWytXje39DpUFRr/qy9AyNZpTAaCbrA4yZcwKuA0khtLR
 AZm+m6hu8d6HBjWwqYHIbonE3opecDJzYzuzLY17oF69lg9wneHmurzlV1N9kf+L7/sbsXJ
 rlpgo1PsDZplsfUJKVWRxGKdxh3g+L39Y8gphpHHTxhHsEH9B0d5VRi3Tjc7qpFvZTa6T0M
 KxdKwQy0xNmnKGoUdtEeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AMrR4VI3uIo=:qV2NS9PpCLmOVNqpq6tdbV
 6tTngIyR04zKxpAuIasSHWEoMHW68bitKTA5WK2jFmtfyGSJs1GSbkojpoF/TYVabvt6S8rzO
 mcDdh+V5fDKgVUmoLXBRd1fm7j84gArPn+bNFVWfkf37ELWGxhRsNS3uA9n7hFmkg7HtEDOwX
 KSmTvfAaWKI+6u+lISUfcyyxuh9dntUTXvRhVCcG5cjfKRaNGTJLsu/8Mr5Dnx+iVGcvQZJVg
 Ty6iYi6fCVjVdlOm3ppAY/eieNBOeAaKvfhXLbM2nBa7leA1Sr/RMSJfr0ny6rXn3JYVBQgaP
 Eh/Id2TWrUnrtsKTFebNJ3ENHhIhqUuVcAu0J5r9HwfWB9eBk61hzuGO2F9JVFF2x80I2OZ7M
 4DeW1dvttS9HZES1nwQzEM+13g4Gf2KSpD/pwkkw5d9zcT74XDkZsCBnkre0VblB4mW47InKE
 xcebrLmaZ55tf03Mv4RrVh0T541qRdIIwk1BOwpdaqPKYUWryUjZbPBAvDNb58zWKuq09e0iJ
 A6NumqVtnbIX7EnakWdjIypx87CRKg1YT+GyvhusFMG0b6RqttxY5ifROgnoRs0PgtSptjTKI
 UKyLES4ZZ4PVRe/MQvQTnQK3HxSs6GWnhccemok0KSOQmwbDa3HYK6QsoyAm8JfSvjyoUt5/N
 ygUatHrXErrz0tRxDKhg7nvYLZRGeCzVSAz4pv1lMHp8Y+Yh+l0+hE0aFN6kPiClVlld3sL4k
 g9sRSRUNBKFzXd1J7y+OuoW5YuyCGI+jeXd+n/k2+SlJAhRYjoRVke8kfqoCRpYNbP4Pnpsv+
 NHifKz5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of discovering the .git/ directory, read the config and then
trying to painstakingly reset all the global state if we did not find a
matching alias, let's use the early config machinery instead.

It may look like unnecessary work to discover the .git/ directory in the
early config machinery and then call setup_git_directory_gently() in the
case of a shell alias, repeating the very same discovery *again*.
However, we have to do this as the early config machinery takes pains
*not* to touch any global state, while shell aliases expect a possibly
changed working directory and at least the GIT_PREFIX and GIT_DIR
variables to be set.

Also, one might be tempted to streamline the code in alias_lookup() to
*not* use a strbuf for the key. However, if the config reports an error,
it is far superior to tell the user that the `alias.xyz` key had a
problem than to claim that it was the `xyz` key.

This change also fixes a known issue where Git tried to read the pager
config from an incorrect path in a subdirectory of a Git worktree if an
alias expanded to a shell command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 alias.c          | 31 ++++++++++++++++++++++++-------
 git.c            | 55 ++++---------------------------------------------------
 t/t7006-pager.sh |  2 +-
 3 files changed, 29 insertions(+), 59 deletions(-)

diff --git a/alias.c b/alias.c
index 3b90397a99d..6bdc9363037 100644
--- a/alias.c
+++ b/alias.c
@@ -1,14 +1,31 @@
 #include "cache.h"
 
+struct config_alias_data
+{
+	struct strbuf key;
+	char *v;
+};
+
+static int config_alias_cb(const char *key, const char *value, void *d)
+{
+	struct config_alias_data *data = d;
+
+	if (!strcmp(key, data->key.buf))
+		return git_config_string((const char **)&data->v, key, value);
+
+	return 0;
+}
+
 char *alias_lookup(const char *alias)
 {
-	char *v = NULL;
-	struct strbuf key = STRBUF_INIT;
-	strbuf_addf(&key, "alias.%s", alias);
-	if (git_config_key_is_valid(key.buf))
-		git_config_get_string(key.buf, &v);
-	strbuf_release(&key);
-	return v;
+	struct config_alias_data data = { STRBUF_INIT, NULL };
+
+	strbuf_addf(&data.key, "alias.%s", alias);
+	if (git_config_key_is_valid(data.key.buf))
+		read_early_config(config_alias_cb, &data);
+	strbuf_release(&data.key);
+
+	return data.v;
 }
 
 #define SPLIT_CMDLINE_BAD_ENDING 1
diff --git a/git.c b/git.c
index 8ff44f081d4..58ef570294d 100644
--- a/git.c
+++ b/git.c
@@ -16,50 +16,6 @@ const char git_more_info_string[] =
 	   "to read about a specific subcommand or concept.");
 
 static int use_pager = -1;
-static char *orig_cwd;
-static const char *env_names[] = {
-	GIT_DIR_ENVIRONMENT,
-	GIT_WORK_TREE_ENVIRONMENT,
-	GIT_IMPLICIT_WORK_TREE_ENVIRONMENT,
-	GIT_PREFIX_ENVIRONMENT
-};
-static char *orig_env[4];
-static int save_restore_env_balance;
-
-static void save_env_before_alias(void)
-{
-	int i;
-
-	assert(save_restore_env_balance == 0);
-	save_restore_env_balance = 1;
-	orig_cwd = xgetcwd();
-	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
-		orig_env[i] = getenv(env_names[i]);
-		orig_env[i] = xstrdup_or_null(orig_env[i]);
-	}
-}
-
-static void restore_env(int external_alias)
-{
-	int i;
-
-	assert(save_restore_env_balance == 1);
-	save_restore_env_balance = 0;
-	if (!external_alias && orig_cwd && chdir(orig_cwd))
-		die_errno("could not move to %s", orig_cwd);
-	free(orig_cwd);
-	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
-		if (external_alias &&
-		    !strcmp(env_names[i], GIT_PREFIX_ENVIRONMENT))
-			continue;
-		if (orig_env[i]) {
-			setenv(env_names[i], orig_env[i], 1);
-			free(orig_env[i]);
-		} else {
-			unsetenv(env_names[i]);
-		}
-	}
-}
 
 static void commit_pager_choice(void) {
 	switch (use_pager) {
@@ -250,19 +206,18 @@ static int handle_alias(int *argcp, const char ***argv)
 	const char **new_argv;
 	const char *alias_command;
 	char *alias_string;
-	int unused_nongit;
-
-	save_env_before_alias();
-	setup_git_directory_gently(&unused_nongit);
 
 	alias_command = (*argv)[0];
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
 			struct child_process child = CHILD_PROCESS_INIT;
+			int nongit_ok;
+
+			/* Aliases expect GIT_PREFIX, GIT_DIR etc to be set */
+			setup_git_directory_gently(&nongit_ok);
 
 			commit_pager_choice();
-			restore_env(1);
 
 			child.use_shell = 1;
 			argv_array_push(&child.args, alias_string + 1);
@@ -308,8 +263,6 @@ static int handle_alias(int *argcp, const char ***argv)
 		ret = 1;
 	}
 
-	restore_env(0);
-
 	errno = saved_errno;
 
 	return ret;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 83881ec3a0c..20b4d83c281 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -391,7 +391,7 @@ test_expect_success TTY 'core.pager in repo config works and retains cwd' '
 	)
 '
 
-test_expect_failure TTY 'core.pager is found via alias in subdirectory' '
+test_expect_success TTY 'core.pager is found via alias in subdirectory' '
 	sane_unset GIT_PAGER &&
 	test_config core.pager "cat >via-alias" &&
 	(
-- 
2.13.0.windows.1.460.g13f583bedb5
