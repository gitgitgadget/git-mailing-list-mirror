From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/9] remove String::ShellQuote dependency.
Date: Wed, 23 Nov 2005 23:48:57 -0800
Message-ID: <20051124074857.GC4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:50:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBqn-00061r-4i
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbVKXHs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbVKXHs6
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:48:58 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58089 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030556AbVKXHs5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:48:57 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 355272DC033; Wed, 23 Nov 2005 23:48:57 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051124074739.GB4789@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12683>

use safe_pipe_capture() or system() over backticks where
shellquoting may have been necessary.
More changes planned, so I'm not touching the parts I'm
planning on replacing entirely.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |   51 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 23 deletions(-)

applies-to: 83307766d30e928179b9aa85a3d7bb906cc08846
80494a7d496ab9f6e0a76a60b1f0b4215fdff442
diff --git a/git-archimport.perl b/git-archimport.perl
index b5f8a2c..b7e2480 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -55,9 +55,8 @@ use warnings;
 use Getopt::Std;
 use File::Spec;
 use File::Temp qw(tempfile tempdir);
-use File::Path qw(mkpath);
+use File::Path qw(mkpath rmtree);
 use File::Basename qw(basename dirname);
-use String::ShellQuote;
 use Time::Local;
 use IO::Socket;
 use IO::Pipe;
@@ -306,7 +305,7 @@ foreach my $ps (@psets) {
     unless ($import) { # skip for import
         if ( -e "$git_dir/refs/heads/$ps->{branch}") {
             # we know about this branch
-            `git checkout    $ps->{branch}`;
+            system('git-checkout',$ps->{branch});
         } else {
             # new branch! we need to verify a few things
             die "Branch on a non-tag!" unless $ps->{type} eq 't';
@@ -315,7 +314,7 @@ foreach my $ps (@psets) {
                 unless $branchpoint;
             
             # find where we are supposed to branch from
-            `git checkout -b $ps->{branch} $branchpoint`;
+            system('git-checkout','-b',$ps->{branch},$branchpoint);
 
             # If we trust Arch with the fact that this is just 
             # a tag, and it does not affect the state of the tree
@@ -344,7 +343,7 @@ foreach my $ps (@psets) {
     #
     my $tree;
     
-    my $commitlog = `tla cat-archive-log -A $ps->{repo} $ps->{id}`; 
+    my $commitlog = safe_pipe_capture($TLA,'cat-archive-log',$ps->{id}); 
     die "Error in cat-archive-log: $!" if $?;
         
     # parselog will git-add/rm files
@@ -422,7 +421,7 @@ foreach my $ps (@psets) {
     #
     my @par;
     if ( -e "$git_dir/refs/heads/$ps->{branch}") {
-        if (open HEAD, "<$git_dir/refs/heads/$ps->{branch}") {
+        if (open HEAD, "<","$git_dir/refs/heads/$ps->{branch}") {
             my $p = <HEAD>;
             close HEAD;
             chomp $p;
@@ -437,7 +436,6 @@ foreach my $ps (@psets) {
     if ($ps->{merges}) {
         push @par, find_parents($ps);
     }
-    my $par = join (' ', @par);
 
     #    
     # Commit, tag and clean state
@@ -454,7 +452,7 @@ foreach my $ps (@psets) {
     $commit_rh = 'commit_rh';
     $commit_wh = 'commit_wh';
     
-    $pid = open2(*READER, *WRITER, "git-commit-tree $tree $par") 
+    $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par) 
         or die $!;
     print WRITER $logmessage;   # write
     close WRITER;
@@ -469,7 +467,7 @@ foreach my $ps (@psets) {
     #
     # Update the branch
     # 
-    open  HEAD, ">$git_dir/refs/heads/$ps->{branch}";
+    open  HEAD, ">","$git_dir/refs/heads/$ps->{branch}";
     print HEAD $commitid;
     close HEAD;
     system('git-update-ref', 'HEAD', "$ps->{branch}");
@@ -483,21 +481,23 @@ foreach my $ps (@psets) {
     print "   + tree   $tree\n";
     print "   + commit $commitid\n";
     $opt_v && print "   + commit date is  $ps->{date} \n";
-    $opt_v && print "   + parents:  $par \n";
+    $opt_v && print "   + parents:  ",join(' ',@par),"\n";
 }
 
 sub apply_import {
     my $ps = shift;
     my $bname = git_branchname($ps->{id});
 
-    `mkdir -p $tmp`;
+    mkpath($tmp);
 
-    `tla get -s --no-pristine -A $ps->{repo} $ps->{id} $tmp/import`;
+    safe_pipe_capture($TLA,'get','-s','--no-pristine',$ps->{id},"$tmp/import");
     die "Cannot get import: $!" if $?;    
-    `rsync -v --archive --delete --exclude '$git_dir' --exclude '.arch-ids' --exclude '{arch}' $tmp/import/* ./`;
+    system('rsync','-aI','--delete', '--exclude',$git_dir,
+		'--exclude','.arch-ids','--exclude','{arch}',
+		"$tmp/import/", './');
     die "Cannot rsync import:$!" if $?;
     
-    `rm -fr $tmp/import`;
+    rmtree("$tmp/import");
     die "Cannot remove tempdir: $!" if $?;
     
 
@@ -507,10 +507,10 @@ sub apply_import {
 sub apply_cset {
     my $ps = shift;
 
-    `mkdir -p $tmp`;
+    mkpath($tmp);
 
     # get the changeset
-    `tla get-changeset  -A $ps->{repo} $ps->{id} $tmp/changeset`;
+    safe_pipe_capture($TLA,'get-changeset',$ps->{id},"$tmp/changeset");
     die "Cannot get changeset: $!" if $?;
     
     # apply patches
@@ -534,17 +534,20 @@ sub apply_cset {
             $orig =~ s/\.modified$//; # lazy
             $orig =~ s!^\Q$tmp\E/changeset/patches/!!;
             #print "rsync -p '$mod' '$orig'";
-            `rsync -p $mod ./$orig`;
+            system('rsync','-p',$mod,"./$orig");
             die "Problem applying binary changes! $!" if $?;
         }
     }
 
     # bring in new files
-    `rsync --archive --exclude '$git_dir' --exclude '.arch-ids' --exclude '{arch}' $tmp/changeset/new-files-archive/* ./`;
+    system('rsync','-aI','--exclude',$git_dir,
+    		'--exclude','.arch-ids',
+		'--exclude', '{arch}',
+		"$tmp/changeset/new-files-archive/",'./');
 
     # deleted files are hinted from the commitlog processing
 
-    `rm -fr $tmp/changeset`;
+    rmtree("$tmp/changeset");
 }
 
 
@@ -622,9 +625,9 @@ sub parselog {
            # tla cat-archive-log will give us filenames with spaces as file\(sp)name - why?
            # we can assume that any filename with \ indicates some pika escaping that we want to get rid of.
            if  ($t =~ /\\/ ){
-               $t = `tla escape --unescaped '$t'`;
+               $t = (safe_pipe_capture($TLA,'escape','--unescaped',$t))[0];
            }
-            push (@tmp, shell_quote($t));
+            push (@tmp, $t);
         }
         @$ref = @tmp;
     }
@@ -827,8 +830,10 @@ sub find_parents {
 	    }
 	}
     }
-    @parents = keys %parents;
-    @parents = map { " -p " . ptag($_) } @parents;
+    @parents = ();
+    foreach (keys %parents) {
+        push @parents, '-p', ptag($_);
+    }
     return @parents;
 }
 
---
0.99.9.GIT
