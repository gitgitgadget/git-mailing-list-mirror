From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2 3/6] test-lib: verbose mode for only tests matching a pattern
Date: Mon, 17 Jun 2013 11:18:48 +0200
Message-ID: <8739d3ba5947c60d402030fc35d47115e7a51b0f.1371460265.git.trast@inf.ethz.ch>
References: <cover.1371460265.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 17 11:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoVav-0004qy-TX
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 11:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012Ab3FQJTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 05:19:19 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:40405 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755905Ab3FQJS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 05:18:57 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 17 Jun
 2013 11:18:50 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 17 Jun
 2013 11:18:52 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371460265.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228057>

With the new --verbose-only=<pattern> option, one can enable --verbose
at a per-test granularity.  The pattern is matched against the test
number, e.g.

  ./t0000-basic.sh --verbose-only='2[0-2]'

to see only the full output of test 20-22, while showing the rest in the
one-liner format.

As suggested by Jeff King, this takes care to wrap the entire test_expect_*
block, but nothing else, in the verbose toggling.  To that end we use
a new pair of hook functions.  The placement is a bit weird because we
need to wait until the beginning of test_skip for $test_count to be
incremented.

This is arguably not *too* useful on its own, but makes the next patch
easier to follow.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/README                |  5 +++++
 t/test-lib-functions.sh |  2 ++
 t/test-lib.sh           | 44 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index 35b3c5c..f4e6299 100644
--- a/t/README
+++ b/t/README
@@ -76,6 +76,11 @@ appropriately before running "make".
 	command being run and their output if any are also
 	output.
 
+--verbose-only=<pattern>::
+	Like --verbose, but the effect is limited to tests with
+	numbers matching <pattern>.  The number matched against is
+	simply the running count of the test within the file.
+
 --debug::
 	This may help the person who is developing a new test.
 	It causes the command defined with test_debug to run.
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5251009..0eac1dd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -358,6 +358,7 @@ test_expect_failure () {
 		fi
 	fi
 	echo >&3 ""
+	test_teardown_hook_
 }
 
 test_expect_success () {
@@ -376,6 +377,7 @@ test_expect_success () {
 		fi
 	fi
 	echo >&3 ""
+	test_teardown_hook_
 }
 
 # test_external runs external test scripts that provide continuous
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d9a74ff..84e5f03 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -184,6 +184,9 @@ do
 		help=t; shift ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=t; shift ;;
+	--verbose-only=*)
+		verbose_only=$(expr "z$1" : 'z[^=]*=\(.*\)')
+		shift ;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		# Ignore --quiet under a TAP::Harness. Saying how many tests
 		# passed without the ok/not ok details is always an error.
@@ -342,6 +345,44 @@ match_pattern_list () {
 	return 1
 }
 
+maybe_teardown_verbose () {
+	test -z "$verbose_only" && return
+	exec 4>/dev/null 3>/dev/null
+	verbose=
+}
+
+last_verbose=t
+maybe_setup_verbose () {
+	test -z "$verbose_only" && return
+	if match_pattern_list $test_count $verbose_only
+	then
+		exec 4>&2 3>&1
+		# Emit a delimiting blank line when going from
+		# non-verbose to verbose.  Within verbose mode the
+		# delimiter is printed by test_expect_*.  The choice
+		# of the initial $last_verbose is such that before
+		# test 1, we do not print it.
+		test -z "$last_verbose" && echo >&3 ""
+		verbose=t
+	else
+		exec 4>/dev/null 3>/dev/null
+		verbose=
+	fi
+	last_verbose=$verbose
+}
+
+# Called from test_skip after it has incremented $test_count.  This
+# means it runs before any test-specific code and output.
+test_setup_hook_ () {
+	maybe_setup_verbose
+}
+
+# Called at the end of test_expect_*.  This means it runs after all
+# test-specific code and output.
+test_teardown_hook_ () {
+	maybe_teardown_verbose
+}
+
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
@@ -358,9 +399,7 @@ test_run_ () {
 
 	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
 	then
-		setup_malloc_check
 		test_eval_ "$test_cleanup"
-		teardown_malloc_check
 	fi
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
 	then
@@ -372,6 +411,7 @@ test_run_ () {
 test_skip () {
 	test_count=$(($test_count+1))
 	to_skip=
+	test_setup_hook_
 	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
 	then
 		to_skip=t
-- 
1.8.3.1.530.g6f90e57
