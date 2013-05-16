From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 3/6] test-lib: verbose mode for only tests matching a pattern
Date: Thu, 16 May 2013 22:50:14 +0200
Message-ID: <10e5eacece7fc9657c312b5c51747d23ae9ef40b.1368736093.git.trast@inf.ethz.ch>
References: <cover.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 22:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud58T-00051H-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 22:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab3EPUuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 16:50:32 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41637 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431Ab3EPUuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 16:50:22 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:16 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:18 +0200
X-Mailer: git-send-email 1.8.3.rc2.393.g8636c0b
In-Reply-To: <cover.1368736093.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224619>

With the new --verbose-only=<pattern> option, one can enable --verbose
at a per-test granularity.  The pattern is matched against the test
number, e.g.

  ./t0000-basic.sh --verbose-only='2[0-2]'

to see only the full output of test 20-22, while showing the rest in the
one-liner format.

This is arguably not *too* useful on its own, but makes the next patch
easier to follow.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/README      |  5 +++++
 t/test-lib.sh | 29 +++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index e669bb3..9c8f9b1 100644
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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c5a80d1..01e7445 100644
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
@@ -342,6 +345,24 @@ match_pattern_list () {
 	return 1
 }
 
+toggle_verbose () {
+	test -z "$verbose_only" && return
+	if match_pattern_list $test_count $verbose_only
+	then
+		exec 4>&2 3>&1
+	else
+		exec 4>/dev/null 3>/dev/null
+	fi
+}
+
+setup_test_eval () {
+	setup_malloc_check
+	toggle_verbose
+}
+teardown_test_eval () {
+	teardown_malloc_check
+}
+
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
@@ -351,16 +372,16 @@ test_eval_ () {
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
-	setup_malloc_check
+	setup_test_eval
 	test_eval_ "$1"
 	eval_ret=$?
-	teardown_malloc_check
+	teardown_test_eval
 
 	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
 	then
-		setup_malloc_check
+		setup_test_eval
 		test_eval_ "$test_cleanup"
-		teardown_malloc_check
+		teardown_test_eval
 	fi
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
 	then
-- 
1.8.3.rc2.393.g8636c0b
