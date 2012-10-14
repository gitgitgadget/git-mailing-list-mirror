From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 08/20] cvsserver: use whole CVS rev number in-process; don't strip "1." prefix
Date: Sat, 13 Oct 2012 23:42:21 -0600
Message-ID: <1350193353-19210-9-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:48:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNH41-0006rG-N8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab2JNFs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:48:27 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:54894 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129Ab2JNFsV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:48:21 -0400
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id Atd71k00B1Y3wxoA1toMKm; Sun, 14 Oct 2012 05:48:21 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta15.emeryville.ca.mail.comcast.net with comcast
	id AtjL1k0042wKXRC8btjL5s; Sun, 14 Oct 2012 05:43:21 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 6EBBD1E9601F; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207622>

Keep track of the whole CVS revision number in-process.  This will
clarify code when we start handling non-linear revision numbers later.

There is one externally visible change: conflict markers after
an update will now include the full CVS revision number,
including the "1." prefix.  It used to leave off the prefix.

Other than the conflict marker, this change doesn't effect
external functionality.  No new features, and the DB schema
is unchanged such that it continues to store just
the stripped rev numbers (without prefix).

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl              | 225 ++++++++++++++++++++++------------------
 t/t9400-git-cvsserver-server.sh |   2 +-
 2 files changed, 123 insertions(+), 104 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index eb8f138..8a7106d 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -554,10 +554,10 @@ sub req_add
         my $meta = $updater->getmeta($filename);
         my $wrev = revparse($filename);
 
-        if ($wrev && $meta && ($wrev < 0))
+        if ($wrev && $meta && ($wrev=~/^-/))
         {
             # previously removed file, add back
-            $log->info("added file $filename was previously removed, send 1.$meta->{revision}");
+            $log->info("added file $filename was previously removed, send $meta->{revision}");
 
             print "MT +updated\n";
             print "MT text U \n";
@@ -574,8 +574,8 @@ sub req_add
 
                 # this is an "entries" line
                 my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
-                $log->debug("/$filepart/1.$meta->{revision}//$kopts/");
-                print "/$filepart/1.$meta->{revision}//$kopts/\n";
+                $log->debug("/$filepart/$meta->{revision}//$kopts/");
+                print "/$filepart/$meta->{revision}//$kopts/\n";
                 # permissions
                 $log->debug("SEND : u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}");
                 print "u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}\n";
@@ -683,13 +683,13 @@ sub req_remove
             next;
         }
 
-        if ( defined($wrev) and $wrev < 0 )
+        if ( defined($wrev) and ($wrev=~/^-/) )
         {
             print "E cvs remove: file `$filename' already scheduled for removal\n";
             next;
         }
 
-        unless ( $wrev == $meta->{revision} )
+        unless ( $wrev eq $meta->{revision} )
         {
             # TODO : not sure if the format of this message is quite correct.
             print "E cvs remove: Up to date check failed for `$filename'\n";
@@ -704,7 +704,7 @@ sub req_remove
         print "Checked-in $dirpart\n";
         print "$filename\n";
         my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
-        print "/$filepart/-1.$wrev//$kopts/\n";
+        print "/$filepart/-$wrev//$kopts/\n";
 
         $rmcount++;
     }
@@ -995,7 +995,7 @@ sub req_co
 
         # this is an "entries" line
         my $kopts = kopts_from_path($fullName,"sha1",$git->{filehash});
-        print "/$git->{name}/1.$git->{revision}//$kopts/\n";
+        print "/$git->{name}/$git->{revision}//$kopts/\n";
         # permissions
         print "u=$git->{mode},g=$git->{mode},o=$git->{mode}\n";
 
@@ -1083,7 +1083,7 @@ sub req_update
         }
 
         my $meta;
