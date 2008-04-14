From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 07/13] Teach rebase interactive the merge command
Date: Mon, 14 Apr 2008 02:21:03 +0200
Message-ID: <1208132469-26471-7-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-5-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-6-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:53:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCx0-0004J2-2L
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbYDNAwV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbYDNAwT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:19 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1649 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500AbYDNAv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:57 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id B305E4880A6; Mon, 14 Apr 2008 02:51:55 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRc-0006IG-8D; Mon, 14 Apr 2008 02:21:12 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006tv-Qu; Mon, 14 Apr 2008 02:21:09 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-6-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79439>

This command redoes merges. It's useful if you rebase a branch that
contains merges and you want to preserve these merges. You can also use
it to add new merges.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh    |   24 ++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |   13 +++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 19145b1..fd41ca0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -356,6 +356,28 @@ do_next () {
=20
 		git update-ref "$mark" HEAD || die "update-ref failed"
 		;;
+	merge|m)
+		comment_for_reflog merge
+
+		if ! git rev-parse --verify $sha1 > /dev/null
+		then
+			die "Invalid reference merge '$sha1' in"
+					"$command $sha1 $rest"
+		fi
+
+		new_parents=3D
+		for p in $rest
+		do
+			new_parents=3D"$new_parents $(mark_to_ref $p)"
+		done
+		new_parents=3D"${new_parents# }"
+		test -n "$new_parents" || \
+			die "You forgot to give the parents for the" \
+				"merge $sha1. Please fix it in $TODO"
+
+		mark_action_done
+		redo_merge $sha1 $new_parents
+		;;
 	reset|r)
 		comment_for_reflog reset
=20
@@ -587,6 +609,8 @@ do
 #  squash =3D use commit, but meld into previous commit
 #  mark :mark =3D mark the current HEAD for later reference
 #  reset commit =3D reset HEAD to the commit
+#  merge commit-M commit-P ... =3D redo merge commit-M with the
+#         current HEAD and the parents commit-P
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 78673a6..ceb9d74 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -88,6 +88,9 @@ for line in $FAKE_LINES; do
 	reset*)
 		echo "reset ${line#reset}"
 		echo "reset ${line#reset}" >> "$1";;
+	merge*)
+		echo "merge ${line#merge}" | tr / ' '
+		echo "merge ${line#merge}" | tr / ' ' >> "$1";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
 		sed -n "${line}p" < "$1".tmp
@@ -223,6 +226,16 @@ test_expect_success 'reset to HEAD is a nop' '
 	test "$(git rev-parse --short HEAD)" =3D "$head"
 '
=20
+test_expect_success 'merge redoes merges' '
+	test_tick &&
+	git merge dead-end &&
+	merge=3D$(git rev-parse HEAD) &&
+	git reset --hard HEAD~1 &&
+	FAKE_LINES=3D"1 merge$merge/dead-end" git rebase -i HEAD~1 &&
+	test $merge =3D "$(git rev-parse HEAD)" &&
+	git reset --hard HEAD~1
+'
+
 test_expect_success 'preserve merges with -p' '
 	git checkout -b to-be-preserved master^ &&
 	: > unrelated-file &&
--=20
1.5.5
