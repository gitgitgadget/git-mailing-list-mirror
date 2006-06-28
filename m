From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/5] git-svn: several graft-branches improvements
Date: Tue, 27 Jun 2006 19:39:11 -0700
Message-ID: <11514623571599-git-send-email-normalperson@yhbt.net>
References: <11514623542848-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 28 04:39:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvPxj-0007c1-Pr
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 04:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422928AbWF1CjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 22:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422924AbWF1CjU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 22:39:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:25815 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422926AbWF1CjT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 22:39:19 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A07A17DC025;
	Tue, 27 Jun 2006 19:39:17 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Jun 2006 19:39:17 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.rc1.g3cc8
In-Reply-To: <11514623542848-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22770>

The 'graft-branches' command can now analyze tree matches for
merge detection after commits are done, when --branch or
--branch-all-refs options are used.

We ensure that tree joins (--branch and --branch-all-refs
options) during commit time only add SVN parents that occurred
before the commit we're importing

Also fixed branch detection via merge messages, this manner of
merge detection (a la git-svnimport) is really all fuzzy, but at
least it actually works now :)

Add some new tests to go along with these fixes, too.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl              |  180 +++++++++++++++++++++++++++--
 contrib/git-svn/t/t0003-graft-branches.sh |   63 ++++++++++
 2 files changed, 230 insertions(+), 13 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 711b558..4fafe7a 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -34,6 +34,8 @@ use POSIX qw/strftime/;
 use IPC::Open3;
 use Memoize;
 memoize('revisions_eq');
+memoize('cmt_metadata');
+memoize('get_commit_time');
 
 my ($SVN_PATH, $SVN, $SVN_LOG, $_use_lib);
 $_use_lib = 1 unless $ENV{GIT_SVN_NO_LIB};
