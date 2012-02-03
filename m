From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 06/13] column: add columnar layout
Date: Fri,  3 Feb 2012 20:34:31 +0700
Message-ID: <1328276078-27955-7-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 14:31:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJF8-0008Fq-IS
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399Ab2BCNbb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 08:31:31 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47389 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242Ab2BCNb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:31:28 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so2900162pbd.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 05:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9SNsgYeBCzZtxZRAe2zfy1iCx6H2YCbLsV9I021x3ao=;
        b=CkOGq0UHes9Q4jyilLMIhsZUzQuJVTUn/7QQVdi88FAL20QoortmVxgLvwLaF0RYAf
         k+jhO7lkrOzDNAMAHcVO2/3YrWKoVNbg6I9cRsoB/sMm+0NROiwwrJxtAh5gsCA9SQF3
         PNPIKcSCxZ0AFrgYAIkPcWn0tLSxBgRdWKDkw=
Received: by 10.68.200.65 with SMTP id jq1mr17928490pbc.54.1328275888435;
        Fri, 03 Feb 2012 05:31:28 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id li19sm13105264pbb.17.2012.02.03.05.31.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 05:31:27 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 03 Feb 2012 20:35:37 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189765>

COL_MODE_COLUMN and COL_MODE_ROW fill column by column (or row by row
respectively), given the terminal width and how many space between
columns.

Strings are supposed to be in UTF-8. If strings contain ANSI escape
strings, COL_ANSI must be specified for correct length calculation.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c          |  131 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 column.h          |    3 +
 t/t9002-column.sh |   86 +++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+), 1 deletions(-)

diff --git a/column.c b/column.c
index bd15bea..4681106 100644
--- a/column.c
+++ b/column.c
@@ -2,8 +2,66 @@
 #include "column.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "utf8.h"
=20
 #define MODE(mode) ((mode) & COL_MODE)
+#define XY2LINEAR(d,x,y) (MODE((d)->mode) =3D=3D COL_MODE_COLUMN ? \
+			  (x) * (d)->rows + (y) : \
+			  (y) * (d)->cols + (x))
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
 struct string_list_item *add_cell_to_list(struct string_list *list,
 					  int mode,
@@ -30,6 +88,65 @@ static void display_plain(const struct string_list *=
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
 void print_columns(const struct string_list *list, int mode,
 		   struct column_options *opts)
 {
@@ -51,7 +168,16 @@ void print_columns(const struct string_list *list, =
int mode,
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
@@ -113,6 +239,9 @@ static int parse_option(const char *arg, int len,
 		{ ENABLE, "always",  1 },
 		{ ENABLE, "never",   0 },
 		{ ENABLE, "auto",   -1 },
+		{ MODE,   "column", COL_MODE_COLUMN },
+		{ MODE,   "row",    COL_MODE_ROW },
+		{ OPTION, "color",  COL_ANSI },
 	};
 	int i, set, name_len;
=20
diff --git a/column.h b/column.h
index 59f26dc..38976ea 100644
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
=20
 struct column_options {
 	int width;
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
