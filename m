From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] wt-status: take the alignment burden off translators
Date: Tue,  5 Nov 2013 09:07:29 +0700
Message-ID: <1383617249-13360-1-git-send-email-pclouds@gmail.com>
References: <1383534531-5153-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, wolfgang@rohdewald.de,
	vnwildman@gmail.com, ralf.thielow@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 05 03:07:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdW3c-0002VT-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 03:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905Ab3KECHs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Nov 2013 21:07:48 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33840 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3KECHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 21:07:47 -0500
Received: by mail-ie0-f172.google.com with SMTP id tp5so14043837ieb.31
        for <git@vger.kernel.org>; Mon, 04 Nov 2013 18:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NQl3OyBi3imz4kq7b5P6SdfeMyCgasiQXJMFOHGt+BM=;
        b=KSVoTsiBNaiubO/oKn7EfHOvXVZC6Dl/Di6TXY1YzKUz8bdrbDm/xnP2YkN7LdBD6U
         fPWQ/rL/nNggvorIcz0bBUBXJj+vA3f7iRS/Z0vxDG8h2PNdUNETX6lQXNdYBQUgHOkg
         EzQ8IfulicS7U8DMIjDvQEO+EfduMdY3wb25pnX/HpnBjUeMWQNC/8RmoSQ6tFQQTYde
         D7Nkkdum9tYzw7yPeecdUjq2A3w3danlroYrHG1xjE1bjSluHvUv59XeHarf5eiowEgt
         bXhySYczosweN0SSB57th6r0GNxPSmFK5OO5qdO7Q2/tYF0KIwMpGMyWnsWbBtF+A8ct
         Evjg==
X-Received: by 10.50.26.70 with SMTP id j6mr14201541igg.24.1383617265391;
        Mon, 04 Nov 2013 18:07:45 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id p5sm5855027igj.10.2013.11.04.18.07.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 04 Nov 2013 18:07:44 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 05 Nov 2013 09:07:38 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1383534531-5153-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237319>

It's not easy for translators to see spaces in these strings have to
align, especially when there are no guarantees that these strings are
grouped together in .po files. Refactor the code and do the alignment
automatically.

Noticed-by: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v2 calculates maximum length automatically too so the translator does
 not have to test and specify that manually.

 wt-status.c | 80 ++++++++++++++++++++++++++++++++++++++++-------------=
--------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index b4e44ba..4625cdb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -15,6 +15,7 @@
 #include "submodule.h"
 #include "column.h"
 #include "strbuf.h"
+#include "utf8.h"
=20
 static char default_wt_status_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -264,6 +265,30 @@ static void wt_status_print_unmerged_data(struct w=
t_status *s,
 	strbuf_release(&onebuf);
 }
=20
+static const char *wt_status_diff_status_string(int status)
+{
+	switch (status) {
+	case DIFF_STATUS_ADDED:
+		return _("new file");
+	case DIFF_STATUS_COPIED:
+		return _("copied");
+	case DIFF_STATUS_DELETED:
+		return _("deleted");
+	case DIFF_STATUS_MODIFIED:
+		return _("modified");
+	case DIFF_STATUS_RENAMED:
+		return _("renamed");
+	case DIFF_STATUS_TYPE_CHANGED:
+		return _("typechange");
+	case DIFF_STATUS_UNKNOWN:
+		return _("unknown");
+	case DIFF_STATUS_UNMERGED:
+		return _("unmerged");
+	default:
+		return NULL;
+	}
+}
+
 static void wt_status_print_change_data(struct wt_status *s,
 					int change_type,
 					struct string_list_item *it)
@@ -276,6 +301,23 @@ static void wt_status_print_change_data(struct wt_=
status *s,
 	const char *one, *two;
 	struct strbuf onebuf =3D STRBUF_INIT, twobuf =3D STRBUF_INIT;
 	struct strbuf extra =3D STRBUF_INIT;
+	static char *padding;
+	const char *what;
+	int len;
+
+	if (!padding) {
+		int width =3D 0;
+		/* If DIFF_STATUS_* uses outside this range, we're in trouble */
+		for (status =3D 'A'; status <=3D 'Z'; status++) {
+			what =3D wt_status_diff_status_string(status);
+			len =3D what ? strlen(what) : 0;
+			if (len > width)
+				width =3D len;
+		}
+		width +=3D 2;	/* colon and a space */
+		padding =3D xmallocz(width);
+		memset(padding, ' ', width);
+	}
=20
 	one_name =3D two_name =3D it->string;
 	switch (change_type) {
@@ -307,34 +349,18 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 	two =3D quote_path(two_name, s->prefix, &twobuf);
=20
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
-	switch (status) {
-	case DIFF_STATUS_ADDED:
-		status_printf_more(s, c, _("new file:   %s"), one);
-		break;
-	case DIFF_STATUS_COPIED:
-		status_printf_more(s, c, _("copied:     %s -> %s"), one, two);
-		break;
-	case DIFF_STATUS_DELETED:
-		status_printf_more(s, c, _("deleted:    %s"), one);
-		break;
-	case DIFF_STATUS_MODIFIED:
-		status_printf_more(s, c, _("modified:   %s"), one);
-		break;
-	case DIFF_STATUS_RENAMED:
-		status_printf_more(s, c, _("renamed:    %s -> %s"), one, two);
-		break;
-	case DIFF_STATUS_TYPE_CHANGED:
-		status_printf_more(s, c, _("typechange: %s"), one);
-		break;
-	case DIFF_STATUS_UNKNOWN:
-		status_printf_more(s, c, _("unknown:    %s"), one);
-		break;
-	case DIFF_STATUS_UNMERGED:
-		status_printf_more(s, c, _("unmerged:   %s"), one);
-		break;
-	default:
+	what =3D wt_status_diff_status_string(status);
+	if (!what)
 		die(_("bug: unhandled diff status %c"), status);
-	}
+	/* 1 for colon, which is not part of "what" */
+	len =3D strlen(padding) - (utf8_strwidth(what) + 1);
+	assert(len >=3D 0);
+	if (status =3D=3D DIFF_STATUS_COPIED || status =3D=3D DIFF_STATUS_REN=
AMED)
+		status_printf_more(s, c, "%s:%.*s%s -> %s",
+				   what, len, padding, one, two);
+	else
+		status_printf_more(s, c, "%s:%.*s%s",
+				   what, len, padding, one);
 	if (extra.len) {
 		status_printf_more(s, color(WT_STATUS_HEADER, s), "%s", extra.buf);
 		strbuf_release(&extra);
--=20
1.8.2.82.gc24b958
