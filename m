From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t6031: move triple-rename test to t3030
Date: Mon, 26 Oct 2015 17:36:18 -0400
Message-ID: <20151026213618.GA17373@sigill.intra.peff.net>
References: <20151026213502.GA17244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 22:36:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqpRL-0007L3-PO
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 22:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbbJZVgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 17:36:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:48143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752877AbbJZVgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 17:36:21 -0400
Received: (qmail 9383 invoked by uid 102); 26 Oct 2015 21:36:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 16:36:20 -0500
Received: (qmail 18047 invoked by uid 107); 26 Oct 2015 21:36:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 17:36:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Oct 2015 17:36:18 -0400
Content-Disposition: inline
In-Reply-To: <20151026213502.GA17244@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280227>

The t6031 test was introduced to check filemode handling of
merge-recursive. Much later, an unrelated test was tacked on
to look at renames and d/f conflicts. This test does not
depend on anything that happened before (it actually blows
away any existing content in the test repo). Let's move it
to t3030, where there are more related tests.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't actually look all that closely at what it does and what t3030
does to see if there is overlap, and we could simply get rid of this.
But it _definitely_ doesn't belong in t6031, so this is at least a step
forward.

 t/t3030-merge-recursive.sh | 30 ++++++++++++++++++++++++++++++
 t/t6031-merge-recursive.sh | 31 -------------------------------
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 82e1854..6224187 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -629,5 +629,35 @@ test_expect_failure 'merge-recursive rename vs. rename/symlink' '
 	test_cmp expected actual
 '
 
+test_expect_success 'merging with triple rename across D/F conflict' '
+	git reset --hard HEAD &&
+	git checkout -b main &&
+	git rm -rf . &&
+
+	echo "just a file" >sub1 &&
+	mkdir -p sub2 &&
+	echo content1 >sub2/file1 &&
+	echo content2 >sub2/file2 &&
+	echo content3 >sub2/file3 &&
+	mkdir simple &&
+	echo base >simple/bar &&
+	git add -A &&
+	test_tick &&
+	git commit -m base &&
+
+	git checkout -b other &&
+	echo more >>simple/bar &&
+	test_tick &&
+	git commit -a -m changesimplefile &&
+
+	git checkout main &&
+	git rm sub1 &&
+	git mv sub2 sub1 &&
+	test_tick &&
+	git commit -m changefiletodir &&
+
+	test_tick &&
+	git merge other
+'
 
 test_done
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index 6464a16..4053bd9 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -53,35 +53,4 @@ test_expect_success FILEMODE 'verify executable bit on file' '
 	test -x file2
 '
 
-test_expect_success 'merging with triple rename across D/F conflict' '
-	git reset --hard HEAD &&
-	git checkout -b main &&
-	git rm -rf . &&
-
-	echo "just a file" >sub1 &&
-	mkdir -p sub2 &&
-	echo content1 >sub2/file1 &&
-	echo content2 >sub2/file2 &&
-	echo content3 >sub2/file3 &&
-	mkdir simple &&
-	echo base >simple/bar &&
-	git add -A &&
-	test_tick &&
-	git commit -m base &&
-
-	git checkout -b other &&
-	echo more >>simple/bar &&
-	test_tick &&
-	git commit -a -m changesimplefile &&
-
-	git checkout main &&
-	git rm sub1 &&
-	git mv sub2 sub1 &&
-	test_tick &&
-	git commit -m changefiletodir &&
-
-	test_tick &&
-	git merge other
-'
-
 test_done
-- 
2.6.2.481.g6ca35c3
