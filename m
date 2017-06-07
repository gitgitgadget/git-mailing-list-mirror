Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FD71FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbdFGQHY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:07:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:61491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdFGQHX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:07:23 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgptO-1dgOys2Lxe-00oJ5r; Wed, 07
 Jun 2017 18:07:04 +0200
Date:   Wed, 7 Jun 2017 18:07:03 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] Use the early config machinery to expand aliases
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
Message-ID: <3b916e1f5055486795c784d55704b4720598f1a9.1496851544.git.johannes.schindelin@gmx.de>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:45986Ts5nvF/rpghZdwhn/SIJCUlUt2sHLwY2ISQtGhTPEDWa4s
 MhYpxoylBVNiEmaSaJjgpiR85T1wXZcUbJY9F/ztDOtADAr4p4v7FfM7WkkSYdMIuh4cqWm
 pmOwe3coonXDa/UVgwubr+Hm7gyPi5pqEb8QZvQVHffiGmSY/vip2EXeo0Vc7WoVa/OVP3I
 T6q4wwhFv7C0+w6SohPUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uFVcj579ZvI=:s5HayHK5or635lq0N+VJgb
 oU10Gw/zfVNWw0vHcKZ9jwEXbCt7GD6oPsUH+4SZZfpJzX8r4poRPLCEjaUHe4ujitfF/3lKj
 FB13A6uy+gmlhsOG5BFV6wQr+AOYzwxX2AXTr7Di9bkGMdmGwN1Dv4FsNxkQSVu2//kh4YrH1
 sdGFUtuta8LwRk3OSlfcLZccaVQJXYGaA9CC/CKV1RNOv5DDvam7QmbUzs2CSIo5O+0Qn29yP
 z2xroJn5NqD15avClkTgP99eiDq0800U6TpPJyxIl4Wku0V2CI/wo8GRb9abmt3QXU4TLKGZW
 BMQRsX81R+o/8dv7utWTwaEvTIHMKHGujoEMJ1Q7d5wlP0py5IZ/LyZSRvya9IoPonp5D8Nyh
 U+wlUgRWXxOZUrWglOBNi1zHX8+y/NpsSRduh9Y3wghwxdabH5Vr1owqvFuT6uaENHs8aLbZQ
 IIW/Z+L5Mk4xHCjB6FXXJdwvWjBLE4sE4B5Us8YrMNw9CLZZmVO5qT7VazMcQ3TXM1KikDlbD
 i8Y1YcojZuEQeKMzkjDiaFy98J+py3d0tQZhOlbpt0UVmTCWoMKXpV/QPtvjpXJmFNLK7MLjc
 TaDFhC3S7n7mC12FVEFOWaYML3/pnhO/DL1boz6dHi0csgu3lXE4fHpf4cMVsjT7GvEKxXDen
 AupGoGs8bEWWfpuz5AGL5+1TUv8VIe3PtWkZ7y+akvGgNG+S/U6TdhOP2hr0PIXTlvmFzy/Sh
 bW7w0pshTs2/LNPeLrRih2fbYAaTmM+qGM6mZRptGjfqn747Co7AdAxFPLnpwO0MO3BwgibfX
 MrMJZKs
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
index 4163beaead4..c82cd455948 100644
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
+	struct strbuf worktree_dir = STRBUF_INIT;
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
+	alias_string = alias_lookup(alias_command, &worktree_dir);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
 			struct child_process child = CHILD_PROCESS_INIT;
 
+			if (worktree_dir.len)
+				setup_git_directory();
+
 			commit_pager_choice();
-			restore_env(1);
 
 			child.use_shell = 1;
 			argv_array_push(&child.args, alias_string + 1);
 			argv_array_pushv(&child.args, (*argv) + 1);
 
 			ret = run_command(&child);
+			strbuf_release(&worktree_dir);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
 			die_errno("While expanding alias '%s': '%s'",
 			    alias_command, alias_string + 1);
 		}
+		strbuf_release(&worktree_dir);
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
