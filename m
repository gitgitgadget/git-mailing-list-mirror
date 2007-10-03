From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 5/5] Use start_comand() in builtin-fetch-pack.c instead of explicit fork/exec.
Date: Wed,  3 Oct 2007 22:09:40 +0200
Message-ID: <1191442180-15905-6-git-send-email-johannes.sixt@telecom.at>
References: <200709302340.17644.johannes.sixt@telecom.at>
 <1191442180-15905-1-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-2-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-3-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-4-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-5-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 03 22:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAY6-0003WL-2w
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbXJCUJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbXJCUJv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:09:51 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:33609 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbXJCUJn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:09:43 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 84FC510B536;
	Wed,  3 Oct 2007 22:09:41 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1191442180-15905-5-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59878>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 fetch-pack.c |   35 ++++++++++-------------------------
 1 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index d06b5ec..80268e1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "pack.h"
 #include "sideband.h"
+#include "run-command.h"
 
 static int keep_pack;
 static int transfer_unpack_limit = -1;
@@ -502,9 +503,12 @@ static int get_pack(int xd[2])
 	char hdr_arg[256];
 	const char **av;
 	int do_keep = keep_pack;
+	struct child_process cmd;
 
 	side_pid = setup_sideband(fd, xd);
 
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = argv;
 	av = argv;
 	*hdr_arg = 0;
 	if (unpack_limit) {
@@ -544,33 +548,14 @@ static int get_pack(int xd[2])
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
-		close(fd[0]);
-		close(fd[1]);
-		execv_git_cmd(argv);
-		die("%s exec failed", argv[0]);
-	}
-	close(fd[0]);
 	close(fd[1]);
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
+	if (finish_command(&cmd))
+		die("%s failed", argv[0]);
+	return 0;
 }
 
 static int fetch_pack(int fd[2], int nr_match, char **match)
-- 
1.5.3.3.1134.gee562
