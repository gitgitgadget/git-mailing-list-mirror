From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [[TIG][PATCH] 2/3] Display correct diff the context in split log view
Date: Fri, 02 Aug 2013 20:23:18 -0400
Message-ID: <1375489399-11618-3-git-send-email-a.kumar@alumni.iitm.ac.in>
References: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: git@vger.kernel.org, fonseca@diku.dk
X-From: git-owner@vger.kernel.org Sat Aug 03 02:23:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Pd2-0000kI-TC
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 02:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab3HCAXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 20:23:25 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.212]:39892 "EHLO
	mta6.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab3HCAXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 20:23:23 -0400
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta6.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-9.20 (built Jul 15 2010))
 with ESMTPA id <0MQX0083JIEX4580@mta6.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Fri, 02 Aug 2013 20:23:22 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V5Pcv-00035z-4F; Fri,
 02 Aug 2013 20:23:21 -0400
In-reply-to: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231549>

In the log view, when scrolling across a commit, the diff view should
automatically switch to the commit whose context the cursor is on in
the log view. This commit changes things to catch the REQ_ENTER in the
log view and handle recalculation of the commit and diff display from
log_request, rather than delegating it to pager_request. In addition,
it also gets rid of unexpected upward scrolling of the log view.

Fixes GH #155

Signed-Off-By: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
---
 NEWS  |  1 +
 tig.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/NEWS b/NEWS
index 0394407..f59e517 100644
--- a/NEWS
+++ b/NEWS
@@ -46,6 +46,7 @@ Bug fixes:
  - Fix rendering glitch for branch names.
  - Do not apply diff styling to untracked files in the stage view. (GH #153)
  - Fix tree indentation for entries containing combining characters. (GH #170)
+ - Introduce a more natural context-sensitive log display. (GH #155)
 
 tig-1.1
 -------
diff --git a/tig.c b/tig.c
index dd4b0f4..53947b7 100644
--- a/tig.c
+++ b/tig.c
@@ -4478,6 +4478,18 @@ log_request(struct view *view, enum request request, struct line *line)
 		state->update_commit_ref = TRUE;
 		return pager_request(view, request, line);
 
+	case REQ_ENTER:
+		/* Recalculate the correct commit for the context. */
+		state->update_commit_ref = TRUE;
+
+		open_view(view, REQ_VIEW_DIFF, OPEN_SPLIT);
+		update_view_title(view);
+
+		/* We don't want to delegate this to pager_request,
+		   since we don't want the extra scrolling of the log
+		   view. */
+		return REQ_NONE;
+
 	default:
 		return pager_request(view, request, line);
 	}
-- 
1.8.3.2
