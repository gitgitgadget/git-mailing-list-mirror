From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: log command fixes
Date: Wed, 11 Oct 2006 11:53:22 -0700
Message-ID: <11605928042812-git-send-email-normalperson@yhbt.net>
References: <11605928022833-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 11 20:53:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXjCq-0002Jt-9f
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 20:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWJKSxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 14:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWJKSxZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 14:53:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:32139 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030408AbWJKSxY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 14:53:24 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 0EF087DC091;
	Wed, 11 Oct 2006 11:53:23 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 11:53:24 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.rc2.gbe730
In-Reply-To: <11605928022833-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28739>

Change the --verbose flag to more closely match svn.  I was
somehow under the impression that --summary included --raw diff
output, but I was wrong.  We now pass -r --raw --name-status as
arguments if passed -v/--verbose.

-r (recursive) is passed by default, since users usually want
it, and accepting it causes difficulty with the -r<revision>
option used by svn users.  A --non-recursive switch has been
added to disable this.

Of course, --summary, --raw, -p and any other git-log options
can still be passed directly (without --name-status).

Also, several warnings about referencing undefined variables
have been fixed.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5a6c87e..4f6e6a3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -52,7 +52,7 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m,
-	$_merge, $_strategy, $_dry_run, $_ignore_nodate);
+	$_merge, $_strategy, $_dry_run, $_ignore_nodate, $_non_recursive);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 my @repo_path_split_cache;
@@ -114,6 +114,7 @@ my %cmd = (
 			  'incremental' => \$_incremental,
 			  'oneline' => \$_oneline,
 			  'show-commit' => \$_show_commit,
+			  'non-recursive' => \$_non_recursive,
 			  'authors-file|A=s' => \$_authors,
 			} ],
 	'commit-diff' => [ \&commit_diff, 'Commit a diff between two trees',
@@ -752,13 +753,18 @@ sub show_log {
 			# ignore
 		} elsif (/^:\d{6} \d{6} $sha1_short/o) {
 			push @{$c->{raw}}, $_;
+		} elsif (/^[ACRMDT]\t/) {
+			# we could add $SVN_PATH here, but that requires
+			# remote access at the moment (repo_path_split)...
+			s#^([ACRMDT])\t#   $1 #;
+			push @{$c->{changed}}, $_;
 		} elsif (/^diff /) {
 			$d = 1;
 			push @{$c->{diff}}, $_;
 		} elsif ($d) {
 			push @{$c->{diff}}, $_;
 		} elsif (/^    (git-svn-id:.+)$/) {
-			(undef, $c->{r}, undef) = extract_metadata($1);
+			($c->{url}, $c->{r}, undef) = extract_metadata($1);
 		} elsif (s/^    //) {
 			push @{$c->{l}}, $_;
 		}
@@ -850,7 +856,8 @@ sub git_svn_log_cmd {
 	my ($r_min, $r_max) = @_;
 	my @cmd = (qw/git-log --abbrev-commit --pretty=raw
 			--default/, "refs/remotes/$GIT_SVN");
-	push @cmd, '--summary' if $_verbose;
+	push @cmd, '-r' unless $_non_recursive;
+	push @cmd, qw/--raw --name-status/ if $_verbose;
 	return @cmd unless defined $r_max;
 	if ($r_max == $r_min) {
 		push @cmd, '--max-count=1';
@@ -861,7 +868,7 @@ sub git_svn_log_cmd {
 		my ($c_min, $c_max);
 		$c_max = revdb_get($REVDB, $r_max);
 		$c_min = revdb_get($REVDB, $r_min);
-		if ($c_min && $c_max) {
+		if (defined $c_min && defined $c_max) {
 			if ($r_max > $r_max) {
 				push @cmd, "$c_min..$c_max";
 			} else {
@@ -2561,6 +2568,12 @@ sub show_commit {
 	}
 }
 
+sub show_commit_changed_paths {
+	my ($c) = @_;
+	return unless $c->{changed};
+	print "Changed paths:\n", @{$c->{changed}};
+}
+
 sub show_commit_normal {
 	my ($c) = @_;
 	print '-' x72, "\nr$c->{r} | ";
@@ -2570,7 +2583,8 @@ sub show_commit_normal {
 	my $nr_line = 0;
 
 	if (my $l = $c->{l}) {
-		while ($l->[$#$l] eq "\n" && $l->[($#$l - 1)] eq "\n") {
+		while ($l->[$#$l] eq "\n" && $#$l > 0
+		                          && $l->[($#$l - 1)] eq "\n") {
 			pop @$l;
 		}
 		$nr_line = scalar @$l;
@@ -2582,11 +2596,15 @@ sub show_commit_normal {
 			} else {
 				$nr_line .= ' lines';
 			}
-			print $nr_line, "\n\n";
+			print $nr_line, "\n";
+			show_commit_changed_paths($c);
+			print "\n";
 			print $_ foreach @$l;
 		}
 	} else {
-		print "1 line\n\n";
+		print "1 line\n";
+		show_commit_changed_paths($c);
+		print "\n";
 
 	}
 	foreach my $x (qw/raw diff/) {
-- 
1.4.2.3.gc5a8
