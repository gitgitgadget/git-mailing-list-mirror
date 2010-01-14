From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/18] rebase -i: Extract function do_with_author
Date: Thu, 14 Jan 2010 06:54:53 +0100
Message-ID: <fce97bc894f622fdc0ff26afab0986200ab42f5a.1263447038.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgh-0002Vo-9S
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab0ANFzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757Ab0ANFzt
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:49 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58635 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab0ANFza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:30 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bT001912;
	Thu, 14 Jan 2010 06:55:26 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136946>

Call it instead of repeating similar code blocks in several places.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 15b8605..2902644 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -205,6 +205,15 @@ has_action () {
 	sane_grep '^[^#]' "$1" >/dev/null
 }
 
+# Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
+# GIT_AUTHOR_DATE exported from the current environment.
+do_with_author () {
+	GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
+	GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
+	GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
+	"$@"
+}
+
 pick_one () {
 	no_ff=
 	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
@@ -326,11 +335,8 @@ pick_one_preserving_merges () {
 			msg="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
-			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
-				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
-				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-				output git merge $STRATEGY -m "$msg" \
-					$new_parents
+			if ! do_with_author output \
+				git merge $STRATEGY -m "$msg" $new_parents
 			then
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
@@ -472,11 +478,9 @@ do_next () {
 		if test $failed = f
 		then
 			# This is like --amend, but with a different message
-			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
-			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
-			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-			$USE_OUTPUT git commit --no-verify \
-				$MSG_OPT "$EDIT_OR_FILE" || failed=t
+			do_with_author $USE_OUTPUT git commit --no-verify \
+				$MSG_OPT "$EDIT_OR_FILE" ||
+				failed=t
 		fi
 		if test $failed = t
 		then
@@ -657,8 +661,7 @@ first and then run 'git rebase --continue' again."
 				git reset --soft HEAD^ ||
 				die "Cannot rewind the HEAD"
 			fi
-			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-			git commit --no-verify -F "$MSG" -e || {
+			do_with_author git commit --no-verify -F "$MSG" -e || {
 				test -n "$amend" && git reset --soft $amend
 				die "Could not commit staged changes."
 			}
-- 
1.6.6
