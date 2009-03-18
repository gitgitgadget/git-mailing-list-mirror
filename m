From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 05/10] test-lib: Simplify test counting.
Date: Wed, 18 Mar 2009 22:27:07 +0100
Message-ID: <26c0cd245694bed22d98850c8ac0a86f3c930789.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Jl-0004j4-Ma
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbZCRV13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbZCRV10
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:26 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46772 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3CCD310024;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B949060F01;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113674>

Since the test case counter was incremented very late, there were a few
users of the counter had to do their own incrementing. Now we increment it
early and simplify these users.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/test-lib.sh |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bd8cba1..ace440c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -242,13 +242,11 @@ test_merge () {
 # the text_expect_* functions instead.
 
 test_ok_ () {
-	test_count=$(($test_count + 1))
 	test_success=$(($test_success + 1))
 	say_color "" "  ok $test_count: $@"
 }
 
 test_failure_ () {
-	test_count=$(($test_count + 1))
 	test_failure=$(($test_failure + 1))
 	say_color error "FAIL $test_count: $1"
 	shift
@@ -257,13 +255,11 @@ test_failure_ () {
 }
 
 test_known_broken_ok_ () {
-	test_count=$(($test_count+1))
 	test_fixed=$(($test_fixed+1))
 	say_color "" "  FIXED $test_count: $@"
 }
 
 test_known_broken_failure_ () {
-	test_count=$(($test_count+1))
 	test_broken=$(($test_broken+1))
 	say_color skip "  still broken $test_count: $@"
 }
@@ -279,10 +275,11 @@ test_run_ () {
 }
 
 test_skip () {
+	test_count=$(($test_count+1))
 	to_skip=
 	for skp in $GIT_SKIP_TESTS
 	do
-		case $this_test.$(($test_count+1)) in
+		case $this_test.$test_count in
 		$skp)
 			to_skip=t
 		esac
@@ -290,7 +287,6 @@ test_skip () {
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-		test_count=$(($test_count+1))
 		say_color skip "skip $test_count: $1"
 		: true
 		;;
@@ -368,7 +364,7 @@ test_external () {
 	then
 		# Announce the script to reduce confusion about the
 		# test output that follows.
-		say_color "" " run $(($test_count+1)): $descr ($*)"
+		say_color "" " run $test_count: $descr ($*)"
 		# Run command; redirect its stderr to &4 as in
 		# test_run_, but keep its stdout on our stdout even in
 		# non-verbose mode.
-- 
1.6.2.1.224.g2225f
