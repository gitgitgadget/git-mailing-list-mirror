From: Byron Bradley <byronb@picochip.com>
Subject: [PATCH] git-cvsserver: fix updates in a subdirectory
Date: Wed, 15 Apr 2009 12:23:57 +0100 (BST)
Message-ID: <alpine.LRH.2.00.0904151222100.885@dunsop.picochip.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 13:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu3Rf-0000tf-PN
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 13:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759630AbZDOLf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 07:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756801AbZDOLfz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 07:35:55 -0400
Received: from mail2.picochip.com ([82.111.145.34]:43480 "EHLO
	arun.picochip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759420AbZDOLfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 07:35:54 -0400
X-Greylist: delayed 936 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2009 07:35:54 EDT
Received: from dunsop.picochip.com (dunsop.picochip.com [172.17.1.250])
	by arun.picochip.com (8.13.1/8.13.1) with ESMTP id n3FBN6H7004066
	for <git@vger.kernel.org>; Wed, 15 Apr 2009 12:23:06 +0100
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (arun.picochip.com [172.17.0.30]); Wed, 15 Apr 2009 12:23:06 +0100 (BST)
X-Virus-Scanned: ClamAV version 0.91.2, clamav-milter version 0.91.2 on arun.picochip.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116604>


If you checkout using git-cvsserver then delete a subdirectory and
replace it with `cvs checkout -d`, the wrong folder name will be
written into CVS/Repository and a `cvs update` in that directory
will no longer work. Includes a test case.

Signed-off-by: Byron Bradley <byronb@picochip.com>
---
 git-cvsserver.perl              |    4 ++--
 t/t9400-git-cvsserver-server.sh |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index c320ee9..bb8cbc2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1117,9 +1117,9 @@ sub req_update
 		} else {
 		    # instruct client we're sending a file to put in this path as a new file
 		    print "Clear-static-directory $dirpart\n";
-		    print $state->{CVSROOT} . "/$state->{module}/$dirpart\n";
+		    print $state->{CVSROOT} . "/$state->{module}/$state->{prependdir}$dirpart\n";
 		    print "Clear-sticky $dirpart\n";
-		    print $state->{CVSROOT} . "/$state->{module}/$dirpart\n";
+		    print $state->{CVSROOT} . "/$state->{module}/$state->{prependdir}$dirpart\n";
 
 		    $log->debug("Creating new file 'Created $dirpart'");
 		    print "Created $dirpart\n";
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 64f947d..201925f 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -352,6 +352,28 @@ test_expect_success 'cvs update (re-add deleted file)' \
    diff -q testfile1 ../testfile1'
 
 cd "$WORKDIR"
+test_expect_success 'cvs update (in a subdirectory)' \
+  'mkdir -p a/b &&
+   echo testfile1 >a/b/test1 &&
+   git add a/b/test1 &&
+   git commit -q -m "Add test1" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
+   cd a &&
+   mv b b.bak &&
+   GIT_CONFIG="$git_config" cvs -Q update -d &&
+   test -d b &&
+   cd "$WORKDIR" &&
+   echo testfile2 >a/b/test1 &&
+   git add a/b/test1 &&
+   git commit -q -m "Add test1 again" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork/a/b &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
+   diff -q test1 "$WORKDIR/a/b/test1"'
+
+cd "$WORKDIR"
 test_expect_success 'cvs update (merge)' \
   'echo Line 0 >expected &&
    for i in 1 2 3 4 5 6 7
-- 
1.6.3.rc0.2.g8152.dirty
