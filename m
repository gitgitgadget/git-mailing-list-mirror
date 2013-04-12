From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 4/4] log -L: improve comments in process_all_files()
Date: Fri, 12 Apr 2013 18:05:12 +0200
Message-ID: <4f96a58897d36d9540bdfb9c0ed291ebd9d1eceb.1365781999.git.trast@inf.ethz.ch>
References: <cover.1365781999.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgTp-0000ti-OU
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab3DLQFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:05:24 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6617 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296Ab3DLQFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:05:23 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:21 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:20 +0200
X-Mailer: git-send-email 1.8.2.1.567.g8ad0f43
In-Reply-To: <cover.1365781999.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220990>

The funny range assignment in process_all_files() had me sidetracked
while investigating what led to the previous commit.  Let's improve
the comments.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 line-log.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/line-log.c b/line-log.c
index 44d1cd5..4bbb09b 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1095,11 +1095,24 @@ static int process_all_files(struct line_log_data **range_out,
 
 	for (i = 0; i < queue->nr; i++) {
 		struct diff_ranges *pairdiff = NULL;
-		if (process_diff_filepair(rev, queue->queue[i], *range_out, &pairdiff)) {
+		struct diff_filepair *pair = queue->queue[i];
+		if (process_diff_filepair(rev, pair, *range_out, &pairdiff)) {
+			/*
+			 * Store away the diff for later output.  We
+			 * tuck it in the ranges we got as _input_,
+			 * since that's the commit that caused the
+			 * diff.
+			 *
+			 * NEEDSWORK not enough when we get around to
+			 * doing something interesting with merges;
+			 * currently each invocation on a merge parent
+			 * trashes the previous one's diff.
+			 *
+			 * NEEDSWORK tramples over data structures not owned here
+			 */
 			struct line_log_data *rg = range;
 			changed++;
-			/* NEEDSWORK tramples over data structures not owned here */
-			while (rg && strcmp(rg->path, queue->queue[i]->two->path))
+			while (rg && strcmp(rg->path, pair->two->path))
 				rg = rg->next;
 			assert(rg);
 			rg->pair = diff_filepair_dup(queue->queue[i]);
-- 
1.8.2.1.567.g8ad0f43
