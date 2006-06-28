From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/5] git-svn: add --follow-parent and --no-metadata options to fetch
Date: Tue, 27 Jun 2006 19:39:13 -0700
Message-ID: <11514623601954-git-send-email-normalperson@yhbt.net>
References: <11514623542848-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 28 04:39:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvPxl-0007c1-9M
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 04:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422924AbWF1CjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 22:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422926AbWF1CjY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 22:39:24 -0400
Received: from hand.yhbt.net ([66.150.188.102]:27607 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422924AbWF1CjW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 22:39:22 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B897B7DC024;
	Tue, 27 Jun 2006 19:39:20 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Jun 2006 19:39:20 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.rc1.g3cc8
In-Reply-To: <11514623542848-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22771>

--follow-parent:
  This is especially helpful when we're tracking a directory
  that has been moved around within the repository, or if we
  started tracking a branch and never tracked the trunk it was
  descended from.

  This relies on the SVN::* libraries to work.  We can't
  reliably parse path info from the svn command-line client
  without relying on XML, so it's better just to have the SVN::*
  libs installed.

  This also removes oldvalue verification when calling update-ref

  In SVN, branches can be deleted, and then recreated under the
  same path as the original one with different ancestry
  information, causing parent information to be mismatched /
  misordered.

  Also force the current ref, if existing, to be a parent,
  regardless of whether or not it was specified.

--no-metadata:
  This gets rid of the git-svn-id: lines at the end of every commit.

  With this, you lose the ability to use the rebuild command.  If
  you ever lose your .git/svn/git-svn/.rev_db file, you won't be
  able to fetch again, either.  This is fine for one-shot imports.

  Also fix some issues with multi-fetch --follow-parent that were
  exposed while testing this.  Additionally, repack checking is
  simplified greatly.

  git-svn log will not work on repositories using this, either.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl             |  169 ++++++++++++++++++++++--------
 contrib/git-svn/t/t0004-follow-parent.sh |   44 ++++++++
 2 files changed, 167 insertions(+), 46 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 73b339a..33fd82a 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -19,6 +19,7 @@ my $TZ = $ENV{TZ};
 # make sure the svn binary gives consistent output between locales and TZs:
 $ENV{TZ} = 'UTC';
 $ENV{LC_ALL} = 'C';
+$| = 1; # unbuffer STDOUT
 
 # If SVN:: library support is added, please make the dependencies
 # optional and preserve the capability to use the command-line client.
@@ -46,7 +47,7 @@ my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_cp_similarity, $_cp_remote,
 	$_repack, $_repack_nr, $_repack_flags,
-	$_message, $_file,
+	$_message, $_file, $_follow_parent, $_no_metadata,
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m);
@@ -56,9 +57,11 @@ my @repo_path_split_cache;
 
 my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
 		'branch|b=s' => \@_branch_from,
+		'follow-parent|follow' => \$_follow_parent,
 		'branch-all-refs|B' => \$_branch_all_refs,
 		'authors-file|A=s' => \$_authors,
 		'repack:i' => \$_repack,
+		'no-metadata' => \$_no_metadata,
 		'repack-flags|repack-args|repack-opts=s' => \$_repack_flags);
 
 my ($_trunk, $_tags, $_branches);
