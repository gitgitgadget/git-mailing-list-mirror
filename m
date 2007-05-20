From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 2/3] t9400: Add some more cvs update tests
Date: Mon, 21 May 2007 00:31:57 +0200
Message-ID: <11797003191512-git-send-email-frank@lichtenheld.de>
References: <11797003182642-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 00:32:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hptwj-0007Yh-4R
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425AbXETWcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757784AbXETWcI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:32:08 -0400
Received: from mail.lenk.info ([217.160.134.107]:1978 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757425AbXETWcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:32:03 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hptv1-0002jI-Rc; Mon, 21 May 2007 00:30:28 +0200
Received: from p54b0cecc.dip.t-dialin.net ([84.176.206.204] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HptwU-00058w-Od; Mon, 21 May 2007 00:31:59 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HptwV-0004Eh-CK; Mon, 21 May 2007 00:31:59 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <11797003182642-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47939>

Add some cvs update tests that include various merge
situations. Also add a basic test for update -C
since it fits so well in there.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9400-git-cvsserver-server.sh |   69 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 1b63435..e42943e 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -192,4 +192,73 @@ test_expect_success 'cvs update (re-add deleted file)' \
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
+
+cat >expected.C <<EOF
+<<<<<<< merge.mine
+Line 0
+=======
+LINE 0
+>>>>>>> merge.3
+EOF
+
+for i in 1 2 3 4 5 6 7 8
+do
+  echo Line $i >>expected.C
+done
+
+test_expect_success 'cvs update (conflict merge)' \
+  '( echo LINE 0; cat merge ) >merge.tmp &&
+   mv merge.tmp merge &&
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
1.5.2-rc3.GIT
