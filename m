From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 07/20] cvsserver: split up long lines in req_{status,diff,log}
Date: Sat, 13 Oct 2012 23:42:20 -0600
Message-ID: <1350193353-19210-8-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHAr-0004bu-0r
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab2JNFz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:55:27 -0400
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:36913 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751626Ab2JNFz0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:55:26 -0400
Received: from omta18.emeryville.ca.mail.comcast.net ([76.96.30.74])
	by qmta06.emeryville.ca.mail.comcast.net with comcast
	id Atfh1k0011bwxycA6toLzc; Sun, 14 Oct 2012 05:48:20 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta18.emeryville.ca.mail.comcast.net with comcast
	id AtjK1k00U2wKXRC8etjKt5; Sun, 14 Oct 2012 05:43:20 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 594D41E9601E; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207625>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 220 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 159 insertions(+), 61 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 9e71f30..eb8f138 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1559,10 +1559,12 @@ sub req_status
     #$log->debug("status state : " . Dumper($state));
 
     # Grab a handle to the SQLite db and do any necessary updates
-    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    my $updater;
+    $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
     $updater->update();
 
-    # if no files were specified, we need to work out what files we should be providing status on ...
+    # if no files were specified, we need to work out what files we should
+    # be providing status on ...
     argsfromdir($updater);
 
     # foreach file specified on the command line ...
