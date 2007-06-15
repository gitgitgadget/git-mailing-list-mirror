From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Let --base-path and pserver get along just fine
Date: Fri, 15 Jun 2007 03:01:52 +0200
Message-ID: <11818693133210-git-send-email-frank@lichtenheld.de>
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 03:02:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz0CX-0003fq-Rb
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 03:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbXFOBB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 21:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755394AbXFOBB5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 21:01:57 -0400
Received: from v32413.1blu.de ([88.84.155.73]:53402 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270AbXFOBB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 21:01:56 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hz0CI-0002Zr-RO; Fri, 15 Jun 2007 03:01:54 +0200
Received: from p54b0da76.dip.t-dialin.net ([84.176.218.118] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hz0CG-0006Un-Kd; Fri, 15 Jun 2007 03:01:53 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hz0CH-0004dU-MB; Fri, 15 Jun 2007 03:01:53 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: 11812282222271-git-send-email-frank@lichtenheld.de
References: 11812282222271-git-send-email-frank@lichtenheld.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50230>

Embarassing bug number one in my options patch.

Since the code for --base-path support rewrote
the cvsroot value after comparing it with a possible
existing value (i.e. from pserver authentication)
the check always failed.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl              |   10 ++++++----
 t/t9400-git-cvsserver-server.sh |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

 I can also squash these two fix-ups into the previous commit
 if preferred.

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 9fbd9db..f78afe8 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -212,15 +212,17 @@ sub req_Root
 	return 0;
     }
 
+    my $cvsroot = $state->{'base-path'} || '';
+    $cvsroot =~ s#/+$##;
+    $cvsroot .= $data;
+
     if ($state->{CVSROOT}
-	&& ($state->{CVSROOT} ne $data)) {
+	&& ($state->{CVSROOT} ne $cvsroot)) {
 	print "error 1 Conflicting roots specified\n";
 	return 0;
     }
 
-    $state->{CVSROOT} = $state->{'base-path'} || '';
-    $state->{CVSROOT} =~ s#/+$##;
-    $state->{CVSROOT} .= $data;
+    $state->{CVSROOT} = $cvsroot;
 
     $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 392f890..9b69452 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -163,6 +163,7 @@ BEGIN AUTH REQUEST
 anonymous
 
 END AUTH REQUEST
+Root /gitcvs.git
 EOF
 
 test_expect_success 'req_Root (base-path)' \
-- 
1.5.2.1
