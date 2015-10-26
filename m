From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t6031: generalize for recursive and resolve strategies
Date: Mon, 26 Oct 2015 17:37:18 -0400
Message-ID: <20151026213717.GB17373@sigill.intra.peff.net>
References: <20151026213502.GA17244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 22:37:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqpSX-0000e0-MP
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 22:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbbJZVhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 17:37:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:48146 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753188AbbJZVhU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 17:37:20 -0400
Received: (qmail 9437 invoked by uid 102); 26 Oct 2015 21:37:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 16:37:20 -0500
Received: (qmail 18063 invoked by uid 107); 26 Oct 2015 21:37:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 17:37:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Oct 2015 17:37:18 -0400
Content-Disposition: inline
In-Reply-To: <20151026213502.GA17244@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280228>

This script tests the filemode handling of merge-recursive,
but we do not test the same thing for merge-resolve. Let's
generalize the script a little:

  1. Break out the setup steps for each test into a separate
     snippet.

  2. For each test, run it twice; once with "-s recursive"
     and once with "-s resolve". We can avoid repeating
     ourselves by adding a function.

  3. Since we have a nice abstracted function, we can make
     our tests more thorough by testing both directions
     (change on "ours" versus "theirs").

This improves our test coverage, and will make this the
place to add more tests related to merging mode changes.

Signed-off-by: Jeff King <peff@peff.net>
---
Sadly I changed too much for this to count as a rename (mostly due to
the new indentation). Oh well, the rename diff was not especially
readable, and it is probably just as well to read the new content as a
single blob.

 t/t6031-merge-filemode.sh  | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t6031-merge-recursive.sh | 56 ---------------------------------
 2 files changed, 77 insertions(+), 56 deletions(-)
 create mode 100755 t/t6031-merge-filemode.sh
 delete mode 100755 t/t6031-merge-recursive.sh

diff --git a/t/t6031-merge-filemode.sh b/t/t6031-merge-filemode.sh
new file mode 100755
index 0000000..c6896e6
--- /dev/null
+++ b/t/t6031-merge-filemode.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+
+test_description='merge: handle file mode'
+. ./test-lib.sh
+
+test_expect_success 'set up mode change in one branch' '
+	: >file1 &&
+	git add file1 &&
+	git commit -m initial &&
+	git checkout -b a1 master &&
+	: >dummy &&
+	git add dummy &&
+	git commit -m a &&
+	git checkout -b b1 master &&
+	test_chmod +x file1 &&
+	git add file1 &&
+	git commit -m b1
+'
+
+do_one_mode () {
+	strategy=$1
+	us=$2
+	them=$3
+	test_expect_success "resolve single mode change ($strategy, $us)" '
+		git checkout -f $us &&
+		git merge -s $strategy $them &&
+		git ls-files -s file1 | grep ^100755
+	'
+
+	test_expect_success FILEMODE "verify executable bit on file ($strategy, $us)" '
+		test -x file1
+	'
+}
+
+do_one_mode recursive a1 b1
+do_one_mode recursive b1 a1
+do_one_mode resolve a1 b1
+do_one_mode resolve b1 a1
+
+test_expect_success 'set up mode change in both branches' '
+	git reset --hard HEAD &&
+	git checkout -b a2 master &&
+	: >file2 &&
+	H=$(git hash-object file2) &&
+	test_chmod +x file2 &&
+	git commit -m a2 &&
+	git checkout -b b2 master &&
+	: >file2 &&
+	git add file2 &&
+	git commit -m b2 &&
+	{
+		echo "100755 $H 2	file2"
+		echo "100644 $H 3	file2"
+	} >expect
+'
+
+do_both_modes () {
+	strategy=$1
+	test_expect_success "detect conflict on double mode change ($strategy)" '
+		git reset --hard &&
+		git checkout -f a2 &&
+		test_must_fail git merge -s $strategy b2 &&
+		git ls-files -u >actual &&
+		test_cmp actual expect &&
+		git ls-files -s file2 | grep ^100755
+	'
+
+	test_expect_success FILEMODE "verify executable bit on file ($strategy)" '
+		test -x file2
+	'
+}
+
+# both sides are equivalent, so no need to run both ways
+do_both_modes recursive
+do_both_modes resolve
+
+test_done
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
deleted file mode 100755
index 4053bd9..0000000
--- a/t/t6031-merge-recursive.sh
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-test_description='merge-recursive: handle file mode'
-. ./test-lib.sh
-
-test_expect_success 'mode change in one branch: keep changed version' '
-	: >file1 &&
-	git add file1 &&
-	git commit -m initial &&
-	git checkout -b a1 master &&
-	: >dummy &&
-	git add dummy &&
-	git commit -m a &&
-	git checkout -b b1 master &&
-	test_chmod +x file1 &&
-	git add file1 &&
-	git commit -m b1 &&
-	git checkout a1 &&
-	git merge-recursive master -- a1 b1 &&
-	git ls-files -s file1 | grep ^100755
-'
-
-test_expect_success FILEMODE 'verify executable bit on file' '
-	test -x file1
-'
-
-test_expect_success 'mode change in both branches: expect conflict' '
-	git reset --hard HEAD &&
-	git checkout -b a2 master &&
-	: >file2 &&
-	H=$(git hash-object file2) &&
-	test_chmod +x file2 &&
-	git commit -m a2 &&
-	git checkout -b b2 master &&
-	: >file2 &&
-	git add file2 &&
-	git commit -m b2 &&
-	git checkout a2 &&
-	(
-		git merge-recursive master -- a2 b2
-		test $? = 1
-	) &&
-	git ls-files -u >actual &&
-	(
-		echo "100755 $H 2	file2"
-		echo "100644 $H 3	file2"
-	) >expect &&
-	test_cmp actual expect &&
-	git ls-files -s file2 | grep ^100755
-'
-
-test_expect_success FILEMODE 'verify executable bit on file' '
-	test -x file2
-'
-
-test_done
-- 
2.6.2.481.g6ca35c3
