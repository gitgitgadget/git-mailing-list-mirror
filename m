From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 3/5] Provide better message for barnhc_wiht_tpyo@{u}
Date: Wed, 11 Apr 2012 18:17:13 +0200
Message-ID: <1334161035-26355-4-git-send-email-zbyszek@in.waw.pl>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 11 18:18:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0FM-0008DX-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760606Ab2DKQSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:18:11 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34681 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760038Ab2DKQSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:18:11 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SI0FF-00065L-Dx; Wed, 11 Apr 2012 18:18:10 +0200
X-Mailer: git-send-email 1.7.10.344.g387ed
In-Reply-To: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195202>

Instead of just saying that no upstream exists for such branch,
which is true but not very helpful, check that there's no
refs/heads/barnhc_wiht_tpyo and tell it to the user.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 sha1_name.c                   | 5 ++++-
 t/t1507-rev-parse-upstream.sh | 2 +-
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
index a00b689..05c4bc4 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -144,7 +144,7 @@ test_expect_success '@{u} error message when no ups=
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
1.7.10.344.g387ed
