From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Fix req_update to handle packed refs
Date: Thu,  4 Oct 2007 21:21:20 +0200
Message-ID: <1191525680-10481-1-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 21:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdWGk-0007dZ-1t
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 21:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768AbXJDTV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756303AbXJDTV0
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 15:21:26 -0400
Received: from v32413.1blu.de ([88.84.155.73]:35382 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261AbXJDTVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 15:21:25 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1IdWGB-00024N-HS; Thu, 04 Oct 2007 21:21:23 +0200
Received: from p57b249f5.dip.t-dialin.net ([87.178.73.245] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1IdWG7-0002Nf-20; Thu, 04 Oct 2007 21:21:19 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1IdWG8-0002jH-Mv; Thu, 04 Oct 2007 21:21:23 +0200
X-Mailer: git-send-email 1.5.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59996>

cvsserver returns a list of existing modules on command
'update' without a module specified (apparently this is
used by some clients to get a list of available modules,
the CVS cli client doesn't support it).

Fix this code to work correctly in presence of packed refs.
(Use git-branch instead of reading refs/heads/)

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl              |   20 +++++++++-----------
 t/t9400-git-cvsserver-server.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 11 deletions(-)

 Found while testing Johannes' patch. Is that a sane use of git-branch?

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7fff18b..acf2e5f 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -914,19 +914,17 @@ sub req_update
     # projects (heads in this case) to checkout.
     #
     if ($state->{module} eq '') {
-	my $heads_dir = $state->{CVSROOT} . '/refs/heads';
-	if (!opendir HEADS, $heads_dir) {
-	    print "E [server aborted]: Failed to open directory, "
-	      . "$heads_dir: $!\nerror\n";
-	    return 0;
+	my @branches = `git branch`;
+	if ($?) {
+	    print "E [server aborted]: git branch failed\nerror\n";
+	    return;
 	}
-        print "E cvs update: Updating .\n";
-	while (my $head = readdir(HEADS)) {
-	    if (-f $state->{CVSROOT} . '/refs/heads/' . $head) {
-	        print "E cvs update: New directory `$head'\n";
-	    }
+	foreach (@branches) {
+	    chomp;
+	    s/^\*//;
+	    s/^\s+//;
+	    print "E cvs update: New directory `$_'\n";
 	}
-	closedir HEADS;
 	print "ok\n";
 	return 1;
     }
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 11def84..106a696 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -447,4 +447,30 @@ test_expect_success 'cvs update (merge no-op)' \
     GIT_CONFIG="$git_config" cvs -Q update &&
     diff -q merge ../merge'
 
+cd "$WORKDIR"
+cat <<EOF >list-modules-cmd
+Root $SERVERDIR
+Valid-responses ok error Valid-requests Force-gzip Referrer Redirect Checked-in New-entry Checksum Copy-file Updated Created Update-existing Merged Patched Rcs-diff Mode Mod-time Removed Remove-entry Set-static-directory Clear-static-directory Set-sticky Clear-sticky Edit-file Template Clear-template Notified Module-expansion Wrapper-rcsOption M Mbinary E F MT
+Global_option -q
+Directory .
+$WORKDIR
+update
+EOF
+
+echo \`master\' >modules-list.exp
+
+# can't do these with the CVS cli client, but others clients
+# use that feature
+test_expect_success 'cvs update (no arg)' \
+   'cat list-modules-cmd | git-cvsserver |
+    sed -n "s/^E cvs update: New directory //p" >modules-list &&
+    diff -q modules-list modules-list.exp'
+
+test_expect_success 'cvs update (no arg/packed refs)' \
+   'GIT_DIR="$SERVERDIR" git gc &&
+    test ! -f "$SERVERDIR/refs/heads/master" &&
+    cat list-modules-cmd | git-cvsserver |
+    sed -n "s/^E cvs update: New directory //p" >modules-list &&
+    diff -q modules-list modules-list.exp'
+    
 test_done
-- 
1.5.3.3
