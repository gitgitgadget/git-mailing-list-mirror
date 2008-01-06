From: Gabriel <g2p.code@gmail.com>
Subject: [PATCH] Make commit, cherry-pick and revert more silent.
Date: Sun,  6 Jan 2008 16:43:21 +0100
Message-ID: <1199634201-26013-1-git-send-email-g2p.code@gmail.com>
Cc: Gabriel <g2p.code@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 16:43:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBXfG-0007ec-Uu
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 16:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbYAFPnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 10:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbYAFPnY
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 10:43:24 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:37488 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465AbYAFPnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 10:43:23 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 59F701AB2E9;
	Sun,  6 Jan 2008 16:43:22 +0100 (CET)
Received: from localhost (pro75-5-88-162-203-35.fbx.proxad.net [88.162.203.35])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 33D561AB2E0;
	Sun,  6 Jan 2008 16:43:22 +0100 (CET)
Received: from g2p by localhost with local (Exim 4.67)
	(envelope-from <g2p@vapeur.no-ip.org>)
	id 1JBXej-0006lv-Mm; Sun, 06 Jan 2008 16:43:21 +0100
X-Mailer: git-send-email 1.5.4.rc2.39.g00d2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69732>

Commit now obeys --quiet more.
Cherry-pick and revert call commit as --quiet.
Prevents us from displaying working-tree status once or even twice.
---
 builtin-commit.c |    4 +++-
 builtin-revert.c |    6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 73f1e35..96ace77 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -759,7 +759,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (!prepare_log_message(index_file, prefix) && !in_merge &&
 	    !allow_empty && !(amend && is_a_merge(head_sha1))) {
-		run_status(stdout, index_file, prefix, 0);
+		fprintf(stderr, "There are no changes, not committing.\n");
+		if (!quiet)
+			run_status(stdout, index_file, prefix, 0);
 		rollback_index_files();
 		unlink(commit_editmsg);
 		return 1;
diff --git a/builtin-revert.c b/builtin-revert.c
index 4bf8eb2..b925358 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -392,9 +392,11 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	if (!no_commit) {
 		if (edit)
-			return execl_git_cmd("commit", "-n", NULL);
+			return execl_git_cmd("commit", "--quiet",
+				"-n", NULL);
 		else
-			return execl_git_cmd("commit", "-n", "-F", defmsg, NULL);
+			return execl_git_cmd("commit", "--quiet",
+				"-n", "-F", defmsg, NULL);
 	}
 	if (reencoded_message)
 		free(reencoded_message);
-- 
1.5.4.rc2.39.g00d2
