From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 2/2] Teach the --no-ff option to 'rebase -i'.
Date: Wed, 24 Mar 2010 11:41:01 -0400
Message-ID: <1269445261-2941-3-git-send-email-marcnarc@xiplink.com>
References: <7vzl1yd5j4.fsf@alter.siamese.dyndns.org>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 16:56:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuSwS-0007xE-GB
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 16:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440Ab0CXPio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 11:38:44 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:39149 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756293Ab0CXPin (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 11:38:43 -0400
Received: from rincewind (rincewind.xiplink.com [192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2OFcHdd012149;
	Wed, 24 Mar 2010 11:38:18 -0400
Received: by rincewind (Postfix, from userid 1000)
	id 93C4333666D; Wed, 24 Mar 2010 11:41:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.1.g59254.dirty
In-Reply-To: <7vzl1yd5j4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143088>

This option tells git-rebase--interactive to cherry-pick all the commits in
the rebased branch, instead of fast-forwarding over any unchanged commits.

--no-ff offers an alterntive way to deal with reverted merges.  Instead of
"reverting the revert" you can use "rebase -i --no-ff" to recreate the
branch with entirely new commits (they're new because at the very least the
committer time is different).  This obviates the need to revert the
reversion, as you can re-merge the new topic branch directly.  Added an
addendum to revert-a-faulty-merge.txt describing the situation and how to
use --no-ff to handle it.

--force-rebase also provides this alternative with non-interactive rebase,
so updated rebase's man page to mention it.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-rebase.txt                  |   23 +++++++++-
 Documentation/howto/revert-a-faulty-merge.txt |   61 +++++++++++++++++++++++++
 git-rebase--interactive.sh                    |    9 +++-
 t/t3404-rebase-interactive.sh                 |   36 +++++++++++++--
 4 files changed, 121 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 823f2a4..ca06c55 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -274,9 +274,15 @@ which makes little sense.
 -f::
 --force-rebase::
 	Force the rebase even if the current branch is a descendant
-	of the commit you are rebasing onto.  Normally the command will
+	of the commit you are rebasing onto.  Normally non-interactive rebase will
 	exit with the message "Current branch is up to date" in such a
 	situation.
++
+You may find this (or --no-ff with an interactive rebase) helpful after
+reverting a topic branch merge, as this option recreates the topic branch with
+fresh commits so it can be remerged successfully without needing to "reverting
+the reversion" (as described in the
+link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To]).
 
 --ignore-whitespace::
 --whitespace=<option>::
@@ -316,7 +322,20 @@ which makes little sense.
 	commit to be modified, and change the action of the moved
 	commit from `pick` to `squash` (or `fixup`).
 +
-This option is only valid when '--interactive' option is used.
+This option is only valid when the '--interactive' option is used.
+
+--no-ff::
+	Cherry-pick all rebased commits instead of fast-forwarding over
+	the unchanged ones.  This ensures that the entire history of the
+	rebased branch is composed of new commits.
++
+This option is only valid when the '--interactive' option is used.
++
+You may find this (or --force-rebase with a non-interactive rebase) helpful
+after reverting a topic branch merge, as this option recreates the topic
+branch with fresh commits so it can be remerged successfully without needing
+to "reverting the reversion" (as described in the
+link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To]).
 
 include::merge-strategies.txt[]
 
diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 3b4a390..eaa8b32 100644
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
@@ -177,3 +179,62 @@ the answer is: "oops, I really shouldn't have merged it, because it wasn't
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
+recreate it as a new commit with the same changes in it.  The rebase commmand's
+two modes (interactive and non-interactive) provide options to do this.  With
+"rebase -i" use the --no-ff option:
+
+    $ git rebase -i --no-ff P
+
+With plain "rebase" use the -f option:
+
+    $ git rebase -f P
+
+Both these commands create a new branch A'-B'-C' with all-new commits (all the
+SHA IDs will be different) even if in the interactive case you only actually
+modify commit B.  You can then merge this new branch directly into the mainline
+branch and be sure you'll get all of the branch's changes.
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index aa0ab1a..42aa705 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -20,6 +20,7 @@ v,verbose          display a diffstat of what changed upstream
 onto=              rebase onto given branch instead of upstream
 p,preserve-merges  try to recreate merges instead of ignoring them
 s,strategy=        use the given merge strategy
+no-ff              cherry-pick all commits, even if unchanged
 m,merge            always used (no-op)
 i,interactive      always used (no-op)
 f,force-rebase     always used (no-op)
@@ -104,6 +105,7 @@ VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
 REBASE_ROOT=
 AUTOSQUASH=
+NEVER_FF=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -223,7 +225,7 @@ do_with_author () {
 }
 
 pick_one () {
-	no_ff=
+	no_ff=$NEVER_FF
 	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
@@ -746,6 +748,9 @@ first and then run 'git rebase --continue' again."
 	-i)
 		# yeah, we know
 		;;
+	--no-ff)
+		NEVER_FF=t
+		;;
 	--root)
 		REBASE_ROOT=t
 		;;
@@ -931,7 +936,7 @@ EOF
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
-		test -d "$REWRITTEN" || skip_unnecessary_picks
+		test -d "$REWRITTEN" || test -n "$NEVER_FF" || skip_unnecessary_picks
 
 		git update-ref ORIG_HEAD $HEAD
 		output git checkout $ONTO && do_rest
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
1.7.0.3.1.g59254.dirty
