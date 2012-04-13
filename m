From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v9 4/9] column: add dense layout support
Date: Fri, 13 Apr 2012 17:54:36 +0700
Message-ID: <1334314481-14470-5-git-send-email-pclouds@gmail.com>
References: <1334314481-14470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 12:56:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIeAq-00073K-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 12:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935245Ab2DMK4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 06:56:11 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:37934 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935209Ab2DMK4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 06:56:09 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so3768806dak.11
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 03:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qyVsK9Q3cb8oBn2z7a2/QzB222ig8sZnROaeALk1hNo=;
        b=Y+8qM7js1PPj+0Dzvwas5OG+1OPGY1c+1xFXUjATBznVIO/BHjM9C/7zmWFGXfrwDb
         amxyPExJMEjWyDCKybNvV3U+VXA2nEDWEirUuh1GY4BDjQ87/1fS+amVeqDIMrU+O9yW
         CE12IPn3g6GR1s6bolBqsgQ5ll5zeTP4mRkuReLz21uYZDNU/8lf/B7QUT6butWEVwmM
         RSKOaKUTfCpyhqHI1kZwUeIaOGupkdhCBIVDch6PPnrDzt1qeMuRCAAhpaYKNe2jGLwa
         +oPbSA61QaniKGNJ138+G9leUHVI6DCo4pDEkCfZ582q7GK7ROX6bZF61cJEmTL68Zvv
         lxCg==
Received: by 10.68.202.163 with SMTP id kj3mr3721522pbc.165.1334314569259;
        Fri, 13 Apr 2012 03:56:09 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id i1sm8416051pbj.70.2012.04.13.03.56.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 03:56:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Apr 2012 17:55:20 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334314481-14470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195414>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    4 ++
 column.c                 |   84 ++++++++++++++++++++++++++++++++++++++=
+++++++-
 column.h                 |    2 +
 t/t9002-column.sh        |   48 ++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab6ae3d..01905a7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -854,6 +854,10 @@ column.ui::
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
index e44e2e9..0fb7582 100644
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
index ec7e1d2..4f178d8 100644
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
 #define COL_DISABLED      0x0000   /* must be zero */
 #define COL_ENABLED       0x0010
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
1.7.3.1.256.g2539c.dirty
