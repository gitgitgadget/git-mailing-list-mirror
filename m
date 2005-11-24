From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 6/9] safer log file parsing
Date: Wed, 23 Nov 2005 23:53:55 -0800
Message-ID: <20051124075355.GG4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net> <20051124075133.GE4789@mail.yhbt.net> <20051124075243.GF4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:55:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBvb-0007pb-Ta
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbVKXHx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKXHx5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:53:57 -0500
Received: from hand.yhbt.net ([66.150.188.102]:61161 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030568AbVKXHx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:53:56 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id F05112DC033; Wed, 23 Nov 2005 23:53:55 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051124075243.GF4789@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12688>

Better logfile parsing, no longer confused by 'headers' after the first
blank line.

Re-enabled tag-reading with abrowse (baz and tla compatible)

Remove need to quote args to external processes

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |  211 +++++++++++++++++++++++++++------------------------
 1 files changed, 112 insertions(+), 99 deletions(-)

applies-to: 1633bcf09400e93aca2eb335181db298a5f49350
3e12af1d958e2d631e27a2f696ca71f83094c7c3
diff --git a/git-archimport.perl b/git-archimport.perl
index 3968740..8676f35 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -140,10 +140,10 @@ sub do_abrowse {
                     $ps{type} = 's';
                 } elsif ($type =~ /\(.*import\)/) {
                     $ps{type} = 'i';
-                } elsif ($type =~ m/\(tag.*\)/) {
+                } elsif ($type =~ m/\(tag.*?(\S+\@\S+).*?\)/) {
                     $ps{type} = 't';
                     # read which revision we've tagged when we parse the log
-                    #$ps{tag}  = $1;
+                    $ps{tag}  = $1;
                 } else { 
                     warn "Unknown type $type";
                 }
@@ -359,78 +359,73 @@ foreach my $ps (@psets) {
     #
     my $tree;
     
-    my $commitlog = safe_pipe_capture($TLA,'cat-archive-log',$ps->{id}); 
+    my @commitlog = safe_pipe_capture($TLA,'cat-archive-log',$ps->{id}); 
     die "Error in cat-archive-log: $!" if $?;
         
-    # parselog will git-add/rm files
-    # and generally prepare things for the commit
-    # NOTE: parselog will shell-quote filenames! 
-    my ($sum, $msg, $add, $del, $mod, $ren) = parselog($commitlog);
-    my $logmessage = "$sum\n$msg";
-
+    parselog($ps,\@commitlog);
 
     # imports don't give us good info
     # on added files. Shame on them
-    if ($ps->{type} eq 'i' || $ps->{type} eq 't') { 
-        `find . -type f -print0 | grep -zv '^./$git_dir' | xargs -0 -l100 git-update-index --add`;
-        `git-ls-files --deleted -z | xargs --no-run-if-empty -0 -l100 git-update-index --remove`;
+    if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
+        system('git-ls-files --others -z | '.
+                'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
+        system('git-ls-files --deleted -z | '.
+                'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
     }
 
-    if (@$add) {
+    # TODO: handle removed_directories and renamed_directories:
+   
+    if (my $add = $ps->{new_files}) {
         while (@$add) {
             my @slice = splice(@$add, 0, 100);
-            my $slice = join(' ', @slice);          
-            `git-update-index --add $slice`;
-            die "Error in git-update-index --add: $!" if $?;
+            system('git-update-index','--add','--',@slice) == 0 or
+                            die "Error in git-update-index --add: $! $?\n";
         }
     }
-    if (@$del) {
-        foreach my $file (@$del) {
-            unlink $file or die "Problems deleting $file : $!";
-        }
+   
+    if (my $del = $ps->{removed_files}) {
+        unlink @$del;
         while (@$del) {
             my @slice = splice(@$del, 0, 100);
-            my $slice = join(' ', @slice);
-            `git-update-index --remove $slice`;
-            die "Error in git-update-index --remove: $!" if $?;
+            system('git-update-index','--remove','--',@slice) == 0 or
+                            die "Error in git-update-index --remove: $! $?\n";
         }
     }
-    if (@$ren) {                # renamed
+
+    if (my $ren = $ps->{renamed_files}) {                # renamed
         if (@$ren % 2) {
             die "Odd number of entries in rename!?";
         }
-        ;
+        
         while (@$ren) {
-            my $from = pop @$ren;
-            my $to   = pop @$ren;           
+            my $from = shift @$ren;
+            my $to   = shift @$ren;           
 
             unless (-d dirname($to)) {
                 mkpath(dirname($to)); # will die on err
             }
-            #print "moving $from $to";
-            `mv $from $to`;
-            die "Error renaming $from $to : $!" if $?;
-            `git-update-index --remove $from`;
-            die "Error in git-update-index --remove: $!" if $?;
-            `git-update-index --add $to`;
-            die "Error in git-update-index --add: $!" if $?;
+            print "moving $from $to";
+            rename($from, $to) or die "Error renaming '$from' '$to': $!\n";
+            system('git-update-index','--remove','--',$from) == 0 or
+                            die "Error in git-update-index --remove: $! $?\n";
+            system('git-update-index','--add','--',$to) == 0 or
+                            die "Error in git-update-index --add: $! $?\n";
         }
 
     }
-    if (@$mod) {                # must be _after_ renames
+
+    if (my $mod = $ps->{modified_files}) {
         while (@$mod) {
             my @slice = splice(@$mod, 0, 100);
-            my $slice = join(' ', @slice);
-            `git-update-index $slice`;
-            die "Error in git-update-index: $!" if $?;
+            system('git-update-index','--',@slice) == 0 or
+                            die "Error in git-update-index: $! $?\n";
         }
     }
-
+    
     # warn "errors when running git-update-index! $!";
     $tree = `git-write-tree`;
     die "cannot write tree $!" if $?;
     chomp $tree;
-        
     
     #
     # Who's your daddy?
@@ -464,13 +459,14 @@ foreach my $ps (@psets) {
     $ENV{GIT_COMMITTER_EMAIL} = $ps->{email};
     $ENV{GIT_COMMITTER_DATE}  = $ps->{date};
 
-    my ($pid, $commit_rh, $commit_wh);
-    $commit_rh = 'commit_rh';
-    $commit_wh = 'commit_wh';
-    
-    $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par) 
+    my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par) 
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
@@ -568,7 +564,9 @@ sub apply_cset {
 
 
 # =for reference
-# A log entry looks like 
+# notes: *-files/-directories keys cannot have spaces, they're always
+# pika-escaped.  Everything after the first newline
+# A log entry looks like:
 # Revision: moodle-org--moodle--1.3.3--patch-15
 # Archive: arch-eduforge@catalyst.net.nz--2004
 # Creator: Penny Leach <penny@catalyst.net.nz>
@@ -586,70 +584,85 @@ sub apply_cset {
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
+    my ($ps, $log) = @_;
+    my $key = undef;
 
-    $msg = '';
-    if ($log =~ m/\n\n(.+)$/s) {
-        $msg = $1;
-        $msg =~ s/^\s+//;
-        $msg =~ s/\s+$//;
+    # headers we want that contain filenames:
+    my %want_headers = (
+        new_files => 1,
+        modified_files => 1,
+        renamed_files => 1,
+        renamed_directories => 1,
+        removed_files => 1,
+        removed_directories => 1,
+    );
+    
+    chomp (@$log);
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
+        # any *-files or *-directories can be read here:
+        } elsif (/^([A-Z][a-z\-]+):\s*(.*)$/) {
+            my $val = $2;
+            $key = lc $1;
+            $key =~ tr/-/_/; # too lazy to quote :P
+            if ($want_headers{$key}) {
+                push @{$ps->{$key}}, split(/\s+/, $val);
+            } else {
+                $key = undef;
+            }
+        } elsif (/^$/) {
+            last; # remainder of @$log that didn't get shifted off is message
+        } elsif ($key) {
+            if (/^\s+(.*)$/) {
+                if ($key eq 'summary') {
+                    push @{$ps->{$key}}, $1;
+                } else { # files/directories:
+                    push @{$ps->{$key}}, split(/\s+/, $1);
+                }
+            } else {
+                $key = undef;
+            }
+        }
     }
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
+   
+    # post-processing:
+    $ps->{summary} = join("\n",@{$ps->{summary}})."\n";
+    $ps->{message} = join("\n",@$log);
+    
+    # skip Arch control files, unescape pika-escaped files
+    foreach my $k (keys %want_headers) {
+        next unless (defined $ps->{$k});
+        my @tmp;
+        foreach my $t (@{$ps->{$k}}) {
+           next unless length ($t);
+           next if $t =~ m!\{arch\}/!;
+           next if $t =~ m!\.arch-ids/!;
+           # should we skip this?
+           next if $t =~ m!\.arch-inventory$!;
            # tla cat-archive-log will give us filenames with spaces as file\(sp)name - why?
            # we can assume that any filename with \ indicates some pika escaping that we want to get rid of.
-           if  ($t =~ /\\/ ){
+           if ($t =~ /\\/ ){
                $t = (safe_pipe_capture($TLA,'escape','--unescaped',$t))[0];
            }
-            push (@tmp, $t);
+           push @tmp, $t;
         }
-        @$ref = @tmp;
+        $ps->{$k} = \@tmp if scalar @tmp;
     }
-    
-    #print Dumper [$sum, $msg, \@add, \@del, \@mod, \@ren]; 
-    return       ($sum, $msg, \@add, \@del, \@mod, \@ren); 
 }
 
 # write/read a tag
---
0.99.9.GIT
