From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2 4/5] Be more specific if upstream branch is not tracked
Date: Sat, 14 Apr 2012 09:54:34 +0200
Message-ID: <1334390075-25467-5-git-send-email-zbyszek@in.waw.pl>
References: <20120412204055.GA21018@sigill.intra.peff.net>
 <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 14 09:56:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIxqg-00082L-Sc
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 09:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab2DNH4m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 03:56:42 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34843 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115Ab2DNH4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 03:56:41 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SIxqa-0001I9-8M; Sat, 14 Apr 2012 09:56:40 +0200
X-Mailer: git-send-email 1.7.10.226.gfe575
In-Reply-To: <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195476>

If the branch configured as upstream didn't have a local tracking
branch, git said "Upstream branch not found". We can be more helpful,
and separate the cases when upstream is not configured, and when it is
configured, but the upstream branch is not tracked in a local branch.

The following configuration leads to the second scenario:

    [remote "origin"]
    	    url =3D ...
            fetch =3D refs/heads/master
    [branch "master"]
            remote =3D origin
            merge =3D refs/heads/master

'git pull' will work on master, but master@{upstream} is not defined.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 sha1_name.c                   |    7 ++++++-
 t/t1507-rev-parse-upstream.sh |    6 +++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index e2d576a..361708b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -865,7 +865,12 @@ int interpret_branch_name(const char *name, struct=
 strbuf *buf)
 	if (!upstream->merge || !upstream->merge[0]->dst) {
 		if (!ref_exists(upstream->refname))
 			return error("No such branch: '%s'", cp);
-		return error("No upstream branch found for '%s'", upstream->name);
+		if (!upstream->merge)
+			return error("No upstream configured for branch '%s'",
+				     upstream->name);
+		return error(
+			"Upstream branch '%s' not stored as a remote-tracking branch",
+			upstream->merge[0]->src);
 	}
 	free(cp);
 	cp =3D shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream=
=2Esh
index 2b8ba31..e742ce0 100755
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
 	error_message non-tracking@{u} 2>actual &&
@@ -134,7 +134,7 @@ test_expect_success 'branch@{u} error message when =
no upstream' '
=20
 test_expect_success '@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
-	error: No upstream branch found for ${sq}master${sq}
+	error: No upstream configured for branch ${sq}master${sq}
 	fatal: Needed a single revision
 	EOF
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
@@ -162,7 +162,7 @@ test_expect_success '@{u} error message when not on=
 a branch' '
=20
 test_expect_success 'branch@{u} error message if upstream branch not f=
etched' '
 	cat >expect <<-EOF &&
-	error: No upstream branch found for ${sq}bad-upstream${sq}
+	error: Upstream branch ${sq}refs/heads/side${sq} not stored as a remo=
te-tracking branch
 	fatal: Needed a single revision
 	EOF
 	error_message bad-upstream@{u} 2>actual &&
--=20
1.7.10.226.gfe575
