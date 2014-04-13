From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [tig] [PATCHv2 1/3] diff: Move diff stat addition to a common function
Date: Sun, 13 Apr 2014 17:54:26 -0400
Message-ID: <1397426068-17439-2-git-send-email-a.kumar@alumni.iitm.ac.in>
References: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
 <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 23:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZSPo-0002eC-Dt
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 23:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbaDMV6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2014 17:58:10 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:39101 "EHLO
	mta4.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaDMV6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2014 17:58:07 -0400
Received: from odessa (ool-44c07830.dyn.optonline.net [68.192.120.48])
 by mta4.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0N3Z00LCCP0SCYW0@mta4.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Sun, 13 Apr 2014 17:58:05 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.82)
	(envelope-from <kumar.a@utexas.edu>)	id 1WZSPb-0004cP-Nu; Sun,
 13 Apr 2014 17:58:03 -0400
In-reply-to: <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246213>

Signed-off-by: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
---
 include/tig/diff.h |  1 +
 src/diff.c         | 27 ++++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/tig/diff.h b/include/tig/diff.h
index be325c4..ba40386 100644
--- a/include/tig/diff.h
+++ b/include/tig/diff.h
@@ -27,6 +27,7 @@ enum request diff_common_edit(struct view *view, enum request request, struct li
 bool diff_common_read(struct view *view, const char *data, struct diff_state *state);
 bool diff_common_draw(struct view *view, struct line *line, unsigned int lineno);
 enum request diff_common_enter(struct view *view, enum request request, struct line *line);
+bool diff_common_add_diff_stat(struct view *view, const char *data);
 
 unsigned int diff_get_lineno(struct view *view, struct line *line);
 const char *diff_get_pathname(struct view *view, struct line *line);
diff --git a/src/diff.c b/src/diff.c
index 4b30068..1daf8fa 100644
--- a/src/diff.c
+++ b/src/diff.c
@@ -38,6 +38,21 @@ diff_open(struct view *view, enum open_flags flags)
 }
 
 bool
+diff_common_add_diff_stat(struct view *view, const char *data)
+{
+	size_t len = strlen(data);
+	char *pipe = strchr(data, '|');
+	bool has_histogram = data[len - 1] == '-' || data[len - 1] == '+';
+	bool has_bin_diff = pipe && strstr(pipe, "Bin") && strstr(pipe, "->");
+	bool has_rename = data[len - 1] == '0' && (strstr(data, "=>") || !strncmp(data, " ...", 4));
+	bool has_no_change = pipe && strstr(pipe, " 0");
+
+	if (pipe && (has_histogram || has_bin_diff || has_rename || has_no_change))
+		return add_line_text(view, data, LINE_DIFF_STAT) != NULL;
+	return FALSE;
+}
+
+bool
 diff_common_read(struct view *view, const char *data, struct diff_state *state)
 {
 	enum line_type type = get_line_type(data);
@@ -49,15 +64,9 @@ diff_common_read(struct view *view, const char *data, struct diff_state *state)
 		state->reading_diff_stat = TRUE;
 
 	if (state->reading_diff_stat) {
-		size_t len = strlen(data);
-		char *pipe = strchr(data, '|');
-		bool has_histogram = data[len - 1] == '-' || data[len - 1] == '+';
-		bool has_bin_diff = pipe && strstr(pipe, "Bin") && strstr(pipe, "->");
-		bool has_rename = data[len - 1] == '0' && (strstr(data, "=>") || !strncmp(data, " ...", 4));
-		bool has_no_change = pipe && strstr(pipe, " 0");
-
-		if (pipe && (has_histogram || has_bin_diff || has_rename || has_no_change)) {
-			return add_line_text(view, data, LINE_DIFF_STAT) != NULL;
+		bool ret = diff_common_add_diff_stat(view, data);
+		if (ret) {
+			return TRUE;
 		} else {
 			state->reading_diff_stat = FALSE;
 		}
-- 
1.9.1
