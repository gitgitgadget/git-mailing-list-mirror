From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 13/14] Avoid a dup2(2) in apply_filter() - start_command() can do it for us.
Date: Fri, 19 Oct 2007 21:48:05 +0200
Message-ID: <1192823286-9654-14-git-send-email-johannes.sixt@telecom.at>
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
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:49:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iixqj-0002t3-KA
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934293AbXJSTsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763858AbXJSTse
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:34 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44529 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229AbXJSTsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:11 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 16B8297BD4;
	Fri, 19 Oct 2007 21:48:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
In-Reply-To: <1192823286-9654-13-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61751>

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
index d83c2fc..8dc9965 100644
--- a/convert.c
+++ b/convert.c
@@ -192,7 +192,7 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static int filter_buffer(const char *path, const char *src,
+static int filter_buffer(int fd, const char *src,
 			 unsigned long size, const char *cmd)
 {
 	/*
@@ -205,6 +205,7 @@ static int filter_buffer(const char *path, const char *src,
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
 	child_process.in = -1;
+	child_process.out = fd;
 
 	if (start_command(&child_process))
 		return error("cannot fork to run external filter %s", cmd);
@@ -254,10 +255,8 @@ static int apply_filter(const char *path, const char *src, size_t len,
 		return 0;
 	}
 	if (!child_process.pid) {
-		dup2(pipe_feed[1], 1);
 		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		exit(filter_buffer(path, src, len, cmd));
+		exit(filter_buffer(pipe_feed[1], src, len, cmd));
 	}
 	close(pipe_feed[1]);
 
-- 
1.5.3.4.315.g2ce38
