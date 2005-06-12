From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix rename/copy when dealing with temporarily broken pairs.
Date: Sat, 11 Jun 2005 20:55:20 -0700
Message-ID: <7vwtp0p6tz.fsf@assigned-by-dhcp.cox.net>
References: <7vfyvpxlqi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 05:51:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhJVG-0008Pu-7x
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 05:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVFLDzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 23:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFLDzb
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 23:55:31 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40321 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261226AbVFLDzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 23:55:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050612035520.DOLW22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 23:55:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfyvpxlqi.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 11 Jun 2005 02:53:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When rename/copy uses a file that was broken by diffcore-break
as the source, and the broken filepair gets merged back later,
the output was mislabeled as a rename.  In this case, the source
file ends up staying in the output, so we should label it as a
copy instead.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff.c            |    1 +
 diffcore-rename.c |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -661,6 +661,7 @@ struct diff_filepair *diff_queue(struct 
 	dp->one = one;
 	dp->two = two;
 	dp->score = 0;
+	dp->status = 0;
 	dp->source_stays = 0;
 	dp->broken_pair = 0;
 	diff_q(queue, dp);
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -249,8 +249,14 @@ void diffcore_rename(int detect_rename, 
 				continue; /* unmerged */
 			else
 				locate_rename_dst(p->two, 1);
-		else if (!DIFF_FILE_VALID(p->two))
-			register_rename_src(p->one, 0);
+		else if (!DIFF_FILE_VALID(p->two)) {
+			/* If the source is a broken "delete", and
+			 * they did not really want to get broken,
+			 * that means the source actually stays.
+			 */
+			int stays = (p->broken_pair && !p->score);
+			register_rename_src(p->one, stays);
+		}
 		else if (detect_rename == DIFF_DETECT_COPY)
 			register_rename_src(p->one, 1);
 	}
------------

