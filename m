From: Francis Galiegue <fg@one2team.net>
Subject: [PATCH] git-cvsimport.perl: use human readable names for option values
Date: Mon, 3 Nov 2008 10:31:59 +0100
Organization: One2team
Message-ID: <200811031031.59196.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 10:34:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwvpP-00038T-Ei
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbYKCJdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbYKCJdO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:33:14 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:52674 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659AbYKCJdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:33:13 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-77-130.w90-20.abo.wanadoo.fr [90.20.64.130])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 7E99492C011
	for <git@vger.kernel.org>; Mon,  3 Nov 2008 10:33:06 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99919>

Hello,

As I am keen to make my company use git eventually, but they have a really, 
really messy CVS tree that git-cvs*.perl cannot handle right now, I've 
decided to have a serious look at the code.

But if others want to have a look at the code, I think it should be made a 
little more readable first, hence this patch.

Comments? In particular, I'm thinking about the option names, maybe some are 
not in sync with what git internal really are.

---
git-cvsimport.perl: use human readable names for option values

It has reclaimed to rewrite the read_repo_config() function as well, but the
good thing is that "no strcit 'refs'" is gone too.
---
 git-cvsimport.perl |  244 
++++++++++++++++++++++++++++++++--------------------
 1 files changed, 150 insertions(+), 94 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e439202..b9a552f 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,7 +29,51 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,
