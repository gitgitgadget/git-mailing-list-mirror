From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH WIP] t/test-lib.sh: support Korn shell by converting GIT_EXIT_OK to GIT_EXIT_CODE
Date: Fri,  2 Apr 2010 07:39:45 -0800
Message-ID: <kDdFf7r0jMi5GOJtQmTmiPdipx954DDuqFx6fJjMgLSspBES0K_moFKS75tCcQr2Dv5Zpb4KUWLzIVX61GA2Ug@cipher.nrlssc.navy.mil>
References: <h2md2d39d861004020812t8463e4f8zbc825bd220fef961@mail.gmail.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Apr 02 17:36:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxivC-0000Gu-Rt
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 17:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab0DBPga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 11:36:30 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58196 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab0DBPg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 11:36:28 -0400
Received: by mail.nrlssc.navy.mil id o32FaCRD007693; Fri, 2 Apr 2010 10:36:12 -0500
In-Reply-To: <h2md2d39d861004020812t8463e4f8zbc825bd220fef961@mail.gmail.com>
X-OriginalArrivalTime: 02 Apr 2010 15:36:12.0367 (UTC) FILETIME=[395C3DF0:01CAD27A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143820>

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

The die() function still prints out the value of $? in the "unexpected exit"
branch, but this value will not be valid under these broken versions of the
Korn shell.

Incorporates suggestions from Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


On 04/02/2010 10:12 AM, Tor Arntsen wrote:
> On Fri, Apr 2, 2010 at 16:56, Brandon Casey
> <brandon.casey.ctr@nrlssc.navy.mil> wrote:
> 
>> Here's another snippet which will show whether $? has the correct
>> value inside a trap on EXIT:
>>
>>   (atrap () { exit $?; }
>>    trap atrap EXIT
>>    exit 1) && echo 'FAILURE' || echo 'SUCCESS'
>>
>> If that prints 'FAILURE', then you will need the patch that I have in
>> order to run the test suite.  ksh from IRIX 6.5 and Solaris both fail.
> 
> It's 'FAILURE' on Tru64 V5.1. I've confirmed 'FAILURE' on IRIX 6.5.30
> and older too, as well as IRIX 6.2 and Solaris 10. And AIX 5.1 plus
> AIX 6.2. in fact I've only got 'SUCCESS' on Linux (pdksh)...

You'll need this patch to run the test suite.

-brandon


 t/test-lib.sh |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c582964..8761586 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -164,8 +164,7 @@ fi
 
 error () {
 	say_color error "error: $*"
-	GIT_EXIT_OK=t
-	exit 1
+	expected_exit 1
 }
 
 say () {
@@ -195,18 +194,23 @@ test_fixed=0
 test_broken=0
 test_success=0
 
+expected_exit () {
+	GIT_EXIT_CODE=$1
+	exit "$1"
+}
+
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
@@ -336,7 +340,7 @@ test_failure_ () {
 	say_color error "FAIL $test_count: $1"
 	shift
 	echo "$@" | sed -e 's/^/	/'
-	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
+	test "$immediate" = "" || { expected_exit 1; }
 }
 
 test_known_broken_ok_ () {
@@ -549,7 +553,6 @@ test_create_repo () {
 }
 
 test_done () {
-	GIT_EXIT_OK=t
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
 	test_results_path="$test_results_dir/${0%.sh}-$$"
@@ -580,11 +583,11 @@ test_done () {
 		cd "$(dirname "$remove_trash")" &&
 		rm -rf "$(basename "$remove_trash")"
 
-		exit 0 ;;
+		expected_exit 0 ;;
 
 	*)
 		say_color error "failed $test_failure among $msg"
-		exit 1 ;;
+		expected_exit 1 ;;
 
 	esac
 }
@@ -712,9 +715,8 @@ case "$test" in
 esac
 test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
 rm -fr "$test" || {
-	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
-	exit 1
+	expected_exit 1
 }
 
 test_create_repo "$test"
-- 
1.6.6.2
