From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 14/14] Use the asyncronous function infrastructure to run the content filter.
Date: Sat, 13 Oct 2007 22:06:24 +0200
Message-ID: <1192305984-22594-15-git-send-email-johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-3-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-4-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-5-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-6-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-7-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-8-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-9-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-10-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-11-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-12-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-13-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-14-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:07:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnH4-0008Ve-LR
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758135AbXJMUG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758497AbXJMUG4
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:56 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52604 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739AbXJMUGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:30 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 1228E13A7A2;
	Sat, 13 Oct 2007 22:06:29 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1192305984-22594-14-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60764>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 convert.c |   60 +++++++++++++++++++++++++++---------------------------------
 1 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/convert.c b/convert.c
index c870817..10161a0 100644
--- a/convert.c
+++ b/convert.c
@@ -201,15 +201,21 @@ static char *crlf_to_worktree(const char *path, const char *src, unsigned long *
 	return buffer;
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
@@ -217,17 +223,17 @@ static int filter_buffer(int fd, const char *src,
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
+		error("external filter %s failed", params->cmd);
 	return (write_err || status);
 }
 
@@ -241,42 +247,31 @@ static char *apply_filter(const char *path, const char *src,
 	 * (child --> cmd) --> us
 	 */
 	const int SLOP = 4096;
-	int pipe_feed[2];
-	int status;
 	char *dst;
 	unsigned long dstsize, dstalloc;
-	struct child_process child_process;
+	struct async async;
+	struct filter_params params;
 
 	if (!cmd)
 		return NULL;
 
-	memset(&child_process, 0, sizeof(child_process));
-
-	if (pipe(pipe_feed) < 0) {
-		error("cannot create pipe to run external filter %s", cmd);
-		return NULL;
-	}
+	memset(&async, 0, sizeof(async));
+	async.proc = filter_buffer;
+	async.data = &params;
+	params.src = src;
+	params.size = *sizep;
+	params.cmd = cmd;
 
 	fflush(NULL);
-	child_process.pid = fork();
-	if (child_process.pid < 0) {
-		error("cannot fork to run external filter %s", cmd);
-		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		return NULL;
-	}
-	if (!child_process.pid) {
-		close(pipe_feed[0]);
-		exit(filter_buffer(pipe_feed[1], src, *sizep, cmd));
-	}
-	close(pipe_feed[1]);
+	if (start_async(&async))
+		return 0;	/* error was already reported */
 
 	dstalloc = *sizep;
 	dst = xmalloc(dstalloc);
 	dstsize = 0;
 
 	while (1) {
-		ssize_t numread = xread(pipe_feed[0], dst + dstsize,
+		ssize_t numread = xread(async.out, dst + dstsize,
 					dstalloc - dstsize);
 
 		if (numread <= 0) {
@@ -293,15 +288,14 @@ static char *apply_filter(const char *path, const char *src,
 			dst = xrealloc(dst, dstalloc);
 		}
 	}
-	if (close(pipe_feed[0])) {
+	if (close(async.out)) {
 		error("read from external filter %s failed", cmd);
 		free(dst);
 		dst = NULL;
 	}
 
-	status = finish_command(&child_process);
-	if (status) {
-		error("external filter %s failed %d", cmd, -status);
+	if (finish_async(&async)) {
+		error("external filter %s failed", cmd);
 		free(dst);
 		dst = NULL;
 	}
-- 
1.5.3.3.1134.gee562
