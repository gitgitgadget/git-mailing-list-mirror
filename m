From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 12/13] git-svn: add support for Perl SVN::* libraries
Date: Tue, 13 Jun 2006 11:02:14 -0700
Message-ID: <115022175180-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDE0-0004t6-MP
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWFMSCh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWFMSCh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:37 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53445 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932141AbWFMSCd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:33 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CB6467DC005;
	Tue, 13 Jun 2006 11:02:31 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:31 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21793>

This means we no longer have to deal with having bloated SVN
working copies around and we get a nice performance increase as
well because we don't have to exec the SVN binary and start a
new server connection each time.

Of course we have to manually manage memory with SVN::Pool
whenever we can, and hack around cases where SVN just eats
memory despite pools (I blame Perl, too).  I would like to
keep memory usage as stable as possible during long fetch/commit
processes since I still use computers with only 256-512M RAM.

commit should always be faster with the SVN library code.  The
SVN::Delta interface is leaky (or I'm not using it with pools
correctly), so I'm forking on every commit, but that doesn't
seem to hurt performance too much (at least on normal Unix/Linux
systems where fork() is pretty cheap).

fetch should be faster in most common cases, but probably not all.
fetches will be faster where client/server delta generation is
the bottleneck and not bandwidth.  Of course, full-files are
generated server-side via deltas, too.  Full files are always
transferred when they're updated, just like git-svnimport and
unlike command-line svn.  I'm also hacking around memory leaks
(see comments) here by using some more forks.

I've tested fetch with http://, https://, file://, and svn://
repositories, so we should be reasonably covered in terms of
error handling for fetching.

Of course, we'll keep plain command-line svn compatibility as a
fallback for people running SVN 1.1 (I'm looking into library
support for 1.1.x SVN, too).  If you want to force command-line
SVN usage, set GIT_SVN_NO_LIB=1 in your environment.

We also require two simultaneous connections (just like
git-svnimport), but this shouldn't be a problem for most
servers.

Less important commands:

show-ignore is slower because it requires repository
access, but -r/--revision <num> can be specified.

graft-branches may use more memory, but it's a
short-term process and is funky-filename-safe.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl               | 1068 +++++++++++++++++++++++++---
 contrib/git-svn/t/lib-git-svn.sh           |    2 
 contrib/git-svn/t/t0000-contrib-git-svn.sh |   15 
 3 files changed, 974 insertions(+), 111 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 03416ae..9618c8b 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -31,6 +31,10 @@ use File::Path qw/mkpath/;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev pass_through/;
 use File::Spec qw//;
 use POSIX qw/strftime/;
+
+my ($SVN_PATH, $SVN, $SVN_LOG, $_use_lib);
+$_use_lib = 1 unless $ENV{GIT_SVN_NO_LIB};
+libsvn_load();
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
@@ -74,7 +78,8 @@ my %cmd = (
 				'copy-similarity|C=i'=> \$_cp_similarity,
 				%fc_opts,
 			} ],
-	'show-ignore' => [ \&show_ignore, "Show svn:ignore listings", { } ],
+	'show-ignore' => [ \&show_ignore, "Show svn:ignore listings",
+			{ 'revision|r=i' => \$_revision } ],
 	rebuild => [ \&rebuild, "Rebuild git-svn metadata (after git clone)",
 			{ 'no-ignore-externals' => \$_no_ignore_ext,
 			  'upgrade' => \$_upgrade } ],
@@ -211,6 +216,8 @@ sub rebuild {
 		$newest_rev = $rev if ($rev > $newest_rev);
 	}
 	close $rev_list or croak $?;
