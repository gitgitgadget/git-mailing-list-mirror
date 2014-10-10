From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t5304: use helper to report failure of "test foo = bar"
Date: Fri, 10 Oct 2014 02:11:14 -0400
Message-ID: <20141010061114.GB15277@peff.net>
References: <20141010060636.GA15057@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 08:11:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcTQ8-00078N-BJ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 08:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaJJGLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 02:11:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:57075 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbaJJGLP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 02:11:15 -0400
Received: (qmail 28333 invoked by uid 102); 10 Oct 2014 06:11:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 01:11:16 -0500
Received: (qmail 30676 invoked by uid 107); 10 Oct 2014 06:11:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 02:11:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Oct 2014 02:11:14 -0400
Content-Disposition: inline
In-Reply-To: <20141010060636.GA15057@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For small outputs, we sometimes use:

  test "$(some_cmd)" = "something we expect"

instead of a full test_cmp. The downside of this is that
when it fails, there is no output at all from the script.
Let's introduce a small helper to make tests easier to
debug.

Signed-off-by: Jeff King <peff@peff.net>
---
I kind of like the elegance of this, but I'd also be OK with dropping
it. The solution from the third patch does the same thing. And while the
output isn't quite as nice, it magically works for all existing tests,
without having to convert them to use verbose().

I wondered if there was any problem with defining a function with the
same name as a variable ($verbose). A few weeks ago, I would have said
they were completely different namespaces, but after seeing the
shellshock vulnerability I am not so sure. :) This seems to work fine
in bash and dash, but maybe there is some more obscure shell that would
not like it?

Technically this function is the opposite of test_must_fail. We could
call it test_must_succeed, but that is a little wordy for my taste (I
actually considered calling it just v() if we are going to use it a
lot, but that may be going too far).

 t/t5304-prune.sh        | 16 ++++++++--------
 t/test-lib-functions.sh |  9 +++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index b0ffb05..e32e46d 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -13,7 +13,7 @@ add_blob() {
 	before=$(git count-objects | sed "s/ .*//") &&
 	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-chmtime =+0 $BLOB_FILE
 }
@@ -45,11 +45,11 @@ test_expect_success 'prune --expire' '
 
 	add_blob &&
 	git prune --expire=1.hour.ago &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-chmtime =-86500 $BLOB_FILE &&
 	git prune --expire 1.day &&
-	test $before = $(git count-objects | sed "s/ .*//") &&
+	verbose test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
 
 '
@@ -59,11 +59,11 @@ test_expect_success 'gc: implicit prune --expire' '
 	add_blob &&
 	test-chmtime =-$((2*$week-30)) $BLOB_FILE &&
 	git gc &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
 	git gc &&
-	test $before = $(git count-objects | sed "s/ .*//") &&
+	verbose test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
 
 '
@@ -144,7 +144,7 @@ test_expect_success 'gc --no-prune' '
 	test-chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git config gc.pruneExpire 2.days.ago &&
 	git gc --no-prune &&
-	test 1 = $(git count-objects | sed "s/ .*//") &&
+	verbose test 1 = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE
 
 '
@@ -209,10 +209,10 @@ test_expect_success 'gc: prune old objects after local clone' '
 	git clone --no-hardlinks . aclone &&
 	(
 		cd aclone &&
-		test 1 = $(git count-objects | sed "s/ .*//") &&
+		verbose test 1 = $(git count-objects | sed "s/ .*//") &&
 		test_path_is_file $BLOB_FILE &&
 		git gc --prune &&
-		test 0 = $(git count-objects | sed "s/ .*//") &&
+		verbose test 0 = $(git count-objects | sed "s/ .*//") &&
 		test_path_is_missing $BLOB_FILE
 	)
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index dafd6ad..b7957b8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -634,6 +634,15 @@ test_cmp_bin() {
 	cmp "$@"
 }
 
+# Call any command "$@" but be more verbose about its
+# failure. This is handy for commands like "test" which do
+# not output anything when they fail.
+verbose () {
+	"$@" && return 0
+	echo >&2 "command failed: $(git rev-parse --sq-quote "$@")"
+	return 1
+}
+
 # Check if the file expected to be empty is indeed empty, and barfs
 # otherwise.
 
-- 
2.1.2.596.g7379948
