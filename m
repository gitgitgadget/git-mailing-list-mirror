From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Allow to "add" a removed file
Date: Thu, 12 Apr 2007 00:51:33 +0200
Message-ID: <11763318932426-git-send-email-frank@lichtenheld.de>
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 00:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hblgf-0008Ok-53
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 00:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161331AbXDKWxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 18:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161329AbXDKWxJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 18:53:09 -0400
Received: from mail.lenk.info ([217.160.134.107]:3072 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161331AbXDKWxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 18:53:08 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HblgP-0006NA-Kg; Thu, 12 Apr 2007 00:52:58 +0200
Received: from p54b0c83b.dip.t-dialin.net ([84.176.200.59] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HblgU-0007sm-8m; Thu, 12 Apr 2007 00:53:02 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hblf3-0001Tc-4m; Thu, 12 Apr 2007 00:51:33 +0200
X-Mailer: git-send-email 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44272>

CVS allows you to add a removed file (where the
removal is not yet committed) which will
cause the server to send the latest revision of the
file and to delete the "removed" status.

Copy this behaviour.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

 Something I noted during my regression tests for my previous
 patch.

 Note: if you added back the file prior to calling 'cvs add'
 you will get a

 cvs add: move away `./testfile'; it is in the way
 C testfile

 which is not exactly what the original CVS does:

 cvs add: `testfile' should be removed and is still there (or is back again)

 but near enough so that I didn't care much about recreating
 that part yet.

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 25816c5..eeadf3d 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -350,12 +350,52 @@ sub req_add
 
     argsplit("add");
 
+    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    $updater->update();
+
+    argsfromdir($updater);
+
     my $addcount = 0;
 
     foreach my $filename ( @{$state->{args}} )
     {
         $filename = filecleanup($filename);
 
+        my $meta = $updater->getmeta($filename);
+        my $wrev = revparse($filename);
+
+        if ($wrev && $meta && ($wrev < 0))
+        {
+            # previously removed file, add back
+            $log->info("added file $filename was previously removed, send 1.$meta->{revision}");
+
+            print "MT +updated\n";
+            print "MT text U \n";
+            print "MT fname $filename\n";
+            print "MT newline\n";
+            print "MT -updated\n";
+
+            unless ( $state->{globaloptions}{-n} )
+            {
+                my ( $filepart, $dirpart ) = filenamesplit($filename,1);
+
+                print "Created $dirpart\n";
+                print $state->{CVSROOT} . "/$state->{module}/$filename\n";
+
+                # this is an "entries" line
+                my $kopts = kopts_from_path($filepart);
+                $log->debug("/$filepart/1.$meta->{revision}//$kopts/");
+                print "/$filepart/1.$meta->{revision}//$kopts/\n";
+                # permissions
+                $log->debug("SEND : u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}");
+                print "u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}\n";
+                # transmit file
+                transmitfile($meta->{filehash});
+            }
+
+            next;
+        }
+
         unless ( defined ( $state->{entries}{$filename}{modified_filename} ) )
         {
             print "E cvs add: nothing known about `$filename'\n";
-- 
1.5.1
