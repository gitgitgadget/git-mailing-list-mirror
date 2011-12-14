From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 2/4] test-lib: allow testing another git build tree
Date: Wed, 14 Dec 2011 16:23:30 +0100
Message-ID: <94f64a03398829bb9a11c18577efb39d9b153eca.1323876121.git.trast@student.ethz.ch>
References: <cover.1323876121.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 16:23:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaqgM-0001QF-R4
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 16:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab1LNPXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 10:23:41 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:21952 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757112Ab1LNPXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 10:23:38 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 16:23:30 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 16:23:33 +0100
X-Mailer: git-send-email 1.7.8.304.ge42e4
In-Reply-To: <cover.1323876121.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187128>

The perf-lib work wants this feature, so we may as well do it for
test-lib in general.  You can now say

  GIT_BUILD_DIR=/another/git/tree
  make test  # or any other test

and it will run the tests of the current tree against the binaries of
the other tree.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Makefile      |    7 ++++++-
 t/test-lib.sh |   19 ++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 2127c1b..52506bf 100644
--- a/Makefile
+++ b/Makefile
@@ -2215,6 +2215,12 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
+	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
+
+GIT-TEST-OPTIONS: FORCE
+ifdef GIT_TEST_OPTS
+	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >$@
+endif
 ifdef GIT_TEST_CMP
 	@echo GIT_TEST_CMP=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_CMP)))'\' >>$@
 endif
@@ -2222,7 +2228,6 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@
 endif
 	@echo GETTEXT_POISON=\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POISON)))'\' >>$@
-	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 368e48c..06f8c96 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -54,6 +54,7 @@ unset $(perl -e '
 		.*_TEST
 		PROVE
 		VALGRIND
+		BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
@@ -318,7 +319,7 @@ test_done () {
 	GIT_EXIT_OK=t
 
 	if test -z "$HARNESS_ACTIVE"; then
-		test_results_dir="$TEST_DIRECTORY/test-results"
+		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
 		mkdir -p "$test_results_dir"
 		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
 
@@ -379,7 +380,18 @@ then
 	# itself.
 	TEST_DIRECTORY=$(pwd)
 fi
-GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+if test -z "$TEST_OUTPUT_DIRECTORY"
+then
+	# Similarly, override this to store the test-results subdir
+	# elsewhere
+	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
+fi
+if test -z "$GIT_BUILD_DIR"
+then
+	# Similarly, override this to test a different git build tree
+	# than the one you are running the tests from
+	GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+fi
 
 if test -n "$valgrind"
 then
@@ -477,6 +489,7 @@ GIT_ATTR_NOSYSTEM=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
 
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+. "$TEST_DIRECTORY"/../GIT-TEST-OPTIONS
 
 if test -z "$GIT_TEST_CMP"
 then
@@ -514,7 +527,7 @@ test="trash directory.$(basename "$0" .sh)"
 test -n "$root" && test="$root/$test"
 case "$test" in
 /*) TRASH_DIRECTORY="$test" ;;
- *) TRASH_DIRECTORY="$TEST_DIRECTORY/$test" ;;
+ *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$test" ;;
 esac
 test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
 rm -fr "$test" || {
-- 
1.7.8.304.ge42e4
