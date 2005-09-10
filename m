From: martin@catalyst.net.nz
Subject: [PATCH] archimport - add merge detection
Date: Sat, 10 Sep 2005 23:38:17 +1200
Message-ID: <1126352297800-git-send-email-martin@catalyst.net.nz>
Reply-To: martin@catalyst.net.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Sep 10 13:39:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EE3gx-00060X-CR
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 13:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVIJLik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 07:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVIJLik
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 07:38:40 -0400
Received: from 202-0-54-239.cable.paradise.net.nz ([202.0.54.239]:61847 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750750AbVIJLij (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2005 07:38:39 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id EFF408ABA5;
	Sat, 10 Sep 2005 23:38:17 +1200 (NZST)
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8254>

We now keep track of the patches merged in each branch since they have
diverged, using the records that the Arch "logs" provide. Merge parents
for a commit are defined if we are merging a series of patches that starts
from the mergebase.

If patches from a related branch are merged out-of-order, we keep track of
how much has been merged sequentially -- the tip of that sequential merge
is our new parent from that branch.

This mechanism works very well for branches that merge in dovetail and/or
flying fish patterns, probably less well for others.

---

 git-archimport.perl |  184 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 180 insertions(+), 4 deletions(-)

e4921c767dd41e23ad9f84b10c7ce1715827905f
diff --git a/git-archimport.perl b/git-archimport.perl
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -61,7 +61,7 @@ END
     exit(1);
 }
 
-getopts("hviC:t:") or usage();
+getopts("ThviC:t:") or usage();
 usage if $opt_h;
 
 @ARGV >= 1 or usage();
@@ -76,6 +76,10 @@ $git_tree ||= ".";
 
 
 my @psets  = ();                # the collection
+my %psets  = ();                # the collection, by name
+
+my %rptags = ();                # my reverse private tags
+                                # to map a SHA1 to a commitid
 
 foreach my $root (@arch_roots) {
     my ($arepo, $abranch) = split(m!/!, $root);
@@ -96,6 +100,7 @@ foreach my $root (@arch_roots) {
             if (%ps) {
                 my %temp = %ps; # break references
                 push (@psets, \%temp);
+		$psets{$temp{id}} = \%temp;
                 %ps = ();
             }
             
@@ -158,7 +163,8 @@ foreach my $root (@arch_roots) {
 
     if (%ps) {
         my %temp = %ps;         # break references
-        push (@psets, \%temp);
+        push (@psets, \%temp);  
+	$psets{ $temp{id} } = \%temp;
         %ps = ();
     }    
     close ABROWSE;
@@ -183,6 +189,24 @@ unless (-d '.git') { # initial import
     } else {
         die "Need to start from an import or a tag -- cannot use $psets[0]{id}";
     }
+} else {    # progressing an import
+    # load the rptags
+    opendir(DIR, ".git/archimport/tags")
+	|| die "can't opendir: $!";
+    while (my $file = readdir(DIR)) {
+	# skip non-interesting-files
+	next unless -f ".git/archimport/tags/$file";
+	next if     $file =~ m/--base-0$/; # don't care for base-0
+	my $sha = ptag($file);
+	chomp $sha;
+	# reconvert the 3rd '--' sequence from the end
+	# into a slash
+	# $file = reverse $file;
+	# $file =~ s!^(.+?--.+?--.+?--.+?)--(.+)$!$1/$2!;
+	# $file = reverse $file;
+	$rptags{$sha} = $file;
+    }
+    closedir DIR;
 }
 
 # process patchsets
@@ -345,6 +369,9 @@ foreach my $ps (@psets) {
         }
     }
     
+    if ($ps->{merges}) {
+        push @par, find_parents($ps);
+    }
     my $par = join (' ', @par);
 
     #    
@@ -391,7 +418,8 @@ foreach my $ps (@psets) {
     print " * Committed $ps->{id}\n";
     print "   + tree   $tree\n";
     print "   + commit $commitid\n";
-    # print "   + commit date is  $ps->{date} \n";
+    $opt_v && print "   + commit date is  $ps->{date} \n";
+    $opt_v && print "   + parents:  $par \n";
 }
 
 sub branchname {
@@ -556,7 +584,7 @@ sub tag {
             or die "Cannot write tag $tag: $!\n";
         close(C)
             or die "Cannot write tag $tag: $!\n";
-        print "Created tag '$tag' on '$commit'\n" if $opt_v;
+        print " * Created tag ' $tag' on '$commit'\n" if $opt_v;
     } else {                    # read
         open(C,"<.git/refs/tags/$tag")
             or die "Cannot read tag $tag: $!\n";
@@ -587,6 +615,8 @@ sub ptag {
             or die "Cannot write tag $tag: $!\n";
         close(C)
             or die "Cannot write tag $tag: $!\n";
+	$rptags{$commit} = $tag 
+	    unless $tag =~ m/--base-0$/;
     } else {                    # read
         # if the tag isn't there, return 0
         unless ( -s ".git/archimport/tags/$tag") {
@@ -599,6 +629,152 @@ sub ptag {
         die "Error reading tag $tag: $!\n" unless length $commit == 40;
         close(C)
             or die "Cannot read tag $tag: $!\n";
+	unless (defined $rptags{$commit}) {
+	    $rptags{$commit} = $tag;
+	}
         return $commit;
     }
 }
+
+sub find_parents {
+    #
+    # Identify what branches are merging into me
+    # and whether we are fully merged
+    # git-merge-base <headsha> <headsha> should tell
+    # me what the base of the merge should be 
+    #
+    my $ps = shift;
+
+    my %branches; # holds an arrayref per branch
+                  # the arrayref contains a list of
+                  # merged patches between the base
+                  # of the merge and the current head
+
+    my @parents;  # parents found for this commit
+
+    # simple loop to split the merges
+    # per branch
+    foreach my $merge (@{$ps->{merges}}) {
+	my $branch = branchname($merge);
+	unless (defined $branches{$branch} ){
+	    $branches{$branch} = [];
+	}
+	push @{$branches{$branch}}, $merge;
+    }
+
+    #
+    # foreach branch find a merge base and walk it to the 
+    # head where we are, collecting the merged patchsets that
+    # Arch has recorded. Keep that in @have
+    # Compare that with the commits on the other branch
+    # between merge-base and the tip of the branch (@need)
+    # and see if we have a series of consecutive patches
+    # starting from the merge base. The tip of the series
+    # of consecutive patches merged is our new parent for 
+    # that branch.
+    #
+    foreach my $branch (keys %branches) {
+	my $mergebase = `git-merge-base $branch $ps->{branch}`;
+	die "Cannot find merge base for $branch and $ps->{branch}" if $?;
+	chomp $mergebase;
+
+	# now walk up to the mergepoint collecting what patches we have
+	my $branchtip = git_rev_parse($ps->{branch});
+	my @ancestors = `git-rev-list --merge-order $branchtip ^$mergebase`;
+	my %have; # collected merges this branch has
+	foreach my $merge (@{$ps->{merges}}) {
+	    $have{$merge} = 1;
+	}
+	my %ancestorshave;
+	foreach my $par (@ancestors) {
+	    $par = commitid2pset($par);
+	    if (defined $par->{merges}) {
+		foreach my $merge (@{$par->{merges}}) {
+		    $ancestorshave{$merge}=1;
+		}
+	    }
+	}
+	# print "++++ Merges in $ps->{id} are....\n";
+	# my @have = sort keys %have;	print Dumper(\@have);
+
+	# merge what we have with what ancestors have
+	%have = (%have, %ancestorshave);
+
+	# see what the remote branch has - these are the merges we 
+	# will want to have in a consecutive series from the mergebase
+	my $otherbranchtip = git_rev_parse($branch);
+	my @needraw = `git-rev-list --merge-order $otherbranchtip ^$mergebase`;
+	my @need;
+	foreach my $needps (@needraw) { 	# get the psets
+	    $needps = commitid2pset($needps);
+	    # git-rev-list will also
+	    # list commits merged in via earlier 
+	    # merges. we are only interested in commits
+	    # from the branch we're looking at
+	    if ($branch eq $needps->{branch}) {
+		push @need, $needps->{id};
+	    }
+	}
+
+	# print "++++ Merges from $branch we want are....\n";
+	# print Dumper(\@need);
+
+	my $newparent;
+	while (my $needed_commit = pop @need) {
+	    if ($have{$needed_commit}) {
+		$newparent = $needed_commit;
+	    } else {
+		last; # break out of the while
+	    }
+	}
+	if ($newparent) {
+	    push @parents, $newparent;
+	}
+
+
+    } # end foreach branch
+
+    # prune redundant parents
+    my %parents;
+    foreach my $p (@parents) {
+	$parents{$p} = 1;
+    }
+    foreach my $p (@parents) {
+	next unless exists $psets{$p}{merges};
+	next unless ref    $psets{$p}{merges};
+	my @merges = @{$psets{$p}{merges}};
+	foreach my $merge (@merges) {
+	    if ($parents{$merge}) { 
+		delete $parents{$merge};
+	    }
+	}
+    }
+    @parents = keys %parents;
+    @parents = map { " -p " . ptag($_) } @parents;
+    return @parents;
+}
+
+sub git_rev_parse {
+    my $name = shift;
+    my $val  = `git-rev-parse $name`;
+    die "Error: git-rev-parse $name" if $?;
+    chomp $val;
+    return $val;
+}
+
+# resolve a SHA1 to a known patchset
+sub commitid2pset {
+    my $commitid = shift;
+    chomp $commitid;
+    my $name = $rptags{$commitid} 
+	|| die "Cannot find reverse tag mapping for $commitid";
+    # the keys in %rptag  are slightly munged; unmunge
+    # reconvert the 3rd '--' sequence from the end
+    # into a slash
+    $name = reverse $name;
+    $name =~ s!^(.+?--.+?--.+?--.+?)--(.+)$!$1/$2!;
+    $name = reverse $name;
+    my $ps   = $psets{$name} 
+	|| (print Dumper(sort keys %psets)) && die "Cannot find patchset for $name";
+    return $ps;
+}
