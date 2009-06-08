From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv3 3/4] t5520-pull: --rebase with rebased upstream and two branches
Date: Mon,  8 Jun 2009 11:00:50 +0200
Message-ID: <1244451651-22651-4-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 11:01:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDajX-0001Ws-UL
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 11:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbZFHJA5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 05:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754602AbZFHJA4
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 05:00:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:28402 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbZFHJAz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 05:00:55 -0400
Received: by fg-out-1718.google.com with SMTP id d23so721017fga.17
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 02:00:58 -0700 (PDT)
Received: by 10.86.31.18 with SMTP id e18mr6909014fge.72.1244451657930;
        Mon, 08 Jun 2009 02:00:57 -0700 (PDT)
Received: from localhost (p5B0D59E7.dip.t-dialin.net [91.13.89.231])
        by mx.google.com with ESMTPS id d6sm39626fga.2.2009.06.08.02.00.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Jun 2009 02:00:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.308.g426b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121051>

If you have two branches tracking an upstream that is rebased,
currently you have to do:

git checkout branch1
git pull --rebase remote branch
git checkout branch2
git pull --rebase remote branch

The second rebase works because the first "git pull --rebase" does not
store in the local tracking branch the new value, so the second rebase
detects that it is rebased.

One should be able to do the same without the explicit
arguments to "git pull --rebase", but without arguments it stores the
new state of the remote branch so the second "git pull --rebase" does
not work.

Mark this case as test_expect_failure to make people aware of this
behavior.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Hi,

I just wanted to make people aware of this behavior and then decide if
this is the correct behavior, so document it, or try to find a better
solution.

Santi
 t/t5520-pull.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c5a2e66..164a0eb 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -117,8 +117,23 @@ test_expect_success '--rebase with rebased default=
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
+	git pull --rebase
+
+'
+
 test_expect_success 'pull --rebase dies early with dirty working direc=
tory' '
=20
+	git rebase --abort &&
 	git checkout to-rebase &&
 	git update-ref refs/remotes/me/copy copy^ &&
 	COPY=3D$(git rev-parse --verify me/copy) &&
--=20
1.6.3.1.308.g426b5
