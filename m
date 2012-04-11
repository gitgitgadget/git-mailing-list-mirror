From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 4/5] Be more specific if upstream branch is not fetched
Date: Wed, 11 Apr 2012 18:17:14 +0200
Message-ID: <1334161035-26355-5-git-send-email-zbyszek@in.waw.pl>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 11 18:18:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0FV-0008Ja-Bz
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760637Ab2DKQSU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:18:20 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34683 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760038Ab2DKQSU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:18:20 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SI0FO-00065L-VO; Wed, 11 Apr 2012 18:18:19 +0200
X-Mailer: git-send-email 1.7.10.344.g387ed
In-Reply-To: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195203>

If the branch configured as upstream was missing from
remote.<remote>.fetch, git said "Upstream branch not found".
We can be more helpful, and separate the cases when upstream
is not configured, and when it is configured, but specific
branch is not fetched.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 sha1_name.c                   | 6 +++++-
 t/t1507-rev-parse-upstream.sh | 6 +++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index e2d576a..5b1b0f9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -865,7 +865,11 @@ int interpret_branch_name(const char *name, struct=
 strbuf *buf)
 	if (!upstream->merge || !upstream->merge[0]->dst) {
 		if (!ref_exists(upstream->refname))
 			return error("No such branch: '%s'", cp);
-		return error("No upstream branch found for '%s'", upstream->name);
+		if (!upstream->merge)
+			return error("No upstream configured for branch '%s'",
+				     upstream->name);
+		return error("Upstream branch '%s' not fetched from remote '%s'",
+			     upstream->merge[0]->src, upstream->remote_name);
 	}
 	free(cp);
 	cp =3D shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream=
=2Esh
index 05c4bc4..112025f 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -125,7 +125,7 @@ test_expect_success 'branch@{u} works when tracking=
 a local branch' '
=20
 test_expect_success 'branch@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
-	error: No upstream branch found for ${sq}non-tracking${sq}
+	error: No upstream configured for branch ${sq}non-tracking${sq}
 	fatal: Needed a single revision
 	EOF
 	(cd clone &&
@@ -135,7 +135,7 @@ test_expect_success 'branch@{u} error message when =
no upstream' '
=20
 test_expect_success '@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
-	error: No upstream branch found for ${sq}master${sq}
+	error: No upstream configured for branch ${sq}master${sq}
 	fatal: Needed a single revision
 	EOF
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
@@ -163,7 +163,7 @@ test_expect_success '@{u} error message when not on=
 a branch' '
=20
 test_expect_success 'branch@{u} error message if upstream branch not f=
etched' '
 	cat >expect <<-EOF &&
-	error: No upstream branch found for ${sq}bad-upstream${sq}
+	error: Upstream branch ${sq}refs/heads/side${sq} not fetched from rem=
ote ${sq}master-only${sq}
 	fatal: Needed a single revision
 	EOF
 	error_message bad-upstream@{u} 2>actual &&
--=20
1.7.10.344.g387ed
