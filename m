From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/16] display_columns: add COL_DENSE to do unequal column layout
Date: Wed,  9 Feb 2011 19:24:32 +0700
Message-ID: <1297254284-3729-5-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn98I-00078e-T8
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab1BIM0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:26:48 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47853 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab1BIM0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:26:47 -0500
Received: by iwn9 with SMTP id 9so74477iwn.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=0Sk+8rbqIfOp6lJtWXDWDUGOH1E55qP8tYpnpR4Vvy0=;
        b=j/BOLAcyEot+i1QN2TiIbdx0XcARBXUu2AJGgKXe4ZQMXVdKsa25/S2IiVJ1CPj5ML
         Ptnzu3g+05OBsu83eyJjUQQS7Ei3HrJfbWvFmqsBiVvlZIKAXLinW8UO5ZYObTHQC+Ta
         PpPdH/lPMUvWGOpHkX28cJcG1ldCmRPlSQZXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UwPThKU6jXVNZo/WWoqFS6s7EeTj0onmmKHOJWMXYq3JLfzVD0VbEKeSGDYPI1xoVU
         tUm7OvZpO9Sk4Tw/tmnHDijVjbD0zMtSCCXytNZL090eTYHV8lgzEHMnreU+mSbphAVY
         J3iOZ1bXF8MSKH0TO4ZPj1rTBOF0jcGsR0H3g=
Received: by 10.42.228.73 with SMTP id jd9mr20185620icb.38.1297254406740;
        Wed, 09 Feb 2011 04:26:46 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id 8sm255420iba.4.2011.02.09.04.26.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:26:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:25:15 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166409>

shrink_columns() calculate column width just enough to contain
text and padding.

relayout() uses shrink_columns() to try adding more columns after
columns are shrunk. However it only try that once.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h |    1 +
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/column.c b/column.c
index d6e2d70..e7facf4 100644
--- a/column.c
+++ b/column.c
@@ -54,6 +54,68 @@ static void layout(const struct string_list *list,
 	*rows =3D DIV_ROUND_UP(list->nr, *cols);
 }
=20
+/*
+ * Tighten columns just wide enough to fit its data and padding
+ * Return number of chars saved after shrinking.
+ */
+static int shrink_columns(const struct string_list *list, int mode,
+			   int *width, int padding, int rows, int cols)
+{
+	int x, y, i, len, item_len, spare =3D 0;
+	const char *s;
+
+	for (x =3D 0; x < cols; x++) {
+		for (y =3D len =3D 0; y < rows; y++) {
+			i =3D XY2SCALAR(mode, x, y, cols, rows);
+			if (i >=3D list->nr)
+				break;
+			s =3D list->items[i].string;
+			item_len =3D item_length(list, mode, s);
+			if (len < item_len)
+				len =3D item_len;
+		}
+		len +=3D padding;
+
+		assert(len <=3D width[x]);
+		spare +=3D width[x] - len;
+		width[x] =3D len;
+	}
+	return spare;
+}
+
+/* Try to tighten the layout and see if more columns can be added.*/
+static void relayout(const struct string_list *list,
+		     int mode, int original_width, int padding, int spare,
+		     int *initial_width, int **width, int *rows, int *cols)
+{
+	int new_rows, new_cols, new_initial_width;
+	int i, *new_width, new_spare, total_width;
+
+	/*
+	 * Assume all columns have same width, we would need
+	 * initial_width*cols. But then after shrinking, we have
+	 * "spare" more chars. Assume a new total_width with
+	 * additional chars, then re-shrink to see if it fits
+	 * c->width.
+	 */
+	total_width =3D (*initial_width)*(*cols) + spare;
+	layout(list, mode, total_width, padding,
+	       &new_initial_width, &new_rows, &new_cols);
+	new_width =3D xmalloc(sizeof(*new_width) * new_cols);
+	for (i =3D 0; i < new_cols; i++)
+		new_width[i] =3D new_initial_width;
+	new_spare =3D shrink_columns(list, mode, new_width, padding, new_rows=
, new_cols);
+
+	/* Does it fit? */
+	if (total_width - new_spare < original_width) {
+		free(*width);
+		*width =3D new_width;
+		*initial_width =3D new_initial_width;
+		*rows =3D new_rows;
+		*cols =3D new_cols;
+	}
+}
+
 /* Display without layout, COL_MODE_PLAIN */
 static void display_plain(const struct string_list *list, const char *=
indent)
 {
@@ -103,6 +165,14 @@ static void display_table(const struct string_list=
 *list,
 	for (i =3D 0; i < cols; i++)
 		width[i] =3D initial_width;
=20
+	if (mode & COL_DENSE) {
+		int spare =3D shrink_columns(list, mode, width, padding, rows, cols)=
;
+		/* is it worth relayout? */
+		if (spare >=3D initial_width/2)
+			relayout(list, mode, total_width, padding, spare,
+				 &initial_width, &width, &rows, &cols);
+	}
+
 	empty_cell =3D xmalloc(initial_width + 1);
 	memset(empty_cell, ' ', initial_width);
 	empty_cell[initial_width] =3D '\0';
diff --git a/column.h b/column.h
index 3ed5731..cef354d 100644
--- a/column.h
+++ b/column.h
@@ -6,6 +6,7 @@
 #define COL_MODE_COLUMN        1   /* Fill columns before rows */
 #define COL_MODE_ROW           2   /* Fill rows before columns */
 #define COL_ANSI         (1 << 4) /* Remove ANSI escapes from string l=
ength */
+#define COL_DENSE        (1 << 5) /* Shrink columns when possible, mak=
ing space for more columns */
=20
 extern int term_columns(void);
 extern void display_columns(const struct string_list *list, int mode, =
int width, int padding, const char *indent);
--=20
1.7.2.2
