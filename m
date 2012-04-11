From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 1/5] t1507: add additional tests for @{upstream}
Date: Wed, 11 Apr 2012 18:17:11 +0200
Message-ID: <1334161035-26355-2-git-send-email-zbyszek@in.waw.pl>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 11 18:17:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0Es-0007vP-N1
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760635Ab2DKQRm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:17:42 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34677 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759968Ab2DKQRl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:17:41 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SI0El-00065L-R3; Wed, 11 Apr 2012 18:17:39 +0200
X-Mailer: git-send-email 1.7.10.344.g387ed
In-Reply-To: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195200>

- test branch@{u} with . as remote
- check error message for branch@{u} on a branch with
  * no upstream,
  * on a branch with a configured upstream, but when a branch is not
    in remote.<remote>.fetch
- check error message for branch@{u} when branch 'branch' does not
  exist
- check error message for @{u} without the branch name

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t1507-rev-parse-upstream.sh | 82 +++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream=
=2Esh
index a455551..1342915 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -15,10 +15,18 @@ test_expect_success 'setup' '
 	test_commit 3 &&
 	(cd clone &&
 	 test_commit 4 &&
-	 git branch --track my-side origin/side)
-
+	 git branch --track my-side origin/side &&
+	 git branch --track local-master master &&
+	 git remote add -t master master-only .. &&
+	 git fetch master-only &&
+	 git branch bad-upstream &&
+	 git config branch.bad-upstream.remote master-only &&
+	 git config branch.bad-upstream.merge refs/heads/side
+	)
 '
=20
+sq=3D"'"
+
 full_name () {
 	(cd clone &&
 	 git rev-parse --symbolic-full-name "$@")
@@ -29,6 +37,11 @@ commit_subject () {
 	 git show -s --pretty=3Dformat:%s "$@")
 }
=20
+error_message () {
+	(cd clone &&
+	 test_must_fail git rev-parse --verify "$@")
+}
+
 test_expect_success '@{upstream} resolves to correct full name' '
 	test refs/remotes/origin/master =3D "$(full_name @{upstream})"
 '
@@ -78,7 +91,6 @@ test_expect_success 'checkout -b new my-side@{u} fork=
s from the same' '
=20
 test_expect_success 'merge my-side@{u} records the correct name' '
 (
-	sq=3D"'\''" &&
 	cd clone || exit
 	git checkout master || exit
 	git branch -D new ;# can fail but is ok
@@ -107,6 +119,70 @@ test_expect_success 'checkout other@{u}' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'branch@{u} works when tracking a local branch' '
+	test refs/heads/master =3D "$(full_name local-master@{u})"
+'
+
+test_expect_success 'branch@{u} error message when no upstream' '
+	cat >expect <<-EOF &&
+	error: No upstream branch found for ${sq}non-tracking${sq}
+	fatal: Needed a single revision
+	EOF
+	(cd clone &&
+	 test_must_fail git rev-parse --verify non-tracking@{u}) 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '@{u} error message when no upstream' '
+	cat >expect <<-EOF &&
+	error: No upstream branch found for ${sq}${sq}
+	fatal: Needed a single revision
+	EOF
+	test_must_fail git rev-parse --verify @{u} 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'branch@{u} error message with misspelt branch' '
+	cat >expect <<-EOF &&
+	error: No upstream branch found for ${sq}no-such-branch${sq}
+	fatal: Needed a single revision
+	EOF
+	error_message no-such-branch@{u} 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '@{u} error message when not on a branch' '
+	cat >expect <<-EOF &&
+	error: No upstream branch found for ${sq}${sq}
+	fatal: Needed a single revision
+	EOF
+	git checkout HEAD^0 &&
+	test_must_fail git rev-parse --verify @{u} 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'branch@{u} error message if upstream branch not f=
etched' '
+	cat >expect <<-EOF &&
+	error: No upstream branch found for ${sq}bad-upstream${sq}
+	fatal: Needed a single revision
+	EOF
+	error_message bad-upstream@{u} 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pull works when tracking a local branch' '
+(
+	cd clone &&
+	git checkout local-master &&
+	git pull
+)
+'
+
+# makes sense if the previous one succeeded
+test_expect_success '@{u} works when tracking a local branch' '
+	test refs/heads/master =3D "$(full_name @{u})"
+'
+
 cat >expect <<EOF
 commit 8f489d01d0cc65c3b0f09504ec50b5ed02a70bd5
 Reflog: master@{0} (C O Mitter <committer@example.com>)
--=20
1.7.10.344.g387ed
