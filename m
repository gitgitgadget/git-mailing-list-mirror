From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-status: wording update to deal with deleted files.
Date: Thu, 11 Jan 2007 15:37:41 -0800
Message-ID: <7vsleh16ey.fsf_-_@assigned-by-dhcp.cox.net>
References: <87bql5cok3.fsf@morpheus.local>
	<7vejq12nlu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 00:38:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H59Ug-0000RH-Tb
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 00:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbXAKXh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 18:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbXAKXh6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 18:37:58 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:51442 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932818AbXAKXh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 18:37:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111233756.LDQZ25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 18:37:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9zd51W00e1kojtg0000000; Thu, 11 Jan 2007 18:37:06 -0500
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <7vejq12nlu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 11 Jan 2007 14:41:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36633>

If you do:

	$ /bin/rm foo
	$ git status

we used to say "git add ... to add content to commit".  But
suggsting "git add" to record the deletion of a file is simply
insane.

So this rewords various things:

 - The section header is the old "Changed but not updated",
   instead of "Changed but not added";

 - Suggestion is "git add ... to update what will be committed",
   instead of "... to add content to commit";

 - If there are removed paths, the above suggestion becomes "git
   add/rm ... to update what will be committed";

 - For untracked files, the suggestion is "git add ... to
   include in what will be committed".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This needs the previous "git rm" update to make sense.
   Currently "/bin/rm foo ; git rm foo" would fail because the
   latter cannot remove foo (it gets "No such file or
   directory").

 wt-status.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 1dc2fdc..a849951 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -15,7 +15,13 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
 	"\033[31m", /* WT_STATUS_CHANGED: red */
 	"\033[31m", /* WT_STATUS_UNTRACKED: red */
 };
-static const char* use_add_msg = "use \"git add <file>...\" to incrementally add content to commit";
+
+static const char use_add_msg[] =
+"use \"git add <file>...\" to update what will be committed";
+static const char use_add_rm_msg[] =
+"use \"git add/rm <file>...\" to update what will be committed";
+static const char use_add_to_include_msg[] =
+"use \"git add <file>...\" to include in what will be committed";
 
 static int parse_status_slot(const char *var, int offset)
 {
@@ -177,8 +183,14 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 	struct wt_status *s = data;
 	int i;
 	if (q->nr) {
+		const char *msg = use_add_msg;
 		s->workdir_dirty = 1;
-		wt_status_print_header("Changed but not added", use_add_msg);
+		for (i = 0; i < q->nr; i++)
+			if (q->queue[i]->status == DIFF_STATUS_DELETED) {
+				msg = use_add_rm_msg;
+				break;
+			}
+		wt_status_print_header("Changed but not updated", msg);
 	}
 	for (i = 0; i < q->nr; i++)
 		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
@@ -265,7 +277,8 @@ static void wt_status_print_untracked(struct wt_status *s)
 		}
 		if (!shown_header) {
 			s->workdir_untracked = 1;
-			wt_status_print_header("Untracked files", use_add_msg);
+			wt_status_print_header("Untracked files",
+					       use_add_to_include_msg);
 			shown_header = 1;
 		}
 		color_printf(color(WT_STATUS_HEADER), "#\t");
-- 
1.4.4.4.gb8a1
