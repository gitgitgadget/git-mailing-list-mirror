From: Jeff King <peff@peff.net>
Subject: [PATCH 08/16] t5304: use helper to report failure of "test foo = bar"
Date: Fri, 3 Oct 2014 16:27:43 -0400
Message-ID: <20141003202743.GH16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9SB-0000eZ-PG
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbaJCU1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:27:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:54838 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753578AbaJCU1q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:27:46 -0400
Received: (qmail 2975 invoked by uid 102); 3 Oct 2014 20:27:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:27:45 -0500
Received: (qmail 15063 invoked by uid 107); 3 Oct 2014 20:27:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:27:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:27:43 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257859>

For small outputs, we sometimes use:

  test "$(some_cmd)" = "something we expect"

instead of a full test_cmp. The downside of this is that
when it fails, there is no output at all from the script.
Let's introduce a small helper to make tests easier to
debug.

Signed-off-by: Jeff King <peff@peff.net>
---
This is in the same boat as the last commit; we can drop it without
hurting the rest of the series.

Is test_eq too cutesy or obfuscated? I have often wanted it when
debugging other tests, too. Our usual technique is to do:

  echo whatever >expect &&
  do_something >actual &&
  test_cmp expect actual

That's a bit verbose. We could hide it behind something like test_eq,
too, but it introduces several extra new processes. And I know people on
some fork-challenged platforms are very sensitive to the number of
spawned processes in the test suite.

 t/t5304-prune.sh        | 16 ++++++++--------
 t/test-lib-functions.sh | 11 +++++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index b0ffb05..502860e 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -13,7 +13,7 @@ add_blob() {
 	before=$(git count-objects | sed "s/ .*//") &&
 	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test_eq $((1 + $before)) $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-chmtime =+0 $BLOB_FILE
 }
@@ -45,11 +45,11 @@ test_expect_success 'prune --expire' '
 
 	add_blob &&
 	git prune --expire=1.hour.ago &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test_eq $((1 + $before)) $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-chmtime =-86500 $BLOB_FILE &&
 	git prune --expire 1.day &&
-	test $before = $(git count-objects | sed "s/ .*//") &&
+	test_eq $before $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
 
 '
@@ -59,11 +59,11 @@ test_expect_success 'gc: implicit prune --expire' '
 	add_blob &&
 	test-chmtime =-$((2*$week-30)) $BLOB_FILE &&
 	git gc &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test_eq $((1 + $before)) $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
 	git gc &&
-	test $before = $(git count-objects | sed "s/ .*//") &&
+	test_eq $before $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
 
 '
@@ -144,7 +144,7 @@ test_expect_success 'gc --no-prune' '
 	test-chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git config gc.pruneExpire 2.days.ago &&
 	git gc --no-prune &&
-	test 1 = $(git count-objects | sed "s/ .*//") &&
+	test_eq 1 $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE
 
 '
@@ -209,10 +209,10 @@ test_expect_success 'gc: prune old objects after local clone' '
 	git clone --no-hardlinks . aclone &&
 	(
 		cd aclone &&
-		test 1 = $(git count-objects | sed "s/ .*//") &&
+		test_eq 1 $(git count-objects | sed "s/ .*//") &&
 		test_path_is_file $BLOB_FILE &&
 		git gc --prune &&
-		test 0 = $(git count-objects | sed "s/ .*//") &&
+		test_eq 0 $(git count-objects | sed "s/ .*//") &&
 		test_path_is_missing $BLOB_FILE
 	)
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index dafd6ad..0a17614 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -634,6 +634,17 @@ test_cmp_bin() {
 	cmp "$@"
 }
 
+# This is the same as 'test "$1" $3 "$2"' except that it
+# will output a useful message to stderr on failure. If
+# $3 is omitted, defaults to "=".
+test_eq () {
+	if ! test "$1" "${3:-=}" "$2"
+	then
+		echo >&2 "test_eq failed: $1 ${3:-=} $2"
+		false
+	fi
+}
+
 # Check if the file expected to be empty is indeed empty, and barfs
 # otherwise.
 
-- 
2.1.1.566.gdb1f904
