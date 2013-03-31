From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] tests: parameterize --valgrind option
Date: Sun, 31 Mar 2013 10:00:16 +0200
Message-ID: <161de95d54802b5a47a8be89f0b78c8caf5a6f1e.1364716452.git.trast@inf.ethz.ch>
References: <cover.1364716452.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 31 10:01:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMDCK-0005Pt-1T
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 10:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652Ab3CaIAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 04:00:35 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:57356 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543Ab3CaIAe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 04:00:34 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:00:32 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.251) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:00:30 +0200
X-Mailer: git-send-email 1.8.2.467.gedf93a5
In-Reply-To: <cover.1364716452.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.251]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219605>

From: Thomas Rast <trast@inf.ethz.ch>

Running tests under helgrind and DRD recently proved useful in
tracking down thread interaction issues.  This can unfortunately not
be done through GIT_VALGRIND_OPTIONS because any tool other than
memcheck would complain about unknown options.

Let --valgrind take an optional parameter that describes the valgrind
tool to invoke.  The default mode is to run memcheck as before.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/README               | 15 ++++++++++-----
 t/test-lib.sh          | 10 +++++++++-
 t/valgrind/valgrind.sh | 25 +++++++++++++++----------
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/t/README b/t/README
index bc7253c5..f5ee40f 100644
--- a/t/README
+++ b/t/README
@@ -92,16 +92,21 @@ appropriately before running "make".
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
 
---valgrind::
-	Execute all Git binaries with valgrind and exit with status
-	126 on errors (just like regular tests, this will only stop
-	the test script when running under -i).
+--valgrind=<tool>::
+	Execute all Git binaries under valgrind tool <tool> and exit
+	with status 126 on errors (just like regular tests, this will
+	only stop the test script when running under -i).
 
 	Since it makes no sense to run the tests with --valgrind and
 	not see any output, this option implies --verbose.  For
 	convenience, it also implies --tee.
 
-	Note that valgrind is run with the option --leak-check=no,
+	<tool> defaults to 'memcheck', just like valgrind itself.
+	Other particularly useful choices include 'helgrind' and
+	'drd', but you may use any tool recognized by your valgrind
+	installation.
+
+	Note that memcheck is run with the option --leak-check=no,
 	as the git process is short-lived and some errors are not
 	interesting. In order to run a single command under the same
 	conditions manually, you should set GIT_VALGRIND to point to
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1f51025..da57a2f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -193,7 +193,11 @@ do
 	--no-color)
 		color=; shift ;;
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
-		valgrind=t; verbose=t; shift ;;
+		valgrind=memcheck
+		shift ;;
+	--valgrind=*)
+		valgrind=$(expr "z$1" : 'z[^=]*=\(.*\)')
+		shift ;;
 	--tee)
 		shift ;; # was handled already
 	--root=*)
@@ -204,6 +208,8 @@ do
 	esac
 done
 
+test -n "$valgrind" && verbose=t
+
 if test -n "$color"
 then
 	say_color () {
@@ -530,6 +536,8 @@ then
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
+	GIT_VALGRIND_MODE="$valgrind"
+	export GIT_VALGRIND_MODE
 elif test -n "$GIT_TEST_INSTALLED"
 then
 	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
index 582b4dc..472ac2d 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -2,20 +2,25 @@
 
 base=$(basename "$0")
 
-TRACK_ORIGINS=
+TOOL_OPTIONS='--leak-check=no'
 
-VALGRIND_VERSION=$(valgrind --version)
-VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
-VALGRIND_MINOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
-test 3 -gt "$VALGRIND_MAJOR" ||
-test 3 -eq "$VALGRIND_MAJOR" -a 4 -gt "$VALGRIND_MINOR" ||
-TRACK_ORIGINS=--track-origins=yes
+case "$GIT_VALGRIND_MODE" in
+memcheck)
+	VALGRIND_VERSION=$(valgrind --version)
+	VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
+	VALGRIND_MINOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
+	test 3 -gt "$VALGRIND_MAJOR" ||
+	test 3 -eq "$VALGRIND_MAJOR" -a 4 -gt "$VALGRIND_MINOR" ||
+	TOOL_OPTIONS="$TOOL_OPTIONS --track-origins=yes"
+	;;
+*)
+	TOOL_OPTIONS="--tool=$GIT_VALGRIND_MODE"
+esac
 
 exec valgrind -q --error-exitcode=126 \
-	--leak-check=no \
-	--suppressions="$GIT_VALGRIND/default.supp" \
 	--gen-suppressions=all \
-	$TRACK_ORIGINS \
+	--suppressions="$GIT_VALGRIND/default.supp" \
+	$TOOL_OPTIONS \
 	--log-fd=4 \
 	--input-fd=4 \
 	$GIT_VALGRIND_OPTIONS \
-- 
1.8.2.467.gedf93a5
