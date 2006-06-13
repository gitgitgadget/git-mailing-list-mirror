From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 13/13] git-svn: make the $GIT_DIR/svn/*/revs directory obsolete
Date: Tue, 13 Jun 2006 11:02:15 -0700
Message-ID: <11502217531195-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDE3-0004t6-1o
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWFMSCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWFMSCj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54213 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932185AbWFMSCe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:34 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 21BC07DC021;
	Tue, 13 Jun 2006 11:02:33 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:33 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21797>

This is a very intrusive change, so I've beefed up the tests
significantly.  Added 'full-test' a target to the Makefile,
to test different possible configurations.  This is intended
for maintainers only.  Users should only be concerned with
'test' succeeding.

We now have a very simple custom database format for handling
mapping of svn revisions => git commits.  Of course, we're
not really using it yet, either.

Also disabled automatic branch-finding on new trees for now.
It's too easily broken.  revisions_eq() function should be
helpful for branch detection.

Also removed an extra assertion in fetch_cmd() that wasn't
correctly done.  This bug was found by full-test.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/Makefile                         |   12 +
 contrib/git-svn/git-svn.perl                     |  245 ++++++++++++++--------
 contrib/git-svn/t/t0000-contrib-git-svn.sh       |   13 +
 contrib/git-svn/t/t0001-contrib-git-svn-props.sh |   86 ++++----
 4 files changed, 224 insertions(+), 132 deletions(-)

diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
index 48f60b3..d73aa56 100644
--- a/contrib/git-svn/Makefile
+++ b/contrib/git-svn/Makefile
@@ -29,8 +29,16 @@ git-svn.html : git-svn.txt
 	asciidoc -b xhtml11 -d manpage \
 		-f ../../Documentation/asciidoc.conf $<
 test: git-svn
-	cd t && $(SHELL) ./t0000-contrib-git-svn.sh
-	cd t && $(SHELL) ./t0001-contrib-git-svn-props.sh
+	cd t && $(SHELL) ./t0000-contrib-git-svn.sh $(TEST_FLAGS)
+	cd t && $(SHELL) ./t0001-contrib-git-svn-props.sh $(TEST_FLAGS)
+
+full-test:
+	$(MAKE) test GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=1
+	$(MAKE) test GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=1
+	$(MAKE) test GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
+							LC_ALL=en_US.UTF-8
+	$(MAKE) test GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
+							LC_ALL=en_US.UTF-8
 
 clean:
 	rm -f git-svn *.xml *.html *.1
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 9618c8b..884969e 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -6,9 +6,9 @@ use strict;
 use vars qw/	$AUTHOR $VERSION
 		$SVN_URL $SVN_INFO $SVN_WC $SVN_UUID
 		$GIT_SVN_INDEX $GIT_SVN
-		$GIT_DIR $REV_DIR $GIT_SVN_DIR/;
+		$GIT_DIR $GIT_SVN_DIR $REVDB/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
-$VERSION = '1.1.0-pre';
+$VERSION = '1.1.1-broken';
 
 use Cwd qw/abs_path/;
 $GIT_DIR = abs_path($ENV{GIT_DIR} || '.git');
@@ -31,10 +31,13 @@ use File::Path qw/mkpath/;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev pass_through/;
 use File::Spec qw//;
 use POSIX qw/strftime/;
+use Memoize;
+memoize('revisions_eq');
 
 my ($SVN_PATH, $SVN, $SVN_LOG, $_use_lib);
 $_use_lib = 1 unless $ENV{GIT_SVN_NO_LIB};
 libsvn_load();
+my $_optimize_commits = 1 unless $ENV{GIT_SVN_NO_OPTIMIZE_COMMITS};
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
@@ -43,7 +46,7 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m);
-my (@_branch_from, %tree_map, %users, %rusers);
+my (@_branch_from, %tree_map, %users, %rusers, %equiv);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 my @repo_path_split_cache;
 
@@ -201,7 +204,6 @@ sub rebuild {
 		next if (defined $SVN_UUID && ($uuid ne $SVN_UUID));
 		next if (defined $SVN_URL && defined $url && ($url ne $SVN_URL));
 
-		print "r$rev = $c\n";
 		unless (defined $latest) {
 			if (!$SVN_URL && !$url) {
 				croak "SVN repository location required: $url\n";
@@ -211,8 +213,8 @@ sub rebuild {
 			setup_git_svn();
 			$latest = $rev;
 		}
-		assert_revision_eq_or_unknown($rev, $c);
-		sys('git-update-ref',"svn/$GIT_SVN/revs/$rev",$c);
+		revdb_set($REVDB, $rev, $c);
+		print "r$rev = $c\n";
 		$newest_rev = $rev if ($rev > $newest_rev);
 	}
 	close $rev_list or croak $?;
@@ -280,7 +282,11 @@ sub fetch_cmd {
 	my $svn_log = svn_log_raw(@log_args);
 
 	my $base = next_log_entry($svn_log) or croak "No base revision!\n";
-	my $last_commit = undef;
+	# don't need last_revision from grab_base_rev() because
+	# user could've specified a different revision to skip (they
+	# didn't want to import certain revisions into git for whatever
+	# reason, so trust $base->{revision} instead.
+	my (undef, $last_commit) = svn_grab_base_rev();
 	unless (-d $SVN_WC) {
 		svn_cmd_checkout($SVN_URL,$base->{revision},$SVN_WC);
 		chdir $SVN_WC or croak $!;
@@ -290,7 +296,6 @@ sub fetch_cmd {
 	} else {
 		chdir $SVN_WC or croak $!;
 		read_uuid();
-		eval { $last_commit = file_to_s("$REV_DIR/$base->{revision}") };
 		# looks like a user manually cp'd and svn switch'ed
 		unless ($last_commit) {
 			sys(qw/svn revert -R ./);
@@ -303,7 +308,6 @@ sub fetch_cmd {
 	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
 	my $last = $base;
 	while (my $log_msg = next_log_entry($svn_log)) {
-		assert_tree($last_commit);
 		if ($last->{revision} >= $log_msg->{revision}) {
 			croak "Out of order: last >= current: ",
 				"$last->{revision} >= $log_msg->{revision}\n";
@@ -444,14 +448,14 @@ sub commit_cmd {
 	}
 	$info = svn_info('.');
 	read_uuid($info);
-	my $svn_current_rev =  $info->{'Last Changed Rev'};
+	my $last = $fetched;
 	foreach my $c (@revs) {
-		my $mods = svn_checkout_tree($svn_current_rev, $c);
+		my $mods = svn_checkout_tree($last, $c);
 		if (scalar @$mods == 0) {
 			print "Skipping, no changes detected\n";
 			next;
 		}
-		$svn_current_rev = svn_commit_tree($svn_current_rev, $c);
+		$last = svn_commit_tree($last, $c);
 	}
 }
 
@@ -500,7 +504,7 @@ sub commit_lib {
 						},
 						@lock)
 					);
-			my $mods = libsvn_checkout_tree($r_last, $c, $ed);
+			my $mods = libsvn_checkout_tree($cmt_last, $c, $ed);
 			if (@$mods == 0) {
 				print "No changes\nr$r_last = $cmt_last\n";
 				$ed->abort_edit;
@@ -814,7 +818,7 @@ sub graft_file_copy_cmd {
 	my ($grafts, $l_map, $u) = @_;
 	my $paths = $l_map->{$u};
 	my $pfx = common_prefix([keys %$paths]);
-
+	$SVN_URL ||= $u.$pfx;
 	my $pid = open my $fh, '-|';
 	defined $pid or croak $!;
 	unless ($pid) {
@@ -851,6 +855,8 @@ sub graft_file_copy_lib {
 	my ($base, $head) = libsvn_parse_revision();
 	my $inc = 1000;
 	my ($min, $max) = ($base, $head < $base+$inc ? $head : $base+$inc);
+	my $eh = $SVN::Error::handler;
+	$SVN::Error::handler = \&libsvn_skip_unknown_revs;
 	while (1) {
 		my $pool = SVN::Pool->new;
 		$SVN_LOG->get_log( "/$path", $min, $max, 0, 1, 1,
@@ -864,6 +870,7 @@ sub graft_file_copy_lib {
 		$max += $inc;
 		$max = $head if ($max > $head);
 	}
+	$SVN::Error::handler = $eh;
 }
 
 sub process_merge_msg_matches {
@@ -994,7 +1001,8 @@ sub setup_git_svn {
 	}
 	mkpath([$GIT_SVN_DIR]);
 	mkpath(["$GIT_SVN_DIR/info"]);
-	mkpath([$REV_DIR]);
+	open my $fh, '>>',$REVDB or croak $!;
+	close $fh;
 	s_to_file($SVN_URL,"$GIT_SVN_DIR/info/url");
 
 	open my $fd, '>>', "$GIT_SVN_DIR/info/exclude" or croak $!;
@@ -1201,8 +1209,7 @@ sub precommit_check {
 
 
 sub get_diff {
-	my ($svn_rev, $treeish) = @_;
-	my $from = file_to_s("$REV_DIR/$svn_rev");
+	my ($from, $treeish) = @_;
 	assert_tree($from);
 	print "diff-tree $from $treeish\n";
 	my $pid = open my $diff_fh, '-|';
@@ -1222,8 +1229,8 @@ sub get_diff {
 }
 
 sub svn_checkout_tree {
-	my ($svn_rev, $treeish) = @_;
-	my $mods = get_diff($svn_rev, $treeish);
+	my ($from, $treeish) = @_;
+	my $mods = get_diff($from->{commit}, $treeish);
 	return $mods unless (scalar @$mods);
 	my ($rm, $add) = precommit_check($mods);
 
@@ -1268,8 +1275,8 @@ sub svn_checkout_tree {
 }
 
 sub libsvn_checkout_tree {
-	my ($svn_rev, $treeish, $ed) = @_;
-	my $mods = get_diff($svn_rev, $treeish);
+	my ($from, $treeish, $ed) = @_;
+	my $mods = get_diff($from, $treeish);
 	return $mods unless (scalar @$mods);
 	my %o = ( D => 1, R => 0, C => -1, A => 3, M => 3, T => 3 );
 	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
@@ -1365,7 +1372,7 @@ sub get_commit_message {
 }
 
 sub svn_commit_tree {
-	my ($svn_rev, $commit) = @_;
+	my ($last, $commit) = @_;
 	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
 	my $log_msg = get_commit_message($commit, $commit_msg);
 	my ($oneline) = ($log_msg->{msg} =~ /([^\n\r]+)/);
@@ -1392,7 +1399,7 @@ sub svn_commit_tree {
 
 	my @svn_up = qw(svn up);
 	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
-	if ($committed == ($svn_rev + 1)) {
+	if ($_optimize_commits && ($committed == ($last->{revision} + 1))) {
 		push @svn_up, "-r$committed";
 		sys(@svn_up);
 		my $info = svn_info('.');
@@ -1408,14 +1415,14 @@ sub svn_commit_tree {
 		$log_msg->{author} = $info->{'Last Changed Author'};
 		$log_msg->{revision} = $committed;
 		$log_msg->{msg} .= "\n";
-		my $parent = file_to_s("$REV_DIR/$svn_rev");
-		git_commit($log_msg, $parent, $commit);
-		return $committed;
+		$log_msg->{parents} = [ $last->{commit} ];
+		$log_msg->{commit} = git_commit($log_msg, $commit);
+		return $log_msg;
 	}
 	# resync immediately
-	push @svn_up, "-r$svn_rev";
+	push @svn_up, "-r$last->{revision}";
 	sys(@svn_up);
-	return fetch("$committed=$commit")->{revision};
+	return fetch("$committed=$commit");
 }
 
 sub rev_list_raw {
@@ -1671,10 +1678,9 @@ sub file_to_s {
 }
 
 sub assert_revision_unknown {
-	my $revno = shift;
-	if (-f "$REV_DIR/$revno") {
-		croak "$REV_DIR/$revno already exists! ",
-				"Why are we refetching it?";
+	my $r = shift;
+	if (my $c = revdb_get($REVDB, $r)) {
+		croak "$r = $c already exists! Why are we refetching it?";
 	}
 }
 
@@ -1690,18 +1696,6 @@ sub trees_eq {
 	return 1;
 }
 
-sub assert_revision_eq_or_unknown {
-	my ($revno, $commit) = @_;
-	if (-f "$REV_DIR/$revno") {
-		my $current = file_to_s("$REV_DIR/$revno");
-		if (($commit ne $current) && !trees_eq($commit, $current)) {
-			croak "$REV_DIR/$revno already exists!\n",
-				"current: $current\nexpected: $commit\n";
-		}
-		return;
-	}
-}
-
 sub git_commit {
 	my ($log_msg, @parents) = @_;
 	assert_revision_unknown($log_msg->{revision});
@@ -1763,19 +1757,12 @@ sub git_commit {
 	}
 	my @update_ref = ('git-update-ref',"refs/remotes/$GIT_SVN",$commit);
 	if (my $primary_parent = shift @exec_parents) {
-		$pid = fork;
-		defined $pid or croak $!;
-		if (!$pid) {
-			close STDERR;
-			close STDOUT;
-			exec 'git-rev-parse','--verify',
-					"refs/remotes/$GIT_SVN^0" or croak $!;
-		}
-		waitpid $pid, 0;
+		quiet_run(qw/git-rev-parse --verify/,"refs/remotes/$GIT_SVN^0");
 		push @update_ref, $primary_parent unless $?;
 	}
 	sys(@update_ref);
-	sys('git-update-ref',"svn/$GIT_SVN/revs/$log_msg->{revision}",$commit);
+	revdb_set($REVDB, $log_msg->{revision}, $commit);
+
 	# this output is read via pipe, do not change:
 	print "r$log_msg->{revision} = $commit\n";
 	if ($_repack && (--$_repack_nr == 0)) {
@@ -1990,7 +1977,29 @@ sub git_svn_each {
 	}
 }
 
+sub migrate_revdb {
+	git_svn_each(sub {
+		my $id = shift;
+		defined(my $pid = fork) or croak $!;
+		if (!$pid) {
+			$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
+			init_vars();
+			exit 0 if -r $REVDB;
+			print "Upgrading svn => git mapping...\n";
+			open my $fh, '>>',$REVDB or croak $!;
+			close $fh;
+			rebuild();
+			print "Done upgrading. You may now delete the ",
+				"deprecated $GIT_SVN_DIR/revs directory\n";
+			exit 0;
+		}
+		waitpid $pid, 0;
+		croak $? if $?;
+	});
+}
+
 sub migration_check {
+	migrate_revdb() unless (-e $REVDB);
 	return if (-d "$GIT_DIR/svn" || !-d $GIT_DIR);
 	print "Upgrading repository...\n";
 	unless (-d "$GIT_DIR/svn") {
@@ -2013,15 +2022,19 @@ sub migration_check {
 		s_to_file($url, "$GIT_DIR/svn/$x/info/repo_url");
 		s_to_file($path, "$GIT_DIR/svn/$x/info/repo_path");
 	}
+	migrate_revdb() if (-d $GIT_SVN_DIR && !-w $REVDB);
 	print "Done upgrading.\n";
 }
 
 sub find_rev_before {
-	my ($r, $git_svn_id) = @_;
-	my @revs = map { basename $_ } <$GIT_DIR/svn/$git_svn_id/revs/*>;
-	foreach my $r0 (sort { $b <=> $a } @revs) {
-		next if $r0 >= $r;
-		return ($r0, file_to_s("$GIT_DIR/svn/$git_svn_id/revs/$r0"));
+	my ($r, $id, $eq_ok) = @_;
+	my $f = "$GIT_DIR/svn/$id/.rev_db";
+	# --$r unless $eq_ok;
+	while ($r > 0) {
+		if (my $c = revdb_get($f, $r)) {
+			return ($r, $c);
+		}
+		--$r;
 	}
 	return (undef, undef);
 }
@@ -2029,9 +2042,9 @@ sub find_rev_before {
 sub init_vars {
 	$GIT_SVN ||= $ENV{GIT_SVN_ID} || 'git-svn';
 	$GIT_SVN_DIR = "$GIT_DIR/svn/$GIT_SVN";
+	$REVDB = "$GIT_SVN_DIR/.rev_db";
 	$GIT_SVN_INDEX = "$GIT_SVN_DIR/index";
 	$SVN_URL = undef;
-	$REV_DIR = "$GIT_SVN_DIR/revs";
 	$SVN_WC = "$GIT_SVN_DIR/tree";
 }
 
@@ -2491,7 +2504,27 @@ sub libsvn_traverse_ignore {
 	$pool->clear;
 }
 
-sub libsvn_new_tree {
+sub revisions_eq {
+	my ($path, $r0, $r1) = @_;
+	return 1 if $r0 == $r1;
+	my $nr = 0;
+	if ($_use_lib) {
+		# should be OK to use Pool here (r1 - r0) should be small
+		my $pool = SVN::Pool->new;
+		$SVN->get_log("/$path", $r0, $r1, 0, 1, 1, sub {$nr++},$pool);
+		$pool->clear;
+	} else {
+		my ($url, undef) = repo_path_split($SVN_URL);
+		my $svn_log = svn_log_raw("$url/$path","-r$r0:$r1");
+		while (next_log_entry($svn_log)) { $nr++ }
+		close $svn_log->{fh};
+	}
+	return 0 if ($nr > 1);
+	return 1;
+}
+
+sub libsvn_find_parent_branch {
+	return undef; # XXX this function is disabled atm (not tested enough)
 	my ($paths, $rev, $author, $date, $msg) = @_;
 	my $svn_path = '/'.$SVN_PATH;
 
@@ -2502,27 +2535,33 @@ sub libsvn_new_tree {
 		my $branch_from = $i->copyfrom_path or next;
 		my $r = $i->copyfrom_rev;
 		print STDERR  "Found possible branch point: ",
-			"$branch_from => $svn_path, $r\n";
+					"$branch_from => $svn_path, $r\n";
 		$branch_from =~ s#^/##;
 		my $l_map = read_url_paths();
 		my $url = $SVN->{url};
 		defined $l_map->{$url} or next;
 		my $id  = $l_map->{$url}->{$branch_from} or next;
-		my $f = "$GIT_DIR/svn/$id/revs/$r";
-		while ($r && !-r $f) {
-			$r--;
-			$f = "$GIT_DIR/svn/$id/revs/$r";
-		}
-		if (-r $f) {
-			my $parent = file_to_s($f);
+		my ($r0, $parent) = find_rev_before($r,$id,1);
+		if (defined $r0 && defined $parent &&
+					revisions_eq($branch_from, $r0, $r)) {
 			unlink $GIT_SVN_INDEX;
 			print STDERR "Found branch parent: $parent\n";
 			sys(qw/git-read-tree/, $parent);
 			return libsvn_fetch($parent, $paths, $rev,
 						$author, $date, $msg);
+		} else {
+			print STDERR
+				"Nope, branch point not imported or unknown\n";
 		}
-		print STDERR "Nope, branch point not imported or unknown\n";
 	}
+	return undef;
+}
+
+sub libsvn_new_tree {
+	if (my $log_entry = libsvn_find_parent_branch(@_)) {
+		return $log_entry;
+	}
+	my ($paths, $rev, $author, $date, $msg) = @_;
 	open my $gui, '| git-update-index -z --index-info' or croak $!;
 	my $pool = SVN::Pool->new;
 	libsvn_traverse($gui, '', $SVN_PATH, $rev, $pool);
@@ -2536,10 +2575,8 @@ sub find_graft_path_commit {
 	foreach my $x (keys %$tree_paths) {
 		next unless ($p1 =~ /^\Q$x\E/);
 		my $i = $tree_paths->{$x};
-		my $f = "$GIT_DIR/svn/$i/revs/$r1";
-
-		return file_to_s($f) if (-r $f);
-
+		my ($r0, $parent) = find_rev_before($r1,$i,1);
+		return $parent if (defined $r0 && $r0 == $r1);
 		print STDERR "r$r1 of $i not imported\n";
 		next;
 	}
@@ -2551,18 +2588,10 @@ sub find_graft_path_parents {
 	foreach my $x (keys %$tree_paths) {
 		next unless ($p0 =~ /^\Q$x\E/);
 		my $i = $tree_paths->{$x};
-		my $f = "$GIT_DIR/svn/$i/revs/$r0";
-		while ($r0 && !-r $f) {
-			# could be an older revision, too...
-			$r0--;
-			$f = "$GIT_DIR/svn/$i/revs/$r0";
-		}
-		unless (-r $f) {
-			print STDERR "r$r0 of $i not imported\n";
-			next;
+		my ($r, $parent) = find_rev_before($r0, $i, 1);
+		if (defined $r && defined $parent && revisions_eq($x,$r,$r0)) {
+			$grafts->{$c}->{$parent} = 1;
 		}
-		my $parent = file_to_s($f);
-		$grafts->{$c}->{$parent} = 1;
 	}
 }
 
@@ -2600,8 +2629,7 @@ sub restore_index {
 
 sub libsvn_commit_cb {
 	my ($rev, $date, $committer, $c, $msg, $r_last, $cmt_last) = @_;
-	if ($rev == ($r_last + 1)) {
-		# optimized (avoid fetch)
+	if ($_optimize_commits && $rev == ($r_last + 1)) {
 		my $log = libsvn_log_entry($rev,$committer,$date,$msg);
 		$log->{tree} = get_tree_from_treeish($c);
 		my $cmt = git_commit($log, $cmt_last, $c);
@@ -2652,6 +2680,49 @@ sub libsvn_skip_unknown_revs {
 	croak "Error from SVN, ($errno): ", $err->expanded_message,"\n";
 };
 
+# Tie::File seems to be prone to offset errors if revisions get sparse,
+# it's not that fast, either.  Tie::File is also not in Perl 5.6.  So
+# one of my favorite modules is out :<  Next up would be one of the DBM
+# modules, but I'm not sure which is most portable...  So I'll just
+# go with something that's plain-text, but still capable of
+# being randomly accessed.  So here's my ultra-simple fixed-width
+# database.  All records are 40 characters + "\n", so it's easy to seek
+# to a revision: (41 * rev) is the byte offset.
+# A record of 40 0s denotes an empty revision.
+# And yes, it's still pretty fast (faster than Tie::File).
+sub revdb_set {
+	my ($file, $rev, $commit) = @_;
+	length $commit == 40 or croak "arg3 must be a full SHA1 hexsum\n";
+	open my $fh, '+<', $file or croak $!;
+	my $offset = $rev * 41;
+	# assume that append is the common case:
+	seek $fh, 0, 2 or croak $!;
+	my $pos = tell $fh;
+	if ($pos < $offset) {
+		print $fh (('0' x 40),"\n") x (($offset - $pos) / 41);
+	}
+	seek $fh, $offset, 0 or croak $!;
+	print $fh $commit,"\n";
+	close $fh or croak $!;
+}
+
+sub revdb_get {
+	my ($file, $rev) = @_;
+	my $ret;
+	my $offset = $rev * 41;
+	open my $fh, '<', $file or croak $!;
+	seek $fh, $offset, 0;
+	if (tell $fh == $offset) {
+		$ret = readline $fh;
+		if (defined $ret) {
+			chomp $ret;
+			$ret = undef if ($ret =~ /^0{40}$/);
+		}
+	}
+	close $fh or croak $!;
+	return $ret;
+}
+
 package SVN::Git::Editor;
 use vars qw/@ISA/;
 use strict;
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
index c33b522..f896e2c 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -193,5 +193,18 @@ test_expect_success "$name" \
      git-rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
      diff -u a b"
 
+name='check imported tree checksums expected tree checksums'
+cat > expected <<\EOF
+tree f735671b89a7eb30cab1d8597de35bd4271ab813
+tree 4b9af72bb861eaed053854ec502cf7df72618f0f
+tree 031b8d557afc6fea52894eaebb45bec52f1ba6d1
+tree 0b094cbff17168f24c302e297f55bfac65eb8bd3
+tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
+tree 56a30b966619b863674f5978696f4a3594f2fca9
+tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
+tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
+EOF
+test_expect_success "$name" "diff -u a expected"
+
 test_done
 
diff --git a/contrib/git-svn/t/t0001-contrib-git-svn-props.sh b/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
index 23a5a2a..54e0ed7 100644
--- a/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
+++ b/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
@@ -52,49 +52,49 @@ EOF
 cd ..
 
 rm -rf import
-svn co "$svnrepo" test_wc
+test_expect_success 'checkout working copy from svn' "svn co $svnrepo test_wc"
+test_expect_success 'setup some commits to svn' \
+	'cd test_wc &&
+		echo Greetings >> kw.c &&
+		svn commit -m "Not yet an Id" &&
+		svn up &&
+		echo Hello world >> kw.c &&
+		svn commit -m "Modified file, but still not yet an Id" &&
+		svn up &&
+		svn propset svn:keywords Id kw.c &&
+		svn commit -m "Propset Id" &&
+		svn up &&
+	cd ..'
+
+test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
+test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 
-cd test_wc
-	echo 'Greetings' >> kw.c
-	svn commit -m 'Not yet an $Id$'
-	svn up
-
-	echo 'Hello world' >> kw.c
-	svn commit -m 'Modified file, but still not yet an $Id$'
-	svn up
-
-	svn propset svn:keywords Id kw.c
-	svn commit -m 'Propset $Id$'
-	svn up
-cd ..
-
-git-svn init "$svnrepo"
-git-svn fetch
-
-git checkout -b mybranch remotes/git-svn
-echo 'Hi again' >> kw.c
 name='test svn:keywords ignoring'
-
-git commit -a -m "$name"
-git-svn commit remotes/git-svn..mybranch
-git pull . remotes/git-svn
+test_expect_success "$name" \
+	'git checkout -b mybranch remotes/git-svn &&
+	echo Hi again >> kw.c &&
+	git commit -a -m "test keywoards ignoring" &&
+	git-svn commit remotes/git-svn..mybranch &&
+	git pull . remotes/git-svn'
 
 expect='/* $Id$ */'
 got="`sed -ne 2p kw.c`"
 test_expect_success 'raw $Id$ found in kw.c' "test '$expect' = '$got'"
 
