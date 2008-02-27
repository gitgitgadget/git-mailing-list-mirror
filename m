From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 36/40] Avoid the "dup dance" in wt_status_print_verbose() when possible.
Date: Wed, 27 Feb 2008 19:54:59 +0100
Message-ID: <1204138503-6126-37-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVd-00022R-Cu
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701AbYB0S4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755808AbYB0S43
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:29 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40469 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbYB0SzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:13 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id B8F4E97723;
	Wed, 27 Feb 2008 19:55:10 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75261>

If the status output already goes to stdout, then it is not necessary to
redirect stdout for the diff machinery. (This case hangs on Windows for
unknown reasons.)

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 wt-status.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 32d780a..e4999ea 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -312,15 +312,17 @@ static void wt_status_print_untracked(struct wt_status *s)
 static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
-	int saved_stdout;
+	int saved_stdout = -1;
 
 	fflush(s->fp);
 
 	/* Sigh, the entire diff machinery is hardcoded to output to
 	 * stdout.  Do the dup-dance...*/
-	saved_stdout = dup(STDOUT_FILENO);
-	if (saved_stdout < 0 ||dup2(fileno(s->fp), STDOUT_FILENO) < 0)
-		die("couldn't redirect stdout\n");
+	if (fileno(s->fp) != STDOUT_FILENO) {
+		saved_stdout = dup(STDOUT_FILENO);
+		if (saved_stdout < 0 ||dup2(fileno(s->fp), STDOUT_FILENO) < 0)
+			die("couldn't redirect stdout\n");
+	}
 
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, s->reference);
@@ -330,7 +332,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 
 	fflush(stdout);
 
-	if (dup2(saved_stdout, STDOUT_FILENO) < 0)
+	if (saved_stdout >= 0 && dup2(saved_stdout, STDOUT_FILENO) < 0)
 		die("couldn't restore stdout\n");
 	close(saved_stdout);
 }
-- 
1.5.4.1.126.ge5a7d
