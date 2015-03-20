From: Jeff King <peff@peff.net>
Subject: [PATCH 20/25] t4117: use modern test_* helpers
Date: Fri, 20 Mar 2015 06:13:18 -0400
Message-ID: <20150320101318.GT12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvh-0005qT-Oj
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbbCTKNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:35720 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbbCTKNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:21 -0400
Received: (qmail 5931 invoked by uid 102); 20 Mar 2015 10:13:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:21 -0500
Received: (qmail 21666 invoked by uid 107); 20 Mar 2015 10:13:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:18 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265894>

We can use test_must_fail and test_path_* to avoid some
hand-rolled if statements. This makes the code shorter, and
makes it more obvious when we are breaking the &&-chain.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4117-apply-reject.sh | 66 ++++++++-----------------------------------------
 1 file changed, 10 insertions(+), 56 deletions(-)

diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index 8e15ecb..d80187d 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -56,23 +56,13 @@ test_expect_success 'apply --reject is incompatible with --3way' '
 
 test_expect_success 'apply without --reject should fail' '
 
-	if git apply patch.1
-	then
-		echo "Eh? Why?"
-		exit 1
-	fi
-
+	test_must_fail git apply patch.1 &&
 	test_cmp file1 saved.file1
 '
 
 test_expect_success 'apply without --reject should fail' '
 
-	if git apply --verbose patch.1
-	then
-		echo "Eh? Why?"
-		exit 1
-	fi
-
+	test_must_fail git apply --verbose patch.1 &&
 	test_cmp file1 saved.file1
 '
 
@@ -81,21 +71,11 @@ test_expect_success 'apply with --reject should fail but update the file' '
 	cat saved.file1 >file1 &&
 	rm -f file1.rej file2.rej &&
 
-	if git apply --reject patch.1
-	then
-		echo "succeeds with --reject?"
-		exit 1
-	fi
-
+	test_must_fail git apply --reject patch.1 &&
 	test_cmp file1 expected &&
 
 	cat file1.rej &&
-
-	if test -f file2.rej
-	then
-		echo "file2 should not have been touched"
-		exit 1
-	fi
+	test_path_is_missing file2.rej
 '
 
 test_expect_success 'apply with --reject should fail but update the file' '
@@ -103,25 +83,12 @@ test_expect_success 'apply with --reject should fail but update the file' '
 	cat saved.file1 >file1 &&
 	rm -f file1.rej file2.rej file2 &&
 
-	if git apply --reject patch.2 >rejects
-	then
-		echo "succeeds with --reject?"
-		exit 1
-	fi
-
-	test -f file1 && {
-		echo "file1 still exists?"
-		exit 1
-	}
+	test_must_fail git apply --reject patch.2 >rejects &&
+	test_path_is_missing file1 &&
 	test_cmp file2 expected &&
 
 	cat file2.rej &&
-
-	if test -f file1.rej
-	then
-		echo "file2 should not have been touched"
-		exit 1
-	fi
+	test_path_is_missing file1.rej
 
 '
 
@@ -130,25 +97,12 @@ test_expect_success 'the same test with --verbose' '
 	cat saved.file1 >file1 &&
 	rm -f file1.rej file2.rej file2 &&
 
-	if git apply --reject --verbose patch.2 >rejects
-	then
-		echo "succeeds with --reject?"
-		exit 1
-	fi
-
-	test -f file1 && {
-		echo "file1 still exists?"
-		exit 1
-	}
+	test_must_fail git apply --reject --verbose patch.2 >rejects &&
+	test_path_is_missing file1 &&
 	test_cmp file2 expected &&
 
 	cat file2.rej &&
-
-	if test -f file1.rej
-	then
-		echo "file2 should not have been touched"
-		exit 1
-	fi
+	test_path_is_missing file1.rej
 
 '
 
-- 
2.3.3.520.g3cfbb5d
