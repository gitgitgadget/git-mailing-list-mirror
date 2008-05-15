From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 1/3] git-cvsserver: add mechanism for managing working tree and current directory
Date: Wed, 14 May 2008 22:35:46 -0600
Message-ID: <1210826148-8708-2-git-send-email-mmogilvi_git@miniinfo.net>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 06:36:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwVCz-0001W0-3I
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 06:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbYEOEf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 00:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbYEOEf5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 00:35:57 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:46710
	"EHLO QMTA06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751418AbYEOEfy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 00:35:54 -0400
Received: from OMTA11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by QMTA06.westchester.pa.mail.comcast.net with comcast
	id RfY01Z0080mv7h05605700; Thu, 15 May 2008 04:35:53 +0000
Received: from fast.fake.domain.org ([75.70.160.185])
	by OMTA11.westchester.pa.mail.comcast.net with comcast
	id Rgbt1Z00240J0Bv3X00000; Thu, 15 May 2008 04:35:53 +0000
X-Authority-Analysis: v=1.0 c=1 a=q77xlIqc6cIA:10 a=XCi9RSTs5d4A:10
 a=hnmYV7qboChJw2SijvcA:9 a=aSKkNXWl5pjRyL3EyvEA:7
 a=QdAorSVeKLNjRBNTWnEOigoak0sA:4 a=3cjVDzgxsZYA:10 a=XF7b4UCPwd8A:10
