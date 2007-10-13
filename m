From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 03/14] Use start_command() to run content filters instead of explicit fork/exec.
Date: Sat, 13 Oct 2007 22:06:13 +0200
Message-ID: <1192305984-22594-4-git-send-email-johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-3-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnFz-0008MX-G1
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717AbXJMUGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756733AbXJMUG3
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:29 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52575 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbXJMUG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:27 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id D801013A6A6;
	Sat, 13 Oct 2007 22:06:25 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1192305984-22594-3-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60759>

The previous code already used finish_command() to wait for the process
to terminate, but did not use start_command() to run it.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 convert.c |   30 +++++++-----------------------
 1 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/convert.c b/convert.c
index d77c8eb..6d64994 100644
--- a/convert.c
+++ b/convert.c
@@ -208,34 +208,18 @@ static int filter_buffer(const char *path, const char *src,
 	 * Spawn cmd and feed the buffer contents through its stdin.
 	 */
 	struct child_process child_process;
-	int pipe_feed[2];
 	int write_err, status;
+	const char *argv[] = { "sh", "-c", cmd, NULL };
 
 	memset(&child_process, 0, sizeof(child_process));
+	child_process.argv = argv;
+	child_process.in = -1;
 
-	if (pipe(pipe_feed) < 0) {
-		error("cannot create pipe to run external filter %s", cmd);
-		return 1;
-	}
-
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
+	if (start_command(&child_process))
+		return error("cannot fork to run external filter %s", cmd);
 
-	write_err = (write_in_full(pipe_feed[1], src, size) < 0);
-	if (close(pipe_feed[1]))
+	write_err = (write_in_full(child_process.in, src, size) < 0);
+	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
 		error("cannot feed the input to external filter %s", cmd);
-- 
1.5.3.3.1134.gee562
