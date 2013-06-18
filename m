From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v3 2/8] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Tue, 18 Jun 2013 14:25:58 +0200
Message-ID: <ad912196db92e34793348462db2e03333ec9eb21.1371557431.git.trast@inf.ethz.ch>
References: <cover.1371557431.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouzS-0007cU-FG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab3FRM0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:26:18 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42501 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135Ab3FRM0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:26:15 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:10 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.157) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:14 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371557431.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228215>

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
1.8.3.1.530.g6f90e57
