From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 12/13] Teach rebase interactive the tag command
Date: Mon, 14 Apr 2008 02:21:08 +0200
Message-ID: <1208132469-26471-12-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-5-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-6-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-7-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-8-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-9-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-10-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-11-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:53:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCwx-0004J2-En
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbYDNAwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753988AbYDNAwI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:08 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1641 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753660AbYDNAv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:56 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id EFBBD4880A3; Mon, 14 Apr 2008 02:51:54 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRb-0006II-4A; Mon, 14 Apr 2008 02:21:11 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRa-0006uX-Jr; Mon, 14 Apr 2008 02:21:10 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-11-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79440>

The intent of the tag command is to (re)set tags for commits in the TOD=
O
list. This way it's possible to rebase a commit together with its tag.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh    |    7 +++++++
 t/t3404-rebase-interactive.sh |   13 +++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ea67942..c601655 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -323,6 +323,12 @@ do_next () {
 		mark_action_done
 		output git reset --hard $tmp
 		;;
+	tag|t)
+		comment_for_reflog tag
+
+		mark_action_done
+		output git tag -f "$sha1"
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
@@ -655,6 +661,7 @@ do
 #  reset commit =3D reset HEAD to the commit
 #  merge commit-M commit-P ... =3D redo merge commit-M with the
 #         current HEAD and the parents commit-P
+#  tag =3D reset tag to the current HEAD
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 8da7829..9901555 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -91,6 +91,9 @@ for line in $FAKE_LINES; do
 	merge*)
 		echo "merge ${line#merge}" | tr / ' '
 		echo "merge ${line#merge}" | tr / ' ' >> "$1";;
+	tag*)
+		echo "tag ${line#tag}"
+		echo "tag ${line#tag}" >> "$1";;
 	*)
 		sed -n "${line}{s/^pick/$action/; p;}" < "$1".tmp
 		sed -n "${line}{s/^pick/$action/; p;}" < "$1".tmp >> "$1"
@@ -306,6 +309,16 @@ test_expect_success 'interactive --first-parent gi=
ves a linear list' '
 	test "$head" =3D "$(git rev-parse HEAD)"
 '
=20
+test_expect_success 'tag sets tags' '
+	head=3D$(git rev-parse HEAD) &&
+	FAKE_LINES=3D"1 2 3 4 5 tagbb-tag1 6 7 8 9 10 11 12 13 14 15 \
+		tagbb-tag2 16 tagbb-tag3a tagbb-tag3b 17 18 19 20 21 22" \
+		EXPECT_COUNT=3D22 git rebase -i -p master &&
+	test "$head" =3D "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse bb-tag1 bb-tag2 bb-tag3a bb-tag3b)" =3D \
+		"$(git rev-parse HEAD^2~2 HEAD~2 HEAD~1 HEAD~1)"
+'
+
 test_expect_success '--continue tries to commit' '
 	git checkout to-be-rebased &&
 	test_tick &&
--=20
1.5.5
