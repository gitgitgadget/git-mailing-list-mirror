From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-cvsserver: no longer use deprecated 'git-subcommand' commands
Date: Wed, 2 Sep 2009 09:23:10 +0000
Message-ID: <20090902092310.23525.qmail@2a30b353bc6194.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 11:31:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MimBl-0005ij-1K
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 11:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbZIBJac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 05:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbZIBJab
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 05:30:31 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:3948 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750971AbZIBJaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 05:30:30 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Sep 2009 05:30:30 EDT
Received: (qmail 23526 invoked by uid 1000); 2 Sep 2009 09:23:10 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127600>

git-cvsserver still references git commands like 'git-config', which
is depcrecated.  This commit changes git-cvsserver to use the
'git subcommand' form.

Sylvain Beucler reported the problem through
 http://bugs.debian.org/536067

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-cvsserver.perl |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ab6cea3..6dc45f5 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -285,7 +285,7 @@ sub req_Root
        return 0;
     }
 
-    my @gitvars = `git-config -l`;
+    my @gitvars = `git config -l`;
     if ($?) {
        print "E problems executing git-config on the server -- this is not a git repository or the PATH is not set correctly.\n";
         print "E \n";
@@ -702,7 +702,7 @@ sub req_Modified
     # Save the file data in $state
     $state->{entries}{$state->{directory}.$data}{modified_filename} = $filename;
     $state->{entries}{$state->{directory}.$data}{modified_mode} = $mode;
-    $state->{entries}{$state->{directory}.$data}{modified_hash} = `git-hash-object $filename`;
+    $state->{entries}{$state->{directory}.$data}{modified_hash} = `git hash-object $filename`;
     $state->{entries}{$state->{directory}.$data}{modified_hash} =~ s/\s.*$//s;
 
     #$log->debug("req_Modified : file=$data mode=$mode size=$size");
@@ -1289,7 +1289,7 @@ sub req_ci
 
 	# do a checkout of the file if it is part of this tree
         if ($wrev) {
-            system('git-checkout-index', '-f', '-u', $filename);
+            system('git', 'checkout-index', '-f', '-u', $filename);
             unless ($? == 0) {
                 die "Error running git-checkout-index -f -u $filename : $!";
             }
@@ -1331,15 +1331,15 @@ sub req_ci
         {
             $log->info("Removing file '$filename'");
             unlink($filename);
-            system("git-update-index", "--remove", $filename);
+            system("git", "update-index", "--remove", $filename);
         }
         elsif ( $addflag )
         {
             $log->info("Adding file '$filename'");
-            system("git-update-index", "--add", $filename);
+            system("git", "update-index", "--add", $filename);
         } else {
             $log->info("Updating file '$filename'");
-            system("git-update-index", $filename);
+            system("git", "update-index", $filename);
         }
     }
 
@@ -1351,7 +1351,7 @@ sub req_ci
         return;
     }
 
-    my $treehash = `git-write-tree`;
+    my $treehash = `git write-tree`;
     chomp $treehash;
 
     $log->debug("Treehash : $treehash, Parenthash : $parenthash");
@@ -1368,7 +1368,7 @@ sub req_ci
     }
     close $msg_fh;
 
-    my $commithash = `git-commit-tree $treehash -p $parenthash < $msg_filename`;
+    my $commithash = `git commit-tree $treehash -p $parenthash < $msg_filename`;
     chomp($commithash);
     $log->info("Commit hash : $commithash");
 
@@ -1821,7 +1821,7 @@ sub req_annotate
 	# TODO: if we got a revision from the client, use that instead
 	# to look up the commithash in sqlite (still good to default to
 	# the current head as we do now)
