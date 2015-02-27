From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] diffcore-rename: avoid processing duplicate destinations
Date: Thu, 26 Feb 2015 20:42:27 -0500
Message-ID: <20150227014227.GB3210@peff.net>
References: <20150227013847.GA2983@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 02:42:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR9wp-000830-6D
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 02:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbbB0Bma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 20:42:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:54001 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752386AbbB0Bm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 20:42:29 -0500
Received: (qmail 28452 invoked by uid 102); 27 Feb 2015 01:42:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 19:42:29 -0600
Received: (qmail 30206 invoked by uid 107); 27 Feb 2015 01:42:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 20:42:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2015 20:42:27 -0500
Content-Disposition: inline
In-Reply-To: <20150227013847.GA2983@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264488>

The rename code cannot handle an input where we have
duplicate destinations (i.e., more than one diff_filepair in
the queue with the same string in its pair->two->path). We
end up allocating only one slot in the rename_dst mapping.
If we fill in the diff_filepair for that slot, when we
re-queue the results, we may queue that filepair multiple
times. When the diff is finally flushed, the filepair is
processed and free()d multiple times, leading to heap
corruption.

This situation should only happen when a tree diff sees
duplicates in one of the trees (see the added test for a
detailed example). Rather than handle it, the sanest thing
is just to turn off rename detection altogether for the
diff.

Signed-off-by: Jeff King <peff@peff.net>
---
Like I mentioned before, I'm OK with not checking the actual diff output
in the test. It's not like it was planned, and is just what diff_tree()
happens to produce. It does make sense, though. We descend into the
first "outer/" of the "a/" side along with the sole "outer/" of the
"b/" side. We see that the entries from "b/" are all added. Then we come
back out, and see that "a/" has another "outer/", but that "b/" does
not. So all of those entries look like they were deleted.

 diffcore-rename.c          |  8 +++--
 t/t4058-diff-duplicates.sh | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100755 t/t4058-diff-duplicates.sh

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 4250cc0..af1fe08 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -466,8 +466,12 @@ void diffcore_rename(struct diff_options *options)
 			else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
 				 is_empty_blob_sha1(p->two->sha1))
 				continue;
-			else
-				add_rename_dst(p->two);
+			else if (add_rename_dst(p->two) < 0) {
+				warning("skipping rename detection, detected"
+					" duplicate destination '%s'",
+					p->two->path);
+				goto cleanup;
+			}
 		}
 		else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
 			 is_empty_blob_sha1(p->one->sha1))
diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
new file mode 100755
index 0000000..0a23242
--- /dev/null
+++ b/t/t4058-diff-duplicates.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='test tree diff when trees have duplicate entries'
+. ./test-lib.sh
+
+# make_tree_entry <mode> <mode> <sha1>
+#
+# We have to rely on perl here because not all printfs understand
+# hex escapes (only octal), and xxd is not portable.
+make_tree_entry () {
+	printf '%s %s\0' "$1" "$2" &&
+	perl -e 'print chr(hex($_)) for ($ARGV[0] =~ /../g)' "$3"
+}
+
+# Like git-mktree, but without all of the pesky sanity checking.
+# Arguments come in groups of three, each group specifying a single
+# tree entry (see make_tree_entry above).
+make_tree () {
+	while test $# -gt 2; do
+		make_tree_entry "$1" "$2" "$3"
+		shift; shift; shift
+	done |
+	git hash-object -w -t tree --stdin
+}
+
+# this is kind of a convoluted setup, but matches
+# a real-world case. Each tree contains four entries
+# for the given path, one with one sha1, and three with
+# the other. The first tree has them split across
+# two subtrees (which are themselves duplicate entries in
+# the root tree), and the second has them all in a single subtree.
+test_expect_success 'create trees with duplicate entries' '
+	blob_one=$(echo one | git hash-object -w --stdin) &&
+	blob_two=$(echo two | git hash-object -w --stdin) &&
+	inner_one_a=$(make_tree \
+		100644 inner $blob_one
+	) &&
+	inner_one_b=$(make_tree \
+		100644 inner $blob_two \
+		100644 inner $blob_two \
+		100644 inner $blob_two
+	) &&
+	outer_one=$(make_tree \
+		040000 outer $inner_one_a \
+		040000 outer $inner_one_b
+	) &&
+	inner_two=$(make_tree \
+		100644 inner $blob_one \
+		100644 inner $blob_two \
+		100644 inner $blob_two \
+		100644 inner $blob_two
+	) &&
+	outer_two=$(make_tree \
+		040000 outer $inner_two
+	) &&
+	git tag one $outer_one &&
+	git tag two $outer_two
+'
+
+test_expect_success 'diff-tree between trees' '
+	{
+		printf ":000000 100644 $_z40 $blob_two A\touter/inner\n" &&
+		printf ":000000 100644 $_z40 $blob_two A\touter/inner\n" &&
+		printf ":000000 100644 $_z40 $blob_two A\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $_z40 D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $_z40 D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $_z40 D\touter/inner\n"
+	} >expect &&
+	git diff-tree -r --no-abbrev one two >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff-tree with renames' '
+	# same expectation as above, since we disable rename detection
+	git diff-tree -M -r --no-abbrev one two >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.3.0.449.g1690e78
