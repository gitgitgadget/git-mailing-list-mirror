From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [tig] [PATCH 2/3] diff: Move diff stat drawing to a common function
Date: Fri, 11 Apr 2014 08:20:04 -0400
Message-ID: <1397218805-2560-3-git-send-email-a.kumar@alumni.iitm.ac.in>
References: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 14:51:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYavA-0008LZ-Bb
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 14:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbaDKMuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 08:50:50 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.4.198]:59711 "EHLO
	mta3.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985AbaDKMuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 08:50:23 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Apr 2014 08:50:22 EDT
Received: from odessa (ool-44c07830.dyn.optonline.net [68.192.120.48])
 by mta3.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0N3V00AAT8XUZJ50@mta3.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Fri, 11 Apr 2014 08:20:19 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.82)
	(envelope-from <kumar.a@utexas.edu>)	id 1WYaRO-0000jg-0c; Fri,
 11 Apr 2014 08:20:18 -0400
In-reply-to: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246087>

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
