From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix overzealous cleanliness check in git-merge
Date: Fri, 23 Sep 2005 01:33:40 -0700
Message-ID: <7vslvwfajf.fsf_-_@assigned-by-dhcp.cox.net>
References: <E1EIWUv-0004HR-F6@jdl.com>
	<Pine.LNX.4.58.0509221413400.2553@g5.osdl.org>
	<Pine.LNX.4.58.0509221427520.2553@g5.osdl.org>
	<Pine.LNX.4.63.0509221747340.23242@iabervon.org>
	<Pine.LNX.4.58.0509221500150.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 10:34:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIj0I-0000ph-F4
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 10:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVIWIdw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 04:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVIWIdw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 04:33:52 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14498 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750810AbVIWIdv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 04:33:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923083342.EGUX6728.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 04:33:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509221500150.2553@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 22 Sep 2005 15:05:02 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9163>

Being able to try multiple strategies and automatically picking one
that seems to give less conflicting result may or may not much sense
in practice.  At least that should not force normal use case to
additionally require the working tree to be fully clean.  As Linus
shouted, local changes do not matter unless they interfere with the
merge.

This commit changes git-merge not to require a clean working tree.
Only when we will iterate through more than one merge strategies,
local changes are stashed away before trying the first merge, and
restored before second and later merges are attempted.

The index file must be in sync with HEAD in any case -- otherwise the
merge result would contain changes since HEAD that was done locally
and registered in the index.  This check is already enforced by
three-way read-tree existing merge strategies use, but is done here as
a safeguard as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Taking hint from your message, here is an attempt to fix the
 'incredibly broken' git-merge.  This does not make git-pull
 use it yet.

 git-merge.sh |   65 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 49 insertions(+), 16 deletions(-)

abfefa19cf56a312d571ea36a491152ac7aef657
diff --git a/git-merge.sh b/git-merge.sh
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -18,8 +18,19 @@ all_strategies='recursive octopus resolv
 default_strategies='resolve octopus'
 use_strategies=
 
-dropheads() {
-	rm -f -- "$GIT_DIR/MERGE_HEAD" || exit 1
+dropsave() {
+	rm -f -- "$GIT_DIR/MERGE_HEAD" \
+		 "$GIT_DIR/MERGE_SAVE" || exit 1
+}
+
+savestate() {
+	git diff -r -z --name-only $head | cpio -0 -o >"$GIR_DIR/MERGE_SAVE"
+}
+
+restorestate() {
+	git reset --hard $head
+	cpio -iuv <"$GIT_DIR/MERGE_SAVE"
+	git-update-index --refresh >/dev/null
 }
 
 summary() {
@@ -92,7 +103,7 @@ case "$#,$common" in
 	# If head can reach all the merge then we are up to date.
 	# but first the most common case of merging one remote
 	echo "Already up-to-date. Yeeah!"
-	dropheads
+	dropsave
 	exit 0
 	;;
 1,"$head")
@@ -102,7 +113,7 @@ case "$#,$common" in
 	git-read-tree -u -m $head "$1" || exit 1
 	git-rev-parse --verify "$1^0" > "$GIT_DIR/HEAD"
 	summary "$1"
-	dropheads
+	dropsave
 	exit 0
 	;;
 1,*)
@@ -124,29 +135,51 @@ case "$#,$common" in
 	if test "$up_to_date" = t
 	then
 		echo "Already up-to-date. Yeeah!"
-		dropheads
+		dropsave
 		exit 0
 	fi
 	;;
 esac
 
-# At this point we need a real merge.  Require that the tree matches
-# exactly our head.
 
-git-update-index --refresh &&
-test '' = "`git-diff-index --cached --name-only $head`" || {
-	die "Need real merge but the working tree has local changes."
-}
+# At this point, we need a real merge.  No matter what strategy
+# we use, it would operate on the index, possibly affecting the
+# working tree, and when resolved cleanly, have the desired tree
+# in the index -- this means that the index must be in sync with
+# the $head commit.
+files=$(git-diff-index --cached --name-only $head) || exit
+if [ "$files" ]; then
+   echo >&2 "Dirty index: cannot merge (dirty: $files)"
+   exit 1
+fi
+
+case "$use_strategies" in
+?*' '?*)
+    # Stash away the local changes so that we can try more than one.
+    savestate
+    single_strategy=no
+    ;;
+*)
+    single_strategy=yes
+    ;;
+esac
 
 result_tree= best_cnt=-1 best_strategy= wt_strategy=
 for strategy in $use_strategies
 do
     test "$wt_strategy" = '' || {
 	echo "Rewinding the tree to pristine..."
-	git reset --hard $head
+	restorestate
     }
-    echo "Trying merge strategy $strategy..."
+    case "$single_strategy" in
+    no)
+	echo "Trying merge strategy $strategy..."
+	;;
+    esac
+
+    # Remember which strategy left the state in the working tree
     wt_strategy=$strategy
+
     git-merge-$strategy $common -- $head "$@" || {
 
 	# The backend exits with 1 when conflicts are left to be resolved,
@@ -185,14 +218,14 @@ then
     echo "Committed merge $result_commit, made by $wt_strategy."
     echo $result_commit >"$GIT_DIR/HEAD"
     summary $result_commit
-    dropheads
+    dropsave
     exit 0
 fi
 
 # Pick the result from the best strategy and have the user fix it up.
 case "$best_strategy" in
 '')
-	git reset --hard $head
+	restorestate
 	die "No merge strategy handled the merge."
 	;;
 "$wt_strategy")
@@ -200,7 +233,7 @@ case "$best_strategy" in
 	;;
 *)
 	echo "Rewinding the tree to pristine..."
-	git reset --hard $head
+	restorestate
 	echo "Using the $best_strategy to prepare resolving by hand."
 	git-merge-$best_strategy $common -- $head "$@"
 	;;
