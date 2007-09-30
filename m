From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 5/5] Use start_comand() in builtin-fetch-pack.c instead of explicit fork/exec.
Date: Sun, 30 Sep 2007 22:10:01 +0200
Message-ID: <1191183001-5368-6-git-send-email-johannes.sixt@telecom.at>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-3-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-4-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-5-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 30 22:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic57p-0002lG-2J
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbXI3UKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbXI3UKQ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 16:10:16 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:36912 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbXI3UKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 16:10:06 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id DA9199737A;
	Sun, 30 Sep 2007 22:10:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1191183001-5368-5-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59557>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-fetch-pack.c |   55 ++++++++++++++-----------------------------------
 1 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 19c144d..d0eca2d 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -7,6 +7,7 @@
 #include "pack.h"
 #include "sideband.h"
 #include "fetch-pack.h"
+#include "run-command.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -499,11 +500,13 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	char hdr_arg[256];
 	const char **av;
 	int do_keep = args.keep_pack;
-	int keep_pipe[2];
+	struct child_process cmd;
 
 	side_pid = setup_sideband(fd, xd);
 
-	av = argv;
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = av = argv;
+
 	*hdr_arg = 0;
 	if (!args.keep_pack && unpack_limit) {
 		struct pack_header header;
@@ -519,8 +522,8 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	}
 
 	if (do_keep) {
-		if (pack_lockfile && pipe(keep_pipe))
-			die("fetch-pack: pipe setup failure: %s", strerror(errno));
+		if (pack_lockfile)
+			cmd.out = -1;
 		*av++ = "index-pack";
 		*av++ = "--stdin";
 		if (!args.quiet && !args.no_progress)
@@ -544,43 +547,17 @@ static int get_pack(int xd[2], char **pack_lockfile)
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
1.5.3.3.1134.gee562
