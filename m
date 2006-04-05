From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff_flush(): leakfix.
Date: Wed, 05 Apr 2006 02:45:40 -0700
Message-ID: <7vu0982w57.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 05 11:45:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR4aA-0001nd-8R
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 11:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWDEJpn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 05:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWDEJpn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 05:45:43 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54760 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751201AbWDEJpn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 05:45:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405094542.XBNB15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 05:45:42 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18425>

We were leaking filepairs when output-format was set to
NO_OUTPUT.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is somewhat embarrassing that the original breakage was
   in a commit on Aug 21, 2005 and the bug stayed there forever
   in git timescale.

 diff.c |   44 +++++++++++++++++++++++++-------------------
 1 files changed, 25 insertions(+), 19 deletions(-)

a12d2890e4d1ada6f9302dea10d151b819e0c0d0
diff --git a/diff.c b/diff.c
index e496905..fe4664c 100644
--- a/diff.c
+++ b/diff.c
@@ -1280,28 +1280,34 @@ void diff_flush(struct diff_options *opt
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if ((diff_output_format == DIFF_FORMAT_NO_OUTPUT) ||
-		    (p->status == DIFF_STATUS_UNKNOWN))
-			continue;
-		if (p->status == 0)
-			die("internal error in diff-resolve-rename-copy");
-		switch (diff_output_format) {
-		case DIFF_FORMAT_PATCH:
-			diff_flush_patch(p, options);
-			break;
-		case DIFF_FORMAT_RAW:
-		case DIFF_FORMAT_NAME_STATUS:
-			diff_flush_raw(p, line_termination,
-				       inter_name_termination,
-				       options);
+
+		switch (p->status) {
+		case DIFF_STATUS_UNKNOWN:
 			break;
-		case DIFF_FORMAT_NAME:
-			diff_flush_name(p,
-					inter_name_termination,
-					line_termination);
+		case 0:
+			die("internal error in diff-resolve-rename-copy");
 			break;
+		default:
+			switch (diff_output_format) {
+			case DIFF_FORMAT_PATCH:
+				diff_flush_patch(p, options);
+				break;
+			case DIFF_FORMAT_RAW:
+			case DIFF_FORMAT_NAME_STATUS:
+				diff_flush_raw(p, line_termination,
+					       inter_name_termination,
+					       options);
+				break;
+			case DIFF_FORMAT_NAME:
+				diff_flush_name(p,
+						inter_name_termination,
+						line_termination);
+				break;
+			case DIFF_FORMAT_NO_OUTPUT:
+				break;
+			}
 		}
-		diff_free_filepair(q->queue[i]);
+		diff_free_filepair(p);
 	}
 	free(q->queue);
 	q->queue = NULL;
-- 
1.3.0.rc2.g110c
