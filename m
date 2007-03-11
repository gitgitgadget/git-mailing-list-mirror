From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] use $GIT_DIR/workdir as working directory with $GIT_DIR
Date: Sun, 11 Mar 2007 22:29:06 +0100
Message-ID: <20070311212906.GA18208@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com> <20070311155649.GA29663@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 22:29:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVbO-0007sa-CD
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbXCKV3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbXCKV3L
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:29:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:48834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750982AbXCKV3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:29:09 -0400
Received: (qmail invoked by alias); 11 Mar 2007 21:29:08 -0000
Received: from pD9EB9C1C.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.156.28]
  by mail.gmx.net (mp044) with SMTP; 11 Mar 2007 22:29:08 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+XSnx30w+Xlke2HIIkFGvdxhdn6LaJvHcbbismA4
	3NNRFatpXARtN5
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070311155649.GA29663@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41985>

$GIT_DIR/workdir will be used as fallback if $GIT_WORK_DIR is not set

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 Documentation/repository-layout.txt |    4 ++
 setup.c                             |   64 ++++++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index 0459bd9..8a88080 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -179,3 +179,7 @@ shallow::
 	and maintained by shallow clone mechanism.  See `--depth`
 	option to gitlink:git-clone[1] and gitlink:git-fetch[1].
 
+workdir::
+	Directory to be used as toplevel working directory when GIT_DIR
+	is set.  If this is a file the first line will be used as the
+	name of the directory.  This can be overriden by GIT_WORK_DIR.
diff --git a/setup.c b/setup.c
index ebf628e..a8b9fae 100644
--- a/setup.c
+++ b/setup.c
@@ -192,6 +192,64 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
+static int stat_git_work_dir(struct stat *st)
+{
+	char workdir[PATH_MAX], cwd[PATH_MAX];
+	const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
+	const char *gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
+	int offset;
+	FILE *fp;
+
+	if (gitwd) {
+		if (!stat(gitwd, st))
+			return 1;
+		die("Unable to stat git working directory '%s'", gitwd);
+	}
+
+	/* setup_git_directory_gently: PATH_MAX - 40 >= strlen(gitdirenv) */
+	strcpy(workdir, gitdir);
+	strcat(workdir, "/workdir");
+
+	if (stat(workdir, st))
+		return 0;
+	if (st->st_mode & S_IFDIR)
+		return 1;
+	if (!(st->st_mode & S_IFREG))
+		die("GIT_DIR/workdir is neither a file nor a directory");
+
+	/* GIT_DIR/workdir is a file */
+	fp = fopen(workdir, "r");
+	if (!fp)
+		die("Unable to open '%s'", workdir);
+	if (!fgets(workdir, sizeof(workdir), fp))
+		die("Reading working directory from '%s' failed", workdir);
+	fclose(fp);
+	/* remove newline character(s) */
+	offset = strlen(workdir)-1;
+	while (offset >= 0 && (workdir[offset] == '\r' ||
+			workdir[offset] == '\n'))
+		--offset;
+	workdir[offset+1] = '\0';
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
+		die("Unable to stat directory from GIT_DIR/workdir");
+	if (!(st->st_mode & S_IFDIR))
+		die("GIT_DIR/workdir does not point to a directory");
+
+	if (workdir[0] != '/' && chdir(cwd))
+		die("Cannot come back to cwd");
+
+	return 1;
+}
+
 int has_working_directory = -1;
 
 const char *setup_git_directory_gently(int *nongit_ok)
@@ -203,7 +261,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
 		struct stat st, st_work, st_git;
-		const char *gitwd;
 		char *prefix;
 		char c;
 		int len;
@@ -219,11 +276,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
1.5.0.3.357.g0b2cd
