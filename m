From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 1/3] t9400: Add test cases for config file handling
Date: Mon, 21 May 2007 00:31:56 +0200
Message-ID: <11797003182642-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 00:32:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hptwi-0007Yh-KQ
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645AbXETWcG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757681AbXETWcG
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:32:06 -0400
Received: from mail.lenk.info ([217.160.134.107]:2640 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756930AbXETWcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:32:03 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hptv1-0002jH-Ra; Mon, 21 May 2007 00:30:28 +0200
Received: from p54b0cecc.dip.t-dialin.net ([84.176.206.204] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HptwU-00058v-IK; Mon, 21 May 2007 00:31:58 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HptwV-0004Ef-2a; Mon, 21 May 2007 00:31:59 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47940>

Add a few test cases for the config file parsing
done by git-cvsserver.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9400-git-cvsserver-server.sh |   69 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

 Note that this currently has one failing test. This will need
 to be fixed in git-cvsserver though.

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index d406a88..1b63435 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -47,6 +47,75 @@ test_expect_success 'basic checkout' \
   'GIT_CONFIG="$git_config" cvs -Q co -d cvswork master &&
    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"'
 
+#--------------
+# CONFIG TESTS
+#--------------
+
+test_expect_success 'gitcvs.enabled = false' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
+   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1
+   then
+     echo unexpected cvs success
+     false
+   else
+     true
+   fi &&
+   cat cvs.log | grep -q "GITCVS emulation disabled" &&
+   test ! -d cvswork2'
+
+rm -fr cvswork2
+test_expect_success 'gitcvs.ext.enabled = true' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
+   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
+   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+   diff -q cvswork cvswork2'
+
+rm -fr cvswork2
+test_expect_success 'gitcvs.ext.enabled = false' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled false &&
+   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1
+   then
+     echo unexpected cvs success
+     false
+   else
+     true
+   fi &&
+   cat cvs.log | grep -q "GITCVS emulation disabled" &&
+   test ! -d cvswork2'
+
+rm -fr cvswork2
+test_expect_success 'gitcvs.dbname' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
+   GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
+   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+   diff -q cvswork cvswork2 &&
+   test -f "$SERVERDIR/gitcvs.ext.master.sqlite" &&
+   cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs.ext.master.sqlite"'
+
+rm -fr cvswork2
+test_expect_success 'gitcvs.ext.dbname' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
+   GIT_DIR="$SERVERDIR" git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
+   GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
+   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+   diff -q cvswork cvswork2 &&
+   test -f "$SERVERDIR/gitcvs1.ext.master.sqlite" &&
+   test ! -f "$SERVERDIR/gitcvs2.ext.master.sqlite" &&
+   cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs1.ext.master.sqlite"'
+
+
+#------------
+# CVS UPDATE
+#------------
+
+rm -fr "$SERVERDIR"
+cd "$WORKDIR" &&
+git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+GIT_DIR="$SERVERDIR" git config --bool gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
+exit 1
+
 test_expect_success 'cvs update (create new file)' \
   'echo testfile1 >testfile1 &&
    git add testfile1 &&
-- 
1.5.2-rc3.GIT
