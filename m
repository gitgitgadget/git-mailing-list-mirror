From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 15/15] for-each-ref: use get_pretty_userformat in --pretty
Date: Sun,  9 Jun 2013 23:24:34 +0530
Message-ID: <1370800474-8940-16-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljrm-0006hW-7K
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab3FIR5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:57:15 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64548 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab3FIR5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:57:12 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so718087pdj.10
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5kiOiGFNS35O0VBr6yXpS67V/Q54uEbG+yZdkOyJ3co=;
        b=hmlb6UmL/WsnEMx6UVkjE8b93DstFGs5aVyt8Y0ATL9ilPXqhhgnRb5PtzWi27K4UJ
         Xat/iIsPlN+pqjbAVn9CdlIboHGHjoczwSyZitETt4p4vPvETtEXNmkNm9naYTKchdeu
         hdoFKwMAd+fC/t7UjmBKhsMAan02MV68RgAzzdSym21Q/Su/XbaZRxqL9xCfby5KkoUn
         v1GhIVbw5EiRz/ftRogCYgDvkTTdRDHSJdLSyGep50i8ybCcMiifVE6btn0eFBHK9+9V
         5Dr0mreokHSDkKnV4IgNmMZsmSwF+iT9dFWfxUOwR/3H4G/OpPTJjaGAO4LNj9aizLa7
         xjpQ==
X-Received: by 10.68.59.98 with SMTP id y2mr6855455pbq.135.1370800631680;
        Sun, 09 Jun 2013 10:57:11 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.57.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:57:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227066>

Use get_pretty_userformat() to interpret the --pretty string.  This
means that you can now reference a format specified in a pretty.*
configuration variable as an argument to 'git for-each-ref --pretty=3D'=
=2E
There are two caveats:

1. A leading "format:" or "tformat:" is automatically stripped and
   ignored.  Separator semantics are not configurable (yet).

2. No built-in formats are available.  The ones specified in
   pretty-formats (oneline, short etc) don't make sense when displaying
   refs anyway.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-for-each-ref.txt |  3 +++
 builtin/for-each-ref.c             | 16 +++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index d666ebd..ef39f2a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -60,6 +60,9 @@ calculated.
 +
 Caveats:
=20
+0. No built-in formats from PRETTY FORMATS (like oneline, short) are
+   available.
+
 1. Many of the placeholders in "PRETTY FORMATS" are designed to work
    specifically on commit objects: when non-commit objects are
    supplied, those placeholders won't work (i.e. they will be emitted
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 25764aa..ed7bd7d 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1151,7 +1151,7 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 	int num_refs;
 	const char *default_format =3D "%(objectname) %(objecttype)\t%(refnam=
e)";
 	const char *format =3D default_format;
-	const char *pretty =3D NULL;
+	const char *pretty_raw =3D NULL, *pretty_userformat =3D NULL;
 	struct ref_sort *sort =3D NULL, **sort_tail =3D &sort;
 	int maxcount =3D 0, quote_style =3D 0;
 	struct refinfo **refs;
@@ -1170,13 +1170,15 @@ int cmd_for_each_ref(int argc, const char **arg=
v, const char *prefix)
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs"=
)),
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use =
for the output")),
-		OPT_STRING(  0 , "pretty", &pretty, N_("format"), N_("alternative fo=
rmat to use for the output")),
+		OPT_STRING(  0 , "pretty", &pretty_raw, N_("format"), N_("alternativ=
e format to use for the output")),
 		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
 			    N_("field name to sort on"), &opt_parse_sort),
 		OPT_END(),
 	};
=20
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
+	if (pretty_raw)
+		pretty_userformat =3D get_pretty_userformat(pretty_raw);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
 		usage_with_options(for_each_ref_usage, opts);
@@ -1185,10 +1187,10 @@ int cmd_for_each_ref(int argc, const char **arg=
v, const char *prefix)
 		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
-	if (format !=3D default_format && pretty)
+	if (format !=3D default_format && pretty_userformat)
 		die("--format and --pretty cannot be used together");
-	if ((pretty && verify_format(pretty, 1)) ||
-	    (!pretty && verify_format(format, 0)))
+	if ((pretty_userformat && verify_format(pretty_userformat, 1)) ||
+	    (!pretty_userformat && verify_format(format, 0)))
 		usage_with_options(for_each_ref_usage, opts);
=20
 	if (!sort)
@@ -1209,8 +1211,8 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 	if (!maxcount || num_refs < maxcount)
 		maxcount =3D num_refs;
=20
-	if (pretty)
-		show_pretty_refs(refs, maxcount, pretty, quote_style);
+	if (pretty_userformat)
+		show_pretty_refs(refs, maxcount, pretty_userformat, quote_style);
 	else
 		show_refs(refs, maxcount, format, quote_style);
 	return 0;
--=20
1.8.3.247.g485169c
