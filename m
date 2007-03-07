From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: [PATCH, 2nd version] git-archimport: allow remapping branch names
Date: Wed, 07 Mar 2007 09:13:54 +0100
Message-ID: <45EE7442.6030308@lu.unisi.ch>
References: <eslrcr$9rc$1@sea.gmane.org> <7vodn5iiew.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 09:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOrHk-00054f-QL
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 09:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbXCGIOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 03:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbXCGIOF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 03:14:05 -0500
Received: from server.usilu.net ([195.176.178.200]:30435 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964989AbXCGIOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 03:14:04 -0500
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Mar 2007 09:13:59 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vodn5iiew.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 07 Mar 2007 08:13:59.0753 (UTC) FILETIME=[8F352390:01C76090]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41656>

This patch add support to archimport for remapping the branch names
to match those used in git more closely.  This is useful for
projects that *migrate* to git (as opposed to users that want
to use git on Arch-based projects).  For example, one can
choose a branch name and call it "master".

The new command-line syntax works even if there is a colon in
a branch name, since only the part after the last colon is taken
to be the git name (git does not allow colons in branch names).

The new feature is implemented so that archives rotated every
year can also be remapped into a single git archive.
---
 Documentation/git-archimport.txt |   19 +++++++-
 git-archimport.perl              |   86 ++++++++++++++++++++++++++++----------
 2 files changed, 81 insertions(+), 24 deletions(-)

	> I am no arch/tla expert, but at least git does not allow colon
	> in branch names at all, so if you make your command line parser
	> to match left-greedy-anything, colon and then right-non-colon
	> (i.e. m/^(.*):([^:]*)$/), you should be able to handle colons in
	> arch archive names.
	
	Great idea.  Thanks.  By the way, this patch was tested on
	my Arch repositories.


diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index 5a13187..5794928 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D depth] [-t tempdir]
-               <archive/branch> [ <archive/branch> ]
+               <archive/branch>[:<git-branch>] ...
 
 DESCRIPTION
 -----------
@@ -39,6 +39,19 @@ directory. To follow the development of a project that uses Arch, rerun
 `git-archimport` with the same parameters as the initial import to perform 
 incremental imports.
 
+While git-archimport will try to create sensible branch names for the
+archives that it imports, it is also possible to specify git branch names
+manually.  To do so, write a git branch name after each <archive/branch>
+parameter, separated by a colon.  This way, you can shorten the Arch
+branch names and convert Arch jargon to git jargon, for example mapping a
+"PROJECT--devo--VERSION" branch to "master".
+
+Associating multiple Arch branches to one git branch is possible; the
+result will make the most sense only if no commits are made to the first
+branch, after the second branch is created.  Still, this is useful to
+convert Arch repositories that had been rotated periodically.
+
+
 MERGES
 ------
 Patch merge data from Arch is used to mark merges in git as well. git 
@@ -73,7 +86,9 @@ OPTIONS
 	Use this for compatibility with old-style branch names used by
 	earlier versions of git-archimport.  Old-style branch names
 	were category--branch, whereas new-style branch names are
-	archive,category--branch--version.
+	archive,category--branch--version.  In both cases, names given
+	on the command-line will override the automatically-generated
+        ones.
 
 -D <depth>::
 	Follow merge ancestry and attempt to import trees that have been
diff --git a/git-archimport.perl b/git-archimport.perl
index 0fcb156..1044695 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -89,7 +89,11 @@ usage if $opt_h;
 # values associated with keys:
 #   =1 - Arch version / git 'branch' detected via abrowse on a limit
 #   >1 - Arch version / git 'branch' of an auxiliary branch we've merged
