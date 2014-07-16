From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1] rebase --root: sentinel commit cloaks empty commits
Date: Wed, 16 Jul 2014 21:32:45 +0200
Message-ID: <8d5cf2e1ff45e2e60072bf6c6e05371e4b265709.1405539123.git.bafain@gmail.com>
References: <53A18198.7070301@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Chris Webb <chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 21:33:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Uxf-0003Ko-Ll
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 21:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbaGPTdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 15:33:52 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35572 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbaGPTdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 15:33:50 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so1917250wib.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MOfOp+rr9+WapN56TrFApZMZXy8z0UcpuhJm8fiy8Y=;
        b=T8LB+ifxev9d/0VXEFLxqgoBwBMnE5dKllnozObty1JpxKbLJ7LNFkRbpLZ+lRPOow
         nl/c7bgpIgqj5CDWhyD/SfpAmlTzj8JcGWWSZKEXHxKUCA5xRVrMklKAD5d6AAg82nlV
         HugdVsgHIYuysHS6GzE7B1ZHYVRjBlcxLdQd4//zY0jgCoh+aPEdMEXgx3exllTv5tbq
         vsk7siWYmAjDyC8QtISXsDHz6rCU/F1sn0YKsrYzW0ftjXX61oJuiXhzbfuy+SwCHqD1
         JFzaWZ48/PU0rJVNrT1vdyu5PPLNS8fZEBgqpNotVILv1UD5C/Wzpi/LbCQZkL7dDg8T
         GbcA==
X-Received: by 10.194.60.35 with SMTP id e3mr39675335wjr.12.1405539229614;
        Wed, 16 Jul 2014 12:33:49 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id wp6sm553753wjb.9.2014.07.16.12.33.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 12:33:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <53A18198.7070301@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253686>

git-rebase supports the option `--root` both with and without
`--onto`. In rebase root mode it replays all commits reachable from a
branch on top of another branch, including the very first commit. In
case `--onto` is not specified, that other branch is temporarily
provided by creating an empty commit. When the first commit on the
to-do list is being replayed, the so-called sentinel commit is
amended using the log message and patch of the replayed commit. Since
the sentinel commit is empty, this results in a replacement of the
sentinel commit with the new root commit of the rebased branch.

The combination of `--root` and no `--onto` implies an interactive
rebase. When `--preserve-merges` is not specified on the command
line, git-rebase--interactive uses `--cherry-pick` with git-rev-list
to put the initial to-do list together. The left side is given by the
fake base and the right side by the branch being rebased. What
happens now is that any empty commit on the original branch is
treated as a cherry-pick of the sentinel commit and subsequently
omitted from the to-do list. This is a bug if `--keep-empty` is
specified also.

Even without `--keep-empty`, using the sentinel commit as left side
with git-rev-list can result in a faulty rebased branch. Indeed, in
the unlikely case that the original branch consists solely of empty
commits, the bug crops up in the strangest fashion as all commits are
skipped and the sentinel commit is not replaced. As a result,
git-rebase produces a branch with a single empty commit.

To trigger the replacement of the sentinel commit, git-rebase assigns
the variable `squash_onto`. Special case a second time regarding
`squash_onto` and run git-rev-list without a left side if the
variable is assigned. The latter is the case if and only if `--root`
is used without `--onto`, that is `upstream` points to the sentinel
commit and `$upstream...$orig_head` would subtract a commit that is
not actually there from the original branch.

Fix a typo in `is_empty_commit`. It always found root commits
non-empty so that empty root commits were scheduled even without
`--keep-empty`. The POSIX specification states that command
substitutions are to be executed in sub-shells, which makes exit(1)
and variable assignments not affect the script execution state. That
was the reason why `ptree` was null for parentless commits and the
test `"$tree" = "$ptree"` always false for them.

Add tests.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
Hi,

Three test cases were added to the bug report to account for the
additional cases in which the bug strikes (raised by Michael on the
other sub-thread). A bugfix is included now as well.

Concerning the bugfix: Obviously, the patch misuses the `squash_onto`
flag because it assumes that the new base is empty except for the
sentinel commit. The variable name does not imply anything close to
that. An additional flag to disable the use of the git-rev-list
option `--cherry-pick` would work and make sense again (for instance,
`keep_redundant`). However, the following two bugs, not related to
empty commits, seem to suggest that git-rebase--interactive cannot
work obliviously to non-existent bases.

 1) git-rebase--interactive when used with `--root` and the to-do
    list `noop` results in the original branch's history being
    rewritten to contain only the sentinel commit.

    git-rebase--interactive correctly checkouts `$onto` and replays
    no commits on top of it but git-rebase has forgotten that `$onto`
    was fake.

 2) git-rebase--interactive when used with `--root` always creates a
    fresh root commit, regardless of `--no-ff` being specified.

    With the current meaning of `squash_onto`,
    git-rebase--interactive cannot just reset the branch to the old
    root commit. It is really the fault of git-rebase to start off
    with a new commit.

