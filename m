From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 03/10] column: add columnar layout
Date: Tue, 28 Feb 2012 18:58:44 +0700
Message-ID: <1330430331-19945-4-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 12:59:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Li7-0005Hi-3O
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 12:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965466Ab2B1L7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 06:59:09 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53635 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965344Ab2B1L7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 06:59:08 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so2265513dae.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 03:59:07 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.219.234 as permitted sender) client-ip=10.68.219.234;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.219.234 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.219.234])
        by 10.68.219.234 with SMTP id pr10mr53243738pbc.11.1330430347960 (num_hops = 1);
        Tue, 28 Feb 2012 03:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HTciqp7Z9zhyjY7kknaA6IDjloUqK1Oo2wnY3EM3Dkc=;
        b=wNX4yJ09OJ31syuTptKtyxGg74CgU/1AoQLodwJX6sHMtIthComN/jHUDMNQlieQy+
         cz64GN2FR6L38Cd9OUaYnjMowpXvS5iEycoR7a/nJbl60aazvzCvoH32cOJ+dMT371Tv
         6TDi7QrtD8P9Z3pRuZ19a4GdCP5NKljKMEe2I=
Received: by 10.68.219.234 with SMTP id pr10mr44869703pbc.11.1330430347893;
        Tue, 28 Feb 2012 03:59:07 -0800 (PST)
Received: from tre ([115.74.56.186])
        by mx.google.com with ESMTPS id q10sm15527508pbb.10.2012.02.28.03.59.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 03:59:06 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 28 Feb 2012 18:59:14 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191717>

COL_MODE_COLUMN and COL_MODE_ROW fill column by column (or row by row
respectively), given the terminal width and how many space between
columns.

Strings are supposed to be in UTF-8. If strings contain ANSI escape
strings, COL_ANSI must be specified for correct length calculation.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 column.c          |  131 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 column.h          |    3 +
 t/t9002-column.sh |   86 +++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+), 1 deletions(-)

diff --git a/column.c b/column.c
index d61da81..6aaa829 100644
--- a/column.c
+++ b/column.c
@@ -2,8 +2,66 @@
 #include "column.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "utf8.h"
=20
 #define MODE(mode) ((mode) & COL_MODE)
