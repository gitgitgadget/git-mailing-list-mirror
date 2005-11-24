From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 7/9] Add the accurate changeset applyer
Date: Wed, 23 Nov 2005 23:55:04 -0800
Message-ID: <20051124075504.GH4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net> <20051124075133.GE4789@mail.yhbt.net> <20051124075243.GF4789@mail.yhbt.net> <20051124075355.GG4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:55:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBwk-0008FJ-IP
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbVKXHzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKXHzG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:55:06 -0500
Received: from hand.yhbt.net ([66.150.188.102]:63721 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030570AbVKXHzE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:55:04 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id A43922DC033; Wed, 23 Nov 2005 23:55:04 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051124075355.GG4789@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12687>

And make it the default.
This includes stats tracking to verbose mode

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |  201 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 172 insertions(+), 29 deletions(-)

applies-to: aa9140057c95e59f65de0794f9054796fbfc96e5
32e5887eedb01ac4c398a06b0a1433ff6f4599fe
diff --git a/git-archimport.perl b/git-archimport.perl
index 8676f35..1cf1261 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -25,6 +25,9 @@ See man (1) git-archimport for more deta
  - audit shell-escaping of filenames
  - hide our private tags somewhere smarter
  - find a way to make "cat *patches | patch" safe even when patchfiles are missing newlines  
+ - sort and apply patches by graphing ancestry relations instead of just
+   relying in dates supplied in the changeset itself.
+   tla ancestry-graph -m could be helpful here...
 
 =head1 Devel tricks
 
@@ -66,18 +69,18 @@ my $git_dir = $ENV{"GIT_DIR"} || ".git";
 $ENV{"GIT_DIR"} = $git_dir;
 my $ptag_dir = "$git_dir/archimport/tags";
 
-our($opt_h,$opt_v,$opt_T,$opt_t,$opt_D,$opt_a,$opt_o);
+our($opt_h,$opt_f,$opt_v,$opt_T,$opt_t,$opt_D,$opt_a,$opt_o);
 
 sub usage() {
     print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from Arch
-       [ -o ] [ -h ] [ -v ] [ -T ] [ -a ] [ -D depth  ] [ -t tempdir ]
+       [ -f ] [ -o ] [ -h ] [ -v ] [ -T ] [ -a ] [ -D depth  ] [ -t tempdir ]
        repository/arch-branch [ repository/arch-branch] ...
 END
     exit(1);
 }
 
-getopts("Thvat:D:") or usage();
+getopts("fThvat:D:") or usage();
 usage if $opt_h;
 
 @ARGV >= 1 or usage();
@@ -95,6 +98,10 @@ my %reachable = ();             # Arch r
 my %unreachable = ();           # Arch repositories we can't access :<
 my @psets  = ();                # the collection
 my %psets  = ();                # the collection, by name
+my %stats  = (			# Track which strategy we used to import:
+	get_tag => 0, replay => 0, get_new => 0, get_delta => 0,
+        simple_changeset => 0, import_or_tag => 0
+);
 
 my %rptags = ();                # my reverse private tags
                                 # to map a SHA1 to a commitid
@@ -288,29 +295,69 @@ sub old_style_branchname {
 
 *git_branchname = $opt_o ? *old_style_branchname : *tree_dirname;
 
-# process patchsets
-foreach my $ps (@psets) {
-    $ps->{branch} = git_branchname($ps->{id});
-
-    #
-    # ensure we have a clean state 
-    # 
-    if (`git-diff-files`) {
-        die "Unclean tree when about to process $ps->{id} " .
-            " - did we fail to commit cleanly before?";
-    }
-    die $! if $?;
-
-    #
-    # skip commits already in repo
-    #
-    if (ptag($ps->{id})) {
-      $opt_v && print " * Skipping already imported: $ps->{id}\n";
-      next;
+sub process_patchset_accurate {
+    my $ps = shift;
+    
+    # switch to that branch if we're not already in that branch:
+    if (-e "$git_dir/refs/heads/$ps->{branch}") {
+       system('git-checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
+
+       # remove any old stuff that got leftover:
+       my $rm = safe_pipe_capture('git-ls-files','--others','-z');
+       rmtree(split(/\0/,$rm)) if $rm;
     }
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
+            
+            # find where we are supposed to branch from
+            system('git-checkout','-f','-b',$ps->{branch},
+                            $branchpoint) == 0 or die "$! $?\n";
+            
+            # remove any old stuff that got leftover:
+            my $rm = safe_pipe_capture('git-ls-files','--others','-z');
+            rmtree(split(/\0/,$rm)) if $rm;
 
-    print " * Starting to work on $ps->{id}\n";
+            # If we trust Arch with the fact that this is just 
+            # a tag, and it does not affect the state of the tree
+            # then we just tag and move on
+            tag($ps->{id}, $branchpoint);
+            ptag($ps->{id}, $branchpoint);
+            print " * Tagged $ps->{id} at $branchpoint\n";
+            return 0;
+        } else {
+            warn "Tagging from unknown id unsupported\n" if $ps->{tag};
+        }
+        # allow multiple bases/imports here since Arch supports cherry-picks
+        # from unrelated trees
+    } 
+    
+    # update the index with all the changes we got
+    system('git-ls-files --others -z | '.
+            'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
+    system('git-ls-files --deleted -z | '.
+            'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
+    system('git-ls-files -z | '.
+             'git-update-index -z --stdin') == 0 or die "$! $?\n";
+    return 1;
+}
 
+# the native changeset processing strategy.  This is very fast, but
+# does not handle permissions or any renames involving directories
+sub process_patchset_fast {
+    my $ps = shift;
     # 
     # create the branch if needed
     #
@@ -338,7 +385,7 @@ foreach my $ps (@psets) {
             tag($ps->{id}, $branchpoint);
             ptag($ps->{id}, $branchpoint);
             print " * Tagged $ps->{id} at $branchpoint\n";
-            next;
+            return 0;
         } 
         die $! if $?;
     } 
@@ -348,16 +395,17 @@ foreach my $ps (@psets) {
     # 
     if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
         apply_import($ps) or die $!;
+        $stats{import_or_tag}++;
         $import=0;
     } elsif ($ps->{type} eq 's') {
         apply_cset($ps);
+        $stats{simple_changeset}++;
     }
 
     #
     # prepare update git's index, based on what arch knows
     # about the pset, resolve parents, etc
     #
-    my $tree;
     
     my @commitlog = safe_pipe_capture($TLA,'cat-archive-log',$ps->{id}); 
     die "Error in cat-archive-log: $!" if $?;
@@ -404,14 +452,13 @@ foreach my $ps (@psets) {
             unless (-d dirname($to)) {
                 mkpath(dirname($to)); # will die on err
             }
-            print "moving $from $to";
+            # print "moving $from $to";
             rename($from, $to) or die "Error renaming '$from' '$to': $!\n";
             system('git-update-index','--remove','--',$from) == 0 or
                             die "Error in git-update-index --remove: $! $?\n";
             system('git-update-index','--add','--',$to) == 0 or
                             die "Error in git-update-index --add: $! $?\n";
         }
-
     }
 
     if (my $mod = $ps->{modified_files}) {
@@ -421,9 +468,46 @@ foreach my $ps (@psets) {
                             die "Error in git-update-index: $! $?\n";
         }
     }
+    return 1; # we successfully applied the changeset
+}
+
+if ($opt_f) {
+    print "Will import patchsets using the fast strategy\n",
+            "Renamed directories and permission changes will be missed\n";
+    *process_patchset = *process_patchset_fast;
+} else {
+    print "Using the default (accurate) import strategy.\n",
+            "Things may be a bit slow\n";
+    *process_patchset = *process_patchset_accurate;
+}
+    
+foreach my $ps (@psets) {
+    # process patchsets
+    $ps->{branch} = git_branchname($ps->{id});
+
+    #
+    # ensure we have a clean state 
+    # 
+    if (my $dirty = `git-diff-files`) {
+        die "Unclean tree when about to process $ps->{id} " .
+            " - did we fail to commit cleanly before?\n$dirty";
+    }
+    die $! if $?;
     
+    #
+    # skip commits already in repo
+    #
+    if (ptag($ps->{id})) {
+      $opt_v && print " * Skipping already imported: $ps->{id}\n";
+      return 0;
+    }
+
+    print " * Starting to work on $ps->{id}\n";
+
+    process_patchset($ps) or next;
+
     # warn "errors when running git-update-index! $!";
-    $tree = `git-write-tree`;
+    my $tree = `git-write-tree`;
     die "cannot write tree $!" if $?;
     chomp $tree;
     
@@ -494,6 +578,65 @@ foreach my $ps (@psets) {
     print "   + commit $commitid\n";
     $opt_v && print "   + commit date is  $ps->{date} \n";
     $opt_v && print "   + parents:  ",join(' ',@par),"\n";
+    if (my $dirty = `git-diff-files`) {
+        die "22 Unclean tree when about to process $ps->{id} " .
+            " - did we fail to commit cleanly before?\n$dirty";
+    }
+}
+
+if ($opt_v) {
+    foreach (sort keys %stats) {
+        print" $_: $stats{$_}\n";
+    }
+}
+exit 0;
+
+# used by the accurate strategy:
+sub sync_to_ps {
+    my $ps = shift;
+    my $tree_dir = $tmp.'/'.tree_dirname($ps->{id});
+    
+    $opt_v && print "sync_to_ps($ps->{id}) method: ";
+
+    if (-d $tree_dir) {
+        if ($ps->{type} eq 't') {
+	    $opt_v && print "get (tag)\n";
+            # looks like a tag-only or (worse,) a mixed tags/changeset branch,
+            # can't rely on replay to work correctly on these
+            rmtree($tree_dir);
+            safe_pipe_capture($TLA,'get','--no-pristine',$ps->{id},$tree_dir);
+            $stats{get_tag}++;
+        } else {
+                my $tree_id = arch_tree_id($tree_dir);
+                if ($ps->{parent_id} && ($ps->{parent_id} eq $tree_id)) {
+                    # the common case (hopefully)
+		    $opt_v && print "replay\n";
+                    safe_pipe_capture($TLA,'replay','-d',$tree_dir,$ps->{id});
+                    $stats{replay}++;
+                } else {
+                    # getting one tree is usually faster than getting two trees
+                    # and applying the delta ...
+                    rmtree($tree_dir);
+		    $opt_v && print "apply-delta\n";
+                    safe_pipe_capture($TLA,'get','--no-pristine',
+                                        $ps->{id},$tree_dir);
+                    $stats{get_delta}++;
+                }
+        }
+    } else {
+        # new branch work
+        $opt_v && print "get (new tree)\n";
+        safe_pipe_capture($TLA,'get','--no-pristine',$ps->{id},$tree_dir);
+        $stats{get_new}++;
+    }
+   
+    # added -I flag to rsync since we're going to fast! AIEEEEE!!!!
+    system('rsync','-aI','--delete','--exclude',$git_dir,
+#               '--exclude','.arch-inventory',
+                '--exclude','.arch-ids','--exclude','{arch}',
+                '--exclude','+*','--exclude',',*',
+                "$tree_dir/",'./') == 0 or die "Cannot rsync $tree_dir: $! $?";
+    return $tree_dir;
 }
 
 sub apply_import {
@@ -896,7 +1039,7 @@ sub safe_pipe_capture {
         @output = (<$child>);
         close $child or die join(' ',@_).": $! $?";
     } else {
-	exec(@_) or die $?; # exec() can fail the executable can't be found
+	exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
     }
     return wantarray ? @output : join('',@output);
 }
---
0.99.9.GIT
