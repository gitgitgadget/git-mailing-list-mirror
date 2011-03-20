From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/9] display_columns: add COL_DENSE to do unequal column layout
Date: Sun, 20 Mar 2011 19:57:49 +0700
Message-ID: <1300625873-18435-6-git-send-email-pclouds@gmail.com>
References: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:59:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1IDn-00033x-MD
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab1CTM66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:58:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57792 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab1CTM66 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:58:58 -0400
Received: by iyb26 with SMTP id 26so5552163iyb.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=usLinIkWSfgI14QBp6pMGVCFTb8Z0wKUSs03KTnRtOE=;
        b=AvTzeva+tvYxh9MPEwIlDtynKrU4Mlh8oVd4FMQEk2SKCWdmBkZqziF3ZmkDMzZMuI
         5wskVSDGuTCvZin44v/joQQ/HMYHzAe0fc0UlwQV4tHS9hCyinuL/Pov7H7MQoix4btn
         w9PFq0OR70849oOd+lBaBdQBIbXDVG5YP7n4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vPskSyQT08oBeqDzl3QgN19U/slWMs0+uedS1pYhvivgRoC/UYcN4X2ShY545qbNu9
         jLULPbiRslqKfEyOi6epm22n0UnNJFReFFZyJmitgRl5w/J+c8FEhUuoyHPaiYGjJiel
         RfXEdpOl7aURO9Imlam+VJzofpKXsTsCTH2fM=
Received: by 10.231.33.205 with SMTP id i13mr3119216ibd.54.1300625937708;
        Sun, 20 Mar 2011 05:58:57 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id g17sm688887ibb.40.2011.03.20.05.58.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 05:58:56 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:58:47 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169507>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c          |   80 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h          |    1 +
 t/t9002-column.sh |   22 ++++++++++++++
 3 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/column.c b/column.c
index 15f74a5..69d42f8 100644
--- a/column.c
+++ b/column.c
@@ -18,6 +18,7 @@ struct column_data {
=20
 	int rows, cols;
 	int *len;			/* cell length */
+	int *width;			/* index to the longest row in column */
 };
=20
 /* return length of 's' in letters, ANSI escapes stripped */
@@ -62,6 +63,69 @@ static void layout(struct column_data *data, int *wi=
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
 struct string_list_item *add_to_columns(struct string_list *list, int =
mode,
 					const char *string)
 {
@@ -89,7 +153,18 @@ static int display_cell(struct column_data *data, i=
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
@@ -124,6 +199,9 @@ static void display_table(const struct string_list =
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
@@ -134,6 +212,7 @@ static void display_table(const struct string_list =
*list,
 	}
=20
 	free(data.len);
+	free(data.width);
 	free(empty_cell);
 }
=20
@@ -221,6 +300,7 @@ static int parse_option(const char *arg, int len,
 		{ ENABLE, "auto",   -1 },
 		{ MODE,   "column", COL_MODE_COLUMN },
 		{ MODE,   "row",    COL_MODE_ROW },
+		{ OPTION, "dense",  COL_DENSE },
 	};
 	int i, set, name_len;
=20
diff --git a/column.h b/column.h
index 4fb1004..48c6345 100644
--- a/column.h
+++ b/column.h
@@ -7,6 +7,7 @@
 #define COL_ENABLED      (1 << 4)
 #define COL_ENABLED_SET  (1 << 5)  /* Has COL_ENABLED been set? */
 #define COL_ANSI         (1 << 6)  /* Remove ANSI escapes from string =
length */
+#define COL_DENSE        (1 << 7)  /* Shrink columns when possible, ma=
king space for more columns */
=20
 extern int term_columns(void);
 extern struct string_list_item *add_to_columns(struct string_list *lis=
t, int mode, const char *string);
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index f801190..07161a9 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -71,6 +71,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success '20 columns, dense' '
+	cat >expected <<\EOF &&
+one   five  nine
+two   six   ten
+three seven eleven
+four  eight
+EOF
+	test-column --mode=3Dcolumn,dense < lista > actual &&
+	test_cmp expected actual
+'
+
 test_expect_success '20 columns, padding 2' '
 	cat >expected <<\EOF &&
 one     seven
@@ -110,4 +121,15 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success '20 columns, row first, dense' '
+	cat >expected <<\EOF &&
+one   two    three
+four  five   six
+seven eight  nine
+ten   eleven
+EOF
+	test-column --mode=3Drow,dense <lista >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.4.74.g639db
