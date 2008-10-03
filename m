From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] rebase -i: proper prepare-commit-msg hook argument when
	squashing
Date: Fri,  3 Oct 2008 02:08:21 +0200
Message-ID: <1222992501-943-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 02:09:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlYEt-0000NP-T8
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 02:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbYJCAIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2008 20:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbYJCAIh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 20:08:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:55121 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYJCAIg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 20:08:36 -0400
Received: from [127.0.1.1] (p5B1335A8.dip0.t-ipconnect.de [91.19.53.168])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1KlYDU3TSv-0001qb; Fri, 03 Oct 2008 02:08:21 +0200
X-Mailer: git-send-email 1.6.0.2.430.gfc53
X-Provags-ID: V01U2FsdGVkX193DL4ZzYdWgSf52GfVExKVTa6CDAi8v/fzXLD
 DC495f0XCbL2HYVQrH8huTspDVIlnq8ZZL4mB2dDEBueVgXMUK
 D13KMkfBoRBgAm3bgQzAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97382>

One would expect that the prepare-commit-msg hook gets 'squash' as the
second argument when squashing commits with 'rebase -i'.  However,
that was not the case, as it got 'merge' instead.  This patch fixes
the problem.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 git-rebase--interactive.sh |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index edb6ec6..ec4299a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -304,23 +304,28 @@ do_next () {
=20
 		mark_action_done
 		make_squash_message $sha1 > "$MSG"
+		failed=3Df
+		author_script=3D$(get_author_ident_from_commit HEAD)
+		output git reset --soft HEAD^
+		pick_one -n $sha1 || failed=3Dt
 		case "$(peek_next_command)" in
 		squash|s)
 			EDIT_COMMIT=3D
 			USE_OUTPUT=3Doutput
+			MSG_OPT=3D-F
+			MSG_FILE=3D"$MSG"
 			cp "$MSG" "$SQUASH_MSG"
 			;;
 		*)
 			EDIT_COMMIT=3D-e
 			USE_OUTPUT=3D
+			MSG_OPT=3D
+			MSG_FILE=3D
 			rm -f "$SQUASH_MSG" || exit
+			cp -v "$MSG" "$GIT_DIR"/SQUASH_MSG
+			rm -f "$GIT_DIR"/MERGE_MSG || exit
 			;;
 		esac
-
-		failed=3Df
-		author_script=3D$(get_author_ident_from_commit HEAD)
-		output git reset --soft HEAD^
-		pick_one -n $sha1 || failed=3Dt
 		echo "$author_script" > "$DOTEST"/author-script
 		if test $failed =3D f
 		then
@@ -329,7 +334,7 @@ do_next () {
 			GIT_AUTHOR_NAME=3D"$GIT_AUTHOR_NAME" \
 			GIT_AUTHOR_EMAIL=3D"$GIT_AUTHOR_EMAIL" \
 			GIT_AUTHOR_DATE=3D"$GIT_AUTHOR_DATE" \
-			$USE_OUTPUT git commit --no-verify -F "$MSG" $EDIT_COMMIT || failed=
=3Dt
+			$USE_OUTPUT git commit --no-verify $MSG_OPT "$MSG_FILE" $EDIT_COMMI=
T || failed=3Dt
 		fi
 		if test $failed =3D t
 		then
--=20
1.6.0.2.430.gfc53
