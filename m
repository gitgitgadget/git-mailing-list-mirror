From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] Ignore dirty submodule states during rebase and stash
Date: Wed, 14 May 2008 18:03:59 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141803510.30431@racer>
References: <alpine.DEB.1.00.0805141802480.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 14 19:05:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwKPK-000824-Jv
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbYENRD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbYENRD7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:03:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:59257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752779AbYENRD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:03:58 -0400
Received: (qmail invoked by alias); 14 May 2008 17:03:56 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp021) with SMTP; 14 May 2008 19:03:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185KSIqi6Y5wa1cJASAZgEHf9RiuPgJScM/7wGyRn
	njsuUwzNFniKyT
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805141802480.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82115>


When rebasing or stashing, chances are that you do not care about
dirty submodules, since they are not updated by those actions anyway.
So ignore the submodules' states.

Note: the submodule states -- as committed in the superproject --
will still be stashed and rebased, it is _just_ the state of the
submodule in the working tree which is ignored.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh  |   11 +++--
 git-rebase.sh               |    8 ++--
 git-stash.sh                |    6 +-
 t/t7402-submodule-rebase.sh |   92 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 12 deletions(-)
 create mode 100755 t/t7402-submodule-rebase.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2a01182..a9daa1b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -56,9 +56,9 @@ output () {
 require_clean_work_tree () {
 	# test if working tree is dirty
 	git rev-parse --verify HEAD > /dev/null &&
-	git update-index --refresh &&
-	git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD -- ||
+	git update-index --ignore-submodules --refresh &&
+	git diff-files --quiet --ignore-submodules &&
+	git diff-index --cached --quiet HEAD --ignore-submodules -- ||
 	die "Working tree is dirty"
 }
 
@@ -526,11 +526,12 @@ do
 		# Sanity check
 		git rev-parse --verify HEAD >/dev/null ||
 			die "Cannot read HEAD"
-		git update-index --refresh && git diff-files --quiet ||
+		git update-index --ignore-submodules --refresh &&
+			git diff-files --quiet --ignore-submodules ||
 			die "Working tree is dirty"
 
 		# do we have anything to commit?
-		if git diff-index --cached --quiet HEAD --
+		if git diff-index --cached --quiet --ignore-submodules HEAD --
 		then
 			: Nothing to commit -- skip this
 		else
diff --git a/git-rebase.sh b/git-rebase.sh
index 68855c1..dd7dfe1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -60,7 +60,7 @@ continue_merge () {
 	fi
 
 	cmt=`cat "$dotest/current"`
-	if ! git diff-index --quiet HEAD --
+	if ! git diff-index --quiet --ignore-submodules HEAD --
 	then
 		if ! git commit --no-verify -C "$cmt"
 		then
@@ -150,7 +150,7 @@ while test $# != 0
 do
 	case "$1" in
 	--continue)
-		git diff-files --quiet || {
+		git diff-files --quiet --ignore-submodules || {
 			echo "You must edit all merge conflicts and then"
 			echo "mark them as resolved using git add"
 			exit 1
@@ -282,8 +282,8 @@ else
 fi
 
 # The tree must be really really clean.
-git update-index --refresh || exit
-diff=$(git diff-index --cached --name-status -r HEAD --)
+git update-index --ignore-submodules --refresh || exit
+diff=$(git diff-index --cached --name-status -r --ignore-submodules HEAD --)
 case "$diff" in
 ?*)	echo "cannot rebase: your index is not up-to-date"
 	echo "$diff"
diff --git a/git-stash.sh b/git-stash.sh
index c2b6820..4938ade 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -15,8 +15,8 @@ trap 'rm -f "$TMP-*"' 0
 ref_stash=refs/stash
 
 no_changes () {
-	git diff-index --quiet --cached HEAD -- &&
-	git diff-files --quiet
+	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
+	git diff-files --quiet --ignore-submodules
 }
 
 clear_stash () {
@@ -130,7 +130,7 @@ show_stash () {
 }
 
 apply_stash () {
-	git diff-files --quiet ||
+	git diff-files --quiet --ignore-submodules ||
 		die 'Cannot restore on top of a dirty state'
 
 	unstash_index=
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
new file mode 100755
index 0000000..5becb3e
--- /dev/null
+++ b/t/t7402-submodule-rebase.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Johannes Schindelin
+#
+
+test_description='Test rebasing and stashing with dirty submodules'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	git clone . submodule &&
+	git add submodule &&
+	test_tick &&
+	git commit -m submodule &&
+	echo second line >> file &&
+	(cd submodule && git pull) &&
+	test_tick &&
+	git commit -m file-and-submodule -a
+
+'
+
+test_expect_success 'rebase with a dirty submodule' '
+
+	(cd submodule &&
+	 echo 3rd line >> file &&
+	 test_tick &&
+	 git commit -m fork -a) &&
+	echo unrelated >> file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m unrelated file2 &&
+	echo other line >> file &&
+	test_tick &&
+	git commit -m update file &&
+	CURRENT=$(cd submodule && git rev-parse HEAD) &&
+	EXPECTED=$(git rev-parse HEAD~2:submodule) &&
+	GIT_TRACE=1 git rebase --onto HEAD~2 HEAD^ &&
+	STORED=$(git rev-parse HEAD:submodule) &&
+	test $EXPECTED = $STORED &&
+	test $CURRENT = $(cd submodule && git rev-parse HEAD)
+
+'
+
+cat > fake-editor.sh << \EOF
+#!/bin/sh
+echo $EDITOR_TEXT
+EOF
+chmod a+x fake-editor.sh
+
+test_expect_success 'interactive rebase with a dirty submodule' '
+
+	test submodule = $(git diff --name-only) &&
+	HEAD=$(git rev-parse HEAD) &&
+	GIT_EDITOR="\"$(pwd)/fake-editor.sh\"" EDITOR_TEXT="pick $HEAD" \
+		git rebase -i HEAD^ &&
+	test submodule = $(git diff --name-only)
+
+'
+
+test_expect_success 'rebase with dirty file and submodule fails' '
+
+	echo yet another line >> file &&
+	test_tick &&
+	git commit -m next file &&
+	echo rewrite > file &&
+	test_tick &&
+	git commit -m rewrite file &&
+	echo dirty > file &&
+	! git rebase --onto HEAD~2 HEAD^
+
+'
+
+test_expect_success 'stash with a dirty submodule' '
+
+	echo new > file &&
+	CURRENT=$(cd submodule && git rev-parse HEAD) &&
+	git stash &&
+	test new != $(cat file) &&
+	test submodule = $(git diff --name-only) &&
+	test $CURRENT = $(cd submodule && git rev-parse HEAD) &&
+	git stash apply &&
+	test new = $(cat file) &&
+	test $CURRENT = $(cd submodule && git rev-parse HEAD)
+
+'
+
+test_done
-- 
1.5.5.1.375.g1becb
