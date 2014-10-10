From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] test-lib.sh: support -x option for shell-tracing
Date: Fri, 10 Oct 2014 02:13:56 -0400
Message-ID: <20141010061355.GC15277@peff.net>
References: <20141010060636.GA15057@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 08:14:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcTSj-00080b-OG
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 08:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbaJJGN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 02:13:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:57082 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbaJJGN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 02:13:57 -0400
Received: (qmail 28427 invoked by uid 102); 10 Oct 2014 06:13:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 01:13:57 -0500
Received: (qmail 30694 invoked by uid 107); 10 Oct 2014 06:13:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 02:13:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Oct 2014 02:13:56 -0400
Content-Disposition: inline
In-Reply-To: <20141010060636.GA15057@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Usually running a test under "-v" makes it clear which
command is failing. However, sometimes it can be useful to
also see a complete trace of the shell commands being run in
the test. You can do so without any support from the test
suite by running "sh -x tXXXX-foo.sh". However, this
produces quite a large bit of output, as we see a trace of
the entire test suite.

This patch instead introduces a "-x" option to the test
scripts (i.e., "./tXXXX-foo.sh -x"). When enabled, this
turns on "set -x" only for the tests themselves. This can
still be a bit verbose, but should keep things to a more
manageable level. You can even use "--verbose-only" to see
the trace only for a specific test.

The implementation is a little invasive. We turn on the "set
-x" inside the "eval" of the test code. This lets the eval
itself avoid being reported in the trace (which would be
long, and redundant with the verbose listing we already
showed). And then after the eval runs, we do some trickery
with stderr to avoid showing the "set +x" to the user.

We also show traces for test_cleanup functions (since they
can impact the test outcome, too). However, we do avoid
running the noop ":" cleanup (the default if the test does
not use test_cleanup at all), as it creates unnecessary
noise in the "set -x" output.

Signed-off-by: Jeff King <peff@peff.net>
---
Having finally figured out how to drop the "set +x" from the output, I
have noticed that I kind of liked the "test_eval_ret=$?" part of the
trace (which is now gone, too), because it pretty explicitly tells you
that the last traced command failed. But now that it has been silenced,
there's no reason we couldn't add back in our own output to make it more
clear.

 t/README      |  4 ++++
 t/test-lib.sh | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 52c77ae..38cb078 100644
--- a/t/README
+++ b/t/README
@@ -82,6 +82,10 @@ appropriately before running "make".
 	numbers matching <pattern>.  The number matched against is
 	simply the running count of the test within the file.
 
+-x::
+	Turn on shell tracing (i.e., `set -x`) during the tests
+	themselves. Implies `--verbose`.
+
 -d::
 --debug::
 	This may help the person who is developing a new test.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 82095e3..a60ec75 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -187,6 +187,8 @@ export _x05 _x40 _z40 LF
 	) &&
 	color=t
 
+test_eval_start_=
+test_eval_end_=
 while test "$#" -ne 0
 do
 	case "$1" in
@@ -233,6 +235,11 @@ do
 	--root=*)
 		root=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
+	-x)
+		test_eval_start_='set -x'
+		test_eval_end_='set +x'
+		verbose=t
+		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -517,10 +524,28 @@ maybe_setup_valgrind () {
 	fi
 }
 
+# This is a separate function because some tests use
+# "return" to end a test_expect_success block early
+# (and we want to make sure we run any $test_eval_end_).
+test_eval_inner_ () {
+	eval "$test_eval_start_ $*"
+}
+
 test_eval_ () {
-	# This is a separate function because some tests use
-	# "return" to end a test_expect_success block early.
-	eval </dev/null >&3 2>&4 "$*"
+	# We run this block with stderr redirected to avoid extra cruft
+	# during a "-x" trace. Once in "set -x" mode, we cannot prevent
+	# the shell from printing the "set +x" to turn it off (nor the saving
+	# of $? before that). But we can make sure that the output goes to
+	# /dev/null.
+	#
+	# The test itself is run with stderr put back to &4 (so either to
+	# /dev/null, or to the original stderr if --verbose was used).
+	{
+		test_eval_inner_ "$@" </dev/null >&3 2>&4
+		test_eval_ret_=$?
+		$test_eval_end_
+	} 2>/dev/null
+	return $test_eval_ret_
 }
 
 test_run_ () {
@@ -531,7 +556,8 @@ test_run_ () {
 	eval_ret=$?
 	teardown_malloc_check
 
-	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
+	if test -z "$immediate" || test $eval_ret = 0 ||
+	   test -n "$expecting_failure" && test "$test_cleanup" != ":"
 	then
 		setup_malloc_check
 		test_eval_ "$test_cleanup"
-- 
2.1.2.596.g7379948