$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r);
+#
+# Option values
+#
+my $help = undef;		 # -h
+my $branch_for_head = undef;	 # -o
+my $verbose = undef;		 # -v
+my $cvs_kill_keywords = undef;	 # -k
+my $convert_underscores = undef; # -u
+my $cvsroot = undef;		 # -d
+my $cvsps_options = undef;	 # -p
+my $git_repos_root = undef;	 # -C
+my $cvsps_fuzz = undef;		 # -z
+my $import_only = undef;	 # -i
+my $cvsps_output_file = undef;	 # -P
+my $branch_subst = undef,	 # -s
+my $detect_merges = undef;	 # -m
+my @more_merge_regexes = ();	 # -M
+my $author_conv_file = undef;	 # -A
+my $skip_paths = undef;		 # -S
+my $commit_limits = undef;	 # -L
+my $all_commits = undef;	 # -a
+my $remote_path = undef;	 # -r
+
+my %options = (
+	"h" => \$help,
+	"o=s" => \$branch_for_head,
+	"v" => \$verbose,
+	"k" => \$cvs_kill_keywords,
+	"u" => \$convert_underscores,
+	"d=s" => \$cvsroot,
+	"p=s" => \$cvsps_options,
+	"C=s" => \$git_repos_root,
+	"z=s" => \$cvsps_fuzz,
+	"i" => \$import_only,
+	"P=s" => \$cvsps_output_file,
+	"s=s" => \$branch_subst,
+	"m" => \$detect_merges,
+	"M=s" => \@more_merge_regexes,
+	"A=s" => \$author_conv_file,
+	"S=s" => \$skip_paths,
+	"L=s" => \$commit_limits,
+	"a" => \$all_commits,
+	"r=s" => \$remote_path
+);
+
 my (%conv_author_name, %conv_author_email);
 
 sub usage(;$) {
@@ -88,37 +132,48 @@ sub write_author_info($) {
 	close ($f);
 }
 
-# convert getopts specs for use by git config
-sub read_repo_config {
-    # Split the string between characters, unless there is a ':'
-    # So "abc:de" becomes ["a", "b", "c:", "d", "e"]
-	my @opts = split(/ *(?!:)/, shift);
-	foreach my $o (@opts) {
-		my $key = $o;
-		$key =~ s/://g;
-		my $arg = 'git config';
-		$arg .= ' --bool' if ($o !~ /:$/);
-
-        chomp(my $tmp = `$arg --get cvsimport.$key`);
-		if ($tmp && !($arg =~ /--bool/ && $tmp eq 'false')) {
-            no strict 'refs';
-            my $opt_name = "opt_" . $key;
-            if (!$$opt_name) {
-                $$opt_name = $tmp;
-            }
+sub read_repo_config ()
+{
+	my @option_keys = keys %options;
+
+	while (my ($opt, $ref) = each %options) {
+		my $key = $opt;
+		my $is_boolean = 0;
+		my $cmd = "git config";
+		unless ($key =~ s/=s$//) {
+			$is_boolean = 1;
+			$cmd .= " --bool";
+		}
+		$cmd .= " cvsimport.$key";
+		
+		chomp(my $tmp = qx/$cmd/);
+		$tmp or next;
+
+		if (ref($ref) eq "ARRAY") {
+			#
+			# FIXME: unhandled...
+			# However this could be handled by splitting $tmp with
+			# /\s*,\s*/ and pusing the result into @$ref (for the -M
+			# option)
+			#
+			next;
+		}
+
+		if ($is_boolean) {
+			$$ref = ("$tmp" eq "true") ? 1 : 0;
+		} else {
+			$$ref = "$tmp";
 		}
 	}
 }
 
-my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:";
-read_repo_config($opts);
+
+read_repo_config();
 Getopt::Long::Configure( 'no_ignore_case', 'bundling' );
 
-# turn the Getopt::Std specification in a Getopt::Long one,
-# with support for multiple -M options
-GetOptions( map { s/:/=s/; /M/ ? "$_\@" : $_ } split( /(?!:)/, $opts ) )
-    or usage();
-usage if $opt_h;
+GetOptions(%options) or usage();
+
+usage() if $help;
 
 if (@ARGV == 0) {
 		chomp(my $module = `git config --get cvsimport.module`);
@@ -126,31 +181,32 @@ if (@ARGV == 0) {
 }
 @ARGV <= 1 or usage("You can't specify more than one CVS module");
 
-if ($opt_d) {
-	$ENV{"CVSROOT"} = $opt_d;
+if ($cvsroot) {
+	$ENV{"CVSROOT"} = $cvsroot;
 } elsif (-f 'CVS/Root') {
 	open my $f, '<', 'CVS/Root' or die 'Failed to open CVS/Root';
-	$opt_d = <$f>;
-	chomp $opt_d;
+	$cvsroot = <$f>;
+	chomp $cvsroot;
 	close $f;
-	$ENV{"CVSROOT"} = $opt_d;
+	$ENV{"CVSROOT"} = $cvsroot;
 } elsif ($ENV{"CVSROOT"}) {
-	$opt_d = $ENV{"CVSROOT"};
+	$cvsroot = $ENV{"CVSROOT"};
 } else {
 	usage("CVSROOT needs to be set");
 }
-$opt_s ||= "-";
-$opt_a ||= 0;
+$branch_subst ||= "-";
+$all_commits ||= 0;
 
-my $git_tree = $opt_C;
+my $git_tree = $git_repos_root;
 $git_tree ||= ".";
 
 my $remote;
-if (defined $opt_r) {
-	$remote = 'refs/remotes/' . $opt_r;
-	$opt_o ||= "master";
+
+if (defined $remote_path) {
+	$remote = 'refs/remotes/' . $remote_path;
+	$branch_for_head ||= "master";
 } else {
-	$opt_o ||= "origin";
+	$branch_for_head ||= "origin";
 	$remote = 'refs/heads';
 }
 
@@ -168,11 +224,11 @@ if ($#ARGV == 0) {
 }
 
 our @mergerx = ();
-if ($opt_m) {
+if ($detect_merges) {
 	@mergerx = ( qr/\b(?:from|of|merge|merging|merged) ([-\w]+)/i );
 }
-if (@opt_M) {
-	push (@mergerx, map { qr/$_/ } @opt_M);
+if (@more_merge_regexes) {
+	push (@mergerx, map { qr/$_/ } @more_merge_regexes);
 }
 
 # Remember UTC of our starting time
@@ -370,7 +426,7 @@ sub _file {
 	$self->{'socketo'}->write("Argument -N\n") or return undef;
 	$self->{'socketo'}->write("Argument -P\n") or return undef;
 	# -kk: Linus' version doesn't use it - defaults to off
-	if ($opt_k) {
+	if ($cvs_kill_keywords) {
 	    $self->{'socketo'}->write("Argument -kk\n") or return undef;
 	}
 	$self->{'socketo'}->write("Argument -r\n") or return undef;
@@ -487,7 +543,7 @@ sub _fetchfile {
 
 package main;
 
-my $cvs = CVSconn->new($opt_d, $cvs_tree);
+my $cvs = CVSconn->new($cvsroot, $cvs_tree);
 
 
 sub pdate($) {
@@ -565,7 +621,7 @@ unless (-d $git_dir) {
 	system("git-read-tree");
 	die "Cannot init an empty tree: $?\n" if $?;
 
-	$last_branch = $opt_o;
+	$last_branch = $branch_for_head;
 	$orig_branch = "";
 } else {
 	open(F, "git-symbolic-ref HEAD |") or
@@ -592,8 +648,8 @@ unless (-d $git_dir) {
 		$branch_date{$head} = $1;
 	}
 	close(H);
-        if (!exists $branch_date{$opt_o}) {
-		die "Branch '$opt_o' does not exist.\n".
+        if (!exists $branch_date{$branch_for_head}) {
+		die "Branch '$branch_for_head' does not exist.\n".
 		       "Either use the correct '-o branch' option,\n".
 		       "or import to a new repository.\n";
         }
@@ -605,31 +661,31 @@ unless (-d $git_dir) {
 # now we read (and possibly save) author-info as well
 -f "$git_dir/cvs-authors" and
   read_author_info("$git_dir/cvs-authors");
-if ($opt_A) {
-	read_author_info($opt_A);
+if ($author_conv_file) {
+	read_author_info($author_conv_file);
 	write_author_info("$git_dir/cvs-authors");
 }
 
 
 #
 # run cvsps into a file unless we are getting
-# it passed as a file via $opt_P
+# it passed as a file via $cvsps_output_file
 #
 my $cvspsfile;
-unless ($opt_P) {
-	print "Running cvsps...\n" if $opt_v;
+unless ($cvsps_output_file) {
+	print "Running cvsps...\n" if $verbose;
 	my $pid = open(CVSPS,"-|");
 	my $cvspsfh;
 	die "Cannot fork: $!\n" unless defined $pid;
 	unless ($pid) {
 		my @opt;
-		@opt = split(/,/,$opt_p) if defined $opt_p;
-		unshift @opt, '-z', $opt_z if defined $opt_z;
-		unshift @opt, '-q'         unless defined $opt_v;
-		unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
+		@opt = split(/,/,$cvsps_options) if defined $cvsps_options;
+		unshift @opt, '-z', $cvsps_fuzz if defined $cvsps_fuzz;
+		unshift @opt, '-q'         unless defined $verbose;
+		unless (defined($cvsps_options) && $cvsps_options =~ m/--no-cvs-direct/) {
 			push @opt, '--cvs-direct';
 		}
-		exec("cvsps","--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
+		exec("cvsps","--norc",@opt,"-u","-A",'--root',$cvsroot,$cvs_tree);
 		die "Could not start cvsps: $!\n";
 	}
 	($cvspsfh, $cvspsfile) = tempfile('gitXXXXXX', SUFFIX => '.cvsps',
@@ -641,7 +697,7 @@ unless ($opt_P) {
 	$? == 0 or die "git-cvsimport: fatal: cvsps reported error\n";
 	close $cvspsfh;
 } else {
-	$cvspsfile = $opt_P;
+	$cvspsfile = $cvsps_output_file;
 }
 
 open(CVS, "<$cvspsfile") or die $!;
@@ -688,7 +744,7 @@ sub write_tree () {
 		or die "Cannot get tree id ($tree): $!";
 	close($fh)
 		or die "Error running git-write-tree: $?\n";
-	print "Tree ID $tree\n" if $opt_v;
+	print "Tree ID $tree\n" if $verbose;
 	return $tree;
 }
 
@@ -699,7 +755,7 @@ my (@old,@new,@skipped,%ignorebranch);
 $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
 
 sub commit {
-	if ($branch eq $opt_o && !$index{branch} &&
+	if ($branch eq $branch_for_head && !$index{branch} &&
 		!get_headref("$remote/$branch")) {
 	    # looks like an initial commit
 	    # use the index primed by git-init
@@ -725,7 +781,7 @@ sub commit {
 	@old = @new = ();
 	my $tree = write_tree();
 	my $parent = get_headref("$remote/$last_branch");
-	print "Parent ID " . ($parent ? $parent : "(empty)") . "\n" if $opt_v;
+	print "Parent ID " . ($parent ? $parent : "(empty)") . "\n" if $verbose;
 
 	my @commit_args;
 	push @commit_args, ("-p", $parent) if $parent;
@@ -734,10 +790,10 @@ sub commit {
 	# based on the commit msg
 	foreach my $rx (@mergerx) {
 		next unless $logmsg =~ $rx && $1;
-		my $mparent = $1 eq 'HEAD' ? $opt_o : $1;
+		my $mparent = $1 eq 'HEAD' ? $branch_for_head : $1;
 		if (my $sha1 = get_headref("$remote/$mparent")) {
 			push @commit_args, '-p', "$remote/$mparent";
-			print "Merge parent branch: $mparent\n" if $opt_v;
+			print "Merge parent branch: $mparent\n" if $verbose;
 		}
 	}
 
@@ -764,10 +820,10 @@ sub commit {
 	print($commit_write "$logmsg\n") && close($commit_write)
 		or die "Error writing to git-commit-tree: $!\n";
 
-	print "Committed patch $patchset ($branch $commit_date)\n" if $opt_v;
+	print "Committed patch $patchset ($branch $commit_date)\n" if $verbose;
 	chomp(my $cid = <$commit_read>);
 	is_sha1($cid) or die "Cannot get commit id ($cid): $!\n";
-	print "Commit ID $cid\n" if $opt_v;
+	print "Commit ID $cid\n" if $verbose;
 	close($commit_read);
 
 	waitpid($pid,0);
@@ -779,14 +835,14 @@ sub commit {
 	if ($tag) {
 	        my ($xtag) = $tag;
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
-		$xtag =~ tr/_/\./ if ( $opt_u );
-		$xtag =~ s/[\/]/$opt_s/g;
+		$xtag =~ tr/_/\./ if ( $convert_underscores );
+		$xtag =~ s/[\/]/$branch_subst/g;
 		$xtag =~ s/\[//g;
 
 		system('git-tag', '-f', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
 
-		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
+		print "Created tag '$xtag' on '$branch'\n" if $verbose;
 	}
 };
 
@@ -822,14 +878,14 @@ while (<CVS>) {
 		$state = 4;
 	} elsif ($state == 4 and s/^Branch:\s+//) {
 		s/\s+$//;
-		tr/_/\./ if ( $opt_u );
-		s/[\/]/$opt_s/g;
+		tr/_/\./ if ( $convert_underscores );
+		s/[\/]/$branch_subst/g;
 		$branch = $_;
 		$state = 5;
 	} elsif ($state == 5 and s/^Ancestor branch:\s+//) {
 		s/\s+$//;
 		$ancestor = $_;
-		$ancestor = $opt_o if $ancestor eq "HEAD";
+		$ancestor = $branch_for_head if $ancestor eq "HEAD";
 		$state = 6;
 	} elsif ($state == 5) {
 		$ancestor = undef;
@@ -847,19 +903,19 @@ while (<CVS>) {
 		$logmsg = "";
 		$state = 8;
 	} elsif ($state == 8 and /^Members:/) {
-		$branch = $opt_o if $branch eq "HEAD";
+		$branch = $branch_for_head if $branch eq "HEAD";
 		if (defined $branch_date{$branch} and $branch_date{$branch} >= $date) {
 			# skip
-			print "skip patchset $patchset: $date before $branch_date{$branch}\n" if 
$opt_v;
+			print "skip patchset $patchset: $date before $branch_date{$branch}\n" if 
$verbose;
 			$state = 11;
 			next;
 		}
-		if (!$opt_a && $starttime - 300 - (defined $opt_z ? $opt_z : 300) <= $date) 
{
+		if (!$all_commits && $starttime - 300 - (defined $cvsps_fuzz ? 
$cvsps_fuzz : 300) <= $date) {
 			# skip if the commit is too recent
 			# given that the cvsps default fuzz is 300s, we give ourselves another
 			# 300s just in case -- this also prevents skipping commits
 			# due to server clock drift
-			print "skip patchset $patchset: $date too recent\n" if $opt_v;
+			print "skip patchset $patchset: $date too recent\n" if $verbose;
 			$state = 11;
 			next;
 		}
@@ -870,8 +926,8 @@ while (<CVS>) {
 		}
 		if ($ancestor) {
 			if ($ancestor eq $branch) {
-				print STDERR "Branch $branch erroneously stems from itself -- changed 
ancestor to $opt_o\n";
-				$ancestor = $opt_o;
+				print STDERR "Branch $branch erroneously stems from itself -- changed 
ancestor to $branch_for_head\n";
+				$ancestor = $branch_for_head;
 			}
 			if (defined get_headref("$remote/$branch")) {
 				print STDERR "Branch $branch already exists!\n";
@@ -905,18 +961,18 @@ while (<CVS>) {
 		my $fn = $1;
 		my $rev = $3;
 		$fn =~ s#^/+##;
-		if ($opt_S && $fn =~ m/$opt_S/) {
+		if ($skip_paths && $fn =~ m/$skip_paths/) {
 		    print "SKIPPING $fn v $rev\n";
 		    push(@skipped, $fn);
 		    next;
 		}
-		print "Fetching $fn   v $rev\n" if $opt_v;
+		print "Fetching $fn   v $rev\n" if $verbose;
 		my ($tmpname, $size) = $cvs->file($fn,$rev);
 		if ($size == -1) {
 			push(@old,$fn);
-			print "Drop $fn\n" if $opt_v;
+			print "Drop $fn\n" if $verbose;
 		} else {
-			print "".($init ? "New" : "Update")." $fn: $size bytes\n" if $opt_v;
+			print "".($init ? "New" : "Update")." $fn: $size bytes\n" if $verbose;
 			my $pid = open(my $F, '-|');
 			die $! unless defined $pid;
 			if (!$pid) {
@@ -934,12 +990,12 @@ while (<CVS>) {
 		my $fn = $1;
 		$fn =~ s#^/+##;
 		push(@old,$fn);
-		print "Delete $fn\n" if $opt_v;
+		print "Delete $fn\n" if $verbose;
 	} elsif ($state == 9 and /^\s*$/) {
 		$state = 10;
 	} elsif (($state == 9 or $state == 10) and /^-+$/) {
 		$commitcount++;
-		if ($opt_L && $commitcount > $opt_L) {
+		if ($commit_limits && $commitcount > $commit_limits) {
 			last;
 		}
 		commit();
@@ -957,7 +1013,7 @@ while (<CVS>) {
 }
 commit() if $branch and $state != 11;
 
-unless ($opt_P) {
+unless ($cvsps_output_file) {
 	unlink($cvspsfile);
 }
 
@@ -985,31 +1041,31 @@ if (defined $orig_git_index) {
 
 # Now switch back to the branch we were in before all of this happened
 if ($orig_branch) {
-	print "DONE.\n" if $opt_v;
-	if ($opt_i) {
+	print "DONE.\n" if $verbose;
+	if ($import_only) {
 		exit 0;
 	}
 	my $tip_at_end = `git-rev-parse --verify HEAD`;
 	if ($tip_at_start ne $tip_at_end) {
 		for ($tip_at_start, $tip_at_end) { chomp; }
-		print "Fetched into the current branch.\n" if $opt_v;
+		print "Fetched into the current branch.\n" if $verbose;
 		system(qw(git-read-tree -u -m),
 		       $tip_at_start, $tip_at_end);
 		die "Fast-forward update failed: $?\n" if $?;
 	}
 	else {
-		system(qw(git-merge cvsimport HEAD), "$remote/$opt_o");
-		die "Could not merge $opt_o into the current branch.\n" if $?;
+		system(qw(git-merge cvsimport HEAD), "$remote/$branch_for_head");
+		die "Could not merge $branch_for_head into the current branch.\n" if $?;
 	}
 } else {
 	$orig_branch = "master";
-	print "DONE; creating $orig_branch branch\n" if $opt_v;
-	system("git-update-ref", "refs/heads/master", "$remote/$opt_o")
+	print "DONE; creating $orig_branch branch\n" if $verbose;
+	system("git-update-ref", "refs/heads/master", "$remote/$branch_for_head")
 		unless defined get_headref('refs/heads/master');
-	system("git-symbolic-ref", "$remote/HEAD", "$remote/$opt_o")
-		if ($opt_r && $opt_o ne 'HEAD');
+	system("git-symbolic-ref", "$remote/HEAD", "$remote/$branch_for_head")
+		if ($remote_path && $branch_for_head ne 'HEAD');
 	system('git-update-ref', 'HEAD', "$orig_branch");
-	unless ($opt_i) {
+	unless ($import_only) {
 		system('git checkout -f');
 		die "checkout failed: $?\n" if $?;
 	}

-- 
fge
