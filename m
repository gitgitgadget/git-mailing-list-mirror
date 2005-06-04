From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diffcore-break.c: various fixes.
Date: Fri, 03 Jun 2005 23:05:57 -0700
Message-ID: <7vwtpairlm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 08:03:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeRkb-0004Fk-4m
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 08:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFDGG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 02:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVFDGG2
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 02:06:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21462 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261253AbVFDGF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2005 02:05:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050604060556.TOSX8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Jun 2005 02:05:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This fixes three bugs in the -B heuristics.

 - Although it was advertised that the initial break criteria
   used was the same as what diffcore-rename uses, it was using
   something different.  Instead of using smaller of src and dst
   size to compare with "edit" size, (insertion and deletion),
   it was using larger of src and dst, unlike the rename/copy
   detection logic.  This caused the parameter to -B to mean
   something different from the one to -M and -C.  To compensate
   for this change, the default break score is also changed to
   match that of the default for rename/copy.

 - The code would have crashed with division by zero when trying
   to break an originally empty file.

 - Contrary to what the comment said, the algorithm was breaking
   small files, only to later merge them together.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diffcore.h       |    2 +-
 diffcore-break.c |   22 ++++++++--------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -17,7 +17,7 @@
  */
 #define MAX_SCORE 60000
 #define DEFAULT_RENAME_SCORE 30000 /* rename/copy similarity minimum (50%) */
-#define DEFAULT_BREAK_SCORE  59400 /* minimum for break to happen (99%)*/
+#define DEFAULT_BREAK_SCORE  30000 /* minimum for break to happen (50%)*/
 #define DEFAULT_MERGE_SCORE  48000 /* maximum for break-merge to happen (80%)*/
 
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
diff --git a/diffcore-break.c b/diffcore-break.c
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -61,14 +61,7 @@ static int should_break(struct diff_file
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0; /* error but caught downstream */
 
-	delta_size = ((src->size < dst->size) ?
-		      (dst->size - src->size) : (src->size - dst->size));
-
-	/* Notice that we use max of src and dst as the base size,
-	 * unlike rename similarity detection.  This is so that we do
-	 * not mistake a large addition as a complete rewrite.
-	 */
-	base_size = ((src->size < dst->size) ? dst->size : src->size);
+	base_size = ((src->size < dst->size) ? src->size : dst->size);
 
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
@@ -88,10 +81,11 @@ static int should_break(struct diff_file
 	 * less than the minimum, after rename/copy runs.
 	 */
 	if (src->size <= src_copied)
-		delta_size = 0; /* avoid wrapping around */
-	else
+		; /* all copied, nothing removed */
+	else {
 		delta_size = src->size - src_copied;
-	*merge_score_p = delta_size * MAX_SCORE / src->size;
+		*merge_score_p = delta_size * MAX_SCORE / src->size;
+	}
 	
 	/* Extent of damage, which counts both inserts and
 	 * deletes.
@@ -174,7 +168,8 @@ void diffcore_break(int break_score)
 		    !S_ISDIR(p->one->mode) && !S_ISDIR(p->two->mode) &&
 		    !strcmp(p->one->path, p->two->path)) {
 			if (should_break(p->one, p->two,
-					 break_score, &score)) {
+					 break_score, &score) &&
+			    MINIMUM_BREAK_SIZE <= p->one->size) {
 				/* Split this into delete and create */
 				struct diff_filespec *null_one, *null_two;
 				struct diff_filepair *dp;
@@ -185,8 +180,7 @@ void diffcore_break(int break_score)
 				 * Also we do not want to break very
 				 * small files.
 				 */
-				if ((score < merge_score) ||
-				    (p->one->size < MINIMUM_BREAK_SIZE))
+				if (score < merge_score)
 					score = 0;
 
 				/* deletion of one */
------------