@@ -825,35 +828,19 @@ sub fetch_child_id {
 	my $id = shift;
 	print "Fetching $id\n";
 	my $ref = "$GIT_DIR/refs/remotes/$id";
-	my $ca = file_to_s($ref) if (-r $ref);
-	defined(my $pid = fork) or croak $!;
+	defined(my $pid = open my $fh, '-|') or croak $!;
 	if (!$pid) {
+		$_repack = undef;
 		$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
 		init_vars();
 		fetch(@_);
 		exit 0;
 	}
-	waitpid $pid, 0;
-	croak $? if $?;
-	return unless $_repack || -r $ref;
-
-	my $cb = file_to_s($ref);
-
-	defined($pid = open my $fh, '-|') or croak $!;
-	my $url = file_to_s("$GIT_DIR/svn/$id/info/url");
-	$url = qr/\Q$url\E/;
-	if (!$pid) {
-		exec qw/git-rev-list --pretty=raw/,
-				$ca ? "$ca..$cb" : $cb or croak $!;
-	}
 	while (<$fh>) {
-		if (/^    git-svn-id: $url\@\d+ [a-f0-9\-]+$/) {
-			check_repack();
-		} elsif (/^    git-svn-id: \S+\@\d+ [a-f0-9\-]+$/) {
-			last;
-		}
+		print $_;
+		check_repack() if (/^r\d+ = $sha1/);
 	}
-	close $fh;
+	close $fh or croak $?;
 }
 
 sub rec_fetch {
@@ -1922,6 +1909,13 @@ sub git_commit {
 		croak $? if $?;
 		restore_index($index);
 	}
+
+	# just in case we clobber the existing ref, we still want that ref
+	# as our parent:
+	if (my $cur = eval { file_to_s("$GIT_DIR/refs/remotes/$GIT_SVN") }) {
+		push @tmp_parents, $cur;
+	}
+
 	if (exists $tree_map{$tree}) {
 		foreach my $p (@{$tree_map{$tree}}) {
 			my $skip;
@@ -1952,31 +1946,26 @@ sub git_commit {
 		last if @exec_parents > 16;
 	}
 
-	defined(my $pid = open my $out_fh, '-|') or croak $!;
-	if ($pid == 0) {
-		my $msg_fh = IO::File->new_tmpfile or croak $!;
-		print $msg_fh $log_msg->{msg}, "\ngit-svn-id: ",
-					"$SVN_URL\@$log_msg->{revision}",
+	set_commit_env($log_msg);
+	my @exec = ('git-commit-tree', $tree);
+	push @exec, '-p', $_  foreach @exec_parents;
+	defined(my $pid = open3(my $msg_fh, my $out_fh, '>&STDERR', @exec))
+								or croak $!;
+	print $msg_fh $log_msg->{msg} or croak $!;
+	unless ($_no_metadata) {
+		print $msg_fh "\ngit-svn-id: $SVN_URL\@$log_msg->{revision}",
 					" $SVN_UUID\n" or croak $!;
-		$msg_fh->flush == 0 or croak $!;
-		seek $msg_fh, 0, 0 or croak $!;
-		set_commit_env($log_msg);
-		my @exec = ('git-commit-tree',$tree);
-		push @exec, '-p', $_  foreach @exec_parents;
-		open STDIN, '<&', $msg_fh or croak $!;
-		exec @exec or croak $!;
 	}
+	$msg_fh->flush == 0 or croak $!;
+	close $msg_fh or croak $!;
 	chomp(my $commit = do { local $/; <$out_fh> });
-	close $out_fh or croak $?;
+	close $out_fh or croak $!;
+	waitpid $pid, 0;
+	croak $? if $?;
 	if ($commit !~ /^$sha1$/o) {
-		croak "Failed to commit, invalid sha1: $commit\n";
+		die "Failed to commit, invalid sha1: $commit\n";
 	}
-	my @update_ref = ('git-update-ref',"refs/remotes/$GIT_SVN",$commit);
-	if (my $primary_parent = shift @exec_parents) {
-		quiet_run(qw/git-rev-parse --verify/,"refs/remotes/$GIT_SVN^0");
-		push @update_ref, $primary_parent unless $?;
-	}
-	sys(@update_ref);
+	sys('git-update-ref',"refs/remotes/$GIT_SVN",$commit);
 	revdb_set($REVDB, $log_msg->{revision}, $commit);
 
 	# this output is read via pipe, do not change:
@@ -2061,6 +2050,11 @@ sub safe_qx {
 }
 
 sub svn_compat_check {
+	if ($_follow_parent) {
+		print STDERR 'E: --follow-parent functionality is only ',
+				"available when SVN libraries are used\n";
+		exit 1;
+	}
 	my @co_help = safe_qx(qw(svn co -h));
 	unless (grep /ignore-externals/,@co_help) {
 		print STDERR "W: Installed svn version does not support ",
@@ -2389,6 +2383,28 @@ sub write_grafts {
 	close $fh or croak $!;
 }
 
+sub read_url_paths_all {
+	my ($l_map, $pfx, $p) = @_;
+	my @dir;
+	foreach (<$p/*>) {
+		if (-r "$_/info/url") {
+			$pfx .= '/' if $pfx && $pfx !~ m!/$!;
+			my $id = $pfx . basename $_;
+			my $url = file_to_s("$_/info/url");
+			my ($u, $p) = repo_path_split($url);
+			$l_map->{$u}->{$p} = $id;
+		} elsif (-d $_) {
+			push @dir, $_;
+		}
+	}
+	foreach (@dir) {
+		my $x = $_;
+		$x =~ s!^\Q$GIT_DIR\E/svn/!!o;
+		read_url_paths_all($l_map, $x, $_);
+	}
+}
+
+# this one only gets ids that have been imported, not new ones
 sub read_url_paths {
 	my $l_map = {};
 	git_svn_each(sub { my $x = shift;
@@ -2602,7 +2618,6 @@ sub libsvn_get_file {
 	# redirect STDOUT for SVN 1.1.x compatibility
 	open my $stdout, '>&', \*STDOUT or croak $!;
 	open STDOUT, '>&', $in or croak $!;
-	$| = 1; # not sure if this is necessary, better safe than sorry...
 	my ($r, $props) = $SVN->get_file($f, $rev, \*STDOUT, $pool);
 	$in->flush == 0 or croak $!;
 	open STDOUT, '>&', $stdout or croak $!;
@@ -2705,6 +2720,28 @@ sub svn_grab_base_rev {
 	close $fh;
 	if (defined $c && length $c) {
 		my ($url, $rev, $uuid) = cmt_metadata($c);
+		return ($rev, $c) if defined $rev;
+	}
+	if ($_no_metadata) {
+		my $offset = -41; # from tail
+		my $rl;
+		open my $fh, '<', $REVDB or
+			die "--no-metadata specified and $REVDB not readable\n";
+		seek $fh, $offset, 2;
+		$rl = readline $fh;
+		defined $rl or return (undef, undef);
+		chomp $rl;
+		while ($c ne $rl && tell $fh != 0) {
+			$offset -= 41;
+			seek $fh, $offset, 2;
+			$rl = readline $fh;
+			defined $rl or return (undef, undef);
+			chomp $rl;
+		}
+		my $rev = tell $fh;
+		croak $! if ($rev < -1);
+		$rev =  ($rev - 41) / 41;
+		close $fh or croak $!;
 		return ($rev, $c);
 	}
 	return (undef, undef);
@@ -2803,15 +2840,45 @@ sub libsvn_find_parent_branch {
 	print STDERR  "Found possible branch point: ",
 				"$branch_from => $svn_path, $r\n";
 	$branch_from =~ s#^/##;
-	my $l_map = read_url_paths();
+	my $l_map = {};
+	read_url_paths_all($l_map, '', "$GIT_DIR/svn");
 	my $url = $SVN->{url};
 	defined $l_map->{$url} or return;
-	my $id = $l_map->{$url}->{$branch_from} or return;
+	my $id = $l_map->{$url}->{$branch_from};
+	if (!defined $id && $_follow_parent) {
+		print STDERR "Following parent: $branch_from\@$r\n";
+		# auto create a new branch and follow it
+		$id = basename($branch_from);
+		$id .= '@'.$r if -r "$GIT_DIR/svn/$id";
+		while (-r "$GIT_DIR/svn/$id") {
+			# just grow a tail if we're not unique enough :x
+			$id .= '-';
+		}
+	}
+	return unless defined $id;
+
 	my ($r0, $parent) = find_rev_before($r,$id,1);
+	if ($_follow_parent && (!defined $r0 || !defined $parent)) {
+		defined(my $pid = fork) or croak $!;
+		if (!$pid) {
+			$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
+			init_vars();
+			$SVN_URL = "$url/$branch_from";
+			$SVN_LOG = $SVN = undef;
+			setup_git_svn();
+			# we can't assume SVN_URL exists at r+1:
+			$_revision = "0:$r";
+			fetch_lib();
+			exit 0;
+		}
+		waitpid $pid, 0;
+		croak $? if $?;
+		($r0, $parent) = find_rev_before($r,$id,1);
+	}
 	return unless (defined $r0 && defined $parent);
 	if (revisions_eq($branch_from, $r0, $r)) {
 		unlink $GIT_SVN_INDEX;
-		print STDERR "Found branch parent: $parent\n";
+		print STDERR "Found branch parent: ($GIT_SVN) $parent\n";
 		sys(qw/git-read-tree/, $parent);
 		return libsvn_fetch($parent, $paths, $rev,
 					$author, $date, $msg);
@@ -3270,6 +3337,16 @@ diff-index line ($m hash)
 }
 ;
 
+# retval of read_url_paths{,_all}();
+$l_map = {
+	# repository root url
+	'https://svn.musicpd.org' => {
+		# repository path 		# GIT_SVN_ID
+		'mpd/trunk'		=>	'trunk',
+		'mpd/tags/0.11.5'	=>	'tags/0.11.5',
+	},
+}
+
 Notes:
 	I don't trust the each() function on unless I created %hash myself
 	because the internal iterator may not have started at base.
diff --git a/contrib/git-svn/t/t0004-follow-parent.sh b/contrib/git-svn/t/t0004-follow-parent.sh
new file mode 100644
index 0000000..01488ff
--- /dev/null
+++ b/contrib/git-svn/t/t0004-follow-parent.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+#
+
+test_description='git-svn --follow-parent fetching'
+. ./lib-git-svn.sh
+
+if test -n "$GIT_SVN_NO_LIB" && test "$GIT_SVN_NO_LIB" -ne 0
+then
+	echo 'Skipping: --follow-parent needs SVN libraries'
+	test_done
+	exit 0
+fi
+
+test_expect_success 'initialize repo' "
+	mkdir import &&
+	cd import &&
+	mkdir -p trunk &&
+	echo hello > trunk/readme &&
+	svn import -m 'initial' . $svnrepo &&
+	cd .. &&
+	svn co $svnrepo wc &&
+	cd wc &&
+	echo world >> trunk/readme &&
+	svn commit -m 'another commit' &&
+	svn up &&
+	svn mv -m 'rename to thunk' trunk thunk &&
+	svn up &&
+	echo goodbye >> thunk/readme &&
+	svn commit -m 'bye now' &&
+	cd ..
+	"
+
+test_expect_success 'init and fetch --follow-parent a moved directory' "
+	git-svn init -i thunk $svnrepo/thunk &&
+	git-svn fetch --follow-parent -i thunk &&
+	git-rev-parse --verify refs/remotes/trunk &&
+	test '$?' -eq '0'
+	"
+
+test_debug 'gitk --all &'
+
+test_done
-- 
1.4.1.rc1.g3cc8
