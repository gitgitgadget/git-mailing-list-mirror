From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 3/5] Use start_command() to run the filter instead of explicit fork/exec.
Date: Sun, 30 Sep 2007 22:09:59 +0200
Message-ID: <1191183001-5368-4-git-send-email-johannes.sixt@telecom.at>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-3-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 30 22:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic57H-0002Yg-WF
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbXI3UKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbXI3UKG
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 16:10:06 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:36907 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbXI3UKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 16:10:04 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 506C49735C;
	Sun, 30 Sep 2007 22:10:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1191183001-5368-3-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59556>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 convert.c |   36 ++++++++++--------------------------
 1 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/convert.c b/convert.c
index 0d5e909..560679d 100644
--- a/convert.c
+++ b/convert.c
@@ -196,40 +196,24 @@ static int filter_buffer(const char *path, const char *src,
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
 	 */
-	struct child_process child_process;
-	int pipe_feed[2];
+	struct child_process chld;
 	int write_err, status;
+	const char *argv[] = { "sh", "-c", cmd, NULL };
 
-	memset(&child_process, 0, sizeof(child_process));
+	memset(&chld, 0, sizeof(chld));
+	chld.argv = argv;
+	chld.in = -1;
 
-	if (pipe(pipe_feed) < 0) {
-		error("cannot create pipe to run external filter %s", cmd);
-		return 1;
-	}
+	if (start_command(&chld))
+		return error("cannot fork to run external filter %s", cmd);
 
-	child_process.pid = fork();
-	if (child_process.pid < 0) {
-		error("cannot fork to run external filter %s", cmd);
-		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		return 1;
-	}
-	if (!child_process.pid) {
-		dup2(pipe_feed[0], 0);
-		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		execlp("sh", "sh", "-c", cmd, NULL);
-		return 1;
-	}
-	close(pipe_feed[0]);
-
-	write_err = (write_in_full(pipe_feed[1], src, size) < 0);
-	if (close(pipe_feed[1]))
+	write_err = (write_in_full(chld.in, src, size) < 0);
+	if (close(chld.in))
 		write_err = 1;
 	if (write_err)
 		error("cannot feed the input to external filter %s", cmd);
 
-	status = finish_command(&child_process);
+	status = finish_command(&chld);
 	if (status)
 		error("external filter %s failed %d", cmd, -status);
 	return (write_err || status);
-- 
1.5.3.3.1134.gee562
