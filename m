From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCHv3] Teach -f/--force-rebase option to 'rebase -i'.
Date: Tue, 23 Mar 2010 12:19:47 -0400
Message-ID: <1269361187-31291-1-git-send-email-marcnarc@xiplink.com>
References: <4BA8D263.8040602@xiplink.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 17:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu6ob-0004M4-En
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 17:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab0CWQRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 12:17:50 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:45981 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754642Ab0CWQRt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 12:17:49 -0400
Received: from rincewind (rincewind.xiplink.com [192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2NGHRFM005410;
	Tue, 23 Mar 2010 12:17:27 -0400
Received: by rincewind (Postfix, from userid 1000)
	id 9B60A33663F; Tue, 23 Mar 2010 12:20:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.dirty
In-Reply-To: <4BA8D263.8040602@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143028>

This option tells rebase--interactive to cherry-pick all the commits in the
rebased branch, instead of fast-forwarding over any unchanged commits.

Also expanded -f's description in rebase's man page.

-f offers an alterntive way to deal with reverted merges.  Instead of
"reverting the revert" you can use "rebase -f [-i]" to recreate the branch
with entirely new commits (they're new because at the very least the
committer time is different).  This obviates the need to revert the
reversion, as you can re-merge the new topic branch directly.  Added an
addendum to revert-a-faulty-merge.txt describing the situation and how to
use -f to handle it.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

It seems more natural to me to just teach -f to "rebase -i" instead of adding
a new --no-ff option.

This patch combines my initial "--no-ff" patch with the documentation changes
in my "reword" patch.  I moved the unit test for "rebase -f -i" into
t3404-rebase-interactive.sh.

		M.


 Documentation/git-rebase.txt                  |   10 ++++-
 Documentation/howto/revert-a-faulty-merge.txt |   57 +++++++++++++++++++++++++
 git-rebase--interactive.sh                    |    9 +++-
 t/t3404-rebase-interactive.sh                 |   36 ++++++++++++++--
 4 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 823f2a4..1fd8d1c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -274,9 +274,15 @@ which makes little sense.
 -f::
 --force-rebase::
 	Force the rebase even if the current branch is a descendant
-	of the commit you are rebasing onto.  Normally the command will
+	of the commit you are rebasing onto.  Normally non-interactive rebase will
 	exit with the message "Current branch is up to date" in such a
-	situation.
+	situation.  With --interactive, this option forces rebase to
+	cherry-pick all commits, even if they're not actually changed.
++
+--force-rebase can sometimes be helpful after reverting a topic branch merge,
+as it recreates the topic branch with fresh commits so it can be remerged
+successfully without needing to "revert the reversion" (see the
+link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To]).
 
 --ignore-whitespace::
 --whitespace=<option>::
diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 3b4a390..994bd7f 100644
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
@@ -177,3 +179,58 @@ the answer is: "oops, I really shouldn't have merged it, because it wasn't
 ready yet, and I really need to undo _all_ of the merge"). So then you
 really should revert the merge, but when you want to re-do the merge, you
 now need to do it by reverting the revert.
+
+ADDENDUM
+
+Sometimes you're in a situation like this
+
+ P---o---o---M---x---x---W---x
+  \         /
+   A---B---C
+
+where W is the reversion of merge M and you:
+
+ - Need to rewrite one of the commits on the A-B-C branch; and
+
+ - Want the rewritten A-B-C branch to still start at commit P (perhaps P
+   is a branching-off point for yet another branch, and you want be able to
+   merge A-B-C into both branches).
+
+The natural thing to do in this case is to checkout the A-B-C branch and use
+"rebase -i A" to change commit B.  However, this does not rewrite commit A,
+and you end up with this:
+
+ P---o---o---M---x---x---W---x
+  \         /
+   A---B---C   <-- old branch
+   \
+    B'---C'    <-- rewritten branch
+
+To merge A-B'-C' into the mainline branch you would still have to first revert
+commit W in order to pick up the changes in A, but then it's likely that the
+changes in B' will conflict with the original B changes re-introduced by the
+reversion of W.
+
+However, you can avoid these problems if you recreate the entire branch,
+including commit A:
+
+ P---o---o---M---x---x---W---x
+ |\         /
+ | A---B---C   <-- old branch
+ \
+  A'---B'---C' <-- entirely recreated branch
+
+Now you can merge A'-B'-C' into the mainline branch without worrying about
+first reverting W.
+
+But if you don't actually need to change commit A, then you need some way to
+recreate it as a new commit with the same changes in it.  One way to do this
+is to rebase the entire branch from the branching-off point (commit P) using
+the -f parameter to ensure that all the commits get recreated:
+
+    $ git rebase -f -i P
+
+This creates a new branch A'-B'-C' with all-new commits (all the SHA IDs will
+be different) even if you only actually modify commit B.  You can then merge
+this new branch directly into the mainline branch and be sure you'll get all
+of the branch's changes.
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3e4fd14..61ccf4c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -20,6 +20,7 @@ v,verbose          display a diffstat of what changed upstream
 onto=              rebase onto given branch instead of upstream
 p,preserve-merges  try to recreate merges instead of ignoring them
 s,strategy=        use the given merge strategy
+f,force-rebase     cherry-pick all commits, even if unchanged
 m,merge            always used (no-op)
 i,interactive      always used (no-op)
  Actions:
@@ -103,6 +104,7 @@ VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
 REBASE_ROOT=
 AUTOSQUASH=
+FORCE=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -222,7 +224,7 @@ do_with_author () {
 }
 
 pick_one () {
-	no_ff=
+	no_ff=$FORCE
 	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
@@ -742,6 +744,9 @@ first and then run 'git rebase --continue' again."
 	-i)
 		# yeah, we know
 		;;
+	-f)
+		FORCE=t
+		;;
 	--root)
 		REBASE_ROOT=t
 		;;
@@ -927,7 +932,7 @@ EOF
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
-		test -d "$REWRITTEN" || skip_unnecessary_picks
+		test -d "$REWRITTEN" || test -n "$FORCE" || skip_unnecessary_picks
 
 		git update-ref ORIG_HEAD $HEAD
 		output git checkout $ONTO && do_rest
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4e35137..a169470 100755
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
+#    N - O - P                 (force-branch)
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
+	git checkout -b force-branch A &&
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
+test_expect_success 'always cherry-pick with -f' '
+	git checkout force-branch &&
+	git tag original-force-branch &&
+	git rebase -i -f A &&
+	touch empty &&
+	for p in 0 1 2
+	do
+		test ! $(git rev-parse HEAD~$p) = $(git rev-parse original-force-branch~$p) &&
+		git diff HEAD~$p original-force-branch~$p > out &&
+		test_cmp empty out
+	done &&
+	test $(git rev-parse HEAD~3) = $(git rev-parse original-force-branch~3) &&
+	git diff HEAD~3 original-force-branch~3 > out &&
+	test_cmp empty out
+'
+
 test_done
-- 
1.7.0.3.dirty
