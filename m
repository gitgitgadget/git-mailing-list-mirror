From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 10/10] diffcore-pickaxe: support case insensitive match on non-ascii
Date: Fri, 21 Aug 2015 19:47:20 +0700
Message-ID: <1440161240-28554-11-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Aug 21 14:59:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSlux-0004Pi-RP
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 14:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbbHUM70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 08:59:26 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35924 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbbHUM70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 08:59:26 -0400
Received: by pdbmi9 with SMTP id mi9so26550223pdb.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=86fjsLlNhEiLEpR3mLvJAzt5B0WAElCypjHXw1AiMTM=;
        b=ej4+87FjjPjahiQS33Uw/c6aZ54mRcZccJRhscOfAyarPb9HvbHq9pX6T/ZmnnPE8H
         El9vnpwrGk5klgsD11UhdCuOBYtapXc2B7g9z4LGexSJdRGIprHUOhD4MG65bmrj5Q9X
         0fF/fLK3k7L1nB6l2nzi9ZMnJs8EjkC18Qpj6+njjRB0TWtGCqFFBlj0sElRb0TaSZuw
         l7wEGYhHSQAgvSAATx8u8RB3cn5Il8M5457k+EkFeVntQmaOon2RjdfnHk50udgdoLrM
         Kmdqry27zv4vA/D2KTnb1JLZ+htCMyub8zufZlAVZQp3zNCCUQOhnn4lfov86kqVx+9n
         ZNjg==
X-Received: by 10.70.20.5 with SMTP id j5mr17175954pde.40.1440161965768;
        Fri, 21 Aug 2015 05:59:25 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id fe8sm7833664pab.40.2015.08.21.05.59.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 05:59:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Aug 2015 19:59:22 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276298>

Similar to the "grep -F -i" case, we can't use kws on icase search
outside ascii range, so we quote the string and pass it to regcomp as
a basic regexp and let regex engine deal with case sensitivity.

The new test is put in t7812 instead of t4209-log-pickaxe because
lib-gettext.sh might cause problems elsewhere, probably..

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diffcore-pickaxe.c              | 11 +++++++++++
 t/t7812-grep-icase-non-ascii.sh |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 7a718fc..6946c15 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -7,6 +7,8 @@
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
+#include "commit.h"
+#include "quote.h"
=20
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
@@ -212,6 +214,15 @@ void diffcore_pickaxe(struct diff_options *o)
 			cflags |=3D REG_ICASE;
 		err =3D regcomp(&regex, needle, cflags);
 		regexp =3D &regex;
+	} else if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE) &&
+		   has_non_ascii(needle)) {
+		struct strbuf sb =3D STRBUF_INIT;
+		int cflags =3D REG_NEWLINE | REG_ICASE;
+
+		basic_regex_quote_buf(&sb, needle);
+		err =3D regcomp(&regex, sb.buf, cflags);
+		strbuf_release(&sb);
+		regexp =3D &regex;
 	} else {
 		kws =3D kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
 			       ? tolower_trans_tbl : NULL);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index 8896410..a5475bb 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -61,4 +61,11 @@ test_expect_success REGEX_LOCALE 'grep string with r=
egex, with -F' '
 	test_cmp expect2 debug2
 '
=20
+test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
+	git commit -m first &&
+	git log --format=3D%f -i -S"TILRAUN: HALL=C3=93 HEIMUR!" >actual &&
+	echo first >expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
