From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 14/14] Use the asyncronous function infrastructure to run the content filter.
Date: Fri, 19 Oct 2007 21:48:06 +0200
Message-ID: <1192823286-9654-15-git-send-email-johannes.sixt@telecom.at>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-2-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-3-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-4-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-5-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-6-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-7-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-8-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-9-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-10-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-11-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-12-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-13-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-14-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iixqk-0002t3-BZ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935141AbXJSTsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934340AbXJSTsg
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:36 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44532 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbXJSTsM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:12 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 545F597C80;
	Fri, 19 Oct 2007 21:48:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
In-Reply-To: <1192823286-9654-14-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61752>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 convert.c |   61 ++++++++++++++++++++++++++++---------------------------------
 1 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/convert.c b/convert.c
index 8dc9965..4df7559 100644
--- a/convert.c
+++ b/convert.c
@@ -192,15 +192,21 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static int filter_buffer(int fd, const char *src,
-			 unsigned long size, const char *cmd)
+struct filter_params {
+	const char *src;
+	unsigned long size;
+	const char *cmd;
+};
+
+static int filter_buffer(int fd, void *data)
 {
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
 	 */
 	struct child_process child_process;
+	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
-	const char *argv[] = { "sh", "-c", cmd, NULL };
+	const char *argv[] = { "sh", "-c", params->cmd, NULL };
 
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
@@ -208,17 +214,17 @@ static int filter_buffer(int fd, const char *src,
 	child_process.out = fd;
 
 	if (start_command(&child_process))
-		return error("cannot fork to run external filter %s", cmd);
+		return error("cannot fork to run external filter %s", params->cmd);
 
-	write_err = (write_in_full(child_process.in, src, size) < 0);
+	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
 	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
-		error("cannot feed the input to external filter %s", cmd);
+		error("cannot feed the input to external filter %s", params->cmd);
 
 	status = finish_command(&child_process);
 	if (status)
-		error("external filter %s failed %d", cmd, -status);
+		error("external filter %s failed %d", params->cmd, -status);
 	return (write_err || status);
 }
 
@@ -231,47 +237,36 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	 *
 	 * (child --> cmd) --> us
 	 */
-	int pipe_feed[2];
-	int status, ret = 1;
-	struct child_process child_process;
+	int ret = 1;
 	struct strbuf nbuf;
+	struct async async;
+	struct filter_params params;
 
 	if (!cmd)
 		return 0;
 
-	memset(&child_process, 0, sizeof(child_process));
-
-	if (pipe(pipe_feed) < 0) {
-		error("cannot create pipe to run external filter %s", cmd);
-		return 0;
-	}
+	memset(&async, 0, sizeof(async));
+	async.proc = filter_buffer;
+	async.data = &params;
+	params.src = src;
+	params.size = len;
+	params.cmd = cmd;
 
 	fflush(NULL);
-	child_process.pid = fork();
-	if (child_process.pid < 0) {
-		error("cannot fork to run external filter %s", cmd);
-		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		return 0;
-	}
-	if (!child_process.pid) {
-		close(pipe_feed[0]);
-		exit(filter_buffer(pipe_feed[1], src, len, cmd));
-	}
-	close(pipe_feed[1]);
+	if (start_async(&async))
+		return 0;	/* error was already reported */
 
 	strbuf_init(&nbuf, 0);
-	if (strbuf_read(&nbuf, pipe_feed[0], len) < 0) {
+	if (strbuf_read(&nbuf, async.out, len) < 0) {
 		error("read from external filter %s failed", cmd);
 		ret = 0;
 	}
-	if (close(pipe_feed[0])) {
+	if (close(async.out)) {
 		error("read from external filter %s failed", cmd);
 		ret = 0;
 	}
-	status = finish_command(&child_process);
-	if (status) {
-		error("external filter %s failed %d", cmd, -status);
+	if (finish_async(&async)) {
+		error("external filter %s failed", cmd);
 		ret = 0;
 	}
 
-- 
1.5.3.4.315.g2ce38
