From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 18/20] cvsserver: support -r and sticky tags for most operations
Date: Sat, 13 Oct 2012 23:42:31 -0600
Message-ID: <1350193353-19210-19-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 08:08:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHN5-00078b-RD
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 08:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab2JNGIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 02:08:04 -0400
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:56417
	"EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752209Ab2JNGID (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 02:08:03 -0400
Received: from omta04.emeryville.ca.mail.comcast.net ([76.96.30.35])
	by qmta12.emeryville.ca.mail.comcast.net with comcast
	id Au7K1k0030lTkoCACu82mB; Sun, 14 Oct 2012 06:08:02 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta04.emeryville.ca.mail.comcast.net with comcast
	id Au311k00L2wKXRC8Qu32md; Sun, 14 Oct 2012 06:03:02 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 614431E9601A; Sat, 13 Oct 2012 23:43:20 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207637>

  - Split off prepDirForOutput for "update" and "commit".
    Some low level protocol details were changed to more closely
    resemble CVS even in non-tagged cases.  Hopefully it still works
    with finicky clients like Eclipse.
  - Substantial changes to "diff".  The output is now closer to
    standard CVS (including exit status), and can be used as
    a patch, but there are still a number of differences compared
    to CVS.
  - Tweaks to "add", "remove", "status", and "commit".
  - FUTURE: CVS revision numbers for branches simply encode git
    commit IDs in a way that resembles CVS revision numbers,
    dropping all normal CVS structural relations between different
    revision numbers.
  - FUTURE: "log" doesn't try to work properly at all with branches
    and tags.
  - FUTURE: "annotate" probably doesn't work with branches or
    tags either (untested)?

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 713 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 510 insertions(+), 203 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 5e558d1..3679074 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -611,7 +611,10 @@ sub req_add
     {
         $filename = filecleanup($filename);
 
-        my $meta = $updater->getmeta($filename);
+        # no -r, -A, or -D with add
+        my $stickyInfo = resolveStickyInfo($filename);
+
+        my $meta = $updater->getmeta($filename,$stickyInfo);
         my $wrev = revparse($filename);
 
         if ($wrev && $meta && ($wrev=~/^-/))
@@ -634,8 +637,10 @@ sub req_add
 
                 # this is an "entries" line
                 my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
-                $log->debug("/$filepart/$meta->{revision}//$kopts/");
-                print "/$filepart/$meta->{revision}//$kopts/\n";
+                my $entryLine = "/$filepart/$meta->{revision}//$kopts/";
+                $entryLine .= getStickyTagOrDate($stickyInfo);
+                $log->debug($entryLine);
+                print "$entryLine\n";
                 # permissions
                 $log->debug("SEND : u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}");
                 print "u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}\n";
@@ -666,7 +671,8 @@ sub req_add
         print "$filename\n";
         my $kopts = kopts_from_path($filename,"file",
                         $state->{entries}{$filename}{modified_filename});
-        print "/$filepart/0//$kopts/\n";
+        print "/$filepart/0//$kopts/" .
+              getStickyTagOrDate($stickyInfo) . "\n";
 
         my $requestedKopts = $state->{opt}{k};
         if(defined($requestedKopts))
@@ -734,7 +740,10 @@ sub req_remove
             next;
         }
 
-        my $meta = $updater->getmeta($filename);
+        # only from entries
+        my $stickyInfo = resolveStickyInfo($filename);
+
+        my $meta = $updater->getmeta($filename,$stickyInfo);
         my $wrev = revparse($filename);
 
         unless ( defined ( $wrev ) )
@@ -764,7 +773,7 @@ sub req_remove
         print "Checked-in $dirpart\n";
         print "$filename\n";
         my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
-        print "/$filepart/-$wrev//$kopts/\n";
+        print "/$filepart/-$wrev//$kopts/" . getStickyTagOrDate($stickyInfo) . "\n";
 
         $rmcount++;
     }
@@ -944,6 +953,9 @@ sub req_co
         return 1;
     }
 
+    my $stickyInfo = { 'tag' => $state->{opt}{r},
+                       'date' => $state->{opt}{D} };
+
     my $module = $state->{args}[0];
     $state->{module} = $module;
     my $checkout_path = $module;
@@ -961,64 +973,32 @@ sub req_co
     my $updater = GITCVS::updater->new($state->{CVSROOT}, $module, $log);
     $updater->update();
 
-    $checkout_path =~ s|/$||; # get rid of trailing slashes
+    my $headHash;
+    if( defined($stickyInfo) && defined($stickyInfo->{tag}) )
+    {
+        $headHash = $updater->lookupCommitRef($stickyInfo->{tag});
+        if( !defined($headHash) )
+        {
+            print "error 1 no such tag `$stickyInfo->{tag}'\n";
+            cleanupWorkTree();
+            exit;
+        }
+    }
 
