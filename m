From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] diffcore_filespec: add is_binary
Date: Thu, 28 Jun 2007 23:35:59 -0700
Message-ID: <11830989621033-git-send-email-gitster@pobox.com>
References: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 08:36:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4A5R-0004Qn-6R
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 08:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757727AbXF2GgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 02:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756640AbXF2GgG
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 02:36:06 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64975 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbXF2GgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 02:36:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629063602.WHMR3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 02:36:02 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HJc11X00M1kojtg0000100; Fri, 29 Jun 2007 02:36:02 -0400
X-Mailer: git-send-email 1.5.2.2.1414.g1e7d9
In-Reply-To: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51153>

diffcore-break and diffcore-rename would want to behave slightly
differently depending on the binary-ness of the data, so add one
bit to the filespec, as the structure is now passed down to
diffcore_count_changes() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c     |   16 ++++++++++++++++
 diffcore.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 9938969..74c1198 100644
--- a/diff.c
+++ b/diff.c
@@ -3005,6 +3005,22 @@ void diffcore_std(struct diff_options *options)
 {
 	if (options->quiet)
 		return;
+
+	/*
+	 * break/rename count similarity differently depending on
+	 * the binary-ness.
+	 */
+	if ((options->break_opt != -1) || (options->detect_rename)) {
+		struct diff_queue_struct *q = &diff_queued_diff;
+		int i;
+
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			p->one->is_binary = file_is_binary(p->one);
+			p->two->is_binary = file_is_binary(p->two);
+		}
+	}
+
 	if (options->break_opt != -1)
 		diffcore_break(options->break_opt);
 	if (options->detect_rename)
diff --git a/diffcore.h b/diffcore.h
index 990dec5..0c8abb5 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -37,6 +37,7 @@ struct diff_filespec {
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
+	unsigned is_binary : 1; /* data should be considered "binary" */
 };
 
 extern struct diff_filespec *alloc_filespec(const char *);
-- 
1.5.2.2.1414.g1e7d9
