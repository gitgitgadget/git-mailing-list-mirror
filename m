From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/12] xdiff-merge: optionally show conflicts in "diff3 -m"
 style
Date: Fri, 29 Aug 2008 17:42:33 -0700
Message-ID: <1220056963-2352-3-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZM-00073m-As
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbYH3Amy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbYH3Amy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:42:54 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbYH3Amw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:42:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 47C3A6DC04
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2545E6DC03 for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:50
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 93E488DC-762C-11DD-AABF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94342>

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
 builtin-merge-file.c  |   10 ++++-
 t/t6023-merge-file.sh |   37 +++++++++++++++++
 xdiff/xdiff.h         |    6 +++
 xdiff/xmerge.c        |  103 ++++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 135 insertions(+), 21 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 3605960..5b4f020 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -4,7 +4,7 @@
 #include "xdiff-interface.h"
 
 static const char merge_file_usage[] =
-"git merge-file [-p | --stdout] [-q | --quiet] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
+"git merge-file [-p | --stdout] [--diff3] [-q | --quiet] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
 
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
@@ -13,6 +13,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmbuffer_t result = {NULL, 0};
 	xpparam_t xpp = {XDF_NEED_MINIMAL};
 	int ret = 0, i = 0, to_stdout = 0;
+	int merge_level = XDL_MERGE_ZEALOUS_ALNUM;
+	int merge_style = 0;
 
 	while (argc > 4) {
 		if (!strcmp(argv[1], "-L") && i < 3) {
@@ -25,6 +27,10 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-q") ||
 				!strcmp(argv[1], "--quiet"))
 			freopen("/dev/null", "w", stderr);
+		else if (!strcmp(argv[1], "--diff3")) {
+			merge_style = XDL_MERGE_DIFF3;
+			merge_level = XDL_MERGE_EAGER;
+		}
 		else
 			usage(merge_file_usage);
 		argc--;
@@ -46,7 +52,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xpp, XDL_MERGE_ZEALOUS_ALNUM, &result);
+			&xpp, merge_level | merge_style, &result);
 
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 42620e0..f3484e3 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -161,4 +161,41 @@ test_expect_success 'ZEALOUS_ALNUM' '
 
 '
 
+cat >expect <<\EOF
+Dominus regit me,
+<<<<<<< new8.txt
+et nihil mihi deerit;
+
+
+
+
+In loco pascuae ibi me collocavit;
+super aquam refectionis educavit me.
+|||||||
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+=======
+et nihil mihi deerit,
+
+
+
+
+In loco pascuae ibi me collocavit --
+super aquam refectionis educavit me,
+>>>>>>> new9.txt
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam TU mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
+EOF
+
+test_expect_success '"diff3 -m" style output' '
+	test_must_fail git merge-file -p --diff3 \
+		new8.txt new5.txt new9.txt >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 413082e..deebe02 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -50,10 +50,16 @@ extern "C" {
 #define XDL_BDOP_CPY 2
 #define XDL_BDOP_INSB 3
 
+/* merge simplification levels */
 #define XDL_MERGE_MINIMAL 0
 #define XDL_MERGE_EAGER 1
 #define XDL_MERGE_ZEALOUS 2
 #define XDL_MERGE_ZEALOUS_ALNUM 3
+#define XDL_MERGE_LEVEL_MASK 0x0f
+
+/* merge output styles */
+#define XDL_MERGE_DIFF3 0x8000
+#define XDL_MERGE_STYLE_MASK 0x8000
 
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 6ffaa4f..29cdbea 100644
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
+			      int size, int i, int style,
 			      xdmerge_t *m, char *dest)
 {
 	const int marker_size = 7;
@@ -143,6 +172,20 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	/* Postimage from side #1 */
 	size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
 			      dest ? dest + size : NULL);
+
+	if (style == XDL_MERGE_DIFF3) {
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
+				 xdmerge_t *m, char *dest, int style)
 {
 	int size, i;
 
 	for (size = i = 0; m; m = m->next) {
 		if (m->mode == 0)
 			size = fill_conflict_hunk(xe1, name1, xe2, name2,
-						  size, i, m, dest);
+						  size, i, style, m, dest);
 		else if (m->mode == 1)
 			size += xdl_recs_copy(xe1, i, m->i1 + m->chg1 - i, 0,
 					      dest ? dest + size : NULL);
@@ -342,9 +386,11 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
  */
 static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 		xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
-		int level, xpparam_t const *xpp, mmbuffer_t *result) {
+		int flags, xpparam_t const *xpp, mmbuffer_t *result) {
 	xdmerge_t *changes, *c;
-	int i1, i2, chg1, chg2;
+	int i0, i1, i2, chg0, chg1, chg2;
+	int level = flags & XDL_MERGE_LEVEL_MASK;
+	int style = flags & XDL_MERGE_STYLE_MASK;
 
 	c = changes = NULL;
 
@@ -352,11 +398,14 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
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
@@ -364,11 +413,14 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
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
@@ -385,19 +437,26 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
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
 			if (ffo > 0)
 				chg2 += ffo;
-			else
+			else {
+				chg0 -= ffo;
 				chg1 -= ffo;
-			if (xdl_append_merge(&c, 0, i1, chg1, i2, chg2)) {
+			}
+			if (xdl_append_merge(&c, 0,
+					     i0, chg0, i1, chg1, i2, chg2)) {
 				xdl_cleanup_merge(changes);
 				return -1;
 			}
@@ -414,11 +473,14 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
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
@@ -427,11 +489,14 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
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
@@ -449,7 +514,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	/* output */
 	if (result) {
 		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
-			changes, NULL);
+			changes, NULL, style);
 		result->ptr = xdl_malloc(size);
 		if (!result->ptr) {
 			xdl_cleanup_merge(changes);
@@ -457,14 +522,14 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 		}
 		result->size = size;
 		xdl_fill_merge_buffer(xe1, name1, xe2, name2, changes,
-				result->ptr);
+				      result->ptr, style);
 	}
 	return xdl_cleanup_merge(changes);
 }
 
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xpparam_t const *xpp, int level, mmbuffer_t *result) {
+		xpparam_t const *xpp, int flags, mmbuffer_t *result) {
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
 	int status;
@@ -501,7 +566,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		} else {
 			status = xdl_do_merge(&xe1, xscr1, name1,
 					      &xe2, xscr2, name2,
-					      level, xpp, result);
+					      flags, xpp, result);
 		}
 		xdl_free_script(xscr1);
 		xdl_free_script(xscr2);
-- 
1.6.0.1.149.ga4c44
