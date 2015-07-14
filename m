From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 7/9] grep/pcre: support utf-8
Date: Tue, 14 Jul 2015 20:24:38 +0700
Message-ID: <1436880280-18194-8-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Jul 14 15:24:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF0CZ-0006ZJ-Pc
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 15:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbbGNNYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 09:24:47 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36280 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbGNNYq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 09:24:46 -0400
Received: by pdjr16 with SMTP id r16so6049604pdj.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1Ax6c9se1M5yc19pe9d/bLnnhaYQXAl1nsEM5M/RbQM=;
        b=wAfXUUJYhL61wEdwrlrTBNYU4+sCVWZ6TXr2iyFTg7i9ddwYQHrP32LR68mIu7gDNr
         Nzl1nn5bVlj3TVRQuKxGx+QdvYm1Tkm09Hm9JCSIXHX4RYPHegBDbRF44d5TtU7Jnjf+
         8lmCo2keR2vQtl8eSw6NJ6HY/AuHnfVVXtW2czW8WDPtdxrU7VcJ4ZAUzb4yZ7T5AZAz
         y5hUhdHohpkQB0isqPYinTwgQL1LcQ1Q84YzrOzqTDMP5pIgrC2nAYkmQ25B3+bmE0NP
         CH0pyIYi/9dnbq12JJPazDWO0yJF36P6w7vwhM9jZi90bzc8cgj+qXq/s76ozqRNnp1L
         n8YA==
X-Received: by 10.68.105.162 with SMTP id gn2mr24330662pbb.158.1436880286399;
        Tue, 14 Jul 2015 06:24:46 -0700 (PDT)
Received: from lanh ([115.73.59.196])
        by smtp.gmail.com with ESMTPSA id fc3sm1432785pab.16.2015.07.14.06.24.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:24:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 14 Jul 2015 20:25:37 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273959>

In the previous change in this function, we add locale support for
single-byte encodings only. It looks like pcre only supports utf-* as
multibyte encodings, the others are left in the cold (which is
fine).

We need to enable PCRE_UTF8 so pcre can find character boundary
correctly. It's needed for case folding (when --ignore-case is used)
or '*', '+' or similar syntax is used.

The "has_non_ascii()" check is to be on the conservative side. If
there's non-ascii in the pattern, the searched content could still be
in utf-8, but we can treat it just like a byte stream and everything
should work. If we force utf-8 based on locale only and pcre validates
utf-8 and the file content is in non-utf8 encoding, things break.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                          |  2 ++
 t/t7812-grep-icase-non-ascii.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/grep.c b/grep.c
index f0fbf99..07621c1 100644
--- a/grep.c
+++ b/grep.c
@@ -329,6 +329,8 @@ static void compile_pcre_regexp(struct grep_pat *p,=
 const struct grep_opt *opt)
 			p->pcre_tables =3D pcre_maketables();
 		options |=3D PCRE_CASELESS;
 	}
+	if (is_utf8_locale() && has_non_ascii(p->pattern))
+		options |=3D PCRE_UTF8;
=20
 	p->pcre_regexp =3D pcre_compile(p->pattern, options, &error, &erroffs=
et,
 				      p->pcre_tables);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index c945589..e861a15 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -16,6 +16,21 @@ test_expect_success GETTEXT_LOCALE 'grep literal str=
ing, no -F' '
 	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
 '
=20
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 icase' '
+	git grep --perl-regexp    "TILRAUN: H.ll=C3=B3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.ll=C3=B3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.LL=C3=93 HEIMUR!"
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 string wit=
h "+"' '
+	printf "TILRAUN: Hall=C3=B3=C3=B3 Heimur!" >file2 &&
+	git add file2 &&
+	git grep -l --perl-regexp "TILRAUN: H.ll=C3=B3+ Heimur!" >actual &&
+	echo file >expected &&
+	echo file2 >>expected &&
+	test_cmp expected actual
+'
+
 test_expect_success GETTEXT_LOCALE 'grep literal string, with -F' '
 	git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/null=
 |
 		 grep fixed >debug1 &&
--=20
2.3.0.rc1.137.g477eb31
