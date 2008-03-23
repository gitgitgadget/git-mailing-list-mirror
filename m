From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH 2/4] Rework redo_merge
Date: Sun, 23 Mar 2008 22:42:40 +0100
Message-ID: <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, B.Steinbrink@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 22:47:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdY2U-0007dT-QB
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 22:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbYCWVqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 17:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755312AbYCWVqt
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 17:46:49 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4013 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662AbYCWVqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 17:46:47 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 0AECB488030; Sun, 23 Mar 2008 22:46:45 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdXxk-0004pC-1q; Sun, 23 Mar 2008 22:42:48 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdXxi-0008CH-B0; Sun, 23 Mar 2008 22:42:42 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77963>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1b2381e..ffd4823 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -114,14 +114,16 @@ has_action () {
 }
=20
 redo_merge() {
-	author_script=3D$(get_author_ident_from_commit $sha1)
-	eval "$author_script"
+	sha1=3D$1
+	shift
+
+	eval "$(get_author_ident_from_commit $sha1)"
 	msg=3D"$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
+
 	if ! GIT_AUTHOR_NAME=3D"$GIT_AUTHOR_NAME" \
 		GIT_AUTHOR_EMAIL=3D"$GIT_AUTHOR_EMAIL" \
 		GIT_AUTHOR_DATE=3D"$GIT_AUTHOR_DATE" \
-		output git merge $STRATEGY -m "$msg" \
-			$new_parents
+		output git merge $STRATEGY -m "$msg" "$@"
 	then
 		git rerere
 		printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
@@ -197,8 +199,7 @@ pick_one_preserving_merges () {
 		case "$new_parents" in
 		' '*' '*)
 			# No point in merging the first parent, that's HEAD
-			new_parents=3D${new_parents# $first_parent}
-			redo_merge
+			redo_merge $sha1 ${new_parents# $first_parent}
 			;;
 		*)
 			output git cherry-pick "$@" ||
--=20
1.5.4.4