-        if ( defined($state->{opt}{r}) and $state->{opt}{r} =~ /^1\.(\d+)/ )
+        if ( defined($state->{opt}{r}) and $state->{opt}{r} =~ /^(1\.\d+)$/ )
         {
             $meta = $updater->getmeta($filename, $1);
         } else {
@@ -1105,7 +1105,7 @@ sub req_update
 	{
 	    $meta = {
 	        name => $filename,
-	        revision => 0,
+	        revision => '0',
 	        filehash => 'added'
 	    };
 	}
@@ -1115,7 +1115,7 @@ sub req_update
         my $wrev = revparse($filename);
 
         # If the working copy is an old revision, lets get that version too for comparison.
-        if ( defined($wrev) and $wrev != $meta->{revision} )
+        if ( defined($wrev) and $wrev ne $meta->{revision} )
         {
             $oldmeta = $updater->getmeta($filename, $wrev);
         }
@@ -1126,7 +1126,7 @@ sub req_update
         # and the working copy is unmodified _and_ the user hasn't specified -C
         next if ( defined ( $wrev )
                   and defined($meta->{revision})
-                  and $wrev == $meta->{revision}
+                  and $wrev eq $meta->{revision}
                   and $state->{entries}{$filename}{unchanged}
                   and not exists ( $state->{opt}{C} ) );
 
@@ -1134,7 +1134,7 @@ sub req_update
         # but the working copy is modified, tell the client it's modified
         if ( defined ( $wrev )
              and defined($meta->{revision})
-             and $wrev == $meta->{revision}
+             and $wrev eq $meta->{revision}
              and defined($state->{entries}{$filename}{modified_hash})
              and not exists ( $state->{opt}{C} ) )
         {
@@ -1168,7 +1168,7 @@ sub req_update
         {
             # normal update, just send the new revision (either U=Update,
             # or A=Add, or R=Remove)
-	    if ( defined($wrev) && $wrev < 0 )
+	    if ( defined($wrev) && ($wrev=~/^-/) )
 	    {
 	        $log->info("Tell the client the file is scheduled for removal");
 		print "MT text R \n";
@@ -1176,7 +1176,8 @@ sub req_update
                 print "MT newline\n";
 		next;
 	    }
-	    elsif ( (!defined($wrev) || $wrev == 0) && (!defined($meta->{revision}) || $meta->{revision} == 0) )
+	    elsif ( (!defined($wrev) || $wrev eq '0') &&
+                    (!defined($meta->{revision}) || $meta->{revision} eq '0') )
 	    {
 	        $log->info("Tell the client the file is scheduled for addition");
 		print "MT text A \n";
@@ -1186,7 +1187,7 @@ sub req_update
 
 	    }
 	    else {
-                $log->info("Updating '$filename' to ".$meta->{revision});
+                $log->info("UpdatingX3 '$filename' to ".$meta->{revision});
                 print "MT +updated\n";
                 print "MT text U \n";
                 print "MT fname $filename\n";
@@ -1218,8 +1219,8 @@ sub req_update
 
 		# this is an "entries" line
 		my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
-		$log->debug("/$filepart/1.$meta->{revision}//$kopts/");
-		print "/$filepart/1.$meta->{revision}//$kopts/\n";
+		$log->debug("/$filepart/$meta->{revision}//$kopts/");
+		print "/$filepart/$meta->{revision}//$kopts/\n";
 
 		# permissions
 		$log->debug("SEND : u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}");
@@ -1229,7 +1230,6 @@ sub req_update
 		transmitfile($meta->{filehash});
 	    }
         } else {
-            $log->info("Updating '$filename'");
             my ( $filepart, $dirpart ) = filenamesplit($meta->{name},1);
 
             my $mergeDir = setupTmpDir();
@@ -1244,7 +1244,7 @@ sub req_update
 
             # we need to merge with the local changes ( M=successful merge, C=conflict merge )
             $log->info("Merging $file_local, $file_old, $file_new");
-            print "M Merging differences between 1.$oldmeta->{revision} and 1.$meta->{revision} into $filename\n";
+            print "M Merging differences between $oldmeta->{revision} and $meta->{revision} into $filename\n";
 
             $log->debug("Temporary directory for merge is $mergeDir");
 
@@ -1267,8 +1267,8 @@ sub req_update
                     print $state->{CVSROOT} . "/$state->{module}/$filename\n";
                     my $kopts = kopts_from_path("$dirpart/$filepart",
                                                 "file",$mergedFile);
-                    $log->debug("/$filepart/1.$meta->{revision}//$kopts/");
-                    print "/$filepart/1.$meta->{revision}//$kopts/\n";
+                    $log->debug("/$filepart/$meta->{revision}//$kopts/");
+                    print "/$filepart/$meta->{revision}//$kopts/\n";
                 }
             }
             elsif ( $return == 1 )
@@ -1284,7 +1284,7 @@ sub req_update
                     print $state->{CVSROOT} . "/$state->{module}/$filename\n";
                     my $kopts = kopts_from_path("$dirpart/$filepart",
                                                 "file",$mergedFile);
-                    print "/$filepart/1.$meta->{revision}/+/$kopts/\n";
+                    print "/$filepart/$meta->{revision}/+/$kopts/\n";
                 }
             }
             else
