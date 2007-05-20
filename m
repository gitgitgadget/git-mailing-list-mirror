From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] allow commands to be executed in submodules
Date: Sun, 20 May 2007 17:39:08 +0200
Message-ID: <20070520153908.GF5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 17:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpnVA-00008f-W8
	for gcvg-git@gmane.org; Sun, 20 May 2007 17:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227AbXETPjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 11:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757304AbXETPjM
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 11:39:12 -0400
Received: from mail.admingilde.org ([213.95.32.147]:42073 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757105AbXETPjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 11:39:11 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HpnUy-00016K-9E
	for git@vger.kernel.org; Sun, 20 May 2007 17:39:08 +0200
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47842>

Add an extra "submodule" field to struct child_process to be able to
easily start commands which are to be executed in a submodule
repository.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---

 run-command.c     |   13 ++++++
 run-command.h     |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index eff523e..c2475e4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -73,6 +73,19 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
+		if (cmd->submodule) {
+			int err = chdir(cmd->submodule);
+			if (err) {
+				die("cannot exec %s in %s.",
+					cmd->argv[0], cmd->submodule);
+			}
+			/* don't inherit supermodule environment */
+			unsetenv(GIT_DIR_ENVIRONMENT);
+			unsetenv(DB_ENVIRONMENT);
+			unsetenv(INDEX_ENVIRONMENT);
+			unsetenv(GRAFT_ENVIRONMENT);
+		}
+
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else {
diff --git a/run-command.h b/run-command.h
index 3680ef9..2940186 100644
--- a/run-command.h
+++ b/run-command.h
@@ -16,6 +16,7 @@ struct child_process {
 	pid_t pid;
 	int in;
 	int out;
+	const char *submodule;
 	unsigned close_in:1;
 	unsigned close_out:1;
 	unsigned no_stdin:1;
-- 
1.5.2.2.g081e


-- 
Martin Waitz
