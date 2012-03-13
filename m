From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 04/9] column: add dense layout support
Date: Tue, 13 Mar 2012 19:09:16 +0700
Message-ID: <28f1df2d0cc13d69fa571600c4723094b6fe514b.1331638663.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com> <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com> <c439d91ff126e2a9d7fe627de7346e19801dd6d4.1331638663.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:07:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QVF-0005Sj-Oc
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab2CMMGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:06:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63053 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab2CMMGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:06:45 -0400
Received: by yhmm54 with SMTP id m54so433182yhm.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2i0FvSaNBKc9EB5krLMni270HdfAcH/P+/UgLDiuIE8=;
        b=oOBmXbdRfBuZ02TwI8RJ5n/SnVGCSA/uUeFAlDiwXqqaLs9pbiT8vB7ia3NsBNbPZS
         xTS4G6CHAzI9rfVt4424fE11TVfTZ5AaWhAGJensKAwLvpOQaSApYiBZ2RJlGKQES6Iu
         BSNBX1XQq9HuhG6IhQ3v4KY3XApOjJYW7CHCsqM5ktfhRA4sLrn7fIKM0XgxDhil0wtF
         mTE71mdWywvFjrnlCRPcrBDXnq7i+0bOgvX0t3/bz/Nz68oZYZ5m/hzhzf8DWf80wcvB
         jj0Kp1QXasaw/BOMpj+M8Ga8TYFxwEMFmzQsX50IcxbN0vA9hZcCxwC2Vhf9Be6F92yi
         dgqA==
Received: by 10.68.234.1 with SMTP id ua1mr5937540pbc.69.1331640404979;
        Tue, 13 Mar 2012 05:06:44 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id y9sm633421pbu.40.2012.03.13.05.06.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:06:43 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:09:52 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <c439d91ff126e2a9d7fe627de7346e19801dd6d4.1331638663.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193001>

Normally all cells (and in turn columns) share the same width. This
layout mode can waste space because one long item can stretch our all
columns.

With COL_DENSE enabled, column width is calculated indepdendently. All
columns are shrunk to minimum, then it attempts to push cells of the
last row over to the next column with hope that everything still fits
even there's one row less. The process is repeated until the new layout
cannot fit in given width any more, or there's only one row left
(perfect!).

Apparently, this mode consumes more cpu than the old one, but it makes
better use of terminal space. For layouting one or two screens, cpu
usage should not be detectable.

This patch introduces option handling code besides layout modes and
enable/disable to expose this feature as "dense". The feature can be
turned off by specifying "nodense".

Thanks-to: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |    4 ++
 column.c                 |   84 ++++++++++++++++++++++++++++++++++++++=
+++++++-
 column.h                 |    2 +
 t/t9002-column.sh        |   48 ++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1d74a1..aacf8ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -839,6 +839,10 @@ column.ui::
 	fill rows before columns
 `plain`;;
 	show in one column
+`dense`;;
+	make unequal size columns to utilize more space
+`nodense`;;
+	make equal size columns
 --
 +
 	This option defaults to 'never'.
diff --git a/column.c b/column.c
index 17c2479..3aac28b 100644
--- a/column.c
+++ b/column.c
@@ -15,6 +15,7 @@ struct column_data {
=20
 	int rows, cols;
 	int *len;		/* cell length */
+	int *width;	      /* index to the longest row in column */
 };
=20
 /* return length of 's' in letters, ANSI escapes stripped */
@@ -56,6 +57,57 @@ static void layout(struct column_data *data, int *wi=
dth)
 	data->rows =3D DIV_ROUND_UP(data->list->nr, data->cols);
 }
=20
+static void compute_column_width(struct column_data *data)
+{
+	int i, x, y;
+	for (x =3D 0; x < data->cols; x++) {
+		data->width[x] =3D XY2LINEAR(data, x, 0);
+		for (y =3D 0; y < data->rows; y++) {
+			i =3D XY2LINEAR(data, x, y);
+			if (i < data->list->nr &&
+			    data->len[data->width[x]] < data->len[i])
+				data->width[x] =3D i;
+		}
+	}
+}
+
+/*
+ * Shrink all columns by shortening them one row each time (and adding
+ * more columns along the way). Hopefully the longest cell will be
+ * moved to the next column, column is shrunk so we have more space
+ * for new columns. The process ends when the whole thing no longer
+ * fits in data->total_width.
+ */
+static void shrink_columns(struct column_data *data)
+{
+	data->width =3D xrealloc(data->width,
+			       sizeof(*data->width) * data->cols);
+	while (data->rows > 1) {
+		int x, total_width, cols, rows;
+		rows =3D data->rows;
+		cols =3D data->cols;
+
+		data->rows--;
+		data->cols =3D DIV_ROUND_UP(data->list->nr, data->rows);
+		if (data->cols !=3D cols)
+			data->width =3D xrealloc(data->width,
+					       sizeof(*data->width) * data->cols);
+		compute_column_width(data);
+
+		total_width =3D strlen(data->opts.indent);
+		for (x =3D 0; x < data->cols; x++) {
+			total_width +=3D data->len[data->width[x]];
+			total_width +=3D data->opts.padding;
+		}
+		if (total_width > data->opts.width) {
+			data->rows =3D rows;
+			data->cols =3D cols;
+			break;
+		}
+	}
+	compute_column_width(data);
+}
+
 /* Display without layout when not enabled */
 static void display_plain(const struct string_list *list,
 			  const char *indent, const char *nl)
