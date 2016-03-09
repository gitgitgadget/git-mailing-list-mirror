From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 04/48] builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
Date: Wed,  9 Mar 2016 18:48:32 +0100
Message-ID: <1457545756-20616-5-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHS-0007US-D3
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933641AbcCIRwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:14 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35316 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933628AbcCIRwK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:10 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so190188547wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K9oJAJ4vYAkp/jdE1+Tj8Xyf/8EBvzHMp9rDhggaSns=;
        b=eowJBsSfwsPeck8ffDrekVMIf+vTDNocvNpf6P7qomM9EXTzdYTbjZV408kiV0sBp1
         fk5OlbZ9MYesgnxs3m8G3Hq+XH01bqUYHb2YWGXViTqrdlPurvdskdmVzjMZEAlX4oX/
         f/WzQLfcMJl7kr+6zQM+0RP8emURXtHGOh5LzxAm5rm6JWDEI//KFGJpTmJZtrS+7Zz2
         iWxRFNXu5XLOHlGyc/9+vmTFRbLT8Sq1sBoMZvkzoB2TgR1GuM/7q3ZE8pjeFjvfLNVx
         hu8YoZMOYK4EZCigCw3Au1A9j7+JV2fGpulKAjxMHVbb3c8dLykLrUntcrC3+n/lXDJJ
         p8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K9oJAJ4vYAkp/jdE1+Tj8Xyf/8EBvzHMp9rDhggaSns=;
        b=VkfgJ9M53+O+1bJVt+BCtdw9GJkwb3+3Z1fBFLQFf0jpUOkKT087EbBEakWMhF6/v+
         co19ki+UEDQ94Iv/ojWGF4SyCZrFw4+o5J73u8GXc8CruzhfL7UMW1fAejnJ1RsnBdy5
         4oGKdBSHaYYGWx6vUpBN6rmC88flbdAYkv/KrOY/nTcypzYnrPIDE/qRmTnn7cbGLMMR
         jaaSz7BCTeaxtEO65FLXh5oW7VR3kc1z3XIG4S/yi35q5cPd4yulcLen4dJfbF3WxFXH
         HHU0hVC9c0eH4TgQIMOsXfL66tsM1IFbUQRDqs8WsPx83ft0jxiqaXYK11Dl1pY5t6w/
         pwwQ==
X-Gm-Message-State: AD7BkJJDM6wBSWsV8NllFzapk+lRXE7DrMazg+fPocQxGy7xsrA15k2QItsO3HbiqH7VMQ==
X-Received: by 10.194.192.36 with SMTP id hd4mr34607188wjc.85.1457545928781;
        Wed, 09 Mar 2016 09:52:08 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:07 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288494>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 125 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 71 insertions(+), 54 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c99c859..7d7a8ab 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2244,6 +2244,74 @@ static void update_pre_post_images(struct image *preimage,
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
@@ -2253,7 +2321,7 @@ static int match_fragment(struct image *img,
 			  int match_beginning, int match_end)
 {
 	int i;
-	char *fixed_buf, *buf, *orig, *target;
+	char *fixed_buf, *orig, *target;
 	struct strbuf fixed;
 	size_t fixed_len, postlen;
 	int preimage_limit;
@@ -2314,6 +2382,7 @@ static int match_fragment(struct image *img,
 		 * There must be one non-blank context line that match
 		 * a line before the end of img.
 		 */
+		char *buf;
 		char *buf_end;
 
 		buf = preimage->buf;
@@ -2334,59 +2403,7 @@ static int match_fragment(struct image *img,
 	 * we need it to adjust whitespace if we match.
 	 */
 	if (ws_ignore_action == ignore_ws_change) {
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
+		return line_by_line_fuzzy_match(img, preimage, postimage, try, try_lno, preimage_limit);
 	}
 
 	if (ws_error_action != correct_ws_error)
-- 
2.8.0.rc1.49.gca61272
