From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/4] Add platform-independent .git "symlink"
Date: Mon,  4 Feb 2008 21:59:18 +0100
Message-ID: <1202158761-31211-2-git-send-email-hjemli@gmail.com>
References: <1202158761-31211-1-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8S1-0008Ne-MC
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbYBDVBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbYBDVBC
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:01:02 -0500
Received: from mail42.e.nsc.no ([193.213.115.42]:46880 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbYBDVBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:01:01 -0500
Received: from localhost.localdomain (ti231210a341-0149.bb.online.no [88.88.168.149])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id m14L0REd021902;
	Mon, 4 Feb 2008 22:00:30 +0100 (MET)
X-Mailer: git-send-email 1.5.4.5.g25d066
In-Reply-To: <1202158761-31211-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72567>

This patch allows .git to be a regular textfile containing the path of
the real git directory (formatted like "gitdir: <path>\n"), which is
useful on platforms lacking support for real symlinks.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 setup.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index adede16..2cbda91 100644
--- a/setup.c
+++ b/setup.c
@@ -239,6 +239,40 @@ static int check_repository_format_gently(int *nongit_ok)
 }
 
 /*
+ * Try to read the location of the git directory from the .git file,
+ * return path to git directory if found.
+ * Format of the .git file is
+ *    gitdir: <path>\n
+ */
+static const char *read_gitfile_gently(const char *path)
+{
+	static char buf[PATH_MAX + 9];  /* "gitdir: " + "\n" */
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
+	if (!len || buf[len - 1] != '\n')
+		return NULL;
+	buf[len - 1] = '\0';
+	if (prefixcmp(buf, "gitdir: "))
+		return NULL;
+	if (!is_git_directory(buf + 8))
+		return NULL;
+	return make_absolute_path(buf + 8);
+}
+
+/*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
  */
@@ -247,6 +281,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
+	const char *gitfile_dir;
 	int len, offset;
 
 	/*
@@ -302,6 +337,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
1.5.4.5.g25d066
