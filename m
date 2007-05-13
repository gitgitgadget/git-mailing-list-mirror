From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] t9400: Add some more cvs update tests
Date: Sun, 13 May 2007 19:49:25 +0200
Message-ID: <1179078566806-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 19:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnICM-00017B-5L
	for gcvg-git@gmane.org; Sun, 13 May 2007 19:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbXEMRt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 13:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbXEMRt3
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 13:49:29 -0400
Received: from mail.lenk.info ([217.160.134.107]:3341 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698AbXEMRt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 13:49:28 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HnIB0-0006pu-5e; Sun, 13 May 2007 19:48:10 +0200
Received: from p54b0dc82.dip.t-dialin.net ([84.176.220.130] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HnICE-00030s-3o; Sun, 13 May 2007 19:49:26 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HnICE-000208-93; Sun, 13 May 2007 19:49:26 +0200
X-Mailer: git-send-email 1.5.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47156>

Add some cvs update tests that include various merge
situations. Also add a basic test for update -C
since it fits so well in there.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9400-git-cvsserver-server.sh |   66 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index d406a88..1d40ee8 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -123,4 +123,70 @@ test_expect_success 'cvs update (re-add deleted file)' \
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.4/" &&
    diff -q testfile1 ../testfile1'
 
+cd "$WORKDIR"
+test_expect_success 'cvs update (merge)' \
+  'echo Line 0 >expected &&
+   for i in 1 2 3 4 5 6 7
+   do
+     echo Line $i >>merge
+     echo Line $i >>expected
+   done &&
+   echo Line 8 >>expected &&
+   git add merge &&
+   git commit -q -m "Merge test (pre-merge)" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
+   test "$(echo $(grep merge CVS/Entries|cut -d/ -f2,3,5))" = "merge/1.1/" &&
+   diff -q merge ../merge &&
+   ( echo Line 0; cat merge ) >merge.tmp &&
+   mv merge.tmp merge &&  
+   cd "$WORKDIR" &&
+   echo Line 8 >>merge &&
+   git add merge &&
+   git commit -q -m "Merge test (merge)" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
+   diff -q merge ../expected'
+
+cd "$WORKDIR"
+test_expect_success 'cvs update (conflict merge)' \
+  '( echo LINE 0; cat merge ) >merge.tmp &&
+   mv merge.tmp merge &&
+   cat >expected.C <<EOF &&
+<<<<<<< merge.mine
+Line 0
+=======
+LINE 0
+>>>>>>> merge.3
+EOF
+   for i in 1 2 3 4 5 6 7 8
+   do
+     echo Line $i >>expected.C
+   done &&
+   git add merge &&
+   git commit -q -m "Merge test (conflict)" &&
+   git push gitcvs.git >/dev/null &&
+   cd cvswork &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
+   diff -q merge ../expected.C'
+
+cd "$WORKDIR"
+test_expect_success 'cvs update (-C)' \
+  'cd cvswork &&
+   GIT_CONFIG="$git_config" cvs -Q update -C &&
+   diff -q merge ../merge'
+
+cd "$WORKDIR"
+test_expect_success 'cvs update (merge no-op)' \
+   'echo Line 9 >>merge &&
+    cp merge cvswork/merge &&
+    git add merge &&
+    git commit -q -m "Merge test (no-op)" &&
+    git push gitcvs.git >/dev/null &&
+    cd cvswork &&
+    GIT_CONFIG="$git_config" cvs -Q update &&
+    diff -q merge ../merge'
+
 test_done
-- 
1.5.1.4
