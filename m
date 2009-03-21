From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 05/16] test-lib: Infrastructure to test and check for prerequisites
Date: Sat, 21 Mar 2009 22:26:28 +0100
Message-ID: <a7bb394037e1c32d47d0b04da025bdbe2eb78d66.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8lh-0004Ii-Qf
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbZCUV11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbZCUV1Z
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:25 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27928 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4B7EC2C4007;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id F2C5D5BBF4;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114069>

Some tests can be run only if a particular prerequisite is available. For
example, some tests require that an UTF-8 locale is available. Here we
introduce functions that are used in this way:

1. Insert code that checks whether the prerequisite is available. If it is,
   call test_set_prereq with an arbitrary tag name that subsequently can be
   used to check for the prerequisite:

      case $LANG in
      *.utf-8)
            test_set_prereq UTF8
            ;;
      esac

2. In the calls to test_expect_success pass the tag name:

      test_expect_success UTF8 '...description...' '...tests...'

3. There is an auxiliary predicate that can be used anywhere to test for
   a prerequisite explicitly:

      if test_have_prereq UTF8
      then
            ...code to be skipped if prerequisite is not available...
      fi

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0000-basic.sh |   15 +++++++++++++++
 t/test-lib.sh    |   44 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ddcd5b0..c53de1f 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -57,6 +57,21 @@ test_expect_failure 'pretend we have a known breakage' '
 test_expect_failure 'pretend we have fixed a known breakage' '
     :
 '
+test_set_prereq HAVEIT
+haveit=no
+test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
+    test_have_prereq HAVEIT &&
+    haveit=yes
+'
+donthaveit=yes
+test_expect_success DONTHAVEIT 'unmet prerequisite causes test to be skipped' '
+    donthaveit=no
+'
+if test $haveit$donthaveit != yesyes
+then
+	say "bug in test framework: prerequisite tags do not work reliably"
+	exit 1
+fi
 
 ################################################################
 # Basics of the basics
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0a0696a..3c65cfe 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -247,6 +247,31 @@ test_chmod () {
 	git update-index --add "--chmod=$@"
 }
 
+# Use test_set_prereq to tell that a particular prerequisite is available.
+# The prerequisite can later be checked for in two ways:
+#
+# - Explicitly using test_have_prereq.
+#
+# - Implicitly by specifying the prerequisite tag in the calls to
+#   test_expect_{success,failure,code}.
+#
+# The single parameter is the prerequisite tag (a simple word, in all
+# capital letters by convention).
+
+test_set_prereq () {
+	satisfied="$satisfied$1 "
+}
+satisfied=" "
+
+test_have_prereq () {
+	case $satisfied in
+	*" $1 "*)
+		: yes, have it ;;
+	*)
+		! : nope ;;
+	esac
+}
+
 # You are not expected to call test_ok_ and test_failure_ directly, use
 # the text_expect_* functions instead.
 
@@ -293,6 +318,11 @@ test_skip () {
 			to_skip=t
 		esac
 	done
+	if test -z "$to_skip" && test -n "$prereq" &&
+	   ! test_have_prereq "$prereq"
+	then
+		to_skip=t
+	fi
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
@@ -306,8 +336,9 @@ test_skip () {
 }
 
 test_expect_failure () {
+	test "$#" = 3 && { prereq=$1; shift; } || prereq=
 	test "$#" = 2 ||
-	error "bug in the test script: not 2 parameters to test-expect-failure"
+	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
 	if ! test_skip "$@"
 	then
 		say >&3 "checking known breakage: $2"
@@ -323,8 +354,9 @@ test_expect_failure () {
 }
 
 test_expect_success () {
+	test "$#" = 3 && { prereq=$1; shift; } || prereq=
 	test "$#" = 2 ||
-	error "bug in the test script: not 2 parameters to test-expect-success"
+	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
 	if ! test_skip "$@"
 	then
 		say >&3 "expecting success: $2"
@@ -340,8 +372,9 @@ test_expect_success () {
 }
 
 test_expect_code () {
+	test "$#" = 4 && { prereq=$1; shift; } || prereq=
 	test "$#" = 3 ||
-	error "bug in the test script: not 3 parameters to test-expect-code"
+	error "bug in the test script: not 3 or 4 parameters to test-expect-code"
 	if ! test_skip "$@"
 	then
 		say >&3 "expecting exit code $1: $3"
@@ -365,8 +398,9 @@ test_expect_code () {
 # Usage: test_external description command arguments...
 # Example: test_external 'Perl API' perl ../path/to/test.pl
 test_external () {
-	test "$#" -eq 3 ||
-	error >&5 "bug in the test script: not 3 parameters to test_external"
+	test "$#" = 4 && { prereq=$1; shift; } || prereq=
+	test "$#" = 3 ||
+	error >&5 "bug in the test script: not 3 or 4 parameters to test_external"
 	descr="$1"
 	shift
 	if ! test_skip "$descr" "$@"
-- 
1.6.2.1.224.g2225f
