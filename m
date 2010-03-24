From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCHv5] Teach rebase the --no-ff option.
Date: Wed, 24 Mar 2010 16:34:04 -0400
Message-ID: <1269462844-13468-1-git-send-email-marcnarc@xiplink.com>
References: <7vaatxskwc.fsf@alter.siamese.dyndns.org>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 21:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXHJ-0006oM-UZ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516Ab0CXUeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 16:34:06 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:59941 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932366Ab0CXUeE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 16:34:04 -0400
Received: from rincewind (rincewind.xiplink.com [192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2OKVOGP013511;
	Wed, 24 Mar 2010 16:31:25 -0400
Received: by rincewind (Postfix, from userid 1000)
	id A1A983366A8; Wed, 24 Mar 2010 16:34:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.1.g7f7ff
In-Reply-To: <7vaatxskwc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143120>

For git-rebase.sh, --no-ff is a synonym for --force-rebase.

For git-rebase--interactive.sh, --no-ff cherry-picks all the commits in
the rebased branch, instead of fast-forwarding over any unchanged commits.

--no-ff offers an alternative way to deal with reverted merges.  Instead of
"reverting the revert" you can use "rebase --no-ff" to recreate the branch
with entirely new commits (they're new because at the very least the
committer time is different).  This obviates the need to revert the
reversion, as you can re-merge the new topic branch directly.  Added an
addendum to revert-a-faulty-merge.txt describing the situation and how to
use --no-ff to handle it.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Now also makes git-rebase.sh treat --no-ff as a synonym for -f.  I think I
got the man page right...

Also rewrote the addendum to revert-a-faulty-merge.txt to (hopefully) reflect
Junio's comments.

I agree about not teaching -f to rebase--interative.  I was only mildly for
it to begin with.  It also occurred to me that we don't want users to think
that "rebase -i" treats -f the same way as it does --no-ff, but making
rebase--interactive silently accept -f might encourage that mistake.

		M.

 Documentation/git-rebase.txt                  |   23 ++++++-
 Documentation/howto/revert-a-faulty-merge.txt |   90 +++++++++++++++++++++++++
 git-rebase--interactive.sh                    |    9 ++-
 git-rebase.sh                                 |    4 +-
 t/t3404-rebase-interactive.sh                 |   36 +++++++++-
 5 files changed, 152 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 823f2a4..0d07b1b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -274,9 +274,16 @@ which makes little sense.
 -f::
 --force-rebase::
 	Force the rebase even if the current branch is a descendant
-	of the commit you are rebasing onto.  Normally the command will
+	of the commit you are rebasing onto.  Normally non-interactive rebase will
 	exit with the message "Current branch is up to date" in such a
 	situation.
+	Incompatible with the --interactive option.
++
+You may find this (or --no-ff with an interactive rebase) helpful after
+reverting a topic branch merge, as this option recreates the topic branch with
+fresh commits so it can be remerged successfully without needing to "revert
+the reversion" (see the
+link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
 
 --ignore-whitespace::
 --whitespace=<option>::
@@ -316,7 +323,19 @@ which makes little sense.
 	commit to be modified, and change the action of the moved
 	commit from `pick` to `squash` (or `fixup`).
 +
-This option is only valid when '--interactive' option is used.
+This option is only valid when the '--interactive' option is used.
+
+--no-ff::
+	With --interactive, cherry-pick all rebased commits instead of
+	fast-forwarding over the unchanged ones.  This ensures that the
+	entire history of the rebased branch is composed of new commits.
++
+Without --interactive, this is a synonym for --force-rebase.
++
+You may find this helpful after reverting a topic branch merge, as this option
+recreates the topic branch with fresh commits so it can be remerged
+successfully without needing to "revert the reversion" (see the
+link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
 
 include::merge-strategies.txt[]
 
diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 3b4a390..ff5c0bc 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -142,6 +142,8 @@ different resolution strategies:
    revert of a merge was rebuilt from scratch (i.e. rebasing and fixing,
    as you seem to have interpreted), then re-merging the result without
    doing anything else fancy would be the right thing to do.
+   (See the ADDENDUM below for how to rebuild a branch from scratch
+   without changing its original branching-off point.)
 
 However, there are things to keep in mind when reverting a merge (and
 reverting such a revert).
@@ -177,3 +179,91 @@ the answer is: "oops, I really shouldn't have merged it, because it wasn't
 ready yet, and I really need to undo _all_ of the merge"). So then you
 really should revert the merge, but when you want to re-do the merge, you
 now need to do it by reverting the revert.
+
+ADDENDUM
+
+Sometimes you have to rewrite one of a topic branch's commits *and* you can't
+change the topic's branching-off point.  Consider the following situation:
+
+ P---o---o---M---x---x---W---x
+  \         /
+   A---B---C
+
+where commit W reverted commit M because it turned out that commit B was wrong
+and needs to be rewritten, but you need the rewritten topic to still branch
+from commit P (perhaps P is a branching-off point for yet another branch, and
+you want be able to merge the topic into both branches).
+
+The natural thing to do in this case is to checkout the A-B-C branch and use
+"rebase -i P" to change commit B.  However this does not rewrite commit A,
+because "rebase -i" by default fast-forwards over any initial commits selected
+with the "pick" command.  So you end up with this:
+
+ P---o---o---M---x---x---W---x
+  \         /
+   A---B---C   <-- old branch
+    \
+     B'---C'   <-- naively rewritten branch
+
+To merge A-B'-C' into the mainline branch you would still have to first revert
+commit W in order to pick up the changes in A, but then it's likely that the
+changes in B' will conflict with the original B changes re-introduced by the
+reversion of W.
+
+However, you can avoid these problems if you recreate the entire branch,
+including commit A:
+
+   A'---B'---C'  <-- completely rewritten branch
+  /
+ P---o---o---M---x---x---W---x
+  \         /
+   A---B---C
+
+You can merge A'-B'-C' into the mainline branch without worrying about first
+reverting W.  Mainline's history would look like this:
+
+   A'---B'---C'------------------
+  /                              \
+ P---o---o---M---x---x---W---x---M2
+  \         /
+   A---B---C
+
+But if you don't actually need to change commit A, then you need some way to
+recreate it as a new commit with the same changes in it.  The rebase commmand's
+--no-ff option provides a way to do this:
+
+    $ git rebase [-i] --no-ff P
+
+The --no-ff option creates a new branch A'-B'-C' with all-new commits (all the
+SHA IDs will be different) even if in the interactive case you only actually
+modify commit B.  You can then merge this new branch directly into the mainline
+branch and be sure you'll get all of the branch's changes.
+
+You can also use --no-ff in cases where you just add extra commits to the topic
+to fix it up.  Let's revisit the situation discussed at the start of this howto:
+
+ P---o---o---M---x---x---W---x
+  \         /
+   A---B---C----------------D---E   <-- fixed-up topic branch
+
+At this point, you can use --no-ff to recreate the topic branch:
+
+    $ git checkout E
+    $ git rebase --no-ff P
+
+yielding
+
+   A'---B'---C'------------D'---E'  <-- recreated topic branch
+  /
+ P---o---o---M---x---x---W---x
+  \         /
+   A---B---C----------------D---E
+
+You can merge the recreated branch into the mainline without reverting commit W,
+and mainline's history will look like this:
+
+   A'---B'---C'------------D'---E'
+  /                              \
+ P---o---o---M---x---x---W---x---M2
+  \         /
+   A---B---C
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3e4fd14..d5468b0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -20,6 +20,7 @@ v,verbose          display a diffstat of what changed upstream
 onto=              rebase onto given branch instead of upstream
 p,preserve-merges  try to recreate merges instead of ignoring them
 s,strategy=        use the given merge strategy
+no-ff              cherry-pick all commits, even if unchanged
 m,merge            always used (no-op)
 i,interactive      always used (no-op)
  Actions:
@@ -103,6 +104,7 @@ VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
 REBASE_ROOT=
 AUTOSQUASH=
+NEVER_FF=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -222,7 +224,7 @@ do_with_author () {
 }
 
 pick_one () {
-	no_ff=
+	no_ff=$NEVER_FF
 	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
@@ -742,6 +744,9 @@ first and then run 'git rebase --continue' again."
 	-i)
 		# yeah, we know
 		;;
+	--no-ff)
+		NEVER_FF=t
+		;;
 	--root)
 		REBASE_ROOT=t
 		;;
