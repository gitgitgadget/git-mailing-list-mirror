From: Jeff King <peff@peff.net>
Subject: [PATCH 19/25] t6034: use modern test_* helpers
Date: Fri, 20 Mar 2015 06:13:15 -0400
Message-ID: <20150320101315.GS12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvh-0005qT-5g
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbbCTKNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:35715 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbbCTKNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:17 -0400
Received: (qmail 5923 invoked by uid 102); 20 Mar 2015 10:13:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:17 -0500
Received: (qmail 21661 invoked by uid 107); 20 Mar 2015 10:13:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:15 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265895>

These say roughly the same thing as the hand-rolled
messages. We do lose the "merge did not complete" debug
message, but merge and write-tree are prefectly capable of
writing useful error messages when they fail.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6034-merge-rename-nocruft.sh | 66 ++++++++---------------------------------
 1 file changed, 13 insertions(+), 53 deletions(-)

diff --git a/t/t6034-merge-rename-nocruft.sh b/t/t6034-merge-rename-nocruft.sh
index 65be95f..89871aa 100755
--- a/t/t6034-merge-rename-nocruft.sh
+++ b/t/t6034-merge-rename-nocruft.sh
@@ -73,33 +73,12 @@ test_expect_success 'merge white into red (A->B,M->N)' \
 '
 	git checkout -b red-white red &&
 	git merge white &&
-	git write-tree >/dev/null || {
-		echo "BAD: merge did not complete"
-		return 1
-	}
-
-	test -f B || {
-		echo "BAD: B does not exist in working directory"
-		return 1
-	}
-	test -f N || {
-		echo "BAD: N does not exist in working directory"
-		return 1
-	}
-	test -f R || {
-		echo "BAD: R does not exist in working directory"
-		return 1
-	}
-
-	test -f A && {
-		echo "BAD: A still exists in working directory"
-		return 1
-	}
-	test -f M && {
-		echo "BAD: M still exists in working directory"
-		return 1
-	}
-	return 0
+	git write-tree &&
+	test_path_is_file B &&
+	test_path_is_file N &&
+	test_path_is_file R &&
+	test_path_is_missing A &&
+	test_path_is_missing M
 '
 
 # This test broke in 8371234ecaaf6e14fe3f2082a855eff1bbd79ae9
@@ -108,32 +87,13 @@ test_expect_success 'merge blue into white (A->B, mod A, A untracked)' \
 	git checkout -b white-blue white &&
 	echo dirty >A &&
 	git merge blue &&
-	git write-tree >/dev/null || {
-		echo "BAD: merge did not complete"
-		return 1
-	}
-
-	test -f A || {
-		echo "BAD: A does not exist in working directory"
-		return 1
-	}
-	test `cat A` = dirty || {
-		echo "BAD: A content is wrong"
-		return 1
-	}
-	test -f B || {
-		echo "BAD: B does not exist in working directory"
-		return 1
-	}
-	test -f N || {
-		echo "BAD: N does not exist in working directory"
-		return 1
-	}
-	test -f M && {
-		echo "BAD: M still exists in working directory"
-		return 1
-	}
-	return 0
+	git write-tree &&
+	test_path_is_file A &&
+	echo dirty >expect &&
+	test_cmp expect A &&
+	test_path_is_file B &&
+	test_path_is_file N &&
+	test_path_is_missing M
 '
 
 test_done
-- 
2.3.3.520.g3cfbb5d
