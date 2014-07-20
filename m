From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 4/4] use xgetcwd() get the current directory or die
Date: Sun, 20 Jul 2014 18:51:10 +0200
Message-ID: <53CBF37E.9080205@web.de>
References: <53CBF277.3090101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 18:51:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8uKn-0005OU-KC
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 18:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbaGTQve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 12:51:34 -0400
Received: from mout.web.de ([212.227.15.3]:62773 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbaGTQvd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 12:51:33 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M0hws-1WGGVw06mM-00us69; Sun, 20 Jul 2014 18:51:30
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53CBF277.3090101@web.de>
X-Provags-ID: V03:K0:EYDOaBhLj5UOZRIg3jha5Xdj/Cva+ZqE4Ur5xTyMVv15GUlDh0o
 ZH9rjiJwzZp4WsoowUEiBiVmHzq9SSUuUqmc0NsoazJ9KNnk+XwuhdUvuy2yy4lRgMOsAGH
 JNuRlXqYKmJ4ecrRLb7QVWp1F63Y8klj2VuW8dW6/Bzl4Z6AkgYOzWVGJKv7YwcxXXx+dk/
 n8AjZ6r4JPrIze5gEyWhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253934>

Convert several calls of getcwd() and die() to use xgetcwd() instead.
This way we get rid of fixed-size buffers (which can be too small
depending on the used file system) and gain consistent error messages.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/init-db.c   | 17 ++++++++---------
 builtin/rev-parse.c |  6 +++---
 dir.c               | 12 ++++++++----
 setup.c             |  6 +++---
 trace.c             |  7 ++++---
 5 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index c4958b6..dc226d1 100644
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
index e65888d..7b994d4 100644
--- a/dir.c
+++ b/dir.c
@@ -1499,12 +1499,16 @@ int dir_inside_of(const char *subdir, const char *dir)
 
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
diff --git a/setup.c b/setup.c
index 0a22f8b..dc92d63 100644
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
 			if (chdir(cwd))
 				die_errno("Could not come back to cwd");
 			set_git_work_tree(core_worktree);
+			free(core_worktree);
 		}
 	}
 	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
diff --git a/trace.c b/trace.c
index 08180a9..3523667 100644
--- a/trace.c
+++ b/trace.c
@@ -158,13 +158,12 @@ void trace_repo_setup(const char *prefix)
 {
 	static const char *key = "GIT_TRACE_SETUP";
 	const char *git_work_tree;
-	char cwd[PATH_MAX];
+	char *cwd;
 
 	if (!trace_want(key))
 		return;
 
-	if (!getcwd(cwd, PATH_MAX))
-		die("Unable to get current working directory");
+	cwd = xgetcwd();
 
 	if (!(git_work_tree = get_git_work_tree()))
 		git_work_tree = "(null)";
@@ -176,6 +175,8 @@ void trace_repo_setup(const char *prefix)
 	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
 	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
 	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));
+
+	free(cwd);
 }
 
 int trace_want(const char *key)
-- 
2.0.2