@@ -91,6 +93,8 @@ my %cmd = (
 	'graft-branches' => [ \&graft_branches,
 			'Detect merges/branches from already imported history',
 			{ 'merge-rx|m' => \@_opt_m,
+			  'branch|b=s' => \@_branch_from,
+			  'branch-all-refs|B' => \$_branch_all_refs,
 			  'no-default-regex' => \$_no_default_regex,
 			  'no-graft-copy' => \$_no_graft_copy } ],
 	'multi-init' => [ \&multi_init,
@@ -591,13 +595,14 @@ sub graft_branches {
 	my $l_map = read_url_paths();
 	my @re = map { qr/$_/is } @_opt_m if @_opt_m;
 	unless ($_no_default_regex) {
-		push @re, (	qr/\b(?:merge|merging|merged)\s+(\S.+)/is,
-				qr/\b(?:from|of)\s+(\S.+)/is );
+		push @re, (qr/\b(?:merge|merging|merged)\s+with\s+([\w\.\-]+)/i,
+			qr/\b(?:merge|merging|merged)\s+([\w\.\-]+)/i,
+			qr/\b(?:from|of)\s+([\w\.\-]+)/i );
 	}
 	foreach my $u (keys %$l_map) {
 		if (@re) {
 			foreach my $p (keys %{$l_map->{$u}}) {
-				graft_merge_msg($grafts,$l_map,$u,$p);
+				graft_merge_msg($grafts,$l_map,$u,$p,@re);
 			}
 		}
 		unless ($_no_graft_copy) {
@@ -608,6 +613,7 @@ sub graft_branches {
 			}
 		}
 	}
+	graft_tree_joins($grafts);
 
 	write_grafts($grafts, $comments, $gr_file);
 	unlink "$gr_file~$gr_sha1" if $gr_sha1;
@@ -880,6 +886,77 @@ sub common_prefix {
 	return '';
 }
 
+# grafts set here are 'stronger' in that they're based on actual tree
+# matches, and won't be deleted from merge-base checking in write_grafts()
+sub graft_tree_joins {
+	my $grafts = shift;
+	map_tree_joins() if (@_branch_from && !%tree_map);
+	return unless %tree_map;
+
+	git_svn_each(sub {
+		my $i = shift;
+		defined(my $pid = open my $fh, '-|') or croak $!;
+		if (!$pid) {
+			exec qw/git-rev-list --pretty=raw/,
+					"refs/remotes/$i" or croak $!;
+		}
+		while (<$fh>) {
+			next unless /^commit ($sha1)$/o;
+			my $c = $1;
+			my ($t) = (<$fh> =~ /^tree ($sha1)$/o);
+			next unless $tree_map{$t};
+
+			my $l;
+			do {
+				$l = readline $fh;
+			} until ($l =~ /^committer (?:.+) (\d+) ([\-\+]?\d+)$/);
+
+			my ($s, $tz) = ($1, $2);
+			if ($tz =~ s/^\+//) {
+				$s += tz_to_s_offset($tz);
+			} elsif ($tz =~ s/^\-//) {
+				$s -= tz_to_s_offset($tz);
+			}
+
+			my ($url_a, $r_a, $uuid_a) = cmt_metadata($c);
+
+			foreach my $p (@{$tree_map{$t}}) {
+				next if $p eq $c;
+				my $mb = eval {
+					safe_qx('git-merge-base', $c, $p)
+				};
+				next unless ($@ || $?);
+				if (defined $r_a) {
+					# see if SVN says it's a relative
+					my ($url_b, $r_b, $uuid_b) =
+							cmt_metadata($p);
+					next if (defined $url_b &&
+							defined $url_a &&
+							($url_a eq $url_b) &&
+							($uuid_a eq $uuid_b));
+					if ($uuid_a eq $uuid_b) {
+						if ($r_b < $r_a) {
+							$grafts->{$c}->{$p} = 2;
+							next;
+						} elsif ($r_b > $r_a) {
+							$grafts->{$p}->{$c} = 2;
+							next;
+						}
+					}
+				}
+				my $ct = get_commit_time($p);
+				if ($ct < $s) {
+					$grafts->{$c}->{$p} = 2;
+				} elsif ($ct > $s) {
+					$grafts->{$p}->{$c} = 2;
+				}
+				# what should we do when $ct == $s ?
+			}
+		}
+		close $fh or croak $?;
+	});
+}
+
 # this isn't funky-filename safe, but good enough for now...
 sub graft_file_copy_cmd {
 	my ($grafts, $l_map, $u) = @_;
@@ -960,7 +1037,7 @@ sub process_merge_msg_matches {
 		my $re = qr/\Q$w\E/i;
 		foreach (keys %{$l_map->{$u}}) {
 			if (/$re/) {
-				push @strong, $_;
+				push @strong, $l_map->{$u}->{$_};
 				last;
 			}
 		}
@@ -969,7 +1046,7 @@ sub process_merge_msg_matches {
 		$re = qr/\Q$w\E/i;
 		foreach (keys %{$l_map->{$u}}) {
 			if (/$re/) {
-				push @strong, $_;
+				push @strong, $l_map->{$u}->{$_};
 				last;
 			}
 		}
@@ -982,7 +1059,7 @@ sub process_merge_msg_matches {
 		return unless defined $rev;
 	}
 	foreach my $m (@strong) {
-		my ($r0, $s0) = find_rev_before($rev, $m);
+		my ($r0, $s0) = find_rev_before($rev, $m, 1);
 		$grafts->{$c->{c}}->{$s0} = 1 if defined $s0;
 	}
 }
@@ -1794,7 +1871,26 @@ sub git_commit {
 		restore_index($index);
 	}
 	if (exists $tree_map{$tree}) {
-		push @tmp_parents, @{$tree_map{$tree}};
+		foreach my $p (@{$tree_map{$tree}}) {
+			my $skip;
+			foreach (@tmp_parents) {
+				# see if a common parent is found
+				my $mb = eval {
+					safe_qx('git-merge-base', $_, $p)
+				};
+				next if ($@ || $?);
+				$skip = 1;
+				last;
+			}
+			next if $skip;
+			my ($url_p, $r_p, $uuid_p) = cmt_metadata($p);
+			next if (($SVN_UUID eq $uuid_p) &&
+						($log_msg->{revision} > $r_p));
+			next if (defined $url_p && defined $SVN_URL &&
+						($SVN_UUID eq $uuid_p) &&
+						($url_p eq $SVN_URL));
+			push @tmp_parents, $p;
+		}
 	}
 	foreach (@tmp_parents) {
 		next if $seen_parent{$_};
@@ -2122,6 +2218,7 @@ sub init_vars {
 	$GIT_SVN_INDEX = "$GIT_SVN_DIR/index";
 	$SVN_URL = undef;
 	$SVN_WC = "$GIT_SVN_DIR/tree";
+	%tree_map = ();
 }
 
 # convert GetOpt::Long specs for use by git-repo-config
@@ -2189,6 +2286,7 @@ sub write_grafts {
 			print $fh $_ foreach @{$comments->{$c}};
 		}
 		my $p = $grafts->{$c};
+		my %x; # real parents
 		delete $p->{$c}; # commits are not self-reproducing...
 		my $pid = open my $ch, '-|';
 		defined $pid or croak $!;
@@ -2196,13 +2294,41 @@ sub write_grafts {
 			exec(qw/git-cat-file commit/, $c) or croak $!;
 		}
 		while (<$ch>) {
-			if (/^parent ([a-f\d]{40})/) {
-				$p->{$1} = 1;
+			if (/^parent ($sha1)/) {
+				$x{$1} = $p->{$1} = 1;
 			} else {
-				last unless /^\S/i;
+				last unless /^\S/;
 			}
 		}
 		close $ch; # breaking the pipe
+
+		# if real parents are the only ones in the grafts, drop it
+		next if join(' ',sort keys %$p) eq join(' ',sort keys %x);
+
+		my (@ip, @jp, $mb);
+		my %del = %x;
+		@ip = @jp = keys %$p;
+		foreach my $i (@ip) {
+			next if $del{$i} || $p->{$i} == 2;
+			foreach my $j (@jp) {
+				next if $i eq $j || $del{$j} || $p->{$j} == 2;
+				$mb = eval { safe_qx('git-merge-base',$i,$j) };
+				next unless $mb;
+				chomp $mb;
+				next if $x{$mb};
+				if ($mb eq $j) {
+					delete $p->{$i};
+					$del{$i} = 1;
+				} elsif ($mb eq $i) {
+					delete $p->{$j};
+					$del{$j} = 1;
+				}
+			}
+		}
+
+		# if real parents are the only ones in the grafts, drop it
+		next if join(' ',sort keys %$p) eq join(' ',sort keys %x);
+
 		print $fh $c, ' ', join(' ', sort keys %$p),"\n";
 	}
 	if ($comments->{'END'}) {
@@ -2222,7 +2348,7 @@ sub read_url_paths {
 }
 
 sub extract_metadata {
-	my $id = shift;
+	my $id = shift or return (undef, undef, undef);
 	my ($url, $rev, $uuid) = ($id =~ /^git-svn-id:\s(\S+?)\@(\d+)
 							\s([a-f\d\-]+)$/x);
 	if (!$rev || !$uuid || !$url) {
@@ -2233,6 +2359,31 @@ sub extract_metadata {
 	return ($url, $rev, $uuid);
 }
 
+sub cmt_metadata {
+	return extract_metadata((grep(/^git-svn-id: /,
+		safe_qx(qw/git-cat-file commit/, shift)))[-1]);
+}
+
+sub get_commit_time {
+	my $cmt = shift;
+	defined(my $pid = open my $fh, '-|') or croak $!;
+	if (!$pid) {
+		exec qw/git-rev-list --pretty=raw -n1/, $cmt or croak $!;
+	}
+	while (<$fh>) {
+		/^committer\s(?:.+) (\d+) ([\-\+]?\d+)$/ or next;
+		my ($s, $tz) = ($1, $2);
+		if ($tz =~ s/^\+//) {
+			$s += tz_to_s_offset($tz);
+		} elsif ($tz =~ s/^\-//) {
+			$s -= tz_to_s_offset($tz);
+		}
+		close $fh;
+		return $s;
+	}
+	die "Can't get commit time for commit: $cmt\n";
+}
+
 sub tz_to_s_offset {
 	my ($tz) = @_;
 	$tz =~ s/(\d\d)$//;
@@ -2501,8 +2652,7 @@ sub svn_grab_base_rev {
 	chomp(my $c = do { local $/; <$fh> });
 	close $fh;
 	if (defined $c && length $c) {
-		my ($url, $rev, $uuid) = extract_metadata((grep(/^git-svn-id: /,
-			safe_qx(qw/git-cat-file commit/, $c)))[-1]);
+		my ($url, $rev, $uuid) = cmt_metadata($c);
 		return ($rev, $c);
 	}
 	return (undef, undef);
@@ -2651,6 +2801,10 @@ sub find_graft_path_parents {
 		my $i = $tree_paths->{$x};
 		my ($r, $parent) = find_rev_before($r0, $i, 1);
 		if (defined $r && defined $parent && revisions_eq($x,$r,$r0)) {
+			my ($url_b, undef, $uuid_b) = cmt_metadata($c);
+			my ($url_a, undef, $uuid_a) = cmt_metadata($parent);
+			next if ($url_a && $url_b && $url_a eq $url_b &&
+							$uuid_b eq $uuid_a);
 			$grafts->{$c}->{$parent} = 1;
 		}
 	}
diff --git a/contrib/git-svn/t/t0003-graft-branches.sh b/contrib/git-svn/t/t0003-graft-branches.sh
new file mode 100644
index 0000000..cc62d4e
--- /dev/null
+++ b/contrib/git-svn/t/t0003-graft-branches.sh
@@ -0,0 +1,63 @@
+test_description='git-svn graft-branches'
+. ./lib-git-svn.sh
+
+test_expect_success 'initialize repo' "
+	mkdir import &&
+	cd import &&
+	mkdir -p trunk branches tags &&
+	echo hello > trunk/readme &&
+	svn import -m 'import for git-svn' . $svnrepo &&
+	cd .. &&
+	svn cp -m 'tag a' $svnrepo/trunk $svnrepo/tags/a &&
+	svn cp -m 'branch a' $svnrepo/trunk $svnrepo/branches/a &&
+	svn co $svnrepo wc &&
+	cd wc &&
+	echo feedme >> branches/a/readme &&
+	svn commit -m hungry &&
+	svn up &&
+	cd trunk &&
+	svn merge -r3:4 $svnrepo/branches/a &&
+	svn commit -m 'merge with a' &&
+	cd ../.. &&
+	svn log -v $svnrepo &&
+	git-svn init -i trunk $svnrepo/trunk &&
+	git-svn init -i a $svnrepo/branches/a &&
+	git-svn init -i tags/a $svnrepo/tags/a &&
+	git-svn fetch -i tags/a &&
+	git-svn fetch -i a &&
+	git-svn fetch -i trunk
+	"
+
+r1=`git-rev-list remotes/trunk | tail -n1`
+r2=`git-rev-list remotes/tags/a | tail -n1`
+r3=`git-rev-list remotes/a | tail -n1`
+r4=`git-rev-list remotes/a | head -n1`
+r5=`git-rev-list remotes/trunk | head -n1`
+
+test_expect_success 'test graft-branches regexes and copies' "
+	test -n "$r1" &&
+	test -n "$r2" &&
+	test -n "$r3" &&
+	test -n "$r4" &&
+	test -n "$r5" &&
+	git-svn graft-branches &&
+	grep '^$r2 $r1' $GIT_DIR/info/grafts &&
+	grep '^$r3 $r1' $GIT_DIR/info/grafts &&
+	grep '^$r5 ' $GIT_DIR/info/grafts | grep '$r4' | grep '$r1'
+	"
+
+test_debug 'gitk --all & sleep 1'
+
+test_expect_success 'test graft-branches with tree-joins' "
+	rm $GIT_DIR/info/grafts &&
+	git-svn graft-branches --no-default-regex --no-graft-copy -B &&
+	grep '^$r3 ' $GIT_DIR/info/grafts | grep '$r1' | grep '$r2' &&
+	grep '^$r2 $r1' $GIT_DIR/info/grafts &&
+	grep '^$r5 ' $GIT_DIR/info/grafts | grep '$r1' | grep '$r4'
+	"
+
+# the result of this is kinda funky, we have a strange history and
+# this is just a test :)
+test_debug 'gitk --all &'
+
+test_done
-- 
1.4.1.rc1.g3cc8
