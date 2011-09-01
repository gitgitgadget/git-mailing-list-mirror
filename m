From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] test-lib: save test counts across invocations
Date: Thu, 1 Sep 2011 15:08:45 +0200
Message-ID: <8fe5381a6b69079b8c20452fd4d99a128764dd52.1314882443.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 01 15:08:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz70p-0006p7-1y
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 15:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449Ab1IANIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 09:08:49 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:24817 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757283Ab1IANIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 09:08:48 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 1 Sep
 2011 15:08:49 +0200
Received: from localhost.localdomain (129.132.153.219) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 1 Sep
 2011 15:08:51 +0200
X-Mailer: git-send-email 1.7.7.rc0.420.g468b7
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180530>

Under 'prove' we can get progress status for tests running in
parallel.  However we never told it the total number of tests in a
file in advance, and thus the progress only showed the tests already
executed.

Save the number of tests run ($test_count) in a file under
test-counts/.  Then when sourcing test-lib.sh the next time, compare
the timestamps.  If the counts file is older than the test, discard.
Otherwise use the count that we saved and give prove the test plan
("1..N") up front.

This results in 'make prove' giving progress output like

  ===(    2884;121   8/12   24/147  1/8  1/3  )============================

if you have already run the tests before.

Prerequisite changes can mean that a whole test group is skipped
(e.g. NO_SVN_TESTS=1).  We thus need to be somewhat careful to only
emit the "full" plan once we know we're not going to $skip_all.

t9700 needs special treatment on top of $test_external_has_tap because
the latter can only be set once we know that the external test will
run.  If a prerequisite fails, we still need to emit the plan.

The Makefile changes are required because we want to keep that
test-count subdirectory unless the *user* invokes 'make clean', but we
previously ran the latter ourselves after every successful test run.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Sparked by a discussion on G+.  I think this is the "simple" approach.
The "cute" approach would be to let test-lib.sh define test_* as
test-counting dummies once, source the test script itself (avoiding
the sourcing loop with test-lib) to count what it does, then do the
real work.


 t/.gitignore        |    1 +
 t/Makefile          |    9 ++++++---
 t/t9700-perl-git.sh |    1 +
 t/test-lib.sh       |   27 +++++++++++++++++++++++++--
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index 4e731dc..7de845f 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1,3 +1,4 @@
 /trash directory*
 /test-results
+/test-counts
 /.prove
diff --git a/t/Makefile b/t/Makefile
index 9046ec9..c70de07 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -36,11 +36,14 @@ $(T):
 pre-clean:
 	$(RM) -r test-results
 
-clean:
+post-clean:
 	$(RM) -r 'trash directory'.* test-results
 	$(RM) -r valgrind/bin
 	$(RM) .prove
 
+clean: post-clean
+	$(RM) -r test-counts
+
 test-lint: test-lint-duplicates test-lint-executable
 
 test-lint-duplicates:
@@ -55,7 +58,7 @@ test-lint-executable:
 
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
-	$(MAKE) clean
+	$(MAKE) post-clean
 
 aggregate-results:
 	for f in test-results/t*-*.counts; do \
@@ -111,4 +114,4 @@ smoke_report: smoke
 		http://smoke.git.nix.is/app/projects/process_add_report/1 \
 	| grep -v ^Redirecting
 
-.PHONY: pre-clean $(T) aggregate-results clean valgrind smoke smoke_report
+.PHONY: pre-clean $(T) aggregate-results clean valgrind smoke smoke_report post-clean
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 3787186..20ec097 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -4,6 +4,7 @@
 #
 
 test_description='perl interface (Git.pm)'
+test_disable_saved_count=1
 . ./test-lib.sh
 
 if ! test_have_prereq PERL; then
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..374cdb2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -522,11 +522,19 @@ test_skip () {
 	esac
 }
 
+test_emit_plan () {
+	if [ -z "$test_plan_emitted" -a -n "$test_count_saved" ]; then
+		say "1..$test_count_saved"
+		test_plan_emitted=y
+	fi
+}
+
 test_expect_failure () {
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
 	export test_prereq
+	test_emit_plan
 	if ! test_skip "$@"
 	then
 		say >&3 "checking known breakage: $2"
@@ -545,6 +553,7 @@ test_expect_success () {
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
 	export test_prereq
+	test_emit_plan
 	if ! test_skip "$@"
 	then
 		say >&3 "expecting success: $2"
@@ -860,12 +869,14 @@ test_done () {
 	fi
 	case "$test_failure" in
 	0)
+		[ -z "$skip_all" ] && echo "$test_count" > "$test_count_file"
+
 		# Maybe print SKIP message
 		[ -z "$skip_all" ] || skip_all=" # SKIP $skip_all"
 
 		if test $test_external_has_tap -eq 0; then
 			say_color pass "# passed all $msg"
-			say "1..$test_count$skip_all"
+			[ -z "$test_plan_emitted" ] && say "1..$test_count$skip_all"
 		fi
 
 		test -d "$remove_trash" &&
@@ -877,7 +888,7 @@ test_done () {
 	*)
 		if test $test_external_has_tap -eq 0; then
 			say_color error "# failed $test_failure among $msg"
-			say "1..$test_count"
+			[ -z "$test_plan_emitted" ] && say "1..$test_count"
 		fi
 
 		exit 1 ;;
@@ -896,6 +907,18 @@ then
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
+mkdir -p "$TEST_DIRECTORY"/test-counts
+test_count_file="$TEST_DIRECTORY"/test-counts/$(basename "$0" .sh)
+test_count_saved=$(
+	if [ -n "$test_disable_saved_count" ]; then
+		:
+	# the saved count is only valid if the file is newer than the test
+	elif [ -f "$test_count_file" -a "$test_count_file" -nt "$0" ]; then
+		cat "$test_count_file" 2>/dev/null
+	fi
+	# otherwise we leave the variable empty
+)
+
 if test -n "$valgrind"
 then
 	make_symlink () {
-- 
1.7.7.rc0.420.g468b7
