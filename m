From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] diff: code clean-up and removal of rename hack.
Date: Sun, 29 May 2005 16:56:48 -0700
Message-ID: <7v4qclh9hb.fsf_-_@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:55:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXbw-0002em-MJ
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVE2X44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVE2X44
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:56:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:15573 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261469AbVE2X4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:56:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529235649.PTEZ7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 19:56:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 16:41:25 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A new macro, DIFF_PAIR_RENAME(), is introduced to distinguish a
filepair that is a rename/copy (the definition of which is src
and dst are different paths, of course).  This removes the hack
used in the record_rename_pair() to always put a non-zero value
in the score field.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c            |    6 +++---
diffcore-rename.c |    2 +-
diffcore.h        |    6 +++---
3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -796,7 +796,7 @@ static void diff_resolve_rename_copy(voi
 			for (j = 0; j < q->nr; j++) {
 				pp = q->queue[j];
 				if (!strcmp(p->one->path, pp->one->path) &&
-				    pp->score) {
+				    DIFF_PAIR_RENAME(pp)) {
 					/* rename/copy are always valid
 					 * so we do not say DIFF_FILE_VALID()
 					 * on pp->one and pp->two.
@@ -815,7 +815,7 @@ static void diff_resolve_rename_copy(voi
 		 * whose both sides are valid and of the same type, i.e.
 		 * either in-place edit or rename/copy edit.
 		 */
-		else if (p->score) {
+		else if (DIFF_PAIR_RENAME(p)) {
 			if (p->source_stays) {
 				p->status = 'C';
 				continue;
@@ -828,7 +828,7 @@ static void diff_resolve_rename_copy(voi
 				pp = q->queue[j];
 				if (strcmp(pp->one->path, p->one->path))
 					continue; /* not us */
-				if (!pp->score)
+				if (!DIFF_PAIR_RENAME(pp))
 					continue; /* not a rename/copy */
 				/* pp is a rename/copy from the same source */
 				p->status = 'C';
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -207,7 +207,7 @@ static void record_rename_pair(struct di
 	fill_filespec(two, dst->sha1, dst->mode);
 
 	dp = diff_queue(renq, one, two);
-	dp->score = score ? : 1; /* make sure it is at least 1 */
+	dp->score = score;
 	dp->source_stays = rename_src[src_index].src_stays;
 	rename_dst[dst_index].pair = dp;
 }
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -39,15 +39,15 @@ extern void diff_free_filespec_data(stru
 struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
-	unsigned short int score; /* only valid when one and two are
-				   * different paths
-				   */
+	unsigned short int score;
 	char source_stays; /* all of R/C are copies */
 	char status; /* M C R N D U (see Documentation/diff-format.txt) */
 };
 #define DIFF_PAIR_UNMERGED(p) \
 	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
 
+#define DIFF_PAIR_RENAME(p) (strcmp((p)->one->path, (p)->two->path))
+
 #define DIFF_PAIR_TYPE_CHANGED(p) \
 	((S_IFMT & (p)->one->mode) != (S_IFMT & (p)->two->mode))
 

