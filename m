From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/7 v2] Refactor git_set_argv0_path() to git_extract_argv0_path()
Date: Sun, 18 Jan 2009 13:00:10 +0100
Message-ID: <1232280015-8144-3-git-send-email-prohaska@zib.de>
References: <1232280015-8144-1-git-send-email-prohaska@zib.de>
 <1232280015-8144-2-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steve Haslam <shaslam@lastminute.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 13:02:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOWMI-0007Kr-6t
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 13:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765915AbZARMAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 07:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765595AbZARMAh
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 07:00:37 -0500
Received: from mailer.zib.de ([130.73.108.11]:32924 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765345AbZARMAf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 07:00:35 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0IC0G3B026429;
	Sun, 18 Jan 2009 13:00:25 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0IC0FJ3001758;
	Sun, 18 Jan 2009 13:00:15 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1232280015-8144-2-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106179>

From: Steve Haslam <shaslam@lastminute.com>

This commit moves the code that computes the dirname of argv[0]
from git.c's main() to git_set_argv0_path() and renames the function
to git_extract_argv0_path().  This makes the code in git.c's main
less cluttered, and we can use the dirname computation from other
main() functions too.

[ spr:
 - split Steve's original commit and wrote new commit message.
 - Integrated Johannes Schindelin's
   cca1704897e7fdb182f68d4c48a437c5d7bc5203 while rebasing onto master.
]

Signed-off-by: Steve Haslam <shaslam@lastminute.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 exec_cmd.c |   14 ++++++++++++--
 exec_cmd.h |    2 +-
 git.c      |   19 +++++--------------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index b7e7b60..23a52cf 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -21,9 +21,19 @@ const char *system_path(const char *path)
 	return path;
 }
 
-void git_set_argv0_path(const char *path)
+const char *git_extract_argv0_path(const char *argv0)
 {
-	argv0_path = path;
+	const char *slash = argv0 + strlen(argv0);
+
+	while (argv0 <= slash && !is_dir_sep(*slash))
+		slash--;
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
index a53e24f..b99b1b2 100644
--- a/git.c
+++ b/git.c
@@ -419,22 +419,13 @@ static void execv_dashed_external(const char **argv)
 
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
-	while (cmd <= slash && !is_dir_sep(*slash))
-		slash--;
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
1.6.1.87.g15624
