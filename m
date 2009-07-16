From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull --rebase
Date: Thu, 16 Jul 2009 10:12:00 +0200
Message-ID: <1247731921-2290-1-git-send-email-santi@agolina.net>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:11:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRM40-0003gZ-8z
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 10:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbZGPILZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 04:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbZGPILY
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 04:11:24 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:61050 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbZGPILX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 04:11:23 -0400
Received: by bwz28 with SMTP id 28so1889681bwz.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 01:11:22 -0700 (PDT)
Received: by 10.103.24.11 with SMTP id b11mr4602620muj.133.1247731881786;
        Thu, 16 Jul 2009 01:11:21 -0700 (PDT)
Received: from localhost (p5B0D3A8D.dip.t-dialin.net [91.13.58.141])
        by mx.google.com with ESMTPS id j10sm37302799mue.59.2009.07.16.01.11.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Jul 2009 01:11:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc0.19.g1b31.dirty
In-Reply-To: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123385>

Use the fork commit of the current branch (where
the tip of upstream branch used to be) as the upstream parameter of
"git rebase". Compute it walking the reflog to find the first commit
which is an ancestor of the current branch.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>

Changed since v1:
  - rename reflist to remoteref to better reflect its use
  - (( $num + 1 ))
---
 git-pull.sh     |   11 ++++++++---
 t/t5520-pull.sh |    5 ++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 4b78a0c..31d3945 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -125,9 +125,14 @@ test true =3D "$rebase" && {
 	die "refusing to pull with rebase: your working tree is not up-to-dat=
e"
=20
 	. git-parse-remote &&
-	reflist=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
-	oldremoteref=3D"$(git rev-parse -q --verify \
-		"$reflist")"
+	remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
+	num=3D0 &&
+	while oldremoteref=3D"$(git rev-parse -q --verify "$remoteref@{$num}"=
)"
+	do
+		test $oldremoteref =3D $(git merge-base $oldremoteref $curr_branch) =
&&
+		break
+		num=3D$(( $num + 1 ))
+	done
 }
 orig_head=3D$(git rev-parse -q --verify HEAD)
 git fetch $verbosity --update-head-ok "$@" || exit 1
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 1aae494..37a7e33 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -117,15 +117,14 @@ test_expect_success '--rebase with rebased defaul=
t upstream' '
=20
 '
=20
-test_expect_failure 'rebased upstream + fetch + pull --rebase' '
+test_expect_success 'rebased upstream + fetch + pull --rebase' '
=20
 	git update-ref refs/remotes/me/copy copy-orig &&
 	git reset --hard to-rebase-orig &&
 	git checkout --track -b to-rebase3 me/copy &&
 	git reset --hard to-rebase-orig &&
 	git fetch &&
-	test_must_fail git pull --rebase &&
-	git rebase --abort &&
+	git pull --rebase &&
 	test "conflicting modification" =3D "$(cat file)" &&
 	test file =3D $(cat file2)
=20
--=20
1.6.4.rc0.19.g1b31.dirty
