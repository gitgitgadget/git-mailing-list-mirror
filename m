From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 05/11] column: support columns with different widths
Date: Sat, 25 Feb 2012 18:41:12 +0700
Message-ID: <1330170078-29353-6-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 12:39:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Fyh-00029c-8e
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 12:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab2BYLjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 06:39:35 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44098 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541Ab2BYLje (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 06:39:34 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so3436768dae.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 03:39:33 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.204.7 as permitted sender) client-ip=10.68.204.7;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.204.7 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.204.7])
        by 10.68.204.7 with SMTP id ku7mr18021568pbc.45.1330169973937 (num_hops = 1);
        Sat, 25 Feb 2012 03:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aGU5eAVvE3g1eAt5m2ySe4Xzjs/UQmArwC5bsjuMCzA=;
        b=PQ1Eg3SvmfXIO70YsS+OS1UN27QEcGSVTJ7qLx2uTQFkJM1BnrJF5TFkSKthF25ifI
         TGSISXFoil6KB/U5//wH88TCDoMMO6TKZl+PuuJzbY6WAo3uczBAvhC6IAzcC0j1cAZb
         nGjXVOJ1WDoFU+o3AjwhuO1yklA0mWNw3w4LQ=
Received: by 10.68.204.7 with SMTP id ku7mr14952800pbc.45.1330169973901;
        Sat, 25 Feb 2012 03:39:33 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id o2sm1847965pbn.59.2012.02.25.03.39.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 03:39:32 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 25 Feb 2012 18:41:51 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191527>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c          |   80 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h          |    2 +
 t/t9002-column.sh |   48 +++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/column.c b/column.c
index 6dca3b8..3c77997 100644
--- a/column.c
+++ b/column.c
@@ -19,6 +19,7 @@ struct column_data {
=20
 	int rows, cols;
 	int *len;			/* cell length */
+	int *width;			/* index to the longest row in column */
 };
=20
 /* return length of 's' in letters, ANSI escapes stripped */
@@ -63,6 +64,69 @@ static void layout(struct column_data *data, int *wi=
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
+			if (i >=3D data->list->nr)
+				continue;
+			if (data->len[data->width[x]] < data->len[i])
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
+	int x, y, total_width, cols, rows;
+
+	data->width =3D xrealloc(data->width,
+			       sizeof(*data->width) * data->cols);
+	for (x =3D 0; x < data->cols; x++) {
+		data->width[x] =3D 0;
+		for (y =3D 0; y < data->rows; y++) {
+			int len1 =3D data->len[data->width[x]];
+			int len2 =3D data->len[XY2LINEAR(data, x, y)];
+			if (len1 < len2)
+				data->width[x] =3D y;
+		}
+	}
+
+	while (data->rows > 1) {
+		rows =3D data->rows;
+		cols =3D data->cols;
+
+		data->rows--;
+		data->cols =3D DIV_ROUND_UP(data->list->nr, data->rows);
+		if (data->cols !=3D cols)
+			data->width =3D xrealloc(data->width, sizeof(*data->width) * data->=
cols);
+
+		compute_column_width(data);
+
+		total_width =3D strlen(data->indent);
+		for (x =3D 0; x < data->cols; x++) {
+			total_width +=3D data->len[data->width[x]];
+			total_width +=3D data->padding;
+		}
+		if (total_width > data->total_width) {
+			data->rows =3D rows;
+			data->cols =3D cols;
+			compute_column_width(data);
+			break;
+		}
+	}
+}
+
 /* Display without layout when COL_ENABLED is not set */
 static void display_plain(const struct string_list *list,
 			  const char *indent, const char *nl)
@@ -82,7 +146,18 @@ static int display_cell(struct column_data *data, i=
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
+		len -=3D data->padding;
+	}
+
 	if (MODE(data->mode) =3D=3D COL_MODE_COLUMN)
 		newline =3D i + data->rows >=3D data->list->nr;
 	else
@@ -119,6 +194,9 @@ static void display_table(const struct string_list =
*list,
=20
 	layout(&data, &initial_width);
=20
+	if (mode & COL_DENSE)
+		shrink_columns(&data);
+
 	empty_cell =3D xmalloc(initial_width + 1);
 	memset(empty_cell, ' ', initial_width);
 	empty_cell[initial_width] =3D '\0';
@@ -129,6 +207,7 @@ static void display_table(const struct string_list =
*list,
 	}
=20
 	free(data.len);
+	free(data.width);
 	free(empty_cell);
 }
=20
@@ -227,6 +306,7 @@ static int parse_option(const char *arg, int len,
 		{ MODE,   "column", COL_MODE_COLUMN },
 		{ MODE,   "row",    COL_MODE_ROW },
 		{ OPTION, "color",  COL_ANSI },
+		{ OPTION, "dense",  COL_DENSE },
 	};
 	int i;
=20
diff --git a/column.h b/column.h
index d9d27c6..eb03c6c 100644
--- a/column.h
+++ b/column.h
@@ -7,6 +7,8 @@
 #define COL_ENABLED      (1 << 4)
 #define COL_ENABLED_SET  (1 << 5)  /* Has COL_ENABLED been set by conf=
ig? */
 #define COL_ANSI         (1 << 6)  /* Remove ANSI escapes from string =
length */
+#define COL_DENSE        (1 << 7)  /* Shrink columns when possible,
+				      making space for more columns */
 #define COL_PARSEOPT     (1 << 8)  /* --column is given */
=20
 #define explicitly_enable_column(c) \
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index cffb029..fe7a30e 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -71,6 +71,30 @@ EOF
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
@@ -110,4 +134,28 @@ EOF
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