Received: from localhost.localdomain(really [192.168.30.96]) by fast.fake.domain.org
	via sendmail with esmtp
	id <m1JwVC2-000twQC@fast.fake.domain.org>
	for <mmogilvi_git@miniinfo.net>; Wed, 14 May 2008 22:35:50 -0600 (MDT)
	(Smail-3.2 1996-Jul-4 #13 built 1998-Aug-8)
X-Mailer: git-send-email 1.5.4.3.340.g97b97
In-Reply-To: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82175>

There are various reasons git-cvsserver needs to manipulate the current
directory, and this patch attempts to clarify and validate such changes:

1. Temporary empty working directory (with index) for certain operations
   that require an index file to work.
2. Use a temporary directory with temporary file names for doing
   merges of user's dirty sandbox state with latest changes in
   repository.
3. Coming up soon: Set up an index and either a valid or empty
   working directory when calling git-check-attr to decide
   if a file should be marked binary (-kb).

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

I'm not sure about this.  I get the vague sense it might be better to
just always set up a (usually empty except for the index file and
user's changed files) working directory early in processing, and
minimize chdir calls after that.  It might also make it
possible to have a new .gitattributes file take effect immediately.
But that would be a much more invasive change.

 git-cvsserver.perl |  252 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 213 insertions(+), 39 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 29dbfc9..674892b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -21,6 +21,7 @@ use bytes;
 
 use Fcntl;
 use File::Temp qw/tempdir tempfile/;
+use File::Path qw/rmtree/;
 use File::Basename;
 use Getopt::Long qw(:config require_order no_ignore_case);
 
@@ -86,6 +87,17 @@ my $methods = {
 # $state holds all the bits of information the clients sends us that could
 # potentially be useful when it comes to actually _doing_ something.
 my $state = { prependdir => '' };
+
+# Work is for managing temporary working directory
+my $work =
+    {
+        state => undef,  # undef, 1 (empty), 2 (with stuff)
+        workDir => undef,
+        index => undef,
+        emptyDir => undef,
+        tmpDir => undef
+    };
+
 $log->info("--------------- STARTING -----------------");
 
 my $usage =
@@ -189,6 +201,9 @@ while (<STDIN>)
 $log->debug("Processing time : user=" . (times)[0] . " system=" . (times)[1]);
 $log->info("--------------- FINISH -----------------");
 
+chdir '/';
+exit 0;
+
 # Magic catchall method.
 #    This is the method that will handle all commands we haven't yet
 #    implemented. It simply sends a warning to the log file indicating a
@@ -1101,10 +1116,10 @@ sub req_update
             $log->info("Updating '$filename'");
             my ( $filepart, $dirpart ) = filenamesplit($meta->{name},1);
 
-            my $dir = tempdir( DIR => $TEMP_DIR, CLEANUP => 1 ) . "/";
+            my $mergeDir = setupTmpDir();
 
-            chdir $dir;
             my $file_local = $filepart . ".mine";
+            my $mergedFile = "$mergeDir/$file_local";
             system("ln","-s",$state->{entries}{$filename}{modified_filename}, $file_local);
             my $file_old = $filepart . "." . $oldmeta->{revision};
             transmitfile($oldmeta->{filehash}, { targetfile => $file_old });
@@ -1115,11 +1130,13 @@ sub req_update
             $log->info("Merging $file_local, $file_old, $file_new");
             print "M Merging differences between 1.$oldmeta->{revision} and 1.$meta->{revision} into $filename\n";
 
-            $log->debug("Temporary directory for merge is $dir");
+            $log->debug("Temporary directory for merge is $mergeDir");
 
             my $return = system("git", "merge-file", $file_local, $file_old, $file_new);
             $return >>= 8;
 
+            cleanupTmpDir();
+
             if ( $return == 0 )
             {
                 $log->info("Merged successfully");
@@ -1168,13 +1185,11 @@ sub req_update
                 # transmit file, format is single integer on a line by itself (file
                 # size) followed by the file contents
                 # TODO : we should copy files in blocks
-                my $data = `cat $file_local`;
+                my $data = `cat $mergedFile`;
                 $log->debug("File size : " . length($data));
                 print length($data) . "\n";
                 print $data;
             }
-
-            chdir "/";
         }
 
     }
@@ -1195,6 +1210,7 @@ sub req_ci
     if ( $state->{method} eq 'pserver')
     {
         print "error 1 pserver access cannot commit\n";
+        cleanupWorkTree();
         exit;
     }
 
@@ -1202,6 +1218,7 @@ sub req_ci
     {
         $log->warn("file 'index' already exists in the git repository");
         print "error 1 Index already exists in git repo\n";
+        cleanupWorkTree();
         exit;
     }
 
@@ -1209,31 +1226,20 @@ sub req_ci
     my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
     $updater->update();
 
-    my $tmpdir = tempdir ( DIR => $TEMP_DIR );
-    my ( undef, $file_index ) = tempfile ( DIR => $TEMP_DIR, OPEN => 0 );
-    $log->info("Lockless commit start, basing commit on '$tmpdir', index file is '$file_index'");
-
-    $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
-    $ENV{GIT_WORK_TREE} = ".";
-    $ENV{GIT_INDEX_FILE} = $file_index;
-
     # Remember where the head was at the beginning.
     my $parenthash = `git show-ref -s refs/heads/$state->{module}`;
     chomp $parenthash;
     if ($parenthash !~ /^[0-9a-f]{40}$/) {
 	    print "error 1 pserver cannot find the current HEAD of module";
+	    cleanupWorkTree();
 	    exit;
     }
 
-    chdir $tmpdir;
+    setupWorkTree($parenthash);
 
-    # populate the temporary index
-    system("git-read-tree", $parenthash);
-    unless ($? == 0)
-    {
-	die "Error running git-read-tree $state->{module} $file_index $!";
-    }
-    $log->info("Created index '$file_index' for head $state->{module} - exit status $?");
+    $log->info("Lockless commit start, basing commit on '$work->{workDir}', index file is '$work->{index}'");
+
+    $log->info("Created index '$work->{index}' for head $state->{module} - exit status $?");
 
     my @committedfiles = ();
     my %oldmeta;
@@ -1271,7 +1277,7 @@ sub req_ci
         {
             # fail everything if an up to date check fails
             print "error 1 Up to date check failed for $filename\n";
-            chdir "/";
+            cleanupWorkTree();
             exit;
         }
 
@@ -1313,7 +1319,7 @@ sub req_ci
     {
         print "E No files to commit\n";
         print "ok\n";
-        chdir "/";
+        cleanupWorkTree();
         return;
     }
 
@@ -1336,7 +1342,7 @@ sub req_ci
     {
         $log->warn("Commit failed (Invalid commit hash)");
         print "error 1 Commit failed (unknown reason)\n";
-        chdir "/";
+        cleanupWorkTree();
         exit;
     }
 
@@ -1348,7 +1354,7 @@ sub req_ci
 		{
 			$log->warn("Commit failed (update hook declined to update ref)");
 			print "error 1 Commit failed (update hook declined)\n";
-			chdir "/";
+			cleanupWorkTree();
 			exit;
 		}
 	}
