From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 00:05:42 -0700
Message-ID: <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
References: <20050414002902.GU25711@pasky.ji.cz>
	<20050413212546.GA17236@64m.dyndns.org>
	<20050414004504.GW25711@pasky.ji.cz>
	<Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Christopher Li <git@chrisli.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 09:03:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLyNV-00029t-64
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 09:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVDNHGW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 03:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVDNHGW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 03:06:22 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45286 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261444AbVDNHFo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 03:05:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050414070544.SNNZ22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Apr 2005 03:05:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 13 Apr 2005 20:51:50 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On that note - I've been avoiding doing the merge-tree thing, in the hope 
LT> that somebody else does what I've described.

I now have a Perl script that uses rev-tree, cat-file,
diff-tree, show-files (with one modification so that it can deal
with pathnames with embedded newlines), update-cache (with one
modification so that I can add an entry for a file that does not
exist to the dircache) and merge (from RCS).  Quick and dirty.

The changes to show-files is to give it an optional '-z' flag,
which chanegs record terminator to NUL character instead of LF.

The script git-merge.perl takes two head commits.  It basically
follows what you described as I remember ;-):

 1. runs rev-tree with --edges to find the common anscestor.

 2. creates a temporary directory "./,,merge-temp"; create a
    symlink ./,,merge-temp/.git/objects that points at
    .git/objects.

 3. sets up dircache there, initially populated with this common
    ancestor tree.  No files are checked out.  Just set up
    .git/index and that's it.

 4. runs diff-tree to find what has been changed in each head.

 5. for each path involved:

  5.0 if neither heads change it, leave it as is;
  5.1 if only one head changes a path and the other does not, just
      get the changed version;
  5.2 if both heads change it, check all three out and run merge.

It does not currently commit.  You can go to ./,,merge-temp/ and
see show-diff to see the result of the merge.  Files added in
one head has already been run "update-cache" when the script
ends, but changed and merged files are not---dircache still has
the common ancestor view.  So show-diff you will be seeing may
be enormous and not very useful if two forks were done in the
distant past.  After reviewing the merge result, you can
update-cache, write-tree and commit-tree as usual, but with one
caveat:  do not run "show-files | xargs update-cache" if you are
running git-merge.perl without -f flag!

By default, git-merge.perl creates absolute minimum number of
files in ./,,merge-temp---only the merged files are left there
so that you can inspect them.  You will not see unmodified
files nor files changed only by one side of the merge.

If you give '-o' (oneside checkout) flag to git-merge.perl, then
the files only one side of the merge changed are also checked
out in ./,,merge-temp.  If you give '-f' (full checkout) flag to
git-merge.perl, then in addition to what '-o' checks out,
unchanged files are checked out in ./,,merge-temp.  This default
is geared towards a huge tree with small merges (favorite case
of Linus, if I understand correctly).

Running 'show-diff' in such a sparsely populated merge result
tree gives you huge results because recent show-diff shows diffs
with empty files.  I added a '-r' flag to show-diff, which
squelches diffs with empty files.

Also to implement 'changed only by one-side' without actually
checking the file out, I needed to add one option to
'update-cache'.  --cacheinfo flag is used this way:

    $ update-cache --cacheinfo mode sha1 path

and adds the pathname with mode and sha1 to the .git/index
without actually requiring you to have such a file there.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 show-diff.c    |   11 ++-
 show-files.c   |   12 ++-
 update-cache.c |   25 +++++++
 git-merge.perl |  193 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+), 7 deletions(-)


show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
--- show-diff.c
+++ show-diff.c	2005-04-13 22:47:33.000000000 -0700
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
show-files.c:  a9fa6767a418f870a34b39379f417bf37b17ee18
--- show-files.c
+++ show-files.c	2005-04-13 21:18:40.000000000 -0700
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
update-cache.c:  8f149d5a4ab60e030a0ab19fdb59b8ee2576ee71
--- update-cache.c
+++ update-cache.c	2005-04-13 23:27:54.000000000 -0700
@@ -203,6 +203,8 @@
 {
 	int i, newfd, entries;
 	int allow_options = 1;
+	const char *sha1_force = NULL;
+	const char *mode_force = NULL;
 
 	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0)
@@ -235,14 +237,35 @@
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

--- /dev/null	2005-03-19 15:28:25.000000000 -0800
+++ git-merge.perl	2005-04-13 23:45:23.000000000 -0700
@@ -0,0 +1,193 @@
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
+    my $common;
+    while (<$fhi>) {
+	chomp;
+	(undef, undef, $common) = split(/ /, $_);
+	if ($common =~ s/^([a-f0-f]{40}):\d+$/$1/) {
+	    last;
+	}
+    }
+    close $fhi;
+    return $common;
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
+	if (/^\*[0-7]+->([0-7]+)\tblob\t[0-9a-f]+->([0-9a-f]{40})\t(.*)$/s) {
+	    # mode newsha path
+	    $path{$3} = [$1, $2];
+	}
+	elsif (/^\+([0-7]+)\tblob\t([0-9a-f]{40})\t(.*)$/s) {
+	    # mode newsha path
+	    $path{$3} = [$1, $2];
+	}
+	else {
+	    print STDERR "$_??";
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
+    open $fhi, '-|', 'cat-file', 'blob', $info->[1]
+	or die "$!: cat-file blob $info->[1]";
+    while (<$fhi>) {
+	print $fho $_;
+    }
+    close $fhi;
+    close $fho;
+    chmod oct("0$info->[0]"), "$path";
+}
+
+sub record_file {
+    my ($path, $info) = @_;
+    system 'update-cache', '--cacheinfo', @$info, $path;
+}
+
+sub merge_tree {
+    my ($path, $info0, $info1) = @_;
+    print STDERR "M - $path\n";
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
+    chmod oct("0$info0->[0]"), "$path";
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
+my %need_merge = ();
+
+for $path (keys %tree0) {
+    if (! exists $tree1{$path}) {
+	# Only changed in tree 0 --- take his version
+	print STDERR "0 - $path\n";
+	if (! exists $ancestor_file{$path}) {
+	    checkout_file($path, $tree0{$path});
+	    system 'update-cache', '--add', "$path";
+	}
+	elsif ($oneside_checkout) {
+	    checkout_file($path, $tree0{$path});
+	}
+	else {
+	    record_file($path, $tree0{$path});
+	}
+    }
+    else {
+	merge_tree($path, $tree0{$path}, $tree1{$path});
+    }
+}
+
+for $path (keys %tree1) {
+    if (! exists $tree0{$path}) {
+	# Only changed in tree 1 --- take his version
+	print STDERR "1 - $path\n";
+	if (! exists $ancestor_file{$path}) {
+	    checkout_file($path, $tree1{$path});
+	    system 'update-cache', '--add', "$path";
+	}
+	elsif ($oneside_checkout) {
+	    checkout_file($path, $tree1{$path});
+	}
+	else {
+	    record_file($path, $tree1{$path});
+	}
+    }
+}
+
+# system 'show-diff';


