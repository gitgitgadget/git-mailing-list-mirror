From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/15] for-each-ref: introduce format specifier %>(*) and %<(*)
Date: Tue,  4 Jun 2013 18:05:32 +0530
Message-ID: <1370349337-20938-11-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRg-00078F-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab3FDMeV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 08:34:21 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:40068 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab3FDMeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:19 -0400
Received: by mail-pd0-f181.google.com with SMTP id bv13so171979pdb.26
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=e9k1K3tyLfdlfXPcV3qk8Ej2Os84ynNdIWN0HT1iaas=;
        b=VqGb6GLavZCKX548UxeRgCbAHjQbysgs6gqsyS+iUJWD8+mTsisRCQ5vjcYbUn9tjz
         vctIcwYcrWPmSxnBCUXyGQnn7k8L9sabi2kOsfQ9y7ay+q2L05sGc6KcHIXm82uss9TZ
         Ux2U1+gJ9poC/VFQM/nTpx2xZVd1V8CSRYYL+AEDqXy8oxaTMJKmobaEJT0JsB4ThCK6
         wA5v+xy3Uc0Xf/FK4r+ddgi8URhOI2VSlsj91TujK+0d6QE8ldV+F1VjDpRJ8vxDKxhf
         b/CNqw8v96w55WSA2Mab+cuxcm5x4DI18LzeRwWdpg8nGf9iVlQlknOnMY/33d0ZYw0K
         jygw==
X-Received: by 10.68.185.194 with SMTP id fe2mr27284119pbc.45.1370349258879;
        Tue, 04 Jun 2013 05:34:18 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226352>

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

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  7 +++++++
 builtin/for-each-ref.c             | 38 ++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index 6135812..7d6db7f 100644
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
@@ -67,6 +71,9 @@ Caveats:
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
index f8a3880..053a622 100644
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
@@ -1003,6 +1039,8 @@ static void show_pretty_refs(struct refinfo **ref=
s, int maxcount,
=20
 	ctx.format =3D format_one_atom;
 	ctx.user_data =3D &fctx;
+	fctx.refs =3D refs;
+	fctx.maxcount =3D maxcount;
 	fctx.quote_style =3D quote_style;
 	for (i =3D 0; i < maxcount; i++) {
 		struct commit *commit =3D NULL;
--=20
1.8.3.GIT