-cd test_wc
-	svn propset svn:eol-style CR empty
-	svn propset svn:eol-style CR crlf
-	svn propset svn:eol-style CR ne_crlf
-	svn commit -m 'propset CR on crlf files'
-	svn up
-cd ..
+test_expect_success "propset CR on crlf files" \
+	'cd test_wc &&
+		svn propset svn:eol-style CR empty &&
+		svn propset svn:eol-style CR crlf &&
+		svn propset svn:eol-style CR ne_crlf &&
+		svn commit -m "propset CR on crlf files" &&
+		svn up &&
+	 cd ..'
 
-git-svn fetch
-git pull . remotes/git-svn
+test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
+	"git-svn fetch &&
+	 git pull . remotes/git-svn &&
+	 svn co $svnrepo new_wc"
 
-svn co "$svnrepo" new_wc
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
 	test_expect_success "Comparing $i" "cmp $i new_wc/$i"
@@ -106,16 +106,16 @@ cd test_wc
 	printf '$Id$\rHello\rWorld' > ne_cr
 	a_cr=`printf '$Id$\r\nHello\r\nWorld\r\n' | git-hash-object --stdin`
 	a_ne_cr=`printf '$Id$\r\nHello\r\nWorld' | git-hash-object --stdin`
-	svn propset svn:eol-style CRLF cr
-	svn propset svn:eol-style CRLF ne_cr
-	svn propset svn:keywords Id cr
-	svn propset svn:keywords Id ne_cr
-	svn commit -m 'propset CRLF on cr files'
-	svn up
+	test_expect_success 'Set CRLF on cr files' \
+	'svn propset svn:eol-style CRLF cr &&
+	 svn propset svn:eol-style CRLF ne_cr &&
+	 svn propset svn:keywords Id cr &&
+	 svn propset svn:keywords Id ne_cr &&
+	 svn commit -m "propset CRLF on cr files" &&
+	 svn up'
 cd ..
-
-git-svn fetch
-git pull . remotes/git-svn
+test_expect_success 'fetch and pull latest from svn' \
+	'git-svn fetch && git pull . remotes/git-svn'
 
 b_cr="`git-hash-object cr`"
 b_ne_cr="`git-hash-object ne_cr`"
-- 
1.4.0
