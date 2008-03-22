From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 2/5] New test: no merges without preserve merges
Date: Sat, 22 Mar 2008 15:08:24 +0100
Message-ID: <1206194907-3340-2-git-send-email-joerg@alea.gnuu.de>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
 <1206194907-3340-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 15:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd4Qk-0004oD-Pd
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 15:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbYCVOKB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 10:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754447AbYCVOJu
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 10:09:50 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1552 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbYCVOJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 10:09:47 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id E1A6B488034; Sat, 22 Mar 2008 15:09:45 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4OY-0002Lp-CB; Sat, 22 Mar 2008 15:08:26 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4OZ-0000sG-Ir; Sat, 22 Mar 2008 15:08:27 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206194907-3340-1-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77809>

This test checks that no merges are included, if --preserve-merges is n=
ot
given.

To see a difference between with and without merges add a second commit
to the branch to-be-preserved. Otherwise you exchange one merge with on=
e
commit, which isn't cognizable with EXPECT_COUNT.

The for loop in the test looks somewhat strange, but I didn't saw a
different way (than || exit 1) to make the test fail if an inner test
fails. Recall: The exit code of a for loop is the exit code of the last
command in the last pass, i.e. =E2=80=9Cfor a in 1 2; do test $a !=3D 1=
; do=E2=80=9D
returns success.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 t/t3404-rebase-interactive.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

This patch must be applied after the first patch that fixes rebase,
because it triggers a bug.

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 9cf873f..8de1f21 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -195,6 +195,9 @@ test_expect_success 'preserve merges with -p' '
 	git add unrelated-file &&
 	test_tick &&
 	git commit -m "unrelated" &&
+	echo 2 > unrelated-file &&
+	test_tick &&
+	git commit -m "second unrelated commit" unrelated-file &&
 	git checkout -b to-be-rebased master &&
 	echo B > file1 &&
 	test_tick &&
@@ -212,6 +215,18 @@ test_expect_success 'preserve merges with -p' '
 	test $(git show HEAD~2:file1) =3D B
 '
=20
+test_expect_success 'no merges without preserve merges' '
+	head=3D$(git rev-parse HEAD) &&
+	test_tick &&
+	EXPECT_COUNT=3D4 git rebase -i branch1 &&
+	test $(git rev-parse HEAD) !=3D $head &&
+        for i in 0 1 2 3
+	do
+		test $? -eq 0 &&
+		test "$(git rev-list --parents -1 HEAD~$i | tr -dc " ")" =3D " "
+	done
+'
+
 test_expect_success '--continue tries to commit' '
 	test_tick &&
 	! git rebase -i --onto new-branch1 HEAD^ &&
--=20
1.5.4.4