@@ -1387,11 +1387,12 @@ sub req_ci
 
         my $addflag = 0;
         my $rmflag = 0;
-        $rmflag = 1 if ( defined($wrev) and $wrev < 0 );
+        $rmflag = 1 if ( defined($wrev) and ($wrev=~/^-/) );
         $addflag = 1 unless ( -e $filename );
 
         # Do up to date checking
-        unless ( $addflag or $wrev == $meta->{revision} or ( $rmflag and -$wrev == $meta->{revision} ) )
+        unless ( $addflag or $wrev eq $meta->{revision} or
+                 ( $rmflag and $wrev eq "-$meta->{revision}" ) )
         {
             # fail everything if an up to date check fails
             print "error 1 Up to date check failed for $filename\n";
@@ -1428,7 +1429,7 @@ sub req_ci
             $log->info("Adding file '$filename'");
             system("git", "update-index", "--add", $filename);
         } else {
-            $log->info("Updating file '$filename'");
+            $log->info("UpdatingX2 file '$filename'");
             system("git", "update-index", $filename);
         }
     }
@@ -1519,7 +1520,7 @@ sub req_ci
 
         my $meta = $updater->getmeta($filename);
 	unless (defined $meta->{revision}) {
-	  $meta->{revision} = 1;
+	  $meta->{revision} = "1.1";
 	}
 
         my ( $filepart, $dirpart ) = filenamesplit($filename, 1);
@@ -1529,19 +1530,19 @@ sub req_ci
 	print "M $state->{CVSROOT}/$state->{module}/$filename,v  <--  $dirpart$filepart\n";
         if ( defined $meta->{filehash} && $meta->{filehash} eq "deleted" )
         {
-            print "M new revision: delete; previous revision: 1.$oldmeta{$filename}{revision}\n";
+            print "M new revision: delete; previous revision: $oldmeta{$filename}{revision}\n";
             print "Remove-entry $dirpart\n";
             print "$filename\n";
         } else {
-            if ($meta->{revision} == 1) {
+            if ($meta->{revision} eq "1.1") {
 	        print "M initial revision: 1.1\n";
             } else {
-	        print "M new revision: 1.$meta->{revision}; previous revision: 1.$oldmeta{$filename}{revision}\n";
+	        print "M new revision: $meta->{revision}; previous revision: $oldmeta{$filename}{revision}\n";
             }
             print "Checked-in $dirpart\n";
             print "$filename\n";
             my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
-            print "/$filepart/1.$meta->{revision}//$kopts/\n";
+            print "/$filepart/$meta->{revision}//$kopts/\n";
         }
     }
 
