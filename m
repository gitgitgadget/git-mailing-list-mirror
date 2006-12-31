From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/4] Automatically detect a bare git repository.
Date: Sat, 30 Dec 2006 23:30:19 -0500
Message-ID: <20061231043019.GC5823@spearce.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Dec 31 05:30:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0sL4-0003Dt-Rn
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 05:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbWLaEaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 23:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbWLaEaY
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 23:30:24 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43014 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730AbWLaEaX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 23:30:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0sKm-0008Um-7t; Sat, 30 Dec 2006 23:30:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 88A9420FB65; Sat, 30 Dec 2006 23:30:19 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35664>

Many users find it unfriendly that they can create a bare git
repository easily with `git clone --bare` but are then unable to
run simple commands like `git log` once they cd into that newly
created bare repository.  This occurs because we do not check to
see if the current working directory is a git repository.

Instead of failing out with "fatal: Not a git repository" we should
try to automatically detect if the current working directory is
a bare repository and use that for GIT_DIR, and fail out only if
that doesn't appear to be true.

We test the current working directory only after we have tried
searching up the directory tree.  This is to retain backwards
compatibility with our previous behavior on the off chance that
a user has a 'refs' and 'objects' subdirectories and a 'HEAD'
file that looks like a symref, all stored within a repository's
associated working directory.

This change also consolidates the validation logic between the case
of GIT_DIR being supplied and GIT_DIR not being supplied, cleaning
up the code.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is in response to Theodore Tso's email asking why 'git log'
 doesn't work in a bare repository.  Now it does.  :-)

 setup.c |   73 +++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/setup.c b/setup.c
index 2afdba4..2ae57f7 100644
--- a/setup.c
+++ b/setup.c
@@ -131,28 +131,46 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 }
 
 /*
- * Test if it looks like we're at the top level git directory.
+ * Test if it looks like we're at a git directory.
  * We want to see:
  *
- *  - either a .git/objects/ directory _or_ the proper
+ *  - either a objects/ directory _or_ the proper
  *    GIT_OBJECT_DIRECTORY environment variable
- *  - a refs/ directory under ".git"
+ *  - a refs/ directory
  *  - either a HEAD symlink or a HEAD file that is formatted as
  *    a proper "ref:".
  */
-static int is_toplevel_directory(void)
+static int is_git_directory(const char *suspect)
 {
-	if (access(".git/refs/", X_OK) ||
-	    access(getenv(DB_ENVIRONMENT) ?
-		   getenv(DB_ENVIRONMENT) : ".git/objects/", X_OK) ||
-	    validate_symref(".git/HEAD"))
+	char path[PATH_MAX];
+	size_t len = strlen(suspect);
+
+	strcpy(path, suspect);
+	if (getenv(DB_ENVIRONMENT)) {
+		if (access(getenv(DB_ENVIRONMENT), X_OK))
+			return 0;
+	}
+	else {
+		strcpy(path + len, "/objects");
+		if (access(path, X_OK))
+			return 0;
+	}
+
+	strcpy(path + len, "/refs");
+	if (access(path, X_OK))
 		return 0;
+
+	strcpy(path + len, "/HEAD");
+	if (validate_symref(path))
+		return 0;
+
 	return 1;
 }
 
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static char cwd[PATH_MAX+1];
+	const char *gitdirenv;
 	int len, offset;
 
 	/*
@@ -160,36 +178,17 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * to do any discovery, but we still do repository
 	 * validation.
 	 */
-	if (getenv(GIT_DIR_ENVIRONMENT)) {
-		char path[PATH_MAX];
-		int len = strlen(getenv(GIT_DIR_ENVIRONMENT));
-		if (sizeof(path) - 40 < len)
+	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
+	if (gitdirenv) {
+		if (PATH_MAX - 40 < strlen(gitdirenv))
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-		memcpy(path, getenv(GIT_DIR_ENVIRONMENT), len);
-		
-		strcpy(path + len, "/refs");
-		if (access(path, X_OK))
-			goto bad_dir_environ;
-		strcpy(path + len, "/HEAD");
-		if (validate_symref(path))
-			goto bad_dir_environ;
-		if (getenv(DB_ENVIRONMENT)) {
-			if (access(getenv(DB_ENVIRONMENT), X_OK))
-				goto bad_dir_environ;
-		}
-		else {
-			strcpy(path + len, "/objects");
-			if (access(path, X_OK))
-				goto bad_dir_environ;
-		}
-		return NULL;
-	bad_dir_environ:
+		if (is_git_directory(gitdirenv))
+			return NULL;
 		if (nongit_ok) {
 			*nongit_ok = 1;
 			return NULL;
 		}
-		path[len] = 0;
-		die("Not a git repository: '%s'", path);
+		die("Not a git repository: '%s'", gitdirenv);
 	}
 
 	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
@@ -197,11 +196,17 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	offset = len = strlen(cwd);
 	for (;;) {
-		if (is_toplevel_directory())
+		if (is_git_directory(".git"))
 			break;
 		chdir("..");
 		do {
 			if (!offset) {
+				if (is_git_directory(cwd)) {
+					if (chdir(cwd))
+						die("Cannot come back to cwd");
+					setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+					return NULL;
+				}
 				if (nongit_ok) {
 					if (chdir(cwd))
 						die("Cannot come back to cwd");
-- 
1.5.0.rc0.g6bb1
