From: Junio Hamano <junio@twinsun.com>
Subject: [PATCH] t9400: Use the repository config and nothing else.
Date: Fri, 11 May 2007 16:35:18 -0700
Message-ID: <7v8xbvj5mx.fsf@arte.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat May 12 02:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmf4U-0007I6-8P
	for gcvg-git@gmane.org; Sat, 12 May 2007 02:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370AbXELACQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 20:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756260AbXELACQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 20:02:16 -0400
Received: from alioth.twinsun.com ([66.80.53.59]:56255 "EHLO
	alioth.twinsun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbXELACP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 20:02:15 -0400
X-Greylist: delayed 1614 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 May 2007 20:02:15 EDT
Received: from sic.twinsun.com ([192.54.239.17])
	by alioth.twinsun.com (8.13.4/8.13.4) with ESMTP id l4BNZIBn031424;
	Fri, 11 May 2007 16:35:18 -0700 (PDT)
Received: from pete.twinsun.com (pete.twinsun.com [192.54.239.43])
	by sic.twinsun.com (8.11.7p3+Sun/8.11.7) with SMTP id l4BNZJE19318;
	Fri, 11 May 2007 16:35:19 -0700 (PDT)
Received: from arte.twinsun.com ([192.54.239.5])
 by pete.twinsun.com (SMSSMTP 4.1.0.19) with SMTP id M2007051116351609221
 ; Fri, 11 May 2007 16:35:16 -0700
Received: from junio by arte.twinsun.com with local (Exim 4.63)
	(envelope-from <junio@twinsun.com>)
	id 1Hmedq-0003GJ-4H; Fri, 11 May 2007 16:35:18 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46996>

git-cvsserver has a bug in its configuration file output parser
that makes it choke if the configuration has these:

        [diff]
                color = auto
        [diff.color]
                whitespace = blue reverse

This needs to be fixed, but thanks to that bug, a separate bug
in t9400 test script was discovered.  The test discarded
GIT_CONFIG instead of pointing at the proper one to be used in
the exoprted repository.  This allowed user's .gitconfig and (if
exists) systemwide /etc/gitconfig to affect the outcome of the
test, which is a big no-no.

The patch fixes the problem in the test.  Fixing the
git-cvsserver's configuration parser is left as an exercise to
motivated volunteers ;-)

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I think the fix to git-cvsserver should be straightforward.
   Instead of parsing two or three level names in a hierarchical
   hash around ll.187-192 for *all* config items, it should just
   parse gitcvs related ones only, as that are the only ones
   that the script cares about.

 t/t9400-git-cvsserver-server.sh |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index f137b30..b136a97 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -26,6 +26,7 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
 unset GIT_DIR GIT_CONFIG
 WORKDIR=$(pwd)
 SERVERDIR=$(pwd)/gitcvs.git
+git_config=$SERVERDIR/config
 CVSROOT=":fork:$SERVERDIR"
 CVSWORK=$(pwd)/cvswork
 CVS_SERVER=git-cvsserver
@@ -43,7 +44,7 @@ echo >empty &&
 # note that cvs doesn't accept absolute pathnames
 # as argument to co -d
 test_expect_success 'basic checkout' \
-  'cvs -Q co -d cvswork master &&
+  'GIT_CONFIG="$git_config" cvs -Q co -d cvswork master &&
    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"'
 
 test_expect_success 'cvs update (create new file)' \
@@ -52,7 +53,7 @@ test_expect_success 'cvs update (create new file)' \
    git commit -q -m "Add testfile1" &&
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
-   cvs -Q update &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
    diff -q testfile1 ../testfile1'
 
@@ -63,7 +64,7 @@ test_expect_success 'cvs update (update existing file)' \
    git commit -q -m "Append to testfile1" &&
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
-   cvs -Q update &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.2/" &&
    diff -q testfile1 ../testfile1'
 
@@ -76,7 +77,7 @@ test_expect_failure "cvs update w/o -d doesn't create subdir (TODO)" \
    git commit -q -m "Single Subdirectory" &&
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
-   cvs -Q update &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
    test ! -d test'
 
 cd "$WORKDIR"
@@ -89,7 +90,7 @@ test_expect_success 'cvs update (subdirectories)' \
    git commit -q -m "deep sub directory structure" &&
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
-   cvs -Q update -d &&
+   GIT_CONFIG="$git_config" cvs -Q update -d &&
    (for dir in A A/B A/B/C A/D E; do
       filename="file_in_$(echo $dir|sed -e "s#/# #g")" &&
       if test "$(echo $(grep -v ^D $dir/CVS/Entries|cut -d/ -f2,3,5))" = "$filename/1.1/" &&
@@ -107,7 +108,7 @@ test_expect_success 'cvs update (delete file)' \
    git commit -q -m "Remove testfile1" &&
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
-   cvs -Q update &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
    test -z "$(grep testfile1 CVS/Entries)" &&
    test ! -f testfile1'
 
@@ -118,7 +119,7 @@ test_expect_success 'cvs update (re-add deleted file)' \
    git commit -q -m "Re-Add testfile1" &&
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
-   cvs -Q update &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.4/" &&
    diff -q testfile1 ../testfile1'
 
