From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add platform-independent .git "symlink"
Date: Sat,  2 Feb 2008 11:36:19 +0100
Message-ID: <1201948579-11807-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 11:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLFlB-0000eG-Ly
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761618AbYBBKhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760623AbYBBKhd
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:37:33 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:41475 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759927AbYBBKhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:37:32 -0500
Received: from localhost.localdomain (ti231210a341-0149.bb.online.no [88.88.168.149])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id m12AbGDc012966;
	Sat, 2 Feb 2008 11:37:17 +0100 (MET)
X-Mailer: git-send-email 1.5.4.GIT-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72244>

This patch allows .git to be a regular textfile containing the path of
the real git directory (formatted like "GITDIR: <path>\n"), which is
useful on platforms lacking support for real symlinks.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

All tests pass, but git-submodule needs to be updated to handle this
feature. Incidentally, git-submodule might also be the first command
wanting to use this feature; it probably should clone submodules into
a bare repository in GIT_DIR/submodules/<modulename> of the containing
repository to prevent dataloss during submodule update etc.

 setup.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index adede16..87d6115 100644
--- a/setup.c
+++ b/setup.c
@@ -239,6 +239,38 @@ static int check_repository_format_gently(int *nongit_ok)
 }
 
 /*
+ * Try to read the location of the git directory from the .git file,
+ * return path to git directory if found.
+ * Format of the .git file is
+ *    GITDIR: <path>\n
+ */
+static const char *read_gitfile_gently(const char *path)
+{
+	static char buf[PATH_MAX + 10];  /* "GITDIR: " + "\n" + "\0" */
+	struct stat st;
+	FILE *f;
+	size_t len;
+
+	if (stat(path, &st))
+		return NULL;
+	if (!S_ISREG(st.st_mode) || st.st_size > PATH_MAX + 9)
+		return NULL;
+	f = fopen(path, "r");
+	if (!f)
+		return NULL;
+	len = fread(buf, 1, st.st_size, f);
+	fclose(f);
+	if (len != st.st_size)
+		return NULL;
+	if (len < 10 || buf[len - 1] != '\n' || strncmp(buf, "GITDIR: ", 8))
+		return NULL;
+	buf[len - 1] = '\0';
+	if (!is_git_directory(buf + 8))
+		return NULL;
+	return buf + 8;
+}
+
+/*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
  */
@@ -247,6 +279,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
+	const char *gitfile_dir;
 	int len, offset;
 
 	/*
@@ -302,6 +335,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
 	offset = len = strlen(cwd);
 	for (;;) {
+		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+		if (gitfile_dir) {
+			setenv(GIT_DIR_ENVIRONMENT, gitfile_dir, 1);
+			break;
+		}
 		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 			break;
 		if (is_git_directory(".")) {
-- 
1.5.4.GIT-dirty