-    # Eclipse seems to need the Clear-sticky command
-    # to prepare the 'Entries' file for the new directory.
-    print "Clear-sticky $checkout_path/\n";
-    print $state->{CVSROOT} . "/$module/\n";
-    print "Clear-static-directory $checkout_path/\n";
-    print $state->{CVSROOT} . "/$module/\n";
-    print "Clear-sticky $checkout_path/\n"; # yes, twice
-    print $state->{CVSROOT} . "/$module/\n";
-    print "Template $checkout_path/\n";
-    print $state->{CVSROOT} . "/$module/\n";
-    print "0\n";
-
-    # instruct the client that we're checking out to $checkout_path
-    print "E cvs checkout: Updating $checkout_path\n";
+    $checkout_path =~ s|/$||; # get rid of trailing slashes
 
     my %seendirs = ();
     my $lastdir ='';
 
-    # recursive
-    sub prepdir {
-       my ($dir, $repodir, $remotedir, $seendirs) = @_;
-       my $parent = dirname($dir);
-       $dir       =~ s|/+$||;
-       $repodir   =~ s|/+$||;
-       $remotedir =~ s|/+$||;
-       $parent    =~ s|/+$||;
-       $log->debug("announcedir $dir, $repodir, $remotedir" );
-
-       if ($parent eq '.' || $parent eq './') {
-           $parent = '';
-       }
-       # recurse to announce unseen parents first
-       if (length($parent) && !exists($seendirs->{$parent})) {
-           prepdir($parent, $repodir, $remotedir, $seendirs);
-       }
-       # Announce that we are going to modify at the parent level
-       if ($parent) {
-           print "E cvs checkout: Updating $remotedir/$parent\n";
-       } else {
-           print "E cvs checkout: Updating $remotedir\n";
-       }
-       print "Clear-sticky $remotedir/$parent/\n";
-       print "$repodir/$parent/\n";
-
-       print "Clear-static-directory $remotedir/$dir/\n";
-       print "$repodir/$dir/\n";
-       print "Clear-sticky $remotedir/$parent/\n"; # yes, twice
-       print "$repodir/$parent/\n";
-       print "Template $remotedir/$dir/\n";
-       print "$repodir/$dir/\n";
-       print "0\n";
-
-       $seendirs->{$dir} = 1;
-    }
-
-    foreach my $git ( @{$updater->gethead} )
+    prepDirForOutput(
+            ".",
+            $state->{CVSROOT} . "/$module",
+            $checkout_path,
+            \%seendirs,
+            'checkout',
+            $state->{dirArgs} );
+
+    foreach my $git ( @{$updater->getAnyHead($headHash)} )
     {
         # Don't want to check out deleted files
         next if ( $git->{filehash} eq "deleted" );
@@ -1026,16 +1006,13 @@ sub req_co
         my $fullName = $git->{name};
         ( $git->{name}, $git->{dir} ) = filenamesplit($git->{name});
 
-       if (length($git->{dir}) && $git->{dir} ne './'
-           && $git->{dir} ne $lastdir ) {
-           unless (exists($seendirs{$git->{dir}})) {
-               prepdir($git->{dir}, $state->{CVSROOT} . "/$module/",
-                       $checkout_path, \%seendirs);
-               $lastdir = $git->{dir};
-               $seendirs{$git->{dir}} = 1;
-           }
-           print "E cvs checkout: Updating /$checkout_path/$git->{dir}\n";
-       }
+        unless (exists($seendirs{$git->{dir}})) {
+            prepDirForOutput($git->{dir}, $state->{CVSROOT} . "/$module/",
+                             $checkout_path, \%seendirs, 'checkout',
+                             $state->{dirArgs} );
+            $lastdir = $git->{dir};
+            $seendirs{$git->{dir}} = 1;
+        }
 
         # modification time of this file
         print "Mod-time $git->{modified}\n";
@@ -1055,7 +1032,8 @@ sub req_co
 
         # this is an "entries" line
         my $kopts = kopts_from_path($fullName,"sha1",$git->{filehash});
-        print "/$git->{name}/$git->{revision}//$kopts/\n";
+        print "/$git->{name}/$git->{revision}//$kopts/" .
+                        getStickyTagOrDate($stickyInfo) . "\n";
         # permissions
         print "u=$git->{mode},g=$git->{mode},o=$git->{mode}\n";
 
@@ -1068,6 +1046,119 @@ sub req_co
     statecleanup();
 }
 
