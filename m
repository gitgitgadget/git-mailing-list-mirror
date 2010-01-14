From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/18] rebase -i: Change function make_squash_message into update_squash_message
Date: Thu, 14 Jan 2010 06:54:54 +0100
Message-ID: <784d63d686a82b93a29531d3079aadbe83258d9f.1263447038.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIge-0002Vo-Ex
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab0ANFzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689Ab0ANFze
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:34 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58640 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab0ANFzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:31 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bU001912;
	Thu, 14 Jan 2010 06:55:27 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136942>

Alter the file $SQUASH_MSG in place rather than outputting the new
message then juggling it around.  Change the function name
accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2902644..5a48fbf 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -360,21 +360,26 @@ nth_string () {
 	esac
 }
 
-make_squash_message () {
+update_squash_message () {
 	if test -f "$SQUASH_MSG"; then
+		mv "$SQUASH_MSG" "$SQUASH_MSG".bak || exit
 		COUNT=$(($(sed -n \
 			-e "1s/^# This is a combination of \(.*\) commits\./\1/p" \
-			-e "q" < "$SQUASH_MSG")+1))
-		echo "# This is a combination of $COUNT commits."
-		sed -e 1d -e '2,/^./{
-			/^$/d
-		}' <"$SQUASH_MSG"
+			-e "q" < "$SQUASH_MSG".bak)+1))
+		{
+			echo "# This is a combination of $COUNT commits."
+			sed -e 1d -e '2,/^./{
+				/^$/d
+			}' <"$SQUASH_MSG".bak
+		} >$SQUASH_MSG
 	else
 		COUNT=2
-		echo "# This is a combination of 2 commits."
-		echo "# The first commit's message is:"
-		echo
-		commit_message HEAD
+		{
+			echo "# This is a combination of 2 commits."
+			echo "# The first commit's message is:"
+			echo
+			commit_message HEAD
+		} >$SQUASH_MSG
 	fi
 	case $1 in
 	squash)
@@ -389,7 +394,7 @@ make_squash_message () {
 		echo
 		commit_message $2 | sed -e 's/^/#	/'
 		;;
-	esac
+	esac >>$SQUASH_MSG
 }
 
 peek_next_command () {
@@ -452,7 +457,7 @@ do_next () {
 			die "Cannot '$squash_style' without a previous commit"
 
 		mark_action_done
-		make_squash_message $squash_style $sha1 > "$MSG"
+		update_squash_message $squash_style $sha1
 		failed=f
 		author_script=$(get_author_ident_from_commit HEAD)
 		echo "$author_script" > "$AUTHOR_SCRIPT"
@@ -462,16 +467,16 @@ do_next () {
 		case "$(peek_next_command)" in
 		squash|s|fixup|f)
 			USE_OUTPUT=output
+			cp "$SQUASH_MSG" "$MSG" || exit
 			MSG_OPT=-F
 			EDIT_OR_FILE="$MSG"
-			cp "$MSG" "$SQUASH_MSG"
 			;;
 		*)
 			USE_OUTPUT=
 			MSG_OPT=
 			EDIT_OR_FILE=-e
-			rm -f "$SQUASH_MSG" || exit
-			cp "$MSG" "$GIT_DIR"/SQUASH_MSG
+			cp "$SQUASH_MSG" "$MSG" || exit
+			mv "$SQUASH_MSG" "$GIT_DIR"/SQUASH_MSG || exit
 			rm -f "$GIT_DIR"/MERGE_MSG || exit
 			;;
 		esac
-- 
1.6.6
