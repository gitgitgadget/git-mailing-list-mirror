From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 09/13] pretty: split color parsing into a separate function
Date: Fri, 19 Apr 2013 09:08:48 +1000
Message-ID: <1366326532-28517-10-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:10:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxy1-0007yn-Ft
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936621Ab3DRXKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:10:07 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34538 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936487Ab3DRXKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:10:05 -0400
Received: by mail-pd0-f169.google.com with SMTP id 14so20385pdc.28
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Q+S8Y4TRZ6E3A/hpu5iNUimZCXin/pww4pFirK5UCvs=;
        b=YGqGvz2JTKwmP2my20HCw0GW9HYwRKNpQG5wy0WDdKXF3+gSLZ/r4w5oynSODbFDSV
         2OFaM+0COFGRElaI/YBYT54QGF/wGqNG9I5IuAwmJHPhTLIs95pbhxwp878wuL4Sav7B
         8HiaIrjeqGySJAZ3UKsJAEIbGPeraJDzW89MJtJIsopjFBBjSrF1uwnujPaI0+GH3X8/
         LCuEk3T6Wz8buYulWTMVTm3XhXT0rDxVpe0MVdsCkqtWa8t+wOq/KssSYKGhZh8KKN6b
         91DivfuXCHBwaL64RLsVAB8XyiwbPVB4dP8OsAws47QvPc7rMnCD8H/fM957lgwggfDC
         45zQ==
X-Received: by 10.66.50.138 with SMTP id c10mr15143297pao.220.1366326605393;
        Thu, 18 Apr 2013 16:10:05 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id be7sm12345022pad.20.2013.04.18.16.10.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:10:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:09:55 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221711>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c | 71 +++++++++++++++++++++++++++++++++++---------------------=
--------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/pretty.c b/pretty.c
index 5947275..e0413e3 100644
--- a/pretty.c
+++ b/pretty.c
@@ -954,6 +954,44 @@ static int format_reflog_person(struct strbuf *sb,
 	return format_person_part(sb, part, ident, strlen(ident), dmode);
 }
=20
+static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
+			  const char *placeholder,
+			  struct format_commit_context *c)
+{
+	if (placeholder[1] =3D=3D '(') {
+		const char *begin =3D placeholder + 2;
+		const char *end =3D strchr(begin, ')');
+		char color[COLOR_MAXLEN];
+
+		if (!end)
+			return 0;
+		if (!prefixcmp(begin, "auto,")) {
+			if (!want_color(c->pretty_ctx->color))
+				return end - placeholder + 1;
+			begin +=3D 5;
+		}
+		color_parse_mem(begin,
+				end - begin,
+				"--pretty format", color);
+		strbuf_addstr(sb, color);
+		return end - placeholder + 1;
+	}
+	if (!prefixcmp(placeholder + 1, "red")) {
+		strbuf_addstr(sb, GIT_COLOR_RED);
+		return 4;
+	} else if (!prefixcmp(placeholder + 1, "green")) {
+		strbuf_addstr(sb, GIT_COLOR_GREEN);
+		return 6;
+	} else if (!prefixcmp(placeholder + 1, "blue")) {
+		strbuf_addstr(sb, GIT_COLOR_BLUE);
+		return 5;
+	} else if (!prefixcmp(placeholder + 1, "reset")) {
+		strbuf_addstr(sb, GIT_COLOR_RESET);
+		return 6;
+	} else
+		return 0;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -967,38 +1005,7 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
-		if (placeholder[1] =3D=3D '(') {
-			const char *begin =3D placeholder + 2;
-			const char *end =3D strchr(begin, ')');
-			char color[COLOR_MAXLEN];
-
-			if (!end)
-				return 0;
-			if (!prefixcmp(begin, "auto,")) {
-				if (!want_color(c->pretty_ctx->color))
-					return end - placeholder + 1;
-				begin +=3D 5;
-			}
-			color_parse_mem(begin,
-					end - begin,
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
+		return parse_color(sb, placeholder, c);
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
--=20
1.8.2.82.gc24b958