+# used by req_co and req_update to set up directories for files
+# recursively handles parents
+sub prepDirForOutput
+{
+    my ($dir, $repodir, $remotedir, $seendirs, $request, $dirArgs) = @_;
+
+    my $parent = dirname($dir);
+    $dir       =~ s|/+$||;
+    $repodir   =~ s|/+$||;
+    $remotedir =~ s|/+$||;
+    $parent    =~ s|/+$||;
+
+    if ($parent eq '.' || $parent eq './')
+    {
+        $parent = '';
+    }
+    # recurse to announce unseen parents first
+    if( length($parent) &&
+        !exists($seendirs->{$parent}) &&
+        ( $request eq "checkout" ||
+          exists($dirArgs->{$parent}) ) )
+    {
+        prepDirForOutput($parent, $repodir, $remotedir,
+                         $seendirs, $request, $dirArgs);
+    }
+    # Announce that we are going to modify at the parent level
+    if ($dir eq '.' || $dir eq './')
+    {
+        $dir = '';
+    }
+    if(exists($seendirs->{$dir}))
+    {
+        return;
+    }
+    $log->debug("announcedir $dir, $repodir, $remotedir" );
+    my($thisRemoteDir,$thisRepoDir);
+    if ($dir ne "")
+    {
+        $thisRepoDir="$repodir/$dir";
+        if($remotedir eq ".")
+        {
+            $thisRemoteDir=$dir;
+        }
+        else
+        {
+            $thisRemoteDir="$remotedir/$dir";
+        }
+    }
+    else
+    {
+        $thisRepoDir=$repodir;
+        $thisRemoteDir=$remotedir;
+    }
+    unless ( $state->{globaloptions}{-Q} || $state->{globaloptions}{-q} )
+    {
+        print "E cvs $request: Updating $thisRemoteDir\n";
+    }
+
+    my ($opt_r)=$state->{opt}{r};
+    my $stickyInfo;
+    if(exists($state->{opt}{A}))
+    {
+        # $stickyInfo=undef;
+    }
+    elsif( defined($opt_r) && $opt_r ne "" )
+           # || ( defined($state->{opt}{D}) && $state->{opt}{D} ne "" ) # TODO
+    {
+        $stickyInfo={ 'tag' => (defined($opt_r)?$opt_r:undef) };
+
+        # TODO: Convert -D value into the form 2011.04.10.04.46.57,
+        #   similar to an entry line's sticky date, without the D prefix.
+        #   It sometimes (always?) arrives as something more like
+        #   '10 Apr 2011 04:46:57 -0000'...
+        # $stickyInfo={ 'date' => (defined($stickyDate)?$stickyDate:undef) };
+    }
+    else
+    {
+        $stickyInfo=getDirStickyInfo($state->{prependdir} . $dir);
+    }
+
+    my $stickyResponse;
+    if(defined($stickyInfo))
+    {
+        $stickyResponse = "Set-sticky $thisRemoteDir/\n" .
+                          "$thisRepoDir/\n" .
+                          getStickyTagOrDate($stickyInfo) . "\n";
+    }
+    else
+    {
+        $stickyResponse = "Clear-sticky $thisRemoteDir/\n" .
+                          "$thisRepoDir/\n";
+    }
+
+    unless ( $state->{globaloptions}{-n} )
+    {
+        print $stickyResponse;
+
+        print "Clear-static-directory $thisRemoteDir/\n";
+        print "$thisRepoDir/\n";
+        print $stickyResponse; # yes, twice
+        print "Template $thisRemoteDir/\n";
+        print "$thisRepoDir/\n";
+        print "0\n";
+    }
+
+    $seendirs->{$dir} = 1;
+
+    # FUTURE: This would more accurately emulate CVS by sending
+    #   another copy of sticky after processing the files in that
+    #   directory.  Or intermediate: perhaps send all sticky's for
+    #   $seendirs after after processing all files.
+}
+
 # update \n
 #     Response expected: yes. Actually do a cvs update command. This uses any
 #     previous Argument, Directory, Entry, or Modified requests, if they have
@@ -1111,29 +1202,19 @@ sub req_update
 
     #$log->debug("update state : " . Dumper($state));
 
-    my $last_dirname = "///";
+    my($repoDir);
+    $repoDir=$state->{CVSROOT} . "/$state->{module}/$state->{prependdir}";
+
+    my %seendirs = ();
 
     # foreach file specified on the command line ...
