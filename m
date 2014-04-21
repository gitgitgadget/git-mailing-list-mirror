From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 1/2] bugfix: fix broken time_buf paddings for git-blame
Date: Mon, 21 Apr 2014 14:02:03 +0800
Message-ID: <e8340b76f5c2b676a9594018b3385ead451412fa.1398059411.git.worldhello.net@gmail.com>
References: <cover.1398059411.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 08:02:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc7JS-0006YW-S3
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 08:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbaDUGCh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Apr 2014 02:02:37 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:49256 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaDUGCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 02:02:36 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so3408010pab.10
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=bVIHJDPs3Hdh4CMM/91xGo7xieTGZkKugF8HTH3XlXw=;
        b=f0mtAdWDrnjJLkdsOFpdjeNQkqwB2zN5O3iOgz7r2rLS29lBCzZMN61AEM7O/nrA3p
         VF83BXPKNwDnG8Ik/uKMCZ6M+m3sVpH6PM8VY/yxvJEMPrjr3Bk4Bytn5Dh73tffgYVf
         wF+FShZ31yTV+zTxebgmz4U+1Yl9su2+8kP2NY4hTSeyvuOx7DsL0R//CIBkx2fbeVSK
         fKLj4G7OTvY4zswncAUAiTbFasX7gF34Ln69VLyuUlPzs840RdQK1IcjpqfapggYV2zt
         e+QJSf2Y8oFrQsS6R4gqcRlDopvalso0AJSxh1lJaIpo0HKVQASMIcRrrqoD8CP4sIXa
         qzcw==
X-Received: by 10.66.163.164 with SMTP id yj4mr36539584pab.91.1398060156102;
        Sun, 20 Apr 2014 23:02:36 -0700 (PDT)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPSA id vx10sm181140376pac.17.2014.04.20.23.02.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Apr 2014 23:02:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.476.ga74def0
In-Reply-To: <cover.1398059411.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1398059411.git.worldhello.net@gmail.com>
References: <7vbnvvllx4.fsf@alter.siamese.dyndns.org> <cover.1398059411.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246607>

Command `git blame --date relative` aligns the date field with a
fixed-width (defined by blame_date_width), and if time_str is shorter
than that, it adds spaces for padding.  But there are two bugs in the
following codes:

        time_len =3D strlen(time_str);
        ...
        memset(time_buf + time_len, ' ', blame_date_width - time_len);

1. The type of blame_date_width is size_t, which is unsigned.  If
   time_len is greater than blame_date_width, the result of
   "blame_date_width - time_len" will never be a negative number, but a
   really big positive number, and will cause memory overwrite.

   This bug can be triggered if either l10n message for function
   show_date_relative() in date.c is longer than 30 characters, then
   `git blame --date relative` may exit abnormally.

2. When show blame information with relative time, the UTF-8 characters
   in time_str will break the alignment of columns after the date field=
=2E
   This is because the time_buf padding with spaces should have a
   constant display width, not a fixed strlen size.  So we should call
   utf8_strwidth() instead of strlen() for width calibration.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/blame.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 88cb799..35e95db 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1556,22 +1556,29 @@ static void assign_blame(struct scoreboard *sb,=
 int opt)
 static const char *format_time(unsigned long time, const char *tz_str,
 			       int show_raw_time)
 {
-	static char time_buf[128];
+	static struct strbuf time_buf =3D STRBUF_INIT;
=20
+	strbuf_reset(&time_buf);
 	if (show_raw_time) {
-		snprintf(time_buf, sizeof(time_buf), "%lu %s", time, tz_str);
+		strbuf_addf(&time_buf, "%lu %s", time, tz_str);
 	}
 	else {
 		const char *time_str;
-		int time_len;
+		size_t time_width;
 		int tz;
 		tz =3D atoi(tz_str);
 		time_str =3D show_date(time, tz, blame_date_mode);
-		time_len =3D strlen(time_str);
-		memcpy(time_buf, time_str, time_len);
-		memset(time_buf + time_len, ' ', blame_date_width - time_len);
+		strbuf_addstr(&time_buf, time_str);
+		/*
+		 * Add space paddings to time_buf to display a fixed width
+		 * string, and use time_width for display width calibration.
+		 */
+		for (time_width =3D utf8_strwidth(time_str);
+		     time_width < blame_date_width;
+		     time_width++)
+			strbuf_addch(&time_buf, ' ');
 	}
-	return time_buf;
+	return time_buf.buf;
 }
=20
 #define OUTPUT_ANNOTATE_COMPAT	001
--=20
1.9.2.476.ga74def0
