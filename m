From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2 - RFH/WIP] xdiff-merge: optionally show conflicts in
 "diff3 -m" style
Date: Thu, 28 Aug 2008 17:18:18 -0700
Message-ID: <7vsksobrn9.fsf@gitster.siamese.dyndns.org>
References: <7vzlmwbs1u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYriV-0007fV-O7
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbYH2AS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbYH2AS1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:18:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779AbYH2ASZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:18:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EDAB2555CD;
	Thu, 28 Aug 2008 20:18:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 508B7555C9; Thu, 28 Aug 2008 20:18:21 -0400 (EDT)
In-Reply-To: <7vzlmwbs1u.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 28 Aug 2008 17:09:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FEE30708-755F-11DD-85AD-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94233>

When showing conflicting merges, we traditionally followed RCS's merge
output format.  The output shows:

 <<<<<<<
 postimage from one side;
 =======
 postimage of the other side; and
 >>>>>>>

Some poeple find it easier to be able to understand what is going on when
they can view the common ancestor's version, which is used by "diff3 -m",
which shows:

 <<<<<<<
 postimage from one side;
 |||||||
 shared preimage;
 =======
 postimage of the other side; and
 >>>>>>>

This is an initial step to bring that as an optional feature to git.
Only "git merge-file" has been converted, with "--diff3" option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is RFH/WIP partly because I tested it only on simplest cases, but
   more importantly I suspect this should be orthogonal to the refinement
   level parameter.

   The idea is to keep (just like <i1,chg1>, <i2,chg2> you use to point at
   the postimage of both sides) <i0,chg0> in xdmerge_t that point at the
   corresponding part of the shared preimage.  I think I got the initial
   computation of <i0,chg0>, coalescing done in xdl_append_merge(), and
   use of that in xdl_fill_merge_buffer() right, but I couldn't figure out
   how to adjust them inside the merge refinement logic.

   Of course the eventual goal is to add this to merge-file.c, give a new
   configuration variable to allow people to use this, while teaching
   rerere to ignore the new '|||||||' + shared preimage section, so that
   existing rerere information can be reused for new conflicts in
   diff3 style output.

 builtin-merge-file.c |    6 ++-
 xdiff/xdiff.h        |    5 +-
 xdiff/xmerge.c       |  145 ++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 119 insertions(+), 37 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 3605960..2f69aa1 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -13,6 +13,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmbuffer_t result = {NULL, 0};
 	xpparam_t xpp = {XDF_NEED_MINIMAL};
 	int ret = 0, i = 0, to_stdout = 0;
