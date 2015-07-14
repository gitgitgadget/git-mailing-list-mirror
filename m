From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 5/9] grep/pcre: prepare locale-dependent tables for icase matching
Date: Tue, 14 Jul 2015 20:24:36 +0700
Message-ID: <1436880280-18194-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Jul 14 15:24:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF0CK-0006T5-AD
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 15:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbbGNNYc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 09:24:32 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34991 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbbGNNYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 09:24:31 -0400
Received: by pdrg1 with SMTP id g1so6032186pdr.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LMowQcmcfh+76Cqjr/cIY5tM11Et+mt9/P26wWtr0e0=;
        b=WPTP0Cd8DUv0qGhuYbMjukX55BItGqNfbD5BMs0V8moTCwR8z+2bfa8qgM5lO4efqk
         5VhGe6tUZtaLz5XJe4RD3UTg677nCNgwtcEuz6VAH+d5X6S0uzC0pUoST7VDup+zqoEp
         9HuERrZzzQMjDU4tx7tDpQe4R2esRo8U+sYnJsRv3/oPzWlzbI9cxYb0y4jcmWWnfc2L
         06tm3fWr73AyZ0+vUZrR9GxkHMr4lzW8XrnBaFCx5hkFmyLJ/uxeu0fg6PuLrRiphbHW
         3JE9FfbXIHj4ZoSwfm8M/nQtlF+Y8MUuXZZY8YirbBVwfpxo039AJqXn4NT3UYVVgUnJ
         Uqgg==
X-Received: by 10.70.128.204 with SMTP id nq12mr31462856pdb.34.1436880270945;
        Tue, 14 Jul 2015 06:24:30 -0700 (PDT)
Received: from lanh ([115.73.59.196])
        by smtp.gmail.com with ESMTPSA id p1sm1455531pdb.3.2015.07.14.06.24.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:24:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 14 Jul 2015 20:25:22 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273957>

The default tables are usually built with C locale and only suitable
for LANG=3DC or similar.  This should make case insensitive search work
correctly for all single-byte charsets.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                             |  8 ++++++--
 grep.h                             |  1 +
 t/t7813-grep-icase-iso.sh (new +x) | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100755 t/t7813-grep-icase-iso.sh

diff --git a/grep.c b/grep.c
index 8fce54f..f0fbf99 100644
--- a/grep.c
+++ b/grep.c
@@ -324,11 +324,14 @@ static void compile_pcre_regexp(struct grep_pat *=
p, const struct grep_opt *opt)
 	int erroffset;
 	int options =3D PCRE_MULTILINE;
=20
-	if (opt->ignore_case)
+	if (opt->ignore_case) {
+		if (has_non_ascii(p->pattern))
+			p->pcre_tables =3D pcre_maketables();
 		options |=3D PCRE_CASELESS;
+	}
=20
 	p->pcre_regexp =3D pcre_compile(p->pattern, options, &error, &erroffs=
et,
-			NULL);
+				      p->pcre_tables);
 	if (!p->pcre_regexp)
 		compile_regexp_failed(p, error);
=20
@@ -362,6 +365,7 @@ static void free_pcre_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre_regexp);
 	pcre_free(p->pcre_extra_info);
+	pcre_free((void *)p->pcre_tables);
 }
 #else /* !USE_LIBPCRE */
 static void compile_pcre_regexp(struct grep_pat *p, const struct grep_=
opt *opt)
diff --git a/grep.h b/grep.h
index 95f197a..cee4357 100644
--- a/grep.h
+++ b/grep.h
@@ -48,6 +48,7 @@ struct grep_pat {
 	regex_t regexp;
 	pcre *pcre_regexp;
 	pcre_extra *pcre_extra_info;
+	const unsigned char *pcre_tables;
 	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
diff --git a/t/t7813-grep-icase-iso.sh b/t/t7813-grep-icase-iso.sh
new file mode 100755
index 0000000..efef7fb
--- /dev/null
+++ b/t/t7813-grep-icase-iso.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description=3D'grep icase on non-English locales'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_ISO_LOCALE 'setup' '
+	printf "TILRAUN: Hall=F3 Heimur!" >file &&
+	git add file &&
+	LC_ALL=3D"$is_IS_iso_locale" &&
+	export LC_ALL
+'
+
+test_expect_success GETTEXT_ISO_LOCALE,LIBPCRE 'grep pcre string' '
+	git grep --perl-regexp -i "TILRAUN: H.ll=F3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.LL=D3 HEIMUR!"
+'
+
+test_done
--=20
2.3.0.rc1.137.g477eb31
