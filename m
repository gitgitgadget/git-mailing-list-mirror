From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: added support for update -p
Date: Thu, 11 Oct 2007 18:36:13 +0200
Message-ID: <1192120573-16765-1-git-send-email-frank@lichtenheld.de>
References: <200710101316.03633.jan@swi-prolog.org>
Cc: Junio C Hamano <junkio@cox.net>,
	Jan Wielemaker <jan@swi-prolog.org>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 18:43:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig18G-0003Q8-KR
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 18:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbXJKQnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 12:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbXJKQnX
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 12:43:23 -0400
Received: from v32413.1blu.de ([88.84.155.73]:37298 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbXJKQnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 12:43:22 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Ig11B-0001LU-Vb; Thu, 11 Oct 2007 18:36:32 +0200
Received: from p54b04cd5.dip.t-dialin.net ([84.176.76.213] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Ig118-0006ig-FU; Thu, 11 Oct 2007 18:36:10 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.68)
	(envelope-from <frank@lichtenheld.de>)
	id 1Ig11B-0004Md-6v; Thu, 11 Oct 2007 18:36:13 +0200
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <200710101316.03633.jan@swi-prolog.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60612>

Based on a patch by Jan Wielemaker <jan@swi-prolog.org>.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl              |   23 +++++++++++++++++++++++
 t/t9400-git-cvsserver-server.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)

 Test cases added and fixed behaviour for non-existant files.

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 2e112fa..7374875 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -973,6 +973,29 @@ sub req_update
             $meta = $updater->getmeta($filename);
         }
 
+	# if we have a -p we should just send the file
+	if ( exists ( $state->{opt}{p} ) )
+	{
+	    if (! defined $meta)
+	    {
+		# non-existant files are ignored
+		print "E cvs update: nothing known about `$filename'\n";
+		next;
+	    }
+	    if ( open my $fh, '-|', "git-cat-file", "blob", $meta->{filehash} )
+	    {
+		while ( <$fh> )
+		{
+		    print "M $_";
+		}
+		close $fh or die ("Couldn't close filehandle: $!");
+	    } else {
+		die("Couldn't execute git-cat-file");
+	    }
+
+	    next;
+	}
+
 	if ( ! defined $meta )
 	{
 	    $meta = {
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index ee58c0f..4f45578 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -446,6 +446,38 @@ test_expect_success 'cvs update (merge no-op)' \
     diff -q merge ../merge'
 
 cd "$WORKDIR"
+test_expect_success 'cvs update (-p)' \
+  'cd cvswork &&
+   GIT_CONFIG="$git_config" cvs -Q update -p merge non-existant testfile1 empty >log &&
+   cat merge testfile1 empty >../expected &&
+   diff -q log ../expected'
+
+cd "$WORKDIR"
+test_expect_success 'cvs update (-p -r)' \
+  'echo testfile1 >expected &&
+   for i in 1 2 3 4 5 6 7
+   do
+     echo Line $i >>expected
+   done &&
+   echo >>expected &&
+   cd cvswork &&
+   GIT_CONFIG="$git_config" cvs -Q update -p -r1.1 testfile1 merge empty >log &&
+   diff -q log ../expected'
+
+cd "$WORKDIR"
+test_expect_success 'cvs update (-p unclean and out-of-date)' \
+  'echo testfile2 >testfile2 &&
+   echo Line 10 >>merge &&
+   git add testfile2 merge &&
+   git commit -q -m "update -p" &&
+   git push gitcvs.git >/dev/null &&
+   cat testfile2 merge >expected &&
+   cd cvswork &&
+   echo "Line 10 workdir" >>merge
+   GIT_CONFIG="$git_config" cvs -Q update -p testfile2 merge >log &&
+   diff -q log ../expected'
+
+cd "$WORKDIR"
 cat <<EOF >list-modules-cmd
 Root $SERVERDIR
 Valid-responses ok error Valid-requests Force-gzip Referrer Redirect Checked-in New-entry Checksum Copy-file Updated Created Update-existing Merged Patched Rcs-diff Mode Mod-time Removed Remove-entry Set-static-directory Clear-static-directory Set-sticky Clear-sticky Edit-file Template Clear-template Notified Module-expansion Wrapper-rcsOption M Mbinary E F MT
-- 
1.5.3.4
