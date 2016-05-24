From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 05/49] builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
Date: Tue, 24 May 2016 10:10:42 +0200
Message-ID: <20160524081126.16973-6-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:16:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Vx-0002MI-5K
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbcEXIQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:16:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35080 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbcEXILy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:11:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id f75so3652149wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gr3PIH5V8vZTPJ/fGijIvTzsLcWSeHrzhjlbbQ/6apg=;
        b=NeU2BonNRIhlTYozIDGNitlolTh3PbDiQDMjRyx9pID5K27ls83TMEEq0L/GJ0q0OR
         5KESEhNmjyODkCR6NlqAr4PgalZwp9IzM6FRUDnsPGFTYIM50vnXRXM/yaXA+tPn1/ki
         XIaprEZm1tZj9FJMLBHaA6uA7ecXPDNdam49UH+m5+qC/A8ziQDLAcWbxuXyq4Y0oVXC
         M+FEBJgmJYT+OYS/U9FEXIyc99X1V8vKTMJ3uIXvy6xmLZF/L/WeRAgsZ3TlSwNKHDXL
         seNYt9+iYLF+a6ejoaJ0rfE4Jf/KNBjp+iQ5mxcCIenUnVpBH1it9RJvmnp+/D1oCfJF
         0JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gr3PIH5V8vZTPJ/fGijIvTzsLcWSeHrzhjlbbQ/6apg=;
        b=bK5xVVrdxIg0+MQwUpwCjtSWY+ThffPN1brLk1b7/JX8S7VrPEXlgyoUEs0qCOY/NT
         qgYfv+iuoxlQf2JbQPj7lx/1z7bgyEsOu8Leg7Py7NUB5/j408F7iYMc112ku0Mh0tjc
         khwcEpf4SHMxbLGdX+j1g0SpNU6eI//wMKu/m9i3SL3LAXSAm+29hVwIpgGpydLTUH1Y
         lgPnk89nNJ5D2TbcIWwORlabcKBVRHh0bLge+1Ir/7q1mSxBI6Ki7dCrFG89UTidQBgf
         PPFyE7lM+pi1EMfXFof4r1xPdso1aK731qiQzuew3woKTfN3Sx4hJri8YyG83ZsF0miZ
         Mn7A==
X-Gm-Message-State: ALyK8tLQepUC2HxpaUlsmwDHmQWq1mkpKnKyX6OqWFjeh0gHgisgtCK1QfG2POqbVDA1MQ==
X-Received: by 10.194.171.7 with SMTP id aq7mr2699147wjc.8.1464077512955;
        Tue, 24 May 2016 01:11:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:52 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295476>

The match_fragment() function is very big and contains a big special case
algorithm that does line by line fuzzy matching. So let's extract this
algorithm in a separate line_by_line_fuzzy_match() function.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 126 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 71 insertions(+), 55 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index bb8bf7f..7bab466 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2242,6 +2242,74 @@ static void update_pre_post_images(struct image *preimage,
 	postimage->nr -= reduced;
 }
 