-    foreach my $filename ( @{$state->{args}} )
+    foreach my $argsFilename ( @{$state->{args}} )
     {
-        $filename = filecleanup($filename);
+        my $filename;
+        $filename = filecleanup($argsFilename);
 
         $log->debug("Processing file $filename");
 
-        unless ( $state->{globaloptions}{-Q} || $state->{globaloptions}{-q} )
-        {
-            my $cur_dirname = dirname($filename);
-            if ( $cur_dirname ne $last_dirname )
-            {
-                $last_dirname = $cur_dirname;
-                if ( $cur_dirname eq "" )
-                {
-                    $cur_dirname = ".";
-                }
-                print "E cvs update: Updating $cur_dirname\n";
-            }
-        }
-
         # if we have a -C we should pretend we never saw modified stuff
         if ( exists ( $state->{opt}{C} ) )
         {
@@ -1142,13 +1223,11 @@ sub req_update
             $state->{entries}{$filename}{unchanged} = 1;
         }
 
-        my $meta;
-        if ( defined($state->{opt}{r}) and $state->{opt}{r} =~ /^(1\.\d+)$/ )
-        {
-            $meta = $updater->getmeta($filename, $1);
-        } else {
-            $meta = $updater->getmeta($filename);
-        }
+        my $stickyInfo = resolveStickyInfo($filename,
+                                           $state->{opt}{r},
+                                           $state->{opt}{D},
+                                           exists($state->{opt}{A}));
+        my $meta = $updater->getmeta($filename, $stickyInfo);
 
         # If -p was given, "print" the contents of the requested revision.
         if ( exists ( $state->{opt}{p} ) ) {
@@ -1161,6 +1240,17 @@ sub req_update
             next;
         }
 
+        # Directories:
+        prepDirForOutput(
+                dirname($argsFilename),
+                $repoDir,
+                ".",
+                \%seendirs,
+                "update",
+                $state->{dirArgs} );
+
+        my $wrev = revparse($filename);
+
 	if ( ! defined $meta )
 	{
 	    $meta = {
@@ -1168,16 +1258,23 @@ sub req_update
 	        revision => '0',
 	        filehash => 'added'
 	    };
+	    if($wrev ne "0")
+	    {
+	        $meta->{filehash}='deleted';
+	    }
 	}
 
         my $oldmeta = $meta;
 
-        my $wrev = revparse($filename);
-
         # If the working copy is an old revision, lets get that version too for comparison.
-        if ( defined($wrev) and $wrev ne $meta->{revision} )
+        my $oldWrev=$wrev;
+        if(defined($oldWrev))
         {
-            $oldmeta = $updater->getmeta($filename, $wrev);
+            $oldWrev=~s/^-//;
+            if($oldWrev ne $meta->{revision})
+            {
+                $oldmeta = $updater->getmeta($filename, $oldWrev);
+            }
         }
 
         #$log->debug("Target revision is $meta->{revision}, current working revision is $wrev");
@@ -1195,6 +1292,7 @@ sub req_update
         if ( defined ( $wrev )
              and defined($meta->{revision})
              and $wrev eq $meta->{revision}
+             and $wrev ne "0"
              and defined($state->{entries}{$filename}{modified_hash})
              and not exists ( $state->{opt}{C} ) )
         {
@@ -1205,7 +1303,7 @@ sub req_update
             next;
         }
 
-        if ( $meta->{filehash} eq "deleted" )
+        if ( $meta->{filehash} eq "deleted" && $wrev ne "0" )
         {
             # TODO: If it has been modified in the sandbox, error out
             #   with the appropriate message, rather than deleting a modified
@@ -1267,10 +1365,6 @@ sub req_update
 		    $log->debug("Updating existing file 'Update-existing $dirpart'");
 		} else {
 		    # instruct client we're sending a file to put in this path as a new file
-		    print "Clear-static-directory $dirpart\n";
-		    print $state->{CVSROOT} . "/$state->{module}/$dirpart\n";
-		    print "Clear-sticky $dirpart\n";
-		    print $state->{CVSROOT} . "/$state->{module}/$dirpart\n";
 
 		    $log->debug("Creating new file 'Created $dirpart'");
 		    print "Created $dirpart\n";
@@ -1279,8 +1373,10 @@ sub req_update
 
 		# this is an "entries" line
 		my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
-		$log->debug("/$filepart/$meta->{revision}//$kopts/");
-		print "/$filepart/$meta->{revision}//$kopts/\n";
+                my $entriesLine = "/$filepart/$meta->{revision}//$kopts/";
+                $entriesLine .= getStickyTagOrDate($stickyInfo);
+		$log->debug($entriesLine);
+		print "$entriesLine\n";
 
 		# permissions
 		$log->debug("SEND : u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}");
@@ -1328,7 +1424,9 @@ sub req_update
                     my $kopts = kopts_from_path("$dirpart/$filepart",
                                                 "file",$mergedFile);
                     $log->debug("/$filepart/$meta->{revision}//$kopts/");
-                    print "/$filepart/$meta->{revision}//$kopts/\n";
+                    my $entriesLine="/$filepart/$meta->{revision}//$kopts/";
+                    $entriesLine .= getStickyTagOrDate($stickyInfo);
+                    print "$entriesLine\n";
                 }
             }
             elsif ( $return == 1 )
@@ -1344,7 +1442,9 @@ sub req_update
                     print $state->{CVSROOT} . "/$state->{module}/$filename\n";
                     my $kopts = kopts_from_path("$dirpart/$filepart",
                                                 "file",$mergedFile);
-                    print "/$filepart/$meta->{revision}/+/$kopts/\n";
+                    my $entriesLine = "/$filepart/$meta->{revision}/+/$kopts/";
+                    $entriesLine .= getStickyTagOrDate($stickyInfo);
+                    print "$entriesLine\n";
                 }
             }
             else
@@ -1372,6 +1472,43 @@ sub req_update
 
     }
 
