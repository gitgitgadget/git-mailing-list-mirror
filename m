From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 07/10] use xgetcwd() to get the current directory or die
Date: Mon, 28 Jul 2014 20:30:39 +0200
Message-ID: <53D696CF.40208@web.de>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:30:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBphI-0004Jg-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbaG1Saw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:30:52 -0400
Received: from mout.web.de ([212.227.17.11]:65464 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbaG1Sat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:30:49 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MCImL-1XKwVq3YB7-009BTv; Mon, 28 Jul 2014 20:30:39
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D694A2.8030007@web.de>
X-Provags-ID: V03:K0:hUzoSW05xZInyKHRw2+eM6Yc1JvFHZjupgsmy0qus9IEiWfhscQ
 zMS8aFFEOkcMjaprJLYSX1hNPYC9ew+jUl5MsVqxTMJ/9kFBEJLlibl/kIvrm05BIVseBxS
 pUslN4JBilqX3NUJEFOByYXrhTwsLG2a0fiVmR79nkNTkFVY4Rs27H1kvkPZN98/pGZgwvi
 dO5mE6lQdGv2zCQH3H9Xg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254340>

Convert several calls of getcwd() and die() to use xgetcwd() instead.
This way we get rid of fixed-size buffers (which can be too small
depending on the used file system) and gain consistent error messages.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/init-db.c   | 17 ++++++++---------
 builtin/rev-parse.c |  6 +++---
 dir.c               | 12 ++++++++----
 git.c               |  8 ++++----
 setup.c             |  6 +++---
 trace.c             |  7 ++++---
 6 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 56f85e2..f6dd172 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -426,8 +426,9 @@ int init_db(const char *template_dir, unsigned int flags)
 
 static int guess_repository_type(const char *git_dir)
 {
-	char cwd[PATH_MAX];
 	const char *slash;
+	char *cwd;
+	int cwd_is_git_dir;
 
 	/*
 	 * "GIT_DIR=. git init" is always bare.
@@ -435,9 +436,10 @@ static int guess_repository_type(const char *git_dir)
 	 */
 	if (!strcmp(".", git_dir))
 		return 1;
-	if (!getcwd(cwd, sizeof(cwd)))
-		die_errno(_("cannot tell cwd"));
-	if (!strcmp(git_dir, cwd))
+	cwd = xgetcwd();
+	cwd_is_git_dir = !strcmp(git_dir, cwd);
+	free(cwd);
+	if (cwd_is_git_dir)
 		return 1;
 	/*
 	 * "GIT_DIR=.git or GIT_DIR=something/.git is usually not.
@@ -572,11 +574,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			git_work_tree_cfg = xstrdup(real_path(rel));
 			free(rel);
 		}
-		if (!git_work_tree_cfg) {
-			git_work_tree_cfg = xcalloc(PATH_MAX, 1);
-			if (!getcwd(git_work_tree_cfg, PATH_MAX))
-				die_errno (_("Cannot access current working directory"));
-		}
+		if (!git_work_tree_cfg)
+			git_work_tree_cfg = xgetcwd();
 		if (work_tree)
 			set_git_work_tree(real_path(work_tree));
 		else
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8102aaa..f6bbac7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -735,7 +735,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--git-dir")) {
 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
-				static char cwd[PATH_MAX];
+				char *cwd;
 				int len;
 				if (gitdir) {
 					puts(gitdir);
@@ -745,10 +745,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					puts(".git");
 					continue;
 				}
-				if (!getcwd(cwd, PATH_MAX))
-					die_errno("unable to get current working directory");
+				cwd = xgetcwd();
 				len = strlen(cwd);
 				printf("%s%s.git\n", cwd, len && cwd[len-1] != '/' ? "/" : "");
+				free(cwd);
 				continue;
 			}
 			if (!strcmp(arg, "--resolve-git-dir")) {
diff --git a/dir.c b/dir.c
index fcb6872..bd274a7 100644
--- a/dir.c
+++ b/dir.c
@@ -1507,12 +1507,16 @@ int dir_inside_of(const char *subdir, const char *dir)
 
 int is_inside_dir(const char *dir)
 {
-	char cwd[PATH_MAX];
+	char *cwd;
+	int rc;
+
 	if (!dir)
 		return 0;
-	if (!getcwd(cwd, sizeof(cwd)))
-		die_errno("can't find the current directory");
-	return dir_inside_of(cwd, dir) >= 0;
+
+	cwd = xgetcwd();
+	rc = (dir_inside_of(cwd, dir) >= 0);
+	free(cwd);
+	return rc;
 }
 
 int is_empty_dir(const char *path)
diff --git a/git.c b/git.c
index 9c49519..47137db 100644
--- a/git.c
+++ b/git.c
@@ -20,7 +20,7 @@ const char git_more_info_string[] =
 
 static struct startup_info git_startup_info;
 static int use_pager = -1;
-static char orig_cwd[PATH_MAX];
+static char *orig_cwd;
 static const char *env_names[] = {
 	GIT_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
@@ -36,8 +36,7 @@ static void save_env(void)
 	if (saved_environment)
 		return;
 	saved_environment = 1;
-	if (!getcwd(orig_cwd, sizeof(orig_cwd)))
-		die_errno("cannot getcwd");
+	orig_cwd = xgetcwd();
 	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
 		orig_env[i] = getenv(env_names[i]);
 		if (orig_env[i])
@@ -48,8 +47,9 @@ static void save_env(void)
 static void restore_env(void)
 {
 	int i;
-	if (*orig_cwd && chdir(orig_cwd))
+	if (orig_cwd && chdir(orig_cwd))
 		die_errno("could not move to %s", orig_cwd);
+	free(orig_cwd);
 	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
 		if (orig_env[i])
 			setenv(env_names[i], orig_env[i], 1);
diff --git a/setup.c b/setup.c
index c8b8a97..23b4338 100644
--- a/setup.c
+++ b/setup.c
@@ -434,16 +434,16 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		if (is_absolute_path(git_work_tree_cfg))
 			set_git_work_tree(git_work_tree_cfg);
 		else {
-			char core_worktree[PATH_MAX];
+			char *core_worktree;
 			if (chdir(gitdirenv))
 				die_errno("Could not chdir to '%s'", gitdirenv);
 			if (chdir(git_work_tree_cfg))
 				die_errno("Could not chdir to '%s'", git_work_tree_cfg);
-			if (!getcwd(core_worktree, PATH_MAX))
-				die_errno("Could not get directory '%s'", git_work_tree_cfg);
+			core_worktree = xgetcwd();
 			if (chdir(cwd->buf))
 				die_errno("Could not come back to cwd");
 			set_git_work_tree(core_worktree);
+			free(core_worktree);
 		}
 	}
 	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
diff --git a/trace.c b/trace.c
index e583dc6..54aaee5 100644
--- a/trace.c
+++ b/trace.c
@@ -298,13 +298,12 @@ void trace_repo_setup(const char *prefix)
 {
 	static struct trace_key key = TRACE_KEY_INIT(SETUP);
 	const char *git_work_tree;
-	char cwd[PATH_MAX];
+	char *cwd;
 
 	if (!trace_want(&key))
 		return;
 
-	if (!getcwd(cwd, PATH_MAX))
-		die("Unable to get current working directory");
+	cwd = xgetcwd();
 
 	if (!(git_work_tree = get_git_work_tree()))
 		git_work_tree = "(null)";
@@ -316,6 +315,8 @@ void trace_repo_setup(const char *prefix)
 	trace_printf_key(&key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
 	trace_printf_key(&key, "setup: cwd: %s\n", quote_crnl(cwd));
 	trace_printf_key(&key, "setup: prefix: %s\n", quote_crnl(prefix));
+
+	free(cwd);
 }
 
 int trace_want(struct trace_key *key)
-- 
2.0.2
