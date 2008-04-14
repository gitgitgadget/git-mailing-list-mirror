From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 06/13] Move redo merge code in a function
Date: Mon, 14 Apr 2008 02:21:02 +0200
Message-ID: <1208132469-26471-6-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-5-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:53:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCwz-0004J2-CT
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbYDNAwR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbYDNAwQ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:16 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1655 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814AbYDNAv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:58 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 345D14880A8; Mon, 14 Apr 2008 02:51:56 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRa-0006IG-0f; Mon, 14 Apr 2008 02:21:10 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006tp-Ku; Mon, 14 Apr 2008 02:21:09 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-5-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79444>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a4b7aad..19145b1 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -125,6 +125,25 @@ has_action () {
 	grep '^[^#]' "$1" >/dev/null
 }
=20
+redo_merge () {
+	rm_sha1=3D$1
+	shift
+
+	eval "$(get_author_ident_from_commit $rm_sha1)"
+	msg=3D"$(git cat-file commit $rm_sha1 | sed -e '1,/^$/d')"
+
+	if ! GIT_AUTHOR_NAME=3D"$GIT_AUTHOR_NAME" \
+		GIT_AUTHOR_EMAIL=3D"$GIT_AUTHOR_EMAIL" \
+		GIT_AUTHOR_DATE=3D"$GIT_AUTHOR_DATE" \
+		output git merge $STRATEGY -m "$msg" "$@"
+	then
+		git rerere
+		printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
+		die Error redoing merge $rm_sha1
+	fi
+	unset rm_sha1
+}
+
 pick_one () {
 	no_ff=3D
 	case "$1" in -n) sha1=3D$2; no_ff=3Dt ;; *) sha1=3D$1 ;; esac
@@ -192,22 +211,8 @@ pick_one_preserving_merges () {
 		echo $sha1 > "$DOTEST"/current-commit
 		case "$new_parents" in
 		' '*' '*)
-			# redo merge
-			author_script=3D$(get_author_ident_from_commit $sha1)
-			eval "$author_script"
-			msg=3D"$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
 			# No point in merging the first parent, that's HEAD
-			new_parents=3D${new_parents# $first_parent}
-			if ! GIT_AUTHOR_NAME=3D"$GIT_AUTHOR_NAME" \
-				GIT_AUTHOR_EMAIL=3D"$GIT_AUTHOR_EMAIL" \
-				GIT_AUTHOR_DATE=3D"$GIT_AUTHOR_DATE" \
-				output git merge $STRATEGY -m "$msg" \
-					$new_parents
-			then
-				git rerere
-				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
-				die Error redoing merge $sha1
-			fi
+			redo_merge $sha1 ${new_parents# $first_parent}
 			;;
 		*)
 			output git cherry-pick "$@" ||
--=20
1.5.5
