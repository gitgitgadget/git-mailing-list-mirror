From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [tig] [PATCH 3/3] log: Colour the diff stat
Date: Fri, 11 Apr 2014 08:20:05 -0400
Message-ID: <1397218805-2560-4-git-send-email-a.kumar@alumni.iitm.ac.in>
References: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 14:51:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYavA-0008LZ-TB
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 14:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbaDKMuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 08:50:50 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:60504 "EHLO
	mta5.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612AbaDKMuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 08:50:23 -0400
Received: from odessa (ool-44c07830.dyn.optonline.net [68.192.120.48])
 by mta5.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0N3V00EWH8XU9HF0@mta5.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Fri, 11 Apr 2014 08:20:19 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.82)
	(envelope-from <kumar.a@utexas.edu>)	id 1WYaRO-0000jl-5P; Fri,
 11 Apr 2014 08:20:18 -0400
In-reply-to: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246086>

This commit adds custom log_read and log_draw functions that utilize
the diff stat drawing functions from the diff module. The absence of
the triple hyphen separator prevents direct usage of the diff drawing
functions directly.

Signed-Off-By: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
---
 src/log.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/src/log.c b/src/log.c
index eef61dc..e6f2a82 100644
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
@@ -76,14 +79,69 @@ log_request(struct view *view, enum request request, struct line *line)
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
+
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
+	if (draw_lineno(view, lineno))
+		return TRUE;
+
+	if (line->wrapped && draw_text(view, LINE_DELIMITER, "+"))
+		return TRUE;
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