+    # prepDirForOutput() any other existing directories unless they already
+    # have the right sticky tag:
+    unless ( $state->{globaloptions}{n} )
+    {
+        my $dir;
+        foreach $dir (keys(%{$state->{dirMap}}))
+        {
+            if( ! $seendirs{$dir} &&
+                exists($state->{dirArgs}{$dir}) )
+            {
+                my($oldTag);
+                $oldTag=$state->{dirMap}{$dir}{tagspec};
+
+                unless( ( exists($state->{opt}{A}) &&
+                          defined($oldTag) ) ||
+                          ( defined($state->{opt}{r}) &&
+                            ( !defined($oldTag) ||
+                              $state->{opt}{r} ne $oldTag ) ) )
+                        # TODO?: OR sticky dir is different...
+                {
+                    next;
+                }
+
+                prepDirForOutput(
+                        $dir,
+                        $repoDir,
+                        ".",
+                        \%seendirs,
+                        'update',
+                        $state->{dirArgs} );
+            }
+
+            # TODO?: Consider sending a final duplicate Sticky response
+            #   to more closely mimic real CVS.
+        }
+    }
+
     print "ok\n";
 }
 
@@ -1404,23 +1541,11 @@ sub req_ci
     my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
     $updater->update();
 
-    # Remember where the head was at the beginning.
-    my $parenthash = `git show-ref -s refs/heads/$state->{module}`;
-    chomp $parenthash;
-    if ($parenthash !~ /^[0-9a-f]{40}$/) {
-	    print "error 1 pserver cannot find the current HEAD of module";
-	    cleanupWorkTree();
-	    exit;
-    }
-
-    setupWorkTree($parenthash);
-
-    $log->info("Lockless commit start, basing commit on '$work->{workDir}', index file is '$work->{index}'");
-
-    $log->info("Created index '$work->{index}' for head $state->{module} - exit status $?");
-
     my @committedfiles = ();
     my %oldmeta;
+    my $stickyInfo;
+    my $branchRef;
+    my $parenthash;
 
     # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
@@ -1430,7 +1555,67 @@ sub req_ci
 
         next unless ( exists $state->{entries}{$filename}{modified_filename} or not $state->{entries}{$filename}{unchanged} );
 
-        my $meta = $updater->getmeta($filename);
+        #####
+        # Figure out which branch and parenthash we are committing
+        # to, and setup worktree:
+
+        # should always come from entries:
+        my $fileStickyInfo = resolveStickyInfo($filename);
+        if( !defined($branchRef) )
+        {
+            $stickyInfo = $fileStickyInfo;
+            if( defined($stickyInfo) &&
+                ( defined($stickyInfo->{date}) ||
+                  !defined($stickyInfo->{tag}) ) )
+            {
+                print "error 1 cannot commit with sticky date for file `$filename'\n";
+                cleanupWorkTree();
+                exit;
+            }
+
+            $branchRef = "refs/heads/$state->{module}";
+            if ( defined($stickyInfo) && defined($stickyInfo->{tag}) )
+            {
+                $branchRef = "refs/heads/$stickyInfo->{tag}";
+            }
+
+            $parenthash = `git show-ref -s $branchRef`;
+            chomp $parenthash;
+            if ($parenthash !~ /^[0-9a-f]{40}$/)
+            {
+                if ( defined($stickyInfo) && defined($stickyInfo->{tag}) )
+                {
+                    print "error 1 sticky tag `$stickyInfo->{tag}' for file `$filename' is not a branch\n";
+                }
+                else
+                {
+                    print "error 1 pserver cannot find the current HEAD of module";
+                }
+                cleanupWorkTree();
+                exit;
+            }
+
+            setupWorkTree($parenthash);
+
+            $log->info("Lockless commit start, basing commit on '$work->{workDir}', index file is '$work->{index}'");
+
+            $log->info("Created index '$work->{index}' for head $state->{module} - exit status $?");
+        }
+        elsif( !refHashEqual($stickyInfo,$fileStickyInfo) )
+        {
+            #TODO: We could split the cvs commit into multiple
+            #  git commits by distinct stickyTag values, but that
+            #  is lowish priority.
+            print "error 1 Committing different files to different"
+                  . " branches is not currently supported\n";
+            cleanupWorkTree();
+            exit;
+        }
+
+        #####
+        # Process this file:
+
+        my $meta = $updater->getmeta($filename,$stickyInfo);
 	$oldmeta{$filename} = $meta;
 
         my $wrev = revparse($filename);
@@ -1532,7 +1717,7 @@ sub req_ci
     }
 
 	### Emulate git-receive-pack by running hooks/update
