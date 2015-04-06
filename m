From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/25] list-files: add --[no-]column, -C and -1
Date: Mon,  6 Apr 2015 20:52:17 +0700
Message-ID: <1428328354-14897-9-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:53:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7T2-0005CD-HC
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbbDFNx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:53:28 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35343 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbbDFNx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:53:28 -0400
Received: by pddn5 with SMTP id n5so45245410pdd.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KrnwEDVdYSNTaH0pspfTJwbCcYlrEytFbjfYygnOBzw=;
        b=kfHz6TnqBlYvoQIA6gZ/SCXqwcaBO0gqMEyRAuHejZqy14MsR2b2VcKp5yxb0yAkFr
         J8/mnleToCb5u+M3pAbu7NXSJ0sKpi8tAuVF8mJ7s9AMPnLdZx72XTShiqjcnglbufFI
         OMsX0MPQx38BW6MPoLvvzKUwcezXexzXgR1YmGdZkZNda4vfxyu93QapekwnLQ54XPID
         b269LjsWSeUsB29Pd8lF+N4TRH308SD+isj/7RC2beHH0/25OqPzuDXWJPoET3fAlLGd
         MAazK87hVjb+o9q7FsCAXJl2TNaHAic7mIJSt3IeV2YbUoNBfrhtHWw5dL7u+gSS9KBT
         dALw==
X-Received: by 10.66.160.71 with SMTP id xi7mr27388489pab.19.1428328407528;
        Mon, 06 Apr 2015 06:53:27 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id jc9sm4769546pbd.54.2015.04.06.06.53.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:53:38 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266853>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 22 +++++++++++++++++++++-
 t/t7013-list-files.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index ec9ca17..8913770 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -4,6 +4,7 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "quote.h"
+#include "column.h"
=20
 enum item_type {
 	FROM_INDEX
@@ -26,6 +27,7 @@ static struct pathspec pathspec;
 static const char *prefix;
 static int prefix_length;
 static int show_tag =3D -1;
+static unsigned int colopts;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -34,6 +36,9 @@ static const char * const ls_usage[] =3D {
=20
 struct option ls_options[] =3D {
 	OPT_BOOL(0, "tag", &show_tag, N_("show tags")),
+	OPT_COLUMN('C', "column", &colopts, N_("show files in columns")),
+	OPT_SET_INT('1', NULL, &colopts,
+		    N_("shortcut for --no-column"), COL_PARSEOPT),
 	OPT_END()
 };
=20
@@ -114,6 +119,7 @@ static void quote_item(struct strbuf *out, const st=
ruct item *item)
 static void display(const struct item_list *result)
 {
 	struct strbuf quoted =3D STRBUF_INIT;
+	struct string_list s =3D STRING_LIST_INIT_DUP;
 	int i;
=20
 	if (!prefix_length)
@@ -129,13 +135,26 @@ static void display(const struct item_list *resul=
t)
 			strbuf_addch(&quoted, ' ');
 		}
 		quote_item(&quoted, item);
-		printf("%s\n", quoted.buf);
+		if (column_active(colopts))
+			string_list_append(&s, quoted.buf);
+		else
+			printf("%s\n", quoted.buf);
+	}
+
+	if (column_active(colopts)) {
+		struct column_options copts;
+		memset(&copts, 0, sizeof(copts));
+		copts.padding =3D 2;
+		print_columns(&s, colopts, &copts);
+		string_list_clear(&s, 0);
 	}
 	strbuf_release(&quoted);
 }
=20
 static int ls_config(const char *var, const char *value, void *cb)
 {
+	if (starts_with(var, "column."))
+		return git_column_config(var, value, "listfiles", &colopts);
 	return git_default_config(var, value, cb);
 }
=20
@@ -163,6 +182,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
 		       cmd_prefix, argv);
 	pathspec.max_depth =3D 0;
 	pathspec.recursive =3D 1;
+	finalize_colopts(&colopts, -1);
=20
 	refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED,
 		      &pathspec, NULL, NULL);
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index a5e555d..b43245c 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -23,6 +23,33 @@ test_expect_success 'list-files from index' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'column output' '
+	COLUMNS=3D20 git list-files --column=3Dalways >actual &&
+	cat >expected <<-\EOF &&
+	a        sa/a
+	b        sa/sb/b
+	c        sc/c
+	EOF
+	test_cmp expected actual &&
+	COLUMNS=3D20 git -c column.listfiles=3Dalways list-files >actual &&
+	cat >expected <<-\EOF &&
+	a        sa/a
+	b        sa/sb/b
+	c        sc/c
+	EOF
+	test_cmp expected actual &&
+	COLUMNS=3D20 git -c column.listfiles=3Dalways list-files -1 >actual &=
&
+	cat >expected <<-\EOF &&
+	a
+	b
+	c
+	sa/a
+	sa/sb/b
+	sc/c
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'list-files selectively from index' '
 	git list-files "*a" >actual &&
 	cat >expect <<-\EOF &&
--=20
2.3.0.rc1.137.g477eb31
