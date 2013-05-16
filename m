From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 4/6] test-lib: valgrind for only tests matching a pattern
Date: Thu, 16 May 2013 22:50:15 +0200
Message-ID: <0be45a574ec5f527ef1f3cc50f7acba2f025a2a3.1368736093.git.trast@inf.ethz.ch>
References: <cover.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 22:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud58T-00051H-9G
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 22:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab3EPUub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 16:50:31 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:48887 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869Ab3EPUuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 16:50:22 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:18 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224618>

With the new --valgrind-only=<pattern> option, one can enable
--valgrind at a per-test granularity, exactly analogous to
--verbose-only from the previous commit.

The options are wired such that --valgrind implies --verbose (as
before), but --valgrind-only=<pattern> implies
--verbose-only=<pattern> unless --verbose is also in effect.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/README               |  5 +++++
 t/test-lib.sh          | 30 +++++++++++++++++++++++++++++-
 t/valgrind/valgrind.sh |  3 +++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 9c8f9b1..bffd484 100644
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
index 01e7445..9ae7c7b 100644
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
@@ -355,8 +365,23 @@ toggle_verbose () {
 	fi
 }
 
+toggle_valgrind () {
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
 setup_test_eval () {
 	setup_malloc_check
+	toggle_valgrind
 	toggle_verbose
 }
 teardown_test_eval () {
@@ -571,6 +596,9 @@ then
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
1.8.3.rc2.393.g8636c0b
