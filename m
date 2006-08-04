From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] http-push: avoid fork() by calling merge_bases() directly
Date: Fri, 4 Aug 2006 17:50:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608041750150.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 04 17:50:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G91wk-00063Z-Ob
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 17:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbWHDPuo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 11:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161262AbWHDPun
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 11:50:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:5328 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161259AbWHDPun (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 11:50:43 -0400
Received: (qmail invoked by alias); 04 Aug 2006 15:50:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 04 Aug 2006 17:50:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24796>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 http-push.c |   49 +++++++------------------------------------------
 1 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/http-push.c b/http-push.c
index 4021e7d..dc82657 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2182,49 +2182,14 @@ static void fetch_symref(const char *pat
 
 static int verify_merge_base(unsigned char *head_sha1, unsigned char *branch_sha1)
 {
-	int pipe_fd[2];
-	pid_t merge_base_pid;
-	char line[PATH_MAX + 20];
-	unsigned char merge_sha1[20];
-	int verified = 0;
-
-	if (pipe(pipe_fd) < 0)
-		die("Verify merge base: pipe failed");
-
-	merge_base_pid = fork();
-	if (!merge_base_pid) {
-		static const char *args[] = {
-			"merge-base",
-			"-a",
-			NULL,
-			NULL,
-			NULL
-		};
-		args[2] = strdup(sha1_to_hex(head_sha1));
-		args[3] = sha1_to_hex(branch_sha1);
-
-		dup2(pipe_fd[1], 1);
-		close(pipe_fd[0]);
-		close(pipe_fd[1]);
-		execv_git_cmd(args);
-		die("merge-base setup failed");
-	}
-	if (merge_base_pid < 0)
-		die("merge-base fork failed");
-
-	dup2(pipe_fd[0], 0);
-	close(pipe_fd[0]);
-	close(pipe_fd[1]);
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		if (get_sha1_hex(line, merge_sha1))
-			die("expected sha1, got garbage:\n %s", line);
-		if (!memcmp(branch_sha1, merge_sha1, 20)) {
-			verified = 1;
-			break;
-		}
-	}
+	struct commit *head = lookup_commit(head_sha1);
+	struct commit *branch = lookup_commit(branch_sha1);
+	struct commit_list *merge_bases = get_merge_bases(head, branch, 1);
 
-	return verified;
+	if (merge_bases && !merge_bases->next && merge_bases->item == branch)
+		return 1;
+
+	return 0;
 }
 
 static int delete_remote_branch(char *pattern, int force)
-- 
1.4.2.rc2.g0bca-dirty
