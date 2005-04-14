From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 04:14:13 -0700
Message-ID: <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
References: <20050414002902.GU25711@pasky.ji.cz>
	<20050413212546.GA17236@64m.dyndns.org>
	<20050414004504.GW25711@pasky.ji.cz>
	<Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 13:12:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM2GG-0006Vp-Fc
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 13:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVDNLO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 07:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVDNLO7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 07:14:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:30112 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261328AbVDNLOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 07:14:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050414111415.PDRF7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Apr 2005 07:14:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 14 Apr 2005 02:10:22 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is a diff to update the git-merge.perl script I showed you
earlier today ;-).  It contains the following updates against
your HEAD (bb95843a5a0f397270819462812735ee29796fb4).

 * git-merge.perl command we talked about on the git list.  I've
   covered the changed-to-the-same case etc.  I still haven't done
   anything about file-vs-directory case yet.

   It does warn when it needed to run merge to automerge and let
   merge give a warning message about conflicts if any.  In
   modify/remove cases, modified in one but removed in the other
   files are left in either $path~A~ or $path~B~ in the merge
   temporary directory, and the script issues a warning at the
   end.

 * show-files and ls-tree updates to add -z flag to NUL terminate records;
   this is needed for git-merge.perl to work.

 * show-diff updates to add -r flag to squelch diffs for files not in
   the working directory.  This is mainly useful when verifying the
   result of an automated merge.

 * update-cache updates to add "--cacheinfo mode sha1" flag to register
   a file that is not in the current working directory.  Needed for
   minimum-checkout merging by git-merge.perl.


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-merge.perl |  247 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ls-tree.c      |    9 +-
 show-diff.c    |   11 +-
 show-files.c   |   12 ++
 update-cache.c |   25 +++++
 5 files changed, 296 insertions(+), 8 deletions(-)

