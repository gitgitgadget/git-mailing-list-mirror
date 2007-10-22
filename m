From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Add some fancy colors in the test library when terminal supports it.
Date: Mon, 22 Oct 2007 10:13:41 +0200
Message-ID: <20071022081341.GC32763@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 10:13:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjsQ7-00084g-Cb
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 10:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXJVINo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 04:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbXJVINo
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 04:13:44 -0400
Received: from pan.madism.org ([88.191.52.104]:33790 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbXJVINn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 04:13:43 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A9CED26165;
	Mon, 22 Oct 2007 10:13:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 02B043CA3F6; Mon, 22 Oct 2007 10:13:41 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61970>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

Maybe this is just me, but I don't find the output of the test-suite
easy to watch while scrolling. This puts some colors in proper places.

  * end-test summaries are in green or red depending on the sucess of
    the tests.
  * errors are in red.
  * skipped tests and other things that tests `say` are in brown (now
    you can _see_ that your testsuite skips some tests on purpose, I
    only noticed recently that I missed part of the environment for
    proper testing).

I'm not 100% sure the test to see if terminal supports color is correct, and
people using emacs shell buffer or alike tools may have better ideas on how to
make it.

and yes, I know that it "depends" upon tput, but if tput isn't available, the
    [ "x$TERM" != "xdumb" ] && tput hpa 60 >/dev/null 2>&1 && tput setaf 1 >/dev/null 2>&1
expression will fail, and color will be disabled.

 t/test-lib.sh |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cc1253c..c6521c0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -59,14 +59,24 @@ esac
 # '
 # . ./test-lib.sh
 
+[ "x$TERM" != "xdumb" ] && tput hpa 60 >/dev/null 2>&1 && tput setaf 1 >/dev/null 2>&1
+nocolor=$?
+
+say_color () {
+	[ "$nocolor" = 0 ] &&  [ "$1" != '-1' ] && tput setaf "$1"
+	shift
+	echo "* $*"
+	tput op
+}
+
 error () {
-	echo "* error: $*"
+	say_color 9 "* error: $*"
 	trap - exit
 	exit 1
 }
 
 say () {
-	echo "* $*"
+	say_color 3 "$*"
 }
 
 test "${test_description}" != "" ||
@@ -84,6 +94,8 @@ do
 		exit 0 ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=t; shift ;;
+	--no-color)
+	    nocolor=1; shift ;;
 	--no-python)
 		# noop now...
 		shift ;;
@@ -122,13 +134,13 @@ test_tick () {
 
 test_ok_ () {
 	test_count=$(expr "$test_count" + 1)
-	say "  ok $test_count: $@"
+	say_color -1 "  ok $test_count: $@"
 }
 
 test_failure_ () {
 	test_count=$(expr "$test_count" + 1)
 	test_failure=$(expr "$test_failure" + 1);
-	say "FAIL $test_count: $1"
+	say_color 9 "FAIL $test_count: $1"
 	shift
 	echo "$@" | sed -e 's/^/	/'
 	test "$immediate" = "" || { trap - exit; exit 1; }
@@ -158,9 +170,9 @@ test_skip () {
 	done
 	case "$to_skip" in
 	t)
-		say >&3 "skipping test: $@"
+		say_color 10 >&3 "skipping test: $@"
 		test_count=$(expr "$test_count" + 1)
-		say "skip $test_count: $1"
+		say_color 10 "skip $test_count: $1"
 		: true
 		;;
 	*)
@@ -247,11 +259,11 @@ test_done () {
 		# The Makefile provided will clean this test area so
 		# we will leave things as they are.
 
-		say "passed all $test_count test(s)"
+		say_color 2 "passed all $test_count test(s)"
 		exit 0 ;;
 
 	*)
-		say "failed $test_failure among $test_count test(s)"
+		say_color 9 "failed $test_failure among $test_count test(s)"
 		exit 1 ;;
 
 	esac
@@ -296,8 +308,8 @@ do
 	done
 	case "$to_skip" in
 	t)
-		say >&3 "skipping test $this_test altogether"
-		say "skip all tests in $this_test"
+		say_color 10 >&3 "skipping test $this_test altogether"
+		say_color 10 "skip all tests in $this_test"
 		test_done
 	esac
 done
-- 
1.5.3.4.1342.ge0cd-dirty
