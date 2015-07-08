From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/9] grep/pcre: prepare locale-dependent tables for icase matching
Date: Wed,  8 Jul 2015 17:38:35 +0700
Message-ID: <1436351919-2520-6-git-send-email-pclouds@gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg, l.s.r@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 12:38:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCmkU-0006pu-0u
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934920AbbGHKig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 06:38:36 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33253 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933815AbbGHKid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 06:38:33 -0400
Received: by pacws9 with SMTP id ws9so131164630pac.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FibJrP3vL0suJ2St4fRalIZ/9VDgyV9vLmIB1IyHSXI=;
        b=V66COFCo5h/cQGUYU5j+y8C2iBH3JKdiX1o3wYZc1twWQTdVEPQN7gynName63Grat
         hfd0GoEQPNzFN9EYz0JkTpvAXVnISgHPcVFtMlAFsuxhiCINJNOi7SOdwcDsLQ8Nxs6r
         oA7wSzS6tP9epYHTegqVkDCfIinlLdYjlIQtSsTx5w0rhZ7tXcQqxL/zV2DnUru2JkO0
         XXcuPUoiQGLUd7Jpul+FEa2sWVgwEHr3Y5zxfJO1wzRJsg/xZyR2kB+KAuAjfZelgv2f
         gvr+1inL9QpMaMzoFIQU6rc3WXwFrFtp3BH6zx2/IH76LA2dZNEU1Y/qs1h09t4CFQFz
         q3BQ==
X-Received: by 10.70.49.73 with SMTP id s9mr18875748pdn.149.1436351912616;
        Wed, 08 Jul 2015 03:38:32 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id g2sm2065808pdh.11.2015.07.08.03.38.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 03:38:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 17:39:18 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273664>

The default tables are usually built with C locale and only suitable
for LANG=3DC or similar.  This should make case insensitive search work
correctly for all single-byte charsets.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                                   |  7 +++++--
 grep.h                                   |  1 +
 t/t7813-grep-icase-non-ascii.sh (new +x) | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 t/t7813-grep-icase-non-ascii.sh

diff --git a/grep.c b/grep.c
index 8fce54f..c79aa70 100644
--- a/grep.c
+++ b/grep.c
@@ -324,11 +324,13 @@ static void compile_pcre_regexp(struct grep_pat *=
p, const struct grep_opt *opt)
 	int erroffset;
 	int options =3D PCRE_MULTILINE;
=20
-	if (opt->ignore_case)
+	if (opt->ignore_case) {
+		p->pcre_tables =3D pcre_maketables();
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
@@ -362,6 +364,7 @@ static void free_pcre_regexp(struct grep_pat *p)
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
diff --git a/t/t7813-grep-icase-non-ascii.sh b/t/t7813-grep-icase-non-a=
scii.sh
new file mode 100755
index 0000000..efef7fb
--- /dev/null
+++ b/t/t7813-grep-icase-non-ascii.sh
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
