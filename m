From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH 2/2] pull: support rebased upstream + fetch + pull --rebase
Date: Thu, 16 Jul 2009 02:09:15 +0200
Message-ID: <1247702955-1559-2-git-send-email-santi@agolina.net>
References: <1247702955-1559-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 02:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MREXB-0000oP-RN
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 02:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588AbZGPAJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2009 20:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756520AbZGPAJD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 20:09:03 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:47591 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574AbZGPAJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 20:09:02 -0400
Received: by mail-fx0-f218.google.com with SMTP id 18so3779209fxm.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 17:09:01 -0700 (PDT)
Received: by 10.204.58.208 with SMTP id i16mr8144226bkh.63.1247702941760;
        Wed, 15 Jul 2009 17:09:01 -0700 (PDT)
Received: from localhost (p5B0D3A8D.dip.t-dialin.net [91.13.58.141])
        by mx.google.com with ESMTPS id e17sm13934926fke.48.2009.07.15.17.08.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 17:09:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.408.g8ecf
In-Reply-To: <1247702955-1559-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123346>

Use the fork commit of the current branch (where
the tip of upstream branch used to be) as the upstream parameter of
"git rebase". Compute it walking the reflog to find the first commit
which is an ancestor of the current branch.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 git-pull.sh     |    9 +++++++--
 t/t5520-pull.sh |    5 ++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 4b78a0c..f5bef53 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -126,8 +126,13 @@ test true =3D "$rebase" && {
=20
 	. git-parse-remote &&
 	reflist=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
-	oldremoteref=3D"$(git rev-parse -q --verify \
-		"$reflist")"
+	num=3D0 &&
+	while oldremoteref=3D"$(git rev-parse -q --verify "$reflist@{$num}")"
+	do
+		test $oldremoteref =3D $(git merge-base $oldremoteref $curr_branch) =
&&
+		break
+		num=3D$((num+1))
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
1.6.4.rc0.18.g60787.dirty
