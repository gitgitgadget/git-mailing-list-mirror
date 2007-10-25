From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/6] copy vs rename detection: avoid unnecessary O(n*m)
 loops
Date: Thu, 25 Oct 2007 11:20:56 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251119120.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7L2-0003qo-He
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbXJYSVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbXJYSVe
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:21:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37686 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753061AbXJYSVd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 14:21:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIKvR8018726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 11:20:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIKudC007899;
	Thu, 25 Oct 2007 11:20:57 -0700
In-Reply-To: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.219 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62349>


From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/6] copy vs rename detection: avoid unnecessary O(n*m) loops

The core rename detection had some rather stupid code to check if a
pathname was used by a later modification or rename, which basically
walked the whole pathname space for all renames for each rename, in
order to tell whether it was a pure rename (no remaining users) or
should be considered a copy (other users of the source file remaining).

That's really silly, since we can just keep a count of users around, and
replace all those complex and expensive loops with just testing that
simple counter (but this all depends on the previous commit that shared
the diff_filespec data structure by using a separate reference count).

Note that the reference count is not the same as the rename count: they
behave otherwise rather similarly, but the reference count is tied to
the allocation (and decremented at de-allocation, so that when it turns
zero we can get rid of the memory), while the rename count is tied to
the renames and is decremented when we find a rename (so that when it
turns zero we know that it was a rename, not a copy).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This fixes the generic diffcode infrastructure, but doesn't do the actual 
*detection* any faster. But as you can tell, it's a huge cleanup on its 
own, and basically removes the "incidental" and stupid support costs of 
rename detection.

 diff.c            |   40 +++++++++++++------------------
 diffcore-rename.c |   68 +++++++++++++---------------------------------------
 diffcore.h        |    2 +-
 3 files changed, 35 insertions(+), 75 deletions(-)

diff --git a/diff.c b/diff.c
index 0b320f6..af85b94 100644
--- a/diff.c
+++ b/diff.c
@@ -2597,9 +2597,9 @@ void diff_debug_filepair(const struct diff_filepair *p, int i)
 {
 	diff_debug_filespec(p->one, i, "one");
 	diff_debug_filespec(p->two, i, "two");
-	fprintf(stderr, "score %d, status %c stays %d broken %d\n",
+	fprintf(stderr, "score %d, status %c rename_used %d broken %d\n",
 		p->score, p->status ? p->status : '?',
-		p->source_stays, p->broken_pair);
+		p->one->rename_used, p->broken_pair);
 }
 
 void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
@@ -2617,8 +2617,8 @@ void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
 
 static void diff_resolve_rename_copy(void)
 {
-	int i, j;
-	struct diff_filepair *p, *pp;
+	int i;
+	struct diff_filepair *p;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
 	diff_debug_queue("resolve-rename-copy", q);
@@ -2640,27 +2640,21 @@ static void diff_resolve_rename_copy(void)
 		 * either in-place edit or rename/copy edit.
 		 */
 		else if (DIFF_PAIR_RENAME(p)) {
-			if (p->source_stays) {
-				p->status = DIFF_STATUS_COPIED;
-				continue;
-			}
-			/* See if there is some other filepair that
-			 * copies from the same source as us.  If so
-			 * we are a copy.  Otherwise we are either a
-			 * copy if the path stays, or a rename if it
-			 * does not, but we already handled "stays" case.
+			/*
+			 * A rename might have re-connected a broken
+			 * pair up, causing the pathnames to be the
+			 * same again. If so, that's not a rename at
+			 * all, just a modification..
+			 *
+			 * Otherwise, see if this source was used for
+			 * multiple renames, in which case we decrement
+			 * the count, and call it a copy.
 			 */
-			for (j = i + 1; j < q->nr; j++) {
-				pp = q->queue[j];
-				if (strcmp(pp->one->path, p->one->path))
-					continue; /* not us */
-				if (!DIFF_PAIR_RENAME(pp))
-					continue; /* not a rename/copy */
-				/* pp is a rename/copy from the same source */
+			if (!strcmp(p->one->path, p->two->path))
+				p->status = DIFF_STATUS_MODIFIED;
+			else if (--p->one->rename_used > 0)
 				p->status = DIFF_STATUS_COPIED;
-				break;
-			}
-			if (!p->status)
+			else
 				p->status = DIFF_STATUS_RENAMED;
 		}
 		else if (hashcmp(p->one->sha1, p->two->sha1) ||
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3da06b7..edb2424 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -55,12 +55,10 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 static struct diff_rename_src {
 	struct diff_filespec *one;
 	unsigned short score; /* to remember the break score */
-	unsigned src_path_left : 1;
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
 static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
-						   int src_path_left,
 						   unsigned short score)
 {
 	int first, last;
@@ -92,7 +90,6 @@ static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
 			(rename_src_nr - first - 1) * sizeof(*rename_src));
 	rename_src[first].one = one;
 	rename_src[first].score = score;
-	rename_src[first].src_path_left = src_path_left;
 	return &(rename_src[first]);
 }
 
@@ -216,6 +213,7 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 		die("internal error: dst already matched.");
 
 	src = rename_src[src_index].one;
+	src->rename_used++;
 	src->count++;
 
 	dst = rename_dst[dst_index].two;
@@ -227,7 +225,6 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 		dp->score = rename_src[src_index].score;
 	else
 		dp->score = score;
-	dp->source_stays = rename_src[src_index].src_path_left;
 	rename_dst[dst_index].pair = dp;
 }
 
