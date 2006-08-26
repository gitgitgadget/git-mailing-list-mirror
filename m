From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: add the 'dcommit' command
Date: Sat, 26 Aug 2006 00:01:23 -0700
Message-ID: <20060826070123.GA10801@localdomain>
References: <m2u040n5e2.fsf@ziti.local> <20060825191516.GA8957@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 09:01:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGsAn-0002wY-CL
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 09:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422884AbWHZHB1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 03:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWHZHB0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 03:01:26 -0400
Received: from hand.yhbt.net ([66.150.188.102]:30101 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964919AbWHZHB0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 03:01:26 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1DB7F7DC02E;
	Sat, 26 Aug 2006 00:01:24 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 26 Aug 2006 00:01:23 -0700
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060825191516.GA8957@localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26033>

This is a high-level wrapper around the 'commit-diff' command
and used to produce cleaner history against the mirrored repository
through rebase/reset usage.

It's basically a more polished version of this:

for i in `git rev-list --no-merges remotes/git-svn..HEAD | tac`; do
	git-svn commit-diff $i~1 $i
done
git reset --hard remotes/git-svn

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   25 +++++++++++++++++++++++++
 git-svn.perl              |   35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 9fce4d3..38e73ba 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -53,6 +53,15 @@ fetch::
 	See 'Additional Fetch Arguments' if you are interested in
 	manually joining branches on commit.
 
+dcommit::
+	Commit all diffs from the current HEAD directly to the SVN
+	repository, and then rebase or reset (depending on whether or
+	not there is a diff between SVN and HEAD).  It is recommended
+	that you run git-svn fetch and rebase (not pull) your commits
+	against the latest changes in the SVN repository.
+	This is advantageous over 'commit' (below) because it produces
+	cleaner, more linear history.
+
 commit::
 	Commit specified commit or tree objects to SVN.  This relies on
 	your imported fetch data being up-to-date.  This makes
@@ -146,6 +155,22 @@ loginname = Joe User <user@example.com>
 
 	repo-config key: svn.authors-file
 
+-m::
+--merge::
+-s<strategy>::
+--strategy=<strategy>::
+	These are only used with the 'dcommit' command.
+
+	Passed directly to git-rebase when using 'dcommit' if a
+	'git-reset' cannot be used (see dcommit).
+
+-n::
+--dry-run::
+	This is only used with the 'dcommit' command.
+
+	Print out the series of git arguments that would show
+	which diffs would be committed to SVN.
+
 ADVANCED OPTIONS
 ----------------
 -b<refname>::
diff --git a/git-svn.perl b/git-svn.perl
index b311c3d..9382a15 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -51,7 +51,8 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_message, $_file, $_follow_parent, $_no_metadata,
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
-	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m);
+	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m,
+	$_merge, $_strategy, $_dry_run);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 my @repo_path_split_cache;
@@ -118,6 +119,11 @@ my %cmd = (
 			{ 'message|m=s' => \$_message,
 			  'file|F=s' => \$_file,
 			%cmt_opts } ],
+	dcommit => [ \&dcommit, 'Commit several diffs to merge with upstream',
+			{ 'merge|m|M' => \$_merge,
+			  'strategy|s=s' => \$_strategy,
+			  'dry-run|n' => \$_dry_run,
+			%cmt_opts } ],
 );
 
 my $cmd;
@@ -561,6 +567,33 @@ sub commit_lib {
 	unlink $commit_msg;
 }
 
+sub dcommit {
+	my $gs = "refs/remotes/$GIT_SVN";
+	chomp(my @refs = safe_qx(qw/git-rev-list --no-merges/, "$gs..HEAD"));
+	foreach my $d (reverse @refs) {
+		if ($_dry_run) {
+			print "diff-tree $d~1 $d\n";
+		} else {
+			commit_diff("$d~1", $d);
+		}
+	}
+	return if $_dry_run;
+	fetch();
+	my @diff = safe_qx(qw/git-diff-tree HEAD/, $gs);
+	my @finish;
+	if (@diff) {
+		@finish = qw/rebase/;
+		push @finish, qw/--merge/ if $_merge;
+		push @finish, "--strategy=$_strategy" if $_strategy;
+		print STDERR "W: HEAD and $gs differ, using @finish:\n", @diff;
+	} else {
+		print "No changes between current HEAD and $gs\n",
+		      "Hard resetting to the latest $gs\n";
+		@finish = qw/reset --hard/;
+	}
+	sys('git', @finish, $gs);
+}
+
 sub show_ignore {
 	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
 	$_use_lib ? show_ignore_lib() : show_ignore_cmd();
-- 
1.4.2.g7c9b
