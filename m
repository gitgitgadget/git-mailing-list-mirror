From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 06/10] grep/pcre: prepare locale-dependent tables for icase matching
Date: Fri, 21 Aug 2015 19:47:16 +0700
Message-ID: <1440161240-28554-7-git-send-email-pclouds@gmail.com>
References: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
 <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 14:59:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSluX-0004C8-N6
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 14:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbbHUM7F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 08:59:05 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36475 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbbHUM7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 08:59:03 -0400
Received: by pawq9 with SMTP id q9so52524056paw.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LMowQcmcfh+76Cqjr/cIY5tM11Et+mt9/P26wWtr0e0=;
        b=BHBb5BExhAAq5AoekYSuxOexclJ2gVPb3FY7x+s0tOhDMsxeA042945o2JVdF53n/l
         yQsY3sV10pyTfU0oZQhsYaKpsf/2J3MbJYX41DyopvF8Xf91syrtK43wagfBJQk/4oea
         BdHfZ2aJfE2+zooDXVj9X/TtrzR6Vt3rlMXlNFTZ106EmyKs8+DSPFrV34ipeXDFkF2J
         btaogpWChy8GFg75XNnEuyKcK404hHdEV5+ofEo1JJKNE3uZsDI1Vbless7FJuDBthg5
         ysBf0Yz55oL+dfYzg9U09pgSgl4XgsciL61KLX0v1NzuB2c3oWpq39VDiNrJ+JCM4mtB
         F+MQ==
X-Received: by 10.66.186.39 with SMTP id fh7mr17062777pac.136.1440161942957;
        Fri, 21 Aug 2015 05:59:02 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id b11sm7778818pbu.80.2015.08.21.05.58.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 05:59:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Aug 2015 19:58:54 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276294>

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
