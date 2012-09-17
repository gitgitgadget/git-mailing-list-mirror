From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH] Make test output coloring more intuitive
Date: Mon, 17 Sep 2012 12:50:37 +0100
Message-ID: <1347882637-21766-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 13:51:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDZqp-0008QV-QN
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 13:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab2IQLul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 07:50:41 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:42415 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049Ab2IQLuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 07:50:40 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 4FA162E5D5
	for <git@vger.kernel.org>; Mon, 17 Sep 2012 12:50:38 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205675>

1. Change the color of individual known breakages from bold green to
   bold yellow.  This seems more appropriate when considering the
   universal traffic lights coloring scheme, where green conveys the
   impression that everything's OK, and amber that something's not
   quite right.

2. Likewise, change the color of the summarized total number of known
   breakages from bold red to bold yellow to be less alarmist and more
   consistent with the above.

3. Change color of unexpectedly fixed known breakages to bold red.  An
   unexpectedly passing test indicates that the test is wrong or the
   semantics of the code being tested have changed.  Either way this
   is an error which is arguably as bad as a failing test, and as such
   is now counted in the totals too.

The end result of these changes is that:

  - red is _only_ used for things which have gone unexpectedly wrong:
    test failures, unexpected test passes, and failures with the
    framework,

  - yellow is _only_ used for known breakages, and

  - green is _only_ used for things which have gone to plan and
    require no further work to be done.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0000-basic.sh |  7 ++++---
 t/test-lib.sh    | 13 ++++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)
 mode change 100644 => 100755 t/test-lib.sh

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ae6a3f0..4e111b4 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -81,9 +81,10 @@ test_expect_success 'pretend we have fixed a known breakage (run in sub test-lib
 	./passing-todo.sh >out 2>err &&
 	! test -s err &&
 	sed -e 's/^> //' >expect <<-\\EOF &&
-	> ok 1 - pretend we have fixed a known breakage # TODO known breakage
-	> # fixed 1 known breakage(s)
-	> # passed all 1 test(s)
+	> ok 1 - pretend we have fixed a known breakage # TODO known breakage vanished
+	> # fixed 1 known breakage(s); please update test(s)
+	> # still have 1 known breakage(s)
+	> # passed all remaining 0 test(s)
 	> 1..1
 	EOF
 	test_cmp expect out)
diff --git a/t/test-lib.sh b/t/test-lib.sh
old mode 100644
new mode 100755
index f8e3733..9907035
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -183,10 +183,12 @@ then
 			tput bold; tput setaf 1;; # bold red
 		skip)
 			tput bold; tput setaf 2;; # bold green
+		warn)
+			tput bold; tput setaf 3;; # bold yellow
 		pass)
 			tput setaf 2;;            # green
 		info)
-			tput setaf 3;;            # brown
+			tput setaf 3;;            # yellow/brown
 		*)
 			test -n "$quiet" && return;;
 		esac
@@ -276,12 +278,13 @@ test_failure_ () {
 
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
-	say_color "" "ok $test_count - $@ # TODO known breakage"
+	test_broken=$(($test_broken+1))
+	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
 	test_broken=$(($test_broken+1))
-	say_color skip "not ok $test_count - $@ # TODO known breakage"
+	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
 
 test_debug () {
@@ -371,11 +374,11 @@ test_done () {
 
 	if test "$test_fixed" != 0
 	then
-		say_color pass "# fixed $test_fixed known breakage(s)"
+		say_color error "# fixed $test_fixed known breakage(s); please update test(s)"
 	fi
 	if test "$test_broken" != 0
 	then
-		say_color error "# still have $test_broken known breakage(s)"
+		say_color warn "# still have $test_broken known breakage(s)"
 		msg="remaining $(($test_count-$test_broken)) test(s)"
 	else
 		msg="$test_count test(s)"
-- 
1.7.12.147.g6d168f4
