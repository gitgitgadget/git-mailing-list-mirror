From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Actually implement --export-all
Date: Fri, 15 Jun 2007 03:01:53 +0200
Message-ID: <11818693133098-git-send-email-frank@lichtenheld.de>
References: 11812282222271-git-send-email-frank@lichtenheld.de
 <11818693133210-git-send-email-frank@lichtenheld.de>
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 03:02:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz0CY-0003fq-Bg
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 03:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbXFOBB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 21:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755473AbXFOBB6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 21:01:58 -0400
Received: from v32413.1blu.de ([88.84.155.73]:53407 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbXFOBB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 21:01:56 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hz0CJ-0002Zs-32; Fri, 15 Jun 2007 03:01:55 +0200
Received: from p54b0da76.dip.t-dialin.net ([84.176.218.118] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hz0CH-0006Uo-BU; Fri, 15 Jun 2007 03:01:53 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hz0CH-0004dW-SQ; Fri, 15 Jun 2007 03:01:53 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818693133210-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50229>

Embarrassing bug number two in my options patch.

Also enforce that --export-all is only ever used together with an
explicit whitelist. Otherwise people might export every git repository
on the whole system without realising.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |    3 ++-
 git-cvsserver.perl              |    8 +++++++-
 t/t9400-git-cvsserver-server.sh |   16 ++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 6d1e311..60d0bcf 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -38,7 +38,8 @@ Prepend 'path' to requested CVSROOT
 Don't allow recursing into subdirectories
 
 --export-all::
-Don't check for `gitcvs.enabled` in config
+Don't check for `gitcvs.enabled` in config. You also have to specify a list
+of allowed directories (see below) if you want to use this option.
 
 --version, -V::
 Print version information and exit
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index f78afe8..5cbf27e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -130,6 +130,11 @@ if (@ARGV) {
 # everything else is a directory
 $state->{allowed_roots} = [ @ARGV ];
 
+# don't export the whole system unless the users requests it
+if ($state->{'export-all'} && !@{$state->{allowed_roots}}) {
+    die "--export-all can only be used together with an explicit whitelist\n";
+}
+
 # if we are called with a pserver argument,
 # deal with the authentication cat before entering the
 # main loop
@@ -276,7 +281,8 @@ sub req_Root
 
     my $enabled = ($cfg->{gitcvs}{$state->{method}}{enabled}
 		   || $cfg->{gitcvs}{enabled});
-    unless ($enabled && $enabled =~ /^\s*(1|true|yes)\s*$/i) {
+    unless ($state->{'export-all'} ||
+	    ($enabled && $enabled =~ /^\s*(1|true|yes)\s*$/i)) {
         print "E GITCVS emulation needs to be enabled on this repo\n";
         print "E the repo config file needs a [gitcvs] section added, and the parameter 'enabled' set to 1\n";
         print "E \n";
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 9b69452..b442b5d 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -173,6 +173,22 @@ test_expect_success 'req_Root (base-path)' \
 test_expect_failure 'req_Root failure (base-path)' \
   'cat request-anonymous | git-cvsserver --strict-paths --base-path $WORKDIR pserver $SERVERDIR >log 2>&1'
 
+GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false || exit 1
+
+test_expect_success 'req_Root (export-all)' \
+  'cat request-anonymous | git-cvsserver --export-all pserver $WORKDIR >log 2>&1 &&
+   tail -n1 log | grep -q "^I LOVE YOU$"'
+
+test_expect_failure 'req_Root failure (export-all w/o whitelist)' \
+  'cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1
+   || false'
+
+test_expect_success 'req_Root (everything together)' \
+  'cat request-base | git-cvsserver --export-all --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
+   tail -n1 log | grep -q "^I LOVE YOU$"'
+
+GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true || exit 1
+
 #--------------
 # CONFIG TESTS
 #--------------
-- 
1.5.2.1
