From: Matthias Lederhofer <matled@gmx.net>
Subject: working directory with GIT_DIR
Date: Thu, 1 Feb 2007 18:47:15 +0100
Message-ID: <20070201174715.GA29440@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 18:47:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCg1p-0005cP-6U
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 18:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbXBARrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 12:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbXBARrS
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 12:47:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:49783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422753AbXBARrR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 12:47:17 -0500
Received: (qmail invoked by alias); 01 Feb 2007 17:47:16 -0000
Received: from pD9EB9AC1.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.154.193]
  by mail.gmx.net (mp036) with SMTP; 01 Feb 2007 18:47:16 +0100
X-Authenticated: #5358227
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38382>

Today on IRC someone asked if it is possible to use GIT_DIR with a
working directory.  At the moment cwd is used as working directory (no
subdirectory support).  I've been thinking for a while about adding an
environment variable to specify the working directory in addition to
GIT_DIR to allow the .git directory to be somewhere else than the
working directory.

I've hacked up a patch to do this using either an environment variable
or take the directory from $GIT_DIR/topdir/ (supposed to be a
symlink).

Any comments?  Is there any interest to add this feature to git?

Here is the patch if anyone is interested, definetly needs some
cleanup.  I'm just asking before I put any further effort into this.
---
allow to specify a working directory with GIT_DIR

set the environment variable GIT_TOP_DIR to the working directory
or $GIT_DIR/topdir/ is tried (e.g. a symlink)
---
 cache.h       |    1 +
 environment.c |    4 ++++
 setup.c       |   54 ++++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 9873ee9..4975cf1 100644
--- a/cache.h
+++ b/cache.h
@@ -118,6 +118,7 @@ extern struct cache_tree *active_cache_tree;
 extern int cache_errno;
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_WORKING_DIR_ENVIRONMENT "GIT_TOP_DIR"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/environment.c b/environment.c
index 54c22f8..d6974f8 100644
--- a/environment.c
+++ b/environment.c
@@ -59,7 +59,11 @@ int is_bare_repository(void)
 	const char *dir, *s;
 	if (0 <= is_bare_repository_cfg)
 		return is_bare_repository_cfg;
+	/* FIXME */
+	return 0;
 
+	if (getenv(GIT_WORKING_DIR_ENVIRONMENT))
+		return 0;
 	dir = get_git_dir();
 	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		return 0;
diff --git a/setup.c b/setup.c
index e9d3f5a..b20fb33 100644
--- a/setup.c
+++ b/setup.c
@@ -205,15 +205,57 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
+		struct stat st;
+		struct stat stcwd;
+
 		if (PATH_MAX - 40 < strlen(gitdirenv))
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-		if (is_git_directory(gitdirenv))
-			return NULL;
-		if (nongit_ok) {
-			*nongit_ok = 1;
-			return NULL;
+		if (!is_git_directory(gitdirenv)) {
+			if (nongit_ok) {
+				*nongit_ok = 1;
+				return NULL;
+			}
+			die("Not a git repository: '%s'", gitdirenv);
+		}
+		if (getenv(GIT_WORKING_DIR_ENVIRONMENT)) {
+			if (stat(getenv(GIT_WORKING_DIR_ENVIRONMENT), &st))
+				die("Unable to stat specified working "
+					"directory '%s'",
+					getenv(GIT_WORKING_DIR_ENVIRONMENT));
+		} else {
+			strcpy(cwd, gitdirenv);
+			strcat(cwd, "/topdir/");
+			if (stat(cwd, &st))
+				return NULL;
 		}
-		die("Not a git repository: '%s'", gitdirenv);
+		if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+			die("Unable to read current working directory");
+
+		offset = len = strlen(cwd);
+		for (;;) {
+			if (offset)
+				cwd[offset] = '\0';
+			if (stat(cwd, &stcwd))
+				die("Unable to stat '%s'", cwd);
+			cwd[offset] = '/';
+			if (st.st_dev == stcwd.st_dev && st.st_ino == stcwd.st_ino)
+				break;
+			chdir("..");
+			do {
+				if (!offset)
+					die("Not below specified working directory");
+			} while(cwd[--offset] != '/');
+		}
+
+		/* FIXME */
+		inside_git_dir = 0;
+
+		if (offset == len)
+			return NULL;
+		offset++;
+		cwd[len++] = '/';
+		cwd[len] = '\0';
+		return cwd+offset;
 	}
 
 	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
-- 
1.5.0.rc3.1.gbc850-dirty
