From: Damien Diederen <dash@foobox.net>
Subject: [PATCH 5/7] cvsserver: Implemented update -p (print to stdout)
Date: Mon, 24 Mar 2008 23:50:32 +0100
Message-ID: <4ba0ce96c3dcd304ca598379dc448ca50d994133.1206393086.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:51:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvVd-0002v8-KW
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbYCXWug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbYCXWug
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:50:36 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:47850 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753089AbYCXWuf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 18:50:35 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 0FDC124AE55;
	Mon, 24 Mar 2008 23:50:34 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id E746023D41C;
	Mon, 24 Mar 2008 23:50:33 +0100 (CET)
Received: from keem.bcc (dslb-084-057-018-240.pools.arcor-ip.net [84.57.18.240])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 462408C466;
	Mon, 24 Mar 2008 23:50:33 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: 4ba0ce96c3dcd304ca598379dc448ca50d994133 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6378/Mon Mar 24 22:24:31 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78119>


Cvs update -p -r <rev> <path> is the documented way to retrieve a
specific revision of a file (similar to git show <rev>:<path>).
Without this patch, the -p flag is ignored and status output is
produced, causing clients to interpret it as the contents of the file.

TkCVS uses update -p as a basis for implementing its various "View"
and "Diff" commands.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 073a426..3c97226 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -958,6 +958,17 @@ sub req_update
             $meta = $updater->getmeta($filename);
         }
 
+        # If -p was given, "print" the contents of the requested revision.
+        if ( exists ( $state->{opt}{p} ) ) {
+            if ( defined ( $meta->{revision} ) ) {
+                $log->info("Printing '$filename' revision " . $meta->{revision});
+
+                transmitfile($meta->{filehash}, { print => 1 });
+            }
+
+            next;
+        }
+
 	if ( ! defined $meta )
 	{
 	    $meta = {
@@ -1091,9 +1102,9 @@ sub req_update
             my $file_local = $filepart . ".mine";
             system("ln","-s",$state->{entries}{$filename}{modified_filename}, $file_local);
             my $file_old = $filepart . "." . $oldmeta->{revision};
-            transmitfile($oldmeta->{filehash}, $file_old);
+            transmitfile($oldmeta->{filehash}, { targetfile => $file_old });
             my $file_new = $filepart . "." . $meta->{revision};
-            transmitfile($meta->{filehash}, $file_new);
+            transmitfile($meta->{filehash}, { targetfile => $file_new });
 
             # we need to merge with the local changes ( M=successful merge, C=conflict merge )
             $log->info("Merging $file_local, $file_old, $file_new");
@@ -1550,14 +1561,14 @@ sub req_diff
                 print "E File $filename at revision 1.$revision1 doesn't exist\n";
                 next;
             }
-            transmitfile($meta1->{filehash}, $file1);
+            transmitfile($meta1->{filehash}, { targetfile => $file1 });
         }
         # otherwise we just use the working copy revision
         else
         {
             ( undef, $file1 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
             $meta1 = $updater->getmeta($filename, $wrev);
-            transmitfile($meta1->{filehash}, $file1);
+            transmitfile($meta1->{filehash}, { targetfile => $file1 });
         }
 
         # if we have a second -r switch, use it too
@@ -1572,7 +1583,7 @@ sub req_diff
                 next;
             }
 
-            transmitfile($meta2->{filehash}, $file2);
+            transmitfile($meta2->{filehash}, { targetfile => $file2 });
         }
         # otherwise we just use the working copy
         else
@@ -1585,7 +1596,7 @@ sub req_diff
         {
             ( undef, $file2 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
             $meta2 = $updater->getmeta($filename, $wrev);
-            transmitfile($meta2->{filehash}, $file2);
+            transmitfile($meta2->{filehash}, { targetfile => $file2 });
         }
 
         # We need to have retrieved something useful
@@ -2021,7 +2032,7 @@ sub revparse
 sub transmitfile
 {
     my $filehash = shift;
-    my $targetfile = shift;
+    my $options = shift;
 
     if ( defined ( $filehash ) and $filehash eq "deleted" )
     {
@@ -2043,11 +2054,20 @@ sub transmitfile
 
     if ( open my $fh, '-|', "git-cat-file", "blob", $filehash )
     {
-        if ( defined ( $targetfile ) )
+        if ( defined ( $options->{targetfile} ) )
         {
+            my $targetfile = $options->{targetfile};
             open NEWFILE, ">", $targetfile or die("Couldn't open '$targetfile' for writing : $!");
             print NEWFILE $_ while ( <$fh> );
             close NEWFILE or die("Failed to write '$targetfile': $!");
+        } elsif ( defined ( $options->{print} ) && $options->{print} ) {
+            while ( <$fh> ) {
+                if( /\n\z/ ) {
+                    print 'M ', $_;
+                } else {
+                    print 'MT text ', $_, "\n";
+                }
+            }
         } else {
             print "$size\n";
             print while ( <$fh> );
-- 
1.5.5.rc1.6.gd183
