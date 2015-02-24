From: Jeff King <peff@peff.net>
Subject: [BUG] diffcore-rename with duplicate tree entries can segfault
Date: Tue, 24 Feb 2015 16:43:11 -0500
Message-ID: <20150224214311.GA8622@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:43:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQNGA-0002Q3-Dz
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 22:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbbBXVnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 16:43:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:52863 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752600AbbBXVnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 16:43:13 -0500
Received: (qmail 7617 invoked by uid 102); 24 Feb 2015 21:43:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 15:43:13 -0600
Received: (qmail 9260 invoked by uid 107); 24 Feb 2015 21:43:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 16:43:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2015 16:43:11 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264349>

I ran across a real-world case where git segfaults on some trees that
have duplicate entries. Those trees are obviously broken, and I'm fine
with us producing whatever output we like on them. But probably we
shouldn't segfault.

Basically what happens is that the rename_dst array maps paths to
diff_filepairs. When we process the results of the rename, if we have
duplicates we may hit that same pathname multiple times, and pull out
the same diff_filepair. So we end up with a diff_queue that has the same
filepair mentioned multiple times. When it comes time to flush and free
that queue, we do a double (or triple) free of the filepair and its
contents, which corrupts the heap.

I managed to reduce it to a simplified test case:

diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
new file mode 100755
index 0000000..9e03490
--- /dev/null
+++ b/t/t4058-diff-duplicates.sh
@@ -0,0 +1,85 @@
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
+	{
+		printf ":100644 100644 $blob_two $blob_two M\touter/inner\n" &&
+		printf ":000000 100644 $_z40 $blob_two A\touter/inner\n" &&
+		printf ":000000 100644 $_z40 $blob_two A\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $_z40 D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $_z40 D\touter/inner\n"
+	} >expect &&
+	git diff-tree -M -r --no-abbrev one two >actual &&
+	test_cmp expect actual
+'
+
+test_done

The diff-tree outputs are up for debate. Possibly we should not even be
checking the output at all, and just making sure we don't segfault. The
first one is produced with stock git, and kind-of makes sense (we don't
link up the obviously matching paths in the tree diff because they come
from two different subtrees). Of course with "-p" it cannot be applied,
but it is at least somewhat informative to the user.

The second one is what is produced by the patch below. It also kind of
makes sense (we link up one pair, but the others are left out of the
rename detection). Though I would have expected the `M` in the first
line to be an `R100`.

My idea for a fix was to make sure we didn't pull the same entry out of
locate_rename_dst multiple times:

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 4e132f1..7030502 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -12,6 +12,7 @@
 static struct diff_rename_dst {
 	struct diff_filespec *two;
 	struct diff_filepair *pair;
+	int used;
 } *rename_dst;
 static int rename_dst_nr, rename_dst_alloc;
 
@@ -27,7 +28,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 		struct diff_rename_dst *dst = &(rename_dst[next]);
 		int cmp = strcmp(two->path, dst->two->path);
 		if (!cmp)
-			return dst;
+			return dst->used ? NULL : dst;
 		if (cmp < 0) {
 			last = next;
 			continue;
@@ -46,6 +47,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 	rename_dst[first].two = alloc_filespec(two->path);
 	fill_filespec(rename_dst[first].two, two->sha1, two->sha1_valid, two->mode);
 	rename_dst[first].pair = NULL;
+	rename_dst[first].used = 0;
 	return &(rename_dst[first]);
 }
 
@@ -587,6 +589,7 @@ void diffcore_rename(struct diff_options *options)
 			if (dst && dst->pair) {
 				diff_q(&outq, dst->pair);
 				pair_to_free = p;
+				dst->used = 1;
 			}
 			else
 				/* no matching rename/copy source, so


That does fix this problem, and it doesn't break any other tests. But
frankly, I don't know what I'm doing and this feels like a giant hack.
The "M" output above is confusing to me, and I have no faith that there
isn't another way this problem can come up (e.g., with duplicate
sources).

Given that this is tangentially related to the "-B -M" stuff you've been
looking at (and it's your code in the first place :) ), I thought you
might have some insight.

-Peff
