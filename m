From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH 2/3] pull --rebase: Add support for rebased default upstream
Date: Fri,  5 Jun 2009 21:53:36 +0200
Message-ID: <1244231617-17754-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 21:53:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCfTy-0004P8-3O
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 21:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbZFETxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 15:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbZFETxg
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 15:53:36 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:40210 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbZFETxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 15:53:35 -0400
Received: by bwz9 with SMTP id 9so1734854bwz.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 12:53:36 -0700 (PDT)
Received: by 10.103.160.9 with SMTP id m9mr2242731muo.96.1244231616263;
        Fri, 05 Jun 2009 12:53:36 -0700 (PDT)
Received: from localhost (p5B0D54CB.dip.t-dialin.net [91.13.84.203])
        by mx.google.com with ESMTPS id u26sm1380639mug.22.2009.06.05.12.53.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 12:53:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.308.g426b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120822>

Also add a test to check for this case and another one (failing) to
test rebasing two branches on top of a rebased upstream using just
'git pull --rebase'.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 git-parse-remote.sh |    8 +++++++-
 t/t5520-pull.sh     |   29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 8b3ba72..5df5689 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -232,7 +232,13 @@ get_remote_refs_for_fetch () {
 get_remote_merge_branch () {
 	case "$#" in
 	0|1)
-	    die "internal error: get-remote-merge-branch." ;;
+	    origin=3D"$1"
+	    default=3D$(get_default_remote)
+	    test -z "$origin" && origin=3D$default
+	    curr_branch=3D$(git symbolic-ref -q HEAD)
+	    [ "$origin" =3D "$default" ] &&
+	    echo $(git for-each-ref --format=3D'%(upstream)' $curr_branch)
+	    ;;
 	*)
 	    repo=3D$1
 	    shift
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 725771f..359a3e2 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -92,20 +92,49 @@ test_expect_success '--rebase with rebased upstream=
' '
=20
 	git remote add -f me . &&
 	git checkout copy &&
+	git tag copy-orig &&
 	git reset --hard HEAD^ &&
 	echo conflicting modification > file &&
 	git commit -m conflict file &&
 	git checkout to-rebase &&
 	echo file > file2 &&
 	git commit -m to-rebase file2 &&
+	git tag to-rebase-orig &&
 	git pull --rebase me copy &&
 	test "conflicting modification" =3D "$(cat file)" &&
 	test file =3D $(cat file2)
=20
 '
=20
+test_expect_success '--rebase with rebased default upstream' '
+
+	git update-ref refs/remotes/me/copy copy-orig &&
+	git checkout --track -b to-rebase2 me/copy &&
+	git reset --hard to-rebase-orig &&
+	git pull --rebase &&
+	test "conflicting modification" =3D "$(cat file)" &&
+	test file =3D $(cat file2)
+
+'
+
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
+	git pull --rebase me copy
+
+'
+
 test_expect_success 'pull --rebase dies early with dirty working direc=
tory' '
=20
+	git rebase --abort &&
+	git checkout to-rebase &&
 	git update-ref refs/remotes/me/copy copy^ &&
 	COPY=3D$(git rev-parse --verify me/copy) &&
 	git rebase --onto $COPY copy &&
--=20
1.6.3.1.308.g426b5
