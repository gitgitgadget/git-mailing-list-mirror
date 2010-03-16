From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] Teach --no-ff option to 'rebase -i'.
Date: Tue, 16 Mar 2010 12:08:55 -0400
Message-ID: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 17:12:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrZO1-0005Lw-CY
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 17:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966476Ab0CPQMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 12:12:48 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:50350 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S966378Ab0CPQMq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 12:12:46 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2010 12:12:46 EDT
Received: from rincewind (rincewind.xiplink.com [192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2GG7dnP032171;
	Tue, 16 Mar 2010 12:07:39 -0400
Received: by rincewind (Postfix, from userid 1000)
	id 7E5D23365A9; Tue, 16 Mar 2010 12:09:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142340>

This option tells rebase--interactive to cherry-pick all the commits in the
rebased branch, instead of fast-forwarding over any unchanged commits.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

This offers an alterntive way to deal with reverted merges (the
revert-a-faulty-merge.txt howto recommends reverting the initial reversion
before re-merging a modified topic branch).

With this change, you can instead use the --no-ff option to recreate the
branch with entirely new commits (they're new because at the very least the
committer time is different).  This obviates the need to revert the
reversion, as you can re-merge the new topic branch directly.

(Honestly, I wouldn't say that this approach is vastly superior to
reverting the reversion.  I just find it a little less messy and a little
more intuitive.  It's also a bit easier to explain to people to "use --no-ff
after reverting a merge" instead of making sure they get the double-
reversion right.)

		M.

 Documentation/git-rebase.txt |   13 ++++++++++++-
 git-rebase--interactive.sh   |   10 ++++++++--
 t/t3417-rebase-no-ff.sh      |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100755 t/t3417-rebase-no-ff.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 823f2a4..01f1476 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -316,7 +316,18 @@ which makes little sense.
 	commit to be modified, and change the action of the moved
 	commit from `pick` to `squash` (or `fixup`).
 +
-This option is only valid when '--interactive' option is used.
+This option is only valid when the '--interactive' option is used.
+
+--no-ff::
+	Cherry-pick all rebased commits instead of fast-forwarding over
+	the unchanged ones.  This ensures that the entire history of the
+	rebased branch is composed of new commits.  You may find this
+	helpful after reverting a topic branch merge, as this option
+	recreates the topic branch with fresh commits so it can be remerged
+	successfully without needing to "reverting the reversion" (as described
+	in the link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To]).
++
+This option is only valid when the '--interactive' option is used.
 
 include::merge-strategies.txt[]
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3e4fd14..aecac3e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -20,6 +20,7 @@ v,verbose          display a diffstat of what changed upstream
 onto=              rebase onto given branch instead of upstream
 p,preserve-merges  try to recreate merges instead of ignoring them
 s,strategy=        use the given merge strategy
+no-ff              never fast-forward any commits, even if they're unchanged
 m,merge            always used (no-op)
 i,interactive      always used (no-op)
  Actions:
@@ -103,6 +104,7 @@ VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
 REBASE_ROOT=
 AUTOSQUASH=
+NO_SKIP=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -222,7 +224,7 @@ do_with_author () {
 }
 
 pick_one () {
-	no_ff=
+	no_ff=$NO_SKIP
 	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
@@ -742,6 +744,10 @@ first and then run 'git rebase --continue' again."
 	-i)
 		# yeah, we know
 		;;
+	--no-ff)
+		# Set -n parameter to pass to pick_one function
+		NO_SKIP=t
+		;;
 	--root)
 		REBASE_ROOT=t
 		;;
@@ -927,7 +933,7 @@ EOF
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
-		test -d "$REWRITTEN" || skip_unnecessary_picks
+		test -d "$REWRITTEN" || ( test -z "$NO_SKIP" && skip_unnecessary_picks )
 
 		git update-ref ORIG_HEAD $HEAD
 		output git checkout $ONTO && do_rest
diff --git a/t/t3417-rebase-no-ff.sh b/t/t3417-rebase-no-ff.sh
new file mode 100755
index 0000000..29455da
--- /dev/null
+++ b/t/t3417-rebase-no-ff.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Marc Branchaud
+#
+
+test_description='git rebase -i --no-ff tests'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+set_fake_editor
+
+test_expect_success setup '
+	echo hello > hello &&
+	git add hello &&
+	git commit -m "hello" &&
+
+	echo world >> hello &&
+	git commit -a -m "hello world" &&
+
+	echo goodbye >> hello &&
+	git commit -a -m "goodbye" &&
+
+	git tag old_head
+	'
+# Pause to ensure that the cherry-picked commits have a different
+# timestamp.
+sleep 1
+
+test_expect_success rebase '
+	git rebase -i --no-ff HEAD~2 &&
+	test ! $(git rev-parse HEAD) = $(git rev-parse old_head)
+	'
+
+test_done
-- 
1.7.0.2.dirty
