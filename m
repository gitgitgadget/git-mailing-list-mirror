From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t5304: use test_path_is_* instead of "test -f"
Date: Fri, 10 Oct 2014 02:07:00 -0400
Message-ID: <20141010060700.GA15277@peff.net>
References: <20141010060636.GA15057@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 08:07:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcTM3-0005NC-Fp
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 08:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbaJJGHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 02:07:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:57070 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750982AbaJJGHB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 02:07:01 -0400
Received: (qmail 28125 invoked by uid 102); 10 Oct 2014 06:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 01:07:02 -0500
Received: (qmail 30647 invoked by uid 107); 10 Oct 2014 06:07:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 02:07:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Oct 2014 02:07:00 -0400
Content-Disposition: inline
In-Reply-To: <20141010060636.GA15057@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is slightly more robust (checking "! test -f" would not
notice a directory of the same name, though that is not
likely to happen here). It also makes debugging easier, as
the test script will output a message on failure.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5304-prune.sh | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 01c6a3f..b0ffb05 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -14,7 +14,7 @@ add_blob() {
 	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE &&
+	test_path_is_file $BLOB_FILE &&
 	test-chmtime =+0 $BLOB_FILE
 }
 
@@ -35,9 +35,9 @@ test_expect_success 'prune stale packs' '
 	: > .git/objects/tmp_2.pack &&
 	test-chmtime =-86501 .git/objects/tmp_1.pack &&
 	git prune --expire 1.day &&
-	test -f $orig_pack &&
-	test -f .git/objects/tmp_2.pack &&
-	! test -f .git/objects/tmp_1.pack
+	test_path_is_file $orig_pack &&
+	test_path_is_file .git/objects/tmp_2.pack &&
+	test_path_is_missing .git/objects/tmp_1.pack
 
 '
 
@@ -46,11 +46,11 @@ test_expect_success 'prune --expire' '
 	add_blob &&
 	git prune --expire=1.hour.ago &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE &&
+	test_path_is_file $BLOB_FILE &&
 	test-chmtime =-86500 $BLOB_FILE &&
 	git prune --expire 1.day &&
 	test $before = $(git count-objects | sed "s/ .*//") &&
-	! test -f $BLOB_FILE
+	test_path_is_missing $BLOB_FILE
 
 '
 
@@ -60,11 +60,11 @@ test_expect_success 'gc: implicit prune --expire' '
 	test-chmtime =-$((2*$week-30)) $BLOB_FILE &&
 	git gc &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE &&
+	test_path_is_file $BLOB_FILE &&
 	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
 	git gc &&
 	test $before = $(git count-objects | sed "s/ .*//") &&
-	! test -f $BLOB_FILE
+	test_path_is_missing $BLOB_FILE
 
 '
 
@@ -110,7 +110,7 @@ test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 	git commit --allow-empty -m "detached commit" &&
 	# verify that there is no reflogs
 	# (should be removed and disabled by previous test)
-	test ! -e .git/logs &&
+	test_path_is_missing .git/logs &&
 	git prune -n >prune_actual &&
 	: >prune_expected &&
 	test_cmp prune_actual prune_expected
@@ -145,7 +145,7 @@ test_expect_success 'gc --no-prune' '
 	git config gc.pruneExpire 2.days.ago &&
 	git gc --no-prune &&
 	test 1 = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE
+	test_path_is_file $BLOB_FILE
 
 '
 
@@ -153,10 +153,10 @@ test_expect_success 'gc respects gc.pruneExpire' '
 
 	git config gc.pruneExpire 5002.days.ago &&
 	git gc &&
-	test -f $BLOB_FILE &&
+	test_path_is_file $BLOB_FILE &&
 	git config gc.pruneExpire 5000.days.ago &&
 	git gc &&
-	test ! -f $BLOB_FILE
+	test_path_is_missing $BLOB_FILE
 
 '
 
@@ -165,9 +165,9 @@ test_expect_success 'gc --prune=<date>' '
 	add_blob &&
 	test-chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git gc --prune=5002.days.ago &&
-	test -f $BLOB_FILE &&
+	test_path_is_file $BLOB_FILE &&
 	git gc --prune=5000.days.ago &&
-	test ! -f $BLOB_FILE
+	test_path_is_missing $BLOB_FILE
 
 '
 
@@ -175,9 +175,9 @@ test_expect_success 'gc --prune=never' '
 
 	add_blob &&
 	git gc --prune=never &&
-	test -f $BLOB_FILE &&
+	test_path_is_file $BLOB_FILE &&
 	git gc --prune=now &&
-	test ! -f $BLOB_FILE
+	test_path_is_missing $BLOB_FILE
 
 '
 
@@ -186,10 +186,10 @@ test_expect_success 'gc respects gc.pruneExpire=never' '
 	git config gc.pruneExpire never &&
 	add_blob &&
 	git gc &&
-	test -f $BLOB_FILE &&
+	test_path_is_file $BLOB_FILE &&
 	git config gc.pruneExpire now &&
 	git gc &&
-	test ! -f $BLOB_FILE
+	test_path_is_missing $BLOB_FILE
 
 '
 
@@ -197,9 +197,9 @@ test_expect_success 'prune --expire=never' '
 
 	add_blob &&
 	git prune --expire=never &&
-	test -f $BLOB_FILE &&
+	test_path_is_file $BLOB_FILE &&
 	git prune &&
-	test ! -f $BLOB_FILE
+	test_path_is_missing $BLOB_FILE
 
 '
 
@@ -210,10 +210,10 @@ test_expect_success 'gc: prune old objects after local clone' '
 	(
 		cd aclone &&
 		test 1 = $(git count-objects | sed "s/ .*//") &&
-		test -f $BLOB_FILE &&
+		test_path_is_file $BLOB_FILE &&
 		git gc --prune &&
 		test 0 = $(git count-objects | sed "s/ .*//") &&
-		! test -f $BLOB_FILE
+		test_path_is_missing $BLOB_FILE
 	)
 '
 
@@ -250,7 +250,7 @@ test_expect_success 'prune .git/shallow' '
 	grep $SHA1 .git/shallow &&
 	grep $SHA1 out &&
 	git prune &&
-	! test -f .git/shallow
+	test_path_is_missing .git/shallow
 '
 
 test_done
-- 
2.1.2.596.g7379948
