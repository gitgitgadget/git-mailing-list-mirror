From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv3 2/2] pull: support rebased upstream + fetch + pull --rebase
Date: Sat, 18 Jul 2009 15:46:25 +0200
Message-ID: <1247924785-31886-1-git-send-email-santi@agolina.net>
References: <adf1fd3d0907170624t7c2bf8f5w35c03788fdd82422@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 15:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSAEf-00075e-1f
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 15:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbZGRNpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jul 2009 09:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZGRNpu
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 09:45:50 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:60642 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZGRNpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 09:45:49 -0400
Received: by fxm18 with SMTP id 18so1208493fxm.37
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 06:45:48 -0700 (PDT)
Received: by 10.102.215.19 with SMTP id n19mr1169593mug.79.1247924748305;
        Sat, 18 Jul 2009 06:45:48 -0700 (PDT)
Received: from localhost (p5B0D3877.dip.t-dialin.net [91.13.56.119])
        by mx.google.com with ESMTPS id g1sm11913584muf.26.2009.07.18.06.45.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Jul 2009 06:45:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.408.g8ecf
In-Reply-To: <adf1fd3d0907170624t7c2bf8f5w35c03788fdd82422@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123519>

The problem is that you cannot do a "git pull --rebase" with a rebased
upstream if you have already run "git fetch" before. And the solution:
Try to behaved as if the "git fetch" was not run.

Or in other words, use the fork commit of the current branch (where
the tip of upstream branch used to be) as the upstream parameter of
"git rebase".

Compute it walking the reflog to find the first commit which is an
ancestor of the current branch.  Maybe there are smarter ways to
compute it, but this is a straight forward implementation of the above
"Try to behaved as if the "git fetch" was not run".

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Changes since v2:
  - Hopefully enhance the commit log
  - Use a 'for' loop for the reflog entries
  - provide a default value in case there is no reflog
Changed since v1:
  - rename reflist to remoteref to better reflect its use
  - (( $num + 1 ))

 git-pull.sh     |   11 +++++++++--
 t/t5520-pull.sh |    5 ++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 4b78a0c..c8f1674 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -125,9 +125,16 @@ test true =3D "$rebase" && {
 	die "refusing to pull with rebase: your working tree is not up-to-dat=
e"
=20
 	. git-parse-remote &&
-	reflist=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
+	remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
+	oldremoteref=3D &&
+	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
+	do
+		test $reflog =3D $(git merge-base $reflog $curr_branch) &&
+		oldremoteref=3D$reflog && break
+	done
+	[ -z "$oldremoteref" ] &&
 	oldremoteref=3D"$(git rev-parse -q --verify \
-		"$reflist")"
+		"$remoteref")"
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
1.6.3.2.408.g8ecf