@@ -245,21 +242,6 @@ static int score_compare(const void *a_, const void *b_)
 	return b->score - a->score;
 }
 
-static int compute_stays(struct diff_queue_struct *q,
-			 struct diff_filespec *one)
-{
-	int i;
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		if (strcmp(one->path, p->two->path))
-			continue;
-		if (DIFF_PAIR_RENAME(p)) {
-			return 0; /* something else is renamed into this */
-		}
-	}
-	return 1;
-}
-
 /*
  * Find exact renames first.
  *
@@ -338,15 +320,25 @@ void diffcore_rename(struct diff_options *options)
 				locate_rename_dst(p->two, 1);
 		}
 		else if (!DIFF_FILE_VALID(p->two)) {
-			/* If the source is a broken "delete", and
+			/*
+			 * If the source is a broken "delete", and
 			 * they did not really want to get broken,
 			 * that means the source actually stays.
+			 * So we increment the "rename_used" score
+			 * by one, to indicate ourselves as a user
+			 */
+			if (p->broken_pair && !p->score)
+				p->one->rename_used++;
+			register_rename_src(p->one, p->score);
+		}
+		else if (detect_rename == DIFF_DETECT_COPY) {
+			/*
+			 * Increment the "rename_used" score by
+			 * one, to indicate ourselves as a user.
 			 */
-			int stays = (p->broken_pair && !p->score);
-			register_rename_src(p->one, stays, p->score);
+			p->one->rename_used++;
+			register_rename_src(p->one, p->score);
 		}
-		else if (detect_rename == DIFF_DETECT_COPY)
-			register_rename_src(p->one, 1, p->score);
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
 		goto cleanup; /* nothing to do */
@@ -472,16 +464,7 @@ void diffcore_rename(struct diff_options *options)
 					pair_to_free = p;
 			}
 			else {
-				for (j = 0; j < rename_dst_nr; j++) {
-					if (!rename_dst[j].pair)
-						continue;
-					if (strcmp(rename_dst[j].pair->
-						   one->path,
-						   p->one->path))
-						continue;
-					break;
-				}
-				if (j < rename_dst_nr)
+				if (p->one->rename_used)
 					/* this path remains */
 					pair_to_free = p;
 			}
@@ -507,23 +490,6 @@ void diffcore_rename(struct diff_options *options)
 	*q = outq;
 	diff_debug_queue("done collapsing", q);
 
-	/* We need to see which rename source really stays here;
-	 * earlier we only checked if the path is left in the result,
-	 * but even if a path remains in the result, if that is coming
-	 * from copying something else on top of it, then the original
-	 * source is lost and does not stay.
-	 */
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		if (DIFF_PAIR_RENAME(p) && p->source_stays) {
-			/* If one appears as the target of a rename-copy,
-			 * then mark p->source_stays = 0; otherwise
-			 * leave it as is.
-			 */
-			p->source_stays = compute_stays(q, p->one);
-		}
-	}
-
 	for (i = 0; i < rename_dst_nr; i++)
 		free_filespec(rename_dst[i].two);
 
diff --git a/diffcore.h b/diffcore.h
index 30055ac..cc96c20 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -31,6 +31,7 @@ struct diff_filespec {
 	unsigned long size;
 	int count;               /* Reference count */
 	int xfrm_flags;		 /* for use by the xfrm */
+	int rename_used;         /* Count of rename users */
 	unsigned short mode;	 /* file mode */
 	unsigned sha1_valid : 1; /* if true, use sha1 and trust mode;
 				  * if false, use the name and read from
@@ -58,7 +59,6 @@ struct diff_filepair {
 	struct diff_filespec *two;
 	unsigned short int score;
 	char status; /* M C R N D U (see Documentation/diff-format.txt) */
-	unsigned source_stays : 1; /* all of R/C are copies */
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
-- 
1.5.3.4.330.g1dec6