+
+	goto out if $_use_lib;
 	if (!chdir $SVN_WC) {
 		svn_cmd_checkout($SVN_URL, $latest, $SVN_WC);
 		chdir $SVN_WC or croak $!;
@@ -228,7 +235,7 @@ sub rebuild {
 	}
 	waitpid $pid, 0;
 	croak $? if $?;
-
+out:
 	if ($_upgrade) {
 		print STDERR <<"";
 Keeping deprecated refs/head/$GIT_SVN-HEAD for now.  Please remove it
@@ -251,9 +258,18 @@ sub init {
 }
 
 sub fetch {
-	my (@parents) = @_;
 	check_upgrade_needed();
 	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
+	my $ret = $_use_lib ? fetch_lib(@_) : fetch_cmd(@_);
+	if ($ret->{commit} && quiet_run(qw(git-rev-parse --verify
+						refs/heads/master^0))) {
+		sys(qw(git-update-ref refs/heads/master),$ret->{commit});
+	}
+	return $ret;
+}
+
+sub fetch_cmd {
+	my (@parents) = @_;
 	my @log_args = -d $SVN_WC ? ($SVN_WC) : ($SVN_URL);
 	unless ($_revision) {
 		$_revision = -d $SVN_WC ? 'BASE:HEAD' : '0:HEAD';
@@ -301,13 +317,91 @@ sub fetch {
 		$last_commit = git_commit($log_msg, $last_commit, @parents);
 		$last = $log_msg;
 	}
-	unless (-e "$GIT_DIR/refs/heads/master") {
-		sys(qw(git-update-ref refs/heads/master),$last_commit);
-	}
 	close $svn_log->{fh};
+	$last->{commit} = $last_commit;
 	return $last;
 }
 
+sub fetch_lib {
+	my (@parents) = @_;
+	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
+	my $repo;
+	($repo, $SVN_PATH) = repo_path_split($SVN_URL);
+	$SVN_LOG ||= libsvn_connect($repo);
+	$SVN ||= libsvn_connect($repo);
+	my ($last_rev, $last_commit) = svn_grab_base_rev();
+	my ($base, $head) = libsvn_parse_revision($last_rev);
+	if ($base > $head) {
+		return { revision => $last_rev, commit => $last_commit }
+	}
+	my $index = set_index($GIT_SVN_INDEX);
+
+	# limit ourselves and also fork() since get_log won't release memory
+	# after processing a revision and SVN stuff seems to leak
+	my $inc = 1000;
+	my ($min, $max) = ($base, $head < $base+$inc ? $head : $base+$inc);
+	read_uuid();
+	if (defined $last_commit) {
+		unless (-e $GIT_SVN_INDEX) {
+			sys(qw/git-read-tree/, $last_commit);
+		}
+		chomp (my $x = `git-write-tree`);
+		my ($y) = (`git-cat-file commit $last_commit`
+							=~ /^tree ($sha1)/m);
+		if ($y ne $x) {
+			unlink $GIT_SVN_INDEX or croak $!;
+			sys(qw/git-read-tree/, $last_commit);
+		}
+		chomp ($x = `git-write-tree`);
+		if ($y ne $x) {
+			print STDERR "trees ($last_commit) $y != $x\n",
+				 "Something is seriously wrong...\n";
+		}
+	}
+	while (1) {
+		# fork, because using SVN::Pool with get_log() still doesn't
+		# seem to help enough to keep memory usage down.
+		defined(my $pid = fork) or croak $!;
+		if (!$pid) {
+			$SVN::Error::handler = \&libsvn_skip_unknown_revs;
+			print "Fetching revisions $min .. $max\n";
+
+			# Yes I'm perfectly aware that the fourth argument
+			# below is the limit revisions number.  Unfortunately
+			# performance sucks with it enabled, so it's much
+			# faster to fetch revision ranges instead of relying
+			# on the limiter.
+			$SVN_LOG->get_log( '/'.$SVN_PATH, $min, $max, 0, 1, 1,
+				sub {
+					my $log_msg;
+					if ($last_commit) {
+						$log_msg = libsvn_fetch(
+							$last_commit, @_);
+						$last_commit = git_commit(
+							$log_msg,
+							$last_commit,
+							@parents);
+					} else {
+						$log_msg = libsvn_new_tree(@_);
+						$last_commit = git_commit(
+							$log_msg, @parents);
+					}
+				});
+			$SVN::Error::handler = sub { 'quiet warnings' };
+			exit 0;
+		}
+		waitpid $pid, 0;
+		croak $? if $?;
+		($last_rev, $last_commit) = svn_grab_base_rev();
+		last if ($max >= $head);
+		$min = $max + 1;
+		$max += $inc;
+		$max = $head if ($max > $head);
+	}
+	restore_index($index);
+	return { revision => $last_rev, commit => $last_commit };
+}
+
 sub commit {
 	my (@commits) = @_;
 	check_upgrade_needed();
@@ -332,6 +426,12 @@ sub commit {
 		}
 	}
 	chomp @revs;
+	$_use_lib ? commit_lib(@revs) : commit_cmd(@revs);
+	print "Done committing ",scalar @revs," revisions to SVN\n";
+}
+
+sub commit_cmd {
+	my (@revs) = @_;
 
 	chdir $SVN_WC or croak "Unable to chdir $SVN_WC: $!\n";
 	my $info = svn_info('.');
@@ -353,17 +453,95 @@ sub commit {
 		}
 		$svn_current_rev = svn_commit_tree($svn_current_rev, $c);
 	}
-	print "Done committing ",scalar @revs," revisions to SVN\n";
 }
 
-sub show_ignore {
-	require File::Find or die $!;
-	my $exclude_file = "$GIT_DIR/info/exclude";
-	open my $fh, '<', $exclude_file or croak $!;
-	chomp(my @excludes = (<$fh>));
-	close $fh or croak $!;
+sub commit_lib {
+	my (@revs) = @_;
+	my ($r_last, $cmt_last) = svn_grab_base_rev();
+	defined $r_last or die "Must have an existing revision to commit\n";
+	my $fetched = fetch_lib();
+	if ($r_last != $fetched->{revision}) {
+		print STDERR "There are new revisions that were fetched ",
+				"and need to be merged (or acknowledged) ",
+				"before committing.\n",
+				"last rev: $r_last\n",
+				" current: $fetched->{revision}\n";
+		exit 1;
+	}
+	read_uuid();
+	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
+	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
+
+	foreach my $c (@revs) {
+		# fork for each commit because there's a memory leak I
+		# can't track down... (it's probably in the SVN code)
+		defined(my $pid = open my $fh, '-|') or croak $!;
+		if (!$pid) {
+			if (defined $LC_ALL) {
+				$ENV{LC_ALL} = $LC_ALL;
+			} else {
+				delete $ENV{LC_ALL};
+			}
+			my $log_msg = get_commit_message($c, $commit_msg);
+			my $ed = SVN::Git::Editor->new(
+					{	r => $r_last,
+						ra => $SVN,
+						c => $c,
+						svn_path => $SVN_PATH
+					},
+					$SVN->get_commit_editor(
+						$log_msg->{msg},
+						sub {
+							libsvn_commit_cb(
+								@_, $c,
+								$log_msg->{msg},
+								$r_last,
+								$cmt_last)
+						},
+						@lock)
+					);
+			my $mods = libsvn_checkout_tree($r_last, $c, $ed);
+			if (@$mods == 0) {
+				print "No changes\nr$r_last = $cmt_last\n";
+				$ed->abort_edit;
+			} else {
+				$ed->close_edit;
+			}
+			exit 0;
+		}
+		my ($r_new, $cmt_new, $no);
+		while (<$fh>) {
+			print $_;
+			chomp;
+			if (/^r(\d+) = ($sha1)$/o) {
+				($r_new, $cmt_new) = ($1, $2);
+			} elsif ($_ eq 'No changes') {
+				$no = 1;
+			}
+		}
+		close $fh or croak $!;
+		if (! defined $r_new && ! defined $cmt_new) {
+			unless ($no) {
+				die "Failed to parse revision information\n";
+			}
+		} else {
+			($r_last, $cmt_last) = ($r_new, $cmt_new);
+		}
+	}
+	unlink $commit_msg;
+}
 
+sub show_ignore {
 	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
+	$_use_lib ? show_ignore_lib() : show_ignore_cmd();
+}
+
+sub show_ignore_cmd {
+	require File::Find or die $!;
+	if (defined $_revision) {
+		die "-r/--revision option doesn't work unless the Perl SVN ",
+			"libraries are used\n";
+	}
 	chdir $SVN_WC or croak $!;
 	my %ign;
 	File::Find::find({wanted=>sub{if(lstat $_ && -d _ && -d "$_/.svn"){
@@ -380,6 +558,14 @@ sub show_ignore {
 	}
 }
 
+sub show_ignore_lib {
+	my $repo;
+	($repo, $SVN_PATH) = repo_path_split($SVN_URL);
+	$SVN ||= libsvn_connect($repo);
+	my $r = defined $_revision ? $_revision : $SVN->get_latest_revnum;
+	libsvn_traverse_ignore(\*STDOUT, $SVN_PATH, $r);
+}
+
 sub graft_branches {
 	my $gr_file = "$GIT_DIR/info/grafts";
 	my ($grafts, $comments) = read_grafts($gr_file);
@@ -403,7 +589,13 @@ sub graft_branches {
 				graft_merge_msg($grafts,$l_map,$u,$p);
 			}
 		}
-		graft_file_copy($grafts,$l_map,$u) unless $_no_graft_copy;
+		unless ($_no_graft_copy) {
+			if ($_use_lib) {
+				graft_file_copy_lib($grafts,$l_map,$u);
+			} else {
+				graft_file_copy_cmd($grafts,$l_map,$u);
+			}
+		}
 	}
 
 	write_grafts($grafts, $comments, $gr_file);
@@ -574,7 +766,8 @@ sub complete_url_ls_init {
 		}
 		$var = $url . $var;
 	}
-	chomp(my @ls = safe_qx(qw/svn ls --non-interactive/, $var));
+	chomp(my @ls = $_use_lib ? libsvn_ls_fullurl($var)
+				: safe_qx(qw/svn ls --non-interactive/, $var));
 	my $old = $GIT_SVN;
 	defined(my $pid = fork) or croak $!;
 	if (!$pid) {
@@ -617,7 +810,7 @@ sub common_prefix {
 }
 
 # this isn't funky-filename safe, but good enough for now...
-sub graft_file_copy {
+sub graft_file_copy_cmd {
 	my ($grafts, $l_map, $u) = @_;
 	my $paths = $l_map->{$u};
 	my $pfx = common_prefix([keys %$paths]);
@@ -625,7 +818,9 @@ sub graft_file_copy {
 	my $pid = open my $fh, '-|';
 	defined $pid or croak $!;
 	unless ($pid) {
-		exec(qw/svn log -v/, $u.$pfx) or croak $!;
+		my @exec = qw/svn log -v/;
+		push @exec, "-r$_revision" if defined $_revision;
+		exec @exec, $u.$pfx or croak $!;
 	}
 	my ($r, $mp) = (undef, undef);
 	while (<$fh>) {
@@ -637,42 +832,40 @@ sub graft_file_copy {
 		} elsif (/^Changed paths:/) {
 			$mp = 1;
 		} elsif ($mp && m#^   [AR] /(\S.*?) \(from /(\S+?):(\d+)\)$#) {
-			my $dbg = "r$r | $_";
 			my ($p1, $p0, $r0) = ($1, $2, $3);
-			my $c;
-			foreach my $x (keys %$paths) {
-				next unless ($p1 =~ /^\Q$x\E/);
-				my $i = $paths->{$x};
-				my $f = "$GIT_DIR/svn/$i/revs/$r";
-				unless (-r $f) {
-					print STDERR "r$r of $i not imported,",
-								" $dbg\n";
-					next;
-				}
-				$c = file_to_s($f);
-			}
+			my $c = find_graft_path_commit($paths, $p1, $r);
 			next unless $c;
-			foreach my $x (keys %$paths) {
-				next unless ($p0 =~ /^\Q$x\E/);
-				my $i = $paths->{$x};
-				my $f = "$GIT_DIR/svn/$i/revs/$r0";
-				while ($r0 && !-r $f) {
-					# could be an older revision, too...
-					$r0--;
-					$f = "$GIT_DIR/svn/$i/revs/$r0";
-				}
-				unless (-r $f) {
-					print STDERR "r$r0 of $i not imported,",
-								" $dbg\n";
-					next;
-				}
-				my $r1 = file_to_s($f);
-				$grafts->{$c}->{$r1} = 1;
-			}
+			find_graft_path_parents($grafts, $paths, $c, $p0, $r0);
 		}
 	}
 }
 
+sub graft_file_copy_lib {
+	my ($grafts, $l_map, $u) = @_;
+	my $tree_paths = $l_map->{$u};
+	my $pfx = common_prefix([keys %$tree_paths]);
+	my ($repo, $path) = repo_path_split($u.$pfx);
+	$SVN_LOG ||= libsvn_connect($repo);
+	$SVN ||= libsvn_connect($repo);
+
+	my ($base, $head) = libsvn_parse_revision();
+	my $inc = 1000;
+	my ($min, $max) = ($base, $head < $base+$inc ? $head : $base+$inc);
+	while (1) {
+		my $pool = SVN::Pool->new;
+		$SVN_LOG->get_log( "/$path", $min, $max, 0, 1, 1,
+			sub {
+				libsvn_graft_file_copies($grafts, $tree_paths,
+							$path, @_);
+			}, $pool);
+		$pool->clear;
+		last if ($max >= $head);
+		$min = $max + 1;
+		$max += $inc;
+		$max = $head if ($max > $head);
+	}
+}
+
 sub process_merge_msg_matches {
 	my ($grafts, $l_map, $u, $p, $c, @matches) = @_;
 	my (@strong, @weak);
@@ -734,9 +927,15 @@ sub graft_merge_msg {
 
 sub read_uuid {
 	return if $SVN_UUID;
-	my $info = shift || svn_info('.');
-	$SVN_UUID = $info->{'Repository UUID'} or
+	if ($_use_lib) {
+		my $pool = SVN::Pool->new;
+		$SVN_UUID = $SVN->get_uuid($pool);
+		$pool->clear;
+	} else {
+		my $info = shift || svn_info('.');
+		$SVN_UUID = $info->{'Repository UUID'} or
 					croak "Repository UUID unreadable\n";
+	}
 	s_to_file($SVN_UUID,"$GIT_SVN_DIR/info/uuid");
 }
 
@@ -769,9 +968,19 @@ sub repo_path_split {
 	$path =~ s#^/+##;
 	my @paths = split(m#/+#, $path);
 
-	while (quiet_run(qw/svn ls --non-interactive/, $url)) {
-		my $n = shift @paths || last;
-		$url .= "/$n";
+	if ($_use_lib) {
+		while (1) {
+			$SVN = libsvn_connect($url);
+			last if (defined $SVN &&
+				defined eval { $SVN->get_latest_revnum });
+			my $n = shift @paths || last;
+			$url .= "/$n";
+		}
+	} else {
+		while (quiet_run(qw/svn ls --non-interactive/, $url)) {
+			my $n = shift @paths || last;
+			$url .= "/$n";
+		}
 	}
 	push @repo_path_split_cache, qr/^(\Q$url\E)/;
 	$path = join('/',@paths);
@@ -797,6 +1006,7 @@ sub setup_git_svn {
 }
 
 sub assert_svn_wc_clean {
+	return if $_use_lib;
 	my ($svn_rev) = @_;
 	croak "$svn_rev is not an integer!\n" unless ($svn_rev =~ /^\d+$/);
 	my $lcr = svn_info('.')->{'Last Changed Rev'};
@@ -819,7 +1029,7 @@ sub assert_svn_wc_clean {
 	}
 }
 
-sub assert_tree {
+sub get_tree_from_treeish {
 	my ($treeish) = @_;
 	croak "Not a sha1: $treeish\n" unless $treeish =~ /^$sha1$/o;
 	chomp(my $type = `git-cat-file -t $treeish`);
@@ -836,20 +1046,22 @@ sub assert_tree {
 	} else {
 		die "$treeish is a $type, expected tree, tag or commit\n";
 	}
+	return $expected;
+}
+
+sub assert_tree {
+	return if $_use_lib;
+	my ($treeish) = @_;
+	my $expected = get_tree_from_treeish($treeish);
 
-	my $old_index = $ENV{GIT_INDEX_FILE};
 	my $tmpindex = $GIT_SVN_INDEX.'.assert-tmp';
 	if (-e $tmpindex) {
 		unlink $tmpindex or croak $!;
 	}
-	$ENV{GIT_INDEX_FILE} = $tmpindex;
+	my $old_index = set_index($tmpindex);
 	index_changes(1);
 	chomp(my $tree = `git-write-tree`);
-	if ($old_index) {
-		$ENV{GIT_INDEX_FILE} = $old_index;
-	} else {
-		delete $ENV{GIT_INDEX_FILE};
-	}
+	restore_index($old_index);
 	if ($tree ne $expected) {
 		croak "Tree mismatch, Got: $tree, Expected: $expected\n";
 	}
@@ -987,7 +1199,8 @@ sub precommit_check {
 	}
 }
 
-sub svn_checkout_tree {
+
+sub get_diff {
 	my ($svn_rev, $treeish) = @_;
 	my $from = file_to_s("$REV_DIR/$svn_rev");
 	assert_tree($from);
@@ -1005,11 +1218,13 @@ sub svn_checkout_tree {
 		push @diff_tree, "-l$_l" if defined $_l;
 		exec(@diff_tree, $from, $treeish) or croak $!;
 	}
-	my $mods = parse_diff_tree($diff_fh);
-	unless (@$mods) {
-		# git can do empty commits, but SVN doesn't allow it...
-		return $mods;
-	}
+	return parse_diff_tree($diff_fh);
+}
+
+sub svn_checkout_tree {
+	my ($svn_rev, $treeish) = @_;
+	my $mods = get_diff($svn_rev, $treeish);
+	return $mods unless (scalar @$mods);
 	my ($rm, $add) = precommit_check($mods);
 
 	my %o = ( D => 1, R => 0, C => -1, A => 3, M => 3, T => 3 );
@@ -1052,6 +1267,23 @@ sub svn_checkout_tree {
 	return $mods;
 }
 
+sub libsvn_checkout_tree {
+	my ($svn_rev, $treeish, $ed) = @_;
+	my $mods = get_diff($svn_rev, $treeish);
+	return $mods unless (scalar @$mods);
+	my %o = ( D => 1, R => 0, C => -1, A => 3, M => 3, T => 3 );
+	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
+		my $f = $m->{chg};
+		if (defined $o{$f}) {
+			$ed->$f($m);
+		} else {
+			croak "Invalid change type: $f\n";
+		}
+	}
+	$ed->rmdirs if $_rmdir;
+	return $mods;
+}
+
 # svn ls doesn't work with respect to the current working tree, but what's
 # in the repository.  There's not even an option for it... *sigh*
 # (added files don't show up and removed files remain in the ls listing)
@@ -1090,12 +1322,12 @@ sub handle_rmdir {
 	}
 }
 
-sub svn_commit_tree {
-	my ($svn_rev, $commit) = @_;
-	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
+sub get_commit_message {
+	my ($commit, $commit_msg) = (@_);
 	my %log_msg = ( msg => '' );
 	open my $msg, '>', $commit_msg or croak $!;
 
+	print "commit: $commit\n";
 	chomp(my $type = `git-cat-file -t $commit`);
 	if ($type eq 'commit') {
 		my $pid = open my $msg_fh, '-|';
@@ -1129,7 +1361,14 @@ sub svn_commit_tree {
 	{ local $/; chomp($log_msg{msg} = <$msg>); }
 	close $msg or croak $!;
 
-	my ($oneline) = ($log_msg{msg} =~ /([^\n\r]+)/);
+	return \%log_msg;
+}
+
+sub svn_commit_tree {
+	my ($svn_rev, $commit) = @_;
+	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
+	my $log_msg = get_commit_message($commit, $commit_msg);
+	my ($oneline) = ($log_msg->{msg} =~ /([^\n\r]+)/);
 	print "Committing $commit: $oneline\n";
 
 	if (defined $LC_ALL) {
@@ -1165,12 +1404,12 @@ sub svn_commit_tree {
 					/(\d{4})\-(\d\d)\-(\d\d)\s
 					 (\d\d)\:(\d\d)\:(\d\d)\s([\-\+]\d+)/x)
 					 or croak "Failed to parse date: $date\n";
-		$log_msg{date} = "$tz $Y-$m-$d $H:$M:$S";
-		$log_msg{author} = $info->{'Last Changed Author'};
-		$log_msg{revision} = $committed;
-		$log_msg{msg} .= "\n";
+		$log_msg->{date} = "$tz $Y-$m-$d $H:$M:$S";
+		$log_msg->{author} = $info->{'Last Changed Author'};
+		$log_msg->{revision} = $committed;
+		$log_msg->{msg} .= "\n";
 		my $parent = file_to_s("$REV_DIR/$svn_rev");
-		git_commit(\%log_msg, $parent, $commit);
+		git_commit($log_msg, $parent, $commit);
 		return $committed;
 	}
 	# resync immediately
@@ -1335,8 +1574,14 @@ sub eol_cp {
 	binmode $rfd or croak $!;
 	open my $wfd, '>', $to or croak $!;
 	binmode $wfd or croak $!;
+	eol_cp_fd($rfd, $wfd, $es);
+	close $rfd or croak $!;
+	close $wfd or croak $!;
+}
 
-	my $eol = $EOL{$es} or undef;
+sub eol_cp_fd {
+	my ($rfd, $wfd, $es) = @_;
+	my $eol = defined $es ? $EOL{$es} : undef;
 	my $buf;
 	use bytes;
 	while (1) {
@@ -1396,6 +1641,7 @@ sub do_update_index {
 }
 
 sub index_changes {
+	return if $_use_lib;
 	my $no_text_base = shift;
 	do_update_index([qw/git-diff-files --name-only -z/],
 			'remove',
@@ -1459,63 +1705,59 @@ sub assert_revision_eq_or_unknown {
 sub git_commit {
 	my ($log_msg, @parents) = @_;
 	assert_revision_unknown($log_msg->{revision});
-	my $out_fh = IO::File->new_tmpfile or croak $!;
-
 	map_tree_joins() if (@_branch_from && !%tree_map);
 
+	my (@tmp_parents, @exec_parents, %seen_parent);
+	if (my $lparents = $log_msg->{parents}) {
+		@tmp_parents = @$lparents
+	}
 	# commit parents can be conditionally bound to a particular
 	# svn revision via: "svn_revno=commit_sha1", filter them out here:
-	my @exec_parents;
 	foreach my $p (@parents) {
 		next unless defined $p;
 		if ($p =~ /^(\d+)=($sha1_short)$/o) {
 			if ($1 == $log_msg->{revision}) {
-				push @exec_parents, $2;
+				push @tmp_parents, $2;
 			}
 		} else {
-			push @exec_parents, $p if $p =~ /$sha1_short/o;
+			push @tmp_parents, $p if $p =~ /$sha1_short/o;
 		}
 	}
-
-	my $pid = fork;
-	defined $pid or croak $!;
-	if ($pid == 0) {
-		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
+	my $tree = $log_msg->{tree};
+	if (!defined $tree) {
+		my $index = set_index($GIT_SVN_INDEX);
 		index_changes();
-		chomp(my $tree = `git-write-tree`);
+		chomp($tree = `git-write-tree`);
 		croak $? if $?;
-		if (exists $tree_map{$tree}) {
-			my %seen_parent = map { $_ => 1 } @exec_parents;
-			foreach (@{$tree_map{$tree}}) {
-				# MAXPARENT is defined to 16 in commit-tree.c:
-				if ($seen_parent{$_} || @exec_parents > 16) {
-					next;
-				}
-				push @exec_parents, $_;
-				$seen_parent{$_} = 1;
-			}
-		}
+		restore_index($index);
+	}
+	if (exists $tree_map{$tree}) {
+		push @tmp_parents, @{$tree_map{$tree}};
+	}
+	foreach (@tmp_parents) {
+		next if $seen_parent{$_};
+		$seen_parent{$_} = 1;
+		push @exec_parents, $_;
+		# MAXPARENT is defined to 16 in commit-tree.c:
+		last if @exec_parents > 16;
+	}
+
+	defined(my $pid = open my $out_fh, '-|') or croak $!;
+	if ($pid == 0) {
 		my $msg_fh = IO::File->new_tmpfile or croak $!;
 		print $msg_fh $log_msg->{msg}, "\ngit-svn-id: ",
 					"$SVN_URL\@$log_msg->{revision}",
 					" $SVN_UUID\n" or croak $!;
 		$msg_fh->flush == 0 or croak $!;
 		seek $msg_fh, 0, 0 or croak $!;
-
 		set_commit_env($log_msg);
-
 		my @exec = ('git-commit-tree',$tree);
 		push @exec, '-p', $_  foreach @exec_parents;
 		open STDIN, '<&', $msg_fh or croak $!;
-		open STDOUT, '>&', $out_fh or croak $!;
 		exec @exec or croak $!;
 	}
-	waitpid($pid,0);
-	croak $? if $?;
-
-	$out_fh->flush == 0 or croak $!;
-	seek $out_fh, 0, 0 or croak $!;
 	chomp(my $commit = do { local $/; <$out_fh> });
+	close $out_fh or croak $?;
 	if ($commit !~ /^$sha1$/o) {
 		croak "Failed to commit, invalid sha1: $commit\n";
 	}
@@ -1534,6 +1776,7 @@ sub git_commit {
 	}
 	sys(@update_ref);
 	sys('git-update-ref',"svn/$GIT_SVN/revs/$log_msg->{revision}",$commit);
+	# this output is read via pipe, do not change:
 	print "r$log_msg->{revision} = $commit\n";
 	if ($_repack && (--$_repack_nr == 0)) {
 		$_repack_nr = $_repack;
@@ -1545,6 +1788,9 @@ sub git_commit {
 sub set_commit_env {
 	my ($log_msg) = @_;
 	my $author = $log_msg->{author};
+	if (!defined $author || length $author == 0) {
+		$author = '(no author)';
+	}
 	my ($name,$email) = defined $users{$author} ?  @{$users{$author}}
 				: ($author,"$author\@$SVN_UUID");
 	$ENV{GIT_AUTHOR_NAME} = $ENV{GIT_COMMITTER_NAME} = $name;
@@ -2029,6 +2275,612 @@ sub show_commit_normal {
 	}
 }
 
+sub libsvn_load {
+	return unless $_use_lib;
+	$_use_lib = eval {
+		require SVN::Core;
+		if ($SVN::Core::VERSION lt '1.2.1') {
+			die "Need SVN::Core 1.2.1 or better ",
+					"(got $SVN::Core::VERSION) ",
+					"Falling back to command-line svn\n";
+		}
+		require SVN::Ra;
+		require SVN::Delta;
+		push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
+		my $kill_stupid_warnings = $SVN::Node::none.$SVN::Node::file.
+					$SVN::Node::dir.$SVN::Node::unknown.
+					$SVN::Node::none.$SVN::Node::file.
+					$SVN::Node::dir.$SVN::Node::unknown;
+		1;
+	};
+}
+
+sub libsvn_connect {
+	my ($url) = @_;
+	my $auth = SVN::Core::auth_open([SVN::Client::get_simple_provider(),
+			  SVN::Client::get_ssl_server_trust_file_provider(),
+			  SVN::Client::get_username_provider()]);
+	my $s = eval { SVN::Ra->new(url => $url, auth => $auth) };
+	return $s;
+}
+
+sub libsvn_get_file {
+	my ($gui, $f, $rev) = @_;
+	my $p = $f;
+	return unless ($p =~ s#^\Q$SVN_PATH\E/?##);
+
+	my $fd = IO::File->new_tmpfile or croak $!;
+	my $pool = SVN::Pool->new;
+	my ($r, $props) = $SVN->get_file($f, $rev, $fd, $pool);
+	$pool->clear;
+	$fd->flush == 0 or croak $!;
+	seek $fd, 0, 0 or croak $!;
+	if (my $es = $props->{'svn:eol-style'}) {
+		my $new_fd = IO::File->new_tmpfile or croak $!;
+		eol_cp_fd($fd, $new_fd, $es);
+		close $fd or croak $!;
+		$fd = $new_fd;
+		seek $fd, 0, 0 or croak $!;
+		$fd->flush == 0 or croak $!;
+	}
+	my $mode = '100644';
+	if (exists $props->{'svn:executable'}) {
+		$mode = '100755';
+	}
+	if (exists $props->{'svn:special'}) {
+		$mode = '120000';
+		local $/;
+		my $link = <$fd>;
+		$link =~ s/^link // or die "svn:special file with contents: <",
+						$link, "> is not understood\n";
+		seek $fd, 0, 0 or croak $!;
+		truncate $fd, 0 or croak $!;
+		print $fd $link or croak $!;
+		seek $fd, 0, 0 or croak $!;
+		$fd->flush == 0 or croak $!;
+	}
+	my $pid = open my $ho, '-|';
+	defined $pid or croak $!;
+	if (!$pid) {
+		open STDIN, '<&', $fd or croak $!;
+		exec qw/git-hash-object -w --stdin/ or croak $!;
+	}
+	chomp(my $hash = do { local $/; <$ho> });
+	close $ho or croak $?;
+	$hash =~ /^$sha1$/o or die "not a sha1: $hash\n";
+	print $gui $mode,' ',$hash,"\t",$p,"\0" or croak $!;
+	close $fd or croak $!;
+}
+
+sub libsvn_log_entry {
+	my ($rev, $author, $date, $msg, $parents) = @_;
+	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
+					 (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x)
+				or die "Unable to parse date: $date\n";
+	if (defined $_authors && ! defined $users{$author}) {
+		die "Author: $author not defined in $_authors file\n";
+	}
+	return { revision => $rev, date => "+0000 $Y-$m-$d $H:$M:$S",
+		author => $author, msg => $msg."\n", parents => $parents || [] }
+}
+
+sub process_rm {
+	my ($gui, $last_commit, $f) = @_;
+	$f =~ s#^\Q$SVN_PATH\E/?## or return;
+	# remove entire directories.
+	if (safe_qx('git-ls-tree',$last_commit,'--',$f) =~ /^040000 tree/) {
+		defined(my $pid = open my $ls, '-|') or croak $!;
+		if (!$pid) {
+			exec(qw/git-ls-tree -r --name-only -z/,
+				$last_commit,'--',$f) or croak $!;
+		}
+		local $/ = "\0";
+		while (<$ls>) {
+			print $gui '0 ',0 x 40,"\t",$_ or croak $!;
+		}
+		close $ls or croak $!;
+	} else {
+		print $gui '0 ',0 x 40,"\t",$f,"\0" or croak $!;
+	}
+}
+
+sub libsvn_fetch {
+	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
+	open my $gui, '| git-update-index -z --index-info' or croak $!;
+	my @amr;
+	foreach my $f (keys %$paths) {
+		my $m = $paths->{$f}->action();
+		$f =~ s#^/+##;
+		if ($m =~ /^[DR]$/) {
+			process_rm($gui, $last_commit, $f);
+			next if $m eq 'D';
+			# 'R' can be file replacements, too, right?
+		}
+		my $pool = SVN::Pool->new;
+		my $t = $SVN->check_path($f, $rev, $pool);
+		if ($t == $SVN::Node::file) {
+			if ($m =~ /^[AMR]$/) {
+				push @amr, $f;
+			} else {
+				die "Unrecognized action: $m, ($f r$rev)\n";
+			}
+		}
+		$pool->clear;
+	}
+	libsvn_get_file($gui, $_, $rev) foreach (@amr);
+	close $gui or croak $!;
+	return libsvn_log_entry($rev, $author, $date, $msg, [$last_commit]);
+}
+
+sub svn_grab_base_rev {
+	defined(my $pid = open my $fh, '-|') or croak $!;
+	if (!$pid) {
+		open my $null, '>', '/dev/null' or croak $!;
+		open STDERR, '>&', $null or croak $!;
+		exec qw/git-rev-parse --verify/,"refs/remotes/$GIT_SVN^0"
+								or croak $!;
+	}
+	chomp(my $c = do { local $/; <$fh> });
+	close $fh;
+	if (defined $c && length $c) {
+		my ($url, $rev, $uuid) = extract_metadata((grep(/^git-svn-id: /,
+			safe_qx(qw/git-cat-file commit/, $c)))[0]);
+		return ($rev, $c);
+	}
+	return (undef, undef);
+}
+
+sub libsvn_parse_revision {
+	my $base = shift;
+	my $head = $SVN->get_latest_revnum();
+	if (!defined $_revision || $_revision eq 'BASE:HEAD') {
+		return ($base + 1, $head) if (defined $base);
+		return (0, $head);
+	}
+	return ($1, $2) if ($_revision =~ /^(\d+):(\d+)$/);
+	return ($_revision, $_revision) if ($_revision =~ /^\d+$/);
+	if ($_revision =~ /^BASE:(\d+)$/) {
+		return ($base + 1, $1) if (defined $base);
+		return (0, $head);
+	}
+	return ($1, $head) if ($_revision =~ /^(\d+):HEAD$/);
+	die "revision argument: $_revision not understood by git-svn\n",
+		"Try using the command-line svn client instead\n";
+}
+
+sub libsvn_traverse {
+	my ($gui, $pfx, $path, $rev) = @_;
+	my $cwd = "$pfx/$path";
+	my $pool = SVN::Pool->new;
+	$cwd =~ s#^/+##g;
+	my ($dirent, $r, $props) = $SVN->get_dir($cwd, $rev, $pool);
+	foreach my $d (keys %$dirent) {
+		my $t = $dirent->{$d}->kind;
+		if ($t == $SVN::Node::dir) {
+			libsvn_traverse($gui, $cwd, $d, $rev);
+		} elsif ($t == $SVN::Node::file) {
+			libsvn_get_file($gui, "$cwd/$d", $rev);
+		}
+	}
+	$pool->clear;
+}
+
+sub libsvn_traverse_ignore {
+	my ($fh, $path, $r) = @_;
+	$path =~ s#^/+##g;
+	my $pool = SVN::Pool->new;
+	my ($dirent, undef, $props) = $SVN->get_dir($path, $r, $pool);
+	my $p = $path;
+	$p =~ s#^\Q$SVN_PATH\E/?##;
+	print $fh length $p ? "\n# $p\n" : "\n# /\n";
+	if (my $s = $props->{'svn:ignore'}) {
+		$s =~ s/[\r\n]+/\n/g;
+		chomp $s;
+		if (length $p == 0) {
+			$s =~ s#\n#\n/$p#g;
+			print $fh "/$s\n";
+		} else {
+			$s =~ s#\n#\n/$p/#g;
+			print $fh "/$p/$s\n";
+		}
+	}
+	foreach (sort keys %$dirent) {
+		next if $dirent->{$_}->kind != $SVN::Node::dir;
+		libsvn_traverse_ignore($fh, "$path/$_", $r);
+	}
+	$pool->clear;
+}
+
+sub libsvn_new_tree {
+	my ($paths, $rev, $author, $date, $msg) = @_;
+	my $svn_path = '/'.$SVN_PATH;
+
+	# look for a parent from another branch:
+	foreach (keys %$paths) {
+		next if ($_ ne $svn_path);
+		my $i = $paths->{$_};
+		my $branch_from = $i->copyfrom_path or next;
+		my $r = $i->copyfrom_rev;
+		print STDERR  "Found possible branch point: ",
+			"$branch_from => $svn_path, $r\n";
+		$branch_from =~ s#^/##;
+		my $l_map = read_url_paths();
+		my $url = $SVN->{url};
+		defined $l_map->{$url} or next;
+		my $id  = $l_map->{$url}->{$branch_from} or next;
+		my $f = "$GIT_DIR/svn/$id/revs/$r";
+		while ($r && !-r $f) {
+			$r--;
+			$f = "$GIT_DIR/svn/$id/revs/$r";
+		}
+		if (-r $f) {
+			my $parent = file_to_s($f);
+			unlink $GIT_SVN_INDEX;
+			print STDERR "Found branch parent: $parent\n";
+			sys(qw/git-read-tree/, $parent);
+			return libsvn_fetch($parent, $paths, $rev,
+						$author, $date, $msg);
+		}
+		print STDERR "Nope, branch point not imported or unknown\n";
+	}
+	open my $gui, '| git-update-index -z --index-info' or croak $!;
+	my $pool = SVN::Pool->new;
+	libsvn_traverse($gui, '', $SVN_PATH, $rev, $pool);
+	$pool->clear;
+	close $gui or croak $!;
+	return libsvn_log_entry($rev, $author, $date, $msg);
+}
+
+sub find_graft_path_commit {
+	my ($tree_paths, $p1, $r1) = @_;
+	foreach my $x (keys %$tree_paths) {
+		next unless ($p1 =~ /^\Q$x\E/);
+		my $i = $tree_paths->{$x};
+		my $f = "$GIT_DIR/svn/$i/revs/$r1";
+
+		return file_to_s($f) if (-r $f);
+
+		print STDERR "r$r1 of $i not imported\n";
+		next;
+	}
+	return undef;
+}
+
+sub find_graft_path_parents {
+	my ($grafts, $tree_paths, $c, $p0, $r0) = @_;
+	foreach my $x (keys %$tree_paths) {
+		next unless ($p0 =~ /^\Q$x\E/);
+		my $i = $tree_paths->{$x};
+		my $f = "$GIT_DIR/svn/$i/revs/$r0";
+		while ($r0 && !-r $f) {
+			# could be an older revision, too...
+			$r0--;
+			$f = "$GIT_DIR/svn/$i/revs/$r0";
+		}
+		unless (-r $f) {
+			print STDERR "r$r0 of $i not imported\n";
+			next;
+		}
+		my $parent = file_to_s($f);
+		$grafts->{$c}->{$parent} = 1;
+	}
+}
+
+sub libsvn_graft_file_copies {
+	my ($grafts, $tree_paths, $path, $paths, $rev) = @_;
+	foreach (keys %$paths) {
+		my $i = $paths->{$_};
+		my ($m, $p0, $r0) = ($i->action, $i->copyfrom_path,
+					$i->copyfrom_rev);
+		next unless (defined $p0 && defined $r0);
+
+		my $p1 = $_;
+		$p1 =~ s#^/##;
+		$p0 =~ s#^/##;
+		my $c = find_graft_path_commit($tree_paths, $p1, $rev);
+		next unless $c;
+		find_graft_path_parents($grafts, $tree_paths, $c, $p0, $r0);
+	}
+}
+
+sub set_index {
+	my $old = $ENV{GIT_INDEX_FILE};
+	$ENV{GIT_INDEX_FILE} = shift;
+	return $old;
+}
+
+sub restore_index {
+	my ($old) = @_;
+	if (defined $old) {
+		$ENV{GIT_INDEX_FILE} = $old;
+	} else {
+		delete $ENV{GIT_INDEX_FILE};
+	}
+}
+
+sub libsvn_commit_cb {
+	my ($rev, $date, $committer, $c, $msg, $r_last, $cmt_last) = @_;
+	if ($rev == ($r_last + 1)) {
+		# optimized (avoid fetch)
+		my $log = libsvn_log_entry($rev,$committer,$date,$msg);
+		$log->{tree} = get_tree_from_treeish($c);
+		my $cmt = git_commit($log, $cmt_last, $c);
+		my @diff = safe_qx('git-diff-tree', $cmt, $c);
+		if (@diff) {
+			print STDERR "Trees differ: $cmt $c\n",
+					join('',@diff),"\n";
+			exit 1;
+		}
+	} else {
+		fetch_lib("$rev=$c");
+	}
+}
+
+sub libsvn_ls_fullurl {
+	my $fullurl = shift;
+	my ($repo, $path) = repo_path_split($fullurl);
+	$SVN ||= libsvn_connect($repo);
+	my @ret;
+	my $pool = SVN::Pool->new;
+	my ($dirent, undef, undef) = $SVN->get_dir($path,
+						$SVN->get_latest_revnum, $pool);
+	foreach my $d (keys %$dirent) {
+		if ($dirent->{$d}->kind == $SVN::Node::dir) {
+			push @ret, "$d/"; # add '/' for compat with cli svn
+		}
+	}
+	$pool->clear;
+	return @ret;
+}
+
+
+sub libsvn_skip_unknown_revs {
+	my $err = shift;
+	my $errno = $err->apr_err();
+	# Maybe the branch we're tracking didn't
+	# exist when the repo started, so it's
+	# not an error if it doesn't, just continue
+	#
+	# Wonderfully consistent library, eh?
+	# 160013 - svn:// and file://
+	# 175002 - http(s)://
+	#   More codes may be discovered later...
+	if ($errno == 175002 || $errno == 160013) {
+		print STDERR "directory non-existent\n";
+		return;
+	}
+	croak "Error from SVN, ($errno): ", $err->expanded_message,"\n";
+};
+
+package SVN::Git::Editor;
+use vars qw/@ISA/;
+use strict;
+use warnings;
+use Carp qw/croak/;
+use IO::File;
+
+sub new {
+	my $class = shift;
+	my $git_svn = shift;
+	my $self = SVN::Delta::Editor->new(@_);
+	bless $self, $class;
+	foreach (qw/svn_path c r ra /) {
+		die "$_ required!\n" unless (defined $git_svn->{$_});
+		$self->{$_} = $git_svn->{$_};
+	}
+	$self->{pool} = SVN::Pool->new;
+	$self->{bat} = { '' => $self->open_root($self->{r}, $self->{pool}) };
+	$self->{rm} = { };
+	require Digest::MD5;
+	return $self;
+}
+
+sub split_path {
+	return ($_[0] =~ m#^(.*?)/?([^/]+)$#);
+}
+
+sub repo_path {
+	(defined $_[1] && length $_[1]) ? "$_[0]->{svn_path}/$_[1]"
+					: $_[0]->{svn_path}
+}
+
+sub url_path {
+	my ($self, $path) = @_;
+	$self->{ra}->{url} . '/' . $self->repo_path($path);
+}
+
+sub rmdirs {
+	my ($self) = @_;
+	my $rm = $self->{rm};
+	delete $rm->{''}; # we never delete the url we're tracking
+	return unless %$rm;
+
+	foreach (keys %$rm) {
+		my @d = split m#/#, $_;
+		my $c = shift @d;
+		$rm->{$c} = 1;
+		while (@d) {
+			$c .= '/' . shift @d;
+			$rm->{$c} = 1;
+		}
+	}
+	delete $rm->{$self->{svn_path}};
+	delete $rm->{''}; # we never delete the url we're tracking
+	return unless %$rm;
+
+	defined(my $pid = open my $fh,'-|') or croak $!;
+	if (!$pid) {
+		exec qw/git-ls-tree --name-only -r -z/, $self->{c} or croak $!;
+	}
+	local $/ = "\0";
+	while (<$fh>) {
+		chomp;
+		$_ = $self->{svn_path} . '/' . $_;
+		my ($dn) = ($_ =~ m#^(.*?)/?(?:[^/]+)$#);
+		delete $rm->{$dn};
+		last unless %$rm;
+	}
+	my ($r, $p, $bat) = ($self->{r}, $self->{pool}, $self->{bat});
+	foreach my $d (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$rm) {
+		$self->close_directory($bat->{$d}, $p);
+		my ($dn) = ($d =~ m#^(.*?)/?(?:[^/]+)$#);
+		$self->SUPER::delete_entry($d, $r, $bat->{$dn}, $p);
+		delete $bat->{$d};
+	}
+}
+
+sub open_or_add_dir {
+	my ($self, $full_path, $baton) = @_;
+	my $p = SVN::Pool->new;
+	my $t = $self->{ra}->check_path($full_path, $self->{r}, $p);
+	$p->clear;
+	if ($t == $SVN::Node::none) {
+		return $self->add_directory($full_path, $baton,
+						undef, -1, $self->{pool});
+	} elsif ($t == $SVN::Node::dir) {
+		return $self->open_directory($full_path, $baton,
+						$self->{r}, $self->{pool});
+	}
+	print STDERR "$full_path already exists in repository at ",
+		"r$self->{r} and it is not a directory (",
+		($t == $SVN::Node::file ? 'file' : 'unknown'),"/$t)\n";
+	exit 1;
+}
+
+sub ensure_path {
+	my ($self, $path) = @_;
+	my $bat = $self->{bat};
+	$path = $self->repo_path($path);
+	return $bat->{''} unless (length $path);
+	my @p = split m#/+#, $path;
+	my $c = shift @p;
+	$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{''});
+	while (@p) {
+		my $c0 = $c;
+		$c .= '/' . shift @p;
+		$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{$c0});
+	}
+	return $bat->{$c};
+}
+
+sub A {
+	my ($self, $m) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir);
+	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
+					undef, -1);
+	$self->chg_file($fbat, $m);
+	$self->close_file($fbat,undef,$self->{pool});
+}
+
+sub C {
+	my ($self, $m) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir);
+	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
+				$self->url_path($m->{file_a}), $self->{r});
+	$self->chg_file($fbat, $m);
+	$self->close_file($fbat,undef,$self->{pool});
+}
+
+sub delete_entry {
+	my ($self, $path, $pbat) = @_;
+	my $rpath = $self->repo_path($path);
+	my ($dir, $file) = split_path($rpath);
+	$self->{rm}->{$dir} = 1;
+	$self->SUPER::delete_entry($rpath, $self->{r}, $pbat, $self->{pool});
+}
+
+sub R {
+	my ($self, $m) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir);
+	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
+				$self->url_path($m->{file_a}), $self->{r});
+	$self->chg_file($fbat, $m);
+	$self->close_file($fbat,undef,$self->{pool});
+
+	($dir, $file) = split_path($m->{file_a});
+	$pbat = $self->ensure_path($dir);
+	$self->delete_entry($m->{file_a}, $pbat);
+}
+
+sub M {
+	my ($self, $m) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir);
+	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
+				$pbat,$self->{r},$self->{pool});
+	$self->chg_file($fbat, $m);
+	$self->close_file($fbat,undef,$self->{pool});
+}
+
+sub T { shift->M(@_) }
+
+sub change_file_prop {
+	my ($self, $fbat, $pname, $pval) = @_;
+	$self->SUPER::change_file_prop($fbat, $pname, $pval, $self->{pool});
+}
+
+sub chg_file {
+	my ($self, $fbat, $m) = @_;
+	if ($m->{mode_b} =~ /755$/ && $m->{mode_a} !~ /755$/) {
+		$self->change_file_prop($fbat,'svn:executable','*');
+	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
+		$self->change_file_prop($fbat,'svn:executable',undef);
+	}
+	my $fh = IO::File->new_tmpfile or croak $!;
+	if ($m->{mode_b} =~ /^120/) {
+		print $fh 'link ' or croak $!;
+		$self->change_file_prop($fbat,'svn:special','*');
+	} elsif ($m->{mode_a} =~ /^120/ && $m->{mode_b} !~ /^120/) {
+		$self->change_file_prop($fbat,'svn:special',undef);
+	}
+	defined(my $pid = fork) or croak $!;
+	if (!$pid) {
+		open STDOUT, '>&', $fh or croak $!;
+		exec qw/git-cat-file blob/, $m->{sha1_b} or croak $!;
+	}
+	waitpid $pid, 0;
+	croak $? if $?;
+	$fh->flush == 0 or croak $!;
+	seek $fh, 0, 0 or croak $!;
+
+	my $md5 = Digest::MD5->new;
+	$md5->addfile($fh) or croak $!;
+	seek $fh, 0, 0 or croak $!;
+
+	my $exp = $md5->hexdigest;
+	my $atd = $self->apply_textdelta($fbat, undef, $self->{pool});
+	my $got = SVN::TxDelta::send_stream($fh, @$atd, $self->{pool});
+	die "Checksum mismatch\nexpected: $exp\ngot: $got\n" if ($got ne $exp);
+
+	close $fh or croak $!;
+}
+
+sub D {
+	my ($self, $m) = @_;
+	my ($dir, $file) = split_path($m->{file_b});
+	my $pbat = $self->ensure_path($dir);
+	$self->delete_entry($m->{file_b}, $pbat);
+}
+
+sub close_edit {
+	my ($self) = @_;
+	my ($p,$bat) = ($self->{pool}, $self->{bat});
+	foreach (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$bat) {
+		$self->close_directory($bat->{$_}, $p);
+	}
+	$self->SUPER::close_edit($p);
+	$p->clear;
+}
+
+sub abort_edit {
+	my ($self) = @_;
+	$self->SUPER::abort_edit($self->{pool});
+	$self->{pool}->clear;
+}
+
 __END__
 
 Data structures:
@@ -2062,3 +2914,7 @@ diff-index line ($m hash)
 	file_b => new/current file name of a file (any chg)
 }
 ;
+
+Notes:
+	I don't trust the each() function on unless I created %hash myself
+	because the internal iterator may not have started at base.
diff --git a/contrib/git-svn/t/lib-git-svn.sh b/contrib/git-svn/t/lib-git-svn.sh
index 58408a6..2843258 100644
--- a/contrib/git-svn/t/lib-git-svn.sh
+++ b/contrib/git-svn/t/lib-git-svn.sh
@@ -11,7 +11,7 @@ fi
 
 GIT_DIR=$PWD/.git
 GIT_SVN_DIR=$GIT_DIR/svn/git-svn
-SVN_TREE=$GIT_SVN_DIR/tree
+SVN_TREE=$GIT_SVN_DIR/svn-tree
 
 svnadmin >/dev/null 2>&1
 if test $? != 1
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
index 0c6ff20..c33b522 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -31,6 +31,7 @@ test_expect_success \
     'import an SVN revision into git' \
     'git-svn fetch'
 
+test_expect_success "checkout from svn" "svn co $svnrepo $SVN_TREE"
 
 name='try a deep --rmdir with a commit'
 git checkout -f -b mybranch remotes/git-svn
@@ -41,6 +42,7 @@ git commit -m "$name"
 
 test_expect_success "$name" \
     "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch &&
+     svn up $SVN_TREE &&
      test -d $SVN_TREE/dir && test ! -d $SVN_TREE/dir/a"
 
 
@@ -52,7 +54,7 @@ git update-index --remove dir/file
 git update-index --add dir/file/file
 git commit -m "$name"
 
-test_expect_code 1 "$name" \
+test_expect_failure "$name" \
     'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch' \
     || true
 
@@ -67,7 +69,7 @@ git update-index --remove -- bar/zzz
 git update-index --add -- bar
 git commit -m "$name"
 
-test_expect_code 1 "$name" \
+test_expect_failure "$name" \
     'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch2' \
     || true
 
@@ -82,7 +84,7 @@ echo yyy > bar/zzz/yyy
 git-update-index --add bar/zzz/yyy
 git commit -m "$name"
 
-test_expect_code 1 "$name" \
+test_expect_failure "$name" \
     'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch3' \
     || true
 
@@ -97,7 +99,7 @@ echo asdf > dir
 git update-index --add -- dir
 git commit -m "$name"
 
-test_expect_code 1 "$name" \
+test_expect_failure "$name" \
     'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch4' \
     || true
 
@@ -111,6 +113,7 @@ git commit -m "$name"
 
 test_expect_success "$name" \
     "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
+     svn up $SVN_TREE &&
      test ! -x $SVN_TREE/exec.sh"
 
 
@@ -121,6 +124,7 @@ git commit -m "$name"
 
 test_expect_success "$name" \
     "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
+     svn up $SVN_TREE &&
      test -x $SVN_TREE/exec.sh"
 
 
@@ -133,6 +137,7 @@ git commit -m "$name"
 
 test_expect_success "$name" \
     "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
+     svn up $SVN_TREE &&
      test -L $SVN_TREE/exec.sh"
 
 
@@ -145,6 +150,7 @@ git commit -m "$name"
 
 test_expect_success "$name" \
     "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
+     svn up $SVN_TREE &&
      test -x $SVN_TREE/bar/zzz &&
      test -L $SVN_TREE/exec-2.sh"
 
@@ -159,6 +165,7 @@ git commit -m "$name"
 
 test_expect_success "$name" \
     "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
+     svn up $SVN_TREE &&
      test -f $SVN_TREE/exec-2.sh &&
      test ! -L $SVN_TREE/exec-2.sh &&
      diff -u help $SVN_TREE/exec-2.sh"
-- 
1.4.0
