From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsserver: fix revision number during file adds
Date: Tue,  9 Jan 2007 15:10:41 +1300
Message-ID: <11683086411718-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jan 09 03:10:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H46Rf-0008TS-DX
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 03:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbXAICKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 21:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXAICKb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 21:10:31 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:55008 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbXAICKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 21:10:30 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1H46RZ-0003Lw-HU; Tue, 09 Jan 2007 15:10:29 +1300
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1H46Rl-0000Hm-00; Tue, 09 Jan 2007 15:10:41 +1300
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.5.0.rc0.g4017-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36296>

With this patch, cvs add / cvs commit echoes back to the client
the correct file version (1.1) so that the file in the checkout
is recognised as up-to-date.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-cvsserver.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 0b75f9c..81d478d 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1181,12 +1181,15 @@ sub req_ci
         $filename = filecleanup($filename);
 
         my $meta = $updater->getmeta($filename);
+	unless (defined $meta->{revision}) {
+	  $meta->{revision} = 1;
+	}
 
         my ( $filepart, $dirpart ) = filenamesplit($filename, 1);
 
         $log->debug("Checked-in $dirpart : $filename");
 
-        if ( $meta->{filehash} eq "deleted" )
+        if ( defined $meta->{filehash} && $meta->{filehash} eq "deleted" )
         {
             print "Remove-entry $dirpart\n";
             print "$filename\n";
-- 
1.5.0.rc0.g4017-dirty
