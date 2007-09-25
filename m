From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/5] rebase -i: style fixes and minor cleanups
Date: Tue, 25 Sep 2007 16:42:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251642430.28395@racer.site>
References: <Pine.LNX.4.64.0709251640360.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 25 17:44:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaCZv-0002HB-Kt
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 17:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbXIYPn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 11:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755012AbXIYPnz
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 11:43:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:50223 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755307AbXIYPny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 11:43:54 -0400
Received: (qmail invoked by alias); 25 Sep 2007 15:43:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 25 Sep 2007 17:43:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dIOA8rKJdKFebIrJgJZH64fG+XVfuLGv1fUTXma
	IU/b7leY9hafpb
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709251640360.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59138>


This patch indents ";;" consistently with the rest of git's shell scripts,
and makes sure that ";;" are before each "esac".

It introduces a helper function "has_action", to make it easier to read
the intentions of the code.

Errors from "git rev-parse --verify" are no longer ignored.

Spaces are quoted using single quotes instead of a backslash, for
readability.

A "test $preserve=f" (missing spaces) was fixed; hashes are no longer
written to "$DOTEST"/rewritten/ unnecessarily.

We used to quote the message for a squash, only to have "echo" unquote it.
Now we use "printf" and do not need to quote to start with.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   48 +++++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 58f6f28..c850411 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -41,9 +41,10 @@ output () {
 		test $status != 0 &&
 			cat "$DOTEST"/output
 		return $status
-	;;
+		;;
 	*)
 		"$@"
+		;;
 	esac
 }
 
@@ -63,6 +64,7 @@ comment_for_reflog () {
 	''|rebase*)
 		GIT_REFLOG_ACTION="rebase -i ($1)"
 		export GIT_REFLOG_ACTION
+		;;
 	esac
 }
 
@@ -96,13 +98,18 @@ die_abort () {
 	die "$1"
 }
 
+has_action () {
+	grep -vqe '^$' -e '^#' "$1"
+}
+
 pick_one () {
 	no_ff=
 	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
 		pick_one_preserving_merges "$@" && return
-	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
+	parent_sha1=$(git rev-parse --verify $sha1^) ||
+		die "Could not get the parent of $sha1"
 	current_sha1=$(git rev-parse --verify HEAD)
 	if test $no_ff$current_sha1 = $parent_sha1; then
 		output git reset --hard $sha1
@@ -130,7 +137,7 @@ pick_one_preserving_merges () {
 	fast_forward=t
 	preserve=t
 	new_parents=
-	for p in $(git rev-list --parents -1 $sha1 | cut -d\  -f2-)
+	for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
 	do
 		if test -f "$REWRITTEN"/$p
 		then
@@ -142,41 +149,43 @@ pick_one_preserving_merges () {
 				;; # do nothing; that parent is already there
 			*)
 				new_parents="$new_parents $new_p"
+				;;
 			esac
 		fi
 	done
 	case $fast_forward in
 	t)
 		output warn "Fast forward to $sha1"
-		test $preserve=f && echo $sha1 > "$REWRITTEN"/$sha1
+		test $preserve = f || echo $sha1 > "$REWRITTEN"/$sha1
 		;;
 	f)
 		test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
 
-		first_parent=$(expr "$new_parents" : " \([^ ]*\)")
+		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
 		# detach HEAD to current parent
 		output git checkout $first_parent 2> /dev/null ||
 			die "Cannot move HEAD to $first_parent"
 
 		echo $sha1 > "$DOTEST"/current-commit
 		case "$new_parents" in
-		\ *\ *)
+		' '*' '*)
 			# redo merge
 			author_script=$(get_author_ident_from_commit $sha1)
 			eval "$author_script"
-			msg="$(git cat-file commit $sha1 | \
-				sed -e '1,/^$/d' -e "s/[\"\\]/\\\\&/g")"
+			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
 			# NEEDSWORK: give rerere a chance
 			if ! output git merge $STRATEGY -m "$msg" $new_parents
 			then
-				echo "$msg" > "$GIT_DIR"/MERGE_MSG
+				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
 				die Error redoing merge $sha1
 			fi
 			;;
 		*)
 			output git cherry-pick $STRATEGY "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
+			;;
 		esac
+		;;
 	esac
 }
 
@@ -213,12 +222,11 @@ peek_next_command () {
 }
 
 do_next () {
-	test -f "$DOTEST"/message && rm "$DOTEST"/message
-	test -f "$DOTEST"/author-script && rm "$DOTEST"/author-script
-	test -f "$DOTEST"/amend && rm "$DOTEST"/amend
+	rm -f "$DOTEST"/message "$DOTEST"/author-script \
+		"$DOTEST"/amend || exit
 	read command sha1 rest < "$TODO"
 	case "$command" in
-	\#|'')
+	'#'*|'')
 		mark_action_done
 		;;
 	pick)
@@ -246,7 +254,7 @@ do_next () {
 	squash)
 		comment_for_reflog squash
 
-		test -z "$(grep -ve '^$' -e '^#' < $DONE)" &&
+		has_action "$DONE" ||
 			die "Cannot 'squash' without a previous commit"
 
 		mark_action_done
@@ -256,11 +264,12 @@ do_next () {
 			EDIT_COMMIT=
 			USE_OUTPUT=output
 			cp "$MSG" "$SQUASH_MSG"
-		;;
+			;;
 		*)
 			EDIT_COMMIT=-e
 			USE_OUTPUT=
-			test -f "$SQUASH_MSG" && rm "$SQUASH_MSG"
+			rm -f "$SQUASH_MSG" || exit
+			;;
 		esac
 
 		failed=f
@@ -280,11 +289,13 @@ do_next () {
 			warn
 			warn "Could not apply $sha1... $rest"
 			die_with_patch $sha1 ""
+			;;
 		esac
 		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
+		;;
 	esac
 	test -s "$TODO" && return
 
@@ -475,17 +486,18 @@ EOF
 			$UPSTREAM...$HEAD | \
 			sed -n "s/^>/pick /p" >> "$TODO"
 
-		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
+		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
 		cp "$TODO" "$TODO".backup
 		git_editor "$TODO" ||
 			die "Could not execute editor"
 
-		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
+		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
 		output git checkout $ONTO && do_rest
+		;;
 	esac
 	shift
 done
-- 
1.5.3.2.1057.gf4dc1
