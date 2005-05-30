From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] diff: fix the culling of unneeded delete record.
Date: Mon, 30 May 2005 00:08:07 -0700
Message-ID: <7v4qcl8a3s.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
	<7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
	<7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net>
	<7vekbp8ajm.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 09:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DceLX-0000oW-V3
	for gcvg-git@gmane.org; Mon, 30 May 2005 09:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVE3HI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 03:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVE3HI2
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 03:08:28 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33445 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261532AbVE3HIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 03:08:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530070807.WCJB550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 03:08:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekbp8ajm.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 23:58:37 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The commit 15d061b435a7e3b6bead39df3889f4af78c4b00a

    [PATCH] Fix the way diffcore-rename records unremoved source.

still leaves unneeded delete records in its output stream by
mistake, which was covered up by having an extra check to turn
such a delete into a no-op downstream.  Fix the check in the
diffcore-rename to simplify the output routine.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff.c            |   23 ++---------------------
 diffcore-rename.c |   44 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 32 deletions(-)

3fde726e95a828e680c95297f185d6d25fcf853a (from 9c88ea020142346a56e36cea87e349814675f3f5)
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -792,27 +792,8 @@ static void diff_resolve_rename_copy(voi
 			p->status = 'U';
 		else if (!DIFF_FILE_VALID(p->one))
 			p->status = 'N';
-		else if (!DIFF_FILE_VALID(p->two)) {
-			/* Deleted entry may have been picked up by
-			 * another rename-copy entry.  So we scan the
-			 * queue and if we find one that uses us as the
-			 * source we do not say delete for this entry.
-			 */
-			for (j = 0; j < q->nr; j++) {
-				pp = q->queue[j];
-				if (!strcmp(p->one->path, pp->one->path) &&
-				    DIFF_PAIR_RENAME(pp)) {
-					/* rename/copy are always valid
-					 * so we do not say DIFF_FILE_VALID()
-					 * on pp->one and pp->two.
-					 */
-					p->status = 'X';
-					break;
-				}
-			}
-			if (!p->status)
-				p->status = 'D';
-		}
+		else if (!DIFF_FILE_VALID(p->two))
+			p->status = 'D';
 		else if (DIFF_PAIR_TYPE_CHANGED(p))
 			p->status = 'T';
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -328,26 +328,48 @@ void diffcore_rename(int detect_rename, 
 	outq.nr = outq.alloc = 0;
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		struct diff_rename_dst *dst = locate_rename_dst(p->two, 0);
 		struct diff_filepair *pair_to_free = NULL;
 
-		if (dst) {
-			/* creation */
-			if (dst->pair) {
-				/* renq has rename/copy to produce
-				 * this file already, so we do not
-				 * emit the creation record in the
-				 * output.
-				 */
+		if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
+			/*
+			 * Creation
+			 *
+			 * We would output this create record if it has
+			 * not been turned into a rename/copy already.
+			 */
+			struct diff_rename_dst *dst =
+				locate_rename_dst(p->two, 0);
+			if (dst && dst->pair) {
 				diff_q(&outq, dst->pair);
 				pair_to_free = p;
 			}
 			else
-				/* no matching rename/copy source, so record
-				 * this as a creation.
+				/* no matching rename/copy source, so
+				 * record this as a creation.
 				 */
 				diff_q(&outq, p);
 		}
+		else if (DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two)) {
+			/*
+			 * Deletion
+			 *
+			 * We would output this delete record if renq
+			 * does not have a rename/copy to move
+			 * p->one->path out.
+			 */
+			for (j = 0; j < renq.nr; j++)
+				if (!strcmp(renq.queue[j]->one->path,
+					    p->one->path))
+					break;
+			if (j < renq.nr)
+				/* this path remains */
+				pair_to_free = p;
+
+			if (pair_to_free)
+				;
+			else
+				diff_q(&outq, p);
+		}
 		else if (!diff_unmodified_pair(p))
 			/* all the usual ones need to be kept */
 			diff_q(&outq, p);