@@ -1570,14 +1572,19 @@ sub req_status
     {
         $filename = filecleanup($filename);
 
-        next if exists($state->{opt}{l}) && index($filename, '/', length($state->{prependdir})) >= 0;
+        if ( exists($state->{opt}{l}) &&
+             index($filename, '/', length($state->{prependdir})) >= 0 )
+        {
+           next;
+        }
 
         my $meta = $updater->getmeta($filename);
         my $oldmeta = $meta;
 
         my $wrev = revparse($filename);
 
-        # If the working copy is an old revision, lets get that version too for comparison.
+        # If the working copy is an old revision, lets get that
+        # version too for comparison.
         if ( defined($wrev) and $wrev != $meta->{revision} )
         {
             $oldmeta = $updater->getmeta($filename, $wrev);
@@ -1585,49 +1592,95 @@ sub req_status
 
         # TODO : All possible statuses aren't yet implemented
         my $status;
-        # Files are up to date if the working copy and repo copy have the same revision, and the working copy is unmodified
-        $status = "Up-to-date" if ( defined ( $wrev ) and defined($meta->{revision}) and $wrev == $meta->{revision}
-                                    and
-                                    ( ( $state->{entries}{$filename}{unchanged} and ( not defined ( $state->{entries}{$filename}{conflict} ) or $state->{entries}{$filename}{conflict} !~ /^\+=/ ) )
-                                      or ( defined($state->{entries}{$filename}{modified_hash}) and $state->{entries}{$filename}{modified_hash} eq $meta->{filehash} ) )
-                                   );
-
-        # Need checkout if the working copy has an older revision than the repo copy, and the working copy is unmodified
-        $status ||= "Needs Checkout" if ( defined ( $wrev ) and defined ( $meta->{revision} ) and $meta->{revision} > $wrev
-                                          and
-                                          ( $state->{entries}{$filename}{unchanged}
-                                            or ( defined($state->{entries}{$filename}{modified_hash}) and $state->{entries}{$filename}{modified_hash} eq $oldmeta->{filehash} ) )
-                                        );
-
-        # Need checkout if it exists in the repo but doesn't have a working copy
-        $status ||= "Needs Checkout" if ( not defined ( $wrev ) and defined ( $meta->{revision} ) );
-
-        # Locally modified if working copy and repo copy have the same revision but there are local changes
-        $status ||= "Locally Modified" if ( defined ( $wrev ) and defined($meta->{revision}) and $wrev == $meta->{revision} and $state->{entries}{$filename}{modified_filename} );
-
-        # Needs Merge if working copy revision is less than repo copy and there are local changes
-        $status ||= "Needs Merge" if ( defined ( $wrev ) and defined ( $meta->{revision} ) and $meta->{revision} > $wrev and $state->{entries}{$filename}{modified_filename} );
-
-        $status ||= "Locally Added" if ( defined ( $state->{entries}{$filename}{revision} ) and not defined ( $meta->{revision} ) );
-        $status ||= "Locally Removed" if ( defined ( $wrev ) and defined ( $meta->{revision} ) and -$wrev == $meta->{revision} );
-        $status ||= "Unresolved Conflict" if ( defined ( $state->{entries}{$filename}{conflict} ) and $state->{entries}{$filename}{conflict} =~ /^\+=/ );
-        $status ||= "File had conflicts on merge" if ( 0 );
+        # Files are up to date if the working copy and repo copy have
+        # the same revision, and the working copy is unmodified
+        if ( defined ( $wrev ) and defined($meta->{revision}) and
+             $wrev == $meta->{revision} and
+             ( ( $state->{entries}{$filename}{unchanged} and
+                 ( not defined ( $state->{entries}{$filename}{conflict} ) or
+                   $state->{entries}{$filename}{conflict} !~ /^\+=/ ) ) or
+               ( defined($state->{entries}{$filename}{modified_hash}) and
+                 $state->{entries}{$filename}{modified_hash} eq
+                          $meta->{filehash} ) ) )
+        {
+            $status = "Up-to-date";
+        }
+
+        # Need checkout if the working copy has an older revision than
+        # the repo copy, and the working copy is unmodified
+        if ( defined ( $wrev ) and defined ( $meta->{revision} ) and
+             $meta->{revision} > $wrev and
+             ( $state->{entries}{$filename}{unchanged} or
+               ( defined($state->{entries}{$filename}{modified_hash}) and
+                 $state->{entries}{$filename}{modified_hash} eq
+                                $oldmeta->{filehash} ) ) )
+        {
+            $status ||= "Needs Checkout";
+        }
+
+        # Need checkout if it exists in the repo but doesn't have a working
+        # copy
+        if ( not defined ( $wrev ) and defined ( $meta->{revision} ) )
+        {
+            $status ||= "Needs Checkout";
+        }
+
+        # Locally modified if working copy and repo copy have the
+        # same revision but there are local changes
+        if ( defined ( $wrev ) and defined($meta->{revision}) and
+             $wrev == $meta->{revision} and
+             $state->{entries}{$filename}{modified_filename} )
+        {
+            $status ||= "Locally Modified";
+        }
+
+        # Needs Merge if working copy revision is less than repo copy
+        # and there are local changes
+        if ( defined ( $wrev ) and defined ( $meta->{revision} ) and
+             $meta->{revision} > $wrev and
+             $state->{entries}{$filename}{modified_filename} )
+        {
+            $status ||= "Needs Merge";
+        }
+
+        if ( defined ( $state->{entries}{$filename}{revision} ) and
+             not defined ( $meta->{revision} ) )
+        {
+            $status ||= "Locally Added";
+        }
+        if ( defined ( $wrev ) and defined ( $meta->{revision} ) and
+             -$wrev == $meta->{revision} )
+        {
+            $status ||= "Locally Removed";
+        }
+        if ( defined ( $state->{entries}{$filename}{conflict} ) and
+             $state->{entries}{$filename}{conflict} =~ /^\+=/ )
+        {
+            $status ||= "Unresolved Conflict";
+        }
+        if ( 0 )
+        {
+            $status ||= "File had conflicts on merge";
+        }
 
         $status ||= "Unknown";
 
         my ($filepart) = filenamesplit($filename);
 
-        print "M ===================================================================\n";
+        print "M =======" . ( "=" x 60 ) . "\n";
         print "M File: $filepart\tStatus: $status\n";
         if ( defined($state->{entries}{$filename}{revision}) )
         {
-            print "M Working revision:\t" . $state->{entries}{$filename}{revision} . "\n";
+            print "M Working revision:\t" .
+                  $state->{entries}{$filename}{revision} . "\n";
         } else {
             print "M Working revision:\tNo entry for $filename\n";
         }
         if ( defined($meta->{revision}) )
         {
-            print "M Repository revision:\t1." . $meta->{revision} . "\t$state->{CVSROOT}/$state->{module}/$filename,v\n";
+            print "M Repository revision:\t1." .
+                   $meta->{revision} .
+                   "\t$state->{CVSROOT}/$state->{module}/$filename,v\n";
             print "M Sticky Tag:\t\t(none)\n";
             print "M Sticky Date:\t\t(none)\n";
             print "M Sticky Options:\t\t(none)\n";
@@ -1661,13 +1714,17 @@ sub req_diff
     $revision1 =~ s/^1\.// if ( defined ( $revision1 ) );
     $revision2 =~ s/^1\.// if ( defined ( $revision2 ) );
 
-    $log->debug("Diffing revisions " . ( defined($revision1) ? $revision1 : "[NULL]" ) . " and " . ( defined($revision2) ? $revision2 : "[NULL]" ) );
+    $log->debug("Diffing revisions " .
+                ( defined($revision1) ? $revision1 : "[NULL]" ) .
+                " and " . ( defined($revision2) ? $revision2 : "[NULL]" ) );
 
     # Grab a handle to the SQLite db and do any necessary updates
-    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    my $updater;
+    $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
     $updater->update();
 
-    # if no files were specified, we need to work out what files we should be providing status on ...
+    # if no files were specified, we need to work out what files we should
+    # be providing status on ...
     argsfromdir($updater);
 
     # foreach file specified on the command line ...
@@ -1722,7 +1779,8 @@ sub req_diff
             $file2 = $state->{entries}{$filename}{modified_filename};
         }
 
-        # if we have been given -r, and we don't have a $file2 yet, lets get one
+        # if we have been given -r, and we don't have a $file2 yet, lets
+        # get one
         if ( defined ( $revision1 ) and not defined ( $file2 ) )
         {
             ( undef, $file2 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
@@ -1733,21 +1791,37 @@ sub req_diff
         # We need to have retrieved something useful
         next unless ( defined ( $meta1 ) );
 
-        # Files to date if the working copy and repo copy have the same revision, and the working copy is unmodified
-        next if ( not defined ( $meta2 ) and $wrev == $meta1->{revision}
-                  and
-                   ( ( $state->{entries}{$filename}{unchanged} and ( not defined ( $state->{entries}{$filename}{conflict} ) or $state->{entries}{$filename}{conflict} !~ /^\+=/ ) )
-                     or ( defined($state->{entries}{$filename}{modified_hash}) and $state->{entries}{$filename}{modified_hash} eq $meta1->{filehash} ) )
-                  );
+        # Files to date if the working copy and repo copy have the same
+        # revision, and the working copy is unmodified
+        if ( not defined ( $meta2 ) and $wrev == $meta1->{revision} and
+             ( ( $state->{entries}{$filename}{unchanged} and
+                 ( not defined ( $state->{entries}{$filename}{conflict} ) or
+                   $state->{entries}{$filename}{conflict} !~ /^\+=/ ) ) or
+               ( defined($state->{entries}{$filename}{modified_hash}) and
+                 $state->{entries}{$filename}{modified_hash} eq
+                        $meta1->{filehash} ) ) )
+        {
+            next;
+        }
 
         # Apparently we only show diffs for locally modified files
-        next unless ( defined($meta2) or defined ( $state->{entries}{$filename}{modified_filename} ) );
+        unless ( defined($meta2) or
+                 defined ( $state->{entries}{$filename}{modified_filename} ) )
+        {
+            next;
+        }
 
         print "M Index: $filename\n";
-        print "M ===================================================================\n";
+        print "M =======" . ( "=" x 60 ) . "\n";
         print "M RCS file: $state->{CVSROOT}/$state->{module}/$filename,v\n";
-        print "M retrieving revision 1.$meta1->{revision}\n" if ( defined ( $meta1 ) );
-        print "M retrieving revision 1.$meta2->{revision}\n" if ( defined ( $meta2 ) );
+        if ( defined ( $meta1 ) )
+        {
+            print "M retrieving revision 1.$meta1->{revision}\n"
+        }
+        if ( defined ( $meta2 ) )
+        {
+            print "M retrieving revision 1.$meta2->{revision}\n"
+        }
         print "M diff ";
         foreach my $opt ( keys %{$state->{opt}} )
         {
@@ -1759,18 +1833,27 @@ sub req_diff
                 }
             } else {
                 print "-$opt ";
-                print "$state->{opt}{$opt} " if ( defined ( $state->{opt}{$opt} ) );
+                if ( defined ( $state->{opt}{$opt} ) )
+                {
+                    print "$state->{opt}{$opt} "
+                }
             }
         }
         print "$filename\n";
 
-        $log->info("Diffing $filename -r $meta1->{revision} -r " . ( $meta2->{revision} or "workingcopy" ));
+        $log->info("Diffing $filename -r $meta1->{revision} -r " .
+                   ( $meta2->{revision} or "workingcopy" ));
 
         ( $fh, $filediff ) = tempfile ( DIR => $TEMP_DIR );
 
         if ( exists $state->{opt}{u} )
         {
-            system("diff -u -L '$filename revision 1.$meta1->{revision}' -L '$filename " . ( defined($meta2->{revision}) ? "revision 1.$meta2->{revision}" : "working copy" ) . "' $file1 $file2 > $filediff");
+            system("diff -u -L '$filename revision 1.$meta1->{revision}'" .
+                        " -L '$filename " .
+                        ( defined($meta2->{revision}) ?
+                                "revision 1.$meta2->{revision}" :
+                                "working copy" ) .
+                        "' $file1 $file2 > $filediff" );
         } else {
             system("diff $file1 $file2 > $filediff");
         }
@@ -1795,7 +1878,8 @@ sub req_log
     #$log->debug("log state : " . Dumper($state));
 
     my ( $minrev, $maxrev );
-    if ( defined ( $state->{opt}{r} ) and $state->{opt}{r} =~ /([\d.]+)?(::?)([\d.]+)?/ )
+    if ( defined ( $state->{opt}{r} ) and
+         $state->{opt}{r} =~ /([\d.]+)?(::?)([\d.]+)?/ )
     {
         my $control = $2;
         $minrev = $1;
@@ -1806,10 +1890,12 @@ sub req_log
     }
 
     # Grab a handle to the SQLite db and do any necessary updates
-    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    my $updater;
+    $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
     $updater->update();
 
-    # if no files were specified, we need to work out what files we should be providing status on ...
+    # if no files were specified, we need to work out what files we
+    # should be providing status on ...
     argsfromdir($updater);
 
     # foreach file specified on the command line ...
@@ -1825,7 +1911,8 @@ sub req_log
         if ( defined ( $minrev ) )
         {
             $log->debug("Removing revisions less than $minrev");
-            while ( scalar(@$revisions) > 0 and $revisions->[-1]{revision} < $minrev )
+            while ( scalar(@$revisions) > 0 and
+                    $revisions->[-1]{revision} < $minrev )
             {
                 pop @$revisions;
             }
@@ -1833,7 +1920,8 @@ sub req_log
         if ( defined ( $maxrev ) )
         {
             $log->debug("Removing revisions greater than $maxrev");
-            while ( scalar(@$revisions) > 0 and $revisions->[0]{revision} > $maxrev )
+            while ( scalar(@$revisions) > 0 and
+                    $revisions->[0]{revision} > $maxrev )
             {
                 shift @$revisions;
             }
@@ -1850,7 +1938,8 @@ sub req_log
         print "M access list:\n";
         print "M symbolic names:\n";
         print "M keyword substitution: kv\n";
-        print "M total revisions: $totalrevisions;\tselected revisions: " . scalar(@$revisions) . "\n";
+        print "M total revisions: $totalrevisions;\tselected revisions: " .
+              scalar(@$revisions) . "\n";
         print "M description:\n";
 
         foreach my $revision ( @$revisions )
@@ -1858,14 +1947,23 @@ sub req_log
             print "M ----------------------------\n";
             print "M revision 1.$revision->{revision}\n";
             # reformat the date for log output
-            $revision->{modified} = sprintf('%04d/%02d/%02d %s', $3, $DATE_LIST->{$2}, $1, $4 ) if ( $revision->{modified} =~ /(\d+)\s+(\w+)\s+(\d+)\s+(\S+)/ and defined($DATE_LIST->{$2}) );
+            if ( $revision->{modified} =~ /(\d+)\s+(\w+)\s+(\d+)\s+(\S+)/ and
+                 defined($DATE_LIST->{$2}) )
+            {
+                $revision->{modified} = sprintf('%04d/%02d/%02d %s',
+                                            $3, $DATE_LIST->{$2}, $1, $4 );
+            }
             $revision->{author} = cvs_author($revision->{author});
-            print "M date: $revision->{modified};  author: $revision->{author};  state: " . ( $revision->{filehash} eq "deleted" ? "dead" : "Exp" ) . ";  lines: +2 -3\n";
-            my $commitmessage = $updater->commitmessage($revision->{commithash});
+            print "M date: $revision->{modified};" .
+                  "  author: $revision->{author};  state: " .
+                  ( $revision->{filehash} eq "deleted" ? "dead" : "Exp" ) .
+                  ";  lines: +2 -3\n";
+            my $commitmessage;
+            $commitmessage = $updater->commitmessage($revision->{commithash});
             $commitmessage =~ s/^/M /mg;
             print $commitmessage . "\n";
         }
-        print "M =============================================================================\n";
+        print "M =======" . ( "=" x 70 ) . "\n";
     }
 
     print "ok\n";
-- 
1.7.10.2.484.gcd07cc5
