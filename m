From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv4 2/4] parse-remote: support default reflist in get_remote_merge_branch
Date: Fri, 12 Jun 2009 00:39:19 +0200
Message-ID: <1244759961-4750-3-git-send-email-santi@agolina.net>
References: <1244759961-4750-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 00:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEsw3-00070r-MR
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 00:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761196AbZFKWjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 18:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762691AbZFKWjT
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 18:39:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:9150 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761393AbZFKWjR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 18:39:17 -0400
Received: by fg-out-1718.google.com with SMTP id d23so34657fga.17
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 15:39:20 -0700 (PDT)
Received: by 10.86.68.10 with SMTP id q10mr2857413fga.78.1244759959934;
        Thu, 11 Jun 2009 15:39:19 -0700 (PDT)
Received: from localhost (p5B0D383D.dip.t-dialin.net [91.13.56.61])
        by mx.google.com with ESMTPS id e20sm237862fga.10.2009.06.11.15.39.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 15:39:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.222.g479ad6
In-Reply-To: <1244759961-4750-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121369>

Expand get_remote_merge_branch to compute the tracking branch to merge
when called without arguments (or only the remote name). This allows
"git pull --rebase" without arguments (default upstream branch) to
work with a rebased upstream. With explicit arguments it already worked=
=2E

Also add a test to check for this case.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---

Changes since v1:
  - Hopefully provide a more useful and correct commit message
Changes since v2:
  - Add sentence about the "with explicit arguments" case
  - Move the test about two branch to a different patch
  - Restore the executable bit

 git-parse-remote.sh |    8 +++++++-
 t/t5520-pull.sh     |   14 ++++++++++++++
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index a991564..75e1254 100755
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
index 725771f..c5a2e66 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -92,20 +92,34 @@ test_expect_success '--rebase with rebased upstream=
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
 test_expect_success 'pull --rebase dies early with dirty working direc=
tory' '
=20
+	git checkout to-rebase &&
 	git update-ref refs/remotes/me/copy copy^ &&
 	COPY=3D$(git rev-parse --verify me/copy) &&
 	git rebase --onto $COPY copy &&
--=20
1.6.3.2.206.g417f7
