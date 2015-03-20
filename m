From: Jeff King <peff@peff.net>
Subject: [PATCH 09/25] t: use test_might_fail for diff and grep
Date: Fri, 20 Mar 2015 06:11:32 -0400
Message-ID: <20150320101132.GI12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:11:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYttz-0004N2-CD
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbbCTKLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:11:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:35691 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751150AbbCTKLe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:11:34 -0400
Received: (qmail 5792 invoked by uid 102); 20 Mar 2015 10:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:11:34 -0500
Received: (qmail 21540 invoked by uid 107); 20 Mar 2015 10:11:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:11:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:11:32 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265883>

Some tests run diff or grep to produce an output, and then
compare the output to an expected value. We know the exit
code we expect these processes to have (e.g., grep yields 0
if it produced output and 1 otherwise), so it would not make
the test wrong to look for it. But the difference between
their output and the expected output (e.g., shown by
test_cmp) is much more useful to somebody debugging the test
than the test just bailing out.

These tests break the &&-chain to skip the exit-code check
of the process. However, we can get the same effect by using
test_might_fail. Note that in some cases the test did use
"|| return 1", which meant the test was not wrong, but it
did fool --chain-lint.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1002-read-tree-m-u-2way.sh | 8 ++++----
 t/t5550-http-fetch-dumb.sh    | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index fed877b..e3bf821 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -75,8 +75,8 @@ test_expect_success \
      echo yomin >yomin &&
      git update-index --add yomin &&
      read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >4.out || return 1
-     git diff -U0 --no-index M.out 4.out >4diff.out
+     git ls-files --stage >4.out &&
+     test_might_fail git diff -U0 --no-index M.out 4.out >4diff.out &&
      compare_change 4diff.out expected &&
      check_cache_at yomin clean &&
      sum bozbar frotz nitfol >actual4.sum &&
@@ -94,8 +94,8 @@ test_expect_success \
      git update-index --add yomin &&
      echo yomin yomin >yomin &&
      read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >5.out || return 1
-     git diff -U0 --no-index M.out 5.out >5diff.out
+     git ls-files --stage >5.out &&
+     test_might_fail git diff -U0 --no-index M.out 5.out >5diff.out &&
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty &&
      sum bozbar frotz nitfol >actual5.sum &&
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 61e087e..3d11b7a 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -184,8 +184,8 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
 '
 
 test_expect_success 'did not use upload-pack service' '
-	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act
-	: >exp
+	test_might_fail grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act &&
+	: >exp &&
 	test_cmp exp act
 '
 
-- 
2.3.3.520.g3cfbb5d