@@ -1358,6 +1364,7 @@ sub req_ci
 			"refs/heads/$state->{module}", $commithash, $parenthash)) {
 		$log->warn("update-ref for $state->{module} failed.");
 		print "error 1 Cannot commit -- update first\n";
+		cleanupWorkTree();
 		exit;
 	}
 
@@ -1414,7 +1421,7 @@ sub req_ci
         }
     }
 
-    chdir "/";
+    cleanupWorkTree();
     print "ok\n";
 }
 
@@ -1757,15 +1764,9 @@ sub req_annotate
     argsfromdir($updater);
 
     # we'll need a temporary checkout dir
-    my $tmpdir = tempdir ( DIR => $TEMP_DIR );
-    my ( undef, $file_index ) = tempfile ( DIR => $TEMP_DIR, OPEN => 0 );
-    $log->info("Temp checkoutdir creation successful, basing annotate session work on '$tmpdir', index file is '$file_index'");
-
-    $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
-    $ENV{GIT_WORK_TREE} = ".";
-    $ENV{GIT_INDEX_FILE} = $file_index;
+    setupWorkTree();
 
-    chdir $tmpdir;
+    $log->info("Temp checkoutdir creation successful, basing annotate session work on '$work->{workDir}', index file is '$ENV{GIT_INDEX_FILE}'");
 
     # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
@@ -1789,10 +1790,10 @@ sub req_annotate
 	system("git-read-tree", $lastseenin);
 	unless ($? == 0)
 	{
-	    print "E error running git-read-tree $lastseenin $file_index $!\n";
+	    print "E error running git-read-tree $lastseenin $ENV{GIT_INDEX_FILE} $!\n";
 	    return;
 	}
-	$log->info("Created index '$file_index' with commit $lastseenin - exit status $?");
+	$log->info("Created index '$ENV{GIT_INDEX_FILE}' with commit $lastseenin - exit status $?");
 
         # do a checkout of the file
         system('git-checkout-index', '-f', '-u', $filename);
@@ -1808,7 +1809,7 @@ sub req_annotate
         # git-jsannotate telling us about commits we are hiding
         # from the client.
 
-        my $a_hints = "$tmpdir/.annotate_hints";
+        my $a_hints = "$work->{workDir}/.annotate_hints";
         if (!open(ANNOTATEHINTS, '>', $a_hints)) {
             print "E failed to open '$a_hints' for writing: $!\n";
             return;
@@ -1862,7 +1863,7 @@ sub req_annotate
     }
 
     # done; get out of the tempdir
-    chdir "/";
+    cleanupWorkDir();
 
     print "ok\n";
 
@@ -2115,6 +2116,179 @@ sub filecleanup
     return $filename;
 }
 
