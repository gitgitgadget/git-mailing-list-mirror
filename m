From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting GIT_EXIT_OK to GIT_EXIT_CODE
Date: Fri,  9 Oct 2009 13:39:56 -0500
Message-ID: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
Cc: drizzd@aon.at, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 20:47:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwKUm-0003JE-8K
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 20:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934087AbZJISlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 14:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934094AbZJISlI
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 14:41:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33579 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914AbZJISlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 14:41:08 -0400
Received: by mail.nrlssc.navy.mil id n99IeEpr011991; Fri, 9 Oct 2009 13:40:14 -0500
X-OriginalArrivalTime: 09 Oct 2009 18:40:14.0227 (UTC) FILETIME=[F0881E30:01CA490F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129831>

From: Brandon Casey <drafnel@gmail.com>

Commit 6e7b5aaf introduced the concept of GIT_EXIT_OK as a way to indicate
to die(), the exit handler, whether the exit was initiated by the test
harness, or whether it was unexpected.  die() expects $? to contain the
value passed to exit(), and when GIT_EXIT_OK is set, die() calls exit with
the value in $?.  This works as expected when using the Bash shell.  For
the Korn shell, $? has the value of the last executed statement _before_
the call to exit.  If that statement completed successfully, then die()
would incorrectly exit with a successful status when GIT_EXIT_OK is set.

So, rather than relying on the behavior of Bash in order to get the exit
code from $? inside die(), change GIT_EXIT_OK into GIT_EXIT_CODE, and set
it to the code that we want to exit with.  This allows the test suite to
be run with the Korn shell.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/test-lib.sh |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2ca536..64e793a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -150,7 +150,7 @@ fi
 
 error () {
 	say_color error "error: $*"
-	GIT_EXIT_OK=t
+	GIT_EXIT_CODE=1
 	exit 1
 }
 
@@ -183,16 +183,16 @@ test_success=0
 
 die () {
 	code=$?
-	if test -n "$GIT_EXIT_OK"
+	if test -n "$GIT_EXIT_CODE"
 	then
-		exit $code
+		exit $GIT_EXIT_CODE
 	else
 		echo >&5 "FATAL: Unexpected exit with code $code"
 		exit 1
 	fi
 }
 
-GIT_EXIT_OK=
+GIT_EXIT_CODE=
 trap 'die' EXIT
 
 # The semantics of the editor variables are that of invoking
@@ -295,7 +295,7 @@ test_failure_ () {
 	say_color error "FAIL $test_count: $1"
 	shift
 	echo "$@" | sed -e 's/^/	/'
-	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
+	test "$immediate" = "" || { GIT_EXIT_CODE=1; exit 1; }
 }
 
 test_known_broken_ok_ () {
@@ -508,7 +508,6 @@ test_create_repo () {
 }
 
 test_done () {
-	GIT_EXIT_OK=t
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
 	test_results_path="$test_results_dir/${0%.sh}-$$"
@@ -539,9 +538,11 @@ test_done () {
 		cd "$(dirname "$remove_trash")" &&
 		rm -rf "$(basename "$remove_trash")"
 
+		GIT_EXIT_CODE=0
 		exit 0 ;;
 
 	*)
+		GIT_EXIT_CODE=1
 		say_color error "failed $test_failure among $msg"
 		exit 1 ;;
 
@@ -655,7 +656,7 @@ case "$test" in
 esac
 test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
 rm -fr "$test" || {
-	GIT_EXIT_OK=t
+	GIT_EXIT_CODE=1
 	echo >&5 "FATAL: Cannot prepare test area"
 	exit 1
 }
-- 
1.6.5.rc3
