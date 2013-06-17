From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2 4/6] test-lib: valgrind for only tests matching a pattern
Date: Mon, 17 Jun 2013 11:18:49 +0200
Message-ID: <2b24f531f3bdcb0e4553c5701c91d462d928d13c.1371460265.git.trast@inf.ethz.ch>
References: <cover.1371460265.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 17 11:19:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoVau-0004qy-A9
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 11:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab3FQJTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 05:19:00 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:40405 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694Ab3FQJS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 05:18:59 -0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228055>

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
index 84e5f03..40bd7da 100644
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
@@ -371,15 +381,36 @@ maybe_setup_verbose () {
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
 # Called from test_skip after it has incremented $test_count.  This
 # means it runs before any test-specific code and output.
 test_setup_hook_ () {
 	maybe_setup_verbose
+	maybe_setup_valgrind
 }
 
 # Called at the end of test_expect_*.  This means it runs after all
 # test-specific code and output.
 test_teardown_hook_ () {
+	maybe_teardown_valgrind
 	maybe_teardown_verbose
 }
 
@@ -590,6 +621,9 @@ then
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
