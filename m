From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/9] grep/icase: avoid kwsset on literal non-ascii strings
Date: Wed,  8 Jul 2015 17:38:33 +0700
Message-ID: <1436351919-2520-4-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 08 12:38:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCmkL-0006kN-3t
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934918AbbGHKiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 06:38:23 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36053 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934356AbbGHKiU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 06:38:20 -0400
Received: by pddu5 with SMTP id u5so56201356pdd.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fgMWL6Xzs70T184i73kO3RaDo9zcoAggtfh+5VVoNU8=;
        b=s4Fhodg8y1EHiLcI3j8qnliLClJr61Z4D+Jk6jllBx+Yl/boS7SmxhnSmdtl+mXl3E
         pBfgi9tOie3yplQMRBP8Howc+sqJNTXfXOntW/qLh5GyE1AuDZBS4RechA0SOPcfxgAJ
         5JDLMGC+VTH2MbckC31LKnqo8uNlFyd3fW9VE3xVfFyi7gXFTRNZeP0pyadCLfoQ+eIR
         LNKKEOVdGJbLYwOWOc/LuJxC8FS3Vo8J9x2bDlhlLvp+ZYoczwPV45i9O8N4Pa2gFV6i
         4GfWoe5wbL/BbVB7TLNf1oWuFM7UvMPQ+CoZQrr8tG5c1BgpdrxuPTmVsDMZ6mWhiM8p
         vRAQ==
X-Received: by 10.66.150.196 with SMTP id uk4mr19318063pab.54.1436351900456;
        Wed, 08 Jul 2015 03:38:20 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id cc5sm2053727pac.24.2015.07.08.03.38.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 03:38:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 17:39:06 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273662>

When we detect the pattern is just a literal string, we avoid heavy
regex engine and use fast substring search implemented in kwsset.c.
But kws uses git-ctype which is locale-independent so it does not know
how to fold case properly outside ascii range. Let regcomp or pcre
take care of this case instead. Slower, but accurate.

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                                   |  7 ++++++-
 t/t7812-grep-icase-non-ascii.sh (new +x) | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh

diff --git a/grep.c b/grep.c
index bd32f66..d795b0e 100644
--- a/grep.c
+++ b/grep.c
@@ -4,6 +4,7 @@
 #include "xdiff-interface.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "commit.h"
=20
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -398,12 +399,16 @@ static int is_fixed(const char *s, size_t len)
=20
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
+	int icase_non_ascii;
 	int err;
=20
 	p->word_regexp =3D opt->word_regexp;
 	p->ignore_case =3D opt->ignore_case;
+	icase_non_ascii =3D
+		(opt->regflags & REG_ICASE || p->ignore_case) &&
+		has_non_ascii(p->pattern);
=20
-	if (is_fixed(p->pattern, p->patternlen))
+	if (!icase_non_ascii && is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
 	else if (opt->fixed) {
 		p->fixed =3D 1;
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
new file mode 100755
index 0000000..63a2630
--- /dev/null
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description=3D'grep icase on non-English locales'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_LOCALE 'setup' '
+	printf "TILRAUN: Hall=C3=B3 Heimur!" >file &&
+	git add file &&
+	LC_ALL=3D"$is_IS_locale" &&
+	export LC_ALL
+'
+
+test_expect_success GETTEXT_LOCALE 'grep literal string, no -F' '
+	git grep -i "TILRAUN: Hall=C3=B3 Heimur!" &&
+	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
+'
+
+test_done
--=20
2.3.0.rc1.137.g477eb31
