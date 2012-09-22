From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] pretty: split parsing %C into a separate function
Date: Sat, 22 Sep 2012 11:22:15 +0700
Message-ID: <1348287739-12128-3-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 06:23:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHFA-0003Pi-4x
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242Ab2IVEWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 00:22:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61105 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab2IVEWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:22:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3905556pbb.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OnsKOK5xEooSQPEYy5IUI0mQ8e+zZW+xbCqtWH6iZo0=;
        b=EBPLe8nj4MYgcibbFJiiWhWXuVYiMDdXy6hT3pdFd/XBD+Zzm71v0t1rnqokvl1fES
         HKdAyEeyAELYD3AtZeSqWBSKqrTAHvtqq2N6a9zt9KqHWJ6js+UEir/QWwsy0irw+9tr
         RYA88Jra91qlBCw7kEDivWfRl0VSUEyfc7B7bmn7wT9lbi7D4b002+8XNUmAsAjKK4P0
         ugUxp76QwnlbLgbq9AiL68WjWWN1DOQYPhIDnAfgnc8b73zccu+v2GD4Qs8Mj43BaK28
         Uk8yMltk3Pw/xoRMf6VMJBac7oD070LFjNV0Yt39tlo5X87A5sqGj2UFfJiWMHOc0Kvy
         k3YQ==
Received: by 10.68.225.199 with SMTP id rm7mr20591096pbc.150.1348287742437;
        Fri, 21 Sep 2012 21:22:22 -0700 (PDT)
Received: from lanh ([115.74.43.144])
        by mx.google.com with ESMTPS id jv10sm586190pbc.23.2012.09.21.21.22.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 21:22:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Sep 2012 11:22:33 +0700
X-Mailer: git-send-email 1.7.12.1.384.g7b808e7
In-Reply-To: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206182>


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
1.7.12.1.384.g7b808e7
