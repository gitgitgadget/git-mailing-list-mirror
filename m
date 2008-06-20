From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/3] rebase-i: slight internal improvements
Date: Fri, 20 Jun 2008 04:45:34 +0200
Message-ID: <1213929935-15093-3-git-send-email-s-beyer@gmx.net>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net>
 <1213929935-15093-2-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 04:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9WeN-0006EA-5z
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 04:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbYFTCpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 22:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYFTCpt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 22:45:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:44922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751957AbYFTCpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 22:45:41 -0400
Received: (qmail invoked by alias); 20 Jun 2008 02:45:39 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp063) with SMTP; 20 Jun 2008 04:45:39 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19rIqFNDl5r0tmJSno5WzBxfx7CEQpTBFdrXUSZXh
	WfbnE0Hg9SN80u
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9Wd5-0003x1-IE; Fri, 20 Jun 2008 04:45:35 +0200
X-Mailer: git-send-email 1.5.5.1.561.gd8556
In-Reply-To: <1213929935-15093-2-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85590>

Add commit_message function to get the commit message
from a commit and other slight internal improvements.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-rebase--interactive.sh |   61 +++++++++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3f926d8..e8ac2ae 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -25,6 +25,7 @@ SQUASH_MSG="$DOTEST"/message-squash
 PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
+MARK_PREFIX='refs/rebase-marks'
 test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 test -f "$DOTEST"/verbose && VERBOSE=t
 
@@ -33,7 +34,6 @@ mark the corrected paths with 'git add <paths>', and
 run 'git rebase --continue'"
 export GIT_CHERRY_PICK_HELP
 
-mark_prefix=refs/rebase-marks/
 
 warn () {
 	echo "$*" >&2
@@ -73,13 +73,18 @@ comment_for_reflog () {
 	esac
 }
 
+# Get commit message from commit $1
+commit_message () {
+	git cat-file commit "$1" | sed -e '1,/^$/d'
+}
+
 last_count=
 mark_action_done () {
-	sed -e 1q < "$TODO" >> "$DONE"
-	sed -e 1d < "$TODO" >> "$TODO".new
-	mv -f "$TODO".new "$TODO"
-	count=$(grep -c '^[^#]' < "$DONE")
-	total=$(($count+$(grep -c '^[^#]' < "$TODO")))
+	sed -e 1q "$TODO" >>"$DONE"
+	sed -e 1d "$TODO" >>"$TODO.new"
+	mv -f "$TODO.new" "$TODO"
+	count="$(grep -c '^[^#]' "$DONE")"
+	total="$(expr "$count" + "$(grep -c '^[^#]' "$TODO")")"
 	if test "$last_count" != "$count"
 	then
 		last_count=$count
@@ -88,16 +93,18 @@ mark_action_done () {
 	fi
 }
 
+# Generate message, patch and author script files
 make_patch () {
 	parent_sha1=$(git rev-parse --verify "$1"^) ||
 		die "Cannot get patch for $1^"
 	git diff-tree -p "$parent_sha1".."$1" > "$DOTEST"/patch
 	test -f "$DOTEST"/message ||
-		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
+		commit_message "$1" >"$DOTEST"/message
 	test -f "$DOTEST"/author-script ||
 		get_author_ident_from_commit "$1" > "$DOTEST"/author-script
 }
 
+# Generate a patch and die
 die_with_patch () {
 	make_patch "$1"
 	git rerere
@@ -105,9 +112,9 @@ die_with_patch () {
 }
 
 cleanup_before_quit () {
-	for ref in $(git for-each-ref --format='%(refname)' "${mark_prefix%/}")
+	for ref in $(git for-each-ref --format='%(refname)' "$MARK_PREFIX")
 	do
-		git update-ref -d "$ref" "$ref" || return 1
+		git update-ref -d "$ref" "$ref" || return
 	done
 	rm -rf "$DOTEST"
 }
@@ -118,7 +125,7 @@ die_abort () {
 }
 
 has_action () {
-	grep '^[^#]' "$1" >/dev/null
+	grep -q '^[^#]' "$1"
 }
 
 redo_merge () {
@@ -126,7 +133,7 @@ redo_merge () {
 	shift
 
 	eval "$(get_author_ident_from_commit $rm_sha1)"
-	msg="$(git cat-file commit $rm_sha1 | sed -e '1,/^$/d')"
+	msg="$(commit_message "$rm_sha1")"
 
 	if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 		GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
@@ -167,37 +174,39 @@ nth_string () {
 }
 
 make_squash_message () {
-	if test -f "$SQUASH_MSG"; then
-		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
-			< "$SQUASH_MSG" | sed -ne '$p')+1))
+	if test -f "$SQUASH_MSG"
+	then
+		count="$(($(sed -n -e 's/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p' \
+			"$SQUASH_MSG" | sed -n -e '$p')+1))"
 		echo "# This is a combination of $COUNT commits."
 		sed -e 1d -e '2,/^./{
 			/^$/d
-		}' <"$SQUASH_MSG"
+		}' "$SQUASH_MSG"
 	else
 		COUNT=2
 		echo "# This is a combination of two commits."
 		echo "# The first commit's message is:"
 		echo
-		git cat-file commit HEAD | sed -e '1,/^$/d'
+		commit_message HEAD
 	fi
 	echo
 	echo "# This is the $(nth_string $COUNT) commit message:"
 	echo
-	git cat-file commit $1 | sed -e '1,/^$/d'
+	commit_message "$1"
 }
 
 peek_next_command () {
-	sed -n "1s/ .*$//p" < "$TODO"
+	sed -n -e '1s/ .*$//p' "$TODO"
 }
 
+# If $1 is a mark, make a ref from it; otherwise keep it
 mark_to_ref () {
-	if expr "$1" : "^:[0-9][0-9]*$" >/dev/null
-	then
-		echo "$mark_prefix$(printf %d ${1#:})"
-	else
-		echo "$1"
-	fi
+	arg="$1"
+	ref="$(expr "$arg" : '^:0*\([0-9]\+\)$')"
+	test -n "$ref" &&
+		arg="$MARK_PREFIX/$ref"
+	printf '%s\n' "$arg"
+	unset arg ref
 }
 
 do_next () {
@@ -634,7 +643,7 @@ do
 		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
 		test -z "$ONTO" && ONTO=$UPSTREAM
 
-		if test ! -z "$2"
+		if test -n "$2"
 		then
 			output git show-ref --verify --quiet "refs/heads/$2" ||
 				die "Invalid branchname: $2"
@@ -674,7 +683,7 @@ do
 				create_extended_todo_list
 		else
 			git rev-list --no-merges --reverse --pretty=oneline \
-				 $common_rev_list_opts | sed -n "s/^>/pick /p"
+				 $common_rev_list_opts | sed -n -e 's/^>/pick /p'
 		fi > "$TODO"
 
 		cat >> "$TODO" << EOF
-- 
1.5.5.1.561.gd8556
