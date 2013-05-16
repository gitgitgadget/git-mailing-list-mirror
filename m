From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 5/6] test-lib: allow prefixing a custom string before "ok N" etc.
Date: Thu, 16 May 2013 22:50:16 +0200
Message-ID: <f440021d75345b1242e54f47697c3d2ac9593e99.1368736093.git.trast@inf.ethz.ch>
References: <cover.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 22:50:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud58U-00051H-T6
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 22:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab3EPUug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 16:50:36 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41637 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225Ab3EPUuY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 16:50:24 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:17 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:19 +0200
X-Mailer: git-send-email 1.8.3.rc2.393.g8636c0b
In-Reply-To: <cover.1368736093.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224621>

This is not really meant for external use, but allows the next commit
to neatly distinguish between sub-tests and the main run.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/test-lib.sh | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9ae7c7b..55fa749 100644
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
@@ -435,8 +438,8 @@ test_skip () {
 			of_prereq=" of $test_prereq"
 		fi
 
-		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
+		say_color skip >&3 "${statusprefix}skipping test: $@"
+		say_color skip "${statusprefix}ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
 		: true
 		;;
 	*)
@@ -472,11 +475,11 @@ test_done () {
 
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
@@ -499,9 +502,9 @@ test_done () {
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
@@ -515,8 +518,8 @@ test_done () {
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
1.8.3.rc2.393.g8636c0b
