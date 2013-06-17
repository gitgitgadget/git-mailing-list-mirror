From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2 5/6] test-lib: allow prefixing a custom string before "ok N" etc.
Date: Mon, 17 Jun 2013 11:18:50 +0200
Message-ID: <cc07d2c6e7282df1c6a1e1dcac23205b9c4b8667.1371460265.git.trast@inf.ethz.ch>
References: <cover.1371460265.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 17 11:19:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoVau-0004qy-S5
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 11:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab3FQJTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 05:19:03 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:40405 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756012Ab3FQJTA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 05:19:00 -0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228056>

This is not really meant for external use, and thus not documented. It
allows the next commit to neatly distinguish between sub-tests and the
main run.

The format is intentionally not valid TAP.  The use in the next commit
would not result in anything valid either way, and it seems better to
make it obvious.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/test-lib.sh | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 40bd7da..aaf6084 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -209,6 +209,9 @@ do
 	--root=*)
 		root=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
+	--statusprefix=*)
+		statusprefix=$(expr "z$1" : 'z[^=]*=\(.*\)')
+		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -316,12 +319,12 @@ trap 'die' EXIT
 
 test_ok_ () {
 	test_success=$(($test_success + 1))
-	say_color "" "ok $test_count - $@"
+	say_color "" "${statusprefix}ok $test_count - $@"
 }
 
 test_failure_ () {
 	test_failure=$(($test_failure + 1))
-	say_color error "not ok $test_count - $1"
+	say_color error "${statusprefix}not ok $test_count - $1"
 	shift
 	echo "$@" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
@@ -329,12 +332,12 @@ test_failure_ () {
 
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
-	say_color error "ok $test_count - $@ # TODO known breakage vanished"
+	say_color error "${statusprefix}ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
 	test_broken=$(($test_broken+1))
-	say_color warn "not ok $test_count - $@ # TODO known breakage"
+	say_color warn "${statusprefix}not ok $test_count - $@ # TODO known breakage"
 }
 
 test_debug () {
@@ -460,8 +463,8 @@ test_skip () {
 			of_prereq=" of $test_prereq"
 		fi
 
-		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
+		say_color skip >&3 "${statusprefix}skipping test: $@"
+		say_color skip "${statusprefix}ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
 		: true
 		;;
 	*)
@@ -497,11 +500,11 @@ test_done () {
 
 	if test "$test_fixed" != 0
 	then
-		say_color error "# $test_fixed known breakage(s) vanished; please update test(s)"
+		say_color error "${statusprefix}# $test_fixed known breakage(s) vanished; please update test(s)"
 	fi
 	if test "$test_broken" != 0
 	then
-		say_color warn "# still have $test_broken known breakage(s)"
+		say_color warn "${statusprefix}# still have $test_broken known breakage(s)"
 	fi
 	if test "$test_broken" != 0 || test "$test_fixed" != 0
 	then
@@ -524,9 +527,9 @@ test_done () {
 		then
 			if test $test_remaining -gt 0
 			then
-				say_color pass "# passed all $msg"
+				say_color pass "${statusprefix}# passed all $msg"
 			fi
-			say "1..$test_count$skip_all"
+			say "${statusprefix}1..$test_count$skip_all"
 		fi
 
 		test -d "$remove_trash" &&
@@ -540,8 +543,8 @@ test_done () {
 	*)
 		if test $test_external_has_tap -eq 0
 		then
-			say_color error "# failed $test_failure among $msg"
-			say "1..$test_count"
+			say_color error "${statusprefix}# failed $test_failure among $msg"
+			say "${statusprefix}1..$test_count"
 		fi
 
 		exit 1 ;;
-- 
1.8.3.1.530.g6f90e57
