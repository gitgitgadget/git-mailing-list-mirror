From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/4] git-svn: remove non-delta fetch code paths
Date: Thu, 28 Dec 2006 01:16:19 -0800
Message-ID: <11672973823960-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 28 10:16:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrNO-0002oO-Lp
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWL1JQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWL1JQZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:16:25 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43029 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964961AbWL1JQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:16:24 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B3E607DC08E;
	Thu, 28 Dec 2006 01:16:22 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 28 Dec 2006 01:16:22 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35546>

We have less code to worry about now.  As a bonus, --revision
can be used to reliably skip parts of history whenever fetch is
run, not just the first time.  I'm not sure why anybody would
want to skip history in the middle, however...

For people (nearly everyone at the moment) without the
do_switch() function in their Perl SVN library, the entire tree
must be refetched if --follow-parent is used and a parent is
found.  Future versions of SVN will have a working do_switch()
function accessible via Perl.

Accessing repositories on the local machine (especially file://
ones) is also slightly slower as a result; but I suspect most
git-svn users will be using it to access remote repositories.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |  194 ++++++----------------------------------------------------
 t/Makefile   |    3 +-
 2 files changed, 21 insertions(+), 176 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index c2cdceb..0ef13b2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -69,7 +69,7 @@ my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m,
 	$_merge, $_strategy, $_dry_run, $_ignore_nodate, $_non_recursive,
-	$_username, $_config_dir, $_no_auth_cache, $_xfer_delta,
+	$_username, $_config_dir, $_no_auth_cache,
 	$_pager, $_color);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
 my ($_svn_can_do_switch);
@@ -2044,13 +2044,6 @@ sub libsvn_connect {
 	                      config => $config,
 	                      pool => SVN::Pool->new,
 	                      auth_provider_callbacks => $callbacks);
-
-	my $df = $ENV{GIT_SVN_DELTA_FETCH};
-	if (defined $df) {
-		$_xfer_delta = $df;
-	} else {
-		$_xfer_delta = ($url =~ m#^file://#) ? undef : 1;
-	}
 	$ra->{svn_path} = $url;
 	$ra->{repos_root} = $ra->get_repos_root;
 	$ra->{svn_path} =~ s#^\Q$ra->{repos_root}\E/*##;
@@ -2082,49 +2075,6 @@ sub libsvn_dup_ra {
 	             auth auth_provider_callbacks repos_root svn_path/);
 }
 
