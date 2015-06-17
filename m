From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] t3404: demonstrate =?UTF-8?Q?CHERRY=5FPICK=5FHEAD=20b?=
 =?UTF-8?Q?ug?=
Date: Wed, 17 Jun 2015 10:16:08 +0200
Organization: gmx
Message-ID: <f76ca5d0b6687a4d2ee4f587d8ba75a643a33c04.1434528725.git.johannes.schindelin@gmx.de>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
 <cover.1434528725.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 17 10:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z58WD-0004VO-N5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 10:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933AbbFQIQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 04:16:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:50164 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757931AbbFQIQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 04:16:14 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LqQnR-1YaDcG0hOL-00e8b5; Wed, 17 Jun 2015 10:16:09
 +0200
In-Reply-To: <cover.1434528725.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:k/BbOtVSc1V8vMMQ5c66tWusRipbi+1dJg+k3oEgAbW5wJmFYtW
 DuYCuEVV4EqQmyuncCG7VePvzwHJoHw/fRAqmptMVI1TAyCwH4h5R0N+o3XFUD1SudUpG5r
 2Cwgmh71KZDSzE7P6UFT/5tlA8JxG+doOjPfhj8YnBUUKWFp7Do/K1JFho+eUH6lEQIiRLj
 cfaYRER0MWNERVzRKD8Lw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271815>

When rev-list's --cherry option does not detect that a patch has alread=
y
been applied upstream, an interactive rebase would offer to reapply it =
and
consequently stop at that patch with a failure, mentioning that the dif=
f
is empty.

Traditionally, a `git rebase --continue` simply skips the commit in suc=
h a
situation.

However, as pointed out by G=C3=A1bor Szeder, this leaves a CHERRY_PICK=
_HEAD
behind, making the Git prompt believe that a cherry pick is still going
on. This commit adds a test case demonstrating this bug.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index ac429a0..5d52775 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1102,4 +1102,24 @@ test_expect_success 'rebase -i commits that over=
write untracked files (no ff)' '
 	test $(git cat-file commit HEAD | sed -ne \$p) =3D I
 '
=20
+test_expect_failure 'rebase --continue removes CHERRY_PICK_HEAD' '
+	git checkout -b commit-to-skip &&
+	for double in X 3 1
+	do
+		seq 5 | sed "s/$double/&&/" >seq &&
+		git add seq &&
+		test_tick &&
+		git commit -m seq-$double
+	done &&
+	git tag seq-onto &&
+	git reset --hard HEAD~2 &&
+	git cherry-pick seq-onto &&
+	test_must_fail git rebase -i seq-onto &&
+	test -d .git/rebase-merge &&
+	git rebase --continue &&
+	git diff seq-onto &&
+	test ! -d .git/rebase-merge &&
+	test ! -f .git/CHERRY_PICK_HEAD
+'
+
 test_done
--=20
2.3.1.windows.1.9.g8c01ab4
