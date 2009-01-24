From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 05/10] cvsserver: run dashless "git command"s to access plumbing
Date: Sat, 24 Jan 2009 16:43:16 -0700
Message-ID: <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBa-0006Ei-7N
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbZAXXnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713AbZAXXni
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:38 -0500
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:49297 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752065AbZAXXnc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:32 -0500
Received: from OMTA03.emeryville.ca.mail.comcast.net ([76.96.30.27])
	by QMTA05.emeryville.ca.mail.comcast.net with comcast
	id 7UZr1b00L0b6N64A5bjYvj; Sat, 24 Jan 2009 23:43:32 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA03.emeryville.ca.mail.comcast.net with comcast
	id 7bjW1b00M1TYyYj8PbjXT5; Sat, 24 Jan 2009 23:43:31 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id E0AEC89119;
	Sat, 24 Jan 2009 16:43:24 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107021>

git-cvsserver has been installed in the default $(bindir)
since 1df2a1ce806, but if you actually invoke it that way
(CVS_SERVER=git-cvsserver), it was failing because most of the
dashed-form plumbing commands cvsserver invokes are not in the PATH.

It seems best not to just switch to pure CVS_SERVER="git cvsserver",
which does not work with cvs's ":fork:" connection scheme.  In
this case "cvs" presumably uses the whole value as argv[0] for
exec(), and of course no execuable named "git cvsserver" exists.

But both settings worked under some circumstances:

CVS_SERVER="git cvsserver" works OK for cvs's ":ext:" scheme (at
least with ssh), presumably because of how sshd invokes
/bin/sh -c "{args}" with limited quoting, and "git"
would set up the PATH so that cvsserver could run dashed commands
correctly.

Also, CVS_SERVER="git-cvsserver" has been working OK under git's test
framework, because the test framework currently always sets up a PATH
that includes the dashed forms.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

Note: I only changed the actual command invocations; I left error
messages and comments as-is.  Should they be changed as well?

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

 git-cvsserver.perl |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index fe23b49..8e9e659 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -283,7 +283,7 @@ sub req_Root
        return 0;
     }
 
-    my @gitvars = `git-config -l`;
+    my @gitvars = `git config -l`;
     if ($?) {
        print "E problems executing git-config on the server -- this is not a git repository or the PATH is not set correctly.\n";
         print "E \n";
@@ -700,7 +700,7 @@ sub req_Modified
     # Save the file data in $state
     $state->{entries}{$state->{directory}.$data}{modified_filename} = $filename;
     $state->{entries}{$state->{directory}.$data}{modified_mode} = $mode;
-    $state->{entries}{$state->{directory}.$data}{modified_hash} = `git-hash-object $filename`;
+    $state->{entries}{$state->{directory}.$data}{modified_hash} = `git hash-object $filename`;
     $state->{entries}{$state->{directory}.$data}{modified_hash} =~ s/\s.*$//s;
 
     #$log->debug("req_Modified : file=$data mode=$mode size=$size");
@@ -1287,7 +1287,7 @@ sub req_ci
 
 	# do a checkout of the file if it is part of this tree
         if ($wrev) {
-            system('git-checkout-index', '-f', '-u', $filename);
+            system('git', 'checkout-index', '-f', '-u', $filename);
             unless ($? == 0) {
                 die "Error running git-checkout-index -f -u $filename : $!";
             }
@@ -1329,15 +1329,15 @@ sub req_ci
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
 
@@ -1349,7 +1349,7 @@ sub req_ci
         return;
     }
 
-    my $treehash = `git-write-tree`;
+    my $treehash = `git write-tree`;
     chomp $treehash;
 
     $log->debug("Treehash : $treehash, Parenthash : $parenthash");
@@ -1366,7 +1366,7 @@ sub req_ci
     }
     close $msg_fh;
 
-    my $commithash = `git-commit-tree $treehash -p $parenthash < $msg_filename`;
+    my $commithash = `git commit-tree $treehash -p $parenthash < $msg_filename`;
     chomp($commithash);
     $log->info("Commit hash : $commithash");
 
