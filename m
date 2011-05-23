From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] combine-diff: handle binary files as binary
Date: Mon, 23 May 2011 16:27:34 -0400
Message-ID: <20110523202734.GC6298@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QObj5-0004im-B9
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 22:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934058Ab1EWU1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 16:27:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58966
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933515Ab1EWU1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 16:27:37 -0400
Received: (qmail 23068 invoked by uid 107); 23 May 2011 20:29:41 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 16:29:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 16:27:34 -0400
Content-Disposition: inline
In-Reply-To: <20110523201529.GA6281@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174269>

The combined diff code path is totally different from the
regular diff code path, and didn't handle binary files at
all. The results of a combined diff on a binary file could
range from annoying (since we spewed binary garbage,
possibly upsetting the user's terminal), to wrong (embedded
NULs caused us to show incorrect diffs, with lines truncated
at the NUL character), to potential security problems
(embedded NULs could interfere with "-z" output, possibly
defeating policy hooks which parse diff output).

Instead, we consider a combined diff to be binary if any of
the input blobs is binary. To show a binary combined diff,
we indicate "Binary blobs differ"; the "index" meta line
will show which parents had which blob.

Signed-off-by: Jeff King <peff@peff.net>
---
The big question here is what we want the output to look like. I chose
this:

  diff --combined foo
  index 7ea6ded,6197570..9563691
  Binary files differ

which contains all of the information we have: for file "foo" there were
two parents (at 7ea6ded and 6197570 respectively), and the resolution
was 9563691. If you want to see full sha1s, you can use --full-index.
This format maps very closely to the non-combined case, which looks
like:

  diff --git a/foo b/foo
  index 6197570..9563691 100644
  Binary files a/foo and b/foo differ

Two other obvious options for format would be:

  1. A combined diff of fake text, like:

     - Binary blob 7ea6ded
      -Binary blob 6197570
     ++Binary blob 9563691

    But this contains no additional information over the index line, and
    I worry that it will be less obvious to readers what is going on.

  2. The --raw format, which looks like:

     ::100644 100644 100644 7ea6ded... 6197570... 9563691... MM binary

     but again, there's really no extra information there (the modes
     are there, but in the case of changed modes, we already produce a
     separate mode line like "mode 100644,100755 100755". And I
     personally find it way less readable (it's more compact, which is
     good for actual --raw mode, but in patch mode we are already
     spending quite a few lines per file).

So I think what I have is succint, complete, and matches the
non-combined case as well as we can.

 combine-diff.c                  |   37 ++++++++++++-
 t/t4048-diff-combined-binary.sh |  113 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100755 t/t4048-diff-combined-binary.sh

diff --git a/combine-diff.c b/combine-diff.c
index 2183184..94a207f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -7,6 +7,7 @@
 #include "xdiff-interface.h"
 #include "log-tree.h"
 #include "refs.h"
+#include "userdiff.h"
 
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
@@ -685,7 +686,8 @@ static void show_combined_header(struct combine_diff_path *elem,
 				 int num_parent,
 				 int dense,
 				 struct rev_info *rev,
-				 int mode_differs)
+				 int mode_differs,
+				 int show_file_header)
 {
 	struct diff_options *opt = &rev->diffopt;
 	int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
@@ -739,6 +741,9 @@ static void show_combined_header(struct combine_diff_path *elem,
 		printf("%s\n", c_reset);
 	}
 
+	if (!show_file_header)
+		return;
+
 	if (added)
 		dump_quoted_path("--- ", "", "/dev/null",
 				 c_meta, c_reset);
@@ -765,8 +770,13 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	int i, show_hunks;
 	int working_tree_file = is_null_sha1(elem->sha1);
 	mmfile_t result_file;
+	struct userdiff_driver *userdiff;
+	int is_binary;
 
 	context = opt->context;
+	userdiff = userdiff_find_by_path(elem->path);
+	if (!userdiff)
+		userdiff = userdiff_find_by_name("default");
 
 	/* Read the result of merge first */
 	if (!working_tree_file)
@@ -852,6 +862,29 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		}
 	}
 
