From: Steve Haslam <shaslam@lastminute.com>
Subject: [PATCH] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
Date: Wed, 30 Jul 2008 12:27:18 +0100
Message-ID: <1217417238-26731-1-git-send-email-shaslam@lastminute.com>
Cc: Steve Haslam <shaslam@lastminute.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 13:29:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO9rT-0004s1-HN
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 13:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760931AbYG3L1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 07:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760825AbYG3L1o
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 07:27:44 -0400
Received: from sglonmg02-out.sabre.com ([151.193.120.24]:59898 "EHLO
	sglonmg02-out.sabre.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760318AbYG3L1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 07:27:42 -0400
X-ExtLoop1: From 10.136.85.54
X-IronPort-AV: E=Sophos;i="4.31,278,1215385200"; 
   d="scan'208";a="1125067125"
Received: from unknown (HELO sglonbh01.Global.ad.sabre.com) ([10.136.85.54])
  by sglonmg02-out.sabre.com with ESMTP; 30 Jul 2008 12:27:40 +0100
Received: from sglonms02.Global.ad.sabre.com ([10.136.85.20]) by sglonbh01.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 30 Jul 2008 12:27:40 +0100
Received: from localhost.localdomain ([10.104.41.28]) by sglonms02.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 30 Jul 2008 12:27:39 +0100
X-Mailer: git-send-email 1.6.0.rc1
X-OriginalArrivalTime: 30 Jul 2008 11:27:39.0689 (UTC) FILETIME=[4650E990:01C8F237]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90765>

If the user specified the full path to git-upload-pack as the -u option to
"git clone" when cloning a remote repository, and git was not on the default
PATH on the remote machine, git-upload-pack was failing to exec
git-pack-objects.

By making the argv[0] path (if any) available to setup_path(), this will
allow finding the "git" executable in the same directory as
"git-upload-pack". The default built in to exec_cmd.c is to look for "git"
in the ".../libexec/git-core" directory, but it is not installed there (any
longer).

Much the same applies to invoking git-receive-pack from a non-PATH location
using the "--exec" argument to "git push". Since both commands require the
same treatment, a single function has been added in exec_cmd.c to serve both.

Signed-off-by: Steve Haslam <shaslam@lastminute.com>
---
 exec_cmd.c     |   15 +++++++++++++--
 exec_cmd.h     |    2 +-
 git.c          |   20 +++++---------------
 receive-pack.c |    3 +++
 upload-pack.c  |    3 +++
 5 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index ce6741e..a2a6a0d 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -17,9 +17,20 @@ const char *system_path(const char *path)
 	return path;
 }
 
-void git_set_argv0_path(const char *path)
+const char *git_extract_argv0_path(const char *argv0)
 {
-	argv0_path = path;
+	const char *slash = argv0 + strlen(argv0);
+
+	do
+		--slash;
+	while (slash >= argv0 && !is_dir_sep(*slash));
+
+	if (slash >= argv0) {
+		argv0_path = xstrndup(argv0, slash - argv0);
+		return slash + 1;
+	}
+
+	return argv0;
 }
 
 void git_set_argv_exec_path(const char *exec_path)
diff --git a/exec_cmd.h b/exec_cmd.h
index 594f961..392e903 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -2,7 +2,7 @@
 #define GIT_EXEC_CMD_H
 
 extern void git_set_argv_exec_path(const char *exec_path);
-extern void git_set_argv0_path(const char *path);
+extern const char* git_extract_argv0_path(const char *path);
 extern const char* git_exec_path(void);
 extern void setup_path(void);
 extern const char **prepare_git_cmd(const char **argv);
diff --git a/git.c b/git.c
index 37b1d76..b1eff4a 100644
--- a/git.c
+++ b/git.c
@@ -416,23 +416,13 @@ static void execv_dashed_external(const char **argv)
 
 int main(int argc, const char **argv)
 {
-	const char *cmd = argv[0] && *argv[0] ? argv[0] : "git-help";
-	char *slash = (char *)cmd + strlen(cmd);
+	const char *cmd;
 	int done_alias = 0;
 
-	/*
-	 * Take the basename of argv[0] as the command
-	 * name, and the dirname as the default exec_path
-	 * if we don't have anything better.
-	 */
-	do
-		--slash;
-	while (cmd <= slash && !is_dir_sep(*slash));
-	if (cmd <= slash) {
-		*slash++ = 0;
-		git_set_argv0_path(cmd);
-		cmd = slash;
-	}
+	if (argv[0] && *argv[0])
+		cmd = git_extract_argv0_path(argv[0]);
+	else
+		cmd = "git-help";
 
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
diff --git a/receive-pack.c b/receive-pack.c
index d44c19e..3699b16 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -467,6 +467,9 @@ int main(int argc, char **argv)
 	int i;
 	char *dir = NULL;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	argv++;
 	for (i = 1; i < argc; i++) {
 		char *arg = *argv++;
diff --git a/upload-pack.c b/upload-pack.c
index c911e70..086eff6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -616,6 +616,9 @@ int main(int argc, char **argv)
 	int i;
 	int strict = 0;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
-- 
1.5.6.3
