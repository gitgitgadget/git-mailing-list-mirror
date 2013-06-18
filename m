From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v3 5/8] test-lib: verbose mode for only tests matching a pattern
Date: Tue, 18 Jun 2013 14:26:01 +0200
Message-ID: <a48122be29cc9088cc0aa388e9148bc62c1712dd.1371557431.git.trast@inf.ethz.ch>
References: <cover.1371557431.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:26:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouzT-0007cU-0x
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab3FRM0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:26:22 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:19103 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755794Ab3FRM0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:26:18 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:15 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.157) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:16 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371557431.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228218>

With the new --verbose-only=<pattern> option, one can enable --verbose
at a per-test granularity.  The pattern is matched against the test
number, e.g.

  ./t0000-basic.sh --verbose-only='2[0-2]'

to see only the full output of test 20-22, while showing the rest in the
one-liner format.

As suggested by Jeff King, this takes care to wrap the entire
test_expect_* block, but nothing else, in the verbose toggling.  We
can use the test_start/end functions from the previous commit for the
purpose.

This is arguably not *too* useful on its own, but makes the next patch
easier to follow.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/README         |  5 +++++
 t/t0000-basic.sh | 30 ++++++++++++++++++++++++++++--
 t/test-lib.sh    | 31 +++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

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
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b568c06..0d86039 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -225,17 +225,43 @@ test_expect_success 'test --verbose' '
 	test_expect_success "failing test" false
 	test_done
 	EOF
+	mv test-verbose/out test-verbose/out+
+	grep -v "^Initialized empty" test-verbose/out+ >test-verbose/out &&
 	check_sub_test_lib_test test-verbose <<-\EOF
 	> expecting success: true
 	> ok 1 - passing test
-	>
+	> Z
 	> expecting success: echo foo
 	> foo
-	>
 	> ok 2 - test with output
+	> Z
 	> expecting success: false
 	> not ok 3 - failing test
 	> #	false
+	> Z
+	> # failed 1 among 3 test(s)
+	> 1..3
+	EOF
+'
+
+test_expect_success 'test --verbose-only' '
+	test_must_fail run_sub_test_lib_test \
+		test-verbose-only-2 "test verbose-only=2" \
+		--verbose-only=2 <<-\EOF &&
+	test_expect_success "passing test" true
+	test_expect_success "test with output" "echo foo"
+	test_expect_success "failing test" false
+	test_done
+	EOF
+	check_sub_test_lib_test test-verbose-only-2 <<-\EOF
+	> ok 1 - passing test
+	> Z
+	> expecting success: echo foo
+	> foo
+	> ok 2 - test with output
+	> Z
+	> not ok 3 - failing test
+	> #	false
 	> # failed 1 among 3 test(s)
 	> 1..3
 	EOF
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e99b0ea..2bceb92 100644
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
@@ -342,6 +345,32 @@ match_pattern_list () {
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
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
@@ -371,10 +400,12 @@ test_run_ () {
 
 test_start_ () {
 	test_count=$(($test_count+1))
+	maybe_setup_verbose
 }
 
 test_finish_ () {
 	echo >&3 ""
+	maybe_teardown_verbose
 }
 
 test_skip () {
-- 
1.8.3.1.530.g6f90e57
