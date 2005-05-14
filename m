From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Test suite fixup.
Date: Sat, 14 May 2005 00:24:27 -0700
Message-ID: <7vzmuy46dw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 09:24:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWr0v-0003Od-Li
	for gcvg-git@gmane.org; Sat, 14 May 2005 09:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVENHYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 03:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVENHYg
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 03:24:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:27849 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262696AbVENHY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 03:24:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514072428.WFON7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 03:24:28 -0400
To: pasky@ucw.cz, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Exposing test_expect_success and test_expect_failure turns out
to be enough for the test scripts and there is no need for
exposing test_ok or test_failure.  This patch cleans it up and
fixes the users of test_ok and test_failure.

Also test scripts have acquired a new command line flag
'--immediate' to cause them to exit upon the first failure.
This is useful especially during the development of a new test.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

This is on top of the two "test suite take 2" patches.

t/t1000-checkout-cache.sh |    9 +++------
t/t1001-checkout-cache.sh |   15 ++++++---------
t/test-lib.sh             |   15 +++++++++------
3 files changed, 18 insertions(+), 21 deletions(-)

--- a/t/t1000-checkout-cache.sh
+++ b/t/t1000-checkout-cache.sh
@@ -44,12 +44,9 @@
     'git-checkout-cache with -f should succeed.' \
     'git-checkout-cache -f -a'
 
-if test -f path0 && test -d path1 && test -f path1/file1
-then
-	test_ok "checkout successful"
-else
-	test_failure "checkout failed"
-fi
+test_expect_success \
+    'git-checkout-cache conflicting paths.' \
+    'test -f path0 && test -d path1 && test -f path1/file1'
 
 test_done
 
--- a/t/t1001-checkout-cache.sh
+++ b/t/t1001-checkout-cache.sh
@@ -76,15 +76,12 @@
     'git-read-tree $tree2 && git-checkout-cache -f -a'
 test_debug show_files $tree2
 
-if test ! -h path0 && test -d path0 &&
-   test ! -h path1 && test -d path1 &&
-   test ! -h path0/file0 && test -f path0/file0 &&
-   test ! -h path1/file1 && test -f path1/file1
-then
-    test_ok "checked out correctly."
-else
-    test_failure "did not check out correctly."
-fi
+test_expect_success \
+    'checking out conflicting path with -f' \
+    'test ! -h path0 && test -d path0 &&
+     test ! -h path1 && test -d path1 &&
+     test ! -h path0/file0 && test -f path0/file0 &&
+     test ! -h path1/file1 && test -f path1/file1'
 
 test_done
 
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -50,6 +50,8 @@
 	case "$1" in
 	-d|--d|--de|--deb|--debu|--debug)
 		debug=t; shift ;;
+	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
+	immediate=t; shift ;;
 	-h|--h|--he|--hel|--help)
 		echo "$test_description"
 		exit 0 ;;
@@ -74,15 +76,16 @@
 	test "$debug" == "" || eval "$1"
 }
 
-test_ok () {
+test_ok_ () {
 	test_count=$(expr "$test_count" + 1)
 	say "ok #$test_count: $@"
 }
 
-test_failure () {
+test_failure_ () {
 	test_count=$(expr "$test_count" + 1)
 	test_failure=$(expr "$test_failure" + 1);
 	say "NO #$test_count: $@"
+	test "$immediate" == "" || exit 1
 }
 
 test_expect_failure () {
@@ -91,9 +94,9 @@
 	say >&3 "expecting failure: $2"
 	if eval >&3 2>&4 "$2"
 	then
-		test_failure "$@"
+		test_failure_ "$@"
 	else
-		test_ok "$1"
+		test_ok_ "$1"
 	fi
 }
 
@@ -103,9 +106,9 @@
 	say >&3 "expecting success: $2"
 	if eval >&3 2>&4 "$2"
 	then
-		test_ok "$1"
+		test_ok_ "$1"
 	else
-		test_failure "$@"
+		test_failure_ "$@"
 	fi
 }
 


