From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add platform-independent .git "symlink"
Date: Sat,  2 Feb 2008 19:09:17 +0100
Message-ID: <1201975757-13771-1-git-send-email-hjemli@gmail.com>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 02 19:11:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLMpW-0007VX-7g
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 19:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbYBBSKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 13:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbYBBSKe
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 13:10:34 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:60887 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbYBBSKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 13:10:33 -0500
Received: from localhost.localdomain (ti231210a341-0149.bb.online.no [88.88.168.149])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id m12IAGFM003404;
	Sat, 2 Feb 2008 19:10:17 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4.gd2e29
In-Reply-To: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72294>

This patch allows .git to be a regular textfile containing the path of
the real git directory (formatted like "GITDIR: <path>\n"), which is
useful on platforms lacking support for real symlinks.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 setup.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index adede16..45a78c4 100644
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
+	int fd;
+	size_t len;
+
+	if (stat(path, &st))
+		return NULL;
+	if (!S_ISREG(st.st_mode) || st.st_size >= sizeof(buf))
+		return NULL;
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return NULL;
+	len = read_in_full(fd, buf, sizeof(buf));
+	close(fd);
+	if (len != st.st_size)
+		return NULL;
+	if (len < 10 || buf[len - 1] != '\n' || strncmp(buf, "GITDIR: ", 8))
+		return NULL;
+	buf[len - 1] = '\0';
+	if (!is_git_directory(buf + 8))
+		return NULL;
+	return make_absolute_path(buf + 8);
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
1.5.4.4.gd2e29
