From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 3/3] use xgetcwd() get the current directory or die
Date: Sun, 20 Jul 2014 13:22:03 +0200
Message-ID: <53CBA65B.7090504@web.de>
References: <53CBA59C.8050901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWk=?= =?UTF-8?B?IE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 13:22:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8pCQ-0002oa-Eg
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 13:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbaGTLWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 07:22:34 -0400
Received: from mout.web.de ([212.227.15.14]:52956 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbaGTLWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 07:22:34 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MaJse-1Wp6Rz3iye-00Jrev; Sun, 20 Jul 2014 13:22:23
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53CBA59C.8050901@web.de>
X-Provags-ID: V03:K0:Ci+MhNFjUgWdteqbJn8Q1RZ3vGASN9XVRV64zadbclzVxseVR7w
 UB/5MTzgmfN9i2guNlV7ywCTgN6Gu/jQMVZswHptgFJPtam3sCt0f3IgoSA7pydxfjuWII1
 13rU3vd6dxvWpd/3HA7YwcJCGBmXHRV8bdUBnbZe8johLsMTygBNyJFkmBfkHKuH9RgxERY
 1fe1o6IfxFzAtJQS6on4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253918>

Convert several calls of getcwd() and die() to use xgetcwd() instead.
This way we get rid of fixed-size buffers (which can be too small
depending on the used file system) and gain consistent error messages.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/init-db.c   | 17 ++++++++---------
 builtin/rev-parse.c |  6 +++---
 dir.c               | 12 ++++++++----
 trace.c             |  7 ++++---
 4 files changed, 23 insertions(+), 19 deletions(-)

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
