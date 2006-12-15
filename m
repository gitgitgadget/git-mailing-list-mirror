X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC/PATCH] git-svn: convert to using Git.pm
Date: Fri, 15 Dec 2006 10:59:54 -0800
Message-ID: <11662091941543-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Fri, 15 Dec 2006 19:00:11 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g0817
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34541>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvIHt-00088N-N5 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 20:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753197AbWLOS77 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 13:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbWLOS77
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 13:59:59 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58073 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753197AbWLOS75
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 13:59:57 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 2A40F7DC02A; Fri, 15 Dec 2006 10:59:55 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 15 Dec 2006
 10:59:54 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Thanks to Git.pm, I've been able to greatly reduce the amount
of extra work that needs to be done to manage input/output
pipes in Perl.

chomp usage has also been greatly reduced, too.

All tests (including full-svn-test) still pass, but this has
not been tested extensively in the real-world.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

Junio: please don't apply this to master just yet.

 git-svn.perl |  328 ++++++++++++++++++++++++----------------------------------
 1 files changed, 135 insertions(+), 193 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 73ab8d8..f453c9a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -46,6 +46,8 @@ use File::Copy qw/copy/;
 use POSIX qw/strftime/;
 use IPC::Open3;
 use Memoize;
+use Git qw/command command_oneline command_noisy
+           command_output_pipe command_input_pipe command_close_pipe/;
 memoize('revisions_eq');
 memoize('cmt_metadata');
 memoize('get_commit_time');
