From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] test-lib.sh: work around ksh's trap shortcomings
Date: Mon, 18 Aug 2008 18:16:11 -0500
Message-ID: <gPlIc7E6mNDrXE6mwaHXFoin7rDpLmjvuzlhJfCp-YmuyVK3pEzqNA@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:17:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDyP-00059K-Q3
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbYHRXQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbYHRXQO
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:16:14 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60911 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbYHRXQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:16:13 -0400
Received: by mail.nrlssc.navy.mil id m7INGCo0026460; Mon, 18 Aug 2008 18:16:12 -0500
In-Reply-To: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Aug 2008 23:16:11.0435 (UTC) FILETIME=[6723CFB0:01C90188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92755>

In ksh, if trap is called within a function with 0 or EXIT as its signal,
then the trap will be executed at the time the function returns. This
causes a problem in the test functions since 'trap - exit' is called
within the test_done function in order to remove the trap which calls
die() on exit. This means trap has to be called from the scripts top-level.
Do so using an alias.

Additionally, there is some strangeness with respect to aliases and
sourced script files; the alias hack doesn't work. So call 'trap - 0'
directly in lib-git-svn.sh before calling the test_done function.
---
 t/lib-git-svn.sh |    3 +++
 t/test-lib.sh    |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index a841df2..e2e8cf3 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -3,6 +3,7 @@
 if test -n "$NO_SVN_TESTS"
 then
 	test_expect_success 'skipping git-svn tests, NO_SVN_TESTS defined' :
+	trap - exit
 	test_done
 	exit
 fi
@@ -15,6 +16,7 @@ svn >/dev/null 2>&1
 if test $? -ne 1
 then
     test_expect_success 'skipping git-svn tests, svn not found' :
+    trap - exit
     test_done
     exit
 fi
@@ -39,6 +41,7 @@ then
 		err='Perl SVN libraries not found or unusable, skipping test'
 	fi
 	test_expect_success "$err" :
+	trap - exit
 	test_done
 	exit
 fi
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11c0275..6a3fc93 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -415,7 +415,6 @@ test_create_repo () {
 }
 
 test_done () {
-	trap - exit
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
 	test_results_path="$test_results_dir/${0%-*}-$$"
@@ -457,6 +456,7 @@ test_done () {
 
 	esac
 }
+alias test_done='trap - exit && test_done'
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
-- 
1.6.0.13.ge1c8
