From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/2] bugfix: fix broken time_buf paddings for git-blame
Date: Mon, 21 Apr 2014 00:13:52 +0800
Message-ID: <2742234ee9199b26e646f30b6ae20a1c9bfe48f7.1398010052.git.worldhello.net@gmail.com>
References: <cover.1398010052.git.worldhello.net@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 18:14:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbuON-00026t-Nr
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 18:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbaDTQOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 12:14:47 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:49839 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbaDTQOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 12:14:17 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so2930947pde.39
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+D7niVwUY1rZN8nz4fMak1Q0nsqcLEZwFBQTjdEOPM8=;
        b=hVfDmhewsCrBapw6y7vl0QK1Zq3R5J32BcUfd/3N2SlTKkOtwbPCqBQVgut+KX6LG3
         +uTzNe/Tuwt9WOOxHA3HTYbwKYsJkhelcHfPVVcnLPuDHBDXejYb77LegFzod8nAWPsx
         c4Ao8DTyzLWT0xIzhLs+o/LxSIDj0W7Q3LbBz5KQ1DspbpWFIog5RlOuECJSrL5bmkdA
         lZ8/btuuEYIQGwD2D8ssgMoRrRxJqarztVdAYbkBWyVwFI5/SqkNaw1TLeMb2P/8mwa3
         J0f1szY407i74HsMfooG5j1ba0oMTmBFnOAvRQFtI1uS1wktR/06s/JZRlz7UJmY564M
         h/2g==
X-Received: by 10.66.65.138 with SMTP id x10mr33487321pas.17.1398010456872;
        Sun, 20 Apr 2014 09:14:16 -0700 (PDT)
Received: from localhost.localdomain ([114.241.217.8])
        by mx.google.com with ESMTPSA id dy7sm173141497pad.9.2014.04.20.09.14.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Apr 2014 09:14:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.3.g444188f.dirty
In-Reply-To: <cover.1398010052.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1398010052.git.worldhello.net@gmail.com>
References: <CACsJy8BTBwqFZUU3i3cuv40B6AHw5SRY9DZN2PoKL4XzgEL2eA@mail.gmail.com> <cover.1398010052.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246552>

When `git blame` shows date field in a fixed width (as long as
blame_date_width characters), if time_str shorter than that, add spaces
for padding.  But there are two bugs in the following codes:

        memcpy(time_buf, time_str, time_len);
        memset(time_buf + time_len, ' ', blame_date_width - time_len);

1. The type of blame_date_width is size_t (unsigned int).  If time_len
   is greater than blame_ate_width, "blame_date_width - time_len" will
   never be a negative number, but a really big positive number, and
   will cause memory overwrite.

   This bug can be triggered if either l10n message for function
   show_date_relative() in date.c is longer then 30 charcters, then
   `git blame --date relative` may fail.

2. When show blame information with relative time, the UTF-8 characters
   in time_str will break the alignment of columns after the date field.
   This is because the time_buf padding with spaces should have a
   constant display width, not a fixed strlen size.  So we should call
   utf8_strwidth() instead of strlen() for calibration.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/blame.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 88cb799..0a0a858 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1556,22 +1556,31 @@ static void assign_blame(struct scoreboard *sb, int opt)
 static const char *format_time(unsigned long time, const char *tz_str,
 			       int show_raw_time)
 {
-	static char time_buf[128];
+	static struct strbuf time_buf = STRBUF_INIT;
 
+	strbuf_reset(&time_buf);
 	if (show_raw_time) {
-		snprintf(time_buf, sizeof(time_buf), "%lu %s", time, tz_str);
+		strbuf_addf(&time_buf, "%lu %s", time, tz_str);
 	}
 	else {
 		const char *time_str;
+		size_t time_width;
 		int time_len;
 		int tz;
 		tz = atoi(tz_str);
 		time_str = show_date(time, tz, blame_date_mode);
 		time_len = strlen(time_str);
-		memcpy(time_buf, time_str, time_len);
-		memset(time_buf + time_len, ' ', blame_date_width - time_len);
+		strbuf_add(&time_buf, time_str, time_len);
+		/*
+		 * Add space paddings to time_buf to display a fixed width
+		 * string, and use time_width for display width calibration.
+		 */
+		for (time_width = utf8_strwidth(time_str);
+		     time_width < blame_date_width;
+		     time_width++)
+			strbuf_addch(&time_buf, ' ');
 	}
-	return time_buf;
+	return time_buf.buf;
 }
 
 #define OUTPUT_ANNOTATE_COMPAT	001
-- 
2.0.0.rc0.3.g444188f.dirty