-	my @hook = ( $ENV{GIT_DIR}.'hooks/update', "refs/heads/$state->{module}",
+	my @hook = ( $ENV{GIT_DIR}.'hooks/update', $branchRef,
 			$parenthash, $commithash );
 	if( -x $hook[0] ) {
 		unless( system( @hook ) == 0 )
@@ -1546,7 +1731,7 @@ sub req_ci
 
 	### Update the ref
 	if (system(qw(git update-ref -m), "cvsserver ci",
-			"refs/heads/$state->{module}", $commithash, $parenthash)) {
+			$branchRef, $commithash, $parenthash)) {
 		$log->warn("update-ref for $state->{module} failed.");
 		print "error 1 Cannot commit -- update first\n";
 		cleanupWorkTree();
@@ -1560,7 +1745,7 @@ sub req_ci
 
 		local $SIG{PIPE} = sub { die 'pipe broke' };
 
-		print $pipe "$parenthash $commithash refs/heads/$state->{module}\n";
+		print $pipe "$parenthash $commithash $branchRef\n";
 
 		close $pipe || die "bad pipe: $! $?";
 	}
@@ -1570,7 +1755,7 @@ sub req_ci
 	### Then hooks/post-update
 	$hook = $ENV{GIT_DIR}.'hooks/post-update';
 	if (-x $hook) {
-		system($hook, "refs/heads/$state->{module}");
+		system($hook, $branchRef);
 	}
 
     # foreach file specified on the command line ...
@@ -1578,7 +1763,7 @@ sub req_ci
     {
         $filename = filecleanup($filename);
 
-        my $meta = $updater->getmeta($filename);
+        my $meta = $updater->getmeta($filename,$stickyInfo);
 	unless (defined $meta->{revision}) {
 	  $meta->{revision} = "1.1";
 	}
@@ -1602,7 +1787,8 @@ sub req_ci
             print "Checked-in $dirpart\n";
             print "$filename\n";
             my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
-            print "/$filepart/$meta->{revision}//$kopts/\n";
+            print "/$filepart/$meta->{revision}//$kopts/" .
+                  getStickyTagOrDate($stickyInfo) . "\n";
         }
     }
 
@@ -1639,16 +1825,19 @@ sub req_status
            next;
         }
 
-        my $meta = $updater->getmeta($filename);
-        my $oldmeta = $meta;
-
         my $wrev = revparse($filename);
 
+        my $stickyInfo = resolveStickyInfo($filename);
+        my $meta = $updater->getmeta($filename,$stickyInfo);
+        my $oldmeta = $meta;
+
         # If the working copy is an old revision, lets get that
         # version too for comparison.
         if ( defined($wrev) and $wrev ne $meta->{revision} )
         {
-            $oldmeta = $updater->getmeta($filename, $wrev);
+            my($rmRev)=$wrev;
+            $rmRev=~s/^-//;
+            $oldmeta = $updater->getmeta($filename, $rmRev);
         }
 
         # TODO : All possible statuses aren't yet implemented
@@ -1691,6 +1880,7 @@ sub req_status
         # same revision but there are local changes
         if ( defined ( $wrev ) and defined($meta->{revision}) and
              $wrev eq $meta->{revision} and
+             $wrev ne "0" and
              $state->{entries}{$filename}{modified_filename} )
         {
             $status ||= "Locally Modified";
@@ -1706,7 +1896,8 @@ sub req_status
         }
 
         if ( defined ( $state->{entries}{$filename}{revision} ) and
-             not defined ( $meta->{revision} ) )
+             ( !defined($meta->{revision}) ||
+               $meta->{revision} eq "0" ) )
         {
             $status ||= "Locally Added";
         }
@@ -1802,98 +1993,133 @@ sub req_diff
     # be providing status on ...
     argsfromdir($updater);
 
+    my($foundDiff);
+
     # foreach file specified on the command line ...