@@ -1819,7 +1819,7 @@ sub req_annotate
 	# TODO: if we got a revision from the client, use that instead
 	# to look up the commithash in sqlite (still good to default to
 	# the current head as we do now)
-	system("git-read-tree", $lastseenin);
+	system("git", "read-tree", $lastseenin);
 	unless ($? == 0)
 	{
 	    print "E error running git-read-tree $lastseenin $ENV{GIT_INDEX_FILE} $!\n";
@@ -1828,7 +1828,7 @@ sub req_annotate
 	$log->info("Created index '$ENV{GIT_INDEX_FILE}' with commit $lastseenin - exit status $?");
 
         # do a checkout of the file
-        system('git-checkout-index', '-f', '-u', $filename);
+        system('git', 'checkout-index', '-f', '-u', $filename);
         unless ($? == 0) {
             print "E error running git-checkout-index -f -u $filename : $!\n";
             return;
@@ -1859,7 +1859,7 @@ sub req_annotate
         close ANNOTATEHINTS
             or (print "E failed to write $a_hints: $!\n"), return;
 
-        my @cmd = (qw(git-annotate -l -S), $a_hints, $filename);
+        my @cmd = (qw(git annotate -l -S), $a_hints, $filename);
         if (!open(ANNOTATE, "-|", @cmd)) {
             print "E error invoking ". join(' ',@cmd) .": $!\n";
             return;
@@ -2080,17 +2080,17 @@ sub transmitfile
 
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
@@ -2942,7 +2942,7 @@ sub update
         push @git_log_params, $self->{module};
     }
     # git-rev-list is the backend / plumbing version of git-log
-    open(GITLOG, '-|', 'git-rev-list', @git_log_params) or die "Cannot call git-rev-list: $!";
+    open(GITLOG, '-|', 'git', 'rev-list', @git_log_params) or die "Cannot call git-rev-list: $!";
 
     my @commits;
 
@@ -3029,7 +3029,7 @@ sub update
                     # several candidate merge bases. let's assume
                     # that the first one is the best one.
 		    my $base = eval {
-			    safe_pipe_capture('git-merge-base',
+			    safe_pipe_capture('git', 'merge-base',
 						 $lastpicked, $parent);
 		    };
 		    # The two branches may not be related at all,
@@ -3041,7 +3041,7 @@ sub update
                     if ($base) {
                         my @merged;
                         # print "want to log between  $base $parent \n";
-                        open(GITLOG, '-|', 'git-log', '--pretty=medium', "$base..$parent")
+                        open(GITLOG, '-|', 'git', 'log', '--pretty=medium', "$base..$parent")
 			  or die "Cannot call git-log: $!";
                         my $mergedhash;
                         while (<GITLOG>) {
@@ -3083,7 +3083,7 @@ sub update
 
         if ( defined ( $lastpicked ) )
         {
-            my $filepipe = open(FILELIST, '-|', 'git-diff-tree', '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git', 'diff-tree', '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
 	    local ($/) = "\0";
             while ( <FILELIST> )
             {
@@ -3157,7 +3157,7 @@ sub update
             # this is used to detect files removed from the repo
             my $seen_files = {};
 
-            my $filepipe = open(FILELIST, '-|', 'git-ls-tree', '-z', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git', 'ls-tree', '-z', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
 	    local $/ = "\0";
             while ( <FILELIST> )
             {
@@ -3448,7 +3448,7 @@ sub commitmessage
         return $message;
     }
 
-    my @lines = safe_pipe_capture("git-cat-file", "commit", $commithash);
+    my @lines = safe_pipe_capture("git", "cat-file", "commit", $commithash);
     shift @lines while ( $lines[0] =~ /\S/ );
     $message = join("",@lines);
     $message .= " " if ( $message =~ /\n$/ );
-- 
1.6.1.81.g9833d.dirty
