From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] t9400: Add some tests for checkout
Date: Thu,  4 Oct 2007 20:13:45 +0200
Message-ID: <1191521625-2597-1-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 20:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdVb1-00047A-F4
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 20:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758919AbXJDSid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 14:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759230AbXJDSid
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 14:38:33 -0400
Received: from v32413.1blu.de ([88.84.155.73]:59700 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758883AbXJDSia (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 14:38:30 -0400
X-Greylist: delayed 1172 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2007 14:38:30 EDT
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1IdVCl-0003Xn-K8; Thu, 04 Oct 2007 20:13:48 +0200
Received: from p57b249f5.dip.t-dialin.net ([87.178.73.245] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1IdVCg-00084w-KM; Thu, 04 Oct 2007 20:13:42 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1IdVCj-0000g7-QE; Thu, 04 Oct 2007 20:13:45 +0200
X-Mailer: git-send-email 1.5.3.3
In-Reply-To: Pine.LNX.4.64.0710041731550.4174@racer.site
References: Pine.LNX.4.64.0710041731550.4174@racer.site
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59993>

Test the behaviour for non-branches (e.g. head) and
non-existant branches. Also make a test checkout with
packed refs.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9400-git-cvsserver-server.sh |   48 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 641303e..11def84 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -246,11 +246,50 @@ test_expect_success 'gitcvs.ext.dbname' \
    test ! -f "$SERVERDIR/gitcvs2.ext.master.sqlite" &&
    cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs1.ext.master.sqlite"'
 
+# clean up
+rm -fr cvswork2
+rm -fr "$SERVERDIR"
+cd "$WORKDIR" &&
+git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
+exit 1
 
-#------------
-# CVS UPDATE
-#------------
+#--------------
+# CVS CHECKOUT
+#--------------
+test_expect_success 'cvs checkout failure (HEAD)' \
+  'if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 HEAD >cvs.log 2>&1
+   then
+     echo unexpected cvs success
+     false
+   else
+     true
+   fi &&
+   cat cvs.log | grep -q "not a branch" &&
+   test ! -d cvswork2'
+rm -fr cvswork2
 
+test_expect_success 'cvs checkout failure (foobar)' \
+  'if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 foobar >cvs.log 2>&1
+   then
+     echo unexpected cvs success
+     false
+   else
+     true
+   fi &&
+   cat cvs.log | grep -q "not a branch" &&
+   test ! -d cvswork2'
+rm -fr cvswork2
+
+test_expect_success 'cvs checkout (packed ref)' \
+  'GIT_DIR="$SERVERDIR" git-gc &&
+   test ! -f "$SERVERDIR/refs/heads/master" &&
+   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+   diff -qr cvswork cvswork2'
+
+# clean up
+rm -fr cvswork2
 rm -fr "$SERVERDIR"
 cd "$WORKDIR" &&
 git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
@@ -258,6 +297,9 @@ GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
 GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
 exit 1
 
+#------------
+# CVS UPDATE
+#------------
 test_expect_success 'cvs update (create new file)' \
   'echo testfile1 >testfile1 &&
    git add testfile1 &&
-- 
1.5.3.3
