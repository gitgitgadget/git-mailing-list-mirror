From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/9] contrib/git-svn: add -b/--branch switch for branch detection
Date: Fri, 3 Mar 2006 01:20:07 -0800
Message-ID: <11413776074148-git-send-email-normalperson@yhbt.net>
References: <11413776074123-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6SL-0003xs-FH
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbWCCJUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbWCCJUJ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:63362 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752196AbWCCJUI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:08 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 9D5792DC091;
	Fri,  3 Mar 2006 01:20:07 -0800 (PST)
In-Reply-To: <11413776074123-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17142>

I've said I don't like branches in Subversion, and I still don't.
This is a bit more flexible, though, as the argument for -b is any
arbitrary git head/tag reference.

This makes some things easier:
 * Importing git history into a brand new SVN branch.
 * Tracking multiple SVN branches via GIT_SVN_ID, even from multiple
   repositories.
 * Adding tags from SVN (still need to use GIT_SVN_ID, though).
 * Even merge tracking is supported, if and only the heads end up with
   100% equivalent tree objects.  This is more stricter but more robust
   and foolproof than parsing commit messages, imho.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   38 ++++++++++++++++++++++++++++++++++++++
 contrib/git-svn/git-svn.txt  |   17 ++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletions(-)

536109ffa6682954d3b2bb6a184978fd185ecaa4
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 0e092c5..1f9a470 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -35,6 +35,7 @@ my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{6,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_version, $_upgrade);
+my (@_branch_from, %tree_map);
 
 GetOptions(	'revision|r=s' => \$_revision,
 		'no-ignore-externals' => \$_no_ignore_ext,
@@ -43,6 +44,7 @@ GetOptions(	'revision|r=s' => \$_revisio
 		'rmdir' => \$_rmdir,
 		'upgrade' => \$_upgrade,
 		'help|H|h' => \$_help,
+		'branch|b=s' => \@_branch_from,
 		'find-copies-harder' => \$_find_copies_harder,
 		'l=i' => \$_l,
 		'version|V' => \$_version,
@@ -831,6 +833,8 @@ sub git_commit {
 	my $uuid = $info->{'Repository UUID'};
 	defined $uuid or croak "Unable to get Repository UUID\n";
 
+	map_tree_joins() if (@_branch_from && !%tree_map);
+
 	# commit parents can be conditionally bound to a particular
 	# svn revision via: "svn_revno=commit_sha1", filter them out here:
 	my @exec_parents;
@@ -852,6 +856,17 @@ sub git_commit {
 		git_addremove();
 		chomp(my $tree = `git-write-tree`);
 		croak if $?;
+		if (exists $tree_map{$tree}) {
+			my %seen_parent = map { $_ => 1 } @exec_parents;
+			foreach (@{$tree_map{$tree}}) {
+				# MAXPARENT is defined to 16 in commit-tree.c:
+				if ($seen_parent{$_} || @exec_parents > 16) {
+					next;
+				}
+				push @exec_parents, $_;
+				$seen_parent{$_} = 1;
+			}
+		}
 		my $msg_fh = IO::File->new_tmpfile or croak $!;
 		print $msg_fh $log_msg->{msg}, "\ngit-svn-id: ",
 					"$SVN_URL\@$log_msg->{revision}",
@@ -975,6 +990,29 @@ sub check_upgrade_needed {
 	}
 }
 
+# fills %tree_map with a reverse mapping of trees to commits.  Useful
+# for finding parents to commit on.
+sub map_tree_joins {
+	foreach my $br (@_branch_from) {
+		my $pid = open my $pipe, '-|';
+		defined $pid or croak $!;
+		if ($pid == 0) {
+			exec(qw(git-rev-list --pretty=raw), $br) or croak $?;
+		}
+		while (<$pipe>) {
+			if (/^commit ($sha1)$/o) {
+				my $commit = $1;
+				my ($tree) = (<$pipe> =~ /^tree ($sha1)$/o);
+				unless (defined $tree) {
+					die "Failed to parse commit $commit\n";
+				}
+				push @{$tree_map{$tree}}, $commit;
+			}
+		}
+		close $pipe or croak $?;
+	}
+}
+
 __END__
 
 Data structures:
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index 4102deb..7306048 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -27,7 +27,7 @@ For importing svn, git-svnimport is pote
 operating on repositories organized under the recommended
 trunk/branch/tags structure, and should be faster, too.
 
-git-svn completely ignores the very limited view of branching that
+git-svn mostly ignores the very limited view of branching that
 Subversion has.  This allows git-svn to be much easier to use,
 especially on repositories that are not organized in a manner that
 git-svnimport is designed for.
@@ -116,6 +116,21 @@ OPTIONS
 	They are both passed directly to git-diff-tree see
 	git-diff-tree(1) for more information.
 
+-b<refname>::
+--branch <refname>::
+	Used with 'fetch' or 'commit'.
+
+	This can be used to join arbitrary git branches to remotes/git-svn
+	on new commits where the tree object is equivalent.
+
+	When used with different GIT_SVN_ID values, tags and branches in
+	SVN can be tracked this way, as can some merges where the heads
+	end up having completely equivalent content.  This can even be
+	used to track branches across multiple SVN _repositories_.
+
+	This option may be specified multiple times, once for each
+	branch.
+
 COMPATIBILITY OPTIONS
 ---------------------
 --no-ignore-externals::
-- 
1.2.3.g4676
