From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/9] grep/icase: avoid kwsset on literal non-ascii strings
Date: Tue, 14 Jul 2015 20:24:34 +0700
Message-ID: <1436880280-18194-4-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Jul 14 15:24:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF0C6-0006Nu-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 15:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbbGNNYS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 09:24:18 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34437 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbbGNNYR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 09:24:17 -0400
Received: by pdbep18 with SMTP id ep18so6282395pdb.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fgMWL6Xzs70T184i73kO3RaDo9zcoAggtfh+5VVoNU8=;
        b=OBs2bAFbnqjdIzrKrRnna5IYo9TjV/oI67i3Dwglocwzg2dXPuq/yqawKkjDj3ZuFn
         NA5x5+3hU2yOW2wryP/4oyKSTb/2FAUm08PkBVGvPEDAud5QbfkLjWLven2cOGv/jZ86
         P4jdHa8vyEVlx1SGlxIiAj5G6HmaBzITLeDLr5ML/l8xeCQX2FDAYGSL/lBuKwC/XCy6
         zzQJoygYmUKWc7oxKloKJkKjiVdFtEGKzM64Id9dxOi3cgB6PDga/2aRlqa7JXaU7OYB
         MGVkkDIZuQsGa7ASLOwyAEiAkqmUBSRNhfjaO85GzGYqCuWtmMjvpcJyw5oBvIopjWmb
         DoeA==
X-Received: by 10.70.62.66 with SMTP id w2mr79921756pdr.106.1436880256761;
        Tue, 14 Jul 2015 06:24:16 -0700 (PDT)
Received: from lanh ([115.73.59.196])
        by smtp.gmail.com with ESMTPSA id dp1sm1404932pbb.53.2015.07.14.06.24.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:24:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 14 Jul 2015 20:25:08 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273955>

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
