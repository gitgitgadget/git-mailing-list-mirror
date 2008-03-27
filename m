From: Damien Diederen <dash@foobox.net>
Subject: [PATCH v2 5/7] cvsserver: Implement update -p (print to stdout)
Date: Thu, 27 Mar 2008 23:18:12 +0100
Message-ID: <e95fde851fdc6ef39f32054cba6cde0ae975b8fd.1206654905.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Damien Diederen <dash@foobox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:19:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0RA-000666-Eu
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759803AbYC0WSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759773AbYC0WSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:18:16 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:42485 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759234AbYC0WSP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 18:18:15 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 2101F1F51E6;
	Thu, 27 Mar 2008 23:18:14 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 0D80D21309B;
	Thu, 27 Mar 2008 23:18:14 +0100 (CET)
Received: from keem.bcc (dslb-084-057-042-002.pools.arcor-ip.net [84.57.42.2])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 2A4AA67E05;
	Thu, 27 Mar 2008 23:18:13 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: e95fde851fdc6ef39f32054cba6cde0ae975b8fd Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6432/Thu Mar 27 22:18:40 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78374>

Cvs update -p -r <rev> <path> is the documented way to retrieve a
specific revision of a file (similar to git show <rev>:<path>).
Without this patch, the -p flag is ignored and status output is
produced, causing clients to interpret it as the contents of the file.

TkCVS uses update -p as a basis for implementing its various "View"
and "Diff" commands.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |   47 +++++++++++++++++++++++++++++++++++------------
 1 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 89a4dac..49c0ba2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -963,6 +963,17 @@ sub req_update
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
@@ -1096,9 +1107,9 @@ sub req_update
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
@@ -2014,14 +2025,17 @@ sub revparse
     return undef;
 }
 
-# This method takes a file hash and does a CVS "file transfer" which transmits the
-# size of the file, and then the file contents.
-# If a second argument $targetfile is given, the file is instead written out to
-# a file by the name of $targetfile
+# This method takes a file hash and does a CVS "file transfer".  Its
+# exact behaviour depends on a second, optional hash table argument:
+# - If $options->{targetfile}, dump the contents to that file;
+# - If $options->{print}, use M/MT to transmit the contents one line
+#   at a time;
+# - Otherwise, transmit the size of the file, followed by the file
+#   contents.
 sub transmitfile
 {
     my $filehash = shift;
-    my $targetfile = shift;
+    my $options = shift;
 
     if ( defined ( $filehash ) and $filehash eq "deleted" )
     {
@@ -2043,11 +2057,20 @@ sub transmitfile
 
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
1.5.5.rc1.19.gfe7681
