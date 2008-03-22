From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 4/5] Handle fast forward correctly in rebase with preserve merges
Date: Sat, 22 Mar 2008 15:08:26 +0100
Message-ID: <1206194907-3340-4-git-send-email-joerg@alea.gnuu.de>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
 <1206194907-3340-1-git-send-email-joerg@alea.gnuu.de>
 <1206194907-3340-2-git-send-email-joerg@alea.gnuu.de>
 <1206194907-3340-3-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 15:11:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd4RG-00053I-Vp
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 15:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbYCVOKG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 10:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbYCVOKA
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 10:10:00 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1553 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754347AbYCVOJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 10:09:47 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 2895D488035; Sat, 22 Mar 2008 15:09:45 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4OZ-0002Lx-5A; Sat, 22 Mar 2008 15:08:27 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4Oa-0000sU-DK; Sat, 22 Mar 2008 15:08:28 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206194907-3340-3-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77812>

Rebase-interactive with preserve merges does fast forward commits while
the parent of the old commit is not the parent of the new commit. If th=
e
parent of the changed commit is not touched, e.g. has no entry in the
REWRITTEN database, a fast forward happens. With these commits
=E2=80=9CA---B---C=E2=80=9D and rebase =E2=80=9CA---C---B=E2=80=9D woul=
d do a fast forward for C which
leads to an incorrect result.

The fast forward is also not realised, i.e. the HEAD is not updated.

After all is done, it was assumed that the new head is the rewritten ol=
d
head. But if the old head was applied before current head=E2=80=94as in=
 the
example above=E2=80=94the commits after the rewritten old head are lost=
=2E

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e1ce44e..8626ef6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -144,6 +144,7 @@ pick_one_preserving_merges () {
 		die "Cannot write current commit's replacement sha1"
 	fi
=20
+	current_sha1=3D$(git rev-parse --verify HEAD)
 	# rewrite parents; if none were rewritten, we can fast-forward.
 	fast_forward=3Dt
 	preserve=3Dt
@@ -166,18 +167,31 @@ pick_one_preserving_merges () {
 			new_parents=3D"$new_parents $p"
 		fi
 	done
+
+	# Don't do a fast forward, if current commit is not the parent of
+	# the new commit
+	case "$new_parents" in
+	""|" $current_sha1"*)
+		;;
+	*)
+		fast_forward=3Df
+		;;
+	esac
+
 	case $fast_forward in
 	t)
 		output warn "Fast forward to $sha1"
 		test $preserve =3D f || echo $sha1 > "$REWRITTEN"/$sha1
+		output git reset --hard $sha1
+		if test "a$1" =3D a-n
+		then
+			output git reset --soft $current_sha1
+		fi
 		;;
 	f)
 		test "a$1" =3D a-n && die "Refusing to squash a merge: $sha1"
=20
 		first_parent=3D$(expr "$new_parents" : ' \([^ ]*\)')
-		# detach HEAD to current parent
-		output git checkout $first_parent 2> /dev/null ||
-			die "Cannot move HEAD to $first_parent"
=20
 		echo $sha1 > "$DOTEST"/current-commit
 		case "$new_parents" in
@@ -330,20 +344,7 @@ do_next () {
 	HEADNAME=3D$(cat "$DOTEST"/head-name) &&
 	OLDHEAD=3D$(cat "$DOTEST"/head) &&
 	SHORTONTO=3D$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
-	if test -d "$REWRITTEN"
-	then
-		test -f "$DOTEST"/current-commit &&
-			current_commit=3D$(cat "$DOTEST"/current-commit) &&
-			git rev-parse HEAD > "$REWRITTEN"/$current_commit
-		if test -f "$REWRITTEN"/$OLDHEAD
-		then
-			NEWHEAD=3D$(cat "$REWRITTEN"/$OLDHEAD)
-		else
-			NEWHEAD=3D$OLDHEAD
-		fi
-	else
-		NEWHEAD=3D$(git rev-parse HEAD)
-	fi &&
+	NEWHEAD=3D$(git rev-parse HEAD) &&
 	case $HEADNAME in
 	refs/*)
 		message=3D"$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
--=20
1.5.4.4
