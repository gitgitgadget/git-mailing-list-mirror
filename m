From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 37/40] Windows: Make 'git help -a' work.
Date: Wed, 27 Feb 2008 19:55:00 +0100
Message-ID: <1204138503-6126-38-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVe-00022R-1S
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbYB0S4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756700AbYB0S4b
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:31 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40472 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810AbYB0SzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:13 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id D985B97724;
	Wed, 27 Feb 2008 19:55:10 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75256>

git help -a scans the PATH for git commands. On Windows it failed for two
reasons:

- The PATH separator is ';', not ':' on Windows.

- stat() does not set the executabe bit.

We now open the file and guess whether it is executable.

The result of the guess is good enough for the list of git commands, but
it is of no use for a general stat() implementation because (1) it is a
guess, (2) the user has no way to influence the outcome (via chmod or
similar), and (3) it would reduce stat() performance by an unacceptable
amount. Therefore, this strategy is a special-case local to help.c.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 help.c |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/help.c b/help.c
index 8143dcd..0248c76 100644
--- a/help.c
+++ b/help.c
@@ -163,6 +163,32 @@ static void pretty_print_string_list(struct cmdnames *cmds, int longest)
 	}
 }
 
+static int is_executable(const char *name)
+{
+	struct stat st;
+
+	if (stat(name, &st) || /* stat, not lstat */
+	    !S_ISREG(st.st_mode))
+		return 0;
+
+#ifdef __MINGW32__
+	/* cannot trust the executable bit, peek into the file instead */
+	char buf[3] = { 0 };
+	int n;
+	int fd = open(name, O_RDONLY);
+	st.st_mode &= ~S_IXUSR;
+	if (fd >= 0) {
+		n = read(fd, buf, 2);
+		if (n == 2)
+			/* DOS executables start with "MZ" */
+			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
+				st.st_mode |= S_IXUSR;
+		close(fd);
+	}
+#endif
+	return st.st_mode & S_IXUSR;
+}
+
 static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 					 const char *path)
 {
@@ -176,15 +202,12 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 		return 0;
 
 	while ((de = readdir(dir)) != NULL) {
-		struct stat st;
 		int entlen;
 
 		if (prefixcmp(de->d_name, prefix))
 			continue;
 
-		if (stat(de->d_name, &st) || /* stat, not lstat */
-		    !S_ISREG(st.st_mode) ||
-		    !(st.st_mode & S_IXUSR))
+		if (!is_executable(de->d_name))
 			continue;
 
 		entlen = strlen(de->d_name) - prefix_len;
@@ -208,6 +231,11 @@ static void list_commands(void)
 	const char *env_path = getenv("PATH");
 	char *paths, *path, *colon;
 	const char *exec_path = git_exec_path();
+#ifdef __MINGW32__
+	char sep = ';';
+#else
+	char sep = ':';
+#endif
 
 	if (exec_path)
 		longest = list_commands_in_dir(&main_cmds, exec_path);
@@ -219,7 +247,7 @@ static void list_commands(void)
 
 	path = paths = xstrdup(env_path);
 	while (1) {
-		if ((colon = strchr(path, ':')))
+		if ((colon = strchr(path, sep)))
 			*colon = 0;
 
 		len = list_commands_in_dir(&other_cmds, path);
-- 
1.5.4.1.126.ge5a7d
