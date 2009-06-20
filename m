From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] rebase -i: use some kind of config file to save author
	information
Date: Sat, 20 Jun 2009 04:34:12 +0200
Message-ID: <20090620023413.3995.3630.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 04:35:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHqQQ-00022k-4W
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 04:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbZFTCfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 22:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbZFTCfM
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 22:35:12 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39908 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbZFTCfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 22:35:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4DDA58180B8;
	Sat, 20 Jun 2009 04:35:03 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 06DCE818094;
	Sat, 20 Jun 2009 04:35:00 +0200 (CEST)
X-git-sha1: cafda14d02e2ddfb59bbd07bee35968535d84b88 
X-Mailer: git-mail-commits v0.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121922>

This is better than saving in a shell script, because it will make
it much easier to port "rebase -i" to C. This also removes some sed
regexps and some "eval"s.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |   78 +++++++++++++++++++++++---------------------
 1 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 92e2523..73f888a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -40,6 +40,7 @@ MSG="$DOTEST"/message
 SQUASH_MSG="$DOTEST"/message-squash
 REWRITTEN="$DOTEST"/rewritten
 DROPPED="$DOTEST"/dropped
+SAVE_AUTHOR_INFO="$DOTEST"/save-author-info
 PRESERVE_MERGES=
 STRATEGY=
 ONTO=
@@ -117,30 +118,31 @@ mark_action_done () {
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
+	author_ident_mail=$(git show -s --pretty="format:%ae" \
+		--encoding="$encoding" "$1" --) &&
+	author_ident_date=$(git show -s --pretty="format:%ai" \
+		--encoding="$encoding" "$1" --)
+}
+
+save_author_ident () {
+	GIT_CONFIG="$SAVE_AUTHOR_INFO" git config rebase.author.name \
+		"$author_ident_name" &&
+	GIT_CONFIG="$SAVE_AUTHOR_INFO" git config rebase.author.mail \
+		"$author_ident_mail" &&
+	GIT_CONFIG="$SAVE_AUTHOR_INFO" git config rebase.author.date \
+		"$author_ident_date"
+}
+
+load_author_ident () {
+	GIT_AUTHOR_NAME=$(GIT_CONFIG="$SAVE_AUTHOR_INFO" \
+		git config rebase.author.name) &&
+	GIT_AUTHOR_EMAIL=$(GIT_CONFIG="$SAVE_AUTHOR_INFO" \
+		git config rebase.author.mail) &&
+	GIT_AUTHOR_DATE=$(GIT_CONFIG="$SAVE_AUTHOR_INFO" \
+		git config rebase.author.date)
 }
 
 make_patch () {
@@ -158,8 +160,10 @@ make_patch () {
 	esac > "$DOTEST"/patch
 	test -f "$DOTEST"/message ||
 		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
-	test -f "$DOTEST"/author-script ||
-		get_author_ident_from_commit "$1" > "$DOTEST"/author-script
+	test -f "$SAVE_AUTHOR_INFO" || {
+		get_author_ident_from_commit "$1"
+		save_author_ident
+	}
 }
 
 die_with_patch () {
@@ -294,8 +298,10 @@ pick_one_preserving_merges () {
 			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
 
 			# redo merge
-			author_script=$(get_author_ident_from_commit $sha1)
-			eval "$author_script"
+			get_author_ident_from_commit $sha1
+			GIT_AUTHOR_NAME="$author_ident_name"
+			GIT_AUTHOR_EMAIL="$author_ident_mail"
+			GIT_AUTHOR_DATE="$author_ident_date"
 			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
@@ -353,8 +359,7 @@ peek_next_command () {
 }
 
 do_next () {
-	rm -f "$DOTEST"/message "$DOTEST"/author-script \
-		"$DOTEST"/amend || exit
+	rm -f "$DOTEST"/message "$DOTEST"/amend "$SAVE_AUTHOR_INFO" || exit
 	read command sha1 rest < "$TODO"
 	case "$command" in
 	'#'*|''|noop)
@@ -395,7 +400,7 @@ do_next () {
 		mark_action_done
 		make_squash_message $sha1 > "$MSG"
 		failed=f
-		author_script=$(get_author_ident_from_commit HEAD)
+		get_author_ident_from_commit HEAD
 		output git reset --soft HEAD^
 		pick_one -n $sha1 || failed=t
 		case "$(peek_next_command)" in
@@ -414,14 +419,13 @@ do_next () {
 			rm -f "$GIT_DIR"/MERGE_MSG || exit
 			;;
 		esac
-		echo "$author_script" > "$DOTEST"/author-script
+		save_author_ident
 		if test $failed = f
 		then
 			# This is like --amend, but with a different message
-			eval "$author_script"
-			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
-			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
-			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
+			GIT_AUTHOR_NAME="$author_ident_name" \
+			GIT_AUTHOR_EMAIL="$author_ident_mail" \
+			GIT_AUTHOR_DATE="$author_ident_date" \
 			$USE_OUTPUT git commit --no-verify \
 				$MSG_OPT "$EDIT_OR_FILE" || failed=t
 		fi
@@ -536,7 +540,7 @@ do
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
