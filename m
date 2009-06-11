From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv4 3/4] t5520-pull: --rebase with rebased upstream and two branches
Date: Fri, 12 Jun 2009 00:39:20 +0200
Message-ID: <1244759961-4750-4-git-send-email-santi@agolina.net>
References: <1244759961-4750-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 00:39:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEsw4-00070r-AK
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 00:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762983AbZFKWj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 18:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762974AbZFKWjZ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 18:39:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:9150 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761072AbZFKWjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 18:39:21 -0400
Received: by fg-out-1718.google.com with SMTP id d23so34657fga.17
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 15:39:24 -0700 (PDT)
Received: by 10.86.53.8 with SMTP id b8mr2871751fga.32.1244759964127;
        Thu, 11 Jun 2009 15:39:24 -0700 (PDT)
Received: from localhost (p5B0D383D.dip.t-dialin.net [91.13.56.61])
        by mx.google.com with ESMTPS id 3sm860340fge.9.2009.06.11.15.39.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 15:39:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.222.g479ad6
In-Reply-To: <1244759961-4750-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121367>

If you have two branches tracking an upstream that is rebased,
currently you have to do:

git checkout branch1
git pull --rebase remote branch
git checkout branch2
git pull --rebase remote branch

The second rebase works because the first "git pull --rebase" does not
store in the local tracking branch the new value, so the second rebase
detects that it is rebased.

I think one should be able to do the same without the explicit
arguments to "git pull --rebase", but without arguments it stores the
new state of the remote branch so the second "git pull --rebase" does
not work.

Mark this case as test_expect_failure to make people aware of this
behavior.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Changes since v3:
  - Move the "git rebase --abort" to the failing test to not polute the
    next test.

Hi,

I just wanted to make people aware of this behavior and then decide if
this is the correct behavior. Then we can document it, or try to find a=
 better
solution.

Santi

 t/t5520-pull.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c5a2e66..a4ac6d2 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -117,6 +117,23 @@ test_expect_success '--rebase with rebased default=
 upstream' '
=20
 '
=20
+test_expect_failure '--rebase with rebased upstream and two branches' =
'
+
+	git update-ref refs/remotes/me/copy copy-orig &&
+	git reset --hard to-rebase-orig &&
+	git checkout --track -b to-rebase3 me/copy &&
+	git reset --hard to-rebase-orig &&
+	git pull --rebase &&
+	test "conflicting modification" =3D "$(cat file)" &&
+	test file =3D $(cat file2) &&
+	git checkout to-rebase2 &&
+	test_must_fail git pull --rebase &&
+	git rebase --abort &&
+	test "conflicting modification" =3D "$(cat file)" &&
+	test file =3D $(cat file2)
+
+'
+
 test_expect_success 'pull --rebase dies early with dirty working direc=
tory' '
=20
 	git checkout to-rebase &&
--=20
1.6.3.2.206.g417f7
