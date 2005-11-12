From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/5] -D <depth> option to recurse into merged branches
Date: Sat, 12 Nov 2005 01:32:08 -0800
Message-ID: <20051112093208.GF16218@Muzzle>
References: <20051112092336.GA16218@Muzzle> <20051112092533.GB16218@Muzzle> <20051112092721.GC16218@Muzzle> <20051112092920.GD16218@Muzzle> <20051112093045.GE16218@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 10:33:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eark6-000768-HA
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 10:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVKLJcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 04:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVKLJcM
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 04:32:12 -0500
Received: from hand.yhbt.net ([66.150.188.102]:41613 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932270AbVKLJcL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 04:32:11 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id D515A2DC03B;
	Sat, 12 Nov 2005 01:32:09 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sat, 12 Nov 2005 01:32:08 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051112093045.GE16218@Muzzle>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11667>

-D <depth> option to recurse into merged branches
-a auto-register Arch archive if it's on mirrors.sourcecontrol.net

fix for dealing with tag revisions
remove unused module loading (no more String::ShellQuote dep)

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |  257 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 141 insertions(+), 116 deletions(-)

applies-to: d6d3e5272bc39ea086e5c1b0b39ceb5b51ade1ff
2fe160b44c5e5da1a139668767ba184b6b63f605
diff --git a/git-archimport.perl b/git-archimport.perl
index 5616d42..a0ea016 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -22,9 +22,10 @@ See man (1) git-archimport for more deta
 =head1 TODO
 
  - create tag objects instead of ref tags
- - audit shell-escaping of filenames
  - hide our private tags somewhere smarter
- - find a way to make "cat *patches | patch" safe even when patchfiles are missing newlines  
+ - sort and apply patches by graphing ancestry relations instead of just
+   relying in dates supplied in the changeset itself.
+   tla ancestry-graph -m could be helpful here...
 
 =head1 Devel tricks
 
@@ -53,15 +54,9 @@ and can contain multiple, unrelated bran
 use strict;
 use warnings;
 use Getopt::Std;
-use File::Spec;
-use File::Temp qw(tempfile tempdir);
+use File::Temp qw(tempdir);
 use File::Path qw(mkpath rmtree);
 use File::Basename qw(basename dirname);
-use String::ShellQuote;
-use Time::Local;
-use IO::Socket;
-use IO::Pipe;
-use POSIX qw(strftime dup2);
 use Data::Dumper qw/ Dumper /;
 use IPC::Open2;
 
@@ -72,29 +67,35 @@ my $git_dir = $ENV{"GIT_DIR"} || ".git";
 $ENV{"GIT_DIR"} = $git_dir;
 my $ptag_dir = "$git_dir/archimport/tags";
 
-our($opt_h,$opt_v, $opt_T,
-    $opt_C,$opt_t);
+our($opt_h,$opt_v,$opt_T,$opt_t,$opt_D,$opt_a);
 
 sub usage() {
     print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from Arch
-       [ -h ] [ -v ] [ -T ] [ -t tempdir ] 
+       [ -h ] [ -v ] [ -T ] [ -a ] [ -D depth  ] [ -t tempdir ]
        repository/arch-branch [ repository/arch-branch] ...
 END
     exit(1);
 }
 
-getopts("Thvt:") or usage();
+getopts("Thvat:D:") or usage();
 usage if $opt_h;
 
 @ARGV >= 1 or usage();
-my @arch_roots = @ARGV;
 
+# $arch_branches:
+# values associated with keys:
+#   =1 - Arch version / git 'branch' detected via abrowse on a limit
+#   >1 - Arch version / git 'branch' of an auxilliary branch we've merged
+my %arch_branches = map { $_ => 1 } @ARGV;
+ 
 my $tmptree;
 $ENV{'TMPDIR'} = $opt_t if $opt_t;
 $tmptree = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
 $opt_v && print "+ Using $tmptree to store temporary trees\n";
 
+my %reachable = ();             # Arch repositories we can access
+my %unreachable = ();           # Arch repositories we can't access :<
 my @psets  = ();                # the collection
 my %psets  = ();                # the collection, by name
 
@@ -102,114 +103,117 @@ my %rptags = ();                # my rev
                                 # to map a SHA1 to a commitid
 my $TLA = $ENV{'ARCH_CLIENT'} || 'tla';
 
-foreach my $root (@arch_roots) {
-    my ($arepo, $abranch) = split(m!/!, $root);
-    open ABROWSE, "tla abrowse -f -A $arepo --desc --merges $abranch |" 
-        or die "Problems with tla abrowse: $!";
-    
-    my %ps        = ();         # the current one
-    my $mode      = '';
-    my $lastseen  = '';
-    
-    while (<ABROWSE>) {
-        chomp;
-        
-        # first record padded w 8 spaces
-        if (s/^\s{8}\b//) {
-            
-            # store the record we just captured
-            if (%ps) {
-                my %temp = %ps; # break references
-                push (@psets, \%temp);
-		$psets{$temp{id}} = \%temp;
-                %ps = ();
-            }
-            
-            my ($id, $type) = split(m/\s{3}/, $_);
-            $ps{id}   = $id;
-            $ps{repo} = $arepo;
-
-            # deal with types
-            if ($type =~ m/^\(simple changeset\)/) {
-                $ps{type} = 's';
-            } elsif ($type eq '(initial import)') {
-                $ps{type} = 'i';
-            } elsif ($type =~ m/^\(tag revision of (.+)\)/) {
-                $ps{type} = 't';
-                $ps{tag}  = $1;
-            } else { 
-                warn "Unknown type $type";
-            }
-            $lastseen = 'id';
-        }
-        
-        if (s/^\s{10}//) { 
-            # 10 leading spaces or more 
-            # indicate commit metadata
-            
-            # date & author 
-            if ($lastseen eq 'id' && m/^\d{4}-\d{2}-\d{2}/) {
+sub do_abrowse {
+    my $stage = shift;
+    while (my ($limit, $level) = each %arch_branches) {
+        next unless $level == $stage;
+    
+        open ABROWSE, "$TLA abrowse -fkD --merges $limit |" 
+                                or die "Problems with tla abrowse: $!";
+    
+        my %ps        = ();         # the current one
+        my $lastseen  = '';
+    
+        while (<ABROWSE>) {
+            chomp;
+            
+            # first record padded w 8 spaces
+            if (s/^\s{8}\b//) {
+                my ($id, $type) = split(m/\s+/, $_, 2);
+
+                my %last_ps;
+                # store the record we just captured
+                if (%ps && !exists $psets{ $ps{id} }) {
+                    %last_ps = %ps; # break references
+                    push (@psets, \%last_ps);
+                    $psets{ $last_ps{id} } = \%last_ps;
+                }
                 
-                my ($date, $authoremail) = split(m/\s{2,}/, $_);
-                $ps{date}   = $date;
-                $ps{date}   =~ s/\bGMT$//; # strip off trailign GMT
-                if ($ps{date} =~ m/\b\w+$/) {
-                    warn 'Arch dates not in GMT?! - imported dates will be wrong';
+                my $branch = extract_versionname($id);
+                %ps = ( id => $id, branch => $branch );
+                if (%last_ps && ($last_ps{branch} eq $branch)) {
+                    $ps{parent_id} = $last_ps{id};
+                }
+                
+                $arch_branches{$branch} = 1;
+                $lastseen = 'id';
+
+                # deal with types (should work with baz or tla):
+                if ($type =~ m/\(.*changeset\)/) {
+                    $ps{type} = 's';
+                } elsif ($type =~ /\(.*import\)/) {
+                    $ps{type} = 'i';
+                } elsif ($type =~ m/\(tag.*\)/) {
+                    $ps{type} = 't';
+                    # read which revision we've tagged when we parse the log
+                    #$ps{tag}  = $1;
+                } else { 
+                    warn "Unknown type $type";
+                }
+
+                $arch_branches{$branch} = 1;
+                $lastseen = 'id';
+            } elsif (s/^\s{10}//) { 
+                # 10 leading spaces or more 
+                # indicate commit metadata
+                
+                # date
+                if ($lastseen eq 'id' && m/^(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d)/){
+                    $ps{date}   = $1;
+                    $lastseen = 'date';
+                } elsif ($_ eq 'merges in:') {
+                    $ps{merges} = [];
+                    $lastseen = 'merges';
+                } elsif ($lastseen eq 'merges' && s/^\s{2}//) {
+                    my $id = $_;
+                    push (@{$ps{merges}}, $id);
+                   
+                    # aggressive branch finding:
+                    if ($opt_D) {
+                        my $branch = extract_versionname($id);
+                        my $repo = extract_reponame($branch);
+                        
+                        if (archive_reachable($repo) &&
+                                !defined $arch_branches{$branch}) {
+                            $arch_branches{$branch} = $stage + 1;
+                        }
+                    }
+                } else {
+                    warn "more metadata after merges!?: $_\n" unless /^\s*$/;
                 }
-            
-                $authoremail =~ m/^(.+)\s(\S+)$/;
-                $ps{author} = $1;
-                $ps{email}  = $2;
-            
-                $lastseen = 'date';
-            
-            } elsif ($lastseen eq 'date') {
-                # the only hint is position
-                # subject is after date
-                $ps{subj} = $_;
-                $lastseen = 'subj';
-            
-            } elsif ($lastseen eq 'subj' && $_ eq 'merges in:') {
-                $ps{merges} = [];
-                $lastseen = 'merges';
-            
-            } elsif ($lastseen eq 'merges' && s/^\s{2}//) {
-                push (@{$ps{merges}}, $_);
-            } else {
-                warn 'more metadata after merges!?';
             }
-            
         }
-    }
 
-    if (%ps) {
-        my %temp = %ps;         # break references
-        push (@psets, \%temp);  
-	$psets{ $temp{id} } = \%temp;
-        %ps = ();
-    }    
-    close ABROWSE;
+        if (%ps && !exists $psets{ $ps{id} }) {
+            my %temp = %ps;         # break references
+            if ($psets[$#psets]{branch} eq $ps{branch}) {
+                $temp{parent_id} = $psets[$#psets]{id};
+            }
+            push (@psets, \%temp);  
+            $psets{ $temp{id} } = \%temp;
+        }    
+        
+        close ABROWSE or die "$TLA abrowse failed on $limit\n";
+    }
 }                               # end foreach $root
 
+do_abrowse(1);
+my $depth = 2;
+$opt_D ||= 0;
+while ($depth <= $opt_D) {
+    do_abrowse($depth);
+    $depth++;
+}
+ 
 ## Order patches by time
+# FIXME see if we can find a more optimal way to do this by graphing
+# the ancestry data and walking it, that way we won't have to rely on
+# client-supplied dates
 @psets = sort {$a->{date}.$b->{id} cmp $b->{date}.$b->{id}} @psets;
 
-#print Dumper \@psets;
-
-##
-## TODO cleanup irrelevant patches
-##      and put an initial import
-##      or a full tag
-my $import = 0;
 unless (-d $git_dir) { # initial import
-    if ($psets[0]{type} eq 'i' || $psets[0]{type} eq 't') {
-        print "Starting import from $psets[0]{id}\n";
-	`git-init-db`;
-	die $! if $?;
-	$import = 1;
-    } else {
-        die "Need to start from an import or a tag -- cannot use $psets[0]{id}";
-    }
+    print "Starting import from $psets[0]{id}\n";
+    system('git-init-db') == 0 or die "$! $?\n";
 } else {    # progressing an import
     # load the rptags
     opendir(DIR, $ptag_dir)
@@ -233,7 +237,6 @@ unless (-d $git_dir) { # initial import
     closedir DIR;
 }
 
-# process patchsets
 # extract the Arch repository name (Arch "archive" in Arch-speak)
 sub extract_reponame {
     my $fq_cvbr = shift; # archivename/[[[[category]branch]version]revision]
@@ -266,21 +269,21 @@ sub tree_dirname {
 
 *git_branchname = *tree_dirname;
 
-# process patchsets
+# process patchsets in ancestry order
 foreach my $ps (@psets) {
     $ps->{branch} = git_branchname($ps->{id});
 
     #
     # ensure we have a clean state 
     # 
-    if (`git diff-files`) {
+    if (`git-diff-files`) {
         die "Unclean tree when about to process $ps->{id} " .
             " - did we fail to commit cleanly before?";
     }
     die $! if $?;
 
     #
-    # skip commits already in repo
+    # skip commits already in git repo
     #
     if (ptag($ps->{id})) {
       $opt_v && print " * Skipping already imported: $ps->{id}\n";
@@ -427,7 +430,7 @@ sub sync_to_ps {
     my $tree_dir = $tmptree.'/'.tree_dirname($ps->{id});
 
     if (-d $tree_dir) {
-        if ($ps->{type} eq 't' && defined $ps->{tag}) {
+        if ($ps->{type} eq 't') {
             # looks like a tag-only or (worse,) a mixed tags/changeset branch,
             # can't rely on replay to work correctly on these
             rmtree($tree_dir);
@@ -435,13 +438,16 @@ sub sync_to_ps {
         } else {
                 my $tree_id = arch_tree_id($tree_dir);
                 if ($ps->{parent_id} eq $tree_id) {
+                    # the common case (hopefully)
                     safe_pipe_capture($TLA,'replay','-d',$tree_dir,$ps->{id});
                 } else {
+                    # this can happen if branches cherry-pick
                     safe_pipe_capture($TLA,'apply-delta','-d',$tree_dir,
                                                         $tree_id, $ps->{id});
                 }
         }
     } else {
+        # new branch work
         safe_pipe_capture($TLA,'get','--no-pristine',$ps->{id},$tree_dir);
     }
    
@@ -750,4 +756,23 @@ sub arch_tree_id {
     return $ret;
 }
 
+sub archive_reachable {
+    my $archive = shift;
+    return 1 if $reachable{$archive};
+    return 0 if $unreachable{$archive};
+    
+    if (system "$TLA whereis-archive $archive >/dev/null") {
+        if ($opt_a && (system($TLA,'register-archive',
+                      "http://mirrors.sourcecontrol.net/$archive") == 0)) {
+            $reachable{$archive} = 1;
+            return 1;
+        }
+        print STDERR "Archive is unreachable: $archive\n";
+        $unreachable{$archive} = 1;
+        return 0;
+    } else {
+        $reachable{$archive} = 1;
+        return 1;
+    }
+}
 
---
0.99.9.GIT
