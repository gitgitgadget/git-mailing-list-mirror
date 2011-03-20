From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/9] display_columns: add COL_MODE_{COLUMN,ROW} mode
Date: Sun, 20 Mar 2011 19:57:48 +0700
Message-ID: <1300625873-18435-5-git-send-email-pclouds@gmail.com>
References: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:58:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1IDd-0002yj-3x
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab1CTM6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:58:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50802 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab1CTM6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:58:47 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so5553777iwn.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=JzjIKE7w04pIl/d83rHshw4g7wXmVUUk4QetBr0Whqk=;
        b=hgxDtNVY8/2WHC+07drynRwRLW9k+XpXlPZGwUaw9aBkcZupEATQ9vgyU25dS4bPvZ
         zQoNiouNLXrk+bGIiWrxteutPtvb1MwACmZKAcQZm89rZ6RVQqePas7SR8eUCA7oD6Xe
         8TT2eUHD9GEMdtgkF+R3rJlhkMSFpFPi/zVFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AbkhBHvpLGmH0aRfjn6AxLc35rgeRMhxIMPtlRYKZIlR7ZUeo0OSF3SAxh45tUqgz1
         O8/Pbh5SQwYXa+pkeuY2smaMqWmd+xQIiAOQjfHz0wzPQeVGdfdKBEkxwqZ8B8iCWYEJ
         d7nxR1C2WcyTwKas2b3pdHSYRrZd/pz7Tlx1I=
Received: by 10.43.58.20 with SMTP id wi20mr4900889icb.304.1300625927111;
        Sun, 20 Mar 2011 05:58:47 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id he40sm2972458ibb.67.2011.03.20.05.58.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 05:58:46 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:58:36 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169506>

COL_MODE_COLUMN and COL_MODE_ROW fill column by column (or row by row
respectively), given the terminal width and how many space between
columns.

Strings are supposed to be in UTF-8. If strings contain ANSI escape str=
ings,
COL_ANSI must be specified for correct length calculation.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c          |  127 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 column.h          |    3 +
 t/t9002-column.sh |   86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+), 1 deletions(-)

diff --git a/column.c b/column.c
index b32b9f9..15f74a5 100644
--- a/column.c
+++ b/column.c
@@ -2,8 +2,65 @@
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
 struct string_list_item *add_to_columns(struct string_list *list, int =
mode,
 					const char *string)
@@ -23,6 +80,63 @@ static void display_plain(const struct string_list *=
list, const char *indent)
 		printf("%s%s\n", indent, list->items[i].string);
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
+			newline ? "\n" : empty_cell + len);
+	return 0;
+}
+
+/* Display COL_MODE_COLUMN or COL_MODE_ROW */
+static void display_table(const struct string_list *list,
+			  int mode, int total_width,
+			  int padding, const char *indent)
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
 void display_columns(const struct string_list *list, int mode,
 		     int width, int padding, const char *indent)
 {
@@ -34,7 +148,16 @@ void display_columns(const struct string_list *list=
, int mode,
 		display_plain(list, indent);
 		return;
 	}
-	die("BUG: invalid mode %d", MODE(mode));
+
+	switch (MODE(mode)) {
+	case COL_MODE_ROW:
+	case COL_MODE_COLUMN:
+		display_table(list, mode, width, padding, indent);
+		break;
+
+	default:
+		die("BUG: invalid mode %d", MODE(mode));
+	}
 }
=20
 struct colopt {
@@ -96,6 +219,8 @@ static int parse_option(const char *arg, int len,
 		{ ENABLE, "always",  1 },
 		{ ENABLE, "never",   0 },
 		{ ENABLE, "auto",   -1 },
+		{ MODE,   "column", COL_MODE_COLUMN },
+		{ MODE,   "row",    COL_MODE_ROW },
 	};
 	int i, set, name_len;
=20
diff --git a/column.h b/column.h
index a8b24e8..4fb1004 100644
--- a/column.h
+++ b/column.h
@@ -2,8 +2,11 @@
 #define COLUMN_H
=20
 #define COL_MODE          0x000F
+#define COL_MODE_COLUMN        0   /* Fill columns before rows */
+#define COL_MODE_ROW           1   /* Fill rows before columns */
 #define COL_ENABLED      (1 << 4)
 #define COL_ENABLED_SET  (1 << 5)  /* Has COL_ENABLED been set? */
+#define COL_ANSI         (1 << 6)  /* Remove ANSI escapes from string =
length */
=20
 extern int term_columns(void);
 extern struct string_list_item *add_to_columns(struct string_list *lis=
t, int mode, const char *string);
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 099a29f..f801190 100755
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
+	COLUMNS=3D80 test-column --mode=3Dcolumn <lista >actual &&
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
+	COLUMNS=3D1 test-column --mode=3Dcolumn <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'width =3D 1' '
+	test-column --mode=3Dcolumn --width=3D1 <lista >actual &&
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
+	test-column --mode=3Dcolumn <lista >actual &&
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
+	test-column --mode=3Dcolumn --padding 2 <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, left indented' '
+	cat >expected <<\EOF &&
+  one    seven
+  two    eight
+  three  nine
+  four   ten
+  five   eleven
+  six
+EOF
+	test-column --mode=3Dcolumn --left=3D2 <lista >actual &&
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
+	test-column --mode=3Drow <lista >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.4.74.g639db
