From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH/RFC 05/10] Rework redo_merge
Date: Thu, 10 Apr 2008 01:58:36 +0200
Message-ID: <1207785521-27742-6-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-4-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-5-git-send-email-joerg@alea.gnuu.de>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 02:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkH0-0004V7-JG
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828AbYDJADR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbYDJADP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:03:15 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3464 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640AbYDJADG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:03:06 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 21112488062; Thu, 10 Apr 2008 02:03:02 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBf-0004mH-4h; Thu, 10 Apr 2008 01:58:43 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBe-0007ER-7N; Thu, 10 Apr 2008 01:58:42 +0200
X-Mailer: git-send-email 1.5.4.5
In-Reply-To: <1207785521-27742-5-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79154>

---
 git-rebase--interactive.sh |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 973770e..1698c3e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -115,14 +115,17 @@ has_action () {
 }
 
 redo_merge() {
-	author_script=$(get_author_ident_from_commit $sha1)
-	eval "$author_script"
+	local sha1
+	sha1=$1
+	shift
+
+	eval "$(get_author_ident_from_commit $sha1)"
 	msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
+
 	if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 		GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
 		GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-		output git merge $STRATEGY -m "$msg" \
-			$new_parents
+		output git merge $STRATEGY -m "$msg" "$@"
 	then
 		git rerere
 		printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
@@ -198,8 +201,7 @@ pick_one_preserving_merges () {
 		case "$new_parents" in
 		' '*' '*)
 			# No point in merging the first parent, that's HEAD
-			new_parents=${new_parents# $first_parent}
-			redo_merge
+			redo_merge $sha1 ${new_parents# $first_parent}
 			;;
 		*)
 			output git cherry-pick "$@" ||
-- 
1.5.4.5
