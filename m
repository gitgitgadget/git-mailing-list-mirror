From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [tig] [PATCHv2 2/3] diff: Move diff stat drawing to a common function
Date: Sun, 13 Apr 2014 17:54:27 -0400
Message-ID: <1397426068-17439-3-git-send-email-a.kumar@alumni.iitm.ac.in>
References: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
 <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 23:58:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZSPz-0002sc-Ix
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 23:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbaDMV6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2014 17:58:15 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:39101 "EHLO
	mta4.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaDMV6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2014 17:58:09 -0400
Received: from odessa (ool-44c07830.dyn.optonline.net [68.192.120.48])
 by mta4.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0N3Z008BBP0S8TB0@mta4.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Sun, 13 Apr 2014 17:58:05 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.82)
	(envelope-from <kumar.a@utexas.edu>)	id 1WZSPb-0004cT-Sp; Sun,
 13 Apr 2014 17:58:03 -0400
In-reply-to: <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246214>

Signed-off-by: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
---
 include/tig/diff.h |  1 +
 src/diff.c         | 30 ++++++++++++++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/tig/diff.h b/include/tig/diff.h
index ba40386..16299fe 100644
--- a/include/tig/diff.h
+++ b/include/tig/diff.h
@@ -28,6 +28,7 @@ bool diff_common_read(struct view *view, const char *data, struct diff_state *st
 bool diff_common_draw(struct view *view, struct line *line, unsigned int lineno);
 enum request diff_common_enter(struct view *view, enum request request, struct line *line);
 bool diff_common_add_diff_stat(struct view *view, const char *data);
+void diff_common_draw_diff_stat(struct view *view, enum line_type *type, char **text);
 
 unsigned int diff_get_lineno(struct view *view, struct line *line);
 const char *diff_get_pathname(struct view *view, struct line *line);
diff --git a/src/diff.c b/src/diff.c
index 1daf8fa..b204bab 100644
--- a/src/diff.c
+++ b/src/diff.c
@@ -167,6 +167,23 @@ diff_common_draw_part(struct view *view, enum line_type *type, char **text, char
 	return sep != NULL;
 }
 
+void
+diff_common_draw_diff_stat(struct view *view, enum line_type *type, char **text)
+{
+		diff_common_draw_part(view, type, text, '|', LINE_DEFAULT);
+		if (diff_common_draw_part(view, type, text, 'B', LINE_DEFAULT)) {
+			/* Handle binary diffstat: Bin <deleted> -> <added> bytes */
+			diff_common_draw_part(view, type, text, ' ', LINE_DIFF_DEL);
+			diff_common_draw_part(view, type, text, '-', LINE_DEFAULT);
+			diff_common_draw_part(view, type, text, ' ', LINE_DIFF_ADD);
+			diff_common_draw_part(view, type, text, 'b', LINE_DEFAULT);
+
+		} else {
+			diff_common_draw_part(view, type, text, '+', LINE_DIFF_ADD);
+			diff_common_draw_part(view, type, text, '-', LINE_DIFF_DEL);
+		}
+}
+
 bool
 diff_common_draw(struct view *view, struct line *line, unsigned int lineno)
 {
@@ -180,18 +197,7 @@ diff_common_draw(struct view *view, struct line *line, unsigned int lineno)
 		return TRUE;
 
 	if (type == LINE_DIFF_STAT) {
-		diff_common_draw_part(view, &type, &text, '|', LINE_DEFAULT);
-		if (diff_common_draw_part(view, &type, &text, 'B', LINE_DEFAULT)) {
-			/* Handle binary diffstat: Bin <deleted> -> <added> bytes */
-			diff_common_draw_part(view, &type, &text, ' ', LINE_DIFF_DEL);
-			diff_common_draw_part(view, &type, &text, '-', LINE_DEFAULT);
-			diff_common_draw_part(view, &type, &text, ' ', LINE_DIFF_ADD);
-			diff_common_draw_part(view, &type, &text, 'b', LINE_DEFAULT);
-
-		} else {
-			diff_common_draw_part(view, &type, &text, '+', LINE_DIFF_ADD);
-			diff_common_draw_part(view, &type, &text, '-', LINE_DIFF_DEL);
-		}
+		diff_common_draw_diff_stat(view, &type, &text);
 	}
 
 	if (line->user_flags & DIFF_LINE_COMMIT_TITLE)
-- 
1.9.1
