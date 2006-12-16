X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC/PATCH 1/2] git-svn: remove support for the svn command-line client
Date: Fri, 15 Dec 2006 23:58:07 -0800
Message-ID: <11662558881347-git-send-email-normalperson@yhbt.net>
References: <m28xh8amxa.fsf@ziti.local>
NNTP-Posting-Date: Sat, 16 Dec 2006 07:58:25 +0000 (UTC)
Cc: seth@hand.yhbt.net, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g0817
In-Reply-To: <m28xh8amxa.fsf@ziti.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34593>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvUQy-0003vU-Us for gcvg-git@gmane.org; Sat, 16 Dec
 2006 08:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030708AbWLPH6N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 02:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030711AbWLPH6N
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 02:58:13 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58676 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1030708AbWLPH6L
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 02:58:11 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id A4AD67DC02A; Fri, 15 Dec 2006 23:58:08 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 15 Dec 2006
 23:58:08 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Using the command-line client was great for prototyping and
getting something working quickly.  Eventually I found time
to study the library documentation and add support for using
the libraries which are much faster and more flexible when
it comes to supporting new features.

Note that we require version 1.1 of the SVN libraries, whereas
we supported the command-line svn client down to version 1.0.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

Note: this requires the Git.pm usage patch I posted earlier

 git-svn.perl                           |  883 ++------------------------------
 t/Makefile                             |   10 +-
 t/lib-git-svn.sh                       |   15 +-
 t/t9100-git-svn-basic.sh               |    4 +-
 t/t9104-git-svn-follow-parent.sh       |    7 -
 t/t9105-git-svn-commit-diff.sh         |    7 -
 t/t9106-git-svn-commit-diff-clobber.sh |    7 -
 7 files changed, 51 insertions(+), 882 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index f453c9a..077e920 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -32,17 +32,20 @@ my %SKIP = ( 'svn:wc:ra_dav:version-url' => 1,
 );
 
 sub fatal (@) { print STDERR @_; exit 1 }
-# If SVN:: library support is added, please make the dependencies
-# optional and preserve the capability to use the command-line client.
-# use eval { require SVN::... } to make it lazy load
-# We don't use any modules not in the standard Perl distribution:
+require SVN::Core; # use()-ing this causes segfaults for me... *shrug*
+require SVN::Ra;
+require SVN::Delta;
+if ($SVN::Core::VERSION lt '1.1.0') {
+	fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)\n";
+}
+push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
+push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
+*SVN::Git::Fetcher::process_rm = *process_rm;
 use Carp qw/croak/;
 use IO::File qw//;
 use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev pass_through/;
-use File::Spec qw//;
-use File::Copy qw/copy/;
 use POSIX qw/strftime/;
 use IPC::Open3;
 use Memoize;
@@ -52,22 +55,7 @@ memoize('revisions_eq');
 memoize('cmt_metadata');
 memoize('get_commit_time');
 
-my ($SVN, $_use_lib);
-
-sub nag_lib {
-	print STDERR <<EOF;
-! Please consider installing the SVN Perl libraries (version 1.1.0 or
-! newer).  You will generally get better performance and fewer bugs,
-! especially if you:
-! 1) have a case-insensitive filesystem
-! 2) replace symlinks with files (and vice-versa) in commits
-
-EOF
-}
-
-$_use_lib = 1 unless $ENV{GIT_SVN_NO_LIB};
-libsvn_load();
-nag_lib() unless $_use_lib;
+my ($SVN);
 
 my $_optimize_commits = 1 unless $ENV{GIT_SVN_NO_OPTIMIZE_COMMITS};
 my $sha1 = qr/[a-f\d]{40}/;
@@ -84,7 +72,7 @@ my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_username, $_config_dir, $_no_auth_cache, $_xfer_delta,
 	$_pager, $_color);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
-my ($_svn_co_url_revs, $_svn_pg_peg_revs, $_svn_can_do_switch);
+my ($_svn_can_do_switch);
 my @repo_path_split_cache;
 
 my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
@@ -193,7 +181,6 @@ usage(1) unless defined $cmd;
 init_vars();
 load_authors() if $_authors;
 load_all_refs() if $_branch_all_refs;
-svn_compat_check() unless $_use_lib;
 migration_check() unless $cmd =~ /^(?:init|rebuild|multi-init|commit-diff)$/;
 $cmd{$cmd}->[0]->(@ARGV);
 exit 0;
@@ -281,32 +268,6 @@ sub rebuild {
 		$newest_rev = $rev if ($rev > $newest_rev);
 	}
 	command_close_pipe($rev_list, $ctx);