+	int level = XDL_MERGE_ZEALOUS_ALNUM;
 
 	while (argc > 4) {
 		if (!strcmp(argv[1], "-L") && i < 3) {
@@ -25,6 +26,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-q") ||
 				!strcmp(argv[1], "--quiet"))
 			freopen("/dev/null", "w", stderr);
+		else if (!strcmp(argv[1], "-3") ||
+			 !strcmp(argv[1], "--diff3"))
+			level = XDL_MERGE_DIFF3;
 		else
 			usage(merge_file_usage);
 		argc--;
@@ -46,7 +50,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xpp, XDL_MERGE_ZEALOUS_ALNUM, &result);
+			&xpp, level, &result);
 
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 413082e..a7b6e08 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -52,8 +52,9 @@ extern "C" {
 
 #define XDL_MERGE_MINIMAL 0
 #define XDL_MERGE_EAGER 1
-#define XDL_MERGE_ZEALOUS 2
-#define XDL_MERGE_ZEALOUS_ALNUM 3
+#define XDL_MERGE_DIFF3 2
+#define XDL_MERGE_ZEALOUS 10
+#define XDL_MERGE_ZEALOUS_ALNUM 11
 
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 6ffaa4f..ac6cc40 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -30,17 +30,32 @@ typedef struct s_xdmerge {
 	 * 2 = no conflict, take second.
 	 */
 	int mode;
+	/*
+	 * These point at the respective postimages.  E.g. <i1,chg1> is
+	 * how side #1 wants to change the common ancestor; if there is no
+	 * overlap, lines before i1 in the postimage of side #1 appear
+	 * in the merge result as a region touched by neither side.
+	 */
 	long i1, i2;
 	long chg1, chg2;
+	/*
+	 * These point at the preimage; of course there is just one
+	 * preimage, that is from the shared common ancestor.
+	 */
+	long i0;
+	long chg0;
 } xdmerge_t;
 
 static int xdl_append_merge(xdmerge_t **merge, int mode,
-		long i1, long chg1, long i2, long chg2)
+			    long i0, long chg0,
+			    long i1, long chg1,
+			    long i2, long chg2)
 {
 	xdmerge_t *m = *merge;
 	if (m && (i1 <= m->i1 + m->chg1 || i2 <= m->i2 + m->chg2)) {
 		if (mode != m->mode)
 			m->mode = 0;
+		m->chg0 = i0 + chg0 - m->i0;
 		m->chg1 = i1 + chg1 - m->i1;
 		m->chg2 = i2 + chg2 - m->i2;
 	} else {
@@ -49,6 +64,8 @@ static int xdl_append_merge(xdmerge_t **merge, int mode,
 			return -1;
 		m->next = NULL;
 		m->mode = mode;
+		m->i0 = i0;
+		m->chg0 = chg0;
 		m->i1 = i1;
 		m->chg1 = chg1;
 		m->i2 = i2;
@@ -91,11 +108,13 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 	return 0;
 }
 
-static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
+static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 {
-	xrecord_t **recs = xe->xdf2.recs + i;
+	xrecord_t **recs;
 	int size = 0;
 
+	recs = (use_orig ? xe->xdf1.recs : xe->xdf2.recs) + i;
+
 	if (count < 1)
 		return 0;
 
@@ -113,9 +132,19 @@ static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 	return size;
 }
 
+static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
+{
+	return xdl_recs_copy_0(0, xe, i, count, add_nl, dest);
+}
+
+static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
+{
+	return xdl_recs_copy_0(1, xe, i, count, add_nl, dest);
+}
+
 static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      xdfenv_t *xe2, const char *name2,
-			      int size, int i,
+			      int size, int i, int level,
 			      xdmerge_t *m, char *dest)
 {
 	const int marker_size = 7;
@@ -143,6 +172,20 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	/* Postimage from side #1 */
 	size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
 			      dest ? dest + size : NULL);
+
+	if (level == XDL_MERGE_DIFF3) {
+		/* Shared preimage */
+		if (!dest) {
+			size += marker_size + 1;
+		} else {
+			for (j = 0; j < marker_size; j++)
+				dest[size++] = '|';
+			dest[size++] = '\n';
+		}
+		size += xdl_orig_copy(xe1, m->i0, m->chg0, 1,
+				      dest ? dest + size : NULL);
+	}
+
 	if (!dest) {
 		size += marker_size + 1;
 	} else {
@@ -170,14 +213,15 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 }
 
 static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
-		xdfenv_t *xe2, const char *name2, xdmerge_t *m, char *dest)
+				 xdfenv_t *xe2, const char *name2,
+				 xdmerge_t *m, char *dest, int level)
 {
 	int size, i;
 
 	for (size = i = 0; m; m = m->next) {
 		if (m->mode == 0)
 			size = fill_conflict_hunk(xe1, name1, xe2, name2,
-						  size, i, m, dest);
+						  size, i, level, m, dest);
 		else if (m->mode == 1)
 			size += xdl_recs_copy(xe1, i, m->i1 + m->chg1 - i, 0,
 					      dest ? dest + size : NULL);
@@ -332,19 +376,31 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
 }
 
 /*
- * level == 0: mark all overlapping changes as conflict
- * level == 1: mark overlapping changes as conflict only if not identical
- * level == 2: analyze non-identical changes for minimal conflict set
- * level == 3: analyze non-identical changes for minimal conflict set, but
- *             treat hunks not containing any letter or number as conflicting
+ * "Level" parameter can be:
+ *
+ * (MINIMAL):
+ * Mark all overlapping changes as conflict
+ *
+ * (EAGER):
+ * Mark overlapping changes as conflict only if not identical
+ *
+ * (DIFF3):
+ * Same as EAGER but show the shared preimage in the output as well
+ *
+ * (ZEALOUS):
+ * Analyze non-identical changes for minimal conflict set
+ *
+ * (ZEALOUS_ALNUM):
+ * Analyze non-identical changes for minimal conflict set, but
+ * treat hunks not containing any letter or number as conflicting
  *
  * returns < 0 on error, == 0 for no conflicts, else number of conflicts
  */
 static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
