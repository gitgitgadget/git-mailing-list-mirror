From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diffcore-rename: fix merging back a broken pair.
Date: Sat, 08 Apr 2006 20:30:56 -0700
Message-ID: <7vr747ctn3.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060409004605.GU27689@pasky.or.cz>
	<7vwtdzcvhb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 05:31:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSQdq-0007wa-TJ
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 05:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWDIDa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 23:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWDIDa7
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 23:30:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:24719 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964973AbWDIDa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 23:30:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409033058.NSNE6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Apr 2006 23:30:58 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7vwtdzcvhb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 08 Apr 2006 19:51:12 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18539>

When a broken pair is matched up by rename detector to be merged
back, we do not want to say it is "dissimilar" with the
similarity index.  The output should just say they were changed,
taking the break score left by the earlier diffcore-break run if
any.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 diffcore-rename.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

c17de73d793ff20fce6bcc8427e5f10ab8a2a7c5
diff --git a/diffcore-rename.c b/diffcore-rename.c
index e992698..d57e865 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -54,12 +54,14 @@ static struct diff_rename_dst *locate_re
 /* Table of rename/copy src files */
 static struct diff_rename_src {
 	struct diff_filespec *one;
+	unsigned short score; /* to remember the break score */
 	unsigned src_path_left : 1;
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
 static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
-						   int src_path_left)
+						   int src_path_left,
+						   unsigned short score)
 {
 	int first, last;
 
@@ -89,6 +91,7 @@ static struct diff_rename_src *register_
 		memmove(rename_src + first + 1, rename_src + first,
 			(rename_src_nr - first - 1) * sizeof(*rename_src));
 	rename_src[first].one = one;
+	rename_src[first].score = score;
 	rename_src[first].src_path_left = src_path_left;
 	return &(rename_src[first]);
 }
@@ -198,7 +201,10 @@ static void record_rename_pair(int dst_i
 	fill_filespec(two, dst->sha1, dst->mode);
 
 	dp = diff_queue(NULL, one, two);
-	dp->score = score;
+	if (!strcmp(src->path, dst->path))
+		dp->score = rename_src[src_index].score;
+	else
+		dp->score = score;
 	dp->source_stays = rename_src[src_index].src_path_left;
 	rename_dst[dst_index].pair = dp;
 }
@@ -256,10 +262,10 @@ void diffcore_rename(struct diff_options
 			 * that means the source actually stays.
 			 */
 			int stays = (p->broken_pair && !p->score);
-			register_rename_src(p->one, stays);
+			register_rename_src(p->one, stays, p->score);
 		}
 		else if (detect_rename == DIFF_DETECT_COPY)
-			register_rename_src(p->one, 1);
+			register_rename_src(p->one, 1, p->score);
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0 ||
 	    (0 < rename_limit && rename_limit < rename_dst_nr))
-- 
1.2.6.gad0b
