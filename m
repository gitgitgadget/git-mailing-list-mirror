From: Jeff King <peff@peff.net>
Subject: [PATCH 01/25] t/test-lib: introduce --chain-lint option
Date: Fri, 20 Mar 2015 06:05:48 -0400
Message-ID: <20150320100548.GA12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:06:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtoS-00084e-4M
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbbCTKFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:05:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:35665 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751987AbbCTKFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:05:51 -0400
Received: (qmail 5545 invoked by uid 102); 20 Mar 2015 10:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:05:51 -0500
Received: (qmail 21396 invoked by uid 107); 20 Mar 2015 10:06:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:06:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:05:48 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265875>

It's easy to miss an "&&"-chain in a test script, like:

  test_expect_success 'check something important' '
	cmd1 &&
	cmd2
	cmd3
  '

The test harness will notice if cmd3 fails, but a failure of
cmd1 or cmd2 will go unnoticed, as their exit status is lost
after cmd3 runs.

The toy example above is easy to spot because the "cmds" are
all the same length, but real code is much more complicated.
It's also difficult to detect these situations by statically
analyzing the shell code with regexps (like the
check-non-portable-shell script does); there's too much
context required to know whether a &&-chain is appropriate
on a given line or not.

This patch instead lets the shell check each test by
sticking a command with a specific and unusual return code
at the top of each test, like:

  (exit 117) &&
  cmd1 &&
  cmd2
  cmd3

In a well-formed test, the non-zero exit from the first
command prevents any of the rest from being run, and the
test's exit code is 117. In a bad test (like the one above),
the 117 is lost, and cmd3 is run.

When we encounter a failure of this check, we abort the test
script entirely. For one thing, we have no clue which subset
of the commands in the test snippet were actually run.
Running further tests would be pointless, because we're now
in an unknown state. And two, this is not a "test failure"
in the traditional sense. The test script is buggy, not the
code it is testing. We should be able to fix these problems
in the script once, and not have them come back later as a
regression in git's code.

After checking a test snippet for --chain-lint, we do still
run the test itself.  We could actually have a pure-lint
mode which just checks each test, but there are a few
reasons not to. One, because the tests are executing
arbitrary code, which could impact the later environment
(e.g., that could impact which set of tests we run at all).
And two, because a pure-lint mode would still be expensive
to run, because a significant amount of code runs outside of
the test_expect_* blocks.  Instead, this option is designed
to be used as part of a normal test suite run, where it adds
very little overhead.

Turning on this option detects quite a few problems in
existing tests, which will be fixed in subsequent patches.
However, there are a number of places it cannot reach:

 - it cannot find a failure to break out of loops on error,
   like:

     cmd1 &&
     for i in a b c; do
	     cmd2 $i
     done &&
     cmd3

   which will not notice failures of "cmd2 a" or "cmd b"

 - it cannot find a missing &&-chain inside a block or
   subfunction, like:

     foo () {
	     cmd1
	     cmd2
     }

     foo &&
     bar

   which will not notice a failure of cmd1.

 - it only checks tests that you run; every platform will
   have some tests skipped due to missing prequisites,
   so it's impossible to say from one run that the test
   suite is free of broken &&-chains. However, all tests get
   run by _somebody_, so eventually we will notice problems.

 - it does not operate on test_when_finished or prerequisite
   blocks. It could, but these tends to be much shorter and
   less of a problem, so I punted on them in this patch.

This patch was inspired by an earlier patch by Jonathan
Nieder:

  http://article.gmane.org/gmane.comp.version-control.git/235913

This implementation and all bugs are mine.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/README      | 10 ++++++++++
 t/test-lib.sh | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/t/README b/t/README
index d5bb0c9..35438bc 100644
--- a/t/README
+++ b/t/README
@@ -168,6 +168,16 @@ appropriately before running "make".
 	Using this option with a RAM-based filesystem (such as tmpfs)
 	can massively speed up the test suite.
 
+--chain-lint::
+--no-chain-lint::
+	If --chain-lint is enabled, the test harness will check each
+	test to make sure that it properly "&&-chains" all commands (so
+	that a failure in the middle does not go unnoticed by the final
+	exit code of the test). This check is performed in addition to
+	running the tests themselves. You may also enable or disable
+	this feature by setting the GIT_TEST_CHAIN_LINT environment
+	variable to "1" or "0", respectively.
+
 You can also set the GIT_TEST_INSTALLED environment variable to
 the bindir of an existing git installation to test that installation.
 You still need to have built this git sandbox, from which various
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c096778..50b3d3f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -232,6 +232,12 @@ do
 	--root=*)
 		root=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
+	--chain-lint)
+		GIT_TEST_CHAIN_LINT=1
+		shift ;;
+	--no-chain-lint)
+		GIT_TEST_CHAIN_LINT=0
+		shift ;;
 	-x)
 		trace=t
 		verbose=t
@@ -524,6 +530,16 @@ test_eval_ () {
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
+
+	if test "${GIT_TEST_CHAIN_LINT:-0}" != 0; then
+		# 117 is magic because it is unlikely to match the exit
+		# code of other programs
+		test_eval_ "(exit 117) && $1"
+		if test "$?" != 117; then
+			error "bug in the test script: broken &&-chain: $1"
+		fi
+	fi
+
 	setup_malloc_check
 	test_eval_ "$1"
 	eval_ret=$?
-- 
2.3.3.520.g3cfbb5d
