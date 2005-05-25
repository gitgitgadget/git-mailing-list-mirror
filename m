From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix type-change handling when assigning the status code to
 filepairs.
Date: Wed, 25 May 2005 15:07:08 -0700
Message-ID: <7vvf57hsdv.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050525111711.GA27492@vrfy.org>
	<Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
	<20050525183546.GA4241@vrfy.org>
	<7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 00:06:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db40q-0006kb-2S
	for gcvg-git@gmane.org; Thu, 26 May 2005 00:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVEYWHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 18:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVEYWHq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 18:07:46 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:33926 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261573AbVEYWHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 18:07:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525220709.HPUO7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 18:07:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vzmujjdq4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 25 May 2005 12:40:51 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The interim single-liner '?' fix resulted delete entries that
should not have emitted coming out in the output as an
unintended side effect; I caught this with the "rename" test in
the test suite.  This patch instead fixes the code that assigns
the status code to each filepair.

I verified this does not break the testcase in udev.git tree Kay
Sievers gave us, by running git-diff-tree on that tree which
showed 21 file to symlink changes.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Linus, it just struck me that there is nothing inherently
*** wrong to detect whole subtree renames (diffcore-rename
*** currently does not attempt to match tree creation against
*** tree delete to produce tree rename/copy).  This is something
*** I am _not_ going to do, but it still would be interesting to
*** keep in mind...

diff.c     |   36 ++++++++++++++++++++++--------------
diffcore.h |    3 +++
2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -691,27 +691,34 @@ static void diff_resolve_rename_copy(voi
 
 	for (i = 0; i < q->nr; i++) {
 		p = q->queue[i];
-		p->status = 0;
+		p->status = 0; /* undecided */
 		if (DIFF_PAIR_UNMERGED(p))
 			p->status = 'U';
 		else if (!DIFF_FILE_VALID((p)->one))
 			p->status = 'N';
 		else if (!DIFF_FILE_VALID((p)->two)) {
 			/* Deletion record should be omitted if there
-			 * is another entry that is a rename or a copy
-			 * and it uses this one as the source.  Then we
-			 * can say the other one is a rename.
+			 * are rename/copy entries using this one as
+			 * the source.  Then we can say one of them
+			 * is a rename and the rest are copies.
 			 */
+			p->status = 'D';
 			for (j = 0; j < q->nr; j++) {
 				pp = q->queue[j];
 				if (!strcmp(pp->one->path, p->one->path) &&
-				    strcmp(pp->one->path, pp->two->path))
+				    strcmp(pp->one->path, pp->two->path)) {
+					p->status = 'X';
 					break;
+				}
 			}
-			if (j < q->nr)
-				continue; /* has rename/copy */
-			p->status = 'D';
 		}
+		else if (DIFF_PAIR_TYPE_CHANGED(p))
+			p->status = 'T';
+
+		/* from this point on, we are dealing with a pair
+		 * whose both sides are valid and of the same type, i.e.
+		 * either in-place edit or rename/copy edit.
+		 */
 		else if (strcmp(p->one->path, p->two->path)) {
 			/* See if there is somebody else anywhere that
 			 * will keep the path (either modified or
@@ -719,7 +726,7 @@ static void diff_resolve_rename_copy(voi
 			 * not a rename.  In addition, if there is
 			 * some other rename or copy that comes later
 			 * than us that uses the same source, we
-			 * cannot be a rename either.
+			 * have to be a copy, not a rename.
 			 */
 			for (j = 0; j < q->nr; j++) {
 				pp = q->queue[j];
@@ -745,10 +752,9 @@ static void diff_resolve_rename_copy(voi
 		}
 		else if (memcmp(p->one->sha1, p->two->sha1, 20))
 			p->status = 'M';
-		else {
-			/* we do not need this one */
-			p->status = 0;
-		}
+		else
+			/* this is a "no-change" entry */
+			p->status = 'X';
 	}
 	diff_debug_queue("resolve-rename-copy done", q);
 }
@@ -767,8 +773,10 @@ void diff_flush(int diff_output_style, i
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
+		if (p->status == 'X')
+			continue;
 		if (p->status == 0)
-			p->status = '?';
+			die("internal error in diff-resolve-rename-copy");
 		switch (diff_output_style) {
 		case DIFF_FORMAT_PATCH:
 			diff_flush_patch(p);
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -45,6 +45,9 @@ struct diff_filepair {
 #define DIFF_PAIR_UNMERGED(p) \
 	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
 
+#define DIFF_PAIR_TYPE_CHANGED(p) \
+	((S_IFMT & (p)->one->mode) != (S_IFMT & (p)->two->mode))
+
 extern int diff_unmodified_pair(struct diff_filepair *);
 
 struct diff_queue_struct {
------------------------------------------------

