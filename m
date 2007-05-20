From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 3/3] t9400: Add some basic pserver tests
Date: Mon, 21 May 2007 00:31:58 +0200
Message-ID: <11797003193447-git-send-email-frank@lichtenheld.de>
References: <11797003182642-git-send-email-frank@lichtenheld.de>
 <11797003191512-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 00:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hptwi-0007Yh-3v
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757112AbXETWcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757681AbXETWcE
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:32:04 -0400
Received: from mail.lenk.info ([217.160.134.107]:1140 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757112AbXETWcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:32:03 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hptv2-0002jJ-0r; Mon, 21 May 2007 00:30:28 +0200
Received: from p54b0cecc.dip.t-dialin.net ([84.176.206.204] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HptwV-000592-1F; Mon, 21 May 2007 00:31:59 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HptwV-0004Ek-Fv; Mon, 21 May 2007 00:31:59 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <11797003191512-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47941>

While we can easily test the cvs <-> git-cvsserver
communication with :fork: and git-cvsserver server
there are some pserver specifics we should test, too.

Currently this are two tests of the pserver authentication.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9400-git-cvsserver-server.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e42943e..7f9c6e2 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -47,6 +47,40 @@ test_expect_success 'basic checkout' \
   'GIT_CONFIG="$git_config" cvs -Q co -d cvswork master &&
    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"'
 
+#------------------------
+# PSERVER AUTHENTICATION
+#------------------------
+
+cat >request-anonymous  <<EOF
+BEGIN AUTH REQUEST
+$SERVERDIR
+anonymous
+
+END AUTH REQUEST
+EOF
+
+cat >request-git  <<EOF
+BEGIN AUTH REQUEST
+$SERVERDIR
+git
+
+END AUTH REQUEST
+EOF
+
+test_expect_success 'pserver authentication' \
+  'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
+   tail -n1 log | grep -q "^I LOVE YOU$"'
+
+test_expect_success 'pserver authentication failure (non-anonymous user)' \
+  'if cat request-git | git-cvsserver pserver >log 2>&1
+   then
+       false
+   else
+       true
+   fi &&
+   tail -n1 log | grep -q "^I HATE YOU$"'
+
+
 #--------------
 # CONFIG TESTS
 #--------------
-- 
1.5.2-rc3.GIT
