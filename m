From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] wt-status: take the alignment burden off translators
Date: Mon,  4 Nov 2013 10:08:51 +0700
Message-ID: <1383534531-5153-1-git-send-email-pclouds@gmail.com>
References: <31465687.35grSWXxkx@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, wolfgang@rohdewald.de,
	vnwildman@gmail.com, ralf.thielow@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 04 04:05:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdATR-0007e1-R4
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 04:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab3KDDEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Nov 2013 22:04:49 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52707 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab3KDDEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 22:04:48 -0500
Received: by mail-pb0-f52.google.com with SMTP id rr4so129808pbb.25
        for <git@vger.kernel.org>; Sun, 03 Nov 2013 19:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6dRFgni+0oMu8Qy/6lkgMwRa6wphvrIYXZZ1yc5p+OU=;
        b=M1Rrg/XMzYMWIITbTgv2BG/0/6b1+3Mt7LPYctau+O9jZTSqPMXJvO44GNIol7QaXp
         KAxr/pb7DyX55vTnRY7Rc9OhFCx6Q36J5lxuUhpliNRNX6bZYyoqOZq0bq3WZrh536c2
         R1s0hXG1RJkrf9GaeINb6WoUA1/mos/jUMwnoLKc+KJqcQ6H1sRYlNNP27FWPnVjgpe+
         8KF1eJOC3JqDmM3K9LUcztaxAycgDnIVAsUZ5uIXI9wQW1BbCIUWY9Ywj3tt2yGS+uWk
         wF9wmDJwniGXYRvlSA+1oU8l+svS7rlkZGgGuuWInupoabjZO8zgmGfj0QPPle5P7VDz
         /8RA==
X-Received: by 10.66.26.236 with SMTP id o12mr788614pag.136.1383534287931;
        Sun, 03 Nov 2013 19:04:47 -0800 (PST)
Received: from lanh ([115.73.205.169])
        by mx.google.com with ESMTPSA id q4sm25021614pba.12.2013.11.03.19.04.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Nov 2013 19:04:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 04 Nov 2013 10:08:54 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <31465687.35grSWXxkx@i5>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237283>

It's not easy for translators to see spaces in these strings have to
align, especially when there are no guarantees that these strings are
grouped together in .po files.

Refactor the code and do the alignment automatically. Let the
translator specify how big the alignment is, though, in case some
languages need more than 12 columns for the preceding text.

Noticed-by: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Ralf and Quan, don't update your translations yet. If this change
 gets merged it'll simplify your task a bit.

 wt-status.c | 51 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index b4e44ba..f9715d3 100644
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
@@ -276,6 +277,10 @@ static void wt_status_print_change_data(struct wt_=
status *s,
 	const char *one, *two;
 	struct strbuf onebuf =3D STRBUF_INIT, twobuf =3D STRBUF_INIT;
 	struct strbuf extra =3D STRBUF_INIT;
+	const char *what;
+	static const char *spaces =3D "                                ";
+	static int width =3D -1;
+	int len;
=20
 	one_name =3D two_name =3D it->string;
 	switch (change_type) {
@@ -309,32 +314,62 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	switch (status) {
 	case DIFF_STATUS_ADDED:
-		status_printf_more(s, c, _("new file:   %s"), one);
+		what =3D _("new file");
 		break;
 	case DIFF_STATUS_COPIED:
-		status_printf_more(s, c, _("copied:     %s -> %s"), one, two);
+		what =3D _("copied");
 		break;
 	case DIFF_STATUS_DELETED:
-		status_printf_more(s, c, _("deleted:    %s"), one);
+		what =3D _("deleted");
 		break;
 	case DIFF_STATUS_MODIFIED:
-		status_printf_more(s, c, _("modified:   %s"), one);
+		what =3D _("modified");
 		break;
 	case DIFF_STATUS_RENAMED:
-		status_printf_more(s, c, _("renamed:    %s -> %s"), one, two);
+		what =3D _("renamed");
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
-		status_printf_more(s, c, _("typechange: %s"), one);
+		what =3D _("typechange");
 		break;
 	case DIFF_STATUS_UNKNOWN:
-		status_printf_more(s, c, _("unknown:    %s"), one);
+		what =3D _("unknown");
 		break;
 	case DIFF_STATUS_UNMERGED:
-		status_printf_more(s, c, _("unmerged:   %s"), one);
+		what =3D _("unmerged");
 		break;
 	default:
 		die(_("bug: unhandled diff status %c"), status);
 	}
+	if (width =3D=3D -1) {
+		/*
+		 * Translators: if you do translate this, replace it
+		 * with a decimal number of how many columns needed
+		 * to align file names in "git status":
+		 *
+		 * |<-columns->|
+		 *
+		 *   unmerged: foo.c
+		 *   copied:   foo.c -> bar.c
+		 *
+		 * The default value is 12. Normally you would not
+		 * need to translate this at all unless the translated
+		 * strings are longer than 12 columns and therefore
+		 * break alignment.
+		 */
+		width =3D atoi(_("<wt-status.c:width>"));
+		if (width <=3D 0 || width > 32)
+			width =3D 12;
+	}
+	if (width > utf8_strwidth(what) + 1)
+		len =3D width - utf8_strwidth(what) - 1;
+	else
+		len =3D 0;
+	if (status =3D=3D DIFF_STATUS_COPIED || status =3D=3D DIFF_STATUS_REN=
AMED)
+		status_printf_more(s, c, "%s:%.*s%s -> %s",
+				   what, len, spaces, one, two);
+	else
+		status_printf_more(s, c, "%s:%.*s%s",
+				   what, len, spaces, one);
 	if (extra.len) {
 		status_printf_more(s, color(WT_STATUS_HEADER, s), "%s", extra.buf);
 		strbuf_release(&extra);
--=20
1.8.2.83.gc99314b
