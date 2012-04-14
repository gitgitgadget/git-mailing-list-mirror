From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2 1/5] t1507: add tests to document @{upstream} behaviour
Date: Sat, 14 Apr 2012 09:54:31 +0200
Message-ID: <1334390075-25467-2-git-send-email-zbyszek@in.waw.pl>
References: <20120412204055.GA21018@sigill.intra.peff.net>
 <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 14 09:56:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIxqI-0007jG-Ia
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 09:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab2DNH4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 03:56:18 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34828 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819Ab2DNH4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 03:56:17 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SIxq7-0001I9-Ny; Sat, 14 Apr 2012 09:56:13 +0200
X-Mailer: git-send-email 1.7.10.226.gfe575
In-Reply-To: <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195473>

In preparation for future changes, add tests which show error messages
with @{upstream} in various conditions:

- test branch@{u} with . as remote
- check error message for branch@{u} on a branch with
  * no upstream,
  * on a branch with a configured upstream which doesn't have a
    remote-tracking branch
- check error message for branch@{u} when branch 'branch' does not
  exist
- check error message for @{u} without the branch name

Right now the messages are very similar, but various cases can and
will be distinguished.

Note: test_i18ncmp is not used, because currently error output is not
internationalized. test_cmp will be switched to test_i18ncmp in a later
patch, when error messages are internationalized.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t1507-rev-parse-upstream.sh |   81 +++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream=
=2Esh
index a455551..c4981ba 100755
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
@@ -107,6 +119,69 @@ test_expect_success 'checkout other@{u}' '
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
+	error_message non-tracking@{u} 2>actual &&
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
1.7.10.226.gfe575
