From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 05/13] Teach rebase interactive the reset command
Date: Mon, 14 Apr 2008 02:21:01 +0200
Message-ID: <1208132469-26471-5-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:53:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCx0-0004J2-Mz
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbYDNAwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbYDNAwU
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:20 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1647 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbYDNAv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:56 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 8D89D4880A5; Mon, 14 Apr 2008 02:51:55 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006IK-VA; Mon, 14 Apr 2008 02:21:10 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006ti-HE; Mon, 14 Apr 2008 02:21:09 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79443>

This command does a hard reset of the HEAD, i.e. the next operation use=
d
this commit as parent. This is necessary to redo the commits of differe=
nt
branches they become merged later.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh    |   10 ++++++++++
 t/t3404-rebase-interactive.sh |   17 +++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6ac316a..a4b7aad 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -351,6 +351,15 @@ do_next () {
=20
 		git update-ref "$mark" HEAD || die "update-ref failed"
 		;;
+	reset|r)
+		comment_for_reflog reset
+
+		tmp=3D$(git rev-parse --verify "$(mark_to_ref $sha1)") ||
+			die "Invalid parent '$sha1' in $command $sha1 $rest"
+
+		mark_action_done
+		output git reset --hard $tmp
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
@@ -572,6 +581,7 @@ do
 #  edit =3D use commit, but stop for amending
 #  squash =3D use commit, but meld into previous commit
 #  mark :mark =3D mark the current HEAD for later reference
+#  reset commit =3D reset HEAD to the commit
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index fa3560e..78673a6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -85,6 +85,9 @@ for line in $FAKE_LINES; do
 	mark*)
 		echo "mark ${line#mark}"
 		echo "mark ${line#mark}" >> "$1";;
+	reset*)
+		echo "reset ${line#reset}"
+		echo "reset ${line#reset}" >> "$1";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
 		sed -n "${line}p" < "$1".tmp
@@ -206,6 +209,20 @@ test_expect_success 'setting marks works' '
 	ls $marks_dir | wc -l | grep -Fx 0
 '
=20
+test_expect_success 'reset with nonexistent mark fails' '
+	export FAKE_LINES=3D"reset:0 1" &&
+	test_must_fail git rebase -i HEAD~1 &&
+	unset FAKE_LINES &&
+	git rebase --abort
+'
+
+test_expect_success 'reset to HEAD is a nop' '
+	test_tick &&
+	head=3D$(git rev-parse --short HEAD) &&
+	FAKE_LINES=3D"reset$head" git rebase -i HEAD~4 &&
+	test "$(git rev-parse --short HEAD)" =3D "$head"
+'
+
 test_expect_success 'preserve merges with -p' '
 	git checkout -b to-be-preserved master^ &&
 	: > unrelated-file &&
--=20
1.5.5
