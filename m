From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] New test for rebase with preserve merges and squash
Date: Thu, 20 Mar 2008 14:01:10 +0100
Message-ID: <1206018070-3402-1-git-send-email-joerg@alea.gnuu.de>
References: <alpine.LSU.1.00.0803201208080.3983@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 14:02:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcKPy-00043F-6K
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 14:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbYCTNCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2008 09:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbYCTNCJ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 09:02:09 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1668 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754688AbYCTNCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 09:02:08 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id C2950488062; Thu, 20 Mar 2008 14:02:06 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JcKNX-0001rs-VS; Thu, 20 Mar 2008 14:00:20 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JcKOM-0000tC-TT; Thu, 20 Mar 2008 14:01:11 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <alpine.LSU.1.00.0803201208080.3983@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77655>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 t/t3404-rebase-interactive.sh |   52 +++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

> > >=20
> > > Please mark such tests with test_expect_fail.
> >=20
> > No, I expect the test succeeds. Currently, it fails. This might be,=
=20
> > because my expectations are wrong or there's a bug.
>=20
> The definition of "test_expect_fail" is: this should succeed, but nee=
ds=20
> fixin'.

Ahh, I didn't know this. Here's a new one:

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 62e65d7..c849415 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -362,4 +362,56 @@ test_expect_success 'rebase with a file named HEAD=
 in worktree' '
=20
 '
=20
+test_expect_success 'squash and preserve merges' '
+	test_tick &&
+	git checkout -b squash-and-preserve-merges master &&
+	echo A > file1 &&
+	git commit -m SaPM-1 file1 &&
+	echo B > file1 &&
+	git commit -m SaPM-2 file1 &&
+	git merge to-be-preserved &&
+	echo C > file1 &&
+	git commit -m SaPM-3 file1
+'
+
+# This test should fail, because the prompt includes the commit from t=
he
+# merge not only the merge:
+# -> pick 9604163 unrelated
+#    pick 5ef0364 SaPM-1
+#    pick 22aadcf SaPM-2
+#    pick 828f7d8 Merge branch 'to-be-preserved' into squash-and-prese=
rve-merges
+#    pick 2a15a54 SaPM-3
+test_expect_failure 'expect preserve merges shown not commits from mer=
ge' '
+        EXPECT_COUNT=3D4 FAKE_LINES=3D"1 2 squash 4 3" \
+          git rebase -i -p --onto branch1 master ||
+        { git rebase --abort;
+          EXPECT_COUNT=3D5 FAKE_LINES=3D"1 2 3 squash 5 4" \
+          git rebase -i -p --onto branch1 master;
+          false; }
+'
+
+# The rebase changes nothing: SaPM-3 is still the last commit while it
+# should have been merged with SaMP-2 and the branch is not rebased on
+# branch1
+#
+# % git forest squash-and-preserve-merges
+# =E2=95=93=E2=94=80[squash-and-preserve-merges]=E2=94=80=E2=94=80SaPM=
-3
+# =E2=95=9F Merge branch 'to-be-preserved' into squash-and-preserve-me=
rges
+# =E2=95=A0=E2=95=90=E2=95=97=20
+# =E2=95=9F =E2=95=91 SaPM-2
+# =E2=95=9F =E2=95=91 SaPM-1
+# =E2=95=91 =E2=95=9F=E2=94=80[to-be-preserved]=E2=94=80=E2=94=80unrel=
ated
+# =E2=95=9F=E2=94=80=E2=95=91=E2=94=80[master]=E2=94=80=E2=94=80E
+# =E2=95=A0=E2=95=90=E2=95=9D=20
+# =E2=95=9F D
+# =E2=95=9F C
+# =E2=95=9F B
+# =E2=95=99=E2=94=80[A]=E2=94=80=E2=94=80A
+test_expect_failure 'squash and preserve merges' '
+	test $(git rev-parse HEAD^2) =3D $(git rev-parse to-be-preserved) &&
+	test $(git rev-parse HEAD~3) =3D $(git rev-parse branch1) &&
+	test $(git show HEAD:file1) =3D C &&
+	test $(git show HEAD~2:file1) =3D A
+'
+
 test_done
--=20
1.5.4.4
