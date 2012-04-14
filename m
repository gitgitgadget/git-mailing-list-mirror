From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2 3/5] Provide better message for barnhc_wiht_tpyo@{u}
Date: Sat, 14 Apr 2012 09:54:33 +0200
Message-ID: <1334390075-25467-4-git-send-email-zbyszek@in.waw.pl>
References: <20120412204055.GA21018@sigill.intra.peff.net>
 <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 14 09:56:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIxqZ-0007tr-FJ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 09:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab2DNH4e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 03:56:34 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34838 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035Ab2DNH4c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 03:56:32 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SIxqR-0001I9-4g; Sat, 14 Apr 2012 09:56:31 +0200
X-Mailer: git-send-email 1.7.10.226.gfe575
In-Reply-To: <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195475>

Instead of just saying that no upstream exists for such branch,
which is true but not very helpful, check that there's no
refs/heads/barnhc_wiht_tpyo and tell it to the user.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 sha1_name.c                   |    5 ++++-
 t/t1507-rev-parse-upstream.sh |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index c2fe1aa..e2d576a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -862,8 +862,11 @@ int interpret_branch_name(const char *name, struct=
 strbuf *buf)
 	 */
 	if (!upstream)
 		return error("HEAD does not point to a branch");
-	if (!upstream->merge || !upstream->merge[0]->dst)
+	if (!upstream->merge || !upstream->merge[0]->dst) {
+		if (!ref_exists(upstream->refname))
+			return error("No such branch: '%s'", cp);
 		return error("No upstream branch found for '%s'", upstream->name);
+	}
 	free(cp);
 	cp =3D shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
 	strbuf_reset(buf);
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream=
=2Esh
index 2f4f0d1..2b8ba31 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -143,7 +143,7 @@ test_expect_success '@{u} error message when no ups=
tream' '
=20
 test_expect_success 'branch@{u} error message with misspelt branch' '
 	cat >expect <<-EOF &&
-	error: No upstream branch found for ${sq}no-such-branch${sq}
+	error: No such branch: ${sq}no-such-branch${sq}
 	fatal: Needed a single revision
 	EOF
 	error_message no-such-branch@{u} 2>actual &&
--=20
1.7.10.226.gfe575