diff -x .git -Nru ,,1/git-merge.perl ,,2/git-merge.perl
--- ,,1/git-merge.perl	1969-12-31 16:00:00.000000000 -0800
+++ ,,2/git-merge.perl	2005-04-14 04:00:14.000000000 -0700
@@ -0,0 +1,247 @@
+#!/usr/bin/perl -w
+
+use Getopt::Long;
+
+my $full_checkout = 0;
+my $oneside_checkout = 0;
+GetOptions("full" => \$full_checkout,
+	   "oneside" => \$oneside_checkout)
+    or die;
+
+if ($full_checkout) {
+    $oneside_checkout = 1;
+}
+
+sub read_rev_tree {
+    my (@head) = @_;
+    my ($fhi);
+    open $fhi, '-|', 'rev-tree', '--edges', @head
+	or die "$!: rev-tree --edges @head";
+    my %common;
+    while (<$fhi>) {
+	chomp;
+	(undef, undef, my @common) = split(/ /, $_);
+	for (@common) {
+	    if (s/^([a-f0-f]{40}):3$/$1/) {
+		$common{$_}++;
+	    }
+	}
+    }
+    close $fhi;
+
+    my @common = (map { $_->[1] }
+		  sort { $b->[0] <=> $a->[0] }
+		  map { [ $common{$_} => $_ ] }
+		  keys %common);
+
+    return $common[0];
+}
+
+sub read_commit_tree {
+    my ($commit) = @_;
+    my ($fhi);
+    open $fhi, '-|', 'cat-file', 'commit', $commit
+	or die "$!: cat-file commit $commit";
+    my $tree = <$fhi>;
+    close $fhi;
+    $tree =~ s/^tree //;
+    return $tree;
+}
+
+# Reads diff-tree -r output and gives a hash that maps a path
+# to 3-tuple (old-mode new-mode new-sha).
+# When creating, old-mode is undef.  When removing, new-* are undef.
+sub read_diff_tree {
+    my (@tree) = @_;
+    my ($fhi);
+    local ($_, $/);
+    $/ = "\0"; 
+    my %path;
+    open $fhi, '-|', 'diff-tree', '-r', @tree
+	or die "$!: diff-tree -r @tree";
+    while (<$fhi>) {
+	chomp;
+	if (/^\*([0-7]+)->([0-7]+)\tblob\t[0-9a-f]+->([0-9a-f]{40})\t(.*)$/s) {
+	    $path{$4} = [$1, $2, $3];
+	}
+	elsif (/^\+([0-7]+)\tblob\t([0-9a-f]{40})\t(.*)$/s) {
+	    $path{$3} = [undef, $1, $2];
+	}
+	elsif (/^\-([0-7]+)\tblob\t[0-9a-f]{40}\t(.*)$/s) {
+	    $path{$2} = [$1, undef, undef];
+	}
+	else {
+	    die "cannot parse diff-tree output: $_";
+	}
+    }
+    close $fhi;
+    return %path;
+}
+
+sub read_show_files {
+    my ($fhi);
+    local ($_, $/);
+    $/ = "\0"; 
+    open $fhi, '-|', 'show-files', '-z'
+	or die "$!: show-files -z";
+    my (@path) = map { chomp; $_ } <$fhi>;
+    close $fhi;
+    return @path;
+}
+
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
+    open $fhi, '-|', 'cat-file', 'blob', $info->[2]
+	or die "$!: cat-file blob $info->[2]";
+    while (<$fhi>) {
+	print $fho $_;
+    }
+    close $fhi;
+    close $fho;
+    chmod oct("0$info->[1]"), "$path";
+}
+
+sub record_file {
+    my ($path, $info) = @_;
+    system ('update-cache', '--add', '--cacheinfo',
+	    $info->[1], $info->[2], $path);
+}
+
+sub merge_tree {
+    my ($path, $info0, $info1) = @_;
+    checkout_file(',,merge-0', $info0);
+    checkout_file(',,merge-1', $info1);
+    system 'checkout-cache', $path;
+    my ($fhi, $fho);
+    open $fhi, '-|', 'merge', '-p', ',,merge-0', $path, ',,merge-1';
+    open $fho, '>', "$path+";
+    local ($/);
+    while (<$fhi>) { print $fho $_; }
+    close $fhi;
+    close $fho;
+    unlink ',,merge-0', ',,merge-1';
+    rename "$path+", $path;
+    # There is no reason to prefer info0 over info1 but
+    # we need to pick one.
+    chmod oct("0$info0->[1]"), "$path";
+}
+
+# Find common ancestor of two trees.
+my $common = read_rev_tree(@ARGV);
+print "Common ancestor: $common\n";
+
+# Create a temporary directory and go there.
+system 'rm', '-rf', ',,merge-temp';
+for ((',,merge-temp', '.git')) { mkdir $_; chdir $_; }
+symlink "../../.git/objects", "objects";
+chdir '..';
+
+my $ancestor_tree = read_commit_tree($common);
+system 'read-tree', $ancestor_tree;
+
+my %tree0 = read_diff_tree($ancestor_tree, read_commit_tree($ARGV[0]));
+my %tree1 = read_diff_tree($ancestor_tree, read_commit_tree($ARGV[1]));
+
+my @ancestor_file = read_show_files();
+my %ancestor_file = map { $_ => 1 } @ancestor_file;
+
+for (@ancestor_file) {
+    if (! exists $tree0{$_} && ! exists $tree1{$_}) {
+	if ($full_checkout) {
+	    system 'checkout-cache', $_;
+	}
+	print STDERR "O - $_\n";
+    }
+}
+
+for my $set ([\%tree0, \%tree1, 'A'], [\%tree1, \%tree0, 'B']) {
+    my ($treeA, $treeB, $side) = @$set;
+    while (my ($path, $info) = each %$treeA) {
+	# In this loop we do not deal with overlaps.
+	next if (exists $treeB->{$path});
+
+	if (! defined $info->[1]) {
+	    # deleted in this tree only.
+	    unlink $path;
+	    system 'update-cache', '--remove', $path;
+	    print STDERR "$side D $path\n";
+	}
+	else {
+	    # modified or created in this tree only.
+	    print STDERR "$side M $path\n";
+	    if ($oneside_checkout) {
+		checkout_file($path, $info);
+		system 'update-cache', '--add', "$path";
+	    } else {
+		record_file($path, $info);
+	    }
+	}
+    }
+}
+
+my @warning = ();
+
+while (my ($path, $info0) = each %tree0) {
+    # We need to deal only with overlaps.
+    next if (!exists $tree1{$path});
+
+    my $info1 = $tree1{$path};
+    if (! defined $info0->[1]) {
+	# deleted in this tree.
+	if (! defined $info1->[1]) {
+	    # deleted in both trees.  Obvious.
+	    print STDERR "*DD $path\n";
+	    unlink $path;
+	    system 'update-cache', '--remove', $path;
+	}
+	else {
+	    # oops.  tree0 wants to remove but tree1 wants to modify it.
+	    print STDERR "*DM $path\n";
+	    checkout_file("$path~B~", $info1);
+	    push @warning, $path;
+	}
+    }
+    else {
+	# modified or created in tree0
+	if (! defined $info1->[1]) {
+	    # oops.  tree0 wants to modify but tree1 wants to remove it.
+	    print STDERR "*MD $path\n";
+	    checkout_file("$path~A~", $info0);
+	    push @warning, $path;
+	}
+	else {
+	    # modified both in tree0 and tree1
+	    # are they modifying to the same contents?
+	    if ($info0->[2] eq $info1->[2]) {
+		# just mode changes (or no changes)
+		# we prefer tree0 over tree1 for no particular reason.
+		print STDERR "*MM $path\n";
+		record_file($path, $info0);
+	    }
+	    else {
+		# modified in both.  Needs merge.
+		print STDERR "MRG $path\n";
+		merge_tree($path, $info0, $info1);
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
+# system 'show-diff';


diff -x .git -Nru ,,1/ls-tree.c ,,2/ls-tree.c
--- ,,1/ls-tree.c	2005-04-14 03:47:18.000000000 -0700
+++ ,,2/ls-tree.c	2005-04-14 04:00:14.000000000 -0700
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 
+int line_termination = '\n';
+
 static int list(unsigned char *sha1)
 {
 	void *buffer;
@@ -31,7 +33,8 @@
 		 * It seems not worth it to read each file just to get this
 		 * and the file size. -- pasky@ucw.cz */
 		type = S_ISDIR(mode) ? "tree" : "blob";
-		printf("%03o\t%s\t%s\t%s\n", mode, type, sha1_to_hex(sha1), path);
+		printf("%03o\t%s\t%s\t%s%c", mode, type, sha1_to_hex(sha1),
+		       path, line_termination);
 	}
 	return 0;
 }
@@ -40,6 +43,10 @@
 {
 	unsigned char sha1[20];
 
+	if (argc == 3 && !strcmp(argv[1], "-z")) {
+	  line_termination = 0;
+	  argc--; argv++;
+	}
 	if (argc != 2)
 		usage("ls-tree <key>");
 	if (get_sha1_hex(argv[1], sha1) < 0)


diff -x .git -Nru ,,1/show-diff.c ,,2/show-diff.c
--- ,,1/show-diff.c	2005-04-14 03:47:18.000000000 -0700
+++ ,,2/show-diff.c	2005-04-14 04:00:14.000000000 -0700
@@ -58,15 +58,20 @@
 int main(int argc, char **argv)
 {
 	int silent = 0;
+	int silent_on_nonexisting_files = 0;
 	int entries = read_cache();
 	int i;
 
 	while (argc-- > 1) {
 		if (!strcmp(argv[1], "-s")) {
-			silent = 1;
+			silent_on_nonexisting_files = silent = 1;
 			continue;
 		}
-		usage("show-diff [-s]");
+		if (!strcmp(argv[1], "-r")) {
+			silent_on_nonexisting_files = 1;
+			continue;
+		}
+		usage("show-diff [-s] [-r]");
 	}
 
 	if (entries < 0) {
@@ -83,7 +88,7 @@
 
 		if (stat(ce->name, &st) < 0) {
 			printf("%s: %s\n", ce->name, strerror(errno));
-			if (errno == ENOENT && !silent)
+			if (errno == ENOENT && !silent_on_nonexisting_files)
 				show_diff_empty(ce);
 			continue;
 		}


diff -x .git -Nru ,,1/show-files.c ,,2/show-files.c
--- ,,1/show-files.c	2005-04-14 03:47:18.000000000 -0700
+++ ,,2/show-files.c	2005-04-14 04:00:14.000000000 -0700
@@ -14,6 +14,7 @@
 static int show_cached = 0;
 static int show_others = 0;
 static int show_ignored = 0;
+static int line_terminator = '\n';
 
 static const char **dir;
 static int nr_dir;
@@ -105,12 +106,12 @@
 	}
 	if (show_others) {
 		for (i = 0; i < nr_dir; i++)
-			printf("%s\n", dir[i]);
+			printf("%s%c", dir[i], line_terminator);
 	}
 	if (show_cached) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			printf("%s\n", ce->name);
+			printf("%s%c", ce->name, line_terminator);
 		}
 	}
 	if (show_deleted) {
@@ -119,7 +120,7 @@
 			struct stat st;
 			if (!stat(ce->name, &st))
 				continue;
-			printf("%s\n", ce->name);
+			printf("%s%c", ce->name, line_terminator);
 		}
 	}
 	if (show_ignored) {
@@ -134,6 +135,11 @@
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
+		if (!strcmp(arg, "-z")) {
+			line_terminator = 0;
+			continue;
+		}
+
 		if (!strcmp(arg, "--cached")) {
 			show_cached = 1;
 			continue;


diff -x .git -Nru ,,1/update-cache.c ,,2/update-cache.c
--- ,,1/update-cache.c	2005-04-14 03:47:18.000000000 -0700
+++ ,,2/update-cache.c	2005-04-14 04:00:14.000000000 -0700
@@ -250,6 +250,8 @@
 {
 	int i, newfd, entries;
 	int allow_options = 1;
+	const char *sha1_force = NULL;
+	const char *mode_force = NULL;
 
 	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0)
@@ -282,14 +284,35 @@
 				refresh_cache();
 				continue;
 			}
+			if (!strcmp(path, "--cacheinfo")) {
+				mode_force = argv[++i];
+				sha1_force = argv[++i];
+				continue;
+			}
 			die("unknown option %s", path);
 		}
 		if (!verify_path(path)) {
 			fprintf(stderr, "Ignoring path %s\n", argv[i]);
 			continue;
 		}
-		if (add_file_to_cache(path))
+		if (sha1_force && mode_force) {
+			struct cache_entry *ce;
+			int namelen = strlen(path);
+			int mode;
+			int size = cache_entry_size(namelen);
+			sscanf(mode_force, "%o", &mode);
+			ce = malloc(size);
+			memset(ce, 0, size);
+			memcpy(ce->name, path, namelen);
+			ce->namelen = namelen;
+			ce->st_mode = mode;
+			get_sha1_hex(sha1_force, ce->sha1);
+
+			add_cache_entry(ce, 1);
+		}
+		else if (add_file_to_cache(path))
 			die("Unable to add %s to database", path);
+		mode_force = sha1_force = NULL;
 	}
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    rename(".git/index.lock", ".git/index"))

