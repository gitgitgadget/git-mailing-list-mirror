Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D361F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 09:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932736AbcIEJpr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 05:45:47 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59302 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932409AbcIEJpa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 05:45:30 -0400
X-AuditID: 12074414-c8fff70000000931-17-57cd3ea8eb50
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id AA.77.02353.8AE3DC75; Mon,  5 Sep 2016 05:45:13 -0400 (EDT)
Received: from bagpipes.fritz.box (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u859iwtS008788
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 05:45:10 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 5/8] xdl_change_compact(): introduce the concept of a change group
Date:   Mon,  5 Sep 2016 11:44:50 +0200
Message-Id: <21ade4ab233a868cabbe15598cd7b2ff4d04d286.1473068229.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsUixO6iqLvS7my4wfk+bYuuK91MFg29V5gt
        di/uZ7ZYcXUOs8WZrUDW7RXzmS1+tPQwW8y8am2xeXM7iwOnx9/3H5g8ds66y+6xYFOpx7Pe
        PYweFy8pe+xfuo3N4/MmOY/bz7axBHBEcdmkpOZklqUW6dslcGXc/zSDreBgSkVTQydrA+Np
        ry5GTg4JAROJeXP+sXUxcnEICWxllDh7bhkjSEJI4CSTxIq/eiA2m4CuxKKeZiYQW0RAXOLt
        8ZnsIA3MAn+ZJBY/ussGkhAWCJXY++U0WDOLgKrE+p1/wOK8AlESvx92sEFsk5O4tO0LM4jN
        KWAhseRLHzvEMnOJefOamScw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZopea
        UrqJERJ8IjsYj5yUO8QowMGoxMNroX0mXIg1say4MvcQoyQHk5Iob4Hq2XAhvqT8lMqMxOKM
        +KLSnNTiQ4wSHMxKIrw5tkA53pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkO
        DiUJ3vkgjYJFqempFWmZOSUIaSYOTpDhPEDDn4ENLy5IzC3OTIfIn2JUlBLnTbEBSgiAJDJK
        8+B6YcnhFaM40CvCvKLAVCHEA0wscN2vgAYzAQ1et/s0yOCSRISUVANj6fSrrste9EhtbL+7
        9MQFlccqz+pOPC5S6X34/riv17VnnhHzF5/e0nWP85WT2cJ7kUVbFqa/Wclh2WZpeoW/6gHP
        OqnTvBJqy2L2fVQorPy5V7phVpX9gxe9nf/OVV0JNZa4z5z3fbsu+7HPk0ujReS9uRNa7njw
        bgvzYJrYkfJowav1/+cwKrEUZyQaajEXFScCAGCXRqjpAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The idea of xdl_change_compact() is fairly simple:

* Proceed through groups of changed lines in the file to be compacted,
  keeping track of the corresponding location in the "other" file.

* If possible, slide the group up and down to try to give the most
  aesthetically pleasing diff. Whenever it is slid, the current location
  in the other file needs to be adjusted.

But these simple concepts are obfuscated by a lot of index handling that
is written in terse, subtle, and varied patterns. I found it very hard
to convince myself that the function was correct.

So introduce a "struct group" that represents a group of changed lines
in a file. Add some functions that perform elementary operations on
groups:

* Initialize a group to the first group in a file
* Move to the next or previous group in a file
* Slide a group up or down

Even though the resulting code is longer, I think it is easier to
understand and review. Its performance is not changed
appreciably (though it would be if `group_next()` and `group_previous()`
were not inlined).

...and in fact, the rewriting helped me discover another bug in the
--compaction-heuristic code: The update of blank_lines was never done
for the highest possible position of the group. This means that it could
fail to slide the group to its highest possible position, even if that
position had a blank line as its last line. So for example, it yielded
the following diff:

    $ git diff --no-index --compaction-heuristic a.txt b.txt
    diff --git a/a.txt b/b.txt
    index e53969f..0d60c5fe 100644
    --- a/a.txt
    +++ b/b.txt
    @@ -1,3 +1,7 @@
     1
     A
    +
    +B
    +
    +A
     2

