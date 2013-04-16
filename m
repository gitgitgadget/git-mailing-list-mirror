From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/13] utf8.c: move display_mode_esc_sequence_len() for use by other functions
Date: Tue, 16 Apr 2013 18:24:54 +1000
Message-ID: <1366100702-31745-6-git-send-email-pclouds@gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 10:26:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1De-00063u-Um
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935662Ab3DPI0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:26:21 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45254 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab3DPI0U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:26:20 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so219047pab.32
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=vaE85W+SLnp48+chFbC41Q0Ns7CNbnEmuRtqugRQTLY=;
        b=hmo8ovmZR+tHsRaG28uUuodf9vFJCSZUUMjUVwWmDKBYO1d2/3wRWMzA6dTRjPi2SS
         InnVrsR/qalgn2a900jBABRRsubiaSkYwUy5gI8f/17cUyX55cGd3PFW/W3NRxT9TMDb
         lNxLIHzDaftyu0ygcHBBRTFo8YYEWG8FBFX/D5AaQ5AmB+gdafL1ctBdWXvBsSOtShzW
         xW0VjmKPqX4GapxkXXkjsdCNQvEgEtv4T5Y9sYgkT0BkHPbp7qHGsk/Ddx8AwAFajOh8
         kinIXA8WzmIbqkAwgCli/AeV5Q9v4K0Fw0RnDWUMowsCPbMVNAlV6NxzWzoX/bKbgOn2
         Fhng==
X-Received: by 10.66.118.5 with SMTP id ki5mr2317309pab.74.1366100779456;
        Tue, 16 Apr 2013 01:26:19 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id fc8sm1719833pad.21.2013.04.16.01.26.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 01:26:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Apr 2013 18:26:05 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221384>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/utf8.c b/utf8.c
index 7f64857..6ed93c3 100644
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
1.8.2.82.gc24b958