+sub validateGitDir
+{
+    if( !defined($state->{CVSROOT}) )
+    {
+        print "error 1 CVSROOT not specified\n";
+        cleanupWorkTree();
+        exit;
+    }
+    if( $ENV{GIT_DIR} ne ($state->{CVSROOT} . '/') )
+    {
+        print "error 1 Internally inconsistent CVSROOT\n";
+        cleanupWorkTree();
+        exit;
+    }
+}
+
+# Setup working directory in a work tree with the requested version
+# loaded in the index.
+sub setupWorkTree
+{
+    my ($ver) = @_;
+
+    validateGitDir();
+
+    if( ( defined($work->{state}) && $work->{state} != 1 ) ||
+        defined($work->{tmpDir}) )
+    {
+        $log->warn("Bad work tree state management");
+        print "error 1 Internal setup multiple work trees without cleanup\n";
+        cleanupWorkTree();
+        exit;
+    }
+
+    $work->{workDir} = tempdir ( DIR => $TEMP_DIR );
+
+    if( !defined($work->{index}) )
+    {
+        (undef, $work->{index}) = tempfile ( DIR => $TEMP_DIR, OPEN => 0 );
+    }
+
+    chdir $work->{workDir} or
+        die "Unable to chdir to $work->{workDir}\n";
+
+    $log->info("Setting up GIT_WORK_TREE as '.' in '$work->{workDir}', index file is '$work->{index}'");
+
+    $ENV{GIT_WORK_TREE} = ".";
+    $ENV{GIT_INDEX_FILE} = $work->{index};
+    $work->{state} = 2;
+
+    if($ver)
+    {
+        system("git","read-tree",$ver);
+        unless ($? == 0)
+        {
+            $log->warn("Error running git-read-tree");
+            die "Error running git-read-tree $ver in $work->{workDir} $!\n";
+        }
+    }
+    # else # req_annotate reads tree for each file
+}
+
+# Ensure current directory is in some kind of working directory,
+# with a recent version loaded in the index.
+sub ensureWorkTree
+{
+    if( defined($work->{tmpDir}) )
+    {
+        $log->warn("Bad work tree state management [ensureWorkTree()]");
+        print "error 1 Internal setup multiple dirs without cleanup\n";
+        cleanupWorkTree();
+        exit;
+    }
+    if( $work->{state} )
+    {
+        return;
+    }
+
+    validateGitDir();
+
+    if( !defined($work->{emptyDir}) )
+    {
+        $work->{emptyDir} = tempdir ( DIR => $TEMP_DIR, OPEN => 0);
+    }
+    chdir $work->{emptyDir} or
+        die "Unable to chdir to $work->{emptyDir}\n";
+
+    my $ver = `git show-ref -s refs/heads/$state->{module}`;
+    chomp $ver;
+    if ($ver !~ /^[0-9a-f]{40}$/)
+    {
+        $log->warn("Error from git show-ref -s refs/head$state->{module}");
+        print "error 1 cannot find the current HEAD of module";
+        cleanupWorkTree();
+        exit;
+    }
+
+    if( !defined($work->{index}) )
+    {
+        (undef, $work->{index}) = tempfile ( DIR => $TEMP_DIR, OPEN => 0 );
+    }
+
+    $ENV{GIT_WORK_TREE} = ".";
+    $ENV{GIT_INDEX_FILE} = $work->{index};
+    $work->{state} = 1;
+
+    system("git","read-tree",$ver);
+    unless ($? == 0)
+    {
+        die "Error running git-read-tree $ver $!\n";
+    }
+}
+
+# Cleanup working directory that is not needed any longer.
+sub cleanupWorkTree
+{
+    if( ! $work->{state} )
+    {
+        return;
+    }
+
+    chdir "/" or die "Unable to chdir '/'\n";
+
+    if( defined($work->{workDir}) )
+    {
+        rmtree( $work->{workDir} );
+        undef $work->{workDir};
+    }
+    undef $work->{state};
+}
+
+# Setup a temporary directory (not a working tree), typically for
+# merging dirty state as in req_update.
+sub setupTmpDir
+{
+    $work->{tmpDir} = tempdir ( DIR => $TEMP_DIR );
+    chdir $work->{tmpDir} or die "Unable to chdir $work->{tmpDir}\n";
+
+    return $work->{tmpDir};
+}
+
+# Clean up a previously setupTmpDir.  Restore previous work tree if
+# appropriate.
+sub cleanupTmpDir
+{
+    if ( !defined($work->{tmpDir}) )
+    {
+        $log->warn("cleanup tmpdir that has not been setup");
+        die "Cleanup tmpDir that has not been setup\n";
+    }
+    if( defined($work->{state}) )
+    {
+        if( $work->{state} == 1 )
+        {
+            chdir $work->{emptyDir} or
+                die "Unable to chdir to $work->{emptyDir}\n";
+        }
+        elsif( $work->{state} == 2 )
+        {
+            chdir $work->{workDir} or
+                die "Unable to chdir to $work->{emptyDir}\n";
+        }
+        else
+        {
+            $log->warn("Inconsistent work dir state");
+            die "Inconsistent work dir state\n";
+        }
+    }
+    else
+    {
+        chdir "/" or die "Unable to chdir '/'\n";
+    }
+}
+
 # Given a path, this function returns a string containing the kopts
 # that should go into that path's Entries line.  For example, a binary
 # file should get -kb.
-- 
1.5.4.3.340.g97b97
