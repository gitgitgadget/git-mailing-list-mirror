From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 2/2] Revert "test-lib: allow prefixing a custom string before "ok N" etc."
Date: Sat, 19 Oct 2013 23:06:08 +0200
Message-ID: <6008d45f4e0edc9e9d2c8e82b4f3cd57495c42f6.1382215973.git.tr@thomasrast.ch>
References: <cover.1382215973.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 23:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXdj8-00054l-WB
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 23:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab3JSVGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 17:06:22 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:36701 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab3JSVGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 17:06:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 8BDEC4D659D;
	Sat, 19 Oct 2013 23:06:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id W0EQTXqUGiOV; Sat, 19 Oct 2013 23:06:10 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id EE3144D658A;
	Sat, 19 Oct 2013 23:06:09 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.1.810.g312044e
In-Reply-To: <cover.1382215973.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236407>

Now that ad0e623 (test-lib: support running tests under valgrind in
parallel, 2013-06-23) has been reverted, this support code has no
users any more.  Revert it, too.

This reverts commit e939e15d241e942662b9f88f6127ab470ab0a0b9.
---
 t/test-lib.sh | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index eaf6759..29c1410 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -210,9 +210,6 @@ do
 	--root=*)
 		root=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
-	--statusprefix=*)
-		statusprefix=$(expr "z$1" : 'z[^=]*=\(.*\)')
-		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -320,12 +317,12 @@ trap 'die' EXIT
 
 test_ok_ () {
 	test_success=$(($test_success + 1))
-	say_color "" "${statusprefix}ok $test_count - $@"
+	say_color "" "ok $test_count - $@"
 }
 
 test_failure_ () {
 	test_failure=$(($test_failure + 1))
-	say_color error "${statusprefix}not ok $test_count - $1"
+	say_color error "not ok $test_count - $1"
 	shift
 	echo "$@" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
@@ -333,12 +330,12 @@ test_failure_ () {
 
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
-	say_color error "${statusprefix}ok $test_count - $@ # TODO known breakage vanished"
+	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
 	test_broken=$(($test_broken+1))
-	say_color warn "${statusprefix}not ok $test_count - $@ # TODO known breakage"
+	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
 
 test_debug () {
@@ -462,8 +459,8 @@ test_skip () {
 			of_prereq=" of $test_prereq"
 		fi
 
-		say_color skip >&3 "${statusprefix}skipping test: $@"
-		say_color skip "${statusprefix}ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
+		say_color skip >&3 "skipping test: $@"
+		say_color skip "ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
 		: true
 		;;
 	*)
@@ -501,11 +498,11 @@ test_done () {
 
 	if test "$test_fixed" != 0
 	then
-		say_color error "${statusprefix}# $test_fixed known breakage(s) vanished; please update test(s)"
+		say_color error "# $test_fixed known breakage(s) vanished; please update test(s)"
 	fi
 	if test "$test_broken" != 0
 	then
-		say_color warn "${statusprefix}# still have $test_broken known breakage(s)"
+		say_color warn "# still have $test_broken known breakage(s)"
 	fi
 	if test "$test_broken" != 0 || test "$test_fixed" != 0
 	then
@@ -528,9 +525,9 @@ test_done () {
 		then
 			if test $test_remaining -gt 0
 			then
-				say_color pass "${statusprefix}# passed all $msg"
+				say_color pass "# passed all $msg"
 			fi
-			say "${statusprefix}1..$test_count$skip_all"
+			say "1..$test_count$skip_all"
 		fi
 
 		test -d "$remove_trash" &&
@@ -544,8 +541,8 @@ test_done () {
 	*)
 		if test $test_external_has_tap -eq 0
 		then
-			say_color error "${statusprefix}# failed $test_failure among $msg"
-			say "${statusprefix}1..$test_count"
+			say_color error "# failed $test_failure among $msg"
+			say "1..$test_count"
 		fi
 
 		exit 1 ;;
-- 
1.8.4.1.810.g312044e