-		xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
-		int level, xpparam_t const *xpp, mmbuffer_t *result) {
+			xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
+			int level, xpparam_t const *xpp, mmbuffer_t *result) {
 	xdmerge_t *changes, *c;
-	int i1, i2, chg1, chg2;
+	int i0, i1, i2, chg0, chg1, chg2;
 
 	c = changes = NULL;
 
@@ -352,11 +408,14 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 		if (!changes)
 			changes = c;
 		if (xscr1->i1 + xscr1->chg1 < xscr2->i1) {
+			i0 = xscr1->i1;
 			i1 = xscr1->i2;
 			i2 = xscr2->i2 - xscr2->i1 + xscr1->i1;
+			chg0 = xscr1->chg1;
 			chg1 = xscr1->chg2;
 			chg2 = xscr1->chg1;
-			if (xdl_append_merge(&c, 1, i1, chg1, i2, chg2)) {
+			if (xdl_append_merge(&c, 1,
+					     i0, chg0, i1, chg1, i2, chg2)) {
 				xdl_cleanup_merge(changes);
 				return -1;
 			}
@@ -364,40 +423,50 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 			continue;
 		}
 		if (xscr2->i1 + xscr2->chg1 < xscr1->i1) {
+			i0 = xscr2->i1;
 			i1 = xscr1->i2 - xscr1->i1 + xscr2->i1;
 			i2 = xscr2->i2;
+			chg0 = xscr2->chg1;
 			chg1 = xscr2->chg1;
 			chg2 = xscr2->chg2;
-			if (xdl_append_merge(&c, 2, i1, chg1, i2, chg2)) {
+			if (xdl_append_merge(&c, 2,
+					     i0, chg0, i1, chg1, i2, chg2)) {
 				xdl_cleanup_merge(changes);
 				return -1;
 			}
 			xscr2 = xscr2->next;
 			continue;
 		}
-		if (level < 1 || xscr1->i1 != xscr2->i1 ||
-				xscr1->chg1 != xscr2->chg1 ||
-				xscr1->chg2 != xscr2->chg2 ||
-				xdl_merge_cmp_lines(xe1, xscr1->i2,
+		if (level == XDL_MERGE_MINIMAL ||
+		    (xscr1->i1 != xscr2->i1 ||
+		     xscr1->chg1 != xscr2->chg1 ||
+		     xscr1->chg2 != xscr2->chg2) ||
+		    xdl_merge_cmp_lines(xe1, xscr1->i2,
 					xe2, xscr2->i2,
 					xscr1->chg2, xpp->flags)) {
 			/* conflict */
 			int off = xscr1->i1 - xscr2->i1;
 			int ffo = off + xscr1->chg1 - xscr2->chg1;
 
+			i0 = xscr1->i1;
 			i1 = xscr1->i2;
 			i2 = xscr2->i2;
-			if (off > 0)
+			if (off > 0) {
+				i0 -= off;
 				i1 -= off;
+			}
 			else
 				i2 += off;
+			chg0 = xscr1->i1 + xscr1->chg1 - i0;
 			chg1 = xscr1->i2 + xscr1->chg2 - i1;
 			chg2 = xscr2->i2 + xscr2->chg2 - i2;
-			if (ffo > 0)
-				chg2 += ffo;
-			else
+			if (ffo < 0) {
+				chg0 -= ffo;
 				chg1 -= ffo;
-			if (xdl_append_merge(&c, 0, i1, chg1, i2, chg2)) {
+			} else
+				chg2 += ffo;
+			if (xdl_append_merge(&c, 0,
+					     i0, chg0, i1, chg1, i2, chg2)) {
 				xdl_cleanup_merge(changes);
 				return -1;
 			}
@@ -414,11 +483,14 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	while (xscr1) {
 		if (!changes)
 			changes = c;
+		i0 = xscr1->i1;
 		i1 = xscr1->i2;
 		i2 = xscr1->i1 + xe2->xdf2.nrec - xe2->xdf1.nrec;
+		chg0 = xscr1->chg1;
 		chg1 = xscr1->chg2;
 		chg2 = xscr1->chg1;
-		if (xdl_append_merge(&c, 1, i1, chg1, i2, chg2)) {
+		if (xdl_append_merge(&c, 1,
+				     i0, chg0, i1, chg1, i2, chg2)) {
 			xdl_cleanup_merge(changes);
 			return -1;
 		}
@@ -427,11 +499,14 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	while (xscr2) {
 		if (!changes)
 			changes = c;
+		i0 = xscr2->i1;
 		i1 = xscr2->i1 + xe1->xdf2.nrec - xe1->xdf1.nrec;
 		i2 = xscr2->i2;
+		chg0 = xscr2->chg1;
 		chg1 = xscr2->chg1;
 		chg2 = xscr2->chg2;
-		if (xdl_append_merge(&c, 2, i1, chg1, i2, chg2)) {
+		if (xdl_append_merge(&c, 2,
+				     i0, chg0, i1, chg1, i2, chg2)) {
 			xdl_cleanup_merge(changes);
 			return -1;
 		}
@@ -440,16 +515,17 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	if (!changes)
 		changes = c;
 	/* refine conflicts */
-	if (level > 1 &&
+	if (XDL_MERGE_ZEALOUS <= level &&
 	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
-	     xdl_simplify_non_conflicts(xe1, changes, level > 2) < 0)) {
+	     xdl_simplify_non_conflicts(xe1, changes,
+					level > XDL_MERGE_ZEALOUS) < 0)) {
 		xdl_cleanup_merge(changes);
 		return -1;
 	}
 	/* output */
 	if (result) {
 		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
-			changes, NULL);
+						 changes, NULL, level);
 		result->ptr = xdl_malloc(size);
 		if (!result->ptr) {
 			xdl_cleanup_merge(changes);
@@ -457,14 +533,15 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 		}
 		result->size = size;
 		xdl_fill_merge_buffer(xe1, name1, xe2, name2, changes,
-				result->ptr);
+				      result->ptr, level);
 	}
 	return xdl_cleanup_merge(changes);
 }
 
-int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
-		mmfile_t *mf2, const char *name2,
-		xpparam_t const *xpp, int level, mmbuffer_t *result) {
+int xdl_merge(mmfile_t *orig,
+	      mmfile_t *mf1, const char *name1,
+	      mmfile_t *mf2, const char *name2,
+	      xpparam_t const *xpp, int level, mmbuffer_t *result) {
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
 	int status;
-- 
1.6.0.1.200.ge682f
