From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/16] display_columns: add COL_MODE_{COLUMN,ROW} mode
Date: Wed,  9 Feb 2011 19:24:31 +0700
Message-ID: <1297254284-3729-4-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:26:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn98C-00074P-PE
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab1BIM0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:26:39 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35859 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab1BIM0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:26:38 -0500
Received: by mail-iy0-f174.google.com with SMTP id 8so92702iyj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=V4BzE3V3C0xZ7QBq/Qb1+zB+py9vWR/IucB8Efcs3RA=;
        b=AYf1qxc4pcg1WuMSow99vxMdT8zgsOoFGM8ygt4cPhI0Xz+8Uq4sZkGF3pT9SG7rSB
         EuUYOGt7TbOC70VsZSXv6GD5S58moYr5FzF3yonjjQHyxodK6xnN0OK7DNh9jfYokTNS
         EgqQ31cR+DOytgLxFFI4ZoIZk9li36pZGVmCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=F2IFKDTT8dveLTpEzDU+/EaTdjWifzt75xea1I79meit49y7J7Od4CYCnF6J0BdUVq
         rco8zaR+71mjTYJq3h3oTjH12BKJTzLVQ7/xSP+zKndyxXToKxaM895n41wsklI9niZK
         b3ODGT4pTNak6pcnFt90hHiOpKcAXkB061tD8=
Received: by 10.42.223.202 with SMTP id il10mr6898893icb.143.1297254398566;
        Wed, 09 Feb 2011 04:26:38 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id u9sm253109ibe.8.2011.02.09.04.26.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:26:37 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:25:07 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166408>

COL_MODE_COLUMN and COL_MODE_ROW fill column by column (or row by row
respectively), given the terminal width and how many space between
columns.

Strings are supposed in UTF-8. If strings contain ANSI escape strings,
COL_ANSI must be specified.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h |    3 ++
 2 files changed, 110 insertions(+), 0 deletions(-)

diff --git a/column.c b/column.c
index c7d9a84..d6e2d70 100644
--- a/column.c
+++ b/column.c
@@ -1,8 +1,58 @@
 #include "cache.h"
 #include "column.h"
+#include "parse-options.h"
 #include "string-list.h"
+#include "utf8.h"
=20
 #define MODE(mode) ((mode) & COL_MODE)
+#define XY2SCALAR(mode,x,y,cols,rows) (MODE(mode) =3D=3D COL_MODE_COLU=
MN ? (x) * (rows) + (y) : (y) * (cols) + (x))
+
+/* return length of 's' in letters, ANSI escapes stripped */
+static int item_length(const struct string_list *list, int mode, const=
 char *s)
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
+static void layout(const struct string_list *list,
+		   int mode, int total_width, int padding,
+		   int *width, int *rows, int *cols)
+{
+	int i;
+
+	*width =3D 0;
+	/* Find maximum column width */
+	for (i =3D 0; i < list->nr; i++) {
+		const char *s =3D list->items[i].string;
+		int len =3D item_length(list, mode, s);
+		if (*width < len)
+			*width =3D len;
+	}
+	*width +=3D padding;
+
+	*cols =3D total_width / *width;
+	if (*cols =3D=3D 0)
+		*cols =3D 1;
+
+	*rows =3D DIV_ROUND_UP(list->nr, *cols);
+}
=20
 /* Display without layout, COL_MODE_PLAIN */
 static void display_plain(const struct string_list *list, const char *=
indent)
@@ -13,6 +63,58 @@ static void display_plain(const struct string_list *=
list, const char *indent)
 		printf("%s%s\n", indent, list->items[i].string);
 }
=20
+static int display_cell(const struct string_list *list, int mode,
+			int *width, int initial_width,
+			const char *indent, const char *empty_cell,
+			int x, int y, int cols, int rows)
+{
+	const char *s;
+	int i, len, newline;
+
+	i =3D XY2SCALAR(mode, x, y, cols, rows);
+	if (i >=3D list->nr)
+		return -1;
+	s =3D list->items[i].string;
+	len =3D item_length(list, mode, s);
+	if (width[x] < initial_width)
+		len +=3D initial_width - width[x];
+	if (MODE(mode) =3D=3D COL_MODE_COLUMN)
+		newline =3D i + rows >=3D list->nr;
+	else
+		newline =3D x =3D=3D cols - 1 || i =3D=3D list->nr - 1;
+
+	printf("%s%s%s",
+			x =3D=3D 0 ? indent : "",
+			list->items[i].string,
+			newline ? "\n" : empty_cell + len);
+	return 0;
+}
+
+/* Display COL_MODE_COLUMN or COL_MODE_ROW */
+static void display_table(const struct string_list *list,
+			  int mode, int total_width,
+			  int padding, const char *indent)
+{
+	int x, y, i, cols, rows, initial_width, *width;
+	char *empty_cell;
+
+	layout(list, mode, total_width, padding, &initial_width, &rows, &cols=
);
+	width =3D xmalloc(sizeof(*width) * cols);
+	for (i =3D 0; i < cols; i++)
+		width[i] =3D initial_width;
+
+	empty_cell =3D xmalloc(initial_width + 1);
+	memset(empty_cell, ' ', initial_width);
+	empty_cell[initial_width] =3D '\0';
+	for (y =3D 0; y < rows; y++) {
+		for (x =3D 0; x < cols; x++)
+			if (display_cell(list, mode, width,
+					 initial_width, indent, empty_cell,
+					 x, y, cols, rows))
+				break;
+	}
+}
+
 void display_columns(const struct string_list *list, int mode, int wid=
th, int padding, const char *indent)
 {
 	int real_mode =3D MODE(mode);
@@ -25,6 +127,11 @@ void display_columns(const struct string_list *list=
, int mode, int width, int pa
 		display_plain(list, indent);
 		break;
=20
+	case COL_MODE_ROW:
+	case COL_MODE_COLUMN:
+		display_table(list, mode, width, padding, indent);
+		break;
+
 	default:
 		die("BUG: invalid mode %d", MODE(mode));
 	}
diff --git a/column.h b/column.h
index da0bf9a..3ed5731 100644
--- a/column.h
+++ b/column.h
@@ -3,6 +3,9 @@
=20
 #define COL_MODE          0x000F
 #define COL_MODE_PLAIN         0   /* Single column */
+#define COL_MODE_COLUMN        1   /* Fill columns before rows */
+#define COL_MODE_ROW           2   /* Fill rows before columns */
+#define COL_ANSI         (1 << 4) /* Remove ANSI escapes from string l=
ength */
=20
 extern int term_columns(void);
 extern void display_columns(const struct string_list *list, int mode, =
int width, int padding, const char *indent);
--=20
1.7.2.2
