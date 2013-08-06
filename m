From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [[TIG][PATCH v2] 2/3] Display correct diff the context in split log
 view
Date: Tue, 06 Aug 2013 00:58:20 -0400
Message-ID: <1375765101-31461-3-git-send-email-a.kumar@alumni.iitm.ac.in>
References: <1375765101-31461-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: fonseca@diku.dk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 06:58:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6ZLw-0005xw-TC
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 06:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab3HFE60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 00:58:26 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.4.198]:60653 "EHLO
	mta3.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab3HFE6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 00:58:24 -0400
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta3.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0MR3005QXF5BUQ50@mta3.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Tue, 06 Aug 2013 00:58:24 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V6ZLi-0008Ej-Tv; Tue,
 06 Aug 2013 00:58:22 -0400
In-reply-to: <1375765101-31461-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231719>

In the log view, when scrolling across a commit, the diff view should
automatically switch to the commit whose context the cursor is on in
the log view. This commit changes things to catch the REQ_ENTER in the
log view and handle recalculation of the commit and diff display from
log_request, rather than delegating it to pager_request. In addition,
it also gets rid of unexpected upward scrolling of the log view.

Fixes GH #155

Signed-Off-By: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
---
 NEWS  | 1 +
 tig.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/NEWS b/NEWS
index 076ac9d..1b0f737 100644
--- a/NEWS
+++ b/NEWS
@@ -49,6 +49,7 @@ Bug fixes:
  - Ignore unrepresentable characters when transliterating text for rendering.
  - Transliterate text to output encoding before trimming it to avoid
    misalignment. (GH #86)
+ - Introduce a more natural context-sensitive log display. (GH #155)
 
 tig-1.1
 -------
diff --git a/tig.c b/tig.c
index 845153f..256b589 100644
--- a/tig.c
+++ b/tig.c
@@ -4475,8 +4475,15 @@ log_request(struct view *view, enum request request, struct line *line)
 		state->recalculate_commit_context = TRUE;
 		return request;
 
+	case REQ_ENTER:
+		state->recalculate_commit_context = TRUE;
+		if (VIEW(REQ_VIEW_DIFF)->ref != ref_commit)
+			open_view(view, REQ_VIEW_DIFF, OPEN_SPLIT);
+		update_view_title(view);
+		return request;
+
 	default:
-		return pager_request(view, request, line);
+		return request;
 	}
 }
 
-- 
1.8.3.2