@@ -1585,7 +1586,7 @@ sub req_status
 
         # If the working copy is an old revision, lets get that
         # version too for comparison.
-        if ( defined($wrev) and $wrev != $meta->{revision} )
+        if ( defined($wrev) and $wrev ne $meta->{revision} )
         {
             $oldmeta = $updater->getmeta($filename, $wrev);
         }
@@ -1595,21 +1596,22 @@ sub req_status
         # Files are up to date if the working copy and repo copy have
         # the same revision, and the working copy is unmodified
         if ( defined ( $wrev ) and defined($meta->{revision}) and
-             $wrev == $meta->{revision} and
+             $wrev eq $meta->{revision} and
              ( ( $state->{entries}{$filename}{unchanged} and
                  ( not defined ( $state->{entries}{$filename}{conflict} ) or
                    $state->{entries}{$filename}{conflict} !~ /^\+=/ ) ) or
                ( defined($state->{entries}{$filename}{modified_hash}) and
                  $state->{entries}{$filename}{modified_hash} eq
-                          $meta->{filehash} ) ) )
+                        $meta->{filehash} ) ) )
         {
-            $status = "Up-to-date";
+            $status = "Up-to-date"
         }
 
-        # Need checkout if the working copy has an older revision than
-        # the repo copy, and the working copy is unmodified
+        # Need checkout if the working copy has a different (usually
+        # older) revision than the repo copy, and the working copy is
+        # unmodified
         if ( defined ( $wrev ) and defined ( $meta->{revision} ) and
-             $meta->{revision} > $wrev and
+             $meta->{revision} ne $wrev and
              ( $state->{entries}{$filename}{unchanged} or
                ( defined($state->{entries}{$filename}{modified_hash}) and
                  $state->{entries}{$filename}{modified_hash} eq
@@ -1628,16 +1630,16 @@ sub req_status
         # Locally modified if working copy and repo copy have the
         # same revision but there are local changes
         if ( defined ( $wrev ) and defined($meta->{revision}) and
-             $wrev == $meta->{revision} and
+             $wrev eq $meta->{revision} and
              $state->{entries}{$filename}{modified_filename} )
         {
             $status ||= "Locally Modified";
         }
 
-        # Needs Merge if working copy revision is less than repo copy
-        # and there are local changes
+        # Needs Merge if working copy revision is different
+        # (usually older) than repo copy and there are local changes
         if ( defined ( $wrev ) and defined ( $meta->{revision} ) and
-             $meta->{revision} > $wrev and
+             $meta->{revision} ne $wrev and
              $state->{entries}{$filename}{modified_filename} )
         {
             $status ||= "Needs Merge";
@@ -1649,7 +1651,7 @@ sub req_status
             $status ||= "Locally Added";
         }
         if ( defined ( $wrev ) and defined ( $meta->{revision} ) and
-             -$wrev == $meta->{revision} )
+             $wrev eq "-$meta->{revision}" )
         {
             $status ||= "Locally Removed";
         }
@@ -1678,7 +1680,7 @@ sub req_status
         }
         if ( defined($meta->{revision}) )
         {
-            print "M Repository revision:\t1." .
+            print "M Repository revision:\t" .
                    $meta->{revision} .
                    "\t$state->{CVSROOT}/$state->{module}/$filename,v\n";
             print "M Sticky Tag:\t\t(none)\n";
@@ -1711,9 +1713,6 @@ sub req_diff
         $revision1 = $state->{opt}{r};
     }
 
-    $revision1 =~ s/^1\.// if ( defined ( $revision1 ) );
-    $revision2 =~ s/^1\.// if ( defined ( $revision2 ) );
-
     $log->debug("Diffing revisions " .
                 ( defined($revision1) ? $revision1 : "[NULL]" ) .
                 " and " . ( defined($revision2) ? $revision2 : "[NULL]" ) );
@@ -1746,7 +1745,7 @@ sub req_diff
             $meta1 = $updater->getmeta($filename, $revision1);
             unless ( defined ( $meta1 ) and $meta1->{filehash} ne "deleted" )
             {
-                print "E File $filename at revision 1.$revision1 doesn't exist\n";
+                print "E File $filename at revision $revision1 doesn't exist\n";
                 next;
             }
             transmitfile($meta1->{filehash}, { targetfile => $file1 });
@@ -1767,7 +1766,7 @@ sub req_diff
 
             unless ( defined ( $meta2 ) and $meta2->{filehash} ne "deleted" )
             {
-                print "E File $filename at revision 1.$revision2 doesn't exist\n";
+                print "E File $filename at revision $revision2 doesn't exist\n";
                 next;
             }
 
@@ -1793,7 +1792,7 @@ sub req_diff
 
         # Files to date if the working copy and repo copy have the same
         # revision, and the working copy is unmodified
-        if ( not defined ( $meta2 ) and $wrev == $meta1->{revision} and
+        if ( not defined ( $meta2 ) and $wrev eq $meta1->{revision} and
              ( ( $state->{entries}{$filename}{unchanged} and
                  ( not defined ( $state->{entries}{$filename}{conflict} ) or
                    $state->{entries}{$filename}{conflict} !~ /^\+=/ ) ) or
@@ -1816,11 +1815,11 @@ sub req_diff
         print "M RCS file: $state->{CVSROOT}/$state->{module}/$filename,v\n";
         if ( defined ( $meta1 ) )
         {
-            print "M retrieving revision 1.$meta1->{revision}\n"
+            print "M retrieving revision $meta1->{revision}\n"
         }
         if ( defined ( $meta2 ) )
         {
-            print "M retrieving revision 1.$meta2->{revision}\n"
+            print "M retrieving revision $meta2->{revision}\n"
         }
         print "M diff ";
         foreach my $opt ( keys %{$state->{opt}} )
@@ -1848,10 +1847,10 @@ sub req_diff
 
         if ( exists $state->{opt}{u} )
         {
-            system("diff -u -L '$filename revision 1.$meta1->{revision}'" .
+            system("diff -u -L '$filename revision $meta1->{revision}'" .
                         " -L '$filename " .
                         ( defined($meta2->{revision}) ?
-                                "revision 1.$meta2->{revision}" :
+                                "revision $meta2->{revision}" :
                                 "working copy" ) .
                         "' $file1 $file2 > $filediff" );
         } else {
@@ -1877,16 +1876,10 @@ sub req_log
     $log->debug("req_log : " . ( defined($data) ? $data : "[NULL]" ));
     #$log->debug("log state : " . Dumper($state));
 
-    my ( $minrev, $maxrev );
-    if ( defined ( $state->{opt}{r} ) and
-         $state->{opt}{r} =~ /([\d.]+)?(::?)([\d.]+)?/ )
-    {
-        my $control = $2;
-        $minrev = $1;
-        $maxrev = $3;
-        $minrev =~ s/^1\.// if ( defined ( $minrev ) );
-        $maxrev =~ s/^1\.// if ( defined ( $maxrev ) );
-        $minrev++ if ( defined($minrev) and $control eq "::" );
+    my ( $revFilter );
+    if ( defined ( $state->{opt}{r} ) )
+    {
+        $revFilter = $state->{opt}{r};
     }
 
     # Grab a handle to the SQLite db and do any necessary updates
@@ -1905,34 +1898,15 @@ sub req_log
 
         my $headmeta = $updater->getmeta($filename);
 
-        my $revisions = $updater->getlog($filename);
-        my $totalrevisions = scalar(@$revisions);
-
-        if ( defined ( $minrev ) )
-        {
-            $log->debug("Removing revisions less than $minrev");
-            while ( scalar(@$revisions) > 0 and
-                    $revisions->[-1]{revision} < $minrev )
-            {
-                pop @$revisions;
-            }
-        }
-        if ( defined ( $maxrev ) )
-        {
-            $log->debug("Removing revisions greater than $maxrev");
-            while ( scalar(@$revisions) > 0 and
-                    $revisions->[0]{revision} > $maxrev )
-            {
-                shift @$revisions;
-            }
-        }
+        my ($revisions,$totalrevisions) = $updater->getlog($filename,
+                                                           $revFilter);
 
         next unless ( scalar(@$revisions) );
 
         print "M \n";
         print "M RCS file: $state->{CVSROOT}/$state->{module}/$filename,v\n";
         print "M Working file: $filename\n";
-        print "M head: 1.$headmeta->{revision}\n";
+        print "M head: $headmeta->{revision}\n";
         print "M branch:\n";
         print "M locks: strict\n";
         print "M access list:\n";
@@ -1945,7 +1919,7 @@ sub req_log
         foreach my $revision ( @$revisions )
         {
             print "M ----------------------------\n";
-            print "M revision 1.$revision->{revision}\n";
+            print "M revision $revision->{revision}\n";
             # reformat the date for log output
             if ( $revision->{modified} =~ /(\d+)\s+(\w+)\s+(\d+)\s+(\S+)/ and
                  defined($DATE_LIST->{$2}) )
@@ -2069,7 +2043,7 @@ sub req_annotate
                     $metadata->{$commithash}{author} = cvs_author($metadata->{$commithash}{author});
                     $metadata->{$commithash}{modified} = sprintf("%02d-%s-%02d", $1, $2, $3) if ( $metadata->{$commithash}{modified} =~ /^(\d+)\s(\w+)\s\d\d(\d\d)/ );
                 }
-                printf("M 1.%-5d      (%-8s %10s): %s\n",
+                printf("M %-7s      (%-8s %10s): %s\n",
                     $metadata->{$commithash}{revision},
                     $metadata->{$commithash}{author},
                     $metadata->{$commithash}{modified},
@@ -2190,7 +2164,7 @@ sub argsfromdir
     # push added files
     foreach my $file (keys %{$state->{entries}}) {
 	if ( exists $state->{entries}{$file}{revision} &&
-		$state->{entries}{$file}{revision} == 0 )
+		$state->{entries}{$file}{revision} eq '0' )
 	{
 	    push @gethead, { name => $file, filehash => 'added' };
 	}
@@ -2234,20 +2208,15 @@ sub statecleanup
     $state->{entries} = {};
 }
 
-# Return working directory revision int "X" from CVS revision "1.X" out
+# Return working directory CVS revision "1.X" out
 # of the the working directory "entries" state, for the given filename.
-# Return negative "X" to represent the file is scheduled for removal
+# This is prefixed with a dash if the file is scheduled for removal
 # when it is committed.
 sub revparse
 {
     my $filename = shift;
 
-    return undef unless ( defined ( $state->{entries}{$filename}{revision} ) );
-
-    return $1 if ( $state->{entries}{$filename}{revision} =~ /^1\.(\d+)/ );
-    return -$1 if ( $state->{entries}{$filename}{revision} =~ /^-1\.(\d+)/ );
-
-    return undef;
+    return $state->{entries}{$filename}{revision};
 }
 
 # This method takes a file hash and does a CVS "file transfer".  Its
@@ -3230,7 +3199,7 @@ sub update
     my $commitcount = 0;
 
     # Load the head table into $head (for cached lookups during the update process)
-    foreach my $file ( @{$self->gethead()} )
+    foreach my $file ( @{$self->gethead(1)} )
     {
         $head->{$file->{name}} = $file;
     }
@@ -3580,6 +3549,7 @@ sub _set_prop
 sub gethead
 {
     my $self = shift;
+    my $intRev = shift;
     my $tablename = $self->tablename("head");
 
     return $self->{gethead_cache} if ( defined ( $self->{gethead_cache} ) );
@@ -3590,6 +3560,10 @@ sub gethead
     my $tree = [];
     while ( my $file = $db_query->fetchrow_hashref )
     {
+        if(!$intRev)
+        {
+            $file->{revision} = "1.$file->{revision}"
+        }
         push @$tree, $file;
     }
 
@@ -3608,18 +3582,49 @@ sub getlog
 {
     my $self = shift;
     my $filename = shift;
+    my $revFilter = shift;
+
     my $tablename = $self->tablename("revision");
 
+    # Filters:
+    # TODO: date, state, or by specific logins filters?
+    # TODO: Handle comma-separated list of revFilter items, each item
+    #   can be a range [only case currently handled] or individual
+    #   rev or branch or "branch.".
+    # TODO: Adjust $db_query WHERE clause based on revFilter, instead of
+    #   manually filtering the results of the query?
+    my ( $minrev, $maxrev );
+    if( defined($revFilter) and
+        $state->{opt}{r} =~ /^(1.(\d+))?(::?)(1.(\d.+))?$/ )
+    {
+        my $control = $3;
+        $minrev = $2;
+        $maxrev = $5;
+        $minrev++ if ( defined($minrev) and $control eq "::" );
+    }
+
     my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, author, mode, revision, modified, commithash FROM $tablename WHERE name=? ORDER BY revision DESC",{},1);
     $db_query->execute($filename);
 
+    my $totalRevs=0;
     my $tree = [];
     while ( my $file = $db_query->fetchrow_hashref )
     {
+        $totalRevs++;
+        if( defined($minrev) and $file->{revision} < $minrev )
+        {
+            next;
+        }
+        if( defined($maxrev) and $file->{revision} > $maxrev )
+        {
+            next;
+        }
+
+        $file->{revision} = "1." . $file->{revision};
         push @$tree, $file;
     }
 
-    return $tree;
+    return ($tree,$totalRevs);
 }
 
 =head2 getmeta
@@ -3638,10 +3643,11 @@ sub getmeta
     my $tablename_head = $self->tablename("head");
 
     my $db_query;
-    if ( defined($revision) and $revision =~ /^\d+$/ )
+    if ( defined($revision) and $revision =~ /^1\.(\d+)$/ )
     {
+        my ($intRev) = $1;
         $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $tablename_rev WHERE name=? AND revision=?",{},1);
-        $db_query->execute($filename, $revision);
+        $db_query->execute($filename, $intRev);
     }
     elsif ( defined($revision) and $revision =~ /^[a-zA-Z0-9]{40}$/ )
     {
@@ -3652,7 +3658,12 @@ sub getmeta
         $db_query->execute($filename);
     }
 
-    return $db_query->fetchrow_hashref;
+    my $meta = $db_query->fetchrow_hashref;
+    if($meta)
+    {
+        $meta->{revision} = "1.$meta->{revision}";
+    }
+    return $meta;
 }
 
 =head2 commitmessage
@@ -3709,7 +3720,15 @@ sub gethistorydense
     $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM $tablename WHERE name=? AND filehash!='deleted' ORDER BY revision DESC",{},1);
     $db_query->execute($filename);
 
-    return $db_query->fetchall_arrayref;
+    my $result = $db_query->fetchall_arrayref;
+
+    my $i;
+    for($i=0 ; $i<scalar(@$result) ; $i++)
+    {
+        $result->[$i][0]="1." . $result->[$i][0];
+    }
+
+    return $result;
 }
 
 =head2 in_array()
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 6c693ff..9502f24 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -400,7 +400,7 @@ cat >expected.C <<EOF
 Line 0
 =======
 LINE 0
->>>>>>> merge.3
+>>>>>>> merge.1.3
 EOF
 
 for i in 1 2 3 4 5 6 7 8
-- 
1.7.10.2.484.gcd07cc5
