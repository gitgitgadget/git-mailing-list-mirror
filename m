From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/15] for-each-ref: introduce format specifier %>(*) and %<(*)
Date: Tue,  9 Jul 2013 16:02:21 +0530
Message-ID: <1373365946-9230-11-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHt-0007Ep-F2
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622Ab3GIKgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:43 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:55115 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab3GIKgj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:39 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so5096061pdj.3
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2E5s4IOUWUOnSm9wx4NdB7S14iGhddfjyKGtDpbSUw8=;
        b=BxkjFLrZ6u0pCKsYdiDPxPJFVYrZh4HUlTJkPNn4wny2Ro/4j++YVA1NBbeiFlg4Gb
         BZt/CUuKvJpw7r/kaa6o0QIV50+4B6iPTdmFT6efbNt3ZWHyibRGWbt5wVoDco/S2fty
         TYL/uMOsT3lU4dd0NDX5mx2WXgczNdT51Z1fYWV3jUEAtKPssKmIKMMNX2cijgksCcAC
         cOM8F9N2ttgIK0JXrNWn66W47eEX9M+664nlOkSLBk2vGqqgPOZYlLpJ48+3RNZrkvjf
         eREO/K4BOWy5KjPJWK+HibqefqDc9aH7P5fBi3uAsdya1GI9Nf+xfR7VE8mV88pGVhnD
         ZhFA==
X-Received: by 10.68.162.97 with SMTP id xz1mr25926767pbb.166.1373366198440;
        Tue, 09 Jul 2013 03:36:38 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229938>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Pretty placeholders %>(N) and %<(N) require a user provided width N,
which makes sense because the commit chain could be really long and the
user only needs to look at a few at the top, going to the end just to
calculate the best width wastes CPU cycles.

for-each-ref is different; the display set is small, and we display the=
m
all at once. We even support sorting, which goes through all display
items anyway.  This patch introduces new %>(*) and %<(*), which are
supposed to be followed immediately by %(fieldname) (i.e. original
for-each-ref specifiers, not ones coming from pretty.c). They calculate
the best width for the %(fieldname), ignoring ansi escape sequences if
any.

[rr: documentation]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  7 +++++++
 builtin/for-each-ref.c             | 38 ++++++++++++++++++++++++++++++=
++++++++
 t/t6300-for-each-ref.sh            | 20 ++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index d8ad758..8cbc08c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -47,6 +47,10 @@ OPTIONS
 	are hex digits interpolates to character with hex code
 	`xx`; for example `%00` interpolates to `\0` (NUL),
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
++
+Placeholders `%<(*)` and `%>(*)` work like `%<(<N>)` and `%>(<N>)`
+respectively, except that the width of the next placeholder is
+calculated.
=20
 <pretty>::
 	A format string with supporting placeholders described in the
@@ -68,6 +72,9 @@ Caveats:
 3. Only the placeholders inherited from `<format>` will respect
    quoting settings.
=20
+3. Only the placeholders inherited from `<format>` will work with the
+   alignment placeholders `%<(*)` and '%>(*)`.
+
 <pattern>...::
 	If one or more patterns are given, only refs are shown that
 	match against at least one pattern, either using fnmatch(3) or
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 39454fb..da479d1 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "utf8.h"
=20
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -966,10 +967,30 @@ static void show_refs(struct refinfo **refs, int =
maxcount,
 }
=20
 struct format_one_atom_context {
+	struct refinfo **refs;
+	int maxcount;
+
 	struct refinfo *info;
 	int quote_style;
 };
=20
+static unsigned int get_atom_width(struct format_one_atom_context *ctx=
,
+				   const char *start, const char *end)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i, atom =3D parse_atom(start, end);
+	unsigned int len =3D 0, sb_len;
+	for (i =3D 0; i < ctx->maxcount; i++) {
+		print_value(&sb, ctx->refs[i], atom, ctx->quote_style);
+		sb_len =3D utf8_strnwidth(sb.buf, sb.len, 1);
+		if (sb_len > len)
+			len =3D sb_len;
+		strbuf_reset(&sb);
+	}
+	strbuf_release(&sb);
+	return len;
+}
+
 static size_t format_one_atom(struct strbuf *sb, const char *placehold=
er,
 			      void *format_context, void *user_data,
 			      struct strbuf *subst)
@@ -982,6 +1003,21 @@ static size_t format_one_atom(struct strbuf *sb, =
const char *placeholder,
 		return 1;
 	}
=20
+	/*
+	 * Substitute %>(*)%(atom) and friends with real width.
+	 */
+	if (*placeholder =3D=3D '>' || *placeholder =3D=3D '<') {
+		const char *star =3D placeholder + 1;
+		if (!prefixcmp(star, "(*)%(") &&
+		    ((ep =3D strchr(star + strlen("(*)%("), ')')) !=3D NULL)) {
+			star++;
+			strbuf_addf(subst, "%c(%u)",
+				    *placeholder,
+				    get_atom_width(ctx, star + strlen("*)%("), ep));
+			return 1 + strlen("(*)");
+		}
+	}
+
 	if (*placeholder !=3D '(')
 		return 0;
=20
@@ -1008,6 +1044,8 @@ static void show_pretty_refs(struct refinfo **ref=
s, int maxcount,
 	ctx.abbrev =3D DEFAULT_ABBREV;
 	ctx.format =3D format_one_atom;
 	ctx.user_data =3D &fctx;
+	fctx.refs =3D refs;
+	fctx.maxcount =3D maxcount;
 	fctx.quote_style =3D quote_style;
 	for (i =3D 0; i < maxcount; i++) {
 		struct commit *commit =3D NULL;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index d39e0b4..160018c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -196,6 +196,26 @@ test_pretty head '%<(20)%(committername) end' 'C O=
 Mitter           end'
 test_pretty head '%>(20)%(committername) end' '          C O Mitter en=
d'
 test_pretty head '%><(20)%(committername) end' '     C O Mitter      e=
nd'
=20
+test_expect_success '%<(*)%(refname) A' '
+	git for-each-ref --pretty=3D"%<(*)%(refname) A" >actual &&
+	cat >expected <<EOF &&
+refs/heads/master          A
+refs/remotes/origin/master A
+refs/tags/testtag          A
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success '%>(*)%(refname) A' '
+	git for-each-ref --pretty=3D"%>(*)%(refname) A" >actual &&
+	qz_to_tab_space >expected <<EOF &&
+Z        refs/heads/master A
+refs/remotes/origin/master A
+Z        refs/tags/testtag A
+EOF
+	test_cmp expected actual
+'
+
 test_pretty tag '%(refname)' refs/tags/testtag
 test_pretty tag '%(upstream)' ''
 test_pretty tag '%(objecttype)' tag
--=20
1.8.3.2.736.g869de25