@@ -75,7 +127,18 @@ static int display_cell(struct column_data *data, i=
nt initial_width,
 	i =3D XY2LINEAR(data, x, y);
 	if (i >=3D data->list->nr)
 		return -1;
+
 	len =3D data->len[i];
+	if (data->width && data->len[data->width[x]] < initial_width) {
+		/*
+		 * empty_cell has initial_width chars, if real column
+		 * is narrower, increase len a bit so we fill less
+		 * space.
+		 */
+		len +=3D initial_width - data->len[data->width[x]];
+		len -=3D data->opts.padding;
+	}
+
 	if (COL_LAYOUT(data->colopts) =3D=3D COL_COLUMN)
 		newline =3D i + data->rows >=3D data->list->nr;
 	else
@@ -108,6 +171,9 @@ static void display_table(const struct string_list =
*list,
=20
 	layout(&data, &initial_width);
=20
+	if (colopts & COL_DENSE)
+		shrink_columns(&data);
+
 	empty_cell =3D xmalloc(initial_width + 1);
 	memset(empty_cell, ' ', initial_width);
 	empty_cell[initial_width] =3D '\0';
@@ -118,6 +184,7 @@ static void display_table(const struct string_list =
*list,
 	}
=20
 	free(data.len);
+	free(data.width);
 	free(empty_cell);
 }
=20
@@ -183,13 +250,22 @@ static int parse_option(const char *arg, int len,=
 unsigned int *colopts,
 		{ "plain",  COL_PLAIN,    COL_LAYOUT_MASK },
 		{ "column", COL_COLUMN,   COL_LAYOUT_MASK },
 		{ "row",    COL_ROW,      COL_LAYOUT_MASK },
+		{ "dense",  COL_DENSE,    0 },
 	};
 	int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(opts); i++) {
-		int arg_len =3D len, name_len;
+		int set =3D 1, arg_len =3D len, name_len;
 		const char *arg_str =3D arg;
=20
+		if (!opts[i].mask) {
+			if (arg_len > 2 && !strncmp(arg_str, "no", 2)) {
+				arg_str +=3D 2;
+				arg_len -=3D 2;
+				set =3D 0;
+			}
+		}
+
 		name_len =3D strlen(opts[i].name);
 		if (arg_len !=3D name_len ||
 		    strncmp(arg_str, opts[i].name, name_len))
@@ -206,6 +282,12 @@ static int parse_option(const char *arg, int len, =
unsigned int *colopts,
=20
 		if (opts[i].mask)
 			*colopts =3D (*colopts & ~opts[i].mask) | opts[i].value;
+		else {
+			if (set)
+				*colopts |=3D opts[i].value;
+			else
+				*colopts &=3D ~opts[i].value;
+		}
 		return 0;
 	}
=20
diff --git a/column.h b/column.h
index 79ac50d..b3e979f 100644
--- a/column.h
+++ b/column.h
@@ -4,6 +4,8 @@
 #define COL_LAYOUT_MASK   0x000F
 #define COL_ENABLE_MASK   0x0030   /* always, never or auto */
 #define COL_PARSEOPT      0x0040   /* --column is given from cmdline *=
/
+#define COL_DENSE         0x0080   /* Shrink columns when possible,
+				      making space for more columns */
=20
 #define COL_ENABLE(c) ((c) & COL_ENABLE_MASK)
 #define COL_DISABLED      0x0000   /* must be zero */
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index ec288ae..c7d7a65 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -89,6 +89,30 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success '20 columns, nodense' '
+	cat >expected <<\EOF &&
+one    seven
+two    eight
+three  nine
+four   ten
+five   eleven
+six
+EOF
+	git column --mode=3Dcolumn,nodense < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, dense' '
+	cat >expected <<\EOF &&
+one   five  nine
+two   six   ten
+three seven eleven
+four  eight
+EOF
+	git column --mode=3Dcolumn,dense < lista > actual &&
+	test_cmp expected actual
+'
+
 test_expect_success '20 columns, padding 2' '
 	cat >expected <<\EOF &&
 one     seven
@@ -128,4 +152,28 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success '20 columns, row first, nodense' '
+	cat >expected <<\EOF &&
+one    two
+three  four
+five   six
+seven  eight
+nine   ten
+eleven
+EOF
+	git column --mode=3Drow,nodense <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, row first, dense' '
+	cat >expected <<\EOF &&
+one   two    three
+four  five   six
+seven eight  nine
+ten   eleven
+EOF
+	git column --mode=3Drow,dense <lista >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.8.36.g69ee2
