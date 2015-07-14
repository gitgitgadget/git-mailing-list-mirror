From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/9] grep/icase: avoid kwsset when -F is specified
Date: Tue, 14 Jul 2015 20:24:35 +0700
Message-ID: <1436880280-18194-5-git-send-email-pclouds@gmail.com>
References: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
 <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 15:24:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF0CE-0006Ql-2k
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 15:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbbGNNY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 09:24:26 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34511 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbbGNNYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 09:24:24 -0400
Received: by pdbep18 with SMTP id ep18so6284046pdb.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=x4vv8IW/e5yrHOTckHlbvGG6o5aIYy3CSxRguOL0WQo=;
        b=T9o7PzdpG70JSR7A0gWlgC5JX094h5QP/ceUgWXOnHVi5LKKL92nSK3rCvoksH+GP4
         oMx+QnP0XibyoR5e7nJAbtVmYLNwQ1HqsTkmE7GbKu6dCTYaMom8MNKfy/0EdhbQ68JX
         i+W/BhZIDR+O47IK27mjPv6zDf1NN0AdToBQhoNG3Q4CLlqNpGfYpaGt69v6Bb//fUUO
         +NkMbzkimyveM94XA2KjYPOuSwd1hJJTKIcH18jHspmaA9uBkmbsuHzqqGmGqz2Vko5g
         Ic9n9ORUg885PdqulIunivWXKUks0Z0ATj036MaYplORYSyEiN6sBuqH//G4XsAJ+Xhb
         IKKQ==
X-Received: by 10.68.194.137 with SMTP id hw9mr80374606pbc.139.1436880264398;
        Tue, 14 Jul 2015 06:24:24 -0700 (PDT)
Received: from lanh ([115.73.59.196])
        by smtp.gmail.com with ESMTPSA id pa1sm1397025pdb.73.2015.07.14.06.24.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:24:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 14 Jul 2015 20:25:15 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273956>

Similar to the previous commit, we can't use kws on icase search
outside ascii range. But we can't simply pass the pattern to
regcomp/pcre like the previous commit because it may contain regex
special characters, so we need to quote the regex first.

To avoid misquote traps that could lead to undefined behavior, we
always stick to basic regex engine in this case. We don't need fancy
features for grepping a literal string anyway.

basic_regex_quote_buf() assumes that if the pattern is in a multibyte
encoding, ascii chars must be unambiguously encoded as single
bytes. This is true at least for UTF-8. For others, let's wait until
people yell up. Chances are nobody uses multibyte, non utf-8 charsets
any more..

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                          | 25 ++++++++++++++++++++++++-
 quote.c                         | 37 +++++++++++++++++++++++++++++++++=
++++
 quote.h                         |  1 +
 t/t7812-grep-icase-non-ascii.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index d795b0e..8fce54f 100644
--- a/grep.c
+++ b/grep.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "commit.h"
+#include "quote.h"
=20
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -397,6 +398,24 @@ static int is_fixed(const char *s, size_t len)
 	return 1;
 }
=20
+static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *=
opt)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int err;
+
+	basic_regex_quote_buf(&sb, p->pattern);
+	err =3D regcomp(&p->regexp, sb.buf, opt->regflags & ~REG_EXTENDED);
+	if (opt->debug)
+		fprintf(stderr, "fixed%s\n", sb.buf);
+	strbuf_release(&sb);
+	if (err) {
+		char errbuf[1024];
+		regerror(err, &p->regexp, errbuf, 1024);
+		regfree(&p->regexp);
+		compile_regexp_failed(p, errbuf);
+	}
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int icase_non_ascii;
@@ -411,7 +430,11 @@ static void compile_regexp(struct grep_pat *p, str=
uct grep_opt *opt)
 	if (!icase_non_ascii && is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
 	else if (opt->fixed) {
-		p->fixed =3D 1;
+		p->fixed =3D !icase_non_ascii;
+		if (!p->fixed) {
+			compile_fixed_regexp(p, opt);
+			return;
+		}
 	} else
 		p->fixed =3D 0;
=20
diff --git a/quote.c b/quote.c
index 7920e18..43a8057 100644
--- a/quote.c
+++ b/quote.c
@@ -439,3 +439,40 @@ void tcl_quote_buf(struct strbuf *sb, const char *=
src)
 	}
 	strbuf_addch(sb, '"');
 }
+
+void basic_regex_quote_buf(struct strbuf *sb, const char *src)
+{
+	char c;
+
+	if (*src =3D=3D '^') {
+		/* only beginning '^' is special and needs quoting */
+		strbuf_addch(sb, '\\');
+		strbuf_addch(sb, *src++);
+	}
+	if (*src =3D=3D '*')
+		/* beginning '*' is not special, no quoting */
+		strbuf_addch(sb, *src++);
+
+	while ((c =3D *src++)) {
+		switch (c) {
+		case '[':
+		case '.':
+		case '\\':
+		case '*':
+			strbuf_addch(sb, '\\');
+			strbuf_addch(sb, c);
+			break;
+
+		case '$':
+			/* only the end '$' is special and needs quoting */
+			if (*src =3D=3D '\0')
+				strbuf_addch(sb, '\\');
+			strbuf_addch(sb, c);
+			break;
+
+		default:
+			strbuf_addch(sb, c);
+			break;
+		}
+	}
+}
diff --git a/quote.h b/quote.h
index 99e04d3..362d315 100644
--- a/quote.h
+++ b/quote.h
@@ -67,5 +67,6 @@ extern char *quote_path_relative(const char *in, cons=
t char *prefix,
 extern void perl_quote_buf(struct strbuf *sb, const char *src);
 extern void python_quote_buf(struct strbuf *sb, const char *src);
 extern void tcl_quote_buf(struct strbuf *sb, const char *src);
+extern void basic_regex_quote_buf(struct strbuf *sb, const char *src);
=20
 #endif
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index 63a2630..c945589 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -16,4 +16,30 @@ test_expect_success GETTEXT_LOCALE 'grep literal str=
ing, no -F' '
 	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
 '
=20
+test_expect_success GETTEXT_LOCALE 'grep literal string, with -F' '
+	git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/null=
 |
+		 grep fixed >debug1 &&
+	echo "fixedTILRAUN: Hall=C3=B3 Heimur!" >expect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "TILRAUN: HALL=C3=93 HEIMUR!"  2>&1 >/dev/null=
 |
+		 grep fixed >debug2 &&
+	echo "fixedTILRAUN: HALL=C3=93 HEIMUR!" >expect2 &&
+	test_cmp expect2 debug2
+'
+
+test_expect_success GETTEXT_LOCALE 'grep string with regex, with -F' '
+	printf "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" >file &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" 2>&=
1 >/dev/null |
+		 grep fixed >debug1 &&
+	echo "fixed\\^*TILR^AUN:\\.\\* \\\\Hall=C3=B3 \$He\\[]imur!\\\$" >exp=
ect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\HALL=C3=93 \$HE[]IMUR!\$"  2>=
&1 >/dev/null |
+		 grep fixed >debug2 &&
+	echo "fixed\\^*TILR^AUN:\\.\\* \\\\HALL=C3=93 \$HE\\[]IMUR!\\\$" >exp=
ect2 &&
+	test_cmp expect2 debug2
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