-my %arch_branches = map { $_ => 1 } @ARGV;
+my %arch_branches = map { my $branch = $_; $branch =~ s/:.*//; $branch => 1 } @ARGV;
+
+# $branch_name_map:
+# maps arch branches to git branch names
+my %branch_name_map = map { m/^(.*):([^:]*)$/; $1 => $2 } grep { m/:/ } @ARGV;
 
 $ENV{'TMPDIR'} = $opt_t if $opt_t; # $ENV{TMPDIR} will affect tempdir() calls:
 my $tmp = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
@@ -104,6 +108,7 @@ unless (-d $git_dir) { # initial import needs empty directory
     closedir DIR
 }
 
+my $default_archive;		# default Arch archive
 my %reachable = ();             # Arch repositories we can access
 my %unreachable = ();           # Arch repositories we can't access :<
 my @psets  = ();                # the collection
@@ -303,7 +308,34 @@ sub old_style_branchname {
     return $ret;
 }
 
-*git_branchname = $opt_o ? *old_style_branchname : *tree_dirname;
+*git_default_branchname = $opt_o ? *old_style_branchname : *tree_dirname;
+
+# retrieve default archive, since $branch_name_map keys might not include it
+sub get_default_archive {
+    if (!defined $default_archive) {
+        $default_archive = safe_pipe_capture($TLA,'my-default-archive');
+        chomp $default_archive;
+    }
+    return $default_archive;
+}
+
+sub git_branchname {
+    my $revision = shift;
+    my $name = extract_versionname($revision);
+
+    if (defined $branch_name_map{$name}) {
+	return $branch_name_map{$name};
+
+    } elsif ($name =~ m#^([^/]*)/(.*)$#
+	     && $1 eq get_default_archive()
+	     && defined $branch_name_map{$2}) {
+	# the names given in the command-line lacked the archive.
+	return $branch_name_map{$2};
+
+    } else {
+	return git_default_branchname($revision);
+    }
+}
 
 sub process_patchset_accurate {
     my $ps = shift;
@@ -333,19 +365,23 @@ sub process_patchset_accurate {
         if ($ps->{tag} && (my $branchpoint = eval { ptag($ps->{tag}) })) {
             
             # find where we are supposed to branch from
-            system('git-checkout','-f','-b',$ps->{branch},
-                            $branchpoint) == 0 or die "$! $?\n";
-            
+	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
+		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
+
+		# We trust Arch with the fact that this is just a tag,
+		# and it does not affect the state of the tree, so
+		# we just tag and move on.  If the user really wants us
+		# to consolidate more branches into one, don't tag because
+		# the tag name would be already taken.
+		tag($ps->{id}, $branchpoint);
+		ptag($ps->{id}, $branchpoint);
+		print " * Tagged $ps->{id} at $branchpoint\n";
+	    }
+	    system('git-checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
+
             # remove any old stuff that got leftover:
             my $rm = safe_pipe_capture('git-ls-files','--others','-z');
             rmtree(split(/\0/,$rm)) if $rm;
-
-            # If we trust Arch with the fact that this is just 
-            # a tag, and it does not affect the state of the tree
-            # then we just tag and move on
-            tag($ps->{id}, $branchpoint);
-            ptag($ps->{id}, $branchpoint);
-            print " * Tagged $ps->{id} at $branchpoint\n";
             return 0;
         } else {
             warn "Tagging from unknown id unsupported\n" if $ps->{tag};
@@ -385,14 +421,19 @@ sub process_patchset_fast {
                 unless $branchpoint;
             
             # find where we are supposed to branch from
-            system('git-checkout','-b',$ps->{branch},$branchpoint);
-
-            # If we trust Arch with the fact that this is just 
-            # a tag, and it does not affect the state of the tree
-            # then we just tag and move on
-            tag($ps->{id}, $branchpoint);
-            ptag($ps->{id}, $branchpoint);
-            print " * Tagged $ps->{id} at $branchpoint\n";
+	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
+		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
+
+		# We trust Arch with the fact that this is just a tag,
+		# and it does not affect the state of the tree, so
+		# we just tag and move on.  If the user really wants us
+		# to consolidate more branches into one, don't tag because
+		# the tag name would be already taken.
+		tag($ps->{id}, $branchpoint);
+		ptag($ps->{id}, $branchpoint);
+		print " * Tagged $ps->{id} at $branchpoint\n";
+            }
+            system('git-checkout',$ps->{branch}) == 0 or die "$! $?\n";
             return 0;
         } 
         die $! if $?;
@@ -830,8 +871,9 @@ sub tag {
     if ($opt_o) {
         $tag =~ s|/|--|g;
     } else {
-        # don't use subdirs for tags yet, it could screw up other porcelains
-        $tag =~ s|/|,|g;
+	my $patchname = $tag;
+	$patchname =~ s/.*--//;
+        $tag = git_branchname ($tag) . '--' . $patchname;
     }
     
     if ($commit) {
-- 
1.4.4.2
