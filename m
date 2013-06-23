From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v4 4/8] test-lib: self-test that --verbose works
Date: Sun, 23 Jun 2013 20:12:55 +0200
Message-ID: <9c6ca931db165476d6fb449632884f6515b0840f.1372010917.git.trast@inf.ethz.ch>
References: <cover.1372010917.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 20:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqonK-0007pi-6b
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 20:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab3FWSNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 14:13:34 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39655 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab3FWSNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 14:13:06 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 20:12:47 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 20:13:01 +0200
X-Mailer: git-send-email 1.8.3.1.727.gcbe3af3
In-Reply-To: <cover.1372010917.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228751>

t0000 contains some light self-tests of test-lib.sh, but --verbose was
not covered.  Add a test.

The only catch is that the presence of a test harness influences the
output (specifically, the presence of some empty lines).  So we need
to unset TEST_HARNESS or set it to a known value.  Leaving it unset
leads to spurious test failures in the final summary, which come from
the subtest.  So we always set it.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/t0000-basic.sh | 37 ++++++++++++++++++++++++++++++++++++-
 t/test-lib.sh    |  2 ++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 0f13180..4b4103f 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -47,8 +47,13 @@ test_expect_failure 'pretend we have a known breakage' '
 
 run_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
+	shift 2
 	mkdir "$name" &&
 	(
+		# Pretend we're a test harness.  This prevents
+		# test-lib from writing the counts to a file that will
+		# later be summarized, showing spurious "failed" tests
+		export HARNESS_ACTIVE=t &&
 		cd "$name" &&
 		cat >"$name.sh" <<-EOF &&
 		#!$SHELL_PATH
@@ -65,7 +70,7 @@ run_sub_test_lib_test () {
 		cat >>"$name.sh" &&
 		chmod +x "$name.sh" &&
 		export TEST_DIRECTORY &&
-		./"$name.sh" >out 2>err
+		./"$name.sh" "$@" >out 2>err
 	)
 }
 
@@ -215,6 +220,36 @@ test_expect_success 'pretend we have a mix of all possible results' "
 	EOF
 "
 
+test_expect_success 'test --verbose' '
+	test_must_fail run_sub_test_lib_test \
+		test-verbose "test verbose" --verbose <<-\EOF &&
+	test_expect_success "passing test" true
+	test_expect_success "test with output" "echo foo"
+	test_expect_success "failing test" false
+	test_done
+	EOF
+	mv test-verbose/out test-verbose/out+
+	grep -v "^Initialized empty" test-verbose/out+ >test-verbose/out &&
+	check_sub_test_lib_test test-verbose <<-\EOF
+	> expecting success: true
+	> Z
+	> ok 1 - passing test
+	> Z
+	> expecting success: echo foo
+	> foo
+	> Z
+	> ok 2 - test with output
+	> Z
+	> expecting success: false
+	> Z
+	> not ok 3 - failing test
+	> #	false
+	> Z
+	> # failed 1 among 3 test(s)
+	> 1..3
+	EOF
+'
+
 test_set_prereq HAVEIT
 haveit=no
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e99b0ea..10827a4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -414,6 +414,8 @@ test_at_end_hook_ () {
 test_done () {
 	GIT_EXIT_OK=t
 
+	# Note: t0000 relies on $HARNESS_ACTIVE disabling the .counts
+	# output file
 	if test -z "$HARNESS_ACTIVE"
 	then
 		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
-- 
1.8.3.1.727.gcbe3af3