+static int line_by_line_fuzzy_match(struct image *img,
+				    struct image *preimage,
+				    struct image *postimage,
+				    unsigned long try,
+				    int try_lno,
+				    int preimage_limit)
+{
+	int i;
+	size_t imgoff = 0;
+	size_t preoff = 0;
+	size_t postlen = postimage->len;
+	size_t extra_chars;
+	char *buf;
+	char *preimage_eof;
+	char *preimage_end;
+	struct strbuf fixed;
+	char *fixed_buf;
+	size_t fixed_len;
+
+	for (i = 0; i < preimage_limit; i++) {
+		size_t prelen = preimage->line[i].len;
+		size_t imglen = img->line[try_lno+i].len;
+
+		if (!fuzzy_matchlines(img->buf + try + imgoff, imglen,
+				      preimage->buf + preoff, prelen))
+			return 0;
+		if (preimage->line[i].flag & LINE_COMMON)
+			postlen += imglen - prelen;
+		imgoff += imglen;
+		preoff += prelen;
+	}
+
+	/*
+	 * Ok, the preimage matches with whitespace fuzz.
+	 *
+	 * imgoff now holds the true length of the target that
+	 * matches the preimage before the end of the file.
+	 *
+	 * Count the number of characters in the preimage that fall
+	 * beyond the end of the file and make sure that all of them
+	 * are whitespace characters. (This can only happen if
+	 * we are removing blank lines at the end of the file.)
+	 */
+	buf = preimage_eof = preimage->buf + preoff;
+	for ( ; i < preimage->nr; i++)
+		preoff += preimage->line[i].len;
+	preimage_end = preimage->buf + preoff;
+	for ( ; buf < preimage_end; buf++)
+		if (!isspace(*buf))
+			return 0;
+
+	/*
+	 * Update the preimage and the common postimage context
+	 * lines to use the same whitespace as the target.
+	 * If whitespace is missing in the target (i.e.
+	 * if the preimage extends beyond the end of the file),
+	 * use the whitespace from the preimage.
+	 */
+	extra_chars = preimage_end - preimage_eof;
+	strbuf_init(&fixed, imgoff + extra_chars);
+	strbuf_add(&fixed, img->buf + try, imgoff);
+	strbuf_add(&fixed, preimage_eof, extra_chars);
+	fixed_buf = strbuf_detach(&fixed, &fixed_len);
+	update_pre_post_images(preimage, postimage,
+			       fixed_buf, fixed_len, postlen);
+	return 1;
+}
+
 static int match_fragment(struct image *img,
 			  struct image *preimage,
 			  struct image *postimage,
@@ -2331,61 +2399,9 @@ static int match_fragment(struct image *img,
 	 * fuzzy matching. We collect all the line length information because
 	 * we need it to adjust whitespace if we match.
 	 */
-	if (ws_ignore_action == ignore_ws_change) {
-		size_t imgoff = 0;
-		size_t preoff = 0;
-		size_t postlen = postimage->len;
-		size_t extra_chars;
-		char *preimage_eof;
-		char *preimage_end;
-		for (i = 0; i < preimage_limit; i++) {
-			size_t prelen = preimage->line[i].len;
-			size_t imglen = img->line[try_lno+i].len;
-
-			if (!fuzzy_matchlines(img->buf + try + imgoff, imglen,
-					      preimage->buf + preoff, prelen))
-				return 0;
-			if (preimage->line[i].flag & LINE_COMMON)
-				postlen += imglen - prelen;
-			imgoff += imglen;
-			preoff += prelen;
-		}
-
-		/*
-		 * Ok, the preimage matches with whitespace fuzz.
-		 *
-		 * imgoff now holds the true length of the target that
-		 * matches the preimage before the end of the file.
-		 *
-		 * Count the number of characters in the preimage that fall
-		 * beyond the end of the file and make sure that all of them
-		 * are whitespace characters. (This can only happen if
-		 * we are removing blank lines at the end of the file.)
-		 */
-		buf = preimage_eof = preimage->buf + preoff;
-		for ( ; i < preimage->nr; i++)
-			preoff += preimage->line[i].len;
-		preimage_end = preimage->buf + preoff;
-		for ( ; buf < preimage_end; buf++)
-			if (!isspace(*buf))
-				return 0;
-
-		/*
-		 * Update the preimage and the common postimage context
-		 * lines to use the same whitespace as the target.
-		 * If whitespace is missing in the target (i.e.
-		 * if the preimage extends beyond the end of the file),
-		 * use the whitespace from the preimage.
-		 */
-		extra_chars = preimage_end - preimage_eof;
-		strbuf_init(&fixed, imgoff + extra_chars);
-		strbuf_add(&fixed, img->buf + try, imgoff);
-		strbuf_add(&fixed, preimage_eof, extra_chars);
-		fixed_buf = strbuf_detach(&fixed, &fixed_len);
-		update_pre_post_images(preimage, postimage,
-				fixed_buf, fixed_len, postlen);
-		return 1;
-	}
+	if (ws_ignore_action == ignore_ws_change)
+		return line_by_line_fuzzy_match(img, preimage, postimage,
+						try, try_lno, preimage_limit);
 
 	if (ws_error_action != correct_ws_error)
 		return 0;
-- 
2.8.3.443.gaeee61e