+#define XY2LINEAR(d, x, y) (MODE((d)->mode) =3D=3D COL_MODE_COLUMN ? \
+			    (x) * (d)->rows + (y) : \
+			    (y) * (d)->cols + (x))
+
+struct column_data {
+	const struct string_list *list; /* list of all cells */
+	int mode;			/* COL_MODE */
+	int total_width;		/* terminal width */
+	int padding;			/* cell padding */
+	const char *indent;		/* left most column indentation */
+	const char *nl;
+
+	int rows, cols;
+	int *len;			/* cell length */
+};
+
+/* return length of 's' in letters, ANSI escapes stripped */
+static int item_length(int mode, const char *s)
+{
+	int len, i =3D 0;
+	struct strbuf str =3D STRBUF_INIT;
+
+	if (!(mode & COL_ANSI))
+		return utf8_strwidth(s);
+
+	strbuf_addstr(&str, s);
+	while ((s =3D strstr(str.buf + i, "\033[")) !=3D NULL) {
+		int len =3D strspn(s + 2, "0123456789;");
+		i =3D s - str.buf;
+		strbuf_remove(&str, i, len + 3); /* \033[<len><func char> */
+	}
+	len =3D utf8_strwidth(str.buf);
+	strbuf_release(&str);
+	return len;
+}
+
+/*
+ * Calculate cell width, rows and cols for a table of equal cells, giv=
en
+ * table width and how many spaces between cells.
+ */
+static void layout(struct column_data *data, int *width)
+{
+	int i;
+
+	*width =3D 0;
+	for (i =3D 0; i < data->list->nr; i++)
+		if (*width < data->len[i])
+			*width =3D data->len[i];
+
+	*width +=3D data->padding;
+
+	data->cols =3D (data->total_width - strlen(data->indent)) / *width;
+	if (data->cols =3D=3D 0)
+		data->cols =3D 1;
+
+	data->rows =3D DIV_ROUND_UP(data->list->nr, data->cols);
+}
=20
 /* Display without layout when COL_ENABLED is not set */
 static void display_plain(const struct string_list *list,
@@ -15,6 +73,65 @@ static void display_plain(const struct string_list *=
list,
 		printf("%s%s%s", indent, list->items[i].string, nl);
 }
=20
+/* Print a cell to stdout with all necessary leading/traling space */
+static int display_cell(struct column_data *data, int initial_width,
+			const char *empty_cell, int x, int y)
+{
+	int i, len, newline;
+
+	i =3D XY2LINEAR(data, x, y);
+	if (i >=3D data->list->nr)
+		return -1;
+	len =3D data->len[i];
+	if (MODE(data->mode) =3D=3D COL_MODE_COLUMN)
+		newline =3D i + data->rows >=3D data->list->nr;
+	else
+		newline =3D x =3D=3D data->cols - 1 || i =3D=3D data->list->nr - 1;
+
+	printf("%s%s%s",
+			x =3D=3D 0 ? data->indent : "",
+			data->list->items[i].string,
+			newline ? data->nl : empty_cell + len);
+	return 0;
+}
+
+/* Display COL_MODE_COLUMN or COL_MODE_ROW */
+static void display_table(const struct string_list *list,
+			  int mode, int total_width,
+			  int padding, const char *indent,
+			  const char *nl)
+{
+	struct column_data data;
+	int x, y, i, initial_width;
+	char *empty_cell;
+
+	memset(&data, 0, sizeof(data));
+	data.list =3D list;
+	data.mode =3D mode;
+	data.total_width =3D total_width;
+	data.padding =3D padding;
+	data.indent =3D indent;
+	data.nl =3D nl;
+
+	data.len =3D xmalloc(sizeof(*data.len) * list->nr);
+	for (i =3D 0; i < list->nr; i++)
+		data.len[i] =3D item_length(mode, list->items[i].string);
+
+	layout(&data, &initial_width);
+
+	empty_cell =3D xmalloc(initial_width + 1);
+	memset(empty_cell, ' ', initial_width);
+	empty_cell[initial_width] =3D '\0';
+	for (y =3D 0; y < data.rows; y++) {
+		for (x =3D 0; x < data.cols; x++)
+			if (display_cell(&data, initial_width, empty_cell, x, y))
+				break;
+	}
+
+	free(data.len);
+	free(empty_cell);
+}
+
 void print_columns(const struct string_list *list, unsigned int mode,
 		   struct column_options *opts)
 {
@@ -36,7 +153,16 @@ void print_columns(const struct string_list *list, =
unsigned int mode,
 		display_plain(list, indent, nl);
 		return;
 	}
-	die("BUG: invalid mode %d", MODE(mode));
+
+	switch (MODE(mode)) {
+	case COL_MODE_ROW:
+	case COL_MODE_COLUMN:
+		display_table(list, mode, width, padding, indent, nl);
+		break;
+
+	default:
+		die("BUG: invalid mode %d", MODE(mode));
+	}
 }
=20
 struct colopt {
@@ -98,6 +224,9 @@ static int parse_option(const char *arg, int len,
 		{ ENABLE, "always",  1 },
 		{ ENABLE, "never",   0 },
 		{ ENABLE, "auto",   -1 },
+		{ MODE,   "column", COL_MODE_COLUMN },
+		{ MODE,   "row",    COL_MODE_ROW },
+		{ OPTION, "color",  COL_ANSI },
 	};
 	int i;
=20
diff --git a/column.h b/column.h
index 67b1c4f..d9d27c6 100644
--- a/column.h
+++ b/column.h
@@ -2,8 +2,11 @@
 #define COLUMN_H
=20
 #define COL_MODE          0x000F
+#define COL_MODE_COLUMN        0   /* Fill columns before rows */
+#define COL_MODE_ROW           1   /* Fill rows before columns */
 #define COL_ENABLED      (1 << 4)
 #define COL_ENABLED_SET  (1 << 5)  /* Has COL_ENABLED been set by conf=
ig? */
+#define COL_ANSI         (1 << 6)  /* Remove ANSI escapes from string =
length */
 #define COL_PARSEOPT     (1 << 8)  /* --column is given */
=20
 #define explicitly_enable_column(c) \
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index b0b6d62..cffb029 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -24,4 +24,90 @@ test_expect_success 'never' '
 	test_cmp lista actual
 '
=20
+test_expect_success '80 columns' '
+	cat >expected <<\EOF &&
+one    two    three  four   five   six    seven  eight  nine   ten    =
eleven
+EOF
+	COLUMNS=3D80 git column --mode=3Dcolumn <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'COLUMNS =3D 1' '
+	cat >expected <<\EOF &&
+one
+two
+three
+four
+five
+six
+seven
+eight
+nine
+ten
+eleven
+EOF
+	COLUMNS=3D1 git column --mode=3Dcolumn <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'width =3D 1' '
+	git column --mode=3Dcolumn --width=3D1 <lista >actual &&
+	test_cmp expected actual
+'
+
+COLUMNS=3D20
+export COLUMNS
+
+test_expect_success '20 columns' '
+	cat >expected <<\EOF &&
+one    seven
+two    eight
+three  nine
+four   ten
+five   eleven
+six
+EOF
+	git column --mode=3Dcolumn <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, padding 2' '
+	cat >expected <<\EOF &&
+one     seven
+two     eight
+three   nine
+four    ten
+five    eleven
+six
+EOF
+	git column --mode=3Dcolumn --padding 2 <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, indented' '
+	cat >expected <<\EOF &&
+  one    seven
+  two    eight
+  three  nine
+  four   ten
+  five   eleven
+  six
+EOF
+	git column --mode=3Dcolumn --indent=3D"  " <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, row first' '
+	cat >expected <<\EOF &&
+one    two
+three  four
+five   six
+seven  eight
+nine   ten
+eleven
+EOF
+	git column --mode=3Drow <lista >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.8.36.g69ee2