@@ -927,7 +932,7 @@ EOF
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
-		test -d "$REWRITTEN" || skip_unnecessary_picks
+		test -d "$REWRITTEN" || test -n "$NEVER_FF" || skip_unnecessary_picks
 
 		git update-ref ORIG_HEAD $HEAD
 		output git checkout $ONTO && do_rest
diff --git a/git-rebase.sh b/git-rebase.sh
index fb4fef7..8b23f8b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
+USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -347,7 +347,7 @@ do
 	--root)
 		rebase_root=t
 		;;
-	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase)
+	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase|--no-ff)
 		force_rebase=t
 		;;
 	--rerere-autoupdate|--no-rerere-autoupdate)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4e35137..624e78e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -22,12 +22,18 @@ set_fake_editor
 # | \
 # |   F - G - H                (branch1)
 # |     \
-#  \      I                    (branch2)
-#   \
-#     J - K - L - M            (no-conflict-branch)
+# |\      I                    (branch2)
+# | \
+# |   J - K - L - M            (no-conflict-branch)
+#  \
+#    N - O - P                 (no-ff-branch)
 #
 # where A, B, D and G all touch file1, and one, two, three, four all
 # touch file "conflict".
+#
+# WARNING: Modifications to the initial repository can change the SHA ID used
+# in the expect2 file for the 'stop on conflicting pick' test.
+
 
 test_expect_success 'setup' '
 	test_commit A file1 &&
@@ -50,6 +56,11 @@ test_expect_success 'setup' '
 	for n in J K L M
 	do
 		test_commit $n file$n
+	done &&
+	git checkout -b no-ff-branch A &&
+	for n in N O P
+	do
+		test_commit $n file$n
 	done
 '
 
@@ -113,7 +124,7 @@ cat > expect2 << EOF
 D
 =======
 G
->>>>>>> 51047de... G
+>>>>>>> 5d18e54... G
 EOF
 
 test_expect_success 'stop on conflicting pick' '
@@ -553,4 +564,21 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '
 
+test_tick # Ensure that the rebased commits get a different timestamp.
+test_expect_success 'always cherry-pick with --no-ff' '
+	git checkout no-ff-branch &&
+	git tag original-no-ff-branch &&
+	git rebase -i --no-ff A &&
+	touch empty &&
+	for p in 0 1 2
+	do
+		test ! $(git rev-parse HEAD~$p) = $(git rev-parse original-no-ff-branch~$p) &&
+		git diff HEAD~$p original-no-ff-branch~$p > out &&
+		test_cmp empty out
+	done &&
+	test $(git rev-parse HEAD~3) = $(git rev-parse original-no-ff-branch~3) &&
+	git diff HEAD~3 original-no-ff-branch~3 > out &&
+	test_cmp empty out
+'
+
 test_done
-- 
1.7.0.3.1.g7f7ff
