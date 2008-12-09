From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] diff: fix handling of binary rewrite diffs
Date: Tue, 9 Dec 2008 03:12:28 -0500
Message-ID: <20081209081227.GA19626@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 09:13:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9xj3-0000XL-BD
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 09:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbYLIIMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 03:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYLIIMb
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 03:12:31 -0500
Received: from peff.net ([208.65.91.99]:4276 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbYLIIMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 03:12:30 -0500
Received: (qmail 1069 invoked by uid 111); 9 Dec 2008 08:12:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Dec 2008 03:12:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2008 03:12:28 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102605>

The current emit_rewrite_diff code always writes a text
patch without checking whether the content is binary. This
means that if you end up with a rewrite diff for a binary
file, you get lots of raw binary goo in your patch.

Instead, if we have binary files, then let's just skip
emit_rewrite_diff altogether. We will already have shown the
"dissimilarity index" line, so it is really about the diff
contents. If binary diffs are turned off, the "Binary files
a/file and b/file differ" message should be the same in
either case. If we do have binary patches turned on, there
isn't much point in making a less-efficient binary patch
that does a total rewrite; no human is going to read it, and
since binary patches don't apply with any fuzz anyway, the
result of application should be the same.

Signed-off-by: Jeff King <peff@peff.net>
---
I couldn't think of a good reason to want a different format of binary
patch for a rewrite versus a regular diff, but others may be able to.
In that case, you have to mimic the binary codepath somewhat in
emit_rewrite_diff; I started on it, but realized I was just copying the
code.

However, we should at least do something before 1.6.1; as it is, it
spews binary garbage.

I discovered this because one of my textconv'd files had a rewrite
(which apparently happens by changing a few lines in a word document :))
and gave me a bogus diff. However, the problem is not unique to
textconv; patch 1/2 handles binary files and 2/2 handles the textconv
case.

I didn't put the tests into the existing t4022-diff-rewrite because I
wanted to keep the textconv tests together with these tests, and I think
it makes sense to test features in isolation before testing them
together. IOW:

  t4022 - rewrite works
  t4030 - textconv works
  t4031 - rewrite AND textconv work together

 diff.c                         |    4 ++-
 t/t4031-diff-rewrite-binary.sh |   42 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletions(-)
 create mode 100755 t/t4031-diff-rewrite-binary.sh

diff --git a/diff.c b/diff.c
index f644947..ea958a2 100644
--- a/diff.c
+++ b/diff.c
@@ -1376,7 +1376,9 @@ static void builtin_diff(const char *name_a,
 		 */
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
-		if (complete_rewrite) {
+		if (complete_rewrite &&
+		    !diff_filespec_is_binary(one) &&
+		    !diff_filespec_is_binary(two)) {
 			emit_rewrite_diff(name_a, name_b, one, two, o);
 			o->found_changes = 1;
 			goto free_ab_and_return;
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
new file mode 100755
index 0000000..4b522f7
--- /dev/null
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='rewrite diff on binary file'
+
+. ./test-lib.sh
+
+# We must be large enough to meet the MINIMUM_BREAK_SIZE
+# requirement.
+make_file() {
+	for i in 1 2 3 4 5 6 7 8 9 10; do
+		for j in 1 2 3 4 5 6 7 9 10; do
+			for k in 1 2 3 4 5; do
+				printf "$1\n"
+			done
+		done
+	done >file
+}
+
+test_expect_success 'create binary file with changes' '
+	make_file "\\0" &&
+	git add file &&
+	make_file "\\01"
+'
+
+test_expect_success 'vanilla diff is binary' '
+	git diff >diff &&
+	grep "Binary files a/file and b/file differ" diff
+'
+
+test_expect_success 'rewrite diff is binary' '
+	git diff -B >diff &&
+	grep "dissimilarity index" diff &&
+	grep "Binary files a/file and b/file differ" diff
+'
+
+test_expect_success 'rewrite diff can show binary patch' '
+	git diff -B --binary >diff &&
+	grep "dissimilarity index" diff &&
+	grep "GIT binary patch" diff
+'
+
+test_done
-- 
1.6.1.rc2.1.g8f945.dirty
