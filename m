From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v5 3/4] [RFC] Only show bulkmoves in output.
Date: Sat,  9 Oct 2010 23:31:34 +0200
Message-ID: <1286659895-1813-4-git-send-email-ydirson@altern.org>
References: <1286659895-1813-1-git-send-email-ydirson@altern.org>
 <1286659895-1813-2-git-send-email-ydirson@altern.org>
 <1286659895-1813-3-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 23:21:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4grD-0007q4-Bz
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 23:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136Ab0JIVV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 17:21:27 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:50699 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755841Ab0JIVVT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 17:21:19 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 78310D4802D;
	Sat,  9 Oct 2010 23:21:13 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P4h0z-0000Tz-Rr; Sat, 09 Oct 2010 23:31:37 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286659895-1813-3-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158627>

In theory we could just append those at display time (possibly diluting
the code too much ?), or before queing the diff.  In practice we cannot
do the latter easily in either case (strcat to a constant string ("./"),
nor to the paths tighly-allocated from alloc_filespec).

So I went the way of including the trailing "*" from the beginning.
Since I'm still unsure whether keeping it that way, I leave it as a
separated patch for now.

After this patch only one of the expected failures can be considered
innocuous.
---
 diffcore-rename.c                |   22 +++++++++++++++-------
 t/t4046-diff-rename-factorize.sh |   22 +++++++++++-----------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 18a0605..6d21792 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -588,6 +588,13 @@ static void check_one_bulk_move(struct diff_filepair *dstpair)
 	copy_dirname(one_parent_path, dstpair->one->path);
 	copy_dirname(two_parent_path, dstpair->two->path);
 
+	/* Visualize toplevel dir if needed.  Need it here because of
+	 * "*" handling below. */
+	if (!*one_parent_path)
+		strcpy(one_parent_path, "./");
+	if (!*two_parent_path)
+		strcpy(two_parent_path, "./");
+
 	/* simple rename with no directory change */
 	if (!strcmp(one_parent_path, two_parent_path))
 		return;
@@ -600,11 +607,16 @@ static void check_one_bulk_move(struct diff_filepair *dstpair)
 	    maybe_disqualify_bulkmove(one_parent_path, one_leftover))
 		return;
 
+	/* For output format reason we want this "*" for the general
+	 * case of bulk moves.  Most be here for alloc_filespec to
+	 * reserve enough space, and to allow for proper comparison
+	 * with those previously recorded in bulkmove_candidates. */
+	strcat(one_parent_path, "*");
+
 	/* already considered ? */
 	for (seen=bulkmove_candidates; seen; seen = seen->next)
 		if (!strcmp(seen->one->path, one_parent_path)) break;