-	system("git-read-tree", $lastseenin);
+	system("git", "read-tree", $lastseenin);
 	unless ($? == 0)
 	{
 	    print "E error running git-read-tree $lastseenin $ENV{GIT_INDEX_FILE} $!\n";
@@ -1830,7 +1830,7 @@ sub req_annotate
 	$log->info("Created index '$ENV{GIT_INDEX_FILE}' with commit $lastseenin - exit status $?");
 
         # do a checkout of the file
-        system('git-checkout-index', '-f', '-u', $filename);
+        system('git', 'checkout-index', '-f', '-u', $filename);
         unless ($? == 0) {
             print "E error running git-checkout-index -f -u $filename : $!\n";
             return;
@@ -1861,7 +1861,7 @@ sub req_annotate
         close ANNOTATEHINTS
             or (print "E failed to write $a_hints: $!\n"), return;
 
-        my @cmd = (qw(git-annotate -l -S), $a_hints, $filename);
+        my @cmd = (qw(git annotate -l -S), $a_hints, $filename);
         if (!open(ANNOTATE, "-|", @cmd)) {
             print "E error invoking ". join(' ',@cmd) .": $!\n";
             return;
@@ -2078,17 +2078,17 @@ sub transmitfile
 
     die "Need filehash" unless ( defined ( $filehash ) and $filehash =~ /^[a-zA-Z0-9]{40}$/ );
 
-    my $type = `git-cat-file -t $filehash`;
+    my $type = `git cat-file -t $filehash`;
     chomp $type;
 
     die ( "Invalid type '$type' (expected 'blob')" ) unless ( defined ( $type ) and $type eq "blob" );
 
-    my $size = `git-cat-file -s $filehash`;
+    my $size = `git cat-file -s $filehash`;
     chomp $size;
 
     $log->debug("transmitfile($filehash) size=$size, type=$type");
 
-    if ( open my $fh, '-|', "git-cat-file", "blob", $filehash )
+    if ( open my $fh, '-|', "git", "cat-file", "blob", $filehash )
     {
         if ( defined ( $options->{targetfile} ) )
         {
@@ -2935,7 +2935,7 @@ sub update
         push @git_log_params, $self->{module};
     }
     # git-rev-list is the backend / plumbing version of git-log
-    open(GITLOG, '-|', 'git-rev-list', @git_log_params) or die "Cannot call git-rev-list: $!";
+    open(GITLOG, '-|', 'git', 'rev-list', @git_log_params) or die "Cannot call git-rev-list: $!";
 
     my @commits;
 
@@ -3021,7 +3021,7 @@ sub update
                         next;
                     }
 		    my $base = eval {
-			    safe_pipe_capture('git-merge-base',
+			    safe_pipe_capture('git', 'merge-base',
 						 $lastpicked, $parent);
 		    };
 		    # The two branches may not be related at all,
@@ -3033,7 +3033,7 @@ sub update
                     if ($base) {
                         my @merged;
                         # print "want to log between  $base $parent \n";
-                        open(GITLOG, '-|', 'git-log', '--pretty=medium', "$base..$parent")
+                        open(GITLOG, '-|', 'git', 'log', '--pretty=medium', "$base..$parent")
 			  or die "Cannot call git-log: $!";
                         my $mergedhash;
                         while (<GITLOG>) {
@@ -3075,7 +3075,7 @@ sub update
 
         if ( defined ( $lastpicked ) )
         {
-            my $filepipe = open(FILELIST, '-|', 'git-diff-tree', '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git', 'diff-tree', '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
 	    local ($/) = "\0";
             while ( <FILELIST> )
             {
@@ -3149,7 +3149,7 @@ sub update
             # this is used to detect files removed from the repo
             my $seen_files = {};
 
-            my $filepipe = open(FILELIST, '-|', 'git-ls-tree', '-z', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git', 'ls-tree', '-z', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
 	    local $/ = "\0";
             while ( <FILELIST> )
             {
@@ -3451,7 +3451,7 @@ sub commitmessage
         return $message;
     }
 
-    my @lines = safe_pipe_capture("git-cat-file", "commit", $commithash);
+    my @lines = safe_pipe_capture("git", "cat-file", "commit", $commithash);
     shift @lines while ( $lines[0] =~ /\S/ );
     $message = join("",@lines);
     $message .= " " if ( $message =~ /\n$/ );
-- 
1.6.0.3