-sub libsvn_get_file {
-	my ($gui, $f, $rev, $chg, $untracked) = @_;
-	$f =~ s#^/##;
-	print "\t$chg\t$f\n" unless $_q;
-
-	my ($hash, $pid, $in, $out);
-	my $pool = SVN::Pool->new;
-	defined($pid = open3($in, $out, '>&STDERR',
-				qw/git-hash-object -w --stdin/)) or croak $!;
-	# redirect STDOUT for SVN 1.1.x compatibility
-	open my $stdout, '>&', \*STDOUT or croak $!;
-	open STDOUT, '>&', $in or croak $!;
-	my ($r, $props) = $SVN->get_file($f, $rev, \*STDOUT, $pool);
-	$in->flush == 0 or croak $!;
-	open STDOUT, '>&', $stdout or croak $!;
-	close $in or croak $!;
-	close $stdout or croak $!;
-	$pool->clear;
-	chomp($hash = do { local $/; <$out> });
-	close $out or croak $!;
-	waitpid $pid, 0;
-	$hash =~ /^$sha1$/o or die "not a sha1: $hash\n";
-
-	my $mode = exists $props->{'svn:executable'} ? '100755' : '100644';
-	if (exists $props->{'svn:special'}) {
-		$mode = '120000';
-		my $link = `git-cat-file blob $hash`; # no chomping symlinks
-		$link =~ s/^link // or die "svn:special file with contents: <",
-						$link, "> is not understood\n";
-		defined($pid = open3($in, $out, '>&STDERR',
-				qw/git-hash-object -w --stdin/)) or croak $!;
-		print $in $link;
-		$in->flush == 0 or croak $!;
-		close $in or croak $!;
-		chomp($hash = do { local $/; <$out> });
-		close $out or croak $!;
-		waitpid $pid, 0;
-		$hash =~ /^$sha1$/o or die "not a sha1: $hash\n";
-	}
-	%{$untracked->{file_prop}->{$f}} = %$props;
-	print $gui $mode,' ',$hash,"\t",$f,"\0" or croak $!;
-}
-
 sub uri_encode {
 	my ($f) = @_;
 	$f =~ s#([^a-zA-Z0-9\*!\:_\./\-])#uc sprintf("%%%02x",ord($1))#eg;
@@ -2232,10 +2182,6 @@ sub process_rm {
 }
 
 sub libsvn_fetch {
-	$_xfer_delta ? libsvn_fetch_delta(@_) : libsvn_fetch_full(@_);
-}
-
-sub libsvn_fetch_delta {
 	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
 	my $pool = SVN::Pool->new;
 	my $ed = SVN::Git::Fetcher->new({ c => $last_commit, q => $_q });
@@ -2251,66 +2197,6 @@ sub libsvn_fetch_delta {
 	libsvn_log_entry($rev, $author, $date, $msg, [$last_commit], $ed);
 }
 
-sub libsvn_fetch_full {
-	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
-	my ($gui, $ctx) = command_input_pipe(qw/update-index -z --index-info/);
-	my %amr;
-	my $ut = { empty => {}, dir_prop => {}, file_prop => {} };
-	my $p = $SVN->{svn_path};
-	foreach my $f (keys %$paths) {
-		my $m = $paths->{$f}->action();
-		if (length $p) {
-			$f =~ s#^/\Q$p\E/##;
-			next if $f =~ m#^/#;
-		} else {
-			$f =~ s#^/##;
-		}
-		if ($m =~ /^[DR]$/) {
-			my $t = process_rm($gui, $last_commit, $f, $_q);
-			if ($m eq 'D') {
-				$ut->{empty}->{$f} = 0 if $t == $SVN::Node::dir;
-				next;
-			}
-			# 'R' can be file replacements, too, right?
-		}
-		my $pool = SVN::Pool->new;
-		my $t = $SVN->check_path($f, $rev, $pool);
-		if ($t == $SVN::Node::file) {
-			if ($m =~ /^[AMR]$/) {
-				$amr{$f} = $m;
-			} else {
-				die "Unrecognized action: $m, ($f r$rev)\n";
-			}
-		} elsif ($t == $SVN::Node::dir && $m =~ /^[AR]$/) {
-			my @traversed = ();
-			libsvn_traverse($gui, '', $f, $rev, \@traversed, $ut);
-			if (@traversed) {
-				foreach (@traversed) {
-					$amr{$_} = $m;
-				}
-			} else {
-				my ($dir, $file) = ($f =~ m#^(.*?)/?([^/]+)$#);
-				delete $ut->{empty}->{$dir};
-				$ut->{empty}->{$f} = 1;
-			}
-		}
-		$pool->clear;
-	}
-	foreach (keys %amr) {
-		libsvn_get_file($gui, $_, $rev, $amr{$_}, $ut);
-		my ($d) = ($_ =~ m#^(.*?)/?(?:[^/]+)$#);
-		delete $ut->{empty}->{$d};
-	}
-	unless (exists $ut->{dir_prop}->{''}) {
-		my $pool = SVN::Pool->new;
-		my (undef, undef, $props) = $SVN->get_dir('', $rev, $pool);
-		%{$ut->{dir_prop}->{''}} = %$props;
-		$pool->clear;
-	}
-	command_close_pipe($gui, $ctx);
-	libsvn_log_entry($rev, $author, $date, $msg, [$last_commit], $ut);
-}
-
 sub svn_grab_base_rev {
 	my $c = eval { command_oneline([qw/rev-parse --verify/,
 	                                "refs/remotes/$GIT_SVN^0"],
@@ -2362,41 +2248,6 @@ sub libsvn_parse_revision {
 		"Try using the command-line svn client instead\n";
 }
 
-sub libsvn_traverse {
-	my ($gui, $pfx, $path, $rev, $files, $untracked) = @_;
-	my $cwd = length $pfx ? "$pfx/$path" : $path;
-	my $pool = SVN::Pool->new;
-	$cwd =~ s#^\Q$SVN->{svn_path}\E##;
-	my $nr = 0;
-	my ($dirent, $r, $props) = $SVN->get_dir($cwd, $rev, $pool);
-	%{$untracked->{dir_prop}->{$cwd}} = %$props;
-	foreach my $d (keys %$dirent) {
-		my $t = $dirent->{$d}->kind;
-		if ($t == $SVN::Node::dir) {
-			my $i = libsvn_traverse($gui, $cwd, $d, $rev,
-			                        $files, $untracked);
-			if ($i) {
-				$nr += $i;
-			} else {
-				$untracked->{empty}->{"$cwd/$d"} = 1;
-			}
-		} elsif ($t == $SVN::Node::file) {
-			$nr++;
-			my $file = "$cwd/$d";
-			if (defined $files) {
-				push @$files, $file;
-			} else {
-				libsvn_get_file($gui, $file, $rev, 'A',
-				                $untracked);
-				my ($dir) = ($file =~ m#^(.*?)/?(?:[^/]+)$#);
-				delete $untracked->{empty}->{$dir};
-			}
-		}
-	}
-	$pool->clear;
-	$nr;
-}
-
 sub libsvn_traverse_ignore {
 	my ($fh, $path, $r) = @_;
 	$path =~ s#^/+##g;
@@ -2488,8 +2339,8 @@ sub libsvn_find_parent_branch {
 		print STDERR "Found branch parent: ($GIT_SVN) $parent\n";
 		command_noisy('read-tree', $parent);
 		unless (libsvn_can_do_switch()) {
-			return libsvn_fetch_full($parent, $paths, $rev,
-						$author, $date, $msg);
+			return _libsvn_new_tree($paths, $rev, $author, $date,
+			                        $msg, [$parent]);
 		}
 		# do_switch works with svn/trunk >= r22312, but that is not
 		# included with SVN 1.4.2 (the latest version at the moment),
@@ -2514,7 +2365,7 @@ sub libsvn_find_parent_branch {
 
 sub libsvn_get_log {
 	my ($ra, @args) = @_;
-	$args[4]-- if $args[4] && $_xfer_delta && ! $_follow_parent;
+	$args[4]-- if $args[4] && ! $_follow_parent;
 	if ($SVN::Core::VERSION le '1.2.0') {
 		splice(@args, 3, 1);
 	}
@@ -2525,28 +2376,23 @@ sub libsvn_new_tree {
 	if (my $log_entry = libsvn_find_parent_branch(@_)) {
 		return $log_entry;
 	}
-	my ($paths, $rev, $author, $date, $msg) = @_;
-	my $ut;
-	if ($_xfer_delta) {
-		my $pool = SVN::Pool->new;
-		my $ed = SVN::Git::Fetcher->new({q => $_q});
-		my $reporter = $SVN->do_update($rev, '', 1, $ed, $pool);
-		my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
-		$reporter->set_path('', $rev, 1, @lock, $pool);
-		$reporter->finish_report($pool);
-		$pool->clear;
-		unless ($ed->{git_commit_ok}) {
-			die "SVN connection failed somewhere...\n";
-		}
-		$ut = $ed;
-	} else {
-		$ut = { empty => {}, dir_prop => {}, file_prop => {} };
-	        my ($gui, $ctx) = command_input_pipe(qw/update-index
-	                                             -z --index-info/);
-		libsvn_traverse($gui, '', $SVN->{svn_path}, $rev, undef, $ut);
-		command_close_pipe($gui, $ctx);
+	my ($paths, $rev, $author, $date, $msg) = @_; # $pool is last
+	_libsvn_new_tree($paths, $rev, $author, $date, $msg, []);
+}
+
+sub _libsvn_new_tree {
+	my ($paths, $rev, $author, $date, $msg, $parents) = @_;
+	my $pool = SVN::Pool->new;
+	my $ed = SVN::Git::Fetcher->new({q => $_q});
+	my $reporter = $SVN->do_update($rev, '', 1, $ed, $pool);
+	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
+	$reporter->set_path('', $rev, 1, @lock, $pool);
+	$reporter->finish_report($pool);
+	$pool->clear;
+	unless ($ed->{git_commit_ok}) {
+		die "SVN connection failed somewhere...\n";
 	}
-	libsvn_log_entry($rev, $author, $date, $msg, [], $ut);
+	libsvn_log_entry($rev, $author, $date, $msg, $parents, $ed);
 }
 
 sub find_graft_path_commit {
diff --git a/t/Makefile b/t/Makefile
index 250a190..19e3850 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -23,8 +23,7 @@ clean:
 
 # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
 full-svn-test:
-	$(MAKE) $(TSVN) GIT_SVN_DELTA_FETCH=1 \
-				GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
+	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
 
 .PHONY: $(T) clean
-- 
1.4.4.3.gd4ada
