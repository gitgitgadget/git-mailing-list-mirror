From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Tweak count-delta interface
Date: Fri, 03 Jun 2005 01:36:03 -0700
Message-ID: <7vekbjq1l8.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
	<7vmzqau3es.fsf@assigned-by-dhcp.cox.net>
	<7vll5sz54z.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506021716140.1876@ppc970.osdl.org>
	<7vis0wusv5.fsf@assigned-by-dhcp.cox.net>
	<7vis0vq1rz.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:35:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De7dK-0007Zq-2a
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 10:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVFCIhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 04:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFCIhV
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 04:37:21 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:62932 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261182AbVFCIgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 04:36:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603083603.PGNY23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 04:36:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis0vq1rz.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 03 Jun 2005 01:32:00 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make it return copied source and insertion separately, so that
later implementation of heuristics can use them more flexibly.

This does not change the heuristics implemented in
diffcore-rename nor diffcore-break in any way.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 count-delta.h     |    3 ++-
 diffcore.h        |    2 --
 count-delta.c     |   30 ++++++++++++++++--------------
 diffcore-break.c  |   15 +++++++++++----
 diffcore-rename.c |   15 +++++++++++----
 5 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/count-delta.h b/count-delta.h
--- a/count-delta.h
+++ b/count-delta.h
@@ -4,6 +4,7 @@
 #ifndef COUNT_DELTA_H
 #define COUNT_DELTA_H
 
-unsigned long count_delta(void *, unsigned long);
+int count_delta(void *, unsigned long,
+		unsigned long *src_copied, unsigned long *literal_added);
 
 #endif
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -12,8 +12,6 @@
 #define DEFAULT_RENAME_SCORE 30000 /* rename/copy similarity minimum (50%) */
 #define DEFAULT_BREAK_SCORE  59400 /* minimum for break to happen (99%)*/
 
-#define RENAME_DST_MATCHED 01
-
 struct diff_filespec {
 	unsigned char sha1[20];
 	char *path;
diff --git a/count-delta.c b/count-delta.c
--- a/count-delta.c
+++ b/count-delta.c
@@ -29,15 +29,18 @@ static unsigned long get_hdr_size(const 
 /*
  * NOTE.  We do not _interpret_ delta fully.  As an approximation, we
  * just count the number of bytes that are copied from the source, and
- * the number of literal data bytes that are inserted.  Number of
- * bytes that are _not_ copied from the source is deletion, and number
- * of inserted literal bytes are addition, so sum of them is what we
- * return.  xdelta can express an edit that copies data inside of the
- * destination which originally came from the source.  We do not count
- * that in the following routine, so we are undercounting the source
- * material that remains in the final output that way.
+ * the number of literal data bytes that are inserted.
+ *
+ * Number of bytes that are _not_ copied from the source is deletion,
+ * and number of inserted literal bytes are addition, so sum of them
+ * is the extent of damage.  xdelta can express an edit that copies
+ * data inside of the destination which originally came from the
+ * source.  We do not count that in the following routine, so we are
+ * undercounting the source material that remains in the final output
+ * that way.
  */
-unsigned long count_delta(void *delta_buf, unsigned long delta_size)
+int count_delta(void *delta_buf, unsigned long delta_size,
+		unsigned long *src_copied, unsigned long *literal_added)
 {
 	unsigned long copied_from_source, added_literal;
 	const unsigned char *data, *top;
@@ -46,7 +49,7 @@ unsigned long count_delta(void *delta_bu
 
 	/* the smallest delta size possible is 6 bytes */
 	if (delta_size < 6)
-		return UINT_MAX;
+		return -1;
 
 	data = delta_buf;
 	top = delta_buf + delta_size;
@@ -83,13 +86,12 @@ unsigned long count_delta(void *delta_bu
 
 	/* sanity check */
 	if (data != top || out != dst_size)
-		return UINT_MAX;
+		return -1;
 
 	/* delete size is what was _not_ copied from source.
 	 * edit size is that and literal additions.
 	 */
-	if (src_size + added_literal < copied_from_source)
-		/* we ended up overcounting and underflowed */
-		return 0;
-	return (src_size - copied_from_source) + added_literal;
+	*src_copied = copied_from_source;
+	*literal_added = added_literal;
+	return 0;
 }
diff --git a/diffcore-break.c b/diffcore-break.c
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -23,7 +23,7 @@ static int very_different(struct diff_fi
 	 * want to get the filepair broken.
 	 */
 	void *delta;
-	unsigned long delta_size, base_size;
+	unsigned long delta_size, base_size, src_copied, literal_added;
 
 	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
 		return 0; /* leave symlink rename alone */
@@ -61,10 +61,17 @@ static int very_different(struct diff_fi
 		return MAX_SCORE;
 
 	/* Estimate the edit size by interpreting delta. */
-	delta_size = count_delta(delta, delta_size);
+	if (count_delta(delta, delta_size, &src_copied, &literal_added)) {
+		free(delta);
+		return 0;
+	}
 	free(delta);
-	if (delta_size == UINT_MAX)
-		return 0; /* error in delta computation */
+
+	/* Extent of damage */
+	if (src->size + literal_added < src_copied)
+		delta_size = 0;
+	else
+		delta_size = (src->size - src_copied) + literal_added;
 
 	if (base_size < delta_size)
 		return MAX_SCORE;
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -135,7 +135,7 @@ static int estimate_similarity(struct di
 	 * call into this function in that case.
 	 */
 	void *delta;
-	unsigned long delta_size, base_size;
+	unsigned long delta_size, base_size, src_copied, literal_added;
 	int score;
 
 	/* We deal only with regular files.  Symlink renames are handled
@@ -174,10 +174,17 @@ static int estimate_similarity(struct di
 		return 0;
 
 	/* Estimate the edit size by interpreting delta. */
-	delta_size = count_delta(delta, delta_size);
-	free(delta);
-	if (delta_size == UINT_MAX)
+	if (count_delta(delta, delta_size, &src_copied, &literal_added)) {
+		free(delta);
 		return 0;
+	}
+	free(delta);
+
+	/* Extent of damage */
+	if (src->size + literal_added < src_copied)
+		delta_size = 0;
+	else
+		delta_size = (src->size - src_copied) + literal_added;
 
 	/*
 	 * Now we will give some score to it.  100% edit gets 0 points
------------

