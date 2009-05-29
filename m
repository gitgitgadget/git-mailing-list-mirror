From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] git-svn: let 'dcommit $rev' work on $rev instead of HEAD
Date: Fri, 29 May 2009 16:38:23 +0200
Message-ID: <3126ac02cedeae2dd70fb6559d8d7fdf192d7a57.1243607811.git.trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 16:38:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA3EB-0006Y9-1U
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 16:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759304AbZE2Oi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 10:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759088AbZE2OiZ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 10:38:25 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:9189 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757047AbZE2OiY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 10:38:24 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 May 2009 16:38:14 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 May 2009 16:38:24 +0200
X-Mailer: git-send-email 1.6.3.1.286.gcb89e
X-OriginalArrivalTime: 29 May 2009 14:38:24.0291 (UTC) FILETIME=[1EFED730:01C9E06B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120281>

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

I hope this can still be changed, as I can see no use-case in which
the old variant would have been useful.  The manual accurately states

	Commit each diff from a specified head directly to the SVN
	repository, and then rebase or reset (depending on whether or
	not there is a diff between SVN and head).

meaning that the "loss" of commits is actually a reset --mixed in the
common case where the branch was already rebased with git-svn.  So the
changes remain in the tree, but the commits vanish.  This happened to
an unsuspecting user yesterday on IRC.

There is a slight catch of course: the user will have to rebase
manually.  This may be slightly surprising in the HEAD^ case, but
special-casing would have become too confusing (do we rebase only if
the $rev is an ancestor?  Why do we rebase for $branch^0, but not for
$branch?).

By analogy with 'git rebase foo bar', we could let the run end on
'bar' instead of returning to the previous HEAD.  I'm somewhat torn on
this, as it would probably reduce confusion as to what happened in the
branch case, but require more work from the user in the HEAD^ case.

If it is too late to change this behaviour, I'll make a patch with a
big warning in the docs and at the end of the dcommit run that HEAD
probably doesn't look like what the user expected.


 Documentation/git-svn.txt |    5 +++--
 git-svn.perl              |   32 +++++++++++++++++++++++++++++++-
 t/t9100-git-svn-basic.sh  |   17 +++++++++++++++++
 3 files changed, 51 insertions(+), 3 deletions(-)

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
index a70c7d7..0f94c37 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -447,13 +447,27 @@
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
 	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
 	unless ($gs) {
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
index 64aa7e2..476c3da 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -231,6 +231,23 @@ test_expect_success \
                               "^:refs/${remotes_git_svn}$"
         '
 
+test_expect_success 'dcommit $rev does not clobber current branch' '
+	git svn fetch -i bar &&
+	git checkout -b my-bar refs/remotes/bar &&
+	echo 1 > foo &&
+	git add foo &&
+	git commit -m 1 &&
+	echo 2 > foo &&
+	git add foo &&
+	git commit -m 2 &&
+	old_head=$(git rev-parse HEAD) &&
+	git svn dcommit -i bar HEAD^ &&
+	test $old_head = $(git rev-parse HEAD) &&
+	test refs/heads/my-bar = $(git symbolic-ref HEAD) &&
+	git checkout master &&
+	git branch -D my-bar
+	'
+
 test_expect_success 'able to dcommit to a subdirectory' "
 	git svn fetch -i bar &&
 	git checkout -b my-bar refs/remotes/bar &&
-- 
1.6.3.1.286.gcb89e
