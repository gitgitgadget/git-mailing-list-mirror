From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] core.workdir config variable
Date: Wed, 14 Mar 2007 00:10:04 +0100
Message-ID: <20070313231004.GA15058@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com> <20070311155649.GA29663@moooo.ath.cx> <20070311212906.GA18208@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 00:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRG8Z-00020n-JN
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 00:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbXCMXKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 19:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbXCMXKJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 19:10:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:52914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752309AbXCMXKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 19:10:08 -0400
Received: (qmail invoked by alias); 13 Mar 2007 23:10:06 -0000
Received: from pD9EBB63A.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.182.58]
  by mail.gmx.net (mp010) with SMTP; 14 Mar 2007 00:10:06 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+bPtBvBeKbvh3T8QVmRJg7DUCtv/tKY8CYImAWWk
	J92cUag+fJ/yIW
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070311212906.GA18208@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42155>

core.workdir is used as default value for $GIT_WORK_DIR

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
This one replaces the 'use $GIT_DIR/workdir as working directory with
$GIT_DIR' patch and uses core.workdir instead.  This patch gets
core.workdir only for setup.c from the configuration file.  Perhaps
this should be handled in git_default_config like most other core.*
variables.

I just noticed that dying if the specified workdir is invalid can
cause trouble too:

    $ export GIT_DIR=/path/to/repository
    $ git config core.workdir /non-existent
    $ git config core.workdir ../workdir
    fatal: Unable to stat git working directory '/non-existent'

Workaround is either to edit the file manually or do:

    $ git --work-dir=. config core.workdir ../workdir

---
 Documentation/config.txt |    4 +++
 setup.c                  |   53 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5408dd6..663d82d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -162,6 +162,10 @@ repository that ends in "/.git" is assumed to be not bare (bare =
 false), while all other repositories are assumed to be bare (bare
 = true).
 
+core.workdir::
+	Directory to be used as toplevel working directory when GIT_DIR
+	is set.  This can be overriden by GIT_WORK_DIR.
+
 core.logAllRefUpdates::
 	Updates to a ref <ref> is logged to the file
 	"$GIT_DIR/logs/<ref>", by appending the new and old
diff --git a/setup.c b/setup.c
index ebf628e..913c4b4 100644
--- a/setup.c
+++ b/setup.c
@@ -192,6 +192,53 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
+static char **git_work_dir;
+
+static int git_workdir_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "core.workdir")) {
+		strlcpy(value, *git_work_dir, PATH_MAX);
+	}
+	return 0;
+}
+
+static int stat_git_work_dir(struct stat *st)
+{
+	char workdir[PATH_MAX], cwd[PATH_MAX];
+	const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
+	const char *gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
+
+	if (gitwd) {
+		if (!stat(gitwd, st))
+			return 1;
+		die("Unable to stat git working directory '%s'", gitwd);
+	}
+
+	/* get workdir from config */
+	workdir[0] = '\0';
+	git_work_dir = workdir;
+	git_config(git_workdir_config);
+	git_workdir_config = NULL;
+	if (!workdir[0])
+		return 0;
+
+	/* relative path: change to gitdir for stat */
+	if (workdir[0] != '/') {
+		if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		if (chdir(gitdir))
+			die("Cannot change directory to '%s'", gitdir);
+	}
+
+	if (stat(workdir, st))
+		die("Unable to stat git working directory '%s'", workdir);
+
+	if (workdir[0] != '/' && chdir(cwd))
+		die("Cannot come back to cwd");
+
+	return 1;
+}
+
 int has_working_directory = -1;
 
 const char *setup_git_directory_gently(int *nongit_ok)
@@ -203,7 +250,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
 		struct stat st, st_work, st_git;
-		const char *gitwd;
 		char *prefix;
 		char c;
 		int len;
@@ -219,11 +265,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 
 		/* check for working directory */
-		gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
-		if (!gitwd)
+		if (!stat_git_work_dir(&st_work))
 			return NULL;
-		if (stat(gitwd, &st_work))
-			die("Unable to stat git working directory '%s'", gitwd);
 		if (inside_git_dir == -1 && stat(gitdirenv, &st_git))
 			die("Unable to stat git directory");
 		if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
-- 
1.5.0.3.970.ge984-dirty
