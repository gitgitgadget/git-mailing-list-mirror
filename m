From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Make !pattern in .gitattributes non-fatal
Date: Fri, 1 Mar 2013 21:06:17 +0100
Message-ID: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 21:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBWEL-00065h-R8
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 21:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720Ab3CAUGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 15:06:25 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:45547 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab3CAUGW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 15:06:22 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 1 Mar
 2013 21:06:15 +0100
Received: from pctrast.v.cablecom.net (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 1 Mar
 2013 21:06:17 +0100
X-Mailer: git-send-email 1.8.2.rc1.392.gf57d6b8.dirty
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217289>

Before 82dce99 (attr: more matching optimizations from .gitignore,
2012-10-15), .gitattributes did not have any special treatment of a
leading '!'.  The docs, however, always said

  The rules how the pattern matches paths are the same as in
  `.gitignore` files; see linkgit:gitignore[5].

By those rules, leading '!' means pattern negation.  So 82dce99
correctly determined that this kind of line makes no sense and should
be disallowed.

However, users who actually had a rule for files starting with a '!'
are in a bad position: before 82dce99 '!' matched that literal
character, so it is conceivable that users have .gitattributes with
such lines in them.  After 82dce99 the unescaped version was
disallowed in such a way that git outright refuses to run(!) most
commands in the presence of such a .gitattributes.  It therefore
becomes very hard to fix, let alone work with, such repositories.

Let's at least allow the users to fix their repos: change the fatal
error into a warning.

Reported-by: mathstuf@gmail.com
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 attr.c                | 8 +++++---
 t/t0003-attributes.sh | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index 4657cc2..e2f9377 100644
--- a/attr.c
+++ b/attr.c
@@ -255,9 +255,11 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
 				      &res->u.pat.nowildcardlen);
-		if (res->u.pat.flags & EXC_FLAG_NEGATIVE)
-			die(_("Negative patterns are forbidden in git attributes\n"
-			      "Use '\\!' for literal leading exclamation."));
+		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
+			warning(_("Negative patterns are ignored in git attributes\n"
+				  "Use '\\!' for literal leading exclamation."));
+			return NULL;
+		}
 	}
 	res->is_macro = is_macro;
 	res->num_attr = num_attr;
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 43b2513..0b98b6f 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -198,7 +198,8 @@ test_expect_success 'root subdir attribute test' '
 
 test_expect_success 'negative patterns' '
 	echo "!f test=bar" >.gitattributes &&
-	test_must_fail git check-attr test -- f
+	git check-attr test -- '"'"'!f'"'"' 2>errors &&
+	test_i18ngrep "Negative patterns are ignored" errors
 '
 
 test_expect_success 'patterns starting with exclamation' '
-- 
1.8.2.rc1.392.gf57d6b8.dirty
