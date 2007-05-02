From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Add test cases for git-cvsserver
Date: Wed,  2 May 2007 02:45:22 +0200
Message-ID: <1178066722390-git-send-email-frank@lichtenheld.de>
References: <7vfy6h7wsb.fsf@assigned-by-dhcp.cox.net>
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 02:45:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj2yH-0000pq-SR
	for gcvg-git@gmane.org; Wed, 02 May 2007 02:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992572AbXEBAp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 20:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992578AbXEBAp0
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 20:45:26 -0400
Received: from mail.lenk.info ([217.160.134.107]:3287 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992572AbXEBApZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 20:45:25 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hj2xM-0006Ei-7z; Wed, 02 May 2007 02:44:32 +0200
Received: from p54b0f026.dip.t-dialin.net ([84.176.240.38] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hj2y9-0008MR-Ia; Wed, 02 May 2007 02:45:21 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hj2yA-0005aG-Rx; Wed, 02 May 2007 02:45:22 +0200
X-Mailer: git-send-email 1.5.1.2
In-Reply-To: <7vfy6h7wsb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46000>

Use the :fork: access method to force cvs to
call "$CVS_SERVER server" even when accessing a local
repository.

Add a basic test for checkout and some tests for update.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9400-git-cvsserver-server.sh |  120 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 t/t9400-git-cvsserver-server.sh

 Still my first test cases so careful review and comments
 on style and implementation would be very welcome :)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
new file mode 100644
index 0000000..19b504b
--- /dev/null
+++ b/t/t9400-git-cvsserver-server.sh
@@ -0,0 +1,120 @@
+#!/bin/sh
+# 
+# Copyright (c) 2007 Frank Lichtenheld
+#
+
+test_description='git-cvsserver access
+
+tests read access to a git repository with the
+cvs CLI client via git-cvsserver server'
+
+. ./test-lib.sh
+
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+    test_expect_success 'skipping git-cvsserver tests, cvs not found' :
+    test_done
+    exit
+fi
+
+unset GIT_DIR GIT_CONFIG
+WORKDIR=$(pwd)
+SERVERDIR=$(pwd)/gitcvs.git
+CVSROOT=":fork:$SERVERDIR"
+CVSWORK=$(pwd)/cvswork
+CVS_SERVER=git-cvsserver
+export CVSROOT CVS_SERVER
+
+rm -rf "$CVSWORK" "$SERVERDIR"
+echo >empty &&
+  git add empty &&
+  git commit -q -m "First Commit" &&
+  git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+  GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+  GIT_DIR="$SERVERDIR" git config --bool gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
+  exit 1
+
+# note that cvs doesn't accept absolute pathnames
+# as argument to co -d
+test_expect_success 'basic checkout' \
+  'cvs -Q co -d cvswork master &&
+   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"'
+
+test_expect_success 'cvs update (create new file)' \
+  'echo testfile1 >testfile1 &&
+   git add testfile1 &&
+   git commit -q -m "Add testfile1" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   cvs -Q update &&
+   test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
+   diff -q testfile1 ../testfile1'
+
+cd "$WORKDIR"
+test_expect_success 'cvs update (update existing file)' \
+  'echo line 2 >>testfile1 &&
+   git add testfile1 &&
+   git commit -q -m "Append to testfile1" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   cvs -Q update &&
+   test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.2/" &&
+   diff -q testfile1 ../testfile1'
+
+cd "$WORKDIR"
+#TODO: cvsserver doesn't support update w/o -d
+test_expect_failure "cvs update w/o -d doesn't create subdir (TODO)" \
+  'mkdir test &&
+   echo >test/empty &&
+   git add test &&
+   git commit -q -m "Single Subdirectory" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   cvs -Q update &&
+   test ! -d test'
+
+cd "$WORKDIR"
+test_expect_success 'cvs update (subdirectories)' \
+  '(for dir in A A/B A/B/C A/D E; do
+      mkdir $dir &&
+      echo "test file in $dir" >"$dir/file_in_$(echo $dir|sed -e "s#/# #g")"  &&
+      git add $dir;
+   done) && 
+   git commit -q -m "deep sub directory structure" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   cvs -Q update -d &&
+   (for dir in A A/B A/B/C A/D E; do
+      filename="file_in_$(echo $dir|sed -e "s#/# #g")" &&
+      if test "$(echo $(grep -v ^D $dir/CVS/Entries|cut -d/ -f2,3,5))" = "$filename/1.1/" &&
+           diff -q "$dir/$filename" "../$dir/$filename"; then
+        :
+      else
+        echo >failure
+      fi
+    done) &&
+   test ! -f failure'
+
+cd "$WORKDIR"
+test_expect_success 'cvs update (delete file)' \
+  'git rm testfile1 &&
+   git commit -q -m "Remove testfile1" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   cvs -Q update &&
+   test -z "$(grep testfile1 CVS/Entries)" &&
+   test ! -f testfile1'
+
+cd "$WORKDIR"
+test_expect_success 'cvs update (re-add deleted file)' \
+  'echo readded testfile >testfile1 &&
+   git add testfile1 &&
+   git commit -q -m "Re-Add testfile1" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   cvs -Q update &&
+   test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.4/" &&
+   diff -q testfile1 ../testfile1'
+
+test_done
-- 
1.5.1.2
