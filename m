From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v3 7/8] test-lib: allow prefixing a custom string before "ok N" etc.
Date: Tue, 18 Jun 2013 14:26:03 +0200
Message-ID: <7b3790c16289ff9ece9097fbfcea86db21bbeb37.1371557431.git.trast@inf.ethz.ch>
References: <cover.1371557431.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:26:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uouzf-00086N-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab3FRM03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:26:29 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:19107 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755925Ab3FRM0U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:26:20 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:17 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.157) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:18 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371557431.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228220>

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
index 817ab43..f2abff9 100644
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
@@ -458,8 +461,8 @@ test_skip () {
 			of_prereq=" of $test_prereq"
 		fi
 
-		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
+		say_color skip >&3 "${statusprefix}skipping test: $@"
+		say_color skip "${statusprefix}ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
 		: true
 		;;
 	*)
@@ -495,11 +498,11 @@ test_done () {
 
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
@@ -522,9 +525,9 @@ test_done () {
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
@@ -538,8 +541,8 @@ test_done () {
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
