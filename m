From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 13/14] Avoid a dup2(2) in apply_filter() - start_command() can do it for us.
Date: Sat, 13 Oct 2007 22:06:23 +0200
Message-ID: <1192305984-22594-14-git-send-email-johannes.sixt@telecom.at>
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
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnGz-0008Ve-RK
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbXJMUGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757729AbXJMUGl
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:41 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52600 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757642AbXJMUGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:30 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id CED8C13A6AA;
	Sat, 13 Oct 2007 22:06:28 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1192305984-22594-13-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60763>

When apply_filter() runs the external (clean or smudge) filter program, it
needs to pass the writable end of a pipe as its stdout. For this purpose,
it used to dup2(2) the file descriptor explicitly to stdout. Now we use
the facilities of start_command() to do it for us.

Furthermore, the path argument of a subordinate function, filter_buffer(),
was not used, so here we replace it to pass the fd instead.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 convert.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index 6d64994..c870817 100644
--- a/convert.c
+++ b/convert.c
@@ -201,7 +201,7 @@ static char *crlf_to_worktree(const char *path, const char *src, unsigned long *
 	return buffer;
 }
 
-static int filter_buffer(const char *path, const char *src,
+static int filter_buffer(int fd, const char *src,
 			 unsigned long size, const char *cmd)
 {
 	/*
@@ -214,6 +214,7 @@ static int filter_buffer(const char *path, const char *src,
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
 	child_process.in = -1;
+	child_process.out = fd;
 
 	if (start_command(&child_process))
 		return error("cannot fork to run external filter %s", cmd);
@@ -265,10 +266,8 @@ static char *apply_filter(const char *path, const char *src,
 		return NULL;
 	}
 	if (!child_process.pid) {
-		dup2(pipe_feed[1], 1);
 		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		exit(filter_buffer(path, src, *sizep, cmd));
+		exit(filter_buffer(pipe_feed[1], src, *sizep, cmd));
 	}
 	close(pipe_feed[1]);
 
-- 
1.5.3.3.1134.gee562
