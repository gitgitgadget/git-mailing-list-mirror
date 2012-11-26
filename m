From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 11/11] Unify appending signoff in format-patch, commit and sequencer
Date: Sun, 25 Nov 2012 17:45:59 -0800
Message-ID: <1353894359-6733-12-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:49:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcnog-00088S-3s
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab2KZBsn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2012 20:48:43 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48267 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab2KZBsm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:48:42 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7624372pbc.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MhKoXxQlSmjYSxL2Xli2O8pJz8C00KNSc2o+O9Nz8V0=;
        b=LGcsedQ+gE+OJ/XX2IuhYetsCF3R/rTPOSnBNp1hXGH1Xgc+EcKT/q1URL6PSodjsK
         HtJ1kDJ3BKa8MmofqczEbtRcDLXAp7k/Nkdpi/pAbTwK/dDRXUuKpL5qxCPbAKtJowQl
         n8B/v0FR95x6SXOQ4oEPsuV0uc/OAC5t5IBF/BgbK8tsdvLwp1Znp3hHVx18qb6XbdDR
         C18xwQZtr3edf9/qHZk7gLZDs8UZuZo2R4P6DdhXuPY0V5DJaK3eH5tqZoMOaMehdkNY
         r6m9YiwczX6dfUqznYHHYXFkVoywQVwbzmqEOu3TaTUVVkOhm94tpQip2tdSs/CAXW4K
         7HrA==
Received: by 10.66.81.42 with SMTP id w10mr28430311pax.66.1353894522247;
        Sun, 25 Nov 2012 17:48:42 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.48.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:48:41 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210401>

There are two implementations of append_signoff in log-tree.c and
sequencer.c, which do more or less the same thing.  Unify on top of the
sequencer.c implementation.

Add a test in t4014 to demonstrate support for non-s-o-b elements in th=
e
commit footer provided by sequence.c:append_sob.  Mark tests fixed as
appropriate.

[Commit message mostly stolen from Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy's original
 unification patch]

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 log-tree.c              | 122 +---------------------------------------=
--------
 t/t4014-format-patch.sh |  27 +++++++++--
 2 files changed, 26 insertions(+), 123 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index be8e7ab..1fb0a16 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "color.h"
 #include "gpg-interface.h"
+#include "sequencer.h"
=20
 struct decoration name_decoration =3D { "object names" };
=20
@@ -206,125 +207,6 @@ void show_decorations(struct rev_info *opt, struc=
t commit *commit)
 	putchar(')');
 }
=20
-/*
- * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
- * Signed-off-by: and Acked-by: lines.
- */
-static int detect_any_signoff(char *letter, int size)
-{
-	char *cp;
-	int seen_colon =3D 0;
-	int seen_at =3D 0;
-	int seen_name =3D 0;
-	int seen_head =3D 0;
-
-	cp =3D letter + size;
-	while (letter <=3D --cp && *cp =3D=3D '\n')
-		continue;
-
-	while (letter <=3D cp) {
-		char ch =3D *cp--;
-		if (ch =3D=3D '\n')
-			break;
-
-		if (!seen_at) {
-			if (ch =3D=3D '@')
-				seen_at =3D 1;
-			continue;
-		}
-		if (!seen_colon) {
-			if (ch =3D=3D '@')
-				return 0;
-			else if (ch =3D=3D ':')
-				seen_colon =3D 1;
-			else
-				seen_name =3D 1;
-			continue;
-		}
-		if (('A' <=3D ch && ch <=3D 'Z') ||
-		    ('a' <=3D ch && ch <=3D 'z') ||
-		    ch =3D=3D '-') {
-			seen_head =3D 1;
-			continue;
-		}
-		/* no empty last line doesn't match */
-		return 0;
-	}
-	return seen_head && seen_name;
-}
-
-static void append_signoff(struct strbuf *sb, int flags)
-{
-	char* signoff =3D xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
-					 getenv("GIT_COMMITTER_EMAIL")));
-	static const char sign_off_header[] =3D "Signed-off-by: ";
-	size_t signoff_len =3D strlen(signoff);
-	int has_signoff =3D 0;
-	char *cp;
-
-	/*
-	 * Only search in the last paragrah, don't be fooled by a
-	 * paragraph full of valid S-o-b in the middle.
-	 */
-	cp =3D sb->buf + sb->len - 1;
-	while (cp > sb->buf) {
-		if (cp[0] =3D=3D '\n' && cp[1] =3D=3D '\n') {
-			cp +=3D 2;
-			break;
-		}
-		cp--;
-	}
-
-	/* First see if we already have the sign-off by the signer */
-	while ((cp =3D strstr(cp, sign_off_header))) {
-		const char *s =3D cp;
-		cp +=3D strlen(sign_off_header);
-
-		if (!has_signoff && s > sb->buf) {
-			/*
-			 * S-o-b in the middle of a sentence is not
-			 * really S-o-b
-			 */
-			if (s[-1] !=3D '\n')
-				continue;
-
-			if (s - 1 > sb->buf && s[-2] =3D=3D '\n')
-				; /* the first S-o-b */
-			else if (!detect_any_signoff(sb->buf, s - sb->buf))
-				/*
-				 * The previous line looks like an
-				 * S-o-b. There's still no guarantee
-				 * that it's an actual S-o-b. For that
-				 * we need to look back until we find
-				 * a blank line, which is too costly.
-				 */
-				continue;
-		}
-
-		has_signoff =3D 1;
-
-		if (cp + signoff_len >=3D sb->buf + sb->len)
-			break;
-		if (strncmp(cp, signoff, signoff_len))
-			continue;
-		if (!isspace(cp[signoff_len]))
-			continue;
-		/* we already have him */
-		return;
-	}
-
-	if (!has_signoff)
-		has_signoff =3D detect_any_signoff(sb->buf, sb->len);
-
-	if (!has_signoff)
-		strbuf_addch(sb, '\n');
-
-	strbuf_addstr(sb, sign_off_header);
-	strbuf_add(sb, signoff, signoff_len);
-	strbuf_addch(sb, '\n');
-	free(signoff);
-}
-
 static unsigned int digits_in_number(unsigned int number)
 {
 	unsigned int i =3D 10, result =3D 1;
@@ -712,7 +594,7 @@ void show_log(struct rev_info *opt)
 	pretty_print_commit(&ctx, commit, &msgbuf);
=20
 	if (opt->add_signoff)
-		append_signoff(&msgbuf, 0);
+		append_signoff(&msgbuf, 0, 1);
=20
 	if ((ctx.fmt !=3D CMIT_FMT_USERFORMAT) &&
 	    ctx.notes_message && *ctx.notes_message) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 30e37a7..1dea58b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1046,7 +1046,28 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: some random signoff-alike' '
+test_expect_success 'signoff: misc conforming footer elements' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+
+Signed-off-by: my@house
+(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
+Tested-by: Some One <someone@example.com>
+Bug: 1234
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+11:Signed-off-by: my@house
+15:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: some random signoff-alike' '
 	append_signoff <<\EOF >actual &&
 subject
=20
@@ -1163,7 +1184,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: detect garbage in non-conforming footer'=
 '
+test_expect_success 'signoff: detect garbage in non-conforming footer'=
 '
 	append_signoff <<\EOF >actual &&
 subject
=20
@@ -1184,7 +1205,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: footer begins with non-signoff without @=
 sign' '
+test_expect_success 'signoff: footer begins with non-signoff without @=
 sign' '
 	append_signoff <<\EOF >actual &&
 subject
=20
--=20
1.8.0.284.g959048a
