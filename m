From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [[TIG][PATCH] 1/3] Add log_select function to find commit from context
 in log view
Date: Fri, 02 Aug 2013 20:23:17 -0400
Message-ID: <1375489399-11618-2-git-send-email-a.kumar@alumni.iitm.ac.in>
References: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: git@vger.kernel.org, fonseca@diku.dk
X-From: git-owner@vger.kernel.org Sat Aug 03 02:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5PdC-0001Ci-Rs
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 02:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab3HCAX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 20:23:28 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:36772 "EHLO
	mta4.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab3HCAX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 20:23:26 -0400
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta4.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0MQX00FA5IEX5511@mta4.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Fri, 02 Aug 2013 20:23:22 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V5Pcu-00035v-Uy; Fri,
 02 Aug 2013 20:23:20 -0400
In-reply-to: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231552>

This commit introduces and uses the log_select function to find the
correct commit in the unsplit log view. In the log view, if one
scrolls down across a commit line, the current commit (as displayed in
the status bar) gets updated, but not so when scrolling upward across
a commit. The log_select function handles this scenario to to the
``right thing''. In addition, it introduces the log_state structure as
the private entry of the log view to hold a flag that decides whether
to re-evaluate the current commit based on scrolling.

Signed-off-by: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
---
 tig.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/tig.c b/tig.c
index 72f132a..dd4b0f4 100644
--- a/tig.c
+++ b/tig.c
@@ -4384,6 +4384,33 @@ pager_select(struct view *view, struct line *line)
 	}
 }
 
+struct log_state {
+	bool update_commit_ref;
+};
+
+static void
+log_select(struct view *view, struct line *line)
+{
+	struct log_state *state = (struct log_state *) view->private;
+
+	if (state->update_commit_ref && line->lineno > 1) {
+		/* We need to recalculate the previous commit,
+		   since the user has likely scrolled up. */
+		const struct line *commit_line = find_prev_line_by_type(view, line, LINE_COMMIT);
+
+		if (commit_line)
+			string_copy_rev(view->ref, (char *) (commit_line->data + STRING_SIZE("commit ")));
+	}
+	if (line->type == LINE_COMMIT) {
+		char *text = (char *)line->data + STRING_SIZE("commit ");
+
+		if (!view_has_flags(view, VIEW_NO_REF))
+			string_copy_rev(view->ref, text);
+	}
+	string_copy_rev(ref_commit, view->ref);
+	state->update_commit_ref = FALSE;
+}
+
 static bool
 pager_open(struct view *view, enum open_flags flags)
 {
@@ -4427,11 +4454,30 @@ log_open(struct view *view, enum open_flags flags)
 static enum request
 log_request(struct view *view, enum request request, struct line *line)
 {
+	struct log_state *state = (struct log_state *) view->private;
+
 	switch (request) {
 	case REQ_REFRESH:
 		load_refs();
 		refresh_view(view);
 		return REQ_NONE;
+
+	case REQ_MOVE_UP:
+	case REQ_PREVIOUS:
+		if (line->type == LINE_COMMIT && line->lineno > 1) {
+			/* We are at a commit, and heading upward. We
+			   force log_select to find the previous
+			   commit above, from the context. */
+			state->update_commit_ref = TRUE;
+		}
+		return pager_request(view, request, line);
+
+	case REQ_MOVE_PAGE_UP:
+	case REQ_MOVE_PAGE_DOWN:
+		/* We need to figure out the right commit again. */
+		state->update_commit_ref = TRUE;
+		return pager_request(view, request, line);
+
 	default:
 		return pager_request(view, request, line);
 	}
@@ -4441,13 +4487,13 @@ static struct view_ops log_ops = {
 	"line",
 	{ "log" },
 	VIEW_ADD_PAGER_REFS | VIEW_OPEN_DIFF | VIEW_SEND_CHILD_ENTER | VIEW_NO_PARENT_NAV,
-	0,
+	sizeof(struct log_state),
 	log_open,
 	pager_read,
 	pager_draw,
 	log_request,
 	pager_grep,
-	pager_select,
+	log_select,
 };
 
 struct diff_state {
-- 
1.8.3.2
