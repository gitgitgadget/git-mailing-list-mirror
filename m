From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/12] utf8.c: move display_mode_esc_sequence_len() for use by other functions
Date: Sat, 30 Mar 2013 16:35:03 +0700
Message-ID: <1364636112-15065-4-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 10:36:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsCb-0002fx-7M
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188Ab3C3Jf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:35:28 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36278 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab3C3Jf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 05:35:27 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so556171pdi.7
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=IBal+T+NC1W4IefMg74Wmfy4mziDb4jAK42OGED1veM=;
        b=rsn1Ivz+jU83/9R2i5KoQQOFMPvMPHfYtL6KdmZLcKXeWm3+xgZwUla25GXPzPLiRw
         Np3yoDzLsg7NVzIAz1ytAOA5fWLygk+jIL1db8N4hZG9XjaFBDoS+SSVQJoIlcR52gfM
         iSxwMRfveuNdwcsSN4+6N5aU8aPKvJF+6wVWZp3q0FvKK/lvISpOecp81/R6zrfZSJFv
         30XgGp71SUmwIESnyA0bV0rOXy524JFJMLWlbv3p1Z1+1M3J5EDNoLhfplQEhs8CB8Iv
         EeBxhuOj98MYO1M/glql14YGo5euIhAdEf3y1U0HwR1yCx/IvQbqFb63Uezbxe/O/f/8
         Y73g==
X-Received: by 10.68.88.37 with SMTP id bd5mr7719895pbb.209.1364636126206;
        Sat, 30 Mar 2013 02:35:26 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id oq3sm6814277pac.16.2013.03.30.02.35.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 02:35:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 16:35:31 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219572>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/utf8.c b/utf8.c
index 1087870..82c2ddf 100644
--- a/utf8.c
+++ b/utf8.c
@@ -9,6 +9,20 @@ struct interval {
   int last;
 };
=20
+static size_t display_mode_esc_sequence_len(const char *s)
+{
+	const char *p =3D s;
+	if (*p++ !=3D '\033')
+		return 0;
+	if (*p++ !=3D '[')
+		return 0;
+	while (isdigit(*p) || *p =3D=3D ';')
+		p++;
+	if (*p++ !=3D 'm')
+		return 0;
+	return p - s;
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int =
max)
 {
@@ -303,20 +317,6 @@ static void strbuf_add_indented_text(struct strbuf=
 *buf, const char *text,
 	}
 }
=20
-static size_t display_mode_esc_sequence_len(const char *s)
-{
-	const char *p =3D s;
-	if (*p++ !=3D '\033')
-		return 0;
-	if (*p++ !=3D '[')
-		return 0;
-	while (isdigit(*p) || *p =3D=3D ';')
-		p++;
-	if (*p++ !=3D 'm')
-		return 0;
-	return p - s;
-}
-
 /*
  * Wrap the text, if necessary. The variable indent is the indent for =
the
  * first line, indent2 is the indent for all other lines.
--=20
1.8.2.83.gc99314b
