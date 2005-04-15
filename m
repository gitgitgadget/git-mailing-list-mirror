From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] merge-trees script for Linus git
Date: Fri, 15 Apr 2005 14:48:47 -0700
Message-ID: <7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 23:46:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMYdk-0004SS-HE
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 23:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVDOVtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 17:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVDOVti
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 17:49:38 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19114 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261943AbVDOVst (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 17:48:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415214849.OMDF7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 17:48:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 15 Apr 2005 13:10:16 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

    what you have in 461aef08823a18a6c69d472499ef5257f8c7f6c8 is fine
by me for the essential support for merge-trees (sorry for the
confusing name, but this is a stop-gap Q&D script until I do the real
merge-tree.c conversion).

This patch contains the merge-trees script itself and Makefile entry
for it.  I have some more fixes to merge-trees in the works but that
will follow later.

I have an optional patch to add '-q' option to show-diff so that
complaints for missing files can be squelched, which I will be sending
you in a separate message.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile    |    2 
 merge-trees |  302 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 303 insertions(+), 1 deletion(-)

Makefile:  b39b4ea37586693dd707d1d0750a9b580350ec50
--- Makefile
+++ Makefile	2005-04-15 13:32:06.000000000 -0700
@@ -14,7 +14,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-tree
+	check-files ls-tree merge-tree merge-trees
 
 all: $(PROG)
 

--- /dev/null	2005-03-19 15:28:25.000000000 -0800
+++ merge-trees	2005-04-15 13:32:20.000000000 -0700
@@ -0,0 +1,302 @@
+#!/usr/bin/perl -w
+
+use strict;
+use Cwd;
+use Getopt::Long;
+
+my $full_checkout = 0;
+my $partial_checkout = 0;
+my $output_directory = ',,merge~tree';
+
+GetOptions("full-checkout" => \$full_checkout,
+	   "partial-checkout" => \$partial_checkout,
+	   "output-directory=s" => \$output_directory)
+    or die;
+
+
+if (@ARGV != 3) {
+    die "Usage: $0 -o [output-directory] [-f] [-p] ancestor A B\n";
+}
+
+if ($full_checkout) {
+    $partial_checkout = 1;
+}
+
+################################################################
+# UI helper -- although it is encouraged to give tree ID, 
+# it is OK to give commit ID.
+sub possibly_commit_to_tree {
+    my ($commit_or_tree_id) = @_;
+    my $type = read_cat_file_t($commit_or_tree_id);
+    if ($type eq 'tree') { return $commit_or_tree_id }
+    if ($type ne 'commit') {
+	die "Tree ID (or commit ID) required, given $type.";
+    }
+
+    my ($fhi);
+    open $fhi, '-|', 'cat-file', 'commit', $commit_or_tree_id
+	or die "$!: cat-file commit $commit_or_tree_id";
+    my ($tree) = <$fhi>;
+    close $fhi;
+    ($tree =~ s/^tree (.*)$/$1/)
+	or die "$tree: Linus says the first line is guaranteed to be tree.";
+    return $tree;
+}
+
+sub read_cat_file_t {
+    my ($id) = @_;
+    my ($fhi);
+    open $fhi, '-|', 'cat-file', '-t', $id
+	or die "$!: cat-file -t $id";
+    my ($t) = <$fhi>;
+    close $fhi;
+    chomp($t);
+    return $t;
+}
+
+################################################################
+# Reads diff-tree -r output and gives a hash that maps a path
+# to 4-tuple (old-mode new-mode old-oid new-oid).
+# When creating, old-* are undef.  When removing, new-* are undef.
+
+sub OLD_MODE () { 0 }
+sub NEW_MODE () { 1 }
+sub OLD_OID ()  { 2 }
+sub NEW_OID ()  { 3 }
+
+sub read_diff_tree {
+    my (@tree) = @_;
+    my ($fhi);
+
+    # Regular expression piece for mode
+    my $reM  = '[0-7]+';
+
+    # Regular expression piece for object ID.
+    # There is a talk about base-64 so better make it easier to modify...
+    my $reID = '[0-9a-f]{40}';
+
+    local ($_, $/);
+    $/ = "\0"; 
+    my %path;
+    open $fhi, '-|', 'diff-tree', '-r', @tree
+	or die "$!: diff-tree -r @tree";
+    while (<$fhi>) {
+	chomp;
+	if (/^\*($reM)->($reM)\tblob\t($reID)->($reID)\t(.*)$/so) {
+	    $path{$5} = [$1, $2, $3, $4]; # modified
+	}
+	elsif (/^\+($reM)\tblob\t($reID)\t(.*)$/so) {
+	    $path{$3} = [undef, $1, undef, $2]; # added
+	}
+	elsif (/^\-($reM)\tblob\t($reID)\t(.*)$/so) {
+	    $path{$3} = [$1, undef, $2, undef]; # deleted
+	}
+	else {
+	    die "cannot parse diff-tree output: $_";
+	}
+    }
+    close $fhi;
+    return %path;
+}
+
+################################################################
+# Read show-files output to figure out the set of files contained
+# in the tree.  This is used to figure out what ancestor had.
+sub read_show_files {
+    my ($fhi);
+    local ($_, $/);
+    $/ = "\0"; 
+    open $fhi, '-|', 'show-files', '-z', '--cached'
+	or die "$!: show-files -z --cached";
+    my (@path) = map { chomp; $_ } <$fhi>;
+    close $fhi;
+    return @path;
+}
+
+################################################################
+# Given path and info (typically returned from read_diff_tree),
+# create the file in the working directory to match the NEW tree.
+# This does not touch dircache.
+sub checkout_file {
+    my ($path, $info) = @_;
+    my (@elt) = split(/\//, $path);
+    my $j = '';
+    my $tail = pop @elt;
+    my ($fhi, $fho);
+    for (@elt) {
+	mkdir "$j$_";
+	$j = "$j$_/";
+    }
+    open $fho, '>', "$path";
+    open $fhi, '-|', 'cat-file', 'blob', $info->[NEW_OID]
+	or die "$!: cat-file blob $info->[NEW_OID]";
+    while (<$fhi>) {
+	print $fho $_;
+    }
+    close $fhi;
+    close $fho;
+    chmod oct("0$info->[NEW_MODE]"), "$path";
+}
+
+################################################################
+# Given path and info record the file in the dircache without
+# affecting working directory.
+sub record_file {
+    my ($path, $info) = @_;
+    system ('update-cache', '--add', '--cacheinfo',
+	    $info->[NEW_MODE], $info->[NEW_OID], $path);
+}
+
+################################################################
+# Merge info from two trees and leave it in path, without
+# affecting dircache.
+sub merge_tree {
+    my ($path, $infoA, $infoB) = @_;
+    checkout_file("$path~A~", $infoA);
+    checkout_file("$path~B~", $infoB);
+    system 'checkout-cache', $path;
+    rename $path, "$path~O~";
+    my ($fhi, $fho);
+    open $fhi, '-|', 'merge', '-p', "$path~A~", "$path~O~", "$path~B~";
+    open $fho, '>', $path;
+    local ($/);
+    while (<$fhi>) { print $fho $_; }
+    close $fhi;
+    close $fho;
+    # There is no reason to prefer infoA over infoB but
+    # we need to pick one.
+    chmod oct("0$infoA->[NEW_MODE]"), $path;
+}
+
+################################################################
+
+# O stands for "the original".  A and B are being merged.
+my ($treeO, $treeA, $treeB) = map { possibly_commit_to_tree $_ } @ARGV;
+
+# Create a temporary directory and go there.
+system('rm', '-rf', $output_directory) == 0 &&
+system('mkdir', '-p', "$output_directory/.git") == 0 &&
+symlink(Cwd::getcwd . "/.git/objects", "$output_directory/.git/objects") &&
+chdir $output_directory &&
+system('read-tree', $treeO) == 0
+    or die "$!: Failed to set up merge working area $output_directory";
+
+# Find out edits done in each branch.
+my %treeA = read_diff_tree($treeO, $treeA);
+my %treeB = read_diff_tree($treeO, $treeB);
+
+# The list of files that was in the ancestor.
+my @ancestor_file = read_show_files();
+my %ancestor_file = map { $_ => 1 } @ancestor_file;
+
+# Report output is formated as follows:
+#
+# The first letter shows the origin of the result.
+#   O - original
+#   A - treeA
+#   B - treeB
+#   M - both treeA and treeB
+#   * - treeA and treeB conflicts; needs human action.
+#
+# The second and third letter shows what each tree did.
+#   . - no change
+#   A - created
+#   M - modified
+#   D - deleted
+
+for (@ancestor_file) {
+    if (! exists $treeA{$_} && ! exists $treeB{$_}) {
+	if ($full_checkout) {
+	    system 'checkout-cache', $_;
+	}
+	print STDERR "O.. $_\n"; # keep original
+    }
+}
+
+for my $set ([\%treeA, \%treeB, 'A'], [\%treeB, \%treeA, 'B']) {
+    my ($this, $other, $side) = @$set;
+    my $delete_sign = ($side eq 'A') ? 'D.' : '.D';
+    my $create_sign = ($side eq 'A') ? 'A.' : '.A';
+    my $modify_sign = ($side eq 'A') ? 'M.' : '.M';
+    while (my ($path, $info) = each %$this) {
+	# In this loop we do not deal with overlaps.
+	next if (exists $other->{$path});
+
+	if (! defined $info->[NEW_OID]) {
+	    # deleted in this tree only.
+	    unlink $path;
+	    system 'update-cache', '--remove', $path;
+	    print STDERR "${side}${delete_sign} $path\n";
+	}
+	else {
+	    # modified or created in this tree only.
+	    my $create_or_modify =
+		(! defined $info->[OLD_OID]) ? $create_sign : $modify_sign;
+	    print STDERR "${side}${create_or_modify} $path\n";
+	    if ($partial_checkout) {
+		checkout_file($path, $info);
+		system 'update-cache', '--add', $path;
+	    } else {
+		record_file($path, $info);
+	    }
+	}
+    }
+}
+
+my @warning = ();
+
+while (my ($path, $infoA) = each %treeA) {
+    # We need to deal only with overlaps.
+    next if (!exists $treeB{$path});
+
+    my $infoB = $treeB{$path};
+    if (! defined $infoA->[NEW_OID]) {
+	# Deleted in tree A.
+	if (! defined $infoB->[NEW_OID]) {
+	    # Deleted in both trees (obvious).
+	    print STDERR "MDD $path\n";
+	    unlink $path;
+	    system 'update-cache', '--remove', $path;
+	}
+	else {
+	    # TreeA wants to remove but TreeB wants to modify it.
+	    print STDERR "*DM $path\n";
+	    checkout_file("$path~B~", $infoB);
+	    push @warning, $path;
+	}
+    }
+    else {
+	# Modified or created in tree A
+	if (! defined $infoB->[NEW_OID]) {
+	    # TreeA wants to modify but treeB wants to remove it.
+	    print STDERR "*MD $path\n";
+	    checkout_file("$path~A~", $infoA);
+	    push @warning, $path;
+	}
+	else {
+	    # Modified both in treeA and treeB.
+	    # Are they modifying to the same contents?
+	    if ($infoA->[NEW_OID] eq $infoB->[NEW_OID]) {
+		# No changes or just the mode.
+		# we prefer TreeA over TreeB for no particular reason.
+		print STDERR "MMM $path\n";
+		record_file($path, $infoA);
+	    }
+	    else {
+		# Modified in both.  Needs merge.
+		print STDERR "*MM $path\n";
+		merge_tree($path, $infoA, $infoB);
+	    }
+	}
+    }
+}
+
+if (@warning) {
+    print "\nThere are some files that were deleted in one branch and\n"
+	. "modified in another.  Please examine them carefully:\n";
+    for (@warning) {
+	print "$_\n";
+    }
+}
+
+# system 'show-diff', '-q';