-
-	goto out if $_use_lib;
-	if (!chdir $SVN_WC) {
-		svn_cmd_checkout($SVN_URL, $latest, $SVN_WC);
-		chdir $SVN_WC or croak $!;
-	}
-
-	my $pid = fork;
-	defined $pid or croak $!;
-	if ($pid == 0) {
-		my @svn_up = qw(svn up);
-		push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
-		sys(@svn_up,"-r$newest_rev");
-		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
-		index_changes();
-		exec('git-write-tree') or croak $!;
-	}
-	waitpid $pid, 0;
-	croak $? if $?;
-out:
-	if ($_upgrade) {
-		print STDERR <<"";
-Keeping deprecated refs/head/$GIT_SVN-HEAD for now.  Please remove it
-when you have upgraded your tools and habits to use refs/remotes/$GIT_SVN
-
-	}
 }
 
 sub init {
@@ -335,69 +296,13 @@ sub init {
 sub fetch {
 	check_upgrade_needed();
 	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
-	my $ret = $_use_lib ? fetch_lib(@_) : fetch_cmd(@_);
+	my $ret = fetch_lib(@_);
 	if ($ret->{commit} && !verify_ref('refs/heads/master^0')) {
 		command_noisy(qw(update-ref refs/heads/master),$ret->{commit});
 	}
 	return $ret;
 }
 
-sub fetch_cmd {
-	my (@parents) = @_;
-	my @log_args = -d $SVN_WC ? ($SVN_WC) : ($SVN_URL);
-	unless ($_revision) {
-		$_revision = -d $SVN_WC ? 'BASE:HEAD' : '0:HEAD';
-	}
-	push @log_args, "-r$_revision";
-	push @log_args, '--stop-on-copy' unless $_no_stop_copy;
-
-	my $svn_log = svn_log_raw(@log_args);
-
-	my $base = next_log_entry($svn_log) or croak "No base revision!\n";
-	# don't need last_revision from grab_base_rev() because
-	# user could've specified a different revision to skip (they
-	# didn't want to import certain revisions into git for whatever
-	# reason, so trust $base->{revision} instead.
-	my (undef, $last_commit) = svn_grab_base_rev();
-	unless (-d $SVN_WC) {
-		svn_cmd_checkout($SVN_URL,$base->{revision},$SVN_WC);
-		chdir $SVN_WC or croak $!;
-		read_uuid();
-		$last_commit = git_commit($base, @parents);
-		assert_tree($last_commit);
-	} else {
-		chdir $SVN_WC or croak $!;
-		read_uuid();
-		# looks like a user manually cp'd and svn switch'ed
-		unless ($last_commit) {
-			sys(qw/svn revert -R ./);
-			assert_svn_wc_clean($base->{revision});
-			$last_commit = git_commit($base, @parents);
-			assert_tree($last_commit);
-		}
-	}
-	my @svn_up = qw(svn up);
-	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
-	my $last = $base;
-	while (my $log_msg = next_log_entry($svn_log)) {
-		if ($last->{revision} >= $log_msg->{revision}) {
-			croak "Out of order: last >= current: ",
-				"$last->{revision} >= $log_msg->{revision}\n";
-		}
-		# Revert is needed for cases like:
-		# https://svn.musicpd.org/Jamming/trunk (r166:167), but
-		# I can't seem to reproduce something like that on a test...
-		sys(qw/svn revert -R ./);
-		assert_svn_wc_clean($last->{revision});
-		sys(@svn_up,"-r$log_msg->{revision}");
-		$last_commit = git_commit($log_msg, $last_commit, @parents);
-		$last = $log_msg;
-	}
-	close $svn_log->{fh};
-	$last->{commit} = $last_commit;
-	return $last;
-}
-
 sub fetch_lib {
 	my (@parents) = @_;
 	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
@@ -498,35 +403,10 @@ sub commit {
 			die "Failed to rev-parse $c\n";
 		}
 	}
-	$_use_lib ? commit_lib(@revs) : commit_cmd(@revs);
+	commit_lib(@revs);
 	print "Done committing ",scalar @revs," revisions to SVN\n";
 }
 
-sub commit_cmd {
-	my (@revs) = @_;
-
-	chdir $SVN_WC or croak "Unable to chdir $SVN_WC: $!\n";
-	my $info = svn_info('.');
-	my $fetched = fetch();
-	if ($info->{Revision} != $fetched->{revision}) {
-		print STDERR "There are new revisions that were fetched ",
-				"and need to be merged (or acknowledged) ",
-				"before committing.\n";
-		exit 1;
-	}
-	$info = svn_info('.');
-	read_uuid($info);
-	my $last = $fetched;
-	foreach my $c (@revs) {
-		my $mods = svn_checkout_tree($last, $c);
-		if (scalar @$mods == 0) {
-			print "Skipping, no changes detected\n";
-			next;
-		}
-		$last = svn_commit_tree($last, $c);
-	}
-}
-
 sub commit_lib {
 	my (@revs) = @_;
 	my ($r_last, $cmt_last) = svn_grab_base_rev();
@@ -649,32 +529,6 @@ sub dcommit {
 
 sub show_ignore {
 	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
-	$_use_lib ? show_ignore_lib() : show_ignore_cmd();
-}
-
-sub show_ignore_cmd {
-	require File::Find or die $!;
-	if (defined $_revision) {
-		die "-r/--revision option doesn't work unless the Perl SVN ",
-			"libraries are used\n";
-	}
-	chdir $SVN_WC or croak $!;
-	my %ign;
-	File::Find::find({wanted=>sub{if(lstat $_ && -d _ && -d "$_/.svn"){
-		s#^\./##;
-		@{$ign{$_}} = svn_propget_base('svn:ignore', $_);
-		}}, no_chdir=>1},'.');
-
-	print "\n# /\n";
-	foreach (@{$ign{'.'}}) { print '/',$_ if /\S/ }
-	delete $ign{'.'};
-	foreach my $i (sort keys %ign) {
-		print "\n# ",$i,"\n";
-		foreach (@{$ign{$i}}) { print '/',$i,'/',$_ if /\S/ }
-	}
-}
-
-sub show_ignore_lib {
 	my $repo;
 	$SVN ||= libsvn_connect($SVN_URL);
 	my $r = defined $_revision ? $_revision : $SVN->get_latest_revnum;
@@ -706,11 +560,7 @@ sub graft_branches {
 			}
 		}
 		unless ($_no_graft_copy) {
-			if ($_use_lib) {
-				graft_file_copy_lib($grafts,$l_map,$u);
-			} else {
-				graft_file_copy_cmd($grafts,$l_map,$u);
-			}
+			graft_file_copy_lib($grafts,$l_map,$u);
 		}
 	}
 	graft_tree_joins($grafts);
@@ -838,10 +688,6 @@ sub commit_diff_usage {
 }
 
 sub commit_diff {
-	if (!$_use_lib) {
-		print STDERR "commit-diff must be used with SVN libraries\n";
-		exit 1;
-	}
 	my $ta = shift or commit_diff_usage();
 	my $tb = shift or commit_diff_usage();
 	if (!eval { $SVN_URL = shift || file_to_s("$GIT_SVN_DIR/info/url") }) {
@@ -1042,8 +888,7 @@ sub complete_url_ls_init {
 		}
 		$var = $url . $var;
 	}
-	chomp(my @ls = $_use_lib ? libsvn_ls_fullurl($var)
-				: safe_qx(qw/svn ls --non-interactive/, $var));
+	my @ls = libsvn_ls_fullurl($var);
 	my $old = $GIT_SVN;
 	defined(my $pid = fork) or croak $!;
 	if (!$pid) {
@@ -1156,37 +1001,6 @@ sub graft_tree_joins {
 	});
 }
 
-# this isn't funky-filename safe, but good enough for now...
-sub graft_file_copy_cmd {
-	my ($grafts, $l_map, $u) = @_;
-	my $paths = $l_map->{$u};
-	my $pfx = common_prefix([keys %$paths]);
-	$SVN_URL ||= $u.$pfx;
-	my $pid = open my $fh, '-|';
-	defined $pid or croak $!;
-	unless ($pid) {
-		my @exec = qw/svn log -v/;
-		push @exec, "-r$_revision" if defined $_revision;
-		exec @exec, $u.$pfx or croak $!;
-	}
-	my ($r, $mp) = (undef, undef);
-	while (<$fh>) {
-		chomp;
-		if (/^\-{72}$/) {
-			$mp = $r = undef;
-		} elsif (/^r(\d+) \| /) {
-			$r = $1 unless defined $r;
-		} elsif (/^Changed paths:/) {
-			$mp = 1;
-		} elsif ($mp && m#^   [AR] /(\S.*?) \(from /(\S+?):(\d+)\)$#) {
-			my ($p1, $p0, $r0) = ($1, $2, $3);
-			my $c = find_graft_path_commit($paths, $p1, $r);
-			next unless $c;
-			find_graft_path_parents($grafts, $paths, $c, $p0, $r0);
-		}
-	}
-}
-
 sub graft_file_copy_lib {
 	my ($grafts, $l_map, $u) = @_;
 	my $tree_paths = $l_map->{$u};
@@ -1277,15 +1091,9 @@ sub graft_merge_msg {
 
 sub read_uuid {
 	return if $SVN_UUID;
-	if ($_use_lib) {
-		my $pool = SVN::Pool->new;
-		$SVN_UUID = $SVN->get_uuid($pool);
-		$pool->clear;
-	} else {
-		my $info = shift || svn_info('.');
-		$SVN_UUID = $info->{'Repository UUID'} or
-					croak "Repository UUID unreadable\n";
-	}
+	my $pool = SVN::Pool->new;
+	$SVN_UUID = $SVN->get_uuid($pool);
+	$pool->clear;
 }
 
 sub verify_ref {
@@ -1293,19 +1101,6 @@ sub verify_ref {
 	eval { command_oneline([ 'rev-parse', $ref ], { STDERR => 0 }) };
 }
 
-sub quiet_run {
-	my $pid = fork;
-	defined $pid or croak $!;
-	if (!$pid) {
-		open my $null, '>', '/dev/null' or croak $!;
-		open STDERR, '>&', $null or croak $!;
-		open STDOUT, '>&', $null or croak $!;
-		exec @_ or croak $!;
-	}
-	waitpid $pid, 0;
-	return $?;
-}
-
 sub repo_path_split {
 	my $full_url = shift;
 	$full_url =~ s#/+$##;
@@ -1317,21 +1112,8 @@ sub repo_path_split {
 			return ($u, $full_url);
 		}
 	}
-	if ($_use_lib) {
-		my $tmp = libsvn_connect($full_url);
-		return ($tmp->{repos_root}, $tmp->{svn_path});
-	} else {
-		my ($url, $path) = ($full_url =~ m!^([a-z\+]+://[^/]*)(.*)$!i);
-		$path =~ s#^/+##;
-		my @paths = split(m#/+#, $path);
-		while (quiet_run(qw/svn ls --non-interactive/, $url)) {
-			my $n = shift @paths || last;
-			$url .= "/$n";
-		}
-		push @repo_path_split_cache, qr/^(\Q$url\E)/;
-		$path = join('/',@paths);
-		return ($url, $path);
-	}
+	my $tmp = libsvn_connect($full_url);
+	return ($tmp->{repos_root}, $tmp->{svn_path});
 }
 
 sub setup_git_svn {
@@ -1347,31 +1129,6 @@ sub setup_git_svn {
 
 }
 
-sub assert_svn_wc_clean {
-	return if $_use_lib;
-	my ($svn_rev) = @_;
-	croak "$svn_rev is not an integer!\n" unless ($svn_rev =~ /^\d+$/);
-	my $lcr = svn_info('.')->{'Last Changed Rev'};
-	if ($svn_rev != $lcr) {
-		print STDERR "Checking for copy-tree ... ";
-		my @diff = grep(/^Index: /,(safe_qx(qw(svn diff),
-						"-r$lcr:$svn_rev")));
-		if (@diff) {
-			croak "Nope!  Expected r$svn_rev, got r$lcr\n";
-		} else {
-			print STDERR "OK!\n";
-		}
-	}
-	my @status = grep(!/^Performing status on external/,(`svn status`));
-	@status = grep(!/^\s*$/,@status);
-	@status = grep(!/^X/,@status) if $_no_ignore_ext;
-	if (scalar @status) {
-		print STDERR "Tree ($SVN_WC) is not clean:\n";
-		print STDERR $_ foreach @status;
-		croak;
-	}
-}
-
 sub get_tree_from_treeish {
 	my ($treeish) = @_;
 	croak "Not a sha1: $treeish\n" unless $treeish =~ /^$sha1$/o;
@@ -1393,28 +1150,8 @@ sub get_tree_from_treeish {
 	return $expected;
 }
 
-sub assert_tree {
-	return if $_use_lib;
-	my ($treeish) = @_;
-	my $expected = get_tree_from_treeish($treeish);
-
-	my $tmpindex = $GIT_SVN_INDEX.'.assert-tmp';
-	if (-e $tmpindex) {
-		unlink $tmpindex or croak $!;
-	}
-	my $old_index = set_index($tmpindex);
-	index_changes(1);
-	my $tree = command_oneline('write-tree');
-	restore_index($old_index);
-	if ($tree ne $expected) {
-		croak "Tree mismatch, Got: $tree, Expected: $expected\n";
-	}
-	unlink $tmpindex;
-}
-
 sub get_diff {
 	my ($from, $treeish) = @_;
-	assert_tree($from);
 	print "diff-tree $from $treeish\n";
 	my @diff_tree = qw(diff-tree -z -r);
 	if ($_cp_similarity) {
@@ -1465,145 +1202,6 @@ sub get_diff {
 	return \@mods;
 }
 
-sub svn_check_prop_executable {
-	my $m = shift;
-	return if -l $m->{file_b};
-	if ($m->{mode_b} =~ /755$/) {
-		chmod((0755 &~ umask),$m->{file_b}) or croak $!;
-		if ($m->{mode_a} !~ /755$/) {
-			sys(qw(svn propset svn:executable 1), $m->{file_b});
-		}
-		-x $m->{file_b} or croak "$m->{file_b} is not executable!\n";
-	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
-		sys(qw(svn propdel svn:executable), $m->{file_b});
-		chmod((0644 &~ umask),$m->{file_b}) or croak $!;
-		-x $m->{file_b} and croak "$m->{file_b} is executable!\n";
-	}
-}
-
-sub svn_ensure_parent_path {
-	my $dir_b = dirname(shift);
-	svn_ensure_parent_path($dir_b) if ($dir_b ne File::Spec->curdir);
-	mkpath([$dir_b]) unless (-d $dir_b);
-	sys(qw(svn add -N), $dir_b) unless (-d "$dir_b/.svn");
-}
-
-sub precommit_check {
-	my $mods = shift;
-	my (%rm_file, %rmdir_check, %added_check);
-
-	my %o = ( D => 0, R => 1, C => 2, A => 3, M => 3, T => 3 );
-	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
-		if ($m->{chg} eq 'R') {
-			if (-d $m->{file_b}) {
-				err_dir_to_file("$m->{file_a} => $m->{file_b}");
-			}
-			# dir/$file => dir/file/$file
-			my $dirname = dirname($m->{file_b});
-			while ($dirname ne File::Spec->curdir) {
-				if ($dirname ne $m->{file_a}) {
-					$dirname = dirname($dirname);
-					next;
-				}
-				err_file_to_dir("$m->{file_a} => $m->{file_b}");
-			}
-			# baz/zzz => baz (baz is a file)
-			$dirname = dirname($m->{file_a});
-			while ($dirname ne File::Spec->curdir) {
-				if ($dirname ne $m->{file_b}) {
-					$dirname = dirname($dirname);
-					next;
-				}
-				err_dir_to_file("$m->{file_a} => $m->{file_b}");
-			}
-		}
-		if ($m->{chg} =~ /^(D|R)$/) {
-			my $t = $1 eq 'D' ? 'file_b' : 'file_a';
-			$rm_file{ $m->{$t} } = 1;
-			my $dirname = dirname( $m->{$t} );
-			my $basename = basename( $m->{$t} );
-			$rmdir_check{$dirname}->{$basename} = 1;
-		} elsif ($m->{chg} =~ /^(?:A|C)$/) {
-			if (-d $m->{file_b}) {
-				err_dir_to_file($m->{file_b});
-			}
-			my $dirname = dirname( $m->{file_b} );
-			my $basename = basename( $m->{file_b} );
-			$added_check{$dirname}->{$basename} = 1;
-			while ($dirname ne File::Spec->curdir) {
-				if ($rm_file{$dirname}) {
-					err_file_to_dir($m->{file_b});
-				}
-				$dirname = dirname $dirname;
-			}
-		}
-	}
-	return (\%rmdir_check, \%added_check);
-
-	sub err_dir_to_file {
-		my $file = shift;
-		print STDERR "Node change from directory to file ",
-				"is not supported by Subversion: ",$file,"\n";
-		exit 1;
-	}
-	sub err_file_to_dir {
-		my $file = shift;
-		print STDERR "Node change from file to directory ",
-				"is not supported by Subversion: ",$file,"\n";
-		exit 1;
-	}
-}
-
-
-sub svn_checkout_tree {
-	my ($from, $treeish) = @_;
-	my $mods = get_diff($from->{commit}, $treeish);
-	return $mods unless (scalar @$mods);
-	my ($rm, $add) = precommit_check($mods);
-
-	my %o = ( D => 1, R => 0, C => -1, A => 3, M => 3, T => 3 );
-	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
-		if ($m->{chg} eq 'C') {
-			svn_ensure_parent_path( $m->{file_b} );
-			sys(qw(svn cp),		$m->{file_a}, $m->{file_b});
-			apply_mod_line_blob($m);
-			svn_check_prop_executable($m);
-		} elsif ($m->{chg} eq 'D') {
-			sys(qw(svn rm --force), $m->{file_b});
-		} elsif ($m->{chg} eq 'R') {
-			svn_ensure_parent_path( $m->{file_b} );
-			sys(qw(svn mv --force), $m->{file_a}, $m->{file_b});
-			apply_mod_line_blob($m);
-			svn_check_prop_executable($m);
-		} elsif ($m->{chg} eq 'M') {
-			apply_mod_line_blob($m);
-			svn_check_prop_executable($m);
-		} elsif ($m->{chg} eq 'T') {
-			svn_check_prop_executable($m);
-			apply_mod_line_blob($m);
-			if ($m->{mode_a} =~ /^120/ && $m->{mode_b} !~ /^120/) {
-				sys(qw(svn propdel svn:special), $m->{file_b});
-			} else {
-				sys(qw(svn propset svn:special *),$m->{file_b});
-			}
-		} elsif ($m->{chg} eq 'A') {
-			svn_ensure_parent_path( $m->{file_b} );
-			apply_mod_line_blob($m);
-			sys(qw(svn add), $m->{file_b});
-			svn_check_prop_executable($m);
-		} else {
-			croak "Invalid chg: $m->{chg}\n";
-		}
-	}
-
-	assert_tree($treeish);
-	if ($_rmdir) { # remove empty directories
-		handle_rmdir($rm, $add);
-	}
-	assert_tree($treeish);
-	return $mods;
-}
-
 sub libsvn_checkout_tree {
 	my ($from, $treeish, $ed) = @_;
 	my $mods = get_diff($from, $treeish);
@@ -1621,44 +1219,6 @@ sub libsvn_checkout_tree {
 	return $mods;
 }
 
-# svn ls doesn't work with respect to the current working tree, but what's
-# in the repository.  There's not even an option for it... *sigh*
-# (added files don't show up and removed files remain in the ls listing)
-sub svn_ls_current {
-	my ($dir, $rm, $add) = @_;
-	chomp(my @ls = safe_qx('svn','ls',$dir));
-	my @ret = ();
-	foreach (@ls) {
-		s#/$##; # trailing slashes are evil
-		push @ret, $_ unless $rm->{$dir}->{$_};
-	}
-	if (exists $add->{$dir}) {
-		push @ret, keys %{$add->{$dir}};
-	}
-	return \@ret;
-}
-
-sub handle_rmdir {
-	my ($rm, $add) = @_;
-
-	foreach my $dir (sort {length $b <=> length $a} keys %$rm) {
-		my $ls = svn_ls_current($dir, $rm, $add);
-		next if (scalar @$ls);
-		sys(qw(svn rm --force),$dir);
-
-		my $dn = dirname $dir;
-		$rm->{ $dn }->{ basename $dir } = 1;
-		$ls = svn_ls_current($dn, $rm, $add);
-		while (scalar @$ls == 0 && $dn ne File::Spec->curdir) {
-			sys(qw(svn rm --force),$dn);
-			$dir = basename $dn;
-			$dn = dirname $dn;
-			$rm->{ $dn }->{ $dir } = 1;
-			$ls = svn_ls_current($dn, $rm, $add);
-		}
-	}
-}
-
 sub get_commit_message {
 	my ($commit, $commit_msg) = (@_);
 	my %log_msg = ( msg => '' );
@@ -1704,56 +1264,6 @@ sub set_svn_commit_env {
 	}
 }
 
-sub svn_commit_tree {
-	my ($last, $commit) = @_;
-	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
-	my $log_msg = get_commit_message($commit, $commit_msg);
-	my ($oneline) = ($log_msg->{msg} =~ /([^\n\r]+)/);
-	print "Committing $commit: $oneline\n";
-
-	set_svn_commit_env();
-	my @ci_output = safe_qx(qw(svn commit -F),$commit_msg);
-	$ENV{LC_ALL} = 'C';
-	unlink $commit_msg;
-	my ($committed) = ($ci_output[$#ci_output] =~ /(\d+)/);
-	if (!defined $committed) {
-		my $out = join("\n",@ci_output);
-		print STDERR "W: Trouble parsing \`svn commit' output:\n\n",
-				$out, "\n\nAssuming English locale...";
-		($committed) = ($out =~ /^Committed revision \d+\./sm);
-		defined $committed or die " FAILED!\n",
-			"Commit output failed to parse committed revision!\n",
-		print STDERR " OK\n";
-	}
-
-	my @svn_up = qw(svn up);
-	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
-	if ($_optimize_commits && ($committed == ($last->{revision} + 1))) {
-		push @svn_up, "-r$committed";
-		sys(@svn_up);
-		my $info = svn_info('.');
-		my $date = $info->{'Last Changed Date'} or die "Missing date\n";
-		if ($info->{'Last Changed Rev'} != $committed) {
-			croak "$info->{'Last Changed Rev'} != $committed\n"
-		}
-		my ($Y,$m,$d,$H,$M,$S,$tz) = ($date =~
-					/(\d{4})\-(\d\d)\-(\d\d)\s
-					 (\d\d)\:(\d\d)\:(\d\d)\s([\-\+]\d+)/x)
-					 or croak "Failed to parse date: $date\n";
-		$log_msg->{date} = "$tz $Y-$m-$d $H:$M:$S";
-		$log_msg->{author} = $info->{'Last Changed Author'};
-		$log_msg->{revision} = $committed;
-		$log_msg->{msg} .= "\n";
-		$log_msg->{parents} = [ $last->{commit} ];
-		$log_msg->{commit} = git_commit($log_msg, $commit);
-		return $log_msg;
-	}
-	# resync immediately
-	push @svn_up, "-r$last->{revision}";
-	sys(@svn_up);
-	return fetch("$committed=$commit");
-}
-
 sub rev_list_raw {
 	my ($fh, $c) = command_output_pipe(qw/rev-list --pretty=raw/, @_);
 	return { fh => $fh, ctx => $c, t => { } };
@@ -1782,177 +1292,6 @@ sub next_rev_list_entry {
 	return ($x != $rl->{t}) ? $x : undef;
 }
 
-# read the entire log into a temporary file (which is removed ASAP)
-# and store the file handle + parser state
-sub svn_log_raw {
-	my (@log_args) = @_;
-	my $log_fh = IO::File->new_tmpfile or croak $!;
-	my $pid = fork;
-	defined $pid or croak $!;
-	if (!$pid) {
-		open STDOUT, '>&', $log_fh or croak $!;
-		exec (qw(svn log), @log_args) or croak $!
-	}
-	waitpid $pid, 0;
-	croak $? if $?;
-	seek $log_fh, 0, 0 or croak $!;
-	return { state => 'sep', fh => $log_fh };
-}
-
-sub next_log_entry {
-	my $log = shift; # retval of svn_log_raw()
-	my $ret = undef;
-	my $fh = $log->{fh};
-
-	while (<$fh>) {
-		chomp;
-		if (/^\-{72}$/) {
-			if ($log->{state} eq 'msg') {
-				if ($ret->{lines}) {
-					$ret->{msg} .= $_."\n";
-					unless(--$ret->{lines}) {
-						$log->{state} = 'sep';
-					}
-				} else {
-					croak "Log parse error at: $_\n",
-						$ret->{revision},
-						"\n";
-				}
-				next;
-			}
-			if ($log->{state} ne 'sep') {
-				croak "Log parse error at: $_\n",
-					"state: $log->{state}\n",
-					$ret->{revision},
-					"\n";
-			}
-			$log->{state} = 'rev';
-
-			# if we have an empty log message, put something there:
-			if ($ret) {
-				$ret->{msg} ||= "\n";
-				delete $ret->{lines};
-				return $ret;
-			}
-			next;
-		}
-		if ($log->{state} eq 'rev' && s/^r(\d+)\s*\|\s*//) {
-			my $rev = $1;
-			my ($author, $date, $lines) = split(/\s*\|\s*/, $_, 3);
-			($lines) = ($lines =~ /(\d+)/);
-			$date = '1970-01-01 00:00:00 +0000'
-				if ($_ignore_nodate && $date eq '(no date)');
-			my ($Y,$m,$d,$H,$M,$S,$tz) = ($date =~
-					/(\d{4})\-(\d\d)\-(\d\d)\s
-					 (\d\d)\:(\d\d)\:(\d\d)\s([\-\+]\d+)/x)
-					 or croak "Failed to parse date: $date\n";
-			$ret = {	revision => $rev,
-					date => "$tz $Y-$m-$d $H:$M:$S",
-					author => $author,
-					lines => $lines,
-					msg => '' };
-			if (defined $_authors && ! defined $users{$author}) {
-				die "Author: $author not defined in ",
-						"$_authors file\n";
-			}
-			$log->{state} = 'msg_start';
-			next;
-		}
-		# skip the first blank line of the message:
-		if ($log->{state} eq 'msg_start' && /^$/) {
-			$log->{state} = 'msg';
-		} elsif ($log->{state} eq 'msg') {
-			if ($ret->{lines}) {
-				$ret->{msg} .= $_."\n";
-				unless (--$ret->{lines}) {
-					$log->{state} = 'sep';
-				}
-			} else {
-				croak "Log parse error at: $_\n",
-					$ret->{revision},"\n";
-			}
-		}
-	}
-	return $ret;
-}
-
-sub svn_info {
-	my $url = shift || $SVN_URL;
-
-	my $pid = open my $info_fh, '-|';
-	defined $pid or croak $!;
-
-	if ($pid == 0) {
-		exec(qw(svn info),$url) or croak $!;
-	}
-
-	my $ret = {};
-	# only single-lines seem to exist in svn info output
-	while (<$info_fh>) {
-		chomp $_;
-		if (m#^([^:]+)\s*:\s*(\S.*)$#) {
-			$ret->{$1} = $2;
-			push @{$ret->{-order}}, $1;
-		}
-	}
-	close $info_fh or croak $?;
-	return $ret;
-}
-
-sub sys { system(@_) == 0 or croak $? }
-
-sub do_update_index {
-	my ($z_cmd, $cmd, $no_text_base) = @_;
-
-	my ($p, $pctx) = command_output_pipe(@$z_cmd);
-
-	my ($ui, $uctx) = command_input_pipe('update-index',
-	                                     "--$cmd",'-z','--stdin');
-	local $/ = "\0";
-	while (my $x = <$p>) {
-		chomp $x;
-		if (!$no_text_base && lstat $x && ! -l _ &&
-				svn_propget_base('svn:keywords', $x)) {
-			my $mode = -x _ ? 0755 : 0644;
-			my ($v,$d,$f) = File::Spec->splitpath($x);
-			my $tb = File::Spec->catfile($d, '.svn', 'tmp',
-						'text-base',"$f.svn-base");
-			$tb =~ s#^/##;
-			unless (-f $tb) {
-				$tb = File::Spec->catfile($d, '.svn',
-						'text-base',"$f.svn-base");
-				$tb =~ s#^/##;
-			}
-			my @s = stat($x);
-			unlink $x or croak $!;
-			copy($tb, $x);
-			chmod(($mode &~ umask), $x) or croak $!;
-			utime $s[8], $s[9], $x;
-		}
-		print $ui $x,"\0";
-	}
-	command_close_pipe($p, $pctx);
-	command_close_pipe($ui, $uctx);
-}
-
-sub index_changes {
-	return if $_use_lib;
-
-	if (!-f "$GIT_SVN_DIR/info/exclude") {
-		open my $fd, '>>', "$GIT_SVN_DIR/info/exclude" or croak $!;
-		print $fd '.svn',"\n";
-		close $fd or croak $!;
-	}
-	my $no_text_base = shift;
-	do_update_index([qw/diff-files --name-only -z/],
-			'remove',
-			$no_text_base);
-	do_update_index([qw/ls-files -z --others/,
-				"--exclude-from=$GIT_SVN_DIR/info/exclude"],
-			'add',
-			$no_text_base);
-}
-
 sub s_to_file {
 	my ($str, $file, $mode) = @_;
 	open my $fd,'>',$file or croak $!;
@@ -1978,18 +1317,6 @@ sub assert_revision_unknown {
 	}
 }
 
-sub trees_eq {
-	my ($x, $y) = @_;
-	my @x = command(qw/cat-file commit/,$x);
-	my @y = command(qw/cat-file commit/,$y);
-	if (($y[0] ne $x[0]) || $x[0] ne "tree $sha1"
-		             || $y[0] ne "tree $sha1") {
-		print STDERR "Trees not equal: $y[0] != $x[0]\n";
-		return 0
-	}
-	return 1;
-}
-
 sub git_commit {
 	my ($log_msg, @parents) = @_;
 	assert_revision_unknown($log_msg->{revision});
@@ -2014,12 +1341,10 @@ sub git_commit {
 	my $tree = $log_msg->{tree};
 	if (!defined $tree) {
 		my $index = set_index($GIT_SVN_INDEX);
-		index_changes();
 		$tree = command_oneline('write-tree');
 		croak $? if $?;
 		restore_index($index);
 	}
-
 	# just in case we clobber the existing ref, we still want that ref
 	# as our parent:
 	if (my $cur = verify_ref("refs/remotes/$GIT_SVN^0")) {
@@ -2104,102 +1429,6 @@ sub set_commit_env {
 	$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} = $log_msg->{date};
 }
 
-sub apply_mod_line_blob {
-	my $m = shift;
-	if ($m->{mode_b} =~ /^120/) {
-		blob_to_symlink($m->{sha1_b}, $m->{file_b});
-	} else {
-		blob_to_file($m->{sha1_b}, $m->{file_b});
-	}
-}
-
-sub blob_to_symlink {
-	my ($blob, $link) = @_;
-	defined $link or croak "\$link not defined!\n";
-	croak "Not a sha1: $blob\n" unless $blob =~ /^$sha1$/o;
-	if (-l $link || -f _) {
-		unlink $link or croak $!;
-	}
-
-	my $dest = `git-cat-file blob $blob`; # no newline, so no chomp
-	symlink $dest, $link or croak $!;
-}
-
-sub blob_to_file {
-	my ($blob, $file) = @_;
-	defined $file or croak "\$file not defined!\n";
-	croak "Not a sha1: $blob\n" unless $blob =~ /^$sha1$/o;
-	if (-l $file || -f _) {
-		unlink $file or croak $!;
-	}
-
-	open my $blob_fh, '>', $file or croak "$!: $file\n";
-	my $pid = fork;
-	defined $pid or croak $!;
-
-	if ($pid == 0) {
-		open STDOUT, '>&', $blob_fh or croak $!;
-		exec('git-cat-file','blob',$blob) or croak $!;
-	}
-	waitpid $pid, 0;
-	croak $? if $?;
-
-	close $blob_fh or croak $!;
-}
-
-sub safe_qx {
-	my $pid = open my $child, '-|';
-	defined $pid or croak $!;
-	if ($pid == 0) {
-		exec(@_) or croak $!;
-	}
-	my @ret = (<$child>);
-	close $child or croak $?;
-	die $? if $?; # just in case close didn't error out
-	return wantarray ? @ret : join('',@ret);
-}
-
-sub svn_compat_check {
-	if ($_follow_parent) {
-		print STDERR 'E: --follow-parent functionality is only ',
-				"available when SVN libraries are used\n";
-		exit 1;
-	}
-	my @co_help = safe_qx(qw(svn co -h));
-	unless (grep /ignore-externals/,@co_help) {
-		print STDERR "W: Installed svn version does not support ",
-				"--ignore-externals\n";
-		$_no_ignore_ext = 1;
-	}
-	if (grep /usage: checkout URL\[\@REV\]/,@co_help) {
-		$_svn_co_url_revs = 1;
-	}
-	if (grep /\[TARGET\[\@REV\]\.\.\.\]/, `svn propget -h`) {
-		$_svn_pg_peg_revs = 1;
-	}
-
-	# I really, really hope nobody hits this...
-	unless (grep /stop-on-copy/, (safe_qx(qw(svn log -h)))) {
-		print STDERR <<'';
-W: The installed svn version does not support the --stop-on-copy flag in
-   the log command.
-   Lets hope the directory you're tracking is not a branch or tag
-   and was never moved within the repository...
-
-		$_no_stop_copy = 1;
-	}
-}
-
-# *sigh*, new versions of svn won't honor -r<rev> without URL@<rev>,
-# (and they won't honor URL@<rev> without -r<rev>, too!)
-sub svn_cmd_checkout {
-	my ($url, $rev, $dir) = @_;
-	my @cmd = ('svn','co', "-r$rev");
-	push @cmd, '--ignore-externals' unless $_no_ignore_ext;
-	$url .= "\@$rev" if $_svn_co_url_revs;
-	sys(@cmd, $url, $dir);
-}
-
 sub check_upgrade_needed {
 	if (!-r $REVDB) {
 		-d $GIT_SVN_DIR or mkpath([$GIT_SVN_DIR]);
@@ -2277,12 +1506,6 @@ sub rload_authors {
 	close $authors or croak $!;
 }
 
-sub svn_propget_base {
-	my ($p, $f) = @_;
-	$f .= '@BASE' if $_svn_pg_peg_revs;
-	return safe_qx(qw/svn propget/, $p, $f);
-}
-
 sub git_svn_each {
 	my $sub = shift;
 	foreach (command(qw/rev-parse --symbolic --all/)) {
@@ -2682,33 +1905,6 @@ sub show_commit_normal {
 	}
 }
 
-sub libsvn_load {
-	return unless $_use_lib;
-	$_use_lib = eval {
-		require SVN::Core;
-		if ($SVN::Core::VERSION lt '1.1.0') {
-			die "Need SVN::Core 1.1.0 or better ",
-					"(got $SVN::Core::VERSION) ",
-					"Falling back to command-line svn\n";
-		}
-		require SVN::Ra;
-		require SVN::Delta;
-		push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
-		push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
-		*SVN::Git::Fetcher::process_rm = *process_rm;
-		my $kill_stupid_warnings = $SVN::Node::none.$SVN::Node::file.
-					$SVN::Node::dir.$SVN::Node::unknown.
-					$SVN::Node::none.$SVN::Node::file.
-					$SVN::Node::dir.$SVN::Node::unknown.
-					$SVN::Auth::SSL::CNMISMATCH.
-					$SVN::Auth::SSL::NOTYETVALID.
-					$SVN::Auth::SSL::EXPIRED.
-					$SVN::Auth::SSL::UNKNOWNCA.
-					$SVN::Auth::SSL::OTHER;
-		1;
-	};
-}
-
 sub _simple_prompt {
 	my ($cred, $realm, $default_username, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
@@ -3231,18 +2427,11 @@ sub revisions_eq {
 	my ($path, $r0, $r1) = @_;
 	return 1 if $r0 == $r1;
 	my $nr = 0;
-	if ($_use_lib) {
-		# should be OK to use Pool here (r1 - r0) should be small
-		my $pool = SVN::Pool->new;
-		libsvn_get_log($SVN, [$path], $r0, $r1,
-				0, 0, 1, sub {$nr++}, $pool);
-		$pool->clear;
-	} else {
-		my ($url, undef) = repo_path_split($SVN_URL);
-		my $svn_log = svn_log_raw("$url/$path","-r$r0:$r1");
-		while (next_log_entry($svn_log)) { $nr++ }
-		close $svn_log->{fh};
-	}
+	# should be OK to use Pool here (r1 - r0) should be small
+	my $pool = SVN::Pool->new;
+	libsvn_get_log($SVN, [$path], $r0, $r1,
+			0, 0, 1, sub {$nr++}, $pool);
+	$pool->clear;
 	return 0 if ($nr > 1);
 	return 1;
 }
@@ -3526,6 +2715,19 @@ sub copy_remote_ref {
 				"refs/remotes/$GIT_SVN on $origin\n";
 	}
 }
+
+{
+	my $kill_stupid_warnings = $SVN::Node::none.$SVN::Node::file.
+				$SVN::Node::dir.$SVN::Node::unknown.
+				$SVN::Node::none.$SVN::Node::file.
+				$SVN::Node::dir.$SVN::Node::unknown.
+				$SVN::Auth::SSL::CNMISMATCH.
+				$SVN::Auth::SSL::NOTYETVALID.
+				$SVN::Auth::SSL::EXPIRED.
+				$SVN::Auth::SSL::UNKNOWNCA.
+				$SVN::Auth::SSL::OTHER;
+}
+
 package SVN::Git::Fetcher;
 use vars qw/@ISA/;
 use strict;
@@ -3963,13 +3165,7 @@ __END__
 
 Data structures:
 
-$svn_log hashref (as returned by svn_log_raw)
-{
-	fh => file handle of the log file,
-	state => state of the log file parser (sep/msg/rev/msg_start...)
-}
-
-$log_msg hashref as returned by next_log_entry($svn_log)
+$log_msg hashref as returned by libsvn_log_entry()
 {
 	msg => 'whitespace-formatted log entry
 ',						# trailing newline is preserved
@@ -3978,7 +3174,6 @@ $log_msg hashref as returned by next_log_entry($svn_log)
 	author => 'committer name'
 };
 
-
 @mods = array of diff-index line hashes, each element represents one line
 	of diff-index output
 
diff --git a/t/Makefile b/t/Makefile
index c9bd9a4..250a190 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -23,13 +23,9 @@ clean:
 
 # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
 full-svn-test:
-	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=0 GIT_SVN_DELTA_FETCH=1 \
-					GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
-	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
-	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
-							LC_ALL=en_US.UTF-8
-	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
-							LC_ALL=en_US.UTF-8
+	$(MAKE) $(TSVN) GIT_SVN_DELTA_FETCH=1 \
+				GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
+	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
 
 .PHONY: $(T) clean
 .NOTPARALLEL:
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 63c6703..99ada71 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -7,17 +7,18 @@ then
 	exit
 fi
 
-GIT_DIR=$PWD/.git
-GIT_SVN_DIR=$GIT_DIR/svn/git-svn
-SVN_TREE=$GIT_SVN_DIR/svn-tree
-
-perl -e 'use SVN::Core' >/dev/null 2>&1
+perl -e 'use SVN::Core; $SVN::Core::VERSION gt "1.1.0" or die' >/dev/null 2>&1
 if test $? -ne 0
 then
-   echo 'Perl SVN libraries not found, tests requiring those will be skipped'
-   GIT_SVN_NO_LIB=1
+	test_expect_success 'Perl SVN libraries not found, skipping test' :
+	test_done
+	exit
 fi
 
+GIT_DIR=$PWD/.git
+GIT_SVN_DIR=$GIT_DIR/svn/git-svn
+SVN_TREE=$GIT_SVN_DIR/svn-tree
+
 svnadmin >/dev/null 2>&1
 if test $? -ne 1
 then
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index f9de232..0fc462e 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -229,9 +229,7 @@ tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
 
-if test -z "$GIT_SVN_NO_LIB" || test "$GIT_SVN_NO_LIB" -eq 0; then
-	echo tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904 >> expected
-fi
+echo tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904 >> expected
 
 test_expect_success "$name" "diff -u a expected"
 
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 01488ff..8d2e2fe 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -6,13 +6,6 @@
 test_description='git-svn --follow-parent fetching'
 . ./lib-git-svn.sh
 
-if test -n "$GIT_SVN_NO_LIB" && test "$GIT_SVN_NO_LIB" -ne 0
-then
-	echo 'Skipping: --follow-parent needs SVN libraries'
-	test_done
-	exit 0
-fi
-
 test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index 746c827..6323c7e 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -4,13 +4,6 @@
 test_description='git-svn commit-diff'
 . ./lib-git-svn.sh
 
-if test -n "$GIT_SVN_NO_LIB" && test "$GIT_SVN_NO_LIB" -ne 0
-then
-	echo 'Skipping: commit-diff needs SVN libraries'
-	test_done
-	exit 0
-fi
-
 test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 58698b3..59b6425 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -4,13 +4,6 @@
 test_description='git-svn commit-diff clobber'
 . ./lib-git-svn.sh
 
-if test -n "$GIT_SVN_NO_LIB" && test "$GIT_SVN_NO_LIB" -ne 0
-then
-	echo 'Skipping: commit-diff clobber needs SVN libraries'
-	test_done
-	exit 0
-fi
-
 test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
-- 
1.4.4.2.g0817
