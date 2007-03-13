From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: further improve messages on commit and status
Date: Tue, 13 Mar 2007 18:25:23 +0100
Message-ID: <11738067231730-git-send-email-frank@lichtenheld.de>
References: <11738067233199-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 18:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRAzB-0000iN-Cx
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 18:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbXCMRkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 13:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbXCMRkL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 13:40:11 -0400
Received: from mail.lenk.info ([217.160.134.107]:61354 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbXCMRkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 13:40:09 -0400
X-Greylist: delayed 871 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2007 13:40:08 EDT
Received: from p54b0dfde.dip.t-dialin.net ([84.176.223.222] helo=goedel.djpig.de)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HRAp5-0001ap-DJ; Tue, 13 Mar 2007 18:30:07 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HRAkW-0003lB-0x; Tue, 13 Mar 2007 18:25:24 +0100
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <11738067233199-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42137>

commit: Also print the old revision similar to how cvs does it and
prepend a line stating the filename so that one can actually
understand what happened when commiting more than one file.

status: Fix the RCS filename displayed. The directory was
printed twice.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index f21f2f1..68aa752 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1069,6 +1069,7 @@ sub req_ci
     $log->info("Created index '$file_index' with for head $state->{module} - exit status $?");
 
     my @committedfiles = ();
+    my %oldmeta;
 
     # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
@@ -1079,6 +1080,7 @@ sub req_ci
         next unless ( exists $state->{entries}{$filename}{modified_filename} or not $state->{entries}{$filename}{unchanged} );
 
         my $meta = $updater->getmeta($filename);
+	$oldmeta{$filename} = $meta;
 
         my $wrev = revparse($filename);
 
@@ -1207,16 +1209,17 @@ sub req_ci
 
         $log->debug("Checked-in $dirpart : $filename");
 
+	print "M $state->{CVSROOT}/$state->{module}/$filename,v  <--  $dirpart$filepart\n";
         if ( defined $meta->{filehash} && $meta->{filehash} eq "deleted" )
         {
-            print "M new revision: delete\n";
+            print "M new revision: delete; previous revision: 1.$oldmeta{$filename}{revision}\n";
             print "Remove-entry $dirpart\n";
             print "$filename\n";
         } else {
             if ($meta->{revision} == 1) {
 	        print "M initial revision: 1.1\n";
             } else {
-	        print "M new revision: 1.$meta->{revision}\n";
+	        print "M new revision: 1.$meta->{revision}; previous revision: 1.$oldmeta{$filename}{revision}\n";
             }
             print "Checked-in $dirpart\n";
             print "$filename\n";
@@ -1303,7 +1306,7 @@ sub req_status
         }
         if ( defined($meta->{revision}) )
         {
-            print "M Repository revision:\t1." . $meta->{revision} . "\t$state->{repository}/$filename,v\n";
+            print "M Repository revision:\t1." . $meta->{revision} . "\t$state->{CVSROOT}/$state->{module}/$filename,v\n";
             print "M Sticky Tag:\t\t(none)\n";
             print "M Sticky Date:\t\t(none)\n";
             print "M Sticky Options:\t\t(none)\n";
-- 
1.5.0.3
