From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/2] rebase -i: save only original commit sha1 to save
	author information
Date: Mon, 22 Jun 2009 06:28:30 +0200
Message-ID: <20090622042831.3858.67926.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 06:34:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIbEv-0001Ky-R4
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 06:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbZFVEdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 00:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbZFVEdh
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 00:33:37 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:37065 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbZFVEdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 00:33:36 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D31018180B8;
	Mon, 22 Jun 2009 06:33:30 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7D2BB8180E3;
	Mon, 22 Jun 2009 06:33:27 +0200 (CEST)
X-git-sha1: cafeacd6dd87b9aaff12778fd586558040ca38d0 
X-Mailer: git-mail-commits v0.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122008>

This is better than saving author information in a shell script,
because it will make it much easier to port "rebase -i" to C.

This also removes some sed regexps and some "eval"s.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |   69 ++++++++++++++++++++-----------------------
 1 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 92e2523..a7a169e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -40,6 +40,7 @@ MSG="$DOTEST"/message
 SQUASH_MSG="$DOTEST"/message-squash
 REWRITTEN="$DOTEST"/rewritten
 DROPPED="$DOTEST"/dropped
+SAVED_COMMIT="$DOTEST"/saved-commit
 PRESERVE_MERGES=
 STRATEGY=
 ONTO=
@@ -117,30 +118,25 @@ mark_action_done () {
 }
 
 get_author_ident_from_commit () {
-	pick_author_script='
-	/^author /{
-		s/'\''/'\''\\'\'\''/g
-		h
-		s/^author \([^<]*\) <[^>]*> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
-
-		g
-		s/^author [^<]* <\([^>]*\)> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
-
-		g
-		s/^author [^<]* <[^>]*> \(.*\)$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
-
-		q
-	}
-	'
-	encoding=$(git config i18n.commitencoding || echo UTF-8)
-	git show -s --pretty=raw --encoding="$encoding" "$1" -- |
-	LANG=C LC_ALL=C sed -ne "$pick_author_script"
+	encoding=$(git config i18n.commitencoding || echo UTF-8) &&
+	author_ident_name=$(git show -s --pretty="format:%an" \
+		--encoding="$encoding" "$1" --) &&
+	author_ident_email=$(git show -s --pretty="format:%ae" \
+		--encoding="$encoding" "$1" --) &&
+	author_ident_date=$(git show -s --pretty="format:%ai" \
+		--encoding="$encoding" "$1" --)
+}
+
+set_author_ident () {
+	GIT_AUTHOR_NAME="$author_ident_name" &&
+	GIT_AUTHOR_EMAIL="$author_ident_email" &&
+	GIT_AUTHOR_DATE="$author_ident_date"
+}
+
+load_author_ident () {
+	commit=$(cat "$SAVED_COMMIT") &&
+	get_author_ident_from_commit "$commit" &&
+	set_author_ident
 }
 
 make_patch () {
@@ -158,8 +154,8 @@ make_patch () {
 	esac > "$DOTEST"/patch
 	test -f "$DOTEST"/message ||
 		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
-	test -f "$DOTEST"/author-script ||
-		get_author_ident_from_commit "$1" > "$DOTEST"/author-script
+	test -f "$SAVED_COMMIT" ||
+		echo $(git rev-parse --verify "$1") > "$SAVED_COMMIT"
 }
 
 die_with_patch () {
@@ -294,8 +290,8 @@ pick_one_preserving_merges () {
 			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
 
 			# redo merge
-			author_script=$(get_author_ident_from_commit $sha1)
-			eval "$author_script"
+			get_author_ident_from_commit $sha1
+			set_author_ident
 			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
@@ -353,8 +349,7 @@ peek_next_command () {
 }
 
 do_next () {
-	rm -f "$DOTEST"/message "$DOTEST"/author-script \
-		"$DOTEST"/amend || exit
+	rm -f "$DOTEST"/message "$DOTEST"/amend "$SAVED_COMMIT" || exit
 	read command sha1 rest < "$TODO"
 	case "$command" in
 	'#'*|''|noop)
@@ -395,7 +390,8 @@ do_next () {
 		mark_action_done
 		make_squash_message $sha1 > "$MSG"
 		failed=f
-		author_script=$(get_author_ident_from_commit HEAD)
+		get_author_ident_from_commit HEAD
+		commit=$(git rev-parse --verify HEAD)
 		output git reset --soft HEAD^
 		pick_one -n $sha1 || failed=t
 		case "$(peek_next_command)" in
@@ -414,14 +410,13 @@ do_next () {
 			rm -f "$GIT_DIR"/MERGE_MSG || exit
 			;;
 		esac
-		echo "$author_script" > "$DOTEST"/author-script
+		echo "$commit" > "$SAVED_COMMIT"
 		if test $failed = f
 		then
 			# This is like --amend, but with a different message
-			eval "$author_script"
-			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
-			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
-			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
+			GIT_AUTHOR_NAME="$author_ident_name" \
+			GIT_AUTHOR_EMAIL="$author_ident_email" \
+			GIT_AUTHOR_DATE="$author_ident_date" \
 			$USE_OUTPUT git commit --no-verify \
 				$MSG_OPT "$EDIT_OR_FILE" || failed=t
 		fi
@@ -536,7 +531,7 @@ do
 		then
 			: Nothing to commit -- skip this
 		else
-			. "$DOTEST"/author-script ||
+			load_author_ident ||
 				die "Cannot find the author identity"
 			amend=
 			if test -f "$DOTEST"/amend
-- 
1.6.3.GIT
