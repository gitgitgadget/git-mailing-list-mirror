From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 3/7] Refactor git_set_argv0_path() to git_extract_argv0_path()
Date: Sun, 17 Aug 2008 14:44:39 +0200
Message-ID: <1218977083-14526-4-git-send-email-prohaska@zib.de>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de>
 <1218977083-14526-2-git-send-email-prohaska@zib.de>
 <1218977083-14526-3-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steve Haslam <shaslam@lastminute.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 14:46:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUheK-0001kf-0d
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 14:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbYHQMpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 08:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbYHQMpT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 08:45:19 -0400
Received: from mailer.zib.de ([130.73.108.11]:52109 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbYHQMpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 08:45:16 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m7HCikYX021933;
	Sun, 17 Aug 2008 14:44:51 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m7HCihbQ002872;
	Sun, 17 Aug 2008 14:44:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1218977083-14526-3-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92602>

From: Steve Haslam <shaslam@lastminute.com>

This commit moves the code that computes the dirname of argv[0]
from git.c's main() to git_set_argv0_path() and renames the function
to git_extract_argv0_path().  This makes the code in git.c's main
less cluttered, and we can use the direname computation from other
main() functions too.

[spr: split Steve's original commit and wrote new commit message. ]

Signed-off-by: Steve Haslam <shaslam@lastminute.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 exec_cmd.c |   15 +++++++++++++--
 exec_cmd.h |    2 +-
 git.c      |   20 +++++---------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 1622481..d84e9e9 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -57,9 +57,20 @@ const char *system_path(const char *path)
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
-- 
1.6.0.rc3.22.g053fd
