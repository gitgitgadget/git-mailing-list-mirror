From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/9] utf8.c: move display_mode_esc_sequence_len() for use by other functions
Date: Sun, 23 Sep 2012 16:10:28 +0700
Message-ID: <1348391433-11300-5-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
 <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 11:17:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFiJz-0001M3-JP
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 11:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab2IWJRm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 05:17:42 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35801 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2IWJRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 05:17:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5429111pbb.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ed247ghSvi8GStOCHym4zvh7F2lKt/aabeayUpVOj1Q=;
        b=uIxE0rUO6y3hBS/QjZSQMhV8nQyQPIr3tgU6ThdGqpE0J1iqROyVdG3stZh39ZvjHB
         y8gwZ9u8CKSGoldJ8NpH4i6SzkmwFRPpQKwGQzCA8FPfYdeE1kmb39yrGPot1n1ULEmR
         NAZ6lU3+N2DyZGqlhUUmXCc6J6zhWlWEls1W5yXhFbzgqVTKSNu6vZhGYFITos4CMpiZ
         oGMah29/dleLwkN3PD3NlZHXDgQ4dREyw9vi18iat4e8oqn4ia6ov+2pADJ4KCYlkUof
         3ZZuTbBi5B8H7aoLQw8AMlYc0PF77E0OKzteYYS9NF/+vfeaWmdjfWf5SEdEqQmqNvfX
         7btA==
Received: by 10.68.220.137 with SMTP id pw9mr28514065pbc.1.1348391861007;
        Sun, 23 Sep 2012 02:17:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.47.110])
        by mx.google.com with ESMTPS id ty1sm7835216pbc.76.2012.09.23.02.17.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Sep 2012 02:17:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Sep 2012 16:10:58 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348391433-11300-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206229>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/utf8.c b/utf8.c
index a544f15..18a4d9c 100644
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
1.7.12.1.406.g6ab07c4
