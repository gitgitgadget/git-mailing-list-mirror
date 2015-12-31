From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] diff --highlight-words: actually highlight words
Date: Thu, 31 Dec 2015 19:37:37 +0700
Message-ID: <1451565457-18756-8-git-send-email-pclouds@gmail.com>
References: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 13:38:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcUz-0001mp-6d
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbbLaMi3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 07:38:29 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36568 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbbLaMi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:38:28 -0500
Received: by mail-pa0-f52.google.com with SMTP id yy13so59485359pab.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 04:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XrCmEJWhO7WAA1HoRlzlNBXQB3TzqjBX50qQqJl95+8=;
        b=0COm2Tq2n/4G7mGYovmoF2GiC+A2dasUqHe4dicmJf3n/+sQHfpHUqUO6XhIoMGpN2
         4YZ8QvyznywjCAHL3nC0Jbxg73vkR2ZrGS6+BtF9g+oiNqVtiveK5aQ6Q7GU2E44l3FD
         bmRCCrKWhjjXpWxeAaFFaIb/vz9D6c7ig0W7KVIMeIDNWdt1xW/gkjE5s8WWj58RLmVp
         FVfiHqZ2sOInGZ99bhxip2vRDNDv/TG0e18qkhRxV7vQtLTGtrtotTtx1lFEP6Y0ZrTw
         NvUUjmts4+LgyCZ3LmdBgQQ8GyQ4Yl48M+x3RUR9paAvc2kEDWUamEtJmr6H69j9pPJR
         e7eQ==
X-Received: by 10.67.3.170 with SMTP id bx10mr67004297pad.34.1451565507804;
        Thu, 31 Dec 2015 04:38:27 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id u14sm96746256pfi.58.2015.12.31.04.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 04:38:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Dec 2015 19:38:23 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283243>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 47d22e3..68a847d 100644
--- a/diff.c
+++ b/diff.c
@@ -457,6 +457,50 @@ struct tagged_pointer {
 	enum pointer_tag tag;
 };
=20
+static void emit_tagged_line(struct diff_options *o, const char *set,
+			     const char *line, int len,
+			     struct tagged_pointer *begin,
+			     struct tagged_pointer *end)
+{
+	struct tagged_pointer *current;
+	FILE *file =3D o->file;
+	const char *last_color =3D set;
+
+	for (current =3D begin; current < end; current++) {
+		struct tagged_pointer *next =3D current + 1;
+		const char *start =3D current->str;
+		const char *end =3D next->str;
+		const char *color =3D NULL;
+
+		switch (current->tag) {
+		case TAG_END_WORD:
+			color =3D set;
+			break;
+
+		case TAG_BEGIN_OLD_WORD:
+			color =3D GIT_COLOR_BG_RED GIT_COLOR_YELLOW;
+			break;
+
+		case TAG_BEGIN_NEW_WORD:
+			color =3D GIT_COLOR_BG_GREEN GIT_COLOR_BLUE;
+			break;
+
+		default:
+			break;
+		}
+
+		if (color && color !=3D last_color) {
+			if (color =3D=3D set)
+				fputs(GIT_COLOR_RESET, file);
+			fputs(color, file);
+			last_color =3D color;
+		}
+		while (end > start && end[-1] =3D=3D '\n')
+			end--;
+		fwrite(start, end - start, 1, file);
+	}
+}
+
 static void emit_line_0(struct diff_options *o, const char *set, const=
 char *reset,
 			int first, const char *line, int len,
 			struct tagged_pointer *begin,
@@ -487,7 +531,10 @@ static void emit_line_0(struct diff_options *o, co=
nst char *set, const char *res
 		fputs(set, file);
 		if (!nofirst)
 			fputc(first, file);
-		fwrite(line, len, 1, file);
+		if (begin)
+			emit_tagged_line(o, set, line, len, begin, end);
+		else
+			fwrite(line, len, 1, file);
 		fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
@@ -531,7 +578,7 @@ static void emit_line_checked(const char *reset,
 			ws =3D NULL;
 	}
=20
-	if (!ws)
+	if (!ws || begin)
 		emit_line_0(ecbdata->opt, set, reset, sign,
 			    line, len, begin, end);
 	else if (sign =3D=3D '+' && new_blank_line_at_eof(ecbdata, line, len)=
)
@@ -1312,7 +1359,7 @@ static void diff_words_flush_unified(struct emit_=
callback *ecb,
 		emit_line_checked(reset, ecb, begin_line->str,
 				  end_line->str - begin_line->str,
 				  color, ws_error_highlight, sign,
-				  NULL, NULL);
+				  begin_line, end_line);
 	}
 	b->mark_nr =3D 0;
 }
--=20
2.3.0.rc1.137.g477eb31
