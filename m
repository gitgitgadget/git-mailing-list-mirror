From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Handle 'cvs login'
Date: Sun, 27 May 2007 14:33:10 +0200
Message-ID: <11802692303581-git-send-email-frank@lichtenheld.de>
References: <1180269190126-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 27 14:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsICD-000432-FR
	for gcvg-git@gmane.org; Sun, 27 May 2007 14:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXE0Mtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 08:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXE0Mtq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 08:49:46 -0400
Received: from v32413.1blu.de ([88.84.155.73]:41066 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbXE0Mto (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 08:49:44 -0400
X-Greylist: delayed 981 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 May 2007 08:49:42 EDT
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HsHwy-0004fF-U4; Sun, 27 May 2007 14:34:20 +0200
Received: from p3ee3d801.dip.t-dialin.net ([62.227.216.1] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HsHwy-0007aX-3T; Sun, 27 May 2007 14:34:20 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HsHwe-0006MD-KA; Sun, 27 May 2007 14:34:00 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <1180269190126-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48534>

Since this is a trivial variation of the general pserver
authentication, there is really no reason not to support
it.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl              |    8 +++++---
 t/t9400-git-cvsserver-server.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 1de5177..2b4825a 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -95,9 +95,10 @@ $state->{method} = 'ext';
 if (@ARGV && $ARGV[0] eq 'pserver') {
     $state->{method} = 'pserver';
     my $line = <STDIN>; chomp $line;
-    unless( $line eq 'BEGIN AUTH REQUEST') {
+    unless( $line =~ /^BEGIN (AUTH|VERIFICATION) REQUEST$/) {
        die "E Do not understand $line - expecting BEGIN AUTH REQUEST\n";
     }
+    my $request = $1;
     $line = <STDIN>; chomp $line;
     req_Root('root', $line) # reuse Root
        or die "E Invalid root $line \n";
@@ -109,10 +110,11 @@ if (@ARGV && $ARGV[0] eq 'pserver') {
     }
     $line = <STDIN>; chomp $line;    # validate the password?
     $line = <STDIN>; chomp $line;
-    unless ($line eq 'END AUTH REQUEST') {
-       die "E Do not understand $line -- expecting END AUTH REQUEST\n";
+    unless ($line eq "END $request REQUEST") {
+       die "E Do not understand $line -- expecting END $request REQUEST\n";
     }
     print "I LOVE YOU\n";
+    exit if $request eq 'VERIFICATION'; # cvs login
     # and now back to our regular programme...
 }
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 76a9b1a..e9ef315 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -67,6 +67,22 @@ git
 END AUTH REQUEST
 EOF
 
+cat >login-anonymous <<EOF
+BEGIN VERIFICATION REQUEST
+$SERVERDIR
+anonymous
+
+END VERIFICATION REQUEST
+EOF
+
+cat >login-git <<EOF
+BEGIN VERIFICATION REQUEST
+$SERVERDIR
+git
+
+END VERIFICATION REQUEST
+EOF
+
 test_expect_success 'pserver authentication' \
   'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
    tail -n1 log | grep -q "^I LOVE YOU$"'
@@ -80,6 +96,19 @@ test_expect_success 'pserver authentication failure (non-anonymous user)' \
    fi &&
    tail -n1 log | grep -q "^I HATE YOU$"'
 
+test_expect_success 'pserver authentication (login)' \
+  'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
+   tail -n1 log | grep -q "^I LOVE YOU$"'
+
+test_expect_success 'pserver authentication failure (login/non-anonymous user)' \
+  'if cat login-git | git-cvsserver pserver >log 2>&1
+   then
+       false
+   else
+       true
+   fi &&
+   tail -n1 log | grep -q "^I HATE YOU$"'
+
 
 #--------------
 # CONFIG TESTS
-- 
1.5.2-rc3.GIT
