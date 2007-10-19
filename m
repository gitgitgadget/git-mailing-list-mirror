From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 05/14] Use start_comand() in builtin-fetch-pack.c instead of explicit fork/exec.
Date: Fri, 19 Oct 2007 21:47:57 +0200
Message-ID: <1192823286-9654-6-git-send-email-johannes.sixt@telecom.at>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-2-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-3-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-4-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-5-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:49:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iixqd-0002t3-U9
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbXJSTsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbXJSTsT
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:19 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44505 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764839AbXJSTsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:10 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 25AB397D53;
	Fri, 19 Oct 2007 21:48:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
In-Reply-To: <1192823286-9654-5-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61754>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-fetch-pack.c |   56 ++++++++++++++-----------------------------------
 1 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index f56592f..871b704 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -7,6 +7,7 @@
 #include "pack.h"
 #include "sideband.h"
 #include "fetch-pack.h"
+#include "run-command.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -491,18 +492,19 @@ static pid_t setup_sideband(int fd[2], int xd[2])
 
 static int get_pack(int xd[2], char **pack_lockfile)
 {
-	int status;
-	pid_t pid, side_pid;
+	pid_t side_pid;
 	int fd[2];
 	const char *argv[20];
 	char keep_arg[256];
 	char hdr_arg[256];
 	const char **av;
 	int do_keep = args.keep_pack;
-	int keep_pipe[2];
+	struct child_process cmd;
 
 	side_pid = setup_sideband(fd, xd);
 
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = argv;
 	av = argv;
 	*hdr_arg = 0;
 	if (!args.keep_pack && unpack_limit) {
@@ -519,8 +521,8 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	}
 
 	if (do_keep) {
-		if (pack_lockfile && pipe(keep_pipe))
-			die("fetch-pack: pipe setup failure: %s", strerror(errno));
+		if (pack_lockfile)
+			cmd.out = -1;
 		*av++ = "index-pack";
 		*av++ = "--stdin";
 		if (!args.quiet && !args.no_progress)
@@ -544,43 +546,17 @@ static int get_pack(int xd[2], char **pack_lockfile)
 		*av++ = hdr_arg;
 	*av++ = NULL;
 
-	pid = fork();
-	if (pid < 0)
+	cmd.in = fd[0];
+	cmd.git_cmd = 1;
+	if (start_command(&cmd))
 		die("fetch-pack: unable to fork off %s", argv[0]);
-	if (!pid) {
-		dup2(fd[0], 0);
-		if (do_keep && pack_lockfile) {
-			dup2(keep_pipe[1], 1);
-			close(keep_pipe[0]);
-			close(keep_pipe[1]);
-		}
-		close(fd[0]);
-		close(fd[1]);
-		execv_git_cmd(argv);
-		die("%s exec failed", argv[0]);
-	}
-	close(fd[0]);
 	close(fd[1]);
-	if (do_keep && pack_lockfile) {
-		close(keep_pipe[1]);
-		*pack_lockfile = index_pack_lockfile(keep_pipe[0]);
-		close(keep_pipe[0]);
-	}
-	while (waitpid(pid, &status, 0) < 0) {
-		if (errno != EINTR)
-			die("waiting for %s: %s", argv[0], strerror(errno));
-	}
-	if (WIFEXITED(status)) {
-		int code = WEXITSTATUS(status);
-		if (code)
-			die("%s died with error code %d", argv[0], code);
-		return 0;
-	}
-	if (WIFSIGNALED(status)) {
-		int sig = WTERMSIG(status);
-		die("%s died of signal %d", argv[0], sig);
-	}
-	die("%s died of unnatural causes %d", argv[0], status);
+	if (do_keep && pack_lockfile)
+		*pack_lockfile = index_pack_lockfile(cmd.out);
+
+	if (finish_command(&cmd))
+		die("%s failed", argv[0]);
+	return 0;
 }
 
 static struct ref *do_fetch_pack(int fd[2],
-- 
1.5.3.4.315.g2ce38
