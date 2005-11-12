From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/5] Overhaul of changeset application
Date: Sat, 12 Nov 2005 01:30:46 -0800
Message-ID: <20051112093045.GE16218@Muzzle>
References: <20051112092336.GA16218@Muzzle> <20051112092533.GB16218@Muzzle> <20051112092721.GC16218@Muzzle> <20051112092920.GD16218@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 10:31:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Earil-0006kU-LT
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 10:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVKLJat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 04:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVKLJat
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 04:30:49 -0500
Received: from hand.yhbt.net ([66.150.188.102]:41101 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932269AbVKLJas (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 04:30:48 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id DC59E2DC03B;
	Sat, 12 Nov 2005 01:30:46 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sat, 12 Nov 2005 01:30:46 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051112092920.GD16218@Muzzle>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11666>

Overhaul of changeset application to use native Arch tree operations.
This results in:
 - reliable rename handling (esp. when dealing with renamed with files
   that already got renamed)
 - permissions tracking (execute only for git).
 - no need to shell-escape or pika-unescape anything.  All arguments to
   external programs are always passed as an array.  File modifications
   are automatically tracked using git (no need to parse Arch patch-log
   to look for modified files).
 - Correctly parse multi-line summary text in patch-logs

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |  381 ++++++++++++++++++++-------------------------------
 1 files changed, 146 insertions(+), 235 deletions(-)

applies-to: 12cd9f2d764e50ae4fe2c6cd8b64fc72c668e0dd
d3cbba7b8e8e3db61dac685ab55055d360e6138d
diff --git a/git-archimport.perl b/git-archimport.perl
index f2bcbb4..5616d42 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -55,7 +55,7 @@ use warnings;
 use Getopt::Std;
 use File::Spec;
 use File::Temp qw(tempfile tempdir);
-use File::Path qw(mkpath);
+use File::Path qw(mkpath rmtree);
 use File::Basename qw(basename dirname);
 use String::ShellQuote;
 use Time::Local;
@@ -90,16 +90,17 @@ usage if $opt_h;
 @ARGV >= 1 or usage();
 my @arch_roots = @ARGV;
 
-my ($tmpdir, $tmpdirname) = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
-my $tmp = $opt_t || 1;
-$tmp = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
-$opt_v && print "+ Using $tmp as temporary directory\n";
+my $tmptree;
+$ENV{'TMPDIR'} = $opt_t if $opt_t;
+$tmptree = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
+$opt_v && print "+ Using $tmptree to store temporary trees\n";
 
 my @psets  = ();                # the collection
 my %psets  = ();                # the collection, by name
 
 my %rptags = ();                # my reverse private tags
                                 # to map a SHA1 to a commitid
+my $TLA = $ENV{'ARCH_CLIENT'} || 'tla';
 
 foreach my $root (@arch_roots) {
     my ($arepo, $abranch) = split(m!/!, $root);
@@ -211,7 +212,7 @@ unless (-d $git_dir) { # initial import
     }
 } else {    # progressing an import
     # load the rptags
-    opendir(DIR, "$git_dir/archimport/tags")
+    opendir(DIR, $ptag_dir)
 	|| die "can't opendir: $!";
     while (my $file = readdir(DIR)) {
         # skip non-interesting-files
@@ -288,26 +289,37 @@ foreach my $ps (@psets) {
 
     print " * Starting to work on $ps->{id}\n";
 
-    # 
-    # create the branch if needed
-    #
-    if ($ps->{type} eq 'i' && !$import) {
-        die "Should not have more than one 'Initial import' per GIT import: $ps->{id}";
+    # switch to that branch if we're not already in that branch:
+    if (-e "$git_dir/refs/heads/$ps->{branch}") {
+       system('git-checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
+
+       # remove any old stuff that got leftover:
+       chomp(my @rm = safe_pipe_capture('git-ls-files','--others'));
+       rmtree(\@rm) if @rm;
     }
-
-    unless ($import) { # skip for import
-        if ( -e "$git_dir/refs/heads/$ps->{branch}") {
-            # we know about this branch
-            `git checkout    $ps->{branch}`;
-        } else {
-            # new branch! we need to verify a few things
-            die "Branch on a non-tag!" unless $ps->{type} eq 't';
-            my $branchpoint = ptag($ps->{tag});
-            die "Tagging from unknown id unsupported: $ps->{tag}" 
-                unless $branchpoint;
+   
+    # Apply the import/changeset/merge into the working tree
+    my $dir = sync_to_ps($ps);
+    # read the new log entry:
+    my @commitlog = safe_pipe_capture($TLA,'cat-log','-d',$dir,$ps->{id});
+    die "Error in cat-log: $!" if $?;
+    chomp @commitlog;
+
+    # grab variables we want from the log, new fields get added to $ps:
+    # (author, date, email, summary, message body ...)
+    parselog($ps, \@commitlog);
+
+    if ($ps->{id} =~ /--base-0$/ && $ps->{id} ne $psets[0]{id}) {
+        # this should work when importing continuations 
+        if ($ps->{tag} && (my $branchpoint = eval { ptag($ps->{tag}) })) {
             
             # find where we are supposed to branch from
-            `git checkout -b $ps->{branch} $branchpoint`;
+            system('git-checkout','-f','-b',$ps->{branch},
+                            $branchpoint) == 0 or die "$! $?\n";
+            
+            # remove any old stuff that got leftover:
+            chomp(my @rm = safe_pipe_capture('git-ls-files','--others'));
+            rmtree(\@rm) if @rm;
 
             # If we trust Arch with the fact that this is just 
             # a tag, and it does not affect the state of the tree
@@ -316,95 +328,26 @@ foreach my $ps (@psets) {
             ptag($ps->{id}, $branchpoint);
             print " * Tagged $ps->{id} at $branchpoint\n";
             next;
-        } 
-        die $! if $?;
+        } else {
+            warn "Tagging from unknown id unsupported\n" if $ps->{tag};
+        }
+        # allow multiple bases/imports here since Arch supports cherry-picks
+        # from unrelated trees
     } 
-
-    #
-    # Apply the import/changeset/merge into the working tree
-    # 
-    if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
-        apply_import($ps) or die $!;
-        $import=0;
-    } elsif ($ps->{type} eq 's') {
-        apply_cset($ps);
-    }
-
-    #
-    # prepare update git's index, based on what arch knows
-    # about the pset, resolve parents, etc
-    #
-    my $tree;
     
-    my $commitlog = `tla cat-archive-log -A $ps->{repo} $ps->{id}`; 
-    die "Error in cat-archive-log: $!" if $?;
-        
-    # parselog will git-add/rm files
-    # and generally prepare things for the commit
-    # NOTE: parselog will shell-quote filenames! 
-    my ($sum, $msg, $add, $del, $mod, $ren) = parselog($commitlog);
-    my $logmessage = "$sum\n$msg";
-
-
-    # imports don't give us good info
-    # on added files. Shame on them
-    if ($ps->{type} eq 'i' || $ps->{type} eq 't') { 
-        `find . -type f -print0 | grep -zv '^./$git_dir' | xargs -0 -l100 git-update-index --add`;
-        `git-ls-files --deleted -z | xargs --no-run-if-empty -0 -l100 git-update-index --remove`;
-    }
-
-    if (@$add) {
-        while (@$add) {
-            my @slice = splice(@$add, 0, 100);
-            my $slice = join(' ', @slice);          
-            `git-update-index --add $slice`;
-            die "Error in git-update-index --add: $!" if $?;
-        }
-    }
-    if (@$del) {
-        foreach my $file (@$del) {
-            unlink $file or die "Problems deleting $file : $!";
-        }
-        while (@$del) {
-            my @slice = splice(@$del, 0, 100);
-            my $slice = join(' ', @slice);
-            `git-update-index --remove $slice`;
-            die "Error in git-update-index --remove: $!" if $?;
-        }
-    }
-    if (@$ren) {                # renamed
-        if (@$ren % 2) {
-            die "Odd number of entries in rename!?";
-        }
-        ;
-        while (@$ren) {
-            my $from = pop @$ren;
-            my $to   = pop @$ren;           
-
-            unless (-d dirname($to)) {
-                mkpath(dirname($to)); # will die on err
-            }
-            #print "moving $from $to";
-            `mv $from $to`;
-            die "Error renaming $from $to : $!" if $?;
-            `git-update-index --remove $from`;
-            die "Error in git-update-index --remove: $!" if $?;
-            `git-update-index --add $to`;
-            die "Error in git-update-index --add: $!" if $?;
-        }
-
-    }
-    if (@$mod) {                # must be _after_ renames
-        while (@$mod) {
-            my @slice = splice(@$mod, 0, 100);
-            my $slice = join(' ', @slice);
-            `git-update-index $slice`;
-            die "Error in git-update-index: $!" if $?;
-        }
-    }
-
-    # warn "errors when running git-update-index! $!";
-    $tree = `git-write-tree`;
+    # update the index with all the changes we got
+    system('git-ls-files --others -z | '.
+            'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
+    system('git-ls-files --deleted -z | '.
+            'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
+
+    # just brute force this and update everything, it's faster than
+    # parsing the Modified-files header and then having to pika-unescape
+    # each one in case it has weird characters
+    system('git-ls-files -z | '.
+             'git-update-index -z --stdin') == 0 or die "$! $?\n";
+    
+    my $tree = `git-write-tree`;
     die "cannot write tree $!" if $?;
     chomp $tree;
         
@@ -414,7 +357,7 @@ foreach my $ps (@psets) {
     #
     my @par;
     if ( -e "$git_dir/refs/heads/$ps->{branch}") {
-        if (open HEAD, "<$git_dir/refs/heads/$ps->{branch}") {
+        if (open HEAD, "<","$git_dir/refs/heads/$ps->{branch}") {
             my $p = <HEAD>;
             close HEAD;
             chomp $p;
@@ -429,7 +372,6 @@ foreach my $ps (@psets) {
     if ($ps->{merges}) {
         push @par, find_parents($ps);
     }
-    my $par = join (' ', @par);
 
     #    
     # Commit, tag and clean state
@@ -442,13 +384,14 @@ foreach my $ps (@psets) {
     $ENV{GIT_COMMITTER_EMAIL} = $ps->{email};
     $ENV{GIT_COMMITTER_DATE}  = $ps->{date};
 
-    my ($pid, $commit_rh, $commit_wh);
-    $commit_rh = 'commit_rh';
-    $commit_wh = 'commit_wh';
-    
-    $pid = open2(*READER, *WRITER, "git-commit-tree $tree $par") 
+    my $pid = open2(*READER, *WRITER, 'git-commit-tree',$tree,@par) 
         or die $!;
-    print WRITER $logmessage;   # write
+    print WRITER $ps->{summary},"\n";
+    print WRITER $ps->{message},"\n";
+
+    # make it easy to backtrack and figure out which Arch revision this was:
+    print WRITER 'git-archimport-id: ',$ps->{id},"\n";
+    
     close WRITER;
     my $commitid = <READER>;    # read
     chomp $commitid;
@@ -461,7 +404,7 @@ foreach my $ps (@psets) {
     #
     # Update the branch
     # 
-    open  HEAD, ">$git_dir/refs/heads/$ps->{branch}";
+    open  HEAD, ">","$git_dir/refs/heads/$ps->{branch}";
     print HEAD $commitid;
     close HEAD;
     unlink ("$git_dir/HEAD");
@@ -476,71 +419,41 @@ foreach my $ps (@psets) {
     print "   + tree   $tree\n";
     print "   + commit $commitid\n";
     $opt_v && print "   + commit date is  $ps->{date} \n";
-    $opt_v && print "   + parents:  $par \n";
+    $opt_v && print "   + parents: ".join(' ',@par)."\n";
 }
 
-sub apply_import {
+sub sync_to_ps {
     my $ps = shift;
-    my $bname = git_branchname($ps->{id});
+    my $tree_dir = $tmptree.'/'.tree_dirname($ps->{id});
 
-    `mkdir -p $tmp`;
-
-    `tla get -s --no-pristine -A $ps->{repo} $ps->{id} $tmp/import`;
-    die "Cannot get import: $!" if $?;    
-    `rsync -v --archive --delete --exclude '$git_dir' --exclude '.arch-ids' --exclude '{arch}' $tmp/import/* ./`;
-    die "Cannot rsync import:$!" if $?;
-    
-    `rm -fr $tmp/import`;
-    die "Cannot remove tempdir: $!" if $?;
-    
-
-    return 1;
-}
-
-sub apply_cset {
-    my $ps = shift;
-
-    `mkdir -p $tmp`;
-
-    # get the changeset
-    `tla get-changeset  -A $ps->{repo} $ps->{id} $tmp/changeset`;
-    die "Cannot get changeset: $!" if $?;
-    
-    # apply patches
-    if (`find $tmp/changeset/patches -type f -name '*.patch'`) {
-        # this can be sped up considerably by doing
-        #    (find | xargs cat) | patch
-        # but that cna get mucked up by patches
-        # with missing trailing newlines or the standard 
-        # 'missing newline' flag in the patch - possibly
-        # produced with an old/buggy diff.
-        # slow and safe, we invoke patch once per patchfile
-        `find $tmp/changeset/patches -type f -name '*.patch' -print0 | grep -zv '{arch}' | xargs -iFILE -0 --no-run-if-empty patch -p1 --forward -iFILE`;
-        die "Problem applying patches! $!" if $?;
-    }
-
-    # apply changed binary files
-    if (my @modified = `find $tmp/changeset/patches -type f -name '*.modified'`) {
-        foreach my $mod (@modified) {
-            chomp $mod;
-            my $orig = $mod;
-            $orig =~ s/\.modified$//; # lazy
-            $orig =~ s!^\Q$tmp\E/changeset/patches/!!;
-            #print "rsync -p '$mod' '$orig'";
-            `rsync -p $mod ./$orig`;
-            die "Problem applying binary changes! $!" if $?;
+    if (-d $tree_dir) {
+        if ($ps->{type} eq 't' && defined $ps->{tag}) {
+            # looks like a tag-only or (worse,) a mixed tags/changeset branch,
+            # can't rely on replay to work correctly on these
+            rmtree($tree_dir);
+            safe_pipe_capture($TLA,'get','--no-pristine',$ps->{id},$tree_dir);
+        } else {
+                my $tree_id = arch_tree_id($tree_dir);
+                if ($ps->{parent_id} eq $tree_id) {
+                    safe_pipe_capture($TLA,'replay','-d',$tree_dir,$ps->{id});
+                } else {
+                    safe_pipe_capture($TLA,'apply-delta','-d',$tree_dir,
+                                                        $tree_id, $ps->{id});
+                }
         }
+    } else {
+        safe_pipe_capture($TLA,'get','--no-pristine',$ps->{id},$tree_dir);
     }
-
-    # bring in new files
-    `rsync --archive --exclude '$git_dir' --exclude '.arch-ids' --exclude '{arch}' $tmp/changeset/new-files-archive/* ./`;
-
-    # deleted files are hinted from the commitlog processing
-
-    `rm -fr $tmp/changeset`;
+   
+    # added -I flag to rsync since we're going to fast! AIEEEEE!!!!
+    system('rsync','-aI','--delete','--exclude',$git_dir,
+#               '--exclude','.arch-inventory',
+                '--exclude','.arch-ids','--exclude','{arch}',
+                '--exclude','+*','--exclude',',*',
+                "$tree_dir/",'./') == 0 or die "Cannot rsync $tree_dir: $! $?";
+    return $tree_dir;
 }
 
-
 # =for reference
 # A log entry looks like 
 # Revision: moodle-org--moodle--1.3.3--patch-15
@@ -560,70 +473,42 @@ sub apply_cset {
 #     admin/editor.html backup/lib.php backup/restore.php
 # New-patches: arch-eduforge@catalyst.net.nz--2004/moodle-org--moodle--1.3.3--patch-15
 # Summary: Updating to latest from MOODLE_14_STABLE (1.4.5+)
+#   summary can be multiline with a leading space just like the above fields
 # Keywords:
 #
 # Updating yadda tadda tadda madda
 sub parselog {
-    my $log = shift;
-    #print $log;
-
-    my (@add, @del, @mod, @ren, @kw, $sum, $msg );
-
-    if ($log =~ m/(?:\n|^)New-files:(.*?)(?=\n\w)/s ) {
-        my $files = $1;
-        @add = split(m/\s+/s, $files);
-    }
-       
-    if ($log =~ m/(?:\n|^)Removed-files:(.*?)(?=\n\w)/s ) {
-        my $files = $1;
-        @del = split(m/\s+/s, $files);
-    }
-    
-    if ($log =~ m/(?:\n|^)Modified-files:(.*?)(?=\n\w)/s ) {
-        my $files = $1;
-        @mod = split(m/\s+/s, $files);
-    }
-    
-    if ($log =~ m/(?:\n|^)Renamed-files:(.*?)(?=\n\w)/s ) {
-        my $files = $1;
-        @ren = split(m/\s+/s, $files);
-    }
-
-    $sum ='';
-    if ($log =~ m/^Summary:(.+?)$/m ) {
-        $sum = $1;
-        $sum =~ s/^\s+//;
-        $sum =~ s/\s+$//;
-    }
-
-    $msg = '';
-    if ($log =~ m/\n\n(.+)$/s) {
-        $msg = $1;
-        $msg =~ s/^\s+//;
-        $msg =~ s/\s+$//;
-    }
-
-
-    # cleanup the arrays
-    foreach my $ref ( (\@add, \@del, \@mod, \@ren) ) {
-        my @tmp = ();
-        while (my $t = pop @$ref) {
-            next unless length ($t);
-            next if $t =~ m!\{arch\}/!;
-            next if $t =~ m!\.arch-ids/!;
-            next if $t =~ m!\.arch-inventory$!;
-           # tla cat-archive-log will give us filenames with spaces as file\(sp)name - why?
-           # we can assume that any filename with \ indicates some pika escaping that we want to get rid of.
-           if  ($t =~ /\\/ ){
-               $t = `tla escape --unescaped '$t'`;
-           }
-            push (@tmp, shell_quote($t));
+    my ($ps, $log) = @_;
+    my $key = undef;
+    while ($_ = shift @$log) {
+        if (/^Continuation-of:\s*(.*)/) {
+            $ps->{tag} = $1;
+            $key = undef;
+        } elsif (/^Summary:\s*(.*)$/ ) {
+            # summary can be multiline as long as it has a leading space
+            $ps->{summary} = [ $1 ];
+            $key = 'summary';
+        } elsif (/^Creator: (.*)\s*<([^\>]+)>/) {
+            $ps->{author} = $1;
+            $ps->{email} = $2;
+            $key = undef;
+        } elsif (/^$/) {
+            last; # remainder of @$log that didn't get shifted off is message
+        } elsif ($key) {
+            if (/^\s+(.*)$/) {
+                if ($key eq 'summary') {
+                    push @{$ps->{$key}}, $1;
+                } else {
+                    push @{$ps->{$key}}, split(/\s+/, $1);
+                }
+            } else {
+                $key = undef;
+            }
         }
-        @$ref = @tmp;
     }
     
-    #print Dumper [$sum, $msg, \@add, \@del, \@mod, \@ren]; 
-    return       ($sum, $msg, \@add, \@del, \@mod, \@ren); 
+    $ps->{summary} = join("\n",@{$ps->{summary}})."\n";
+    $ps->{message} = join("\n",@$log);
 }
 
 # write/read a tag
@@ -816,8 +701,11 @@ sub find_parents {
 	    }
 	}
     }
-    @parents = keys %parents;
-    @parents = map { " -p " . ptag($_) } @parents;
+    
+    @parents = ();
+    foreach (keys %parents) {
+        push @parents, '-p', ptag($_);
+    }
     return @parents;
 }
 
@@ -840,3 +728,26 @@ sub commitid2pset {
 	|| (print Dumper(sort keys %psets)) && die "Cannot find patchset for $name";
     return $ps;
 }
+
+
+# an alterative to `command` that allows input to be passed as an array
+# to work around shell problems with weird characters in arguments
+sub safe_pipe_capture {
+    my @output;
+    if (my $pid = open my $child, '-|') {
+        @output = (<$child>);
+        close $child or die join(' ',@_).": $! $?";
+    } else {
+	exec(@_) or die $?; # exec() can fail the executable can't be found
+    }
+    return wantarray ? @output : join('',@output);
+}
+
+# `tla logs -rf -d <dir> | head -n1` or `baz tree-id <dir>`
+sub arch_tree_id {
+    my $dir = shift;
+    chomp( my $ret = (safe_pipe_capture($TLA,'logs','-rf','-d',$dir))[0] );
+    return $ret;
+}
+
+
---
0.99.9.GIT
