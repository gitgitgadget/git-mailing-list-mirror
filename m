From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [tig] [PATCHv2 3/3] log: Colour the diff stat
Date: Sun, 13 Apr 2014 17:54:28 -0400
Message-ID: <1397426068-17439-4-git-send-email-a.kumar@alumni.iitm.ac.in>
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
	id 1WZSQ0-0002sc-3G
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 23:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbaDMV6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2014 17:58:22 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:39101 "EHLO
	mta4.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbaDMV6I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2014 17:58:08 -0400
Received: from odessa (ool-44c07830.dyn.optonline.net [68.192.120.48])
 by mta4.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0N3Z00M0DP0S6JX0@mta4.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Sun, 13 Apr 2014 17:58:05 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.82)
	(envelope-from <kumar.a@utexas.edu>)	id 1WZSPc-0004cY-12; Sun,
 13 Apr 2014 17:58:04 -0400
In-reply-to: <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246216>

This commit adds custom log_read and log_draw functions that utilize
the diff stat drawing functions from the diff module. The absence of
the triple hyphen separator prevents direct usage of the diff drawing
functions directly.

Signed-Off-By: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
---
 src/log.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/src/log.c b/src/log.c
index 40c9a21..468f7c3 100644
--- a/src/log.c
+++ b/src/log.c
@@ -23,6 +23,9 @@ struct log_state {
 	 * up/down in the log view. */
 	int last_lineno;
 	enum line_type last_type;
+	bool commit_title_read;
+	bool after_commit_header;
+	bool reading_diff_stat;
 };
 
 static void
@@ -78,14 +81,62 @@ log_request(struct view *view, enum request request, struct line *line)
 	}
 }
 
+static bool
+log_read(struct view *view, char *data)
+{
+	enum line_type type;
+	struct log_state *state = view->private;
+	size_t len;
+
+	if (!data)
+		return TRUE;
+
+	type = get_line_type(data);
+	len = strlen(data);
+
+	if (type == LINE_COMMIT)
+		state->commit_title_read = TRUE;
+	else if (state->commit_title_read && len < 1) {
+		state->commit_title_read = FALSE;
+		state->after_commit_header = TRUE;
+	} else if (state->after_commit_header && len < 1) {
+		state->after_commit_header = FALSE;
+		state->reading_diff_stat = TRUE;
+	} else if (state->reading_diff_stat) {
+		bool ret = diff_common_add_diff_stat(view, data);
+		if (ret) {
+			return TRUE;
+		} else {
+			state->reading_diff_stat = FALSE;
+		}
+	}
+
+	return pager_common_read(view, data, type);
+}
+
+static bool
+log_draw(struct view *view, struct line *line, unsigned int lineno)
+{
+	char *text = line->data;
+	enum line_type type = line->type;
+
+	if (type == LINE_DIFF_STAT) {
+		diff_common_draw_diff_stat(view, &type, &text);
+		draw_text(view, type, text);
+		return TRUE;
+	}
+
+	return pager_draw(view, line, lineno);
+}
+
 static struct view_ops log_ops = {
 	"line",
 	argv_env.head,
 	VIEW_ADD_PAGER_REFS | VIEW_OPEN_DIFF | VIEW_SEND_CHILD_ENTER | VIEW_LOG_LIKE | VIEW_REFRESH,
 	sizeof(struct log_state),
 	log_open,
-	pager_read,
-	pager_draw,
+	log_read,
+	log_draw,
 	log_request,
 	pager_grep,
 	log_select,
-- 
1.9.1
