From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v4 2/8] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Sun, 23 Jun 2013 20:12:53 +0200
Message-ID: <271eaadb01fd16324eea440e56c404266fcce2ff.1372010917.git.trast@inf.ethz.ch>
References: <cover.1372010917.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 20:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqonJ-0007pi-5S
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 20:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab3FWSNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 14:13:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39655 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab3FWSNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 14:13:04 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 20:12:46 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 20:13:00 +0200
X-Mailer: git-send-email 1.8.3.1.727.gcbe3af3
In-Reply-To: <cover.1372010917.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228752>

It's already used twice, and we will have more of the same kind of
matching in a minute.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/test-lib.sh | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 35da859..4fa141a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -328,6 +328,20 @@ test_debug () {
 	test "$debug" = "" || eval "$1"
 }
 
+match_pattern_list () {
+	arg="$1"
+	shift
+	test -z "$*" && return 1
+	for pattern_
+	do
+		case "$arg" in
+		$pattern_)
+			return 0
+		esac
+	done
+	return 1
+}
+
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
@@ -358,14 +372,10 @@ test_run_ () {
 test_skip () {
 	test_count=$(($test_count+1))
 	to_skip=
-	for skp in $GIT_SKIP_TESTS
-	do
-		case $this_test.$test_count in
-		$skp)
-			to_skip=t
-			break
-		esac
-	done
+	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
+	then
+		to_skip=t
+	fi
 	if test -z "$to_skip" && test -n "$test_prereq" &&
 	   ! test_have_prereq "$test_prereq"
 	then
@@ -630,15 +640,12 @@ cd -P "$TRASH_DIRECTORY" || exit 1
 
 this_test=${0##*/}
 this_test=${this_test%%-*}
-for skp in $GIT_SKIP_TESTS
-do
-	case "$this_test" in
-	$skp)
-		say_color info >&3 "skipping test $this_test altogether"
-		skip_all="skip all tests in $this_test"
-		test_done
-	esac
-done
+if match_pattern_list "$this_test" $GIT_SKIP_TESTS
+then
+	say_color info >&3 "skipping test $this_test altogether"
+	skip_all="skip all tests in $this_test"
+	test_done
+fi
 
 # Provide an implementation of the 'yes' utility
 yes () {
-- 
1.8.3.1.727.gcbe3af3