-	if (!seen) {
-		/* record potential dir rename */
+	if (!seen) { /* record potential dir rename */
 		seen = xmalloc(sizeof(*seen));
 		seen->one = alloc_filespec(one_parent_path);
 		fill_filespec(seen->one, null_sha1 /*FIXME*/, S_IFDIR);
@@ -822,11 +834,7 @@ void diffcore_rename(struct diff_options *options)
 	for (candidate=bulkmove_candidates; candidate; candidate = candidate->next) {
 		struct diff_filepair* pair;
 		if (candidate->discarded) continue;
-		/* visualize toplevel dir if needed */ //FIXME: wrong place for this ?
-		if (!*candidate->one->path)
-			candidate->one->path = "./";
-		if (!*candidate->two->path)
-			candidate->two->path = "./";
+
 		pair = diff_queue(&outq, candidate->one, candidate->two);
 		pair->score = MAX_SCORE;
 		pair->renamed_pair = 1;
diff --git a/t/t4046-diff-rename-factorize.sh b/t/t4046-diff-rename-factorize.sh
index d063e25..9353929 100755
--- a/t/t4046-diff-rename-factorize.sh
+++ b/t/t4046-diff-rename-factorize.sh
@@ -37,7 +37,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'diff-index --detect-bulk-moves after directory move.' '
 	cat >expected <<-EOF &&
-	:040000 040000 X X R#	a/	b/
+	:040000 040000 X X R#	a/*	b/
 	:100644 100644 X X R#	a/path0	b/path0
 	:100644 100644 X X R#	a/path1	b/path1
 	:100644 100644 X X R#	a/path2	b/path2
@@ -58,7 +58,7 @@ test_expect_success 'setup non-100% rename' '
 
 test_expect_success 'diff-index --detect-bulk-moves after content changes.' '
 	cat >expected <<-EOF &&
-	:040000 040000 X X R#	a/	b/
+	:040000 040000 X X R#	a/*	b/
 	:100644 000000 X X D#	a/path3
 	:100644 100644 X X R#	a/path2	b/2path
 	:100644 100644 X X R#	a/path0	b/path0
@@ -87,7 +87,7 @@ test_expect_success 'setup bulk move that is not directory move' '
 	git update-index --add --remove a/* c/apath0 c/apath1 c/apath2
 '
 
-test_expect_failure 'diff-index --detect-bulk-moves without full-dir rename.' '
+test_expect_success 'diff-index --detect-bulk-moves without full-dir rename.' '
 	cat >expected <<-EOF &&
 	:040000 040000 X X R#	c/*	a/
 	:100644 100644 X X R#	c/apath0	a/apath0
@@ -105,7 +105,7 @@ test_expect_success 'setup bulk move to toplevel' '
 	git update-index --add --remove apath* c/apath0 c/apath1 c/apath2
 '
 
-test_expect_failure 'diff-index --detect-bulk-moves bulk move to toplevel.' '
+test_expect_success 'diff-index --detect-bulk-moves bulk move to toplevel.' '
 	cat >expected <<-EOF &&
 	:040000 040000 X X R#	c/*	./
 	:100644 100644 X X R#	c/apath0	apath0
@@ -132,7 +132,7 @@ test_expect_success 'setup move including a subdir, with some content changes' '
 
 test_expect_failure 'diff-index --detect-bulk-moves on a move including a subdir.' '
 	cat >expected <<-EOF &&
-	:040000 040000 X X R#	a/	b/
+	:040000 040000 X X R#	a/*	b/
 	:100644 100644 X X R#	a/c/apath0	b/c/apath0
 	:100644 100644 X X R#	a/c/apath1	b/c/apath1
 	:100644 100644 X X R#	a/c/apath2	b/c/apath2
@@ -176,7 +176,7 @@ test_expect_success 'setup move of files and subdirs to different places' '
 
 test_expect_failure 'moving subdirs into one dir and files into another is not mistaken for dir move' '
 	cat >expected <<-EOF &&
-	:040000 040000 X X R#	a/c/	b/
+	:040000 040000 X X R#	a/c/*	b/
 	:100644 100644 X X R#	a/c/apath0	b/apath0
 	:100644 100644 X X R#	a/c/apath1	b/apath1
 	:100644 100644 X X R#	a/c/apath2	b/apath2
@@ -201,11 +201,11 @@ test_expect_success 'setup move of dir with only subdirs' '
 	git mv a z
 '
 
-test_expect_failure 'moving a dir with no files' '
+test_expect_failure 'moving a dir with no direct children files' '
 	cat >expected <<-EOF &&
-	:040000 040000 X X R#	a/	z/
-	:040000 040000 X X R#	a/b/	z/b/
-	:040000 040000 X X R#	a/c/	z/c/
+	:040000 040000 X X R#	a/*	z/
+	:040000 040000 X X R#	a/b/*	z/b/
+	:040000 040000 X X R#	a/c/*	z/c/
 	:100644 100644 X X R#	a/b/path0	z/b/path0
 	:100644 100644 X X R#	a/b/path1	z/b/path1
 	:100644 100644 X X R#	a/b/path2	z/b/path2
@@ -235,7 +235,7 @@ test_expect_success 'setup move from toplevel to subdir' '
 	git update-index --add --remove path0 path1 path2 path3 z/path*
 '
 
-test_expect_failure '--detect-bulk-moves everything from toplevel.' '
+test_expect_success '--detect-bulk-moves everything from toplevel.' '
 	cat >expected <<-EOF &&
 	:040000 040000 X X R#	./*	z/
 	:100644 100644 X X R#	path0	z/path0
-- 
1.7.2.3
