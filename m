From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cvsserver: Show correct letters for modified, removed and
 added files
Date: Wed, 11 Oct 2006 00:20:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610110019400.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 00:21:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXPxz-0007rV-8m
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbWJJWUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 18:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030579AbWJJWUs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:20:48 -0400
Received: from mail.gmx.de ([213.165.64.20]:36076 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030574AbWJJWUq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 18:20:46 -0400
Received: (qmail invoked by alias); 10 Oct 2006 22:20:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 11 Oct 2006 00:20:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martyn Smith <martyn@catalyst.net.nz>,
	Martin Langhoff <martin@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28680>


Earlier, cvsserver showed always an 'U', sometimes even without a space
between the 'U' and the name. Now, the correct letter is shown, with a
space.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-cvsserver.perl |   63 ++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 2c1b0c7..7260f32 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -807,7 +807,14 @@ sub req_update
             $meta = $updater->getmeta($filename);
         }
 
-        next unless ( $meta->{revision} );
+	if ( ! defined $meta )
+	{
+	    $meta = {
+	        name => $filename,
+	        revision => 0,
+	        filehash => 'added'
+	    };
+	}
 
         my $oldmeta = $meta;
 
@@ -837,7 +844,7 @@ sub req_update
              and not exists ( $state->{opt}{C} ) )
         {
             $log->info("Tell the client the file is modified");
-            print "MT text U\n";
+            print "MT text M \n";
             print "MT fname $filename\n";
             print "MT newline\n";
             next;
@@ -857,15 +864,36 @@ sub req_update
 	    }
         }
         elsif ( not defined ( $state->{entries}{$filename}{modified_hash} )
-		or $state->{entries}{$filename}{modified_hash} eq $oldmeta->{filehash} )
+		or $state->{entries}{$filename}{modified_hash} eq $oldmeta->{filehash}
+		or $meta->{filehash} eq 'added' )
         {
-            $log->info("Updating '$filename'");
-            # normal update, just send the new revision (either U=Update, or A=Add, or R=Remove)
-            print "MT +updated\n";
-            print "MT text U\n";
-            print "MT fname $filename\n";
-            print "MT newline\n";
-            print "MT -updated\n";
+            # normal update, just send the new revision (either U=Update,
+            # or A=Add, or R=Remove)
+	    if ( defined($wrev) && $wrev < 0 )
+	    {
+	        $log->info("Tell the client the file is scheduled for removal");
+		print "MT text R \n";
+                print "MT fname $filename\n";
+                print "MT newline\n";
+		next;
+	    }
+	    elsif ( !defined($wrev) || $wrev == 0 )
+	    {
+	        $log->info("Tell the client the file will be added");
+		print "MT text A \n";
+                print "MT fname $filename\n";
+                print "MT newline\n";
+		next;
+
+	    }
+	    else {
+                $log->info("Updating '$filename' $wrev");
+                print "MT +updated\n";
+                print "MT text U \n";
+                print "MT fname $filename\n";
+                print "MT newline\n";
+		print "MT -updated\n";
+	    }
 
             my ( $filepart, $dirpart ) = filenamesplit($filename,1);
 
@@ -1711,6 +1739,17 @@ sub argsfromdir
 
     return if ( scalar ( @{$state->{args}} ) > 1 );
 
+    my @gethead = @{$updater->gethead};
+
+    # push added files
+    foreach my $file (keys %{$state->{entries}}) {
+    	if ( exists $state->{entries}{$file}{revision} &&
+		$state->{entries}{$file}{revision} == 0 )
+	{
+	    push @gethead, { name => $file, filehash => 'added' };
+	}
+    }
+
     if ( scalar(@{$state->{args}}) == 1 )
     {
         my $arg = $state->{args}[0];
@@ -1718,7 +1757,7 @@ sub argsfromdir
 
         $log->info("Only one arg specified, checking for directory expansion on '$arg'");
 
-        foreach my $file ( @{$updater->gethead} )
+        foreach my $file ( @gethead )
         {
             next if ( $file->{filehash} eq "deleted" and not defined ( $state->{entries}{$file->{name}} ) );
             next unless ( $file->{name} =~ /^$arg\// or $file->{name} eq $arg  );
@@ -1731,7 +1770,7 @@ sub argsfromdir
 
         $state->{args} = [];
 
-        foreach my $file ( @{$updater->gethead} )
+        foreach my $file ( @gethead )
         {
             next if ( $file->{filehash} eq "deleted" and not defined ( $state->{entries}{$file->{name}} ) );
             next unless ( $file->{name} =~ s/^$state->{prependdir}// );
-- 
1.4.3.rc2.g35de