when in fact the following diff is better (according to the rules of
--compaction-heuristic):

    $ git diff --no-index --compaction-heuristic a.txt b.txt
    diff --git a/a.txt b/b.txt
    index e53969f..0d60c5fe 100644
    --- a/a.txt
    +++ b/b.txt
    @@ -1,3 +1,7 @@
     1
    +A
    +
    +B
    +
     A
     2

The new code gives the bottom answer.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 293 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 203 insertions(+), 90 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 8a5832a..44fded6 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -413,126 +413,239 @@ static int recs_match(xrecord_t *rec1, xrecord_t *rec2, long flags)
 			     flags));
 }
 
-int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
-	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
-	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
-	unsigned int blank_lines;
-	xrecord_t **recs = xdf->recs;
+/*
+ * Represent a group of changed lines in an xdfile_t (i.e., a contiguous group
+ * of lines that was inserted or deleted from the corresponding version of the
+ * file). We consider there to be such a group at the beginning of the file, at
+ * the end of the file, and between any two unchanged lines, though most such
+ * groups will usually be empty.
+ *
+ * If the first line in a group is equal to the line following the group, then
+ * the group can be slid down. Similarly, if the last line in a group is equal
+ * to the line preceding the group, then the group can be slid up. See
+ * group_slide_down() and group_slide_up().
+ *
+ * Note that loops that are testing for changed lines in xdf->rchg do not need
+ * index bounding since the array is prepared with a zero at position -1 and N.
+ */
+struct group {
+	/*
+	 * The index of the first changed line in the group, or the index of
+	 * the unchanged line above which the (empty) group is located.
+	 */
+	long start;
 
 	/*
-	 * This is the same of what GNU diff does. Move back and forward
-	 * change groups for a consistent and pretty diff output. This also
-	 * helps in finding joinable change groups and reduce the diff size.
+	 * The index of the first unchanged line after the group. For an empty
+	 * group, end is equal to start.
 	 */
-	for (ix = ixo = 0;;) {
-		/*
-		 * Find the first changed line in the to-be-compacted file.
-		 * We need to keep track of both indexes, so if we find a
-		 * changed lines group on the other file, while scanning the
-		 * to-be-compacted file, we need to skip it properly. Note
-		 * that loops that are testing for changed lines on rchg* do
-		 * not need index bounding since the array is prepared with
-		 * a zero at position -1 and N.
-		 */
-		for (; ix < nrec && !rchg[ix]; ix++)
-			while (rchgo[ixo++]);
-		if (ix == nrec)
-			break;
+	long end;
+};
+
+/*
+ * Initialize g to point at the first group in xdf.
+ */
+static void group_init(xdfile_t *xdf, struct group *g)
+{
+	g->start = g->end = 0;
+	while (xdf->rchg[g->end])
+		g->end++;
+}
+
+/*
+ * Move g to describe the next (possibly empty) group in xdf and return 0. If g
+ * is already at the end of the file, do nothing and return -1.
+ */
+static inline int group_next(xdfile_t *xdf, struct group *g)
+{
+	if (g->end == xdf->nrec)
+		return -1;
+
+	g->start = g->end + 1;
+	for (g->end = g->start; xdf->rchg[g->end]; g->end++)
+		;
+
+	return 0;
+}
+
+/*
+ * Move g to describe the previous (possibly empty) group in xdf and return 0.
+ * If g is already at the beginning of the file, do nothing and return -1.
+ */
+static inline int group_previous(xdfile_t *xdf, struct group *g)
+{
+	if (g->start == 0)
+		return -1;
+
+	g->end = g->start - 1;
+	for (g->start = g->end; xdf->rchg[g->start - 1]; g->start--)
+		;
+
+	return 0;
+}
+
+/*
+ * If g can be slid toward the end of the file, do so, and if it bumps into a
+ * following group, expand this group to include it. Return 0 on success or -1
+ * if g cannot be slid down.
+ */
+static int group_slide_down(xdfile_t *xdf, struct group *g, long flags)
+{
+	if (g->end < xdf->nrec &&
+	    recs_match(xdf->recs[g->start], xdf->recs[g->end], flags)) {
+		xdf->rchg[g->start++] = 0;
+		xdf->rchg[g->end++] = 1;
+
+		while (xdf->rchg[g->end])
+			g->end++;
+
+		return 0;
+	} else {
+		return -1;
+	}
+}
+
+/*
+ * If g can be slid toward the beginning of the file, do so, and if it bumps
+ * into a previous group, expand this group to include it. Return 0 on success
+ * or -1 if g cannot be slid up.
+ */
+static int group_slide_up(xdfile_t *xdf, struct group *g, long flags)
+{
+	if (g->start > 0 &&
+	    recs_match(xdf->recs[g->start - 1], xdf->recs[g->end - 1], flags)) {
+		xdf->rchg[--g->start] = 1;
+		xdf->rchg[--g->end] = 0;
+
+		while (xdf->rchg[g->start - 1])
+			g->start--;
+
+		return 0;
+	} else {
+		return -1;
+	}
+}
+
+static void xdl_bug(const char *msg)
+{
+	fprintf(stderr, "BUG: %s\n", msg);
+	exit(1);
+}
+
+/*
+ * Move back and forward change groups for a consistent and pretty diff output.
+ * This also helps in finding joinable change groups and reducing the diff
+ * size.
+ */
+int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
+	struct group g, go;
+	long earliest_end, end_matching_other;
+	long groupsize;
+	unsigned int blank_lines;
+
+	group_init(xdf, &g);
+	group_init(xdfo, &go);
+
+	while (1) {
+		/* If the group is empty in the to-be-compacted file, skip it: */
+		if (g.end == g.start)
+			goto next;
 
 		/*
-		 * Record the start of a changed-group in the to-be-compacted file
-		 * and find the end of it, on both to-be-compacted and other file
-		 * indexes (ix and ixo).
+		 * Now shift the change up and then down as far as possible in
+		 * each direction. If it bumps into any other changes, merge them.
 		 */
-		ixs = ix;
-		for (ix++; rchg[ix]; ix++);
-		for (; rchgo[ixo]; ixo++);
-
 		do {
-			grpsiz = ix - ixs;
-			blank_lines = 0;
+			groupsize = g.end - g.start;
 
 			/*
-			 * If the line before the current change group, is equal to
-			 * the last line of the current change group, shift backward
-			 * the group.
+			 * Keep track of the last "end" index that causes this
+			 * group to align with a group of changed lines in the
+			 * other file. -1 indicates that we haven't found such
+			 * a match yet:
 			 */
-			while (ixs > 0 && recs_match(recs[ixs - 1], recs[ix - 1], flags)) {
-				rchg[--ixs] = 1;
-				rchg[--ix] = 0;
-
-				/*
-				 * This change might have joined two change groups,
-				 * so we try to take this scenario in account by moving
-				 * the start index accordingly (and so the other-file
-				 * end-of-group index).
-				 */
-				for (; rchg[ixs - 1]; ixs--);
-				while (rchgo[--ixo]);
-			}
+			end_matching_other = -1;
 
 			/*
-			 * Record the end-of-group position in case we are matched
-			 * with a group of changes in the other file (that is, the
-			 * change record before the end-of-group index in the other
-			 * file is set).
+			 * Boolean value that records whether there are any blank
+			 * lines that could be made to be the last line of this
+			 * group.
 			 */
-			ixref = rchgo[ixo - 1] ? ix: nrec;
+			blank_lines = 0;
+
+			/* Shift the group backward as much as possible: */
+			while (!group_slide_up(xdf, &g, flags))
+				if (group_previous(xdfo, &go))
+					xdl_bug("group sync broken sliding up");
 
 			/*
-			 * If the first line of the current change group, is equal to
-			 * the line next of the current change group, shift forward
-			 * the group.
+			 * This is this highest that this group can be shifted.
+			 * Record its end index:
 			 */
-			while (ix < nrec && recs_match(recs[ixs], recs[ix], flags)) {
-				blank_lines += is_blank_line(recs[ix], flags);
-
-				rchg[ixs++] = 0;
-				rchg[ix++] = 1;
-
-				/*
-				 * This change might have joined two change groups,
-				 * so we try to take this scenario in account by moving
-				 * the start index accordingly (and so the other-file
-				 * end-of-group index). Keep tracking the reference
-				 * index in case we are shifting together with a
-				 * corresponding group of changes in the other file.
-				 */
-				for (; rchg[ix]; ix++);
-				while (rchgo[++ixo])
-					ixref = ix;
+			earliest_end = g.end;
+
+			if (go.end > go.start)
+				end_matching_other = g.end;
+
+			/* Now shift the group forward as far as possible: */
+			while (1) {
+				if (!blank_lines)
+					blank_lines = is_blank_line(
+							xdf->recs[g.end - 1],
+							flags);
+
+				if (group_slide_down(xdf, &g, flags))
+					break;
+				if (group_next(xdfo, &go))
+					xdl_bug("group sync broken sliding down");
+
+				if (go.end > go.start)
+					end_matching_other = g.end;
 			}
-		} while (grpsiz != ix - ixs);
+		} while (groupsize != g.end - g.start);
 
-		if (ixref < ix) {
+		if (g.end == earliest_end) {
+			/* no shifting was possible */
+		} else if (end_matching_other != -1) {
 			/*
-			 * Try to move back the possibly merged group of changes, to match
-			 * the recorded position in the other file.
+			 * Move the possibly merged group of changes back to line
+			 * up with the last group of changes from the other file
+			 * that it can align with.
 			 */
-			while (ixref < ix) {
-				rchg[--ixs] = 1;
-				rchg[--ix] = 0;
-				while (rchgo[--ixo]);
+			while (go.end == go.start) {
+				if (group_slide_up(xdf, &g, flags))
+					xdl_bug("match disappeared");
+				if (group_previous(xdfo, &go))
+					xdl_bug("group sync broken sliding to match");
 			}
 		} else if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
 			/*
-			 * The group can be slid up to make its last line a
-			 * blank line. Do so.
+			 * Compaction heuristic: if it is possible to shift the
+			 * group to make its bottom line a blank line, do so.
 			 *
 			 * As we already shifted the group forward as far as
-			 * possible in the earlier loop, we need to shift it
-			 * back only if at all.
+			 * possible in the earlier loop, we only need to handle
+			 * backward shifts, not forward ones.
 			 */
-			while (ixs > 0 &&
-			       !is_blank_line(recs[ix - 1], flags) &&
-			       recs_match(recs[ixs - 1], recs[ix - 1], flags)) {
-				rchg[--ixs] = 1;
-				rchg[--ix] = 0;
-				while (rchgo[--ixo]);
+			while (!is_blank_line(xdf->recs[g.end - 1], flags)) {
+				if (group_slide_up(xdf, &g, flags))
+					xdl_bug("blank line disappeared");
+				if (group_previous(xdfo, &go))
+					xdl_bug("group sync broken sliding to blank line");
 			}
 		}
+
+	next:
+		/* Move past the just-processed group: */
+		if (group_next(xdf, &g))
+			break;
+		if (group_next(xdfo, &go))
+			xdl_bug("group sync broken moving to next group");
 	}
 
+	if (!group_next(xdfo, &go))
+		xdl_bug("group sync broken at end of file");
+
 	return 0;
 }
 
-- 
2.9.3

