From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 3/5] Use start_command() to run the filter instead of explicit fork/exec.
Date: Wed,  3 Oct 2007 22:09:38 +0200
Message-ID: <1191442180-15905-4-git-send-email-johannes.sixt@telecom.at>
References: <200709302340.17644.johannes.sixt@telecom.at>
 <1191442180-15905-1-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-2-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-3-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 03 22:09:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAXa-0003Ig-6v
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbXJCUJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbXJCUJo
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:09:44 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:33601 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbXJCUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:09:42 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 2F0E210AEF2;
	Wed,  3 Oct 2007 22:09:41 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1191442180-15905-3-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59876>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 convert.c |   30 +++++++-----------------------
 1 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/convert.c b/convert.c
index 0d5e909..6a8c806 100644
--- a/convert.c
+++ b/convert.c
@@ -197,34 +197,18 @@ static int filter_buffer(const char *path, const char *src,
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
