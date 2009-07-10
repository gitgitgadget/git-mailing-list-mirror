From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI 5/5] test-lib.sh: work around ksh's trap shortcomings
Date: Fri, 10 Jul 2009 12:10:47 -0500
Message-ID: <39niBtmtFs5Sy_fjtaztVpzvYMB2VqzJqRa_5SCfycpkVR-qsHwAomyoqf7KXKH-vbxIhbJxKJM@cipher.nrlssc.navy.mil>
References: <39niBtmtFs5Sy_fjtaztVh4dAZGS3bCbUWv-xJglfvb9KPJ_qQhUB4GiCpcoxguAgbDPS36AjnI@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVmZBc5gMLjrIQhevVkHr5EAuPYiuRd5i__yABkFEZOZNG-W8HrgSclE@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVioF-DSUgPaeb2z2kLxvo9ZK1x9ZQKe11vCjlSyOtjKf_tm_u4WsJQY@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVs0m0Z6eHu_U8OSsTLFxj4rzNA1wRn0zCZA2fZ7PNTjvs9tczSQBvpc@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVnLg9Lrx8Lsu5hbcnz9Fsc7tFJx0Z7UST-sRmKU2bdVlCmfkGTgtbs4@cipher.nrlssc.navy.mil>
Cc: Brandon Casey <casey@argon.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 19:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJdz-0004x3-D3
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbZGJRMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754740AbZGJRMB
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:12:01 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57341 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbZGJRL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 13:11:58 -0400
Received: by mail.nrlssc.navy.mil id n6AHBvsq024709; Fri, 10 Jul 2009 12:11:57 -0500
In-Reply-To: <39niBtmtFs5Sy_fjtaztVnLg9Lrx8Lsu5hbcnz9Fsc7tFJx0Z7UST-sRmKU2bdVlCmfkGTgtbs4@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 10 Jul 2009 17:11:57.0271 (UTC) FILETIME=[87B58670:01CA0181]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123068>

From: Brandon Casey <casey@argon.nrlssc.navy.mil>

In ksh, if trap is called within a function with 0 or EXIT as its signal,
then the trap will be executed at the time the function returns. This
causes a problem in the test functions since 'trap - EXIT' is called
within the test_done function in order to remove the trap which calls
die() on exit. This means trap has to be called from the scripts top-level.
Do so by renaming the test_done function to test_done_func, and then,
remove the trap and call test_done_func from within a new alias named
test_done.

Additionally, there is some strangeness with respect to aliases and sourced
script files; the alias is not available within the sourced file. So call
'trap - EXIT' directly in lib-git-svn.sh before calling the test_done_func
function.
---
 t/lib-git-svn.sh |   15 ++++++++++-----
 t/test-lib.sh    |    3 ++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 5654962..c49971c 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -6,11 +6,13 @@ git_svn_id=git""-svn-id
 if test -n "$NO_SVN_TESTS"
 then
 	say 'skipping git svn tests, NO_SVN_TESTS defined'
-	test_done
+	trap - EXIT
+	test_done_func
 fi
 if ! test_have_prereq PERL; then
 	say 'skipping git svn tests, perl not available'
-	test_done
+	trap - EXIT
+	test_done_func
 fi
 
 GIT_DIR=$PWD/.git
@@ -21,7 +23,8 @@ svn >/dev/null 2>&1
 if test $? -ne 1
 then
     say 'skipping git svn tests, svn not found'
-    test_done
+    trap - EXIT
+    test_done_func
 fi
 
 svnrepo=$PWD/svnrepo
@@ -46,7 +49,8 @@ then
 		err='Perl SVN libraries not found or unusable, skipping test'
 	fi
 	say "$err"
-	test_done
+	trap - EXIT
+	test_done_func
 fi
 
 rawsvnrepo="$svnrepo"
@@ -159,7 +163,8 @@ require_svnserve () {
     if test -z "$SVNSERVE_PORT"
     then
         say 'skipping svnserve test. (set $SVNSERVE_PORT to enable)'
-        test_done
+	trap - EXIT
+	test_done_func
     fi
 }
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5fdc5d9..d7c12db 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -504,7 +504,7 @@ test_create_repo () {
 	cd "$owd"
 }
 
-test_done () {
+test_done_func () {
 	GIT_EXIT_OK=t
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
@@ -544,6 +544,7 @@ test_done () {
 
 	esac
 }
+alias test_done='trap - EXIT && test_done_func'
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
-- 
1.6.4.rc0.5.g76f7cf
