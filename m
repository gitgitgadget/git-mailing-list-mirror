From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] git-svn: let 'dcommit $rev' work on $rev instead of HEAD
Date: Fri, 29 May 2009 17:09:42 +0200
Message-ID: <64a802c5249465dc9e39faa480133f501e5d1b59.1243609198.git.trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 17:09:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA3iW-0003iG-8i
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 17:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079AbZE2PJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 11:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757472AbZE2PJm
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 11:09:42 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:16443 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118AbZE2PJl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 11:09:41 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 May 2009 17:09:32 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 May 2009 17:09:42 +0200
X-Mailer: git-send-email 1.6.3.1.286.gf0244
X-OriginalArrivalTime: 29 May 2009 15:09:42.0389 (UTC) FILETIME=[7E6DDA50:01C9E06F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120284>

'git svn dcommit' takes an optional revision argument, but the meaning
of it was rather scary.  It completely ignored the current state of
the HEAD, only looking at the revisions between SVN and $rev.  If HEAD
was attached to $branch, the branch lost all commits $rev..$branch in
the process.

Considering that 'git svn dcommit HEAD^' has the intuitive meaning
"dcommit all changes on my branch except the last one", we change the
meaning of the revision argument.  git-svn temporarily checks out $rev
for its work, meaning that

* if a branch is specified, that branch (_not_ the HEAD) is rebased as
  part of the dcommit,

* if some other revision is specified, as in the example, all work
  happens on a detached HEAD and no branch is affected.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Apologies for the noise.  I immediately wanted to use it on a live
repository, but noticed that I forgot to change the mentions of $head,
So in the relative case it would look at the wrong history to commit.
The interdiff is

  diff --git a/git-svn.perl b/git-svn.perl
  index 0f94c37..6a5b40e 100755
  --- a/git-svn.perl
  +++ b/git-svn.perl
  @@ -469,7 +469,7 @@
          }
   
          my @refs;
  -       my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
  +       my ($url, $rev, $uuid, $gs) = working_head_info('HEAD', \@refs);
          unless ($gs) {
                  die "Unable to determine upstream SVN information from ",
                      "$head history.\nPerhaps the repository is empty.";
  @@ -555,7 +555,7 @@
                          if (@diff) {
                                  @refs = ();
                                  my ($url_, $rev_, $uuid_, $gs_) =
  -                                             working_head_info($head, \@refs);
  +                                             working_head_info('HEAD', \@refs);
                                  my ($linear_refs_, $parents_) =
                                                linearize_history($gs_, \@refs);
                                  if (scalar(@$linear_refs) !=


plus a change of the test to verify that indeed the right commits were
committed.


 Documentation/git-svn.txt |    5 +++--
 git-svn.perl              |   36 +++++++++++++++++++++++++++++++++---
 t/t9100-git-svn-basic.sh  |   19 +++++++++++++++++++
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ca3fc3d..5aa9beb 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -170,8 +170,9 @@ and have no uncommitted changes.
 	It is recommended that you run 'git-svn' fetch and rebase (not
 	pull or merge) your commits against the latest changes in the
 	SVN repository.
-	An optional command-line argument may be specified as an
-	alternative to HEAD.
+	An optional revision or branch argument may be specified, and
+	causes 'git-svn' to do all work on that revision/branch
+	instead of HEAD.
 	This is advantageous over 'set-tree' (below) because it produces
 	cleaner, more linear history.
 +
diff --git a/git-svn.perl b/git-svn.perl
index a70c7d7..6a5b40e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -447,15 +447,29 @@
 	print "Done committing ",scalar @revs," revisions to SVN\n";
 	unlink $gs->{index};
 }
-
+#"
 sub cmd_dcommit {
 	my $head = shift;
 	git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
 		'Cannot dcommit with a dirty index.  Commit your changes first, '
 		. "or stash them with `git stash'.\n";
 	$head ||= 'HEAD';
+
+	my $old_head;
+	if ($head ne 'HEAD') {
+		$old_head = eval {
+			command_oneline([qw/symbolic-ref -q HEAD/])
+		};
+		if ($old_head) {
+			$old_head =~ s{^refs/heads/}{};
+		} else {
+			$old_head = eval { command_oneline(qw/rev-parse HEAD/) };
+		}
+		command(['checkout', $head], STDERR => 0);
+	}
+
 	my @refs;
-	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD', \@refs);
 	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
 		    "$head history.\nPerhaps the repository is empty.";
@@ -541,7 +555,7 @@
 			if (@diff) {
 				@refs = ();
 				my ($url_, $rev_, $uuid_, $gs_) =
-				              working_head_info($head, \@refs);
+				              working_head_info('HEAD', \@refs);
 				my ($linear_refs_, $parents_) =
 				              linearize_history($gs_, \@refs);
 				if (scalar(@$linear_refs) !=
@@ -579,6 +593,22 @@
 			}
 		}
 	}
+
+	if ($old_head) {
+		my $new_head = command_oneline(qw/rev-parse HEAD/);
+		my $new_is_symbolic = eval {
+			command_oneline(qw/symbolic-ref -q HEAD/);
+		};
+		if ($new_is_symbolic) {
+			print "dcommitted the branch ", $head, "\n";
+		} else {
+			print "dcommitted on a detached HEAD because you gave ",
+			      "a revision argument.\n",
+			      "The rewritten commit is: ", $new_head, "\n";
+		}
+		command(['checkout', $old_head], STDERR => 0);
+	}
+
 	unlink $gs->{index};
 }
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 64aa7e2..570e035 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -231,6 +231,25 @@ test_expect_success \
                               "^:refs/${remotes_git_svn}$"
         '
 
+test_expect_success 'dcommit $rev does not clobber current branch' '
+	git svn fetch -i bar &&
+	git checkout -b my-bar refs/remotes/bar &&
+	echo 1 > foo &&
+	git add foo &&
+	git commit -m "change 1" &&
+	echo 2 > foo &&
+	git add foo &&
+	git commit -m "change 2" &&
+	old_head=$(git rev-parse HEAD) &&
+	git svn dcommit -i bar HEAD^ &&
+	test $old_head = $(git rev-parse HEAD) &&
+	test refs/heads/my-bar = $(git symbolic-ref HEAD) &&
+	git log refs/remotes/bar | grep "change 1" &&
+	! git log refs/remotes/bar | grep "change 2" &&
+	git checkout master &&
+	git branch -D my-bar
+	'
+
 test_expect_success 'able to dcommit to a subdirectory' "
 	git svn fetch -i bar &&
 	git checkout -b my-bar refs/remotes/bar &&
-- 
1.6.3.1.286.gcb89e
