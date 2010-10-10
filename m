From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] [RFC] Only show bulkmoves in output.
Date: Sun, 10 Oct 2010 21:59:54 +0200
Message-ID: <1286740795-7929-2-git-send-email-ydirson@altern.org>
References: <20101010123954.GB4983@home.lan>
 <1286740795-7929-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 22:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52ZD-00070z-7q
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281Ab0JJUcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 16:32:10 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:51480 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab0JJUcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 16:32:09 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5A293D4816E;
	Sun, 10 Oct 2010 22:32:01 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P52j5-00025k-H0; Sun, 10 Oct 2010 22:42:35 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286740795-7929-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158699>

At display time, append a "*" suffix to bulk-move sources.  Later
we will be more selective and not display it for bulk moves that are
indeed a directory rename.

Open question: "foo/*" is a valid name for a file, so if such a file
is part of a bulk move, we will see one "foo/*" entry for the bulk
move (with zeroed sha1's), and one "foo/*" for the individual file
(with its own sha1).  Is that seen as a problem ?  After all, the
zeroed sha1's are probably here to stay (or do we want to add tree
sha1's where possible ?), so it is pretty easy to tell which is which.
An alternative would be to have another way of telling it is a
bulk-move, such as a flag to M or C (eg. M100B), but there is no
precedent for this, so I can't tell for myself.

After this patch only one of the expected failures can be considered
innocuous.
---
 diff.c                           |    9 ++++++++-
 diffcore-rename.c                |    4 ++--
 diffcore.h                       |    1 +
 t/t4046-diff-rename-factorize.sh |   22 +++++++++++-----------
 4 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 64e01b3..4de43d6 100644
--- a/diff.c
+++ b/diff.c
@@ -3471,7 +3471,14 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 	if (p->status == DIFF_STATUS_COPIED ||
 	    p->status == DIFF_STATUS_RENAMED) {
 		const char *name_a, *name_b;
-		name_a = p->one->path;
+		if (p->is_bulkmove) {
+			/* append "*" to the first dirname */
+			char buf[PATH_MAX];
+			char* next = memccpy(buf, p->one->path, '\0', PATH_MAX);
+			next[-1] = '*'; *next = '\0';
+			name_a = buf;
+		} else
+			name_a = p->one->path;
 		name_b = p->two->path;
 		strip_prefix(opt->prefix_length, &name_a, &name_b);
 		write_name_quoted(name_a, opt->file, inter_name_termination);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 18a0605..8de0d57 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -603,8 +603,7 @@ static void check_one_bulk_move(struct diff_filepair *dstpair)
 	/* already considered ? */
 	for (seen=bulkmove_candidates; seen; seen = seen->next)
 		if (!strcmp(seen->one->path, one_parent_path)) break;
-	if (!seen) {
-		/* record potential dir rename */
+	if (!seen) { /* record potential dir rename */
 		seen = xmalloc(sizeof(*seen));
 		seen->one = alloc_filespec(one_parent_path);
 		fill_filespec(seen->one, null_sha1 /*FIXME*/, S_IFDIR);
@@ -830,6 +829,7 @@ void diffcore_rename(struct diff_options *options)
 		pair = diff_queue(&outq, candidate->one, candidate->two);
 		pair->score = MAX_SCORE;
 		pair->renamed_pair = 1;
+		pair->is_bulkmove = 1;
 	}
 
 	for (i = 0; i < q->nr; i++) {
diff --git a/diffcore.h b/diffcore.h
index b8f1fde..6dab95b 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -69,6 +69,7 @@ struct diff_filepair {
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
+	unsigned is_bulkmove : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
 
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
