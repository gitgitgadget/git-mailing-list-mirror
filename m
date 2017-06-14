Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB7820401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbdFNLgX (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:36:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:55312 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752278AbdFNLgW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 07:36:22 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIzGn-1dN1Ko1wPR-002UIs; Wed, 14
 Jun 2017 13:36:15 +0200
Date:   Wed, 14 Jun 2017 13:36:00 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 6/6] Use the early config machinery to expand aliases
In-Reply-To: <cover.1497440104.git.johannes.schindelin@gmx.de>
Message-ID: <b75481173390d70a64a1156421aaa0ec5aa4abc2.1497440104.git.johannes.schindelin@gmx.de>
References: <cover.1497440104.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cA7AqzDWXvEzWbF0ALW3Q+FPS2pQGK7dYw/4jn5lZXdRdUD45TG
 kWMdejkuCytMk3qefLm6YxAp5PjY0y3R3yCOAvH0BnWIsyfiSq+C4o7YlUG30CANVSvvrRS
 hkIGjz8w4RSMge4SChN6Kw6j4hFaoWSBm/1HRSJWarBcmOZFU6p5IKYh6dEbCljpzfpCEzk
 mukIlRIhXrpw1WVhxenQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vte83gnZzvo=:Xm2JwwE6+dDbpsWkl2c8MS
 NtYHKmLE6Skr6/iTOzKfXkxiVfZY27rCECMIDKZP11usHNsv3e5qT1JTxEPKdZgBE28FhPfIN
 JpFT01zvPp4PVNjF5ZjPUOMxwRu1/+h87JP71h0uqdsMh5xJwF2jqXkCRDzU59rxXj9j86rYv
 tHzsCFVctjmnazp3dgd/ShVxe9c3G1t8SHj61pIIhYUJ7t7Hu6JxiF4UkMs/hB6xyLLOMEJZF
 +QWMawWiLTnd2/I832hr2UyEHpQlPe80Tq7hzZ59MiwWGcwwn3cAnkz/13dNeuCsf5K3HVWfk
 9pY4Qc7mQnZ269/rUHneBvx3QXDfTNe0sMIGPnGRX/PnK2C4l/9NMquEHzATfJPxfs5NmZ+LO
 BGp5D2QiftqXZo1GLo5EcvsANu0s/YZdGZgHngRU6c1CB6tS8IhrXIiAZr3vLZJJir5edzxnc
 guj2E2NBikA0fNU+IaOM7RfnYfw4vgZPvrhaZV+m6pFpxarvRsSi+Ra8iwUwTaCbq4QSLwlei
 eXjIbKu6VlapUFKcb+ynEOMCoRoL/qjDv2UZ6DFtXW15qH8MCyFzgYdrdIRthno7Qp+jvvtSd
 Egi9Kks45azB0U9S/WIhPqtnroIrOoWr2LZSI+Jhn4TCYgkMLz2QaAco5TAvQ+RqEfxle2/FH
 +BXrNDr8TXRt0K0n2iMARNXMGfBSSLF91z+fqmDrPAVirjs+YvJECvPJ1kH0mVJH7zVk7pMLh
 Cej3w6+WcqgeFrjq0yka/NoOAW85ELc2g9kO9REEM9eOFM9+XR0wn4DZiwHyJ3Xk+UH4wnaNC
 SVP8P+x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of discovering the .git/ directory, reading the config and then
trying to painstakingly reset all the global state if we did not find a
matching alias, let's use the early config machinery instead.

It may look like unnecessary work to discover the .git/ directory in the
early config machinery and then call setup_git_directory_gently() in the
case of a shell alias, repeating the very same discovery *again*.
However, we have to do this as the early config machinery takes pains
*not* to touch any global state, while shell aliases expect a possibly
changed working directory and at least the GIT_PREFIX and GIT_DIR
variables to be set.

This change also fixes a known issue where Git tried to read the pager
config from an incorrect path in a subdirectory of a Git worktree if an
alias expanded to a shell command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 alias.c          | 29 ++++++++++++++++++++++-------
 git.c            | 55 ++++---------------------------------------------------
 t/t7006-pager.sh |  2 +-
 3 files changed, 27 insertions(+), 59 deletions(-)

diff --git a/alias.c b/alias.c
index 3b90397a99d..5df052ae4c4 100644
--- a/alias.c
+++ b/alias.c
@@ -1,14 +1,29 @@
 #include "cache.h"
 
+struct config_alias_data
+{
+	const char *alias;
+	char *v;
+};
+
+static int config_alias_cb(const char *key, const char *value, void *d)
+{
+	struct config_alias_data *data = d;
+	const char *p;
+
+	if (skip_prefix(key, "alias.", &p) && !strcmp(p, data->alias))
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
+	struct config_alias_data data = { alias, NULL };
+
+	read_early_config(config_alias_cb, &data);
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
2.13.1.windows.1.1.ga36e14b3aaa
