From: Jeff King <peff@peff.net>
Subject: [PATCH 10/25] t: use test_expect_code instead of hand-rolled
 comparison
Date: Fri, 20 Mar 2015 06:11:46 -0400
Message-ID: <20150320101146.GJ12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:11:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtuD-0004YA-AI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbbCTKLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:11:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:35694 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751318AbbCTKLs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:11:48 -0400
Received: (qmail 5845 invoked by uid 102); 20 Mar 2015 10:11:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:11:49 -0500
Received: (qmail 21556 invoked by uid 107); 20 Mar 2015 10:12:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:12:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:11:46 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265884>

This makes our output in the event of a failure slightly
nicer, and it means that we do not break the &&-chain.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0040-parse-options.sh | 12 +++------
 t/t4035-diff-quiet.sh    | 66 +++++++++++++++++++++++-------------------------
 t/t4053-diff-no-index.sh |  4 +--
 3 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a90c86b..b044785 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -172,12 +172,9 @@ test_expect_success 'long options' '
 '
 
 test_expect_success 'missing required value' '
-	test-parse-options -s;
-	test $? = 129 &&
-	test-parse-options --string;
-	test $? = 129 &&
-	test-parse-options --file;
-	test $? = 129
+	test_expect_code 129 test-parse-options -s &&
+	test_expect_code 129 test-parse-options --string &&
+	test_expect_code 129 test-parse-options --file
 '
 
 cat > expect << EOF
@@ -227,8 +224,7 @@ test_expect_success 'unambiguously abbreviated option with "="' '
 '
 
 test_expect_success 'ambiguously abbreviated option' '
-	test-parse-options --strin 123;
-	test $? = 129
+	test_expect_code 129 test-parse-options --strin 123
 '
 
 cat > expect << EOF
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index e8ae2a0..461f4bb 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -29,67 +29,65 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'git diff-tree HEAD^ HEAD' '
-	git diff-tree --quiet HEAD^ HEAD >cnt
-	test $? = 1 && test_line_count = 0 cnt
+	test_expect_code 1 git diff-tree --quiet HEAD^ HEAD >cnt &&
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- a' '
-	git diff-tree --quiet HEAD^ HEAD -- a >cnt
-	test $? = 0 && test_line_count = 0 cnt
+	test_expect_code 0 git diff-tree --quiet HEAD^ HEAD -- a >cnt &&
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- b' '
-	git diff-tree --quiet HEAD^ HEAD -- b >cnt
-	test $? = 1 && test_line_count = 0 cnt
+	test_expect_code 1 git diff-tree --quiet HEAD^ HEAD -- b >cnt &&
+	test_line_count = 0 cnt
 '
 # this diff outputs one line: sha1 of the given head
 test_expect_success 'echo HEAD | git diff-tree --stdin' '
-	echo $(git rev-parse HEAD) | git diff-tree --quiet --stdin >cnt
-	test $? = 1 && test_line_count = 1 cnt
+	echo $(git rev-parse HEAD) |
+	test_expect_code 1 git diff-tree --quiet --stdin >cnt &&
+	test_line_count = 1 cnt
 '
 test_expect_success 'git diff-tree HEAD HEAD' '
-	git diff-tree --quiet HEAD HEAD >cnt
-	test $? = 0 && test_line_count = 0 cnt
+	test_expect_code 0 git diff-tree --quiet HEAD HEAD >cnt &&
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-files' '
-	git diff-files --quiet >cnt
-	test $? = 0 && test_line_count = 0 cnt
+	test_expect_code 0 git diff-files --quiet >cnt &&
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-index --cached HEAD' '
-	git diff-index --quiet --cached HEAD >cnt
-	test $? = 0 && test_line_count = 0 cnt
+	test_expect_code 0 git diff-index --quiet --cached HEAD >cnt &&
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-index --cached HEAD^' '
-	git diff-index --quiet --cached HEAD^ >cnt
-	test $? = 1 && test_line_count = 0 cnt
+	test_expect_code 1 git diff-index --quiet --cached HEAD^ >cnt &&
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-index --cached HEAD^' '
 	echo text >>b &&
 	echo 3 >c &&
-	git add . && {
-		git diff-index --quiet --cached HEAD^ >cnt
-		test $? = 1 && test_line_count = 0 cnt
-	}
+	git add . &&
+	test_expect_code 1 git diff-index --quiet --cached HEAD^ >cnt &&
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-tree -Stext HEAD^ HEAD -- b' '
-	git commit -m "text in b" && {
-		git diff-tree --quiet -Stext HEAD^ HEAD -- b >cnt
-		test $? = 1 && test_line_count = 0 cnt
-	}
+	git commit -m "text in b" &&
+	test_expect_code 1 git diff-tree --quiet -Stext HEAD^ HEAD -- b >cnt &&
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-tree -Snot-found HEAD^ HEAD -- b' '
-	git diff-tree --quiet -Snot-found HEAD^ HEAD -- b >cnt
-	test $? = 0 && test_line_count = 0 cnt
+	test_expect_code 0 git diff-tree --quiet -Snot-found HEAD^ HEAD -- b >cnt &&
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-files' '
-	echo 3 >>c && {
-		git diff-files --quiet >cnt
-		test $? = 1 && test_line_count = 0 cnt
-	}
+	echo 3 >>c &&
+	test_expect_code 1 git diff-files --quiet >cnt &&
+	test_line_count = 0 cnt
 '
+
 test_expect_success 'git diff-index --cached HEAD' '
-	git update-index c && {
-		git diff-index --quiet --cached HEAD >cnt
-		test $? = 1 && test_line_count = 0 cnt
-	}
+	git update-index c &&
+	test_expect_code 1 git diff-index --quiet --cached HEAD >cnt &&
+	test_line_count = 0 cnt
 '
 
 test_expect_success 'git diff, one file outside repo' '
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 2ab3c48..075ece6 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -17,8 +17,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'git diff --no-index directories' '
-	git diff --no-index a b >cnt
-	test $? = 1 && test_line_count = 14 cnt
+	test_expect_code 1 git diff --no-index a b >cnt &&
+	test_line_count = 14 cnt
 '
 
 test_expect_success 'git diff --no-index relative path outside repo' '
-- 
2.3.3.520.g3cfbb5d
