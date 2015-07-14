From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 9/9] diffcore-pickaxe: support case insensitive match on non-ascii
Date: Tue, 14 Jul 2015 20:24:40 +0700
Message-ID: <1436880280-18194-10-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Jul 14 15:25:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF0Cs-0006gQ-6B
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 15:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbbGNNZD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 09:25:03 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36281 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbbGNNZC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 09:25:02 -0400
Received: by pachj5 with SMTP id hj5so5870381pac.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GojoApo23X1iDkZx4tI5kK/baCVP3C1B1Lvs5vMWeBs=;
        b=ocjPyYHCEVzuZUGS7W7Q5nyY9d44ErGGweiWRPfBtnQwNvaCmxYAJ5nDQ7f1fcTh4l
         bjNUVi6hgXlHJ5hvIp3VlXXWQPI9clCA9YlIaVlrtkom5k/B9KQnos1xf0gKp4PErxWt
         xiLfCCRogss3VXR/LkVpH2fO5Yq/H+JzK4f5dkdtZwH/dg6NXV5vp9AcAW5AuJbsdAKC
         ghogWVF4s/P+HL4KfeHEfO3Gl1cpERIJSu93rIRycVY78+ymbxeDuaX4y2K6+02Po18i
         nip9FAAYj0wkfvyjsacxHcb/FAlr332e8bNXLQm0mbd6FwdXNHduah1GqGa93h+QSOff
         QZTA==
X-Received: by 10.66.157.167 with SMTP id wn7mr80071582pab.119.1436880301228;
        Tue, 14 Jul 2015 06:25:01 -0700 (PDT)
Received: from lanh ([115.73.59.196])
        by smtp.gmail.com with ESMTPSA id fq2sm1430650pdb.35.2015.07.14.06.24.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:25:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 14 Jul 2015 20:25:52 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273961>

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
index e861a15..d07fa20 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -57,4 +57,11 @@ test_expect_success GETTEXT_LOCALE 'grep string with=
 regex, with -F' '
 	test_cmp expect2 debug2
 '
=20
+test_expect_success GETTEXT_LOCALE 'pickaxe -i on non-ascii' '
+	git commit -m first &&
+	git log --format=3D%f -i -S"TILRAUN: HALL=C3=93 HEIMUR!" >actual &&
+	echo first >expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
