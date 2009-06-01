From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/3] test-lib: allow exit trap to be used for cleanup by tests
Date: Mon,  1 Jun 2009 14:14:41 +0200
Message-ID: <1243858482-6353-3-git-send-email-drizzd@aon.at>
References: <1243858482-6353-1-git-send-email-drizzd@aon.at>
 <1243858482-6353-2-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 14:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB6QE-0005S5-4S
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 14:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbZFAMPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 08:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbZFAMPQ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 08:15:16 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:39866 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757399AbZFAMPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 08:15:09 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Jun 2009 14:15:06 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MB6Py-0001k9-Ev; Mon, 01 Jun 2009 14:15:06 +0200
X-Mailer: git-send-email 1.6.3.1.147.g637c3
In-Reply-To: <1243858482-6353-2-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 01 Jun 2009 12:15:06.0494 (UTC) FILETIME=[998C61E0:01C9E2B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120465>

Exit trap should not be removed in case tests require cleanup code. This
is especially important if tests are executed with the --immediate option.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/test-lib.sh |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6e83ceb..5fdc5d9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -147,7 +147,7 @@ fi
 
 error () {
 	say_color error "error: $*"
-	trap - EXIT
+	GIT_EXIT_OK=t
 	exit 1
 }
 
@@ -179,10 +179,17 @@ test_broken=0
 test_success=0
 
 die () {
-	echo >&5 "FATAL: Unexpected exit with code $?"
-	exit 1
+	code=$?
+	if test -n "$GIT_EXIT_OK"
+	then
+		exit $code
+	else
+		echo >&5 "FATAL: Unexpected exit with code $code"
+		exit 1
+	fi
 }
 
+GIT_EXIT_OK=
 trap 'die' EXIT
 
 # The semantics of the editor variables are that of invoking
@@ -285,7 +292,7 @@ test_failure_ () {
 	say_color error "FAIL $test_count: $1"
 	shift
 	echo "$@" | sed -e 's/^/	/'
-	test "$immediate" = "" || { trap - EXIT; exit 1; }
+	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
 }
 
 test_known_broken_ok_ () {
@@ -347,7 +354,7 @@ test_expect_failure () {
 		then
 			test_known_broken_ok_ "$1"
 		else
-		    test_known_broken_failure_ "$1"
+			test_known_broken_failure_ "$1"
 		fi
 	fi
 	echo >&3 ""
@@ -498,7 +505,7 @@ test_create_repo () {
 }
 
 test_done () {
-	trap - EXIT
+	GIT_EXIT_OK=t
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
 	test_results_path="$test_results_dir/${0%.sh}-$$"
@@ -640,7 +647,7 @@ fi
 test="trash directory.$(basename "$0" .sh)"
 test ! -z "$debug" || remove_trash="$TEST_DIRECTORY/$test"
 rm -fr "$test" || {
-	trap - EXIT
+	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
 	exit 1
 }
-- 
1.6.3.1.147.g637c3
