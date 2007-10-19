From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 03/14] Use start_command() to run content filters instead of explicit fork/exec.
Date: Fri, 19 Oct 2007 21:47:55 +0200
Message-ID: <1192823286-9654-4-git-send-email-johannes.sixt@telecom.at>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-2-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-3-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IixpX-0002gS-Et
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbXJSTsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbXJSTsL
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:11 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44488 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764641AbXJSTsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:09 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 8D3D597D48;
	Fri, 19 Oct 2007 21:48:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
In-Reply-To: <1192823286-9654-3-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61744>

The previous code already used finish_command() to wait for the process
to terminate, but did not use start_command() to run it.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 convert.c |   30 +++++++-----------------------
 1 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/convert.c b/convert.c
index aa95834..d83c2fc 100644
--- a/convert.c
+++ b/convert.c
@@ -199,34 +199,18 @@ static int filter_buffer(const char *path, const char *src,
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
1.5.3.4.315.g2ce38
