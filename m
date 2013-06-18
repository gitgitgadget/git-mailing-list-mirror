From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v3 6/8] test-lib: valgrind for only tests matching a pattern
Date: Tue, 18 Jun 2013 14:26:02 +0200
Message-ID: <b9bc80e3a1e335ff6122dcc42c97247c6aa7ef56.1371557431.git.trast@inf.ethz.ch>
References: <cover.1371557431.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:26:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouzT-0007cU-IF
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab3FRM0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:26:21 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42511 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911Ab3FRM0T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:26:19 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:13 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.157) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:17 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371557431.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228216>

With the new --valgrind-only=<pattern> option, one can enable
--valgrind at a per-test granularity, exactly analogous to
--verbose-only from the previous commit.

The options are wired such that --valgrind implies --verbose (as
before), but --valgrind-only=<pattern> implies
--verbose-only=<pattern> unless --verbose is also in effect.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/README               |  5 +++++
 t/test-lib.sh          | 36 +++++++++++++++++++++++++++++++++++-
 t/valgrind/valgrind.sh |  3 +++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index f4e6299..abe991f 100644
--- a/t/README
+++ b/t/README
@@ -126,6 +126,11 @@ appropriately before running "make".
 	the 't/valgrind/' directory and use the commands under
 	't/valgrind/bin/'.
 
+--valgrind-only=<pattern>::
+	Like --valgrind, but the effect is limited to tests with
+	numbers matching <pattern>.  The number matched against is
+	simply the running count of the test within the file.
+
 --tee::
 	In addition to printing the test output to the terminal,
 	write it to files named 't/test-results/$TEST_NAME.out'.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2bceb92..817ab43 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -201,6 +201,9 @@ do
 	--valgrind=*)
 		valgrind=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
+	--valgrind-only=*)
+		valgrind_only=$(expr "z$1" : 'z[^=]*=\(.*\)')
+		shift ;;
 	--tee)
 		shift ;; # was handled already
 	--root=*)
@@ -211,7 +214,14 @@ do
 	esac
 done
 
-test -n "$valgrind" && verbose=t
+if test -n "$valgrind_only"
+then
+	test -z "$valgrind" && valgrind=memcheck
+	test -z "$verbose" && verbose_only="$valgrind_only"
+elif test -n "$valgrind"
+then
+	verbose=t
+fi
 
 if test -n "$color"
 then
@@ -371,6 +381,25 @@ maybe_setup_verbose () {
 	last_verbose=$verbose
 }
 
+maybe_teardown_valgrind () {
+	test -z "$GIT_VALGRIND" && return
+	GIT_VALGRIND_ENABLED=
+}
+
+maybe_setup_valgrind () {
+	test -z "$GIT_VALGRIND" && return
+	if test -z "$valgrind_only"
+	then
+		GIT_VALGRIND_ENABLED=t
+		return
+	fi
+	GIT_VALGRIND_ENABLED=
+	if match_pattern_list $test_count $valgrind_only
+	then
+		GIT_VALGRIND_ENABLED=t
+	fi
+}
+
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
@@ -401,10 +430,12 @@ test_run_ () {
 test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
+	maybe_setup_valgrind
 }
 
 test_finish_ () {
 	echo >&3 ""
+	maybe_teardown_valgrind
 	maybe_teardown_verbose
 }
 
@@ -588,6 +619,9 @@ then
 	export GIT_VALGRIND
 	GIT_VALGRIND_MODE="$valgrind"
 	export GIT_VALGRIND_MODE
+	GIT_VALGRIND_ENABLED=t
+	test -n "$valgrind_only" && GIT_VALGRIND_ENABLED=
+	export GIT_VALGRIND_ENABLED
 elif test -n "$GIT_TEST_INSTALLED"
 then
 	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
index 6b87c91..4215303 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -4,6 +4,9 @@ base=$(basename "$0")
 
 TOOL_OPTIONS='--leak-check=no'
 
+test -z "$GIT_VALGRIND_ENABLED" &&
+exec "$GIT_VALGRIND"/../../"$base" "$@"
+
 case "$GIT_VALGRIND_MODE" in
 memcheck-fast)
 	;;
-- 
1.8.3.1.530.g6f90e57
