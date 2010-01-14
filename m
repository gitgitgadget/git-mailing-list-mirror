From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/18] rebase -i: Extract a function "commit_message"
Date: Thu, 14 Jan 2010 06:54:51 +0100
Message-ID: <846f72bfe9246c2ac1f776fa18bd7f75fa77292d.1263447038.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgg-0002Vo-MK
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763Ab0ANFzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404Ab0ANFzv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:51 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58627 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab0ANFz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:29 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bR001912;
	Thu, 14 Jan 2010 06:55:25 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136944>

...instead of repeating the same short but slightly obscure blob of
code in several places.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5ed80b0..04a1c3a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -120,6 +120,11 @@ output () {
 	esac
 }
 
+# Output the commit message for the specified commit.
+commit_message () {
+	git cat-file commit "$1" | sed "1,/^$/d"
+}
+
 run_pre_rebase_hook () {
 	if test -z "$OK_TO_SKIP_PRE_REBASE" &&
 	   test -x "$GIT_DIR/hooks/pre-rebase"
@@ -180,7 +185,7 @@ make_patch () {
 		;;
 	esac > "$DOTEST"/patch
 	test -f "$MSG" ||
-		git cat-file commit "$1" | sed "1,/^$/d" > "$MSG"
+		commit_message "$1" > "$MSG"
 	test -f "$AUTHOR_SCRIPT" ||
 		get_author_ident_from_commit "$1" > "$AUTHOR_SCRIPT"
 }
@@ -318,7 +323,7 @@ pick_one_preserving_merges () {
 			# redo merge
 			author_script=$(get_author_ident_from_commit $sha1)
 			eval "$author_script"
-			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
+			msg="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
@@ -363,20 +368,20 @@ make_squash_message () {
 		echo "# This is a combination of 2 commits."
 		echo "# The first commit's message is:"
 		echo
-		git cat-file commit HEAD | sed -e '1,/^$/d'
+		commit_message HEAD
 	fi
 	case $1 in
 	squash)
 		echo
 		echo "# This is the $(nth_string $COUNT) commit message:"
 		echo
-		git cat-file commit $2 | sed -e '1,/^$/d'
+		commit_message $2
 		;;
 	fixup)
 		echo
 		echo "# The $(nth_string $COUNT) commit message will be skipped:"
 		echo
-		git cat-file commit $2 | sed -e '1,/^$/d' -e 's/^/#	/'
+		commit_message $2 | sed -e 's/^/#	/'
 		;;
 	esac
 }
-- 
1.6.6
