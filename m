From: Scott Parish <srp@srparish.net>
Subject: [PATCH] When exec'ing sub-commands, fall back on execvp (the PATH)
Date: Fri, 19 Oct 2007 23:44:59 -0700
Message-ID: <20071020064459.GB2237@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 08:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij85H-0000BA-Ou
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762111AbXJTGpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760927AbXJTGpH
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:45:07 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:52684 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762022AbXJTGpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:45:06 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Ij853-0006w3-42
	for git@vger.kernel.org; Sat, 20 Oct 2007 01:45:05 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Fri, 19 Oct 2007 23:45:00 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61799>

 Signed-off-by: Scott R Parish <srp@srparish.net>

---
 exec_cmd.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 9b74ed2..674c9f3 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -34,15 +34,15 @@ int execv_git_cmd(const char **argv)
 {
 	char git_command[PATH_MAX + 1];
 	int i;
+	int rc;
 	const char *paths[] = { current_exec_path,
 				getenv(EXEC_PATH_ENVIRONMENT),
 				builtin_exec_path };
+	const char *tmp;
+	size_t len;
 
 	for (i = 0; i < ARRAY_SIZE(paths); ++i) {
-		size_t len;
-		int rc;
 		const char *exec_dir = paths[i];
-		const char *tmp;
 
 		if (!exec_dir || !*exec_dir) continue;
 
@@ -106,8 +106,26 @@ int execv_git_cmd(const char **argv)
 
 		argv[0] = tmp;
 	}
-	return -1;
 
+	rc = snprintf(git_command, sizeof(git_command), "git-%s", argv[0]);
+	if (rc < 0 || rc >= sizeof(git_command) - len) {
+		fprintf(stderr, "git: command name given is too long.\n");
+		return -1;
+	}
+
+	tmp = argv[0];
+	argv[0] = git_command;
+
+	trace_argv_printf(argv, -1, "trace: exec:");
+
+	/* execve() can only ever return if it fails */
+	execvp(git_command, (char **)argv);
+
+	trace_printf("trace: exec failed: %s\n", strerror(errno));
+
+	argv[0] = tmp;
+
+	return -1;
 }
 
 
-- 
1.5.3.GIT
