From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t0000: simplify HARNESS_ACTIVE hack
Date: Sat, 28 Dec 2013 04:31:49 -0500
Message-ID: <20131228093149.GB21109@sigill.intra.peff.net>
References: <20131228092731.GA26337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 28 10:31:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwqFQ-0000as-WA
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 10:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab3L1Jbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 04:31:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:51494 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752494Ab3L1Jbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 04:31:51 -0500
Received: (qmail 984 invoked by uid 102); 28 Dec 2013 09:31:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Dec 2013 03:31:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Dec 2013 04:31:49 -0500
Content-Disposition: inline
In-Reply-To: <20131228092731.GA26337@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239763>

Commit 517cd55 set HARNESS_ACTIVE unconditionally in
sub-tests, because that value affects the output of
"--verbose". t0000 needs stable output from its sub-tests,
and we may or may not be running under a TAP harness.

That commit made the decision to always set the variable,
since it has another useful side effect, which is
suppressing writes to t/test-results by the sub-tests (which
would just pollute the real results).

Since the last commit, though, the sub-tests have their own
test-results directories, so this is no longer an issue. We
can now update a few comments that are no longer accurate
nor necessary.

We can also revisit the choice of HARNESS_ACTIVE. Since we
must choose one value for stability, it's probably saner to
have it off. This means that future patches could test
things like the test-results writing, or the "--quiet"
option, which is currently ignored when run under a harness.

Signed-off-by: Jeff King <peff@peff.net>
---
I do not have any plans to write such tests, and I'd be OK if we wanted
to stop this just at fixing up the comments. But it took me a while to
figure out what is going on, and I believe unsetting HARNESS_ACTIVE in
the sub-tests is the choice that is least likely to cause somebody in
the future to have to re-figure it out. :)

 t/t0000-basic.sh | 14 +++++---------
 t/test-lib.sh    |  2 --
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index bc4e3e2..e6c5b63 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -50,11 +50,11 @@ run_sub_test_lib_test () {
 	shift 2
 	mkdir "$name" &&
 	(
-		# Pretend we're a test harness.  This prevents
-		# test-lib from writing the counts to a file that will
-		# later be summarized, showing spurious "failed" tests
-		HARNESS_ACTIVE=t &&
-		export HARNESS_ACTIVE &&
+		# Pretend we're not running under a test harness, whether we
+		# are or not. The test-lib output depends on the setting of
+		# this variable, so we need a stable setting under which to run
+		# the sub-test.
+		sane_unset HARNESS_ACTIVE &&
 		cd "$name" &&
 		cat >"$name.sh" <<-EOF &&
 		#!$SHELL_PATH
@@ -235,16 +235,13 @@ test_expect_success 'test --verbose' '
 	grep -v "^Initialized empty" test-verbose/out+ >test-verbose/out &&
 	check_sub_test_lib_test test-verbose <<-\EOF
 	> expecting success: true
-	> Z
 	> ok 1 - passing test
 	> Z
 	> expecting success: echo foo
 	> foo
-	> Z
 	> ok 2 - test with output
 	> Z
 	> expecting success: false
-	> Z
 	> not ok 3 - failing test
 	> #	false
 	> Z
@@ -267,7 +264,6 @@ test_expect_success 'test --verbose-only' '
 	> Z
 	> expecting success: echo foo
 	> foo
-	> Z
 	> ok 2 - test with output
 	> Z
 	> not ok 3 - failing test
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1cf78d5..1531c24 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -481,8 +481,6 @@ test_at_end_hook_ () {
 test_done () {
 	GIT_EXIT_OK=t
 
-	# Note: t0000 relies on $HARNESS_ACTIVE disabling the .counts
-	# output file
 	if test -z "$HARNESS_ACTIVE"
 	then
 		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
-- 
1.8.5.1.399.g900e7cd
