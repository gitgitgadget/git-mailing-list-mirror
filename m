From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/16] list-files: add --[no-]column, -C and -1
Date: Mon,  9 Mar 2015 17:18:23 +0700
Message-ID: <1425896314-10941-6-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:19:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUumX-0001mF-2S
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbbCIKT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:19:26 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:44516 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbbCIKTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:19:23 -0400
Received: by pdjz10 with SMTP id z10so42979943pdj.11
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=d9pYTJF7krWg98vgIfL7um0RewbDQ2tzxUH1cDyYkJE=;
        b=ouM+JE/Peqj57SmU7GoUGNsAT8ZgmaSDGLHEItp6oThrl954W59zQPeilzwYAPsM6d
         FUE7aX6uFi3C5/l3uaw1FNuiAvDR9Jt/gnv0Cj1yV6vBTtjk/L9IQGZY2nuQyRNCLM40
         TtGtxYfXN2Fdz2DtBYXvUqKgwbr66ZUNGXiZF8Um40Ch1299Ho8ED+bOUBnRPsosO0e0
         bebuOkv3EMerfesG32kyUbO1ljX35xVyXfEUf0b0DA33Ceg/Ch0+cqqV5LX9yAq6ryEN
         iJyZfFMCiIlnUY0eL6j86QKLjAb6WZdnWLhf40tSJl2C8Ee3t6rd1ro5hwElEyfi4pUs
         aekg==
X-Received: by 10.70.92.68 with SMTP id ck4mr51978173pdb.3.1425896362556;
        Mon, 09 Mar 2015 03:19:22 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id xx7sm18549133pab.21.2015.03.09.03.19.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:19:18 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265145>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 18af65c..95a2e19 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -4,10 +4,12 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "quote.h"
+#include "column.h"
=20
 static struct pathspec pathspec;
 static const char *prefix;
 static int prefix_length;
+static unsigned int colopts;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -15,6 +17,9 @@ static const char * const ls_usage[] =3D {
 };
=20
 struct option ls_options[] =3D {
+	OPT_COLUMN('C', "column", &colopts, N_("show files in columns")),
+	OPT_SET_INT('1', NULL, &colopts,
+		    N_("shortcut for --no-column"), COL_PARSEOPT),
 	OPT_END()
 };
=20
@@ -85,6 +90,14 @@ static void display(const struct string_list *result=
)
 {
 	int i;
=20
+	if (column_active(colopts)) {
+		struct column_options copts;
+		memset(&copts, 0, sizeof(copts));
+		copts.padding =3D 2;
+		print_columns(result, colopts, &copts);
+		return;
+	}
+
 	for (i =3D 0; i < result->nr; i++) {
 		const struct string_list_item *s =3D result->items + i;
=20
@@ -94,6 +107,8 @@ static void display(const struct string_list *result=
)
=20
 static int ls_config(const char *var, const char *value, void *cb)
 {
+	if (starts_with(var, "column."))
+		return git_column_config(var, value, "listfiles", &colopts);
 	return git_default_config(var, value, cb);
 }
=20
@@ -123,6 +138,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
 		       cmd_prefix, argv);
 	pathspec.max_depth =3D 0;
 	pathspec.recursive =3D 1;
+	finalize_colopts(&colopts, -1);
=20
 	refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED,
 		      &pathspec, NULL, NULL);
--=20
2.3.0.rc1.137.g477eb31