-    foreach my $filename ( @{$state->{args}} )
+    foreach my $argFilename ( @{$state->{args}} )
     {
-        $filename = filecleanup($filename);
+        my($filename) = filecleanup($argFilename);
 
         my ( $fh, $file1, $file2, $meta1, $meta2, $filediff );
 
         my $wrev = revparse($filename);
 
-        # We need _something_ to diff against
-        next unless ( defined ( $wrev ) );
+        # Priority for revision1:
+        #  1. First -r (missing file: check -N)
+        #  2. wrev from client's Entry line
+        #      - missing line/file: check -N
+        #      - "0": added file not committed (empty contents for rev1)
+        #      - Prefixed with dash (to be removed): check -N
 
-        # if we have a -r switch, use it
         if ( defined ( $revision1 ) )
         {
-            ( undef, $file1 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
             $meta1 = $updater->getmeta($filename, $revision1);
-            unless ( defined ( $meta1 ) and $meta1->{filehash} ne "deleted" )
+        }
+        elsif( defined($wrev) && $wrev ne "0" )
+        {
+            my($rmRev)=$wrev;
+            $rmRev=~s/^-//;
+            $meta1 = $updater->getmeta($filename, $rmRev);
+        }
+        if ( !defined($meta1) ||
+             $meta1->{filehash} eq "deleted" )
+        {
+            if( !exists($state->{opt}{N}) )
             {
-                print "E File $filename at revision $revision1 doesn't exist\n";
+                if(!defined($revision1))
+                {
+                    print "E File $filename at revision $revision1 doesn't exist\n";
+                }
                 next;
             }
-            transmitfile($meta1->{filehash}, { targetfile => $file1 });
-        }
-        # otherwise we just use the working copy revision
-        else
-        {
-            ( undef, $file1 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
-            $meta1 = $updater->getmeta($filename, $wrev);
-            transmitfile($meta1->{filehash}, { targetfile => $file1 });
+            elsif( !defined($meta1) )
+            {
+                $meta1 = {
+                    name => $filename,
+                    revision => '0',
+                    filehash => 'deleted'
+                };
+            }
         }
 
+        # Priority for revision2:
+        #  1. Second -r (missing file: check -N)
+        #  2. Modified file contents from client
+        #  3. wrev from client's Entry line
+        #      - missing line/file: check -N
+        #      - Prefixed with dash (to be removed): check -N
+
         # if we have a second -r switch, use it too
         if ( defined ( $revision2 ) )
         {
-            ( undef, $file2 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
             $meta2 = $updater->getmeta($filename, $revision2);
-
-            unless ( defined ( $meta2 ) and $meta2->{filehash} ne "deleted" )
-            {
-                print "E File $filename at revision $revision2 doesn't exist\n";
-                next;
-            }
-
-            transmitfile($meta2->{filehash}, { targetfile => $file2 });
         }
-        # otherwise we just use the working copy
-        else
+        elsif(defined($state->{entries}{$filename}{modified_filename}))
         {
             $file2 = $state->{entries}{$filename}{modified_filename};
+	    $meta2 = {
+                name => $filename,
+	        revision => '0',
+	        filehash => 'modified'
+            };
         }
-
-        # if we have been given -r, and we don't have a $file2 yet, lets
-        # get one
-        if ( defined ( $revision1 ) and not defined ( $file2 ) )
+        elsif( defined($wrev) && ($wrev!~/^-/) )
         {
-            ( undef, $file2 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
+            if(!defined($revision1))  # no revision and no modifications:
+            {
+                next;
+            }
             $meta2 = $updater->getmeta($filename, $wrev);
-            transmitfile($meta2->{filehash}, { targetfile => $file2 });
+        }
+        if(!defined($file2))
+        {
+            if ( !defined($meta2) ||
+                 $meta2->{filehash} eq "deleted" )
+            {
+                if( !exists($state->{opt}{N}) )
+                {
+                    if(!defined($revision2))
+                    {
+                        print "E File $filename at revision $revision2 doesn't exist\n";
+                    }
+                    next;
+                }
+                elsif( !defined($meta2) )
+                {
+	            $meta2 = {
+                        name => $filename,
+	                revision => '0',
+	                filehash => 'deleted'
+                    };
+                }
+            }
         }
 
-        # We need to have retrieved something useful
-        next unless ( defined ( $meta1 ) );
-
-        # Files to date if the working copy and repo copy have the same
-        # revision, and the working copy is unmodified
-        if ( not defined ( $meta2 ) and $wrev eq $meta1->{revision} and
-             ( ( $state->{entries}{$filename}{unchanged} and
-                 ( not defined ( $state->{entries}{$filename}{conflict} ) or
-                   $state->{entries}{$filename}{conflict} !~ /^\+=/ ) ) or
-               ( defined($state->{entries}{$filename}{modified_hash}) and
-                 $state->{entries}{$filename}{modified_hash} eq
-                        $meta1->{filehash} ) ) )
+        if( $meta1->{filehash} eq $meta2->{filehash} )
         {
+            $log->info("unchanged $filename");
             next;
         }
 
-        # Apparently we only show diffs for locally modified files
-        unless ( defined($meta2) or
-                 defined ( $state->{entries}{$filename}{modified_filename} ) )
+        # Retrieve revision contents:
+        ( undef, $file1 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
+        transmitfile($meta1->{filehash}, { targetfile => $file1 });
+
+        if(!defined($file2))
         {
-            next;
+            ( undef, $file2 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
+            transmitfile($meta2->{filehash}, { targetfile => $file2 });
         }
 
-        print "M Index: $filename\n";
+        # Generate the actual diff:
+        print "M Index: $argFilename\n";
         print "M =======" . ( "=" x 60 ) . "\n";
         print "M RCS file: $state->{CVSROOT}/$state->{module}/$filename,v\n";
-        if ( defined ( $meta1 ) )
+        if ( defined ( $meta1 ) && $meta1->{revision} ne "0" )
         {
             print "M retrieving revision $meta1->{revision}\n"
         }
-        if ( defined ( $meta2 ) )
+        if ( defined ( $meta2 ) && $meta2->{revision} ne "0" )
         {
             print "M retrieving revision $meta2->{revision}\n"
         }
@@ -1914,33 +2140,73 @@ sub req_diff
                 }
             }
         }
-        print "$filename\n";
+        print "$argFilename\n";
 
         $log->info("Diffing $filename -r $meta1->{revision} -r " .
                    ( $meta2->{revision} or "workingcopy" ));
 
-        ( $fh, $filediff ) = tempfile ( DIR => $TEMP_DIR );
-
-        if ( exists $state->{opt}{u} )
+        # TODO: Use --label instead of -L because -L is no longer
+        #  documented and may go away someday.  Not sure if there there are
+        #  versions that only support -L, which would make this change risky?
+        #  http://osdir.com/ml/bug-gnu-utils-gnu/2010-12/msg00060.html
+        #    ("man diff" should actually document the best migration strategy,
+        #  [current behavior, future changes, old compatibility issues
+        #  or lack thereof, etc], not just stop mentioning the option...)
+        # TODO: Real CVS seems to include a date in the label, before
+        #  the revision part, without the keyword "revision".  The following
+        #  has minimal changes compared to original versions of
+        #  git-cvsserver.perl.  (Mostly tab vs space after filename.)
+
+        my (@diffCmd) = ( 'diff' );
+        if ( exists($state->{opt}{N}) )
         {
-            system("diff -u -L '$filename revision $meta1->{revision}'" .
-                        " -L '$filename " .
-                        ( defined($meta2->{revision}) ?
-                                "revision $meta2->{revision}" :
-                                "working copy" ) .
-                        "' $file1 $file2 > $filediff" );
-        } else {
-            system("diff $file1 $file2 > $filediff");
+            push @diffCmd,"-N";
         }
+        if ( exists $state->{opt}{u} )
+        {
+            push @diffCmd,("-u","-L");
+            if( $meta1->{filehash} eq "deleted" )
+            {
+                push @diffCmd,"/dev/null";
+            } else {
+                push @diffCmd,("$argFilename\trevision $meta1->{revision}");
+            }
 
-        while ( <$fh> )
+            if( defined($meta2->{filehash}) )
+            {
+                if( $meta2->{filehash} eq "deleted" )
+                {
+                    push @diffCmd,("-L","/dev/null");
+                } else {
+                    push @diffCmd,("-L",
+                                   "$argFilename\trevision $meta2->{revision}");
+                }
+            } else {
+                push @diffCmd,("-L","$argFilename\tworking copy");
+            }
+        }
+        push @diffCmd,($file1,$file2);
+        if(!open(DIFF,"-|",@diffCmd))
         {
-            print "M $_";
+            $log->warn("Unable to run diff: $!");
         }
-        close $fh;
+        my($diffLine);
+        while(defined($diffLine=<DIFF>))
+        {
+            print "M $diffLine";
+            $foundDiff=1;
+        }
+        close(DIFF);
     }
 
-    print "ok\n";
+    if($foundDiff)
+    {
+        print "error  \n";
+    }
+    else
+    {
+        print "ok\n";
+    }
 }
 
 sub req_log
@@ -2160,7 +2426,7 @@ sub argsplit
         $opt = { A => 0, N => 0, P => 0, R => 0, c => 0, f => 0, l => 0, n => 0, p => 0, s => 0, r => 1, D => 1, d => 1, k => 1, j => 1, } if ( $type eq "co" );
         $opt = { v => 0, l => 0, R => 0 } if ( $type eq "status" );
         $opt = { A => 0, P => 0, C => 0, d => 0, f => 0, l => 0, R => 0, p => 0, k => 1, r => 1, D => 1, j => 1, I => 1, W => 1 } if ( $type eq "update" );
-        $opt = { l => 0, R => 0, k => 1, D => 1, D => 1, r => 2 } if ( $type eq "diff" );
+        $opt = { l => 0, R => 0, k => 1, D => 1, D => 1, r => 2, N => 0 } if ( $type eq "diff" );
         $opt = { c => 0, R => 0, l => 0, f => 0, F => 1, m => 1, r => 1 } if ( $type eq "ci" );
         $opt = { k => 1, m => 1 } if ( $type eq "add" );
         $opt = { f => 0, l => 0, R => 0 } if ( $type eq "remove" );
@@ -3101,6 +3367,45 @@ sub descramble
     return $ret;
 }
 
+# Test if the (deep) values of two references to a hash are the same.
+sub refHashEqual
+{
+    my($v1,$v2) = @_;
+
+    my $out;
+    if(!defined($v1))
+    {
+        if(!defined($v2))
+        {
+            $out=1;
+        }
+    }
+    elsif( !defined($v2) ||
+           scalar(keys(%{$v1})) != scalar(keys(%{$v2})) )
+    {
+        # $out=undef;
+    }
+    else
+    {
+        $out=1;
+
+        my $key;
+        foreach $key (keys(%{$v1}))
+        {
+            if( !exists($v2->{$key}) ||
+                defined($v1->{$key}) ne defined($v2->{$key}) ||
+                ( defined($v1->{$key}) &&
+                  $v1->{$key} ne $v2->{$key} ) )
+            {
+               $out=undef;
+               last;
+            }
+        }
+    }
+
+    return $out;
+}
+
 
 package GITCVS::log;
 
@@ -3506,6 +3811,8 @@ sub update
     my $lastcommit = $self->_get_prop("last_commit");
 
     if (defined $lastcommit && $lastcommit eq $commitsha1) { # up-to-date
+         # invalidate the gethead cache
+         $self->clearCommitRefCaches();
          return 1;
     }
 
-- 
1.7.10.2.484.gcd07cc5
