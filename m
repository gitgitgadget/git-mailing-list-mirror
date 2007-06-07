From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Make req_Root more critical of its input data
Date: Thu,  7 Jun 2007 16:57:00 +0200
Message-ID: <1181228221959-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 16:57:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwJQM-0003Qg-7T
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 16:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759481AbXFGO5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752820AbXFGO5H
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 10:57:07 -0400
Received: from v32413.1blu.de ([88.84.155.73]:33103 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759481AbXFGO5G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 10:57:06 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HwJQ8-0000WS-Go; Thu, 07 Jun 2007 16:57:04 +0200
Received: from p54b0e234.dip.t-dialin.net ([84.176.226.52] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HwJQ7-0004RE-60; Thu, 07 Jun 2007 16:57:03 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HwJQ6-0008Gl-3q; Thu, 07 Jun 2007 16:57:02 +0200
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49373>

The path submitted with the Root request has to be absolute
(cvs does it this way and it may save us some sanity checks
later)

If multiple roots are specified (e.g. because we use
pserver authentication which will already include the
root), ensure that they say all the same.

Probably neither is a security risk, and neither should ever
be triggered by a sane client, but when validating
input data, it's better to be save than sorry.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl              |   11 +++++++++++
 t/t9400-git-cvsserver-server.sh |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 2b4825a..d41b29f 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -167,6 +167,17 @@ sub req_Root
     my ( $cmd, $data ) = @_;
     $log->debug("req_Root : $data");
 
+    unless ($data =~ m#^/#) {
+	print "error 1 Root must be an absolute pathname\n";
+	return 0;
+    }
+
+    if ($state->{CVSROOT}
+	&& ($state->{CVSROOT} ne $data)) {
+	print "error 1 Conflicting roots specified\n";
+	return 0;
+    }
+
     $state->{CVSROOT} = $data;
 
     $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e9ef315..41dcf64 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -110,6 +110,40 @@ test_expect_success 'pserver authentication failure (login/non-anonymous user)'
    tail -n1 log | grep -q "^I HATE YOU$"'
 
 
+# misuse pserver authentication for testing of req_Root
+
+cat >request-relative  <<EOF
+BEGIN AUTH REQUEST
+gitcvs.git
+anonymous
+
+END AUTH REQUEST
+EOF
+
+cat >request-conflict  <<EOF
+BEGIN AUTH REQUEST
+$SERVERDIR
+anonymous
+
+END AUTH REQUEST
+Root $WORKDIR
+EOF
+
+test_expect_success 'req_Root failure (relative pathname)' \
+  'if cat request-relative | git-cvsserver pserver >log 2>&1
+   then
+       echo unexpected success
+       false
+   else
+       true
+   fi &&
+   tail log | grep -q "^error 1 Root must be an absolute pathname$"'
+
+test_expect_success 'req_Root failure (conflicting roots)' \
+  'cat request-conflict | git-cvsserver pserver >log 2>&1 &&
+   tail log | grep -q "^error 1 Conflicting roots specified$"'
+
+
 #--------------
 # CONFIG TESTS
 #--------------
-- 
1.5.2.1
