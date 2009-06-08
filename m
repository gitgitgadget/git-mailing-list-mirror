From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv3 2/4] parse-remote: support default reflist in get_remote_merge_branch
Date: Mon,  8 Jun 2009 11:00:49 +0200
Message-ID: <1244451651-22651-3-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 11:01:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDajX-0001Ws-A6
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 11:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbZFHJAx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 05:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbZFHJAx
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 05:00:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:29346 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbZFHJAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 05:00:52 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1041444fgg.17
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 02:00:54 -0700 (PDT)
Received: by 10.86.98.7 with SMTP id v7mr6910853fgb.58.1244451653984;
        Mon, 08 Jun 2009 02:00:53 -0700 (PDT)
Received: from localhost (p5B0D59E7.dip.t-dialin.net [91.13.89.231])
        by mx.google.com with ESMTPS id 4sm1837536fge.13.2009.06.08.02.00.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Jun 2009 02:00:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.308.g426b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121052>

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
index 8b3ba72..5df5689 100755
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
1.6.3.1.308.g426b5
