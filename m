From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2 2/3] parse-remote: support default reflist in get_remote_merge_branch
Date: Sun,  7 Jun 2009 11:44:21 +0200
Message-ID: <1244367862-6306-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 11:44:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDEvo-000847-I4
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 11:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155AbZFGJoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 05:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbZFGJoP
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 05:44:15 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:43713 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbZFGJoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 05:44:14 -0400
Received: by fxm9 with SMTP id 9so1517168fxm.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 02:44:14 -0700 (PDT)
Received: by 10.204.55.142 with SMTP id u14mr5271395bkg.121.1244367854015;
        Sun, 07 Jun 2009 02:44:14 -0700 (PDT)
Received: from localhost (p5B0D6736.dip.t-dialin.net [91.13.103.54])
        by mx.google.com with ESMTPS id b17sm2097037fka.36.2009.06.07.02.44.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 02:44:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.308.g426b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120959>

Expand get_remote_merge_branch to compute the tracking branch to merge
when called without arguments (or only the remote name). This allows
"git pull --rebase" without arguments (default upstream branch) to
work with a rebased upstream.

Also add a test to check for this case and another one (failing) to
test rebasing two branches on top of a rebased upstream using just
'git pull --rebase'.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Changes from v1:
  - Hopefully provide a more useful and correct commit message

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
