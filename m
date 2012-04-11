From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 2/5] Provide branch name in error message when using @{u}
Date: Wed, 11 Apr 2012 18:17:12 +0200
Message-ID: <1334161035-26355-3-git-send-email-zbyszek@in.waw.pl>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 11 18:18:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0F4-00082i-TV
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760636Ab2DKQRy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:17:54 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34679 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760594Ab2DKQRx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:17:53 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SI0Ey-00065L-B0; Wed, 11 Apr 2012 18:17:52 +0200
X-Mailer: git-send-email 1.7.10.344.g387ed
In-Reply-To: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195201>

When using @{u} or @{upstream} it is common to omit the branch name,
implying current branch. If the upstream is not configured, the error
message was "No upstream branch found for ''".

When resolving '@{u}', branch_get() is called, which almost always
returns a description of a branch. This allows us to use a branch name
in the error message, even if the user said something like '@{u}'.

The only case when branch_get() returns NULL is when HEAD points to so
something which is not a branch. Of course this also means that no
upstream is configured, but it is better to directly say that HEAD
does not point to a branch.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 sha1_name.c                   | 12 ++++++++----
 t/t1507-rev-parse-upstream.sh |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 03ffc2c..c2fe1aa 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -856,10 +856,14 @@ int interpret_branch_name(const char *name, struc=
t strbuf *buf)
 	len =3D cp + tmp_len - name;
 	cp =3D xstrndup(name, cp - name);
 	upstream =3D branch_get(*cp ? cp : NULL);
-	if (!upstream
-	    || !upstream->merge
-	    || !upstream->merge[0]->dst)
-		return error("No upstream branch found for '%s'", cp);
+	/*
+	 * Upstream can be NULL only if cp refers to HEAD and HEAD
+	 * points to something different than a branch.
+	 */
+	if (!upstream)
+		return error("HEAD does not point to a branch");
+	if (!upstream->merge || !upstream->merge[0]->dst)
+		return error("No upstream branch found for '%s'", upstream->name);
 	free(cp);
 	cp =3D shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
 	strbuf_reset(buf);
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream=
=2Esh
index 1342915..a00b689 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -135,7 +135,7 @@ test_expect_success 'branch@{u} error message when =
no upstream' '
=20
 test_expect_success '@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
-	error: No upstream branch found for ${sq}${sq}
+	error: No upstream branch found for ${sq}master${sq}
 	fatal: Needed a single revision
 	EOF
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
@@ -153,7 +153,7 @@ test_expect_success 'branch@{u} error message with =
misspelt branch' '
=20
 test_expect_success '@{u} error message when not on a branch' '
 	cat >expect <<-EOF &&
-	error: No upstream branch found for ${sq}${sq}
+	error: HEAD does not point to a branch
 	fatal: Needed a single revision
 	EOF
 	git checkout HEAD^0 &&
--=20
1.7.10.344.g387ed
