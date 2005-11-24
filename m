From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/9] add -D <depth> and -a switch
Date: Wed, 23 Nov 2005 23:52:43 -0800
Message-ID: <20051124075243.GF4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net> <20051124075133.GE4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBuf-0007Up-LF
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbVKXHwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbVKXHwp
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:52:45 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60393 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030573AbVKXHwo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:52:44 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id D71C92DC033; Wed, 23 Nov 2005 23:52:43 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051124075133.GE4789@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12686>


add -D <depth> option to abrowse add -a switch to attempt to
auto-register archives at mirrors.sourcecontrol.net

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |  227 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 136 insertions(+), 91 deletions(-)

applies-to: 4fd19922030196431179453910cb2b850b54c17d
c52baf62ec29772f7a4e5b0aa2b605bf0f6aa8f7
diff --git a/git-archimport.perl b/git-archimport.perl
index 938fa2b..3968740 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -53,14 +53,9 @@ and can contain multiple, unrelated bran
 use strict;
 use warnings;
 use Getopt::Std;
-use File::Spec;
-use File::Temp qw(tempfile tempdir);
+use File::Temp qw(tempdir);
 use File::Path qw(mkpath rmtree);
 use File::Basename qw(basename dirname);
-use Time::Local;
-use IO::Socket;
-use IO::Pipe;
-use POSIX qw(strftime dup2);
 use Data::Dumper qw/ Dumper /;
 use IPC::Open2;
 
@@ -71,27 +66,33 @@ my $git_dir = $ENV{"GIT_DIR"} || ".git";
 $ENV{"GIT_DIR"} = $git_dir;
 my $ptag_dir = "$git_dir/archimport/tags";
 
-our($opt_h,$opt_v, $opt_T,$opt_t,$opt_o);
+our($opt_h,$opt_v,$opt_T,$opt_t,$opt_D,$opt_a,$opt_o);
 
 sub usage() {
     print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from Arch
-       [ -o ] [ -h ] [ -v ] [ -T ] [ -t tempdir ] 
+       [ -o ] [ -h ] [ -v ] [ -T ] [ -a ] [ -D depth  ] [ -t tempdir ]
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
 
 $ENV{'TMPDIR'} = $opt_t if $opt_t; # $ENV{TMPDIR} will affect tempdir() calls:
 my $tmp = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
 $opt_v && print "+ Using $tmp as temporary directory\n";
 
+my %reachable = ();             # Arch repositories we can access
+my %unreachable = ();           # Arch repositories we can't access :<
 my @psets  = ();                # the collection
 my %psets  = ();                # the collection, by name
 
@@ -99,96 +100,112 @@ my %rptags = ();                # my rev
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
+sub do_abrowse {
+    my $stage = shift;
+    while (my ($limit, $level) = each %arch_branches) {
+        next unless $level == $stage;
         
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
+	open ABROWSE, "$TLA abrowse -fkD --merges $limit |" 
+                                or die "Problems with tla abrowse: $!";
+    
+        my %ps        = ();         # the current one
+        my $lastseen  = '';
+    
+        while (<ABROWSE>) {
+            chomp;
             
-            # date & author 
-            if ($lastseen eq 'id' && m/^\d{4}-\d{2}-\d{2}/) {
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
+            if (@psets && $psets[$#psets]{branch} eq $ps{branch}) {
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
 
 #print Dumper \@psets;
@@ -209,7 +226,7 @@ unless (-d $git_dir) { # initial import
     }
 } else {    # progressing an import
     # load the rptags
-    opendir(DIR, "$git_dir/archimport/tags")
+    opendir(DIR, $ptag_dir)
 	|| die "can't opendir: $!";
     while (my $file = readdir(DIR)) {
         # skip non-interesting-files
@@ -829,6 +846,7 @@ sub find_parents {
 	    }
 	}
     }
+
     @parents = ();
     foreach (keys %parents) {
         push @parents, '-p', ptag($_);
@@ -856,6 +874,7 @@ sub commitid2pset {
     return $ps;
 }
 
+
 # an alterative to `command` that allows input to be passed as an array
 # to work around shell problems with weird characters in arguments
 sub safe_pipe_capture {
@@ -869,4 +888,30 @@ sub safe_pipe_capture {
     return wantarray ? @output : join('',@output);
 }
 
+# `tla logs -rf -d <dir> | head -n1` or `baz tree-id <dir>`
+sub arch_tree_id {
+    my $dir = shift;
+    chomp( my $ret = (safe_pipe_capture($TLA,'logs','-rf','-d',$dir))[0] );
+    return $ret;
+}
+
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
