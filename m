From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not verify filenames in a bare repository
Date: Sat, 20 Jan 2007 03:09:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200308280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jan 20 03:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H85fn-0004qo-79
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 03:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbXATCJg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 21:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932844AbXATCJg
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 21:09:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:49532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932807AbXATCJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 21:09:36 -0500
Received: (qmail invoked by alias); 20 Jan 2007 02:09:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 20 Jan 2007 03:09:34 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37249>


For example, it makes no sense to check the presence of a file
named "HEAD" when calling "git log HEAD" in a bare repository.

Noticed by Han-Wen Nienhuys.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	This is slightly longer than my 1st attempt, but more complete: 
	this works now, too:

		(cd git; git show HEAD)

 cache.h                 |    1 +
 setup.c                 |   26 ++++++++++++++++++++++++++
 t/t1020-subdirectory.sh |    7 +++++++
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index bdaabbe..9690f0f 100644
--- a/cache.h
+++ b/cache.h
@@ -129,6 +129,7 @@ extern int cache_errno;
 
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
+extern int is_inside_git_dir(void);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
diff --git a/setup.c b/setup.c
index cc97f9f..e9d3f5a 100644
--- a/setup.c
+++ b/setup.c
@@ -95,6 +95,8 @@ void verify_non_filename(const char *prefix, const char *arg)
 	const char *name;
 	struct stat st;
 
+	if (is_inside_git_dir())
+		return;
 	if (*arg == '-')
 		return; /* flag */
 	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
@@ -168,6 +170,28 @@ static int is_git_directory(const char *suspect)
 	return 1;
 }
 
+static int inside_git_dir = -1;
+
+int is_inside_git_dir(void)
+{
+	if (inside_git_dir < 0) {
+		char buffer[1024];
+
+		if (is_bare_repository())
+			return (inside_git_dir = 1);
+		if (getcwd(buffer, sizeof(buffer))) {
+			const char *git_dir = get_git_dir(), *cwd = buffer;
+			while (*git_dir && *git_dir == *cwd) {
+				git_dir++;
+				cwd++;
+			}
+			inside_git_dir = !*git_dir;
+		} else
+			inside_git_dir = 0;
+	}
+	return inside_git_dir;
+}
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static char cwd[PATH_MAX+1];
@@ -206,6 +230,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 					if (chdir(cwd))
 						die("Cannot come back to cwd");
 					setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+					inside_git_dir = 1;
 					return NULL;
 				}
 				if (nongit_ok) {
@@ -226,6 +251,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	offset++;
 	cwd[len++] = '/';
 	cwd[len] = 0;
+	inside_git_dir = !strncmp(cwd + offset, ".git/", 5);
 	return cwd + offset;
 }
 
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 4409b87..b4b035a 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -106,4 +106,11 @@ test_expect_success 'read-tree' '
 	cmp ../one ../original.one
 '
 
+test_expect_success 'no file/rev ambuguity check inside .git' '
+	cd $HERE &&
+	git commit -a -m 1 &&
+	cd $HERE/.git &&
+	git show HEAD
+'
+
 test_done
-- 
1.5.0.rc1.g6d11-dirty
