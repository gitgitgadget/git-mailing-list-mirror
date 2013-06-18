From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v3 4/8] test-lib: self-test that --verbose works
Date: Tue, 18 Jun 2013 14:26:00 +0200
Message-ID: <81378a78ec46f876a2b426be99cbb6c3f85498f9.1371557431.git.trast@inf.ethz.ch>
References: <cover.1371557431.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:26:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uouzf-00086N-PI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224Ab3FRM0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:26:34 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42506 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755453Ab3FRM0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:26:17 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:11 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.157) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:15 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371557431.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228219>

t0000 contains some light self-tests of test-lib.sh, but --verbose was
not covered.  Add a test.

The only catch is that the presence of a test harness influences the
output (specifically, the presence of some empty lines).  The easiest
fix is to unset TEST_HARNESS for the sub-test scripts.  This means
that we no longer check whether test-lib.sh works under the harness;
however, since running everything under 'prove' seems far more common
than the esoteric --verbose-only feature introduced in the next
commit, this seems the smaller risk.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/t0000-basic.sh | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index cefe33d..b568c06 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -47,8 +47,10 @@ test_expect_failure 'pretend we have a known breakage' '
 
 run_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
+	shift 2
 	mkdir "$name" &&
 	(
+		unset HARNESS_ACTIVE
 		cd "$name" &&
 		cat >"$name.sh" <<-EOF &&
 		#!$SHELL_PATH
@@ -65,7 +67,7 @@ run_sub_test_lib_test () {
 		cat >>"$name.sh" &&
 		chmod +x "$name.sh" &&
 		export TEST_DIRECTORY &&
-		./"$name.sh" >out 2>err
+		./"$name.sh" "$@" >out 2>err
 	)
 }
 
@@ -215,6 +217,30 @@ test_expect_success 'pretend we have a mix of all possible results' "
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
+	check_sub_test_lib_test test-verbose <<-\EOF
+	> expecting success: true
+	> ok 1 - passing test
+	>
+	> expecting success: echo foo
+	> foo
+	>
+	> ok 2 - test with output
+	> expecting success: false
+	> not ok 3 - failing test
+	> #	false
+	> # failed 1 among 3 test(s)
+	> 1..3
+	EOF
+'
+
 test_set_prereq HAVEIT
 haveit=no
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
-- 
1.8.3.1.530.g6f90e57
