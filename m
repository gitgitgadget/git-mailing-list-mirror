From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Shut "git rebase -i" up when no --verbose was given
Date: Mon, 23 Jul 2007 23:45:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707232342090.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 24 00:46:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID6fN-00023E-DA
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 00:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXGWWqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXGWWqH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 18:46:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:45571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751264AbXGWWqE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 18:46:04 -0400
Received: (qmail invoked by alias); 23 Jul 2007 22:46:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 24 Jul 2007 00:46:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RcncFEbPRLqzg8DPmJZMPIIAvcqMH75gvvsIvKz
	v3PudFT+jwr+9M
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53496>


Up to now, git rebase -i was quite chatty, showing through all the
nice core programs it called.

Now it only shows a progress meter by default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   50 +++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 579a45e..ac1f5a2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -33,6 +33,20 @@ warn () {
 	echo "$*" >&2
 }
 
+output () {
+	case "$VERBOSE" in
+	'')
+		"$@" > "$DOTEST"/output 2>&1
+		status=$?
+		test $status != 0 &&
+			cat "$DOTEST"/output
+		return $status
+	;;
+	*)
+		"$@"
+	esac
+}
+
 require_clean_work_tree () {
 	# test if working tree is dirty
 	git rev-parse --verify HEAD > /dev/null &&
@@ -56,6 +70,10 @@ mark_action_done () {
 	sed -e 1q < "$TODO" >> "$DONE"
 	sed -e 1d < "$TODO" >> "$TODO".new
 	mv -f "$TODO".new "$TODO"
+	count=$(($(wc -l < "$DONE")))
+	total=$(($count+$(wc -l < "$TODO")))
+	printf "Rebasing (%d/%d)\r" $count $total
+	test -z "$VERBOSE" || echo
 }
 
 make_patch () {
@@ -79,18 +97,18 @@ die_abort () {
 
 pick_one () {
 	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
-	git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
+	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
 		pick_one_preserving_merges "$@" && return
 	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
 	current_sha1=$(git rev-parse --verify HEAD)
 	if [ $current_sha1 = $parent_sha1 ]; then
-		git reset --hard $sha1
-		test "a$1" = a-n && git reset --soft $current_sha1
+		output git reset --hard $sha1
+		test "a$1" = a-n && output git reset --soft $current_sha1
 		sha1=$(git rev-parse --short $sha1)
-		warn Fast forward to $sha1
+		output warn Fast forward to $sha1
 	else
-		git cherry-pick $STRATEGY "$@"
+		output git cherry-pick $STRATEGY "$@"
 	fi
 }
 
@@ -127,7 +145,7 @@ pick_one_preserving_merges () {
 	done
 	case $fast_forward in
 	t)
-		echo "Fast forward to $sha1"
+		output warn "Fast forward to $sha1"
 		test $preserve=f && echo $sha1 > "$REWRITTEN"/$sha1
 		;;
 	f)
@@ -135,7 +153,7 @@ pick_one_preserving_merges () {
 
 		first_parent=$(expr "$new_parents" : " \([^ ]*\)")
 		# detach HEAD to current parent
-		git checkout $first_parent 2> /dev/null ||
+		output git checkout $first_parent 2> /dev/null ||
 			die "Cannot move HEAD to $first_parent"
 
 		echo $sha1 > "$DOTEST"/current-commit
@@ -147,14 +165,14 @@ pick_one_preserving_merges () {
 			msg="$(git cat-file commit $sha1 | \
 				sed -e '1,/^$/d' -e "s/[\"\\]/\\\\&/g")"
 			# NEEDSWORK: give rerere a chance
-			if ! git merge $STRATEGY -m "$msg" $new_parents
+			if ! output git merge $STRATEGY -m "$msg" $new_parents
 			then
 				echo "$msg" > "$GIT_DIR"/MERGE_MSG
 				die Error redoing merge $sha1
 			fi
 			;;
 		*)
-			git cherry-pick $STRATEGY "$@" ||
+			output git cherry-pick $STRATEGY "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 		esac
 	esac
@@ -241,7 +259,7 @@ do_next () {
 
 		failed=f
 		pick_one -n $sha1 || failed=t
-		git reset --soft HEAD^
+		output git reset --soft HEAD^
 		author_script=$(get_author_ident_from_commit $sha1)
 		echo "$author_script" > "$DOTEST"/author-script
 		case $failed in
@@ -249,7 +267,7 @@ do_next () {
 			# This is like --amend, but with a different message
 			eval "$author_script"
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
-			git commit -F "$MSG" $EDIT_COMMIT
+			output git commit -F "$MSG" $EDIT_COMMIT
 			;;
 		t)
 			cp "$MSG" "$GIT_DIR"/MERGE_MSG
@@ -324,7 +342,7 @@ do
 		HEADNAME=$(cat "$DOTEST"/head-name)
 		HEAD=$(cat "$DOTEST"/head)
 		git symbolic-ref HEAD $HEADNAME &&
-		git reset --hard $HEAD &&
+		output git reset --hard $HEAD &&
 		rm -rf "$DOTEST"
 		exit
 		;;
@@ -333,7 +351,7 @@ do
 
 		test -d "$DOTEST" || die "No interactive rebase running"
 
-		git reset --hard && do_rest
+		output git reset --hard && do_rest
 		;;
 	-s|--strategy)
 		shift
@@ -387,9 +405,9 @@ do
 
 		if [ ! -z "$2"]
 		then
-			git show-ref --verify --quiet "refs/heads/$2" ||
+			output git show-ref --verify --quiet "refs/heads/$2" ||
 				die "Invalid branchname: $2"
-			git checkout "$2" ||
+			output git checkout "$2" ||
 				die "Could not checkout $2"
 		fi
 
@@ -456,7 +474,7 @@ EOF
 		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
 			die_abort "Nothing to do"
 
-		git checkout $ONTO && do_rest
+		output git checkout $ONTO && do_rest
 	esac
 	shift
 done
-- 
1.5.3.rc2.32.g35c5b
