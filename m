X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] git-svn: color support for the log command
Date: Tue, 28 Nov 2006 18:51:40 -0800
Message-ID: <1164768702941-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Wed, 29 Nov 2006 02:52:11 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g22a08
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpFY5-0006gY-8K for gcvg-git@gmane.org; Wed, 29 Nov
 2006 03:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755296AbWK2Cvp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 21:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755795AbWK2Cvp
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 21:51:45 -0500
Received: from hand.yhbt.net ([66.150.188.102]:11650 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1755296AbWK2Cvo (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 21:51:44 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id EB7122DC035; Tue, 28 Nov 2006 18:51:42 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 28 Nov 2006
 18:51:42 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

 * match LESS environment settings to those in pager.c
 * parse diff.color and pager.color settings in the
   config file, and pass --color to git-log
 * --color and --pager= settings are supported

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   67 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index c3ad5ec..d8d8716 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -60,6 +60,7 @@ nag_lib() unless $_use_lib;
 my $_optimize_commits = 1 unless $ENV{GIT_SVN_NO_OPTIMIZE_COMMITS};
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
+my $_esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_cp_similarity, $_cp_remote,
 	$_repack, $_repack_nr, $_repack_flags, $_q,
@@ -68,7 +69,8 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m,
 	$_merge, $_strategy, $_dry_run, $_ignore_nodate, $_non_recursive,
-	$_username, $_config_dir, $_no_auth_cache, $_xfer_delta);
+	$_username, $_config_dir, $_no_auth_cache, $_xfer_delta,
+	$_pager, $_color);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 my @repo_path_split_cache;
@@ -135,6 +137,8 @@ my %cmd = (
 			  'show-commit' => \$_show_commit,
 			  'non-recursive' => \$_non_recursive,
 			  'authors-file|A=s' => \$_authors,
+			  'color' => \$_color,
+			  'pager=s' => \$_pager,
 			} ],
 	'commit-diff' => [ \&commit_diff, 'Commit a diff between two trees',
 			{ 'message|m=s' => \$_message,
@@ -759,16 +763,17 @@ sub show_log {
 		}
 	}
 
+	config_pager();
 	my $pid = open(my $log,'-|');
 	defined $pid or croak $!;
 	if (!$pid) {
 		exec(git_svn_log_cmd($r_min,$r_max), @args) or croak $!;
 	}
-	setup_pager();
+	run_pager();
 	my (@k, $c, $d);
 
 	while (<$log>) {
-		if (/^commit ($sha1_short)/o) {
+		if (/^${_esc_color}commit ($sha1_short)/o) {
 			my $cmt = $1;
 			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
 				$r_last = $c->{r};
@@ -777,25 +782,25 @@ sub show_log {
 			}
 			$d = undef;
 			$c = { c => $cmt };
-		} elsif (/^author (.+) (\d+) ([\-\+]?\d+)$/) {
+		} elsif (/^${_esc_color}author (.+) (\d+) ([\-\+]?\d+)$/) {
 			get_author_info($c, $1, $2, $3);
-		} elsif (/^(?:tree|parent|committer) /) {
+		} elsif (/^${_esc_color}(?:tree|parent|committer) /) {
 			# ignore
-		} elsif (/^:\d{6} \d{6} $sha1_short/o) {
+		} elsif (/^${_esc_color}:\d{6} \d{6} $sha1_short/o) {
 			push @{$c->{raw}}, $_;
-		} elsif (/^[ACRMDT]\t/) {
+		} elsif (/^${_esc_color}[ACRMDT]\t/) {
 			# we could add $SVN->{svn_path} here, but that requires
 			# remote access at the moment (repo_path_split)...
-			s#^([ACRMDT])\t#   $1 #;
+			s#^(${_esc_color})([ACRMDT])\t#$1   $2 #;
 			push @{$c->{changed}}, $_;
-		} elsif (/^diff /) {
+		} elsif (/^${_esc_color}diff /) {
 			$d = 1;
 			push @{$c->{diff}}, $_;
 		} elsif ($d) {
 			push @{$c->{diff}}, $_;
-		} elsif (/^    (git-svn-id:.+)$/) {
+		} elsif (/^${_esc_color}    (git-svn-id:.+)$/) {
 			($c->{url}, $c->{r}, undef) = extract_metadata($1);
-		} elsif (s/^    //) {
+		} elsif (s/^${_esc_color}    //) {
 			push @{$c->{l}}, $_;
 		}
 	}
@@ -901,12 +906,30 @@ sub cmt_showable {
 	return defined $c->{r};
 }
 
+sub log_use_color {
+	return 1 if $_color;
+	my $dc;
+	chomp($dc = `git-repo-config --get diff.color`);
+	if ($dc eq 'auto') {
+		if (-t *STDOUT || (defined $_pager &&
+		    `git-repo-config --bool --get pager.color` !~ /^false/)) {
+			return ($ENV{TERM} && $ENV{TERM} ne 'dumb');
+		}
+		return 0;
+	}
+	return 0 if $dc eq 'never';
+	return 1 if $dc eq 'always';
+	chomp($dc = `git-repo-config --bool --get diff.color`);
+	$dc eq 'true';
+}
+
 sub git_svn_log_cmd {
 	my ($r_min, $r_max) = @_;
 	my @cmd = (qw/git-log --abbrev-commit --pretty=raw
 			--default/, "refs/remotes/$GIT_SVN");
 	push @cmd, '-r' unless $_non_recursive;
 	push @cmd, qw/--raw --name-status/ if $_verbose;
+	push @cmd, '--color' if log_use_color();
 	return @cmd unless defined $r_max;
 	if ($r_max == $r_min) {
 		push @cmd, '--max-count=1';
@@ -2533,14 +2556,18 @@ sub tz_to_s_offset {
 	return ($1 * 60) + ($tz * 3600);
 }
 
-sub setup_pager { # translated to Perl from pager.c
-	return unless (-t *STDOUT);
-	my $pager = $ENV{PAGER};
-	if (!defined $pager) {
-		$pager = 'less';
-	} elsif (length $pager == 0 || $pager eq 'cat') {
-		return;
+# adapted from pager.c
+sub config_pager {
+	$_pager ||= $ENV{GIT_PAGER} || $ENV{PAGER};
+	if (!defined $_pager) {
+		$_pager = 'less';
+	} elsif (length $_pager == 0 || $_pager eq 'cat') {
+		$_pager = undef;
 	}
+}
+
+sub run_pager {
+	return unless -t *STDOUT;
 	pipe my $rfd, my $wfd or return;
 	defined(my $pid = fork) or croak $!;
 	if (!$pid) {
@@ -2548,8 +2575,8 @@ sub setup_pager { # translated to Perl f
 		return;
 	}
 	open STDIN, '<&', $rfd or croak $!;
-	$ENV{LESS} ||= '-S';
-	exec $pager or croak "Can't run pager: $!\n";;
+	$ENV{LESS} ||= 'FRSX';
+	exec $_pager or croak "Can't run pager: $! ($_pager)\n";
 }
 
 sub get_author_info {
-- 
1.4.4.1.g22a08
