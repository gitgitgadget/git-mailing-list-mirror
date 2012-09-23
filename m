From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/9] pretty: split parsing %C into a separate function
Date: Sun, 23 Sep 2012 16:10:26 +0700
Message-ID: <1348391433-11300-3-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
 <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 11:17:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFiJn-0001Ds-Qy
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 11:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab2IWJRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 05:17:30 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56925 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2IWJR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 05:17:29 -0400
Received: by padhz1 with SMTP id hz1so414721pad.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KFFO0xLE6+rnNPS3ugp/pP9i9TJNzc8YAxJhvqZ1TIg=;
        b=lL8ouspfuryDJlNWB9muluMzz/JLsKYzp+I5W0AjfmNeREULV+cwXC0uhA4i+TmT7l
         gsbRB1ViX60hx3XEX01RMfkb0Zdt/uz6O8qI/3uF1PDxV0uYG8Q2sHfO8aWyY3rPKoSr
         er+EZcFbsyoMr28AV66jAwyYfvLyGGhs9eYKJN3GTCuY2A3DetiF7hBM6Zps/L26kytG
         tP/GhCZ0In/pdLFhsy4pjngY3P7skBWXe8IhdF2fkw825MyrlVDVntWM5cYE6LNfiSAa
         FDKs/aNMVlu9Vnduds3coFu/Gwe7iJXw/Fco1xiAxONnmFj4I/DUebEuIxrUzFrf2XbK
         X+vA==
Received: by 10.68.222.42 with SMTP id qj10mr28474586pbc.117.1348391849478;
        Sun, 23 Sep 2012 02:17:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.47.110])
        by mx.google.com with ESMTPS id y2sm4882494pax.29.2012.09.23.02.17.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Sep 2012 02:17:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Sep 2012 16:10:47 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206227>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c | 60 +++++++++++++++++++++++++++++++++++---------------------=
----
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/pretty.c b/pretty.c
index e910679..93c96c2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -863,6 +863,40 @@ static int format_reflog_person(struct strbuf *sb,
 	return format_person_part(sb, part, ident, strlen(ident), dmode);
 }
=20
+static size_t parse_color_placeholder(struct strbuf *sb,
+				      const char *placeholder,
+				      struct format_commit_context *c)
+{
+	if (placeholder[1] =3D=3D '(') {
+		const char *end =3D strchr(placeholder + 2, ')');
+		char color[COLOR_MAXLEN];
+		if (!end)
+			return 0;
+		color_parse_mem(placeholder + 2,
+				end - (placeholder + 2),
+				"--pretty format", color);
+		strbuf_addstr(sb, color);
+		return end - placeholder + 1;
+	}
+	if (!prefixcmp(placeholder + 1, "red")) {
+		strbuf_addstr(sb, GIT_COLOR_RED);
+		return 4;
+	}
+	if (!prefixcmp(placeholder + 1, "green")) {
+		strbuf_addstr(sb, GIT_COLOR_GREEN);
+		return 6;
+	}
+	if (!prefixcmp(placeholder + 1, "blue")) {
+		strbuf_addstr(sb, GIT_COLOR_BLUE);
+		return 5;
+	}
+	if (!prefixcmp(placeholder + 1, "reset")) {
+		strbuf_addstr(sb, GIT_COLOR_RESET);
+		return 6;
+	}
+	return 0;
+}
+
 static size_t format_commit_one(struct strbuf *sb, const char *placeho=
lder,
 				void *context)
 {
@@ -875,31 +909,7 @@ static size_t format_commit_one(struct strbuf *sb,=
 const char *placeholder,
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
-		if (placeholder[1] =3D=3D '(') {
-			const char *end =3D strchr(placeholder + 2, ')');
-			char color[COLOR_MAXLEN];
-			if (!end)
-				return 0;
-			color_parse_mem(placeholder + 2,
-					end - (placeholder + 2),
-					"--pretty format", color);
-			strbuf_addstr(sb, color);
-			return end - placeholder + 1;
-		}
-		if (!prefixcmp(placeholder + 1, "red")) {
-			strbuf_addstr(sb, GIT_COLOR_RED);
-			return 4;
-		} else if (!prefixcmp(placeholder + 1, "green")) {
-			strbuf_addstr(sb, GIT_COLOR_GREEN);
-			return 6;
-		} else if (!prefixcmp(placeholder + 1, "blue")) {
-			strbuf_addstr(sb, GIT_COLOR_BLUE);
-			return 5;
-		} else if (!prefixcmp(placeholder + 1, "reset")) {
-			strbuf_addstr(sb, GIT_COLOR_RESET);
-			return 6;
-		} else
-			return 0;
+		return parse_color_placeholder(sb, placeholder, c);
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
--=20
1.7.12.1.406.g6ab07c4
