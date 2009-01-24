From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 1/2] am: Add --committer-date-is-author-date option
Date: Sat, 24 Jan 2009 10:17:50 +0900
Message-ID: <20090124101750.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 02:19:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQXBZ-00036o-Kx
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 02:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbZAXBSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 20:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbZAXBSN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 20:18:13 -0500
Received: from karen.lavabit.com ([72.249.41.33]:53005 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143AbZAXBSN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 20:18:13 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 2F297C7AA6;
	Fri, 23 Jan 2009 19:18:12 -0600 (CST)
Received: from 7951.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id B40UFGP2NFZV; Fri, 23 Jan 2009 19:18:12 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=SO+KVX5GsQoH0ixBhaKiEKwJSaL8Vwx8S0q6Gc3DvkPhmig10tbIc+JBcxAYXOA02QgI1Bmq4CXSubLsN+ny4Wi+m/F9FIN4tPJI1gXUaG+Fn7Z4pzpcUE5/t2fiHKiX8l/pXRPz5Q+fP9T5bdNg9cJW9KpwArF4n5Q3aRPm6hs=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106939>

=46rom: Junio C Hamano <gitster@pobox.com>
Date: Thu, 22 Jan 2009 16:14:58 -0800

This new option tells 'git-am' to use the timestamp recorded
in the Email message as both author and committer date.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
 git-am.sh     |   13 ++++++++++++-
 t/t4150-am.sh |   20 ++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e20dd88..e96071d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -23,6 +23,7 @@ resolvemsg=3D     override error message when patch f=
ailure occurs
 r,resolved      to be used after a patch failure
 skip            skip the current patch
 abort           restore the original branch and abort the patching ope=
ration.
+committer-date-is-author-date    lie about committer date
 rebasing        (internal use for git-rebase)"
=20
 . git-sh-setup
@@ -133,6 +134,7 @@ dotest=3D"$GIT_DIR/rebase-apply"
 sign=3D utf8=3Dt keep=3D skip=3D interactive=3D resolved=3D rebasing=3D=
 abort=3D
 resolvemsg=3D resume=3D
 git_apply_opt=3D
+committer_date_is_author_date=3D
=20
 while test $# !=3D 0
 do
@@ -168,6 +170,8 @@ do
 		git_apply_opt=3D"$git_apply_opt $(sq "$1=3D$2")"; shift ;;
 	-C|-p)
 		git_apply_opt=3D"$git_apply_opt $(sq "$1$2")"; shift ;;
+	--committer-date-is-author-date)
+		committer_date_is_author_date=3Dt ;;
 	--)
 		shift; break ;;
 	*)
@@ -521,7 +525,14 @@ do
=20
 	tree=3D$(git write-tree) &&
 	parent=3D$(git rev-parse --verify HEAD) &&
-	commit=3D$(git commit-tree $tree -p $parent <"$dotest/final-commit") =
&&
+	commit=3D$(
+		if test -n "$committer_date_is_author_date"
+		then
+			GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+			export GIT_COMMITTER_DATE
+		fi &&
+		git commit-tree $tree -p $parent <"$dotest/final-commit"
+	) &&
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $pare=
nt ||
 	stop_here $this
=20
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 796f795..8d3fb00 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -257,4 +257,24 @@ test_expect_success 'am works from file (absolute =
path given) in subdirectory' '
 	test -z "$(git diff second)"
 '
=20
+test_expect_success 'am --committer-date-is-author-date' '
+	git checkout first &&
+	test_tick &&
+	git am --committer-date-is-author-date patch1 &&
+	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
+	at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
+	ct=3D$(sed -ne "/^committer /s/.*> //p" head1) &&
+	test "$at" =3D "$ct"
+'
+
+test_expect_success 'am without --committer-date-is-author-date' '
+	git checkout first &&
+	test_tick &&
+	git am patch1 &&
+	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
+	at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
+	ct=3D$(sed -ne "/^committer /s/.*> //p" head1) &&
+	test "$at" !=3D "$ct"
+'
+
 test_done
--=20
1.6.1

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
