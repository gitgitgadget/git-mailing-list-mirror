Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D6B1FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 19:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdFHTx7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 15:53:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:64239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdFHTx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 15:53:57 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoaCE-1dm4am1ozK-00gZSA; Thu, 08
 Jun 2017 21:53:54 +0200
Date:   Thu, 8 Jun 2017 21:53:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/8] Use the early config machinery to expand aliases
In-Reply-To: <cover.1496951503.git.johannes.schindelin@gmx.de>
Message-ID: <af40ce088de03130a5edfae187bb8274b5a9d3a9.1496951503.git.johannes.schindelin@gmx.de>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yZaI9R+60OzFRt2OIMVo9/ovoEr2TWwF0RfiYKqr5MCrkaVSS+4
 h4PFdCZej/rKvzu37k7wexiv+MlzPDlMSxfYNLuCRo40DVJmdkNnV2a0pDj5w+IYhl6b1+Y
 9GiaxwTJOaXsyLdKzVDJz7vyQE9bdJ5ZDzk8r0/tAVfvKyMlxwe+lBDurf+acbRrPp177Rm
 +rkTk+T8KzKY3kDzNZhKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XwlF3V6Pamo=:NrqUhtaiEbfjA800D9ladF
 ky+NEHfZFVXtdiI9I2VXfkN/g2mF+iCZeuc7v/Qt6zYmoj9hB2tLli/YYJfONuSgWOm6dzmRe
 5uV32B4MZxhgcI9vCiJcuWjg7jbJT57xOKkm+k6ysWM/o7eRMQvjcEbhTZv+GN/3WbLVU+4zy
 oSFpmDmRsgHtryODtpetkrRjcigFK6DEk3xEntmanVd/pZVI8yxQw7xOXQd07K1PlTYV2aPmf
 Rqv2Z2wBfCbrFQXwJmqMovXDB1iQg4rUxcEl3ILiTjqhN2UwKWBzmf9FT/ha2FwsUdWOf6YTS
 X8UmkVbiOyel+M6XGPFT0O7u5eglNl7vcGphOcR/INMrKEXFDyjogZ73IAP6pCRrfiuafV3PL
 qoLugpDk+TYZAEBsCmUCpEdBeSNDocFw0kW7bSYlMmsHv1mq8B1X/OPkJF6YMtUJOenh9loez
 rdsOPqMuVGAuWrdMNQD2RK6LxxeRxi5m+TZ/jmZ9F1VeBsH8+0GzMh9GZ/D97HHeWn/YPtIVb
 pNykpA+OdyVW9mCshaQWsqW2wLcSA6KzHYiAbfNOXV5Wd0J+m3lwhJCS+Ta1hG729IbFFQf5t
 Q91fDkrDxTU1ocDdhKCVIddYcZjJOvWjpEW11Xl/KnkWSTbVhfjZqXAYVHZFFuaTMDy0MHCjE
 1eNHh3xL3Au5zAUQgV52UdZ+AgpEUkZFKkQ6aF7E1fWqjdYHiSCLOsVgU8wX4za6w+tUO1sbF
 moWzup/MGoYC4AV3AdyGA2oNoTn1cyCc9vOKZn051rDo9OI4uYzYZDEodQhStGDEF5ZXPgFed
 ZTJrkhG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already taught alias_lookup() to use the early config if the .git/
directory was not yet discovered, of course, however, since we called
setup_git_directory_gently() before expanding the alias (if any), we
only used the early config code path only if outside of any Git-managed
directory.

With this commit, we finally switch over to really using the early
config code path.

Rather than just chdir()ing into the indicated directory in case of an
alias expanding to a shell command, we simply set up the .git/ directory
so that e.g. GIT_PREFIX is set as expected.

This change also fixes a known issue where Git tried to read the pager
config from an incorrect path in a subdirectory of a Git worktree if an
alias expanded to a shell command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git.c            | 59 +++++++-------------------------------------------------
 t/t7006-pager.sh |  2 +-
 2 files changed, 8 insertions(+), 53 deletions(-)

diff --git a/git.c b/git.c
index 4163beaead4..6511595d467 100644
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
@@ -245,36 +201,37 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 
 static int handle_alias(int *argcp, const char ***argv)
 {
+	struct strbuf cdup_dir = STRBUF_INIT;
 	int envchanged = 0, ret = 0, saved_errno = errno;
 	int count, option_count;
 	const char **new_argv;
 	const char *alias_command;
 	char *alias_string;
-	int unused_nongit;
-
-	save_env_before_alias();
-	setup_git_directory_gently(&unused_nongit);
 
 	alias_command = (*argv)[0];
-	alias_string = alias_lookup(alias_command, NULL);
+	alias_string = alias_lookup(alias_command, &cdup_dir);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
 			struct child_process child = CHILD_PROCESS_INIT;
 
+			if (cdup_dir.len)
+				setup_git_directory();
+
 			commit_pager_choice();
-			restore_env(1);
 
 			child.use_shell = 1;
 			argv_array_push(&child.args, alias_string + 1);
 			argv_array_pushv(&child.args, (*argv) + 1);
 
 			ret = run_command(&child);
+			strbuf_release(&cdup_dir);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
 			die_errno("While expanding alias '%s': '%s'",
 			    alias_command, alias_string + 1);
 		}
+		strbuf_release(&cdup_dir);
 		count = split_cmdline(alias_string, &new_argv);
 		if (count < 0)
 			die("Bad alias.%s string: %s", alias_command,
@@ -308,8 +265,6 @@ static int handle_alias(int *argcp, const char ***argv)
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
