From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsserver: Eclipse compat -- now "compare with latest from HEAD" works
Date: Thu, 2 Mar 2006 18:42:01 +1300
Message-ID: <1141278121670-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Mar 02 06:25:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEgJv-0001Vp-FV
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 06:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWCBFZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 00:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWCBFZp
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 00:25:45 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:6046 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751257AbWCBFZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 00:25:44 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1FEgJq-0004bE-Sk; Thu, 02 Mar 2006 18:25:42 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1FEgZd-0000NI-00; Thu, 02 Mar 2006 18:42:01 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17054>

The Eclipse client uses cvs update when that menu option is triggered.
And doesn't like the standard cvs update response. Give it *exactly* what
it wants.

And hope the other clients don't lose the plot too badly.

---

Or pull from my cvsserver branch

---


 git-cvsserver.perl |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

3d9afa6824c09083b26c4d371fee54acd1216bba
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index d641c03..7b3ba1b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -714,8 +714,27 @@ sub req_update
 
         #$log->debug("Target revision is $meta->{revision}, current working revision is $wrev");
 
-        # Files are up to date if the working copy and repo copy have the same revision, and the working copy is unmodified _and_ the user hasn't specified -C
-        next if ( defined ( $wrev ) and defined($meta->{revision}) and $wrev == $meta->{revision} and $state->{entries}{$filename}{unchanged} and not exists ( $state->{opt}{C} ) );
+        # Files are up to date if the working copy and repo copy have the same revision,
+        # and the working copy is unmodified _and_ the user hasn't specified -C
+        next if ( defined ( $wrev )
+                  and defined($meta->{revision})
+                  and $wrev == $meta->{revision}
+                  and $state->{entries}{$filename}{unchanged}
+                  and not exists ( $state->{opt}{C} ) );
+
+        # If the working copy and repo copy have the same revision,
+        # but the working copy is modified, tell the client it's modified
+        if ( defined ( $wrev )
+             and defined($meta->{revision})
+             and $wrev == $meta->{revision}
+             and not exists ( $state->{opt}{C} ) )
+        {
+            $log->info("Tell the client the file is modified");
+            print "MT text U\n";
+            print "MT fname $filename\n";
+            print "MT newline\n";
+            next;
+        }
 
         if ( $meta->{filehash} eq "deleted" )
         {
@@ -727,7 +746,8 @@ sub req_update
             print "Removed $dirpart\n";
             print "$filepart\n";
         }
-        elsif ( not defined ( $state->{entries}{$filename}{modified_hash} ) or $state->{entries}{$filename}{modified_hash} eq $oldmeta->{filehash} )
+        elsif ( not defined ( $state->{entries}{$filename}{modified_hash} )
+		or $state->{entries}{$filename}{modified_hash} eq $oldmeta->{filehash} )
         {
             $log->info("Updating '$filename'");
             # normal update, just send the new revision (either U=Update, or A=Add, or R=Remove)
@@ -763,6 +783,7 @@ sub req_update
             # transmit file
             transmitfile($meta->{filehash});
         } else {
+            $log->info("Updating '$filename'");
             my ( $filepart, $dirpart ) = filenamesplit($meta->{name});
 
             my $dir = tempdir( DIR => $TEMP_DIR, CLEANUP => 1 ) . "/";
-- 
1.2.4.g09a27-dirty