Please take a closer look at the last two test cases that specify the
expected behaviour of rebasing a branch that tracks the empty tree.
At this point they expect the "Nothing to do" error (aborts with
untouched history). This is consistent with rebasing only empty
commits without `--root`, which also doesn't just delete them from
the history. Furthermore, I think the two alternatives adding a note
that all commits in the range were empty, and removing the empty
commits (thus making the branch empty) are better discussed in a
separate bug report.

Thanks for your time,
   Fabian

 git-rebase--interactive.sh | 20 ++++++++++++++-----
 t/t3412-rebase-root.sh     | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f267d8b..71ca0f0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -201,10 +201,10 @@ has_action () {
 }
 
 is_empty_commit() {
-	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
-		die "$1: not a commit that can be picked")
-	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
-		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
+	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null) ||
+		die "$1: not a commit that can be picked"
+	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null) ||
+		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 	test "$tree" = "$ptree"
 }
 
@@ -958,7 +958,17 @@ then
 	revisions=$upstream...$orig_head
 	shortrevisions=$shortupstream..$shorthead
 else
-	revisions=$onto...$orig_head
+	if test -n "$squash_onto"
+	then
+		# $onto points to an empty commit (the sentinel
+		# commit) which was not created by the user.
+		# Exclude it from the rev list to avoid skipping
+		# empty user commits prematurely, i. e. before
+		# --keep-empty can take effect.
+		revisions=$orig_head
+	else
+		revisions=$onto...$orig_head
+	fi
 	shortrevisions=$shorthead
 fi
 git rev-list $merges_option --pretty=oneline --abbrev-commit \
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 0b52105..7c09efc 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -278,4 +278,53 @@ test_expect_success 'rebase -i -p --root with conflict (second part)' '
 	test_cmp expect-conflict-p out
 '
 
+test_expect_success 'recreate empty commits with --keep-empty (root commit only)' '
+	# commit the empty tree, no parents
+	empty_tree=$(git hash-object -t tree /dev/null) &&
+	echo Empty\ root >expected.msg &&
+	empty_root_commit=$(git commit-tree $empty_tree -F expected.msg) &&
+	git checkout -b empty-root-commit $empty_root_commit &&
+	git rebase --root --keep-empty &&
+	git show -s --pretty=format:%s%n HEAD >actual.msg &&
+	test_cmp expected.msg actual.msg
+'
+
+test_expect_success 'recreate empty commits with --keep-empty (root commit with child)' '
+	git checkout -b empty-root-commit-with-child empty-root-commit &&
+	>file &&
+	git add file &&
+	git commit -m file &&
+	git rebase --root --keep-empty &&
+	git show -s --pretty=format:%s%n HEAD^ >actual.msg &&
+	test_cmp expected.msg actual.msg
+'
+
+test_expect_success 'recreate empty commits with --keep-empty (child commit)' '
+	git checkout -b empty-child-commit other &&
+	echo Empty\ child >expected.msg &&
+	git commit --allow-empty -F expected.msg &&
+	git rebase --root --keep-empty &&
+	git show -s --pretty=format:%s%n HEAD >actual.msg &&
+	test_cmp expected.msg actual.msg
+'
+
+test_expect_success 'abort if branch has solely empty commits without --keep-empty (single)' '
+	git checkout empty-root-commit &&
+	git rev-parse HEAD >expected.rev &&
+	test_must_fail git rebase --root &&
+	test_path_is_missing .git/rebase-merge &&
+	git rev-parse HEAD >actual.rev &&
+	test_cmp expected.rev actual.rev
+'
+
+test_expect_success 'abort if branch has solely empty commits without --keep-empty (many)' '
+	git checkout -b empty-commits-only empty-root-commit &&
+	git commit --allow-empty -m Child &&
+	git rev-parse HEAD >expected.rev &&
+	test_must_fail git rebase --root &&
+	test_path_is_missing .git/rebase-merge &&
+	git rev-parse HEAD >actual.rev &&
+	test_cmp expected.rev actual.rev
+'
+
 test_done
-- 
2.0.1