@@ -232,28 +234,27 @@ sub version {
 }
 
 sub rebuild {
-	if (quiet_run(qw/git-rev-parse --verify/,"refs/remotes/$GIT_SVN^0")) {
+	if (!verify_ref("refs/remotes/$GIT_SVN^0")) {
 		copy_remote_ref();
 	}
 	$SVN_URL = shift or undef;
 	my $newest_rev = 0;
 	if ($_upgrade) {
-		sys('git-update-ref',"refs/remotes/$GIT_SVN","$GIT_SVN-HEAD");
+		command_noisy('update-ref',"refs/remotes/$GIT_SVN","
+		              $GIT_SVN-HEAD");
 	} else {
 		check_upgrade_needed();
 	}
 
-	my $pid = open(my $rev_list,'-|');
-	defined $pid or croak $!;
-	if ($pid == 0) {
-		exec("git-rev-list","refs/remotes/$GIT_SVN") or croak $!;
-	}
+	my ($rev_list, $ctx) = command_output_pipe("rev-list",
+	                                           "refs/remotes/$GIT_SVN");
 	my $latest;
 	while (<$rev_list>) {
 		chomp;
 		my $c = $_;
 		croak "Non-SHA1: $c\n" unless $c =~ /^$sha1$/o;
-		my @commit = grep(/^git-svn-id: /,`git-cat-file commit $c`);
+		my @commit = grep(/^git-svn-id: /,
+		                  command(qw/cat-file commit/, $c));
 		next if (!@commit); # skip merges
 		my ($url, $rev, $uuid) = extract_metadata($commit[$#commit]);
 		if (!defined $rev || !$uuid) {
@@ -279,7 +280,7 @@ sub rebuild {
 		print "r$rev = $c\n";
 		$newest_rev = $rev if ($rev > $newest_rev);
 	}
-	close $rev_list or croak $?;
+	command_close_pipe($rev_list, $ctx);
 
 	goto out if $_use_lib;
 	if (!chdir $SVN_WC) {
@@ -287,7 +288,7 @@ sub rebuild {
 		chdir $SVN_WC or croak $!;
 	}
 
-	$pid = fork;
+	my $pid = fork;
 	defined $pid or croak $!;
 	if ($pid == 0) {
 		my @svn_up = qw(svn up);
@@ -323,10 +324,10 @@ sub init {
 
 	$SVN_URL = $url;
 	unless (-d $GIT_DIR) {
-		my @init_db = ('git-init-db');
+		my @init_db = ('init-db');
 		push @init_db, "--template=$_template" if defined $_template;
 		push @init_db, "--shared" if defined $_shared;
-		sys(@init_db);
+		command_noisy(@init_db);
 	}
 	setup_git_svn();
 }
@@ -335,9 +336,8 @@ sub fetch {
 	check_upgrade_needed();
 	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
 	my $ret = $_use_lib ? fetch_lib(@_) : fetch_cmd(@_);
-	if ($ret->{commit} && quiet_run(qw(git-rev-parse --verify
-						refs/heads/master^0))) {
-		sys(qw(git-update-ref refs/heads/master),$ret->{commit});
+	if ($ret->{commit} && !verify_ref('refs/heads/master^0')) {
+		command_noisy(qw(update-ref refs/heads/master),$ret->{commit});
 	}
 	return $ret;
 }
@@ -416,16 +416,16 @@ sub fetch_lib {
 	read_uuid();
 	if (defined $last_commit) {
 		unless (-e $GIT_SVN_INDEX) {
-			sys(qw/git-read-tree/, $last_commit);
+			command_noisy('read-tree', $last_commit);
 		}
-		chomp (my $x = `git-write-tree`);
-		my ($y) = (`git-cat-file commit $last_commit`
+		my $x = command_oneline('write-tree');
+		my ($y) = (command(qw/cat-file commit/, $last_commit)
 							=~ /^tree ($sha1)/m);
 		if ($y ne $x) {
 			unlink $GIT_SVN_INDEX or croak $!;
-			sys(qw/git-read-tree/, $last_commit);
+			command_noisy('read-tree', $last_commit);
 		}
-		chomp ($x = `git-write-tree`);
+		$x = command_oneline('write-tree');
 		if ($y ne $x) {
 			print STDERR "trees ($last_commit) $y != $x\n",
 				 "Something is seriously wrong...\n";
@@ -489,16 +489,15 @@ sub commit {
 	}
 	my @revs;
 	foreach my $c (@commits) {
-		chomp(my @tmp = safe_qx('git-rev-parse',$c));
+		my @tmp = command('rev-parse',$c);
 		if (scalar @tmp == 1) {
 			push @revs, $tmp[0];
 		} elsif (scalar @tmp > 1) {
-			push @revs, reverse (safe_qx('git-rev-list',@tmp));
+			push @revs, reverse(command('rev-list',@tmp));
 		} else {
 			die "Failed to rev-parse $c\n";
 		}
 	}
-	chomp @revs;
 	$_use_lib ? commit_lib(@revs) : commit_cmd(@revs);
 	print "Done committing ",scalar @revs," revisions to SVN\n";
 }
@@ -606,10 +605,10 @@ sub commit_lib {
 sub dcommit {
 	my $head = shift || 'HEAD';
 	my $gs = "refs/remotes/$GIT_SVN";
-	chomp(my @refs = safe_qx(qw/git-rev-list --no-merges/, "$gs..$head"));
+	my @refs = command(qw/rev-list --no-merges/, "$gs..$head");
 	my $last_rev;
 	foreach my $d (reverse @refs) {
-		if (quiet_run('git-rev-parse','--verify',"$d~1") != 0) {
+		if (!verify_ref("$d~1")) {
 			die "Commit $d\n",
 			    "has no parent commit, and therefore ",
 			    "nothing to diff against.\n",
@@ -633,7 +632,7 @@ sub dcommit {
 	}
 	return if $_dry_run;
 	fetch();
-	my @diff = safe_qx('git-diff-tree', $head, $gs);
+	my @diff = command('diff-tree', $head, $gs, '--');
 	my @finish;
 	if (@diff) {
 		@finish = qw/rebase/;
@@ -645,7 +644,7 @@ sub dcommit {
 		      "Resetting to the latest $gs\n";
 		@finish = qw/reset --mixed/;
 	}
-	sys('git', @finish, $gs);
+	command_noisy(@finish, $gs);
 }
 
 sub show_ignore {
@@ -689,7 +688,7 @@ sub graft_branches {
 
 	if (%$grafts) {
 		# temporarily disable our grafts file to make this idempotent
-		chomp($gr_sha1 = safe_qx(qw/git-hash-object -w/,$gr_file));
+		chomp($gr_sha1 = command(qw/hash-object -w/,$gr_file));
 		rename $gr_file, "$gr_file~$gr_sha1" or croak $!;
 	}
 
@@ -743,7 +742,7 @@ sub multi_init {
 	unless (-d $GIT_SVN_DIR) {
 		print "GIT_SVN_ID set to 'trunk' for $_trunk\n" if $ch_id;
 		init($_trunk);
-		sys('git-repo-config', 'svn.trunk', $_trunk);
+		command_noisy('repo-config', 'svn.trunk', $_trunk);
 	}
 	complete_url_ls_init($url, $_branches, '--branches/-b', '');
 	complete_url_ls_init($url, $_tags, '--tags/-t', 'tags/');
@@ -781,11 +780,8 @@ sub show_log {
 	}
 
 	config_pager();
-	my $pid = open(my $log,'-|');
-	defined $pid or croak $!;
-	if (!$pid) {
-		exec(git_svn_log_cmd($r_min,$r_max), @args) or croak $!;
-	}
+	@args = (git_svn_log_cmd($r_min, $r_max), @args);
+	my $log = command_output_pipe(@args);
 	run_pager();
 	my (@k, $c, $d);
 
@@ -832,7 +828,7 @@ sub show_log {
 		process_commit($_, $r_min, $r_max) foreach reverse @k;
 	}
 out:
-	close $log;
+	eval { command_close_pipe($log) };
 	print '-' x72,"\n" unless $_incremental || $_oneline;
 }
 
@@ -912,7 +908,7 @@ sub cmt_showable {
 	return 1 if defined $c->{r};
 	if ($c->{l} && $c->{l}->[-1] eq "...\n" &&
 				$c->{a_raw} =~ /\@([a-f\d\-]+)>$/) {
-		my @msg = safe_qx(qw/git-cat-file commit/, $c->{c});
+		my @msg = command(qw/cat-file commit/, $c->{c});
 		shift @msg while ($msg[0] ne "\n");
 		shift @msg;
 		@{$c->{l}} = grep !/^git-svn-id: /, @msg;
@@ -961,7 +957,7 @@ sub log_use_color {
 
 sub git_svn_log_cmd {
 	my ($r_min, $r_max) = @_;
-	my @cmd = (qw/git-log --abbrev-commit --pretty=raw
+	my @cmd = (qw/log --abbrev-commit --pretty=raw
 			--default/, "refs/remotes/$GIT_SVN");
 	push @cmd, '-r' unless $_non_recursive;
 	push @cmd, qw/--raw --name-status/ if $_verbose;
@@ -1071,7 +1067,7 @@ sub complete_url_ls_init {
 	waitpid $pid, 0;
 	croak $? if $?;
 	my ($n) = ($switch =~ /^--(\w+)/);
-	sys('git-repo-config', "svn.$n", $var);
+	command_noisy('repo-config', "svn.$n", $var);
 }
 
 sub common_prefix {
@@ -1103,11 +1099,8 @@ sub graft_tree_joins {
 
 	git_svn_each(sub {
 		my $i = shift;
-		defined(my $pid = open my $fh, '-|') or croak $!;
-		if (!$pid) {
-			exec qw/git-rev-list --pretty=raw/,
-					"refs/remotes/$i" or croak $!;
-		}
+		my @args = (qw/rev-list --pretty=raw/, "refs/remotes/$i");
+		my ($fh, $ctx) = command_output_pipe(@args);
 		while (<$fh>) {
 			next unless /^commit ($sha1)$/o;
 			my $c = $1;
@@ -1130,9 +1123,7 @@ sub graft_tree_joins {
 
 			foreach my $p (@{$tree_map{$t}}) {
 				next if $p eq $c;
-				my $mb = eval {
-					safe_qx('git-merge-base', $c, $p)
-				};
+				my $mb = eval { command('merge-base', $c, $p) };
 				next unless ($@ || $?);
 				if (defined $r_a) {
 					# see if SVN says it's a relative
@@ -1161,7 +1152,7 @@ sub graft_tree_joins {
 				# what should we do when $ct == $s ?
 			}
 		}
-		close $fh or croak $?;
+		command_close_pipe($fh, $ctx);
 	});
 }
 
@@ -1297,6 +1288,11 @@ sub read_uuid {
 	}
 }
 
+sub verify_ref {
+	my ($ref) = @_;
+	eval { command_oneline([ 'rev-parse', $ref ], { STDERR => 0 }) };
+}
+
 sub quiet_run {
 	my $pid = fork;
 	defined $pid or croak $!;
@@ -1379,13 +1375,14 @@ sub assert_svn_wc_clean {
 sub get_tree_from_treeish {
 	my ($treeish) = @_;
 	croak "Not a sha1: $treeish\n" unless $treeish =~ /^$sha1$/o;
-	chomp(my $type = `git-cat-file -t $treeish`);
+	my $type = command_oneline(qw/cat-file -t/, $treeish);
 	my $expected;
 	while ($type eq 'tag') {
-		chomp(($treeish, $type) = `git-cat-file tag $treeish`);
+		($treeish, $type) = command(qw/cat-file tag/, $treeish);
 	}
 	if ($type eq 'commit') {
-		$expected = (grep /^tree /,`git-cat-file commit $treeish`)[0];
+		$expected = (grep /^tree /, command(qw/cat-file commit/,
+		                                    $treeish))[0];
 		($expected) = ($expected =~ /^tree ($sha1)$/);
 		die "Unable to get tree from $treeish\n" unless $expected;
 	} elsif ($type eq 'tree') {
@@ -1407,7 +1404,7 @@ sub assert_tree {
 	}
 	my $old_index = set_index($tmpindex);
 	index_changes(1);
-	chomp(my $tree = `git-write-tree`);
+	my $tree = command_oneline('write-tree');
 	restore_index($old_index);
 	if ($tree ne $expected) {
 		croak "Tree mismatch, Got: $tree, Expected: $expected\n";
@@ -1415,8 +1412,20 @@ sub assert_tree {
 	unlink $tmpindex;
 }
 
-sub parse_diff_tree {
-	my $diff_fh = shift;
+sub get_diff {
+	my ($from, $treeish) = @_;
+	assert_tree($from);
+	print "diff-tree $from $treeish\n";
+	my @diff_tree = qw(diff-tree -z -r);
+	if ($_cp_similarity) {
+		push @diff_tree, "-C$_cp_similarity";
+	} else {
+		push @diff_tree, '-C';
+	}
+	push @diff_tree, '--find-copies-harder' if $_find_copies_harder;
+	push @diff_tree, "-l$_l" if defined $_l;
+	push @diff_tree, $from, $treeish;
+	my ($diff_fh, $ctx) = command_output_pipe(@diff_tree);
 	local $/ = "\0";
 	my $state = 'meta';
 	my @mods;
@@ -1452,8 +1461,7 @@ sub parse_diff_tree {
 			croak "Error parsing $_\n";
 		}
 	}
-	close $diff_fh or croak $?;
-
+	command_close_pipe($diff_fh, $ctx);
 	return \@mods;
 }
 
@@ -1547,26 +1555,6 @@ sub precommit_check {
 }
 
 
-sub get_diff {
-	my ($from, $treeish) = @_;
-	assert_tree($from);
-	print "diff-tree $from $treeish\n";
-	my $pid = open my $diff_fh, '-|';
-	defined $pid or croak $!;
-	if ($pid == 0) {
-		my @diff_tree = qw(git-diff-tree -z -r);
-		if ($_cp_similarity) {
-			push @diff_tree, "-C$_cp_similarity";
-		} else {
-			push @diff_tree, '-C';
-		}
-		push @diff_tree, '--find-copies-harder' if $_find_copies_harder;
-		push @diff_tree, "-l$_l" if defined $_l;
-		exec(@diff_tree, $from, $treeish) or croak $!;
-	}
-	return parse_diff_tree($diff_fh);
-}
-
 sub svn_checkout_tree {
 	my ($from, $treeish) = @_;
 	my $mods = get_diff($from->{commit}, $treeish);
@@ -1676,14 +1664,10 @@ sub get_commit_message {
 	my %log_msg = ( msg => '' );
 	open my $msg, '>', $commit_msg or croak $!;
 
-	chomp(my $type = `git-cat-file -t $commit`);
+	my $type = command_oneline(qw/cat-file -t/, $commit);
 	if ($type eq 'commit' || $type eq 'tag') {
-		my $pid = open my $msg_fh, '-|';
-		defined $pid or croak $!;
-
-		if ($pid == 0) {
-			exec('git-cat-file', $type, $commit) or croak $!;
-		}
+		my ($msg_fh, $ctx) = command_output_pipe('cat-file',
+		                                         $type, $commit);
 		my $in_msg = 0;
 		while (<$msg_fh>) {
 			if (!$in_msg) {
@@ -1695,7 +1679,7 @@ sub get_commit_message {
 				print $msg $_ or croak $!;
 			}
 		}
-		close $msg_fh or croak $?;
+		command_close_pipe($msg_fh, $ctx);
 	}
 	close $msg or croak $!;
 
@@ -1771,13 +1755,8 @@ sub svn_commit_tree {
 }
 
 sub rev_list_raw {
-	my (@args) = @_;
-	my $pid = open my $fh, '-|';
-	defined $pid or croak $!;
-	if (!$pid) {
-		exec(qw/git-rev-list --pretty=raw/, @args) or croak $!;
-	}
-	return { fh => $fh, t => { } };
+	my ($fh, $c) = command_output_pipe(qw/rev-list --pretty=raw/, @_);
+	return { fh => $fh, ctx => $c, t => { } };
 }
 
 sub next_rev_list_entry {
@@ -1799,6 +1778,7 @@ sub next_rev_list_entry {
 			$x->{m} .= $_;
 		}
 	}
+	command_close_pipe($fh, $rl->{ctx});
 	return ($x != $rl->{t}) ? $x : undef;
 }
 
@@ -1924,15 +1904,10 @@ sub sys { system(@_) == 0 or croak $? }
 sub do_update_index {
 	my ($z_cmd, $cmd, $no_text_base) = @_;
 
-	my $z = open my $p, '-|';
-	defined $z or croak $!;
-	unless ($z) { exec @$z_cmd or croak $! }
+	my ($p, $pctx) = command_output_pipe(@$z_cmd);
 
-	my $pid = open my $ui, '|-';
-	defined $pid or croak $!;
-	unless ($pid) {
-		exec('git-update-index',"--$cmd",'-z','--stdin') or croak $!;
-	}
+	my ($ui, $uctx) = command_input_pipe('update-index',
+	                                     "--$cmd",'-z','--stdin');
 	local $/ = "\0";
 	while (my $x = <$p>) {
 		chomp $x;
@@ -1956,7 +1931,8 @@ sub do_update_index {
 		}
 		print $ui $x,"\0";
 	}
-	close $ui or croak $?;
+	command_close_pipe($p, $pctx);
+	command_close_pipe($ui, $uctx);
 }
 
 sub index_changes {
@@ -1968,10 +1944,10 @@ sub index_changes {
 		close $fd or croak $!;
 	}
 	my $no_text_base = shift;
-	do_update_index([qw/git-diff-files --name-only -z/],
+	do_update_index([qw/diff-files --name-only -z/],
 			'remove',
 			$no_text_base);
-	do_update_index([qw/git-ls-files -z --others/,
+	do_update_index([qw/ls-files -z --others/,
 				"--exclude-from=$GIT_SVN_DIR/info/exclude"],
 			'add',
 			$no_text_base);
@@ -2004,10 +1980,10 @@ sub assert_revision_unknown {
 
 sub trees_eq {
 	my ($x, $y) = @_;
-	my @x = safe_qx('git-cat-file','commit',$x);
-	my @y = safe_qx('git-cat-file','commit',$y);
-	if (($y[0] ne $x[0]) || $x[0] !~ /^tree $sha1\n$/
-				|| $y[0] !~ /^tree $sha1\n$/) {
+	my @x = command(qw/cat-file commit/,$x);
+	my @y = command(qw/cat-file commit/,$y);
+	if (($y[0] ne $x[0]) || $x[0] ne "tree $sha1"
+		             || $y[0] ne "tree $sha1") {
 		print STDERR "Trees not equal: $y[0] != $x[0]\n";
 		return 0
 	}
@@ -2039,33 +2015,24 @@ sub git_commit {
 	if (!defined $tree) {
 		my $index = set_index($GIT_SVN_INDEX);
 		index_changes();
-		chomp($tree = `git-write-tree`);
+		$tree = command_oneline('write-tree');
 		croak $? if $?;
 		restore_index($index);
 	}
 
 	# just in case we clobber the existing ref, we still want that ref
 	# as our parent:
-	open my $null, '>', '/dev/null' or croak $!;
-	open my $stderr, '>&', \*STDERR or croak $!;
-	open STDERR, '>&', $null or croak $!;
-	if (my $cur = eval { safe_qx('git-rev-parse',
-	                             "refs/remotes/$GIT_SVN^0") }) {
+	if (my $cur = verify_ref("refs/remotes/$GIT_SVN^0")) {
 		chomp $cur;
 		push @tmp_parents, $cur;
 	}
-	open STDERR, '>&', $stderr or croak $!;
-	close $stderr or croak $!;
-	close $null or croak $!;
 
 	if (exists $tree_map{$tree}) {
 		foreach my $p (@{$tree_map{$tree}}) {
 			my $skip;
 			foreach (@tmp_parents) {
 				# see if a common parent is found
-				my $mb = eval {
-					safe_qx('git-merge-base', $_, $p)
-				};
+				my $mb = eval { command('merge-base', $_, $p) };
 				next if ($@ || $?);
 				$skip = 1;
 				last;
@@ -2107,7 +2074,7 @@ sub git_commit {
 	if ($commit !~ /^$sha1$/o) {
 		die "Failed to commit, invalid sha1: $commit\n";
 	}
-	sys('git-update-ref',"refs/remotes/$GIT_SVN",$commit);
+	command_noisy('update-ref',"refs/remotes/$GIT_SVN",$commit);
 	revdb_set($REVDB, $log_msg->{revision}, $commit);
 
 	# this output is read via pipe, do not change:
@@ -2119,7 +2086,8 @@ sub git_commit {
 sub check_repack {
 	if ($_repack && (--$_repack_nr == 0)) {
 		$_repack_nr = $_repack;
-		sys("git repack $_repack_flags");
+		# repack doesn't use any arguments with spaces in them, does it?
+		command_noisy('repack', split(/\s+/, $_repack_flags));
 	}
 }
 
@@ -2238,20 +2206,11 @@ sub check_upgrade_needed {
 		open my $fh, '>>',$REVDB or croak $!;
 		close $fh;
 	}
-	my $old = eval {
-		my $pid = open my $child, '-|';
-		defined $pid or croak $!;
-		if ($pid == 0) {
-			close STDERR;
-			exec('git-rev-parse',"$GIT_SVN-HEAD") or croak $!;
-		}
-		my @ret = (<$child>);
-		close $child or croak $?;
-		die $? if $?; # just in case close didn't error out
-		return wantarray ? @ret : join('',@ret);
+	return unless eval {
+		command([qw/rev-parse --verify/,"$GIT_SVN-HEAD^0"],
+		        {STDERR => 0});
 	};
-	return unless $old;
-	my $head = eval { safe_qx('git-rev-parse',"refs/remotes/$GIT_SVN") };
+	my $head = eval { command('rev-parse',"refs/remotes/$GIT_SVN") };
 	if ($@ || !$head) {
 		print STDERR "Please run: $0 rebuild --upgrade\n";
 		exit 1;
@@ -2263,12 +2222,8 @@ sub check_upgrade_needed {
 sub map_tree_joins {
 	my %seen;
 	foreach my $br (@_branch_from) {
-		my $pid = open my $pipe, '-|';
-		defined $pid or croak $!;
-		if ($pid == 0) {
-			exec(qw(git-rev-list --topo-order --pretty=raw), $br)
-								or croak $!;
-		}
+		my $pipe = command_output_pipe(qw/rev-list
+		                            --topo-order --pretty=raw/, $br);
 		while (<$pipe>) {
 			if (/^commit ($sha1)$/o) {
 				my $commit = $1;
@@ -2284,7 +2239,7 @@ sub map_tree_joins {
 				$seen{$commit} = 1;
 			}
 		}
-		close $pipe; # we could be breaking the pipe early
+		eval { command_close_pipe($pipe) };
 	}
 }
 
@@ -2296,7 +2251,7 @@ sub load_all_refs {
 
 	# don't worry about rev-list on non-commit objects/tags,
 	# it shouldn't blow up if a ref is a blob or tree...
-	chomp(@_branch_from = `git-rev-parse --symbolic --all`);
+	@_branch_from = command(qw/rev-parse --symbolic --all/);
 }
 
 # '<svn username> = real-name <email address>' mapping based on git-svnimport:
@@ -2330,7 +2285,7 @@ sub svn_propget_base {
 
 sub git_svn_each {
 	my $sub = shift;
-	foreach (`git-rev-parse --symbolic --all`) {
+	foreach (command(qw/rev-parse --symbolic --all/)) {
 		next unless s#^refs/remotes/##;
 		chomp $_;
 		next unless -f "$GIT_DIR/svn/$_/info/url";
@@ -2371,7 +2326,7 @@ sub migration_check {
 				"$GIT_SVN_DIR\n\t(required for this version ",
 				"($VERSION) of git-svn) does not.\n";
 
-	foreach my $x (`git-rev-parse --symbolic --all`) {
+	foreach my $x (command(qw/rev-parse --symbolic --all/)) {
 		next unless $x =~ s#^refs/remotes/##;
 		chomp $x;
 		next unless -f "$GIT_DIR/$x/info/url";
@@ -2476,11 +2431,7 @@ sub write_grafts {
 		my $p = $grafts->{$c};
 		my %x; # real parents
 		delete $p->{$c}; # commits are not self-reproducing...
-		my $pid = open my $ch, '-|';
-		defined $pid or croak $!;
-		if (!$pid) {
-			exec(qw/git-cat-file commit/, $c) or croak $!;
-		}
+		my $ch = command_output_pipe(qw/cat-file commit/, $c);
 		while (<$ch>) {
 			if (/^parent ($sha1)/) {
 				$x{$1} = $p->{$1} = 1;
@@ -2488,7 +2439,7 @@ sub write_grafts {
 				last unless /^\S/;
 			}
 		}
-		close $ch; # breaking the pipe
+		eval { command_close_pipe($ch) }; # breaking the pipe
 
 		# if real parents are the only ones in the grafts, drop it
 		next if join(' ',sort keys %$p) eq join(' ',sort keys %x);
@@ -2500,7 +2451,7 @@ sub write_grafts {
 			next if $del{$i} || $p->{$i} == 2;
 			foreach my $j (@jp) {
 				next if $i eq $j || $del{$j} || $p->{$j} == 2;
-				$mb = eval { safe_qx('git-merge-base',$i,$j) };
+				$mb = eval { command('merge-base', $i, $j) };
 				next unless $mb;
 				chomp $mb;
 				next if $x{$mb};
@@ -2571,15 +2522,12 @@ sub extract_metadata {
 
 sub cmt_metadata {
 	return extract_metadata((grep(/^git-svn-id: /,
-		safe_qx(qw/git-cat-file commit/, shift)))[-1]);
+		command(qw/cat-file commit/, shift)))[-1]);
 }
 
 sub get_commit_time {
 	my $cmt = shift;
-	defined(my $pid = open my $fh, '-|') or croak $!;
-	if (!$pid) {
-		exec qw/git-rev-list --pretty=raw -n1/, $cmt or croak $!;
-	}
+	my $fh = command_output_pipe(qw/rev-list --pretty=raw -n1/, $cmt);
 	while (<$fh>) {
 		/^committer\s(?:.+) (\d+) ([\-\+]?\d+)$/ or next;
 		my ($s, $tz) = ($1, $2);
@@ -2588,7 +2536,7 @@ sub get_commit_time {
 		} elsif ($tz =~ s/^\-//) {
 			$s -= tz_to_s_offset($tz);
 		}
-		close $fh;
+		eval { command_close_pipe($fh) };
 		return $s;
 	}
 	die "Can't get commit time for commit: $cmt\n";
@@ -2748,7 +2696,6 @@ sub libsvn_load {
 		push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
 		push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
 		*SVN::Git::Fetcher::process_rm = *process_rm;
-		*SVN::Git::Fetcher::safe_qx = *safe_qx;
 		my $kill_stupid_warnings = $SVN::Node::none.$SVN::Node::file.
 					$SVN::Node::dir.$SVN::Node::unknown.
 					$SVN::Node::none.$SVN::Node::file.
@@ -2965,7 +2912,7 @@ sub libsvn_get_file {
 	my $mode = exists $props->{'svn:executable'} ? '100755' : '100644';
 	if (exists $props->{'svn:special'}) {
 		$mode = '120000';
-		my $link = `git-cat-file blob $hash`;
+		my $link = `git-cat-file blob $hash`; # no chomping symlinks
 		$link =~ s/^link // or die "svn:special file with contents: <",
 						$link, "> is not understood\n";
 		defined($pid = open3($in, $out, '>&STDERR',
@@ -3069,19 +3016,17 @@ sub libsvn_log_entry {
 sub process_rm {
 	my ($gui, $last_commit, $f, $q) = @_;
 	# remove entire directories.
-	if (safe_qx('git-ls-tree',$last_commit,'--',$f) =~ /^040000 tree/) {
-		defined(my $pid = open my $ls, '-|') or croak $!;
-		if (!$pid) {
-			exec(qw/git-ls-tree -r --name-only -z/,
-				$last_commit,'--',$f) or croak $!;
-		}
+	if (command('ls-tree',$last_commit,'--',$f) =~ /^040000 tree/) {
+		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
+		                                     -r --name-only -z/,
+				                     $last_commit,'--',$f);
 		local $/ = "\0";
 		while (<$ls>) {
 			print $gui '0 ',0 x 40,"\t",$_ or croak $!;
 			print "\tD\t$_\n" unless $q;
 		}
 		print "\tD\t$f/\n" unless $q;
-		close $ls or croak $?;
+		command_close_pipe($ls, $ctx);
 		return $SVN::Node::dir;
 	} else {
 		print $gui '0 ',0 x 40,"\t",$f,"\0" or croak $!;
@@ -3112,7 +3057,7 @@ sub libsvn_fetch_delta {
 
 sub libsvn_fetch_full {
 	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
-	open my $gui, '| git-update-index -z --index-info' or croak $!;
+	my ($gui, $ctx) = command_input_pipe(qw/update-index -z --index-info/);
 	my %amr;
 	my $ut = { empty => {}, dir_prop => {}, file_prop => {} };
 	my $p = $SVN->{svn_path};
@@ -3166,20 +3111,14 @@ sub libsvn_fetch_full {
 		%{$ut->{dir_prop}->{''}} = %$props;
 		$pool->clear;
 	}
-	close $gui or croak $?;
+	command_close_pipe($gui, $ctx);
 	libsvn_log_entry($rev, $author, $date, $msg, [$last_commit], $ut);
 }
 
 sub svn_grab_base_rev {
-	defined(my $pid = open my $fh, '-|') or croak $!;
-	if (!$pid) {
-		open my $null, '>', '/dev/null' or croak $!;
-		open STDERR, '>&', $null or croak $!;
-		exec qw/git-rev-parse --verify/,"refs/remotes/$GIT_SVN^0"
-								or croak $!;
-	}
-	chomp(my $c = do { local $/; <$fh> });
-	close $fh;
+	my $c = eval { command_oneline([qw/rev-parse --verify/,
+	                                "refs/remotes/$GIT_SVN^0"],
+				        { STDERR => 0 }) };
 	if (defined $c && length $c) {
 		my ($url, $rev, $uuid) = cmt_metadata($c);
 		return ($rev, $c) if defined $rev;
@@ -3358,7 +3297,7 @@ sub libsvn_find_parent_branch {
 	if (revisions_eq($branch_from, $r0, $r)) {
 		unlink $GIT_SVN_INDEX;
 		print STDERR "Found branch parent: ($GIT_SVN) $parent\n";
-		sys(qw/git-read-tree/, $parent);
+		command_noisy('read-tree', $parent);
 		unless (libsvn_can_do_switch()) {
 			return libsvn_fetch_full($parent, $paths, $rev,
 						$author, $date, $msg);
@@ -3367,7 +3306,7 @@ sub libsvn_find_parent_branch {
 		# included with SVN 1.4.2 (the latest version at the moment),
 		# so we can't rely on it.
 		my $ra = libsvn_connect("$url/$branch_from");
-		my $ed = SVN::Git::Fetcher->new({c => $parent, q => $_q});
+		my $ed = SVN::Git::Fetcher->new({c => $parent, q => $_q });
 		my $pool = SVN::Pool->new;
 		my $reporter = $ra->do_switch($rev, '', 1, $SVN->{url},
 		                              $ed, $pool);
@@ -3413,9 +3352,10 @@ sub libsvn_new_tree {
 		$ut = $ed;
 	} else {
 		$ut = { empty => {}, dir_prop => {}, file_prop => {} };
-		open my $gui, '| git-update-index -z --index-info' or croak $!;
+	        my ($gui, $ctx) = command_input_pipe(qw/update-index
+	                                             -z --index-info/);
 		libsvn_traverse($gui, '', $SVN->{svn_path}, $rev, undef, $ut);
-		close $gui or croak $?;
+		command_close_pipe($gui, $ctx);
 	}
 	libsvn_log_entry($rev, $author, $date, $msg, [], $ut);
 }
@@ -3487,7 +3427,7 @@ sub libsvn_commit_cb {
 		my $log = libsvn_log_entry($rev,$committer,$date,$msg);
 		$log->{tree} = get_tree_from_treeish($c);
 		my $cmt = git_commit($log, $cmt_last, $c);
-		my @diff = safe_qx('git-diff-tree', $cmt, $c);
+		my @diff = command('diff-tree', $cmt, $c);
 		if (@diff) {
 			print STDERR "Trees differ: $cmt $c\n",
 					join('',@diff),"\n";
@@ -3579,8 +3519,8 @@ sub revdb_get {
 sub copy_remote_ref {
 	my $origin = $_cp_remote ? $_cp_remote : 'origin';
 	my $ref = "refs/remotes/$GIT_SVN";
-	if (safe_qx('git-ls-remote', $origin, $ref)) {
-		sys(qw/git fetch/, $origin, "$ref:$ref");
+	if (command('ls-remote', $origin, $ref)) {
+		command_noisy('fetch', $origin, "$ref:$ref");
 	} elsif ($_cp_remote && !$_upgrade) {
 		die "Unable to find remote reference: ",
 				"refs/remotes/$GIT_SVN on $origin\n";
@@ -3592,14 +3532,14 @@ use strict;
 use warnings;
 use Carp qw/croak/;
 use IO::File qw//;
+use Git qw/command command_oneline command_noisy
+           command_output_pipe command_input_pipe command_close_pipe/;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
 	my ($class, $git_svn) = @_;
 	my $self = SVN::Delta::Editor->new;
 	bless $self, $class;
-	open my $gui, '| git-update-index -z --index-info' or croak $!;
-	$self->{gui} = $gui;
 	$self->{c} = $git_svn->{c} if exists $git_svn->{c};
 	$self->{q} = $git_svn->{q};
 	$self->{empty} = {};
@@ -3607,6 +3547,8 @@ sub new {
 	$self->{file_prop} = {};
 	$self->{absent_dir} = {};
 	$self->{absent_file} = {};
+	($self->{gui}, $self->{ctx}) = command_input_pipe(
+	                                     qw/update-index -z --index-info/);
 	require Digest::MD5;
 	$self;
 }
@@ -3629,7 +3571,7 @@ sub delete_entry {
 
 sub open_file {
 	my ($self, $path, $pb, $rev) = @_;
-	my ($mode, $blob) = (safe_qx('git-ls-tree',$self->{c},'--',$path)
+	my ($mode, $blob) = (command('ls-tree', $self->{c}, '--',$path)
 	                     =~ /^(\d{6}) blob ([a-f\d]{40})\t/);
 	unless (defined $mode && defined $blob) {
 		die "$path was not found in commit $self->{c} (r$rev)\n";
@@ -3764,13 +3706,13 @@ sub close_file {
 
 sub abort_edit {
 	my $self = shift;
-	close $self->{gui};
+	eval { command_close_pipe($self->{gui}, $self->{ctx}) };
 	$self->SUPER::abort_edit(@_);
 }
 
 sub close_edit {
 	my $self = shift;
-	close $self->{gui} or croak $!;
+	command_close_pipe($self->{gui}, $self->{ctx});
 	$self->{git_commit_ok} = 1;
 	$self->SUPER::close_edit(@_);
 }
@@ -3781,6 +3723,8 @@ use strict;
 use warnings;
 use Carp qw/croak/;
 use IO::File;
+use Git qw/command command_oneline command_noisy
+           command_output_pipe command_input_pipe command_close_pipe/;
 
 sub new {
 	my $class = shift;
@@ -3830,10 +3774,8 @@ sub rmdirs {
 	delete $rm->{''}; # we never delete the url we're tracking
 	return unless %$rm;
 
-	defined(my $pid = open my $fh,'-|') or croak $!;
-	if (!$pid) {
-		exec qw/git-ls-tree --name-only -r -z/, $self->{c} or croak $!;
-	}
+	my ($fh, $ctx) = command_output_pipe(
+	                           qw/ls-tree --name-only -r -z/, $self->{c});
 	local $/ = "\0";
 	while (<$fh>) {
 		chomp;
@@ -3842,11 +3784,11 @@ sub rmdirs {
 			delete $rm->{join '/', @dn};
 		}
 		unless (%$rm) {
-			close $fh;
+			eval { command_close_pipe($fh) };
 			return;
 		}
 	}
-	close $fh;
+	command_close_pipe($fh, $ctx);
 
 	my ($r, $p, $bat) = ($self->{r}, $self->{pool}, $self->{bat});
 	foreach my $d (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$rm) {
-- 
1.4.4.2.g0817