+	if (userdiff->binary != -1)
+		is_binary = userdiff->binary;
+	else {
+		is_binary = buffer_is_binary(result, result_size);
+		for (i = 0; !is_binary && i < num_parent; i++) {
+			char *buf;
+			unsigned long size;
+			buf = grab_blob(elem->parent[i].sha1,
+					elem->parent[i].mode,
+					&size);
+			if (buffer_is_binary(buf, size))
+				is_binary = 1;
+			free(buf);
+		}
+	}
+	if (is_binary) {
+		show_combined_header(elem, num_parent, dense, rev,
+				     mode_differs, 0);
+		printf("Binary files differ\n");
+		free(result);
+		return;
+	}
+
 	for (cnt = 0, cp = result; cp < result + result_size; cp++) {
 		if (*cp == '\n')
 			cnt++;
@@ -906,7 +939,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 	if (show_hunks || mode_differs || working_tree_file) {
 		show_combined_header(elem, num_parent, dense, rev,
-				     mode_differs);
+				     mode_differs, 1);
 		dump_sline(sline, cnt, num_parent,
 			   DIFF_OPT_TST(opt, COLOR_DIFF), result_deleted);
 	}
diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary.sh
new file mode 100755
index 0000000..a943994
--- /dev/null
+++ b/t/t4048-diff-combined-binary.sh
@@ -0,0 +1,113 @@
+#!/bin/sh
+
+test_description='combined and merge diff handle binary files and textconv'
+. ./test-lib.sh
+
+test_expect_success 'setup binary merge conflict' '
+	echo oneQ1 | q_to_nul >binary &&
+	git add binary &&
+	git commit -m one &&
+	echo twoQ2 | q_to_nul >binary &&
+	git commit -a -m two &&
+	git checkout -b branch-binary HEAD^ &&
+	echo threeQ3 | q_to_nul >binary &&
+	git commit -a -m three &&
+	test_must_fail git merge master &&
+	echo resolvedQhooray | q_to_nul >binary &&
+	git commit -a -m resolved
+'
+
+cat >expect <<'EOF'
+resolved
+
+diff --git a/binary b/binary
+index 7ea6ded..9563691 100644
+Binary files a/binary and b/binary differ
+resolved
+
+diff --git a/binary b/binary
+index 6197570..9563691 100644
+Binary files a/binary and b/binary differ
+EOF
+test_expect_success 'diff -m indicates binary-ness' '
+	git show --format=%s -m >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+resolved
+
+diff --combined binary
+index 7ea6ded,6197570..9563691
+Binary files differ
+EOF
+test_expect_success 'diff -c indicates binary-ness' '
+	git show --format=%s -c >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+resolved
+
+diff --cc binary
+index 7ea6ded,6197570..9563691
+Binary files differ
+EOF
+test_expect_success 'diff --cc indicates binary-ness' '
+	git show --format=%s --cc >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup non-binary with binary attribute' '
+	git checkout master &&
+	test_commit one text &&
+	test_commit two text &&
+	git checkout -b branch-text HEAD^ &&
+	test_commit three text &&
+	test_must_fail git merge master &&
+	test_commit resolved text &&
+	echo text -diff >.gitattributes
+'
+
+cat >expect <<'EOF'
+resolved
+
+diff --git a/text b/text
+index 2bdf67a..2ab19ae 100644
+Binary files a/text and b/text differ
+resolved
+
+diff --git a/text b/text
+index f719efd..2ab19ae 100644
+Binary files a/text and b/text differ
+EOF
+test_expect_success 'diff -m respects binary attribute' '
+	git show --format=%s -m >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+resolved
+
+diff --combined text
+index 2bdf67a,f719efd..2ab19ae
+Binary files differ
+EOF
+test_expect_success 'diff -c respects binary attribute' '
+	git show --format=%s -c >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+resolved
+
+diff --cc text
+index 2bdf67a,f719efd..2ab19ae
+Binary files differ
+EOF
+test_expect_success 'diff --cc respects binary attribute' '
+	git show --format=%s --cc >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.5.2.4.g43415
