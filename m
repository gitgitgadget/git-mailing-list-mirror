From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 05/83] builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
Date: Sun, 24 Apr 2016 15:33:05 +0200
Message-ID: <1461504863-15946-6-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:39:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFj-0001Ni-QW
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbcDXNe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:34:57 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34552 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbcDXNew (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:34:52 -0400
Received: by mail-wm0-f41.google.com with SMTP id v200so10008462wmv.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L/4qcp+N3TLS/zZhL5XNr6DhtDyKHckZtYnoZuK2Jt4=;
        b=P3jHvOW8asmORP+f1wfYjZJzpUE9l191RbwIM9alsQ7Sy0OqIZUaw8/IjeDYvmSXnf
         Cl+aXEp0RFQOZgOGtYw/VXmCYQeSxEVA/N3iUHByp2MaPqlux0V60ApHNbjtfKQBhiEC
         wEQRJNY8rcKdksY//xfq3yB0JDiPTCJo1OWALb++gOi6C5W2ctnmB0mmXhx4w0+15q0E
         jDFJut3yyA966/XImn9y++AfsWKIzkzv+UBUdb/bRE1H6GOJn2IKiqplGWarVhNz9Ie3
         AukyusKvg/Vy+WoO/idMRcYGsHv9CeNXq55XXA99xM/8SYtjWvRQEQiITxtckcFoK1fz
         /7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L/4qcp+N3TLS/zZhL5XNr6DhtDyKHckZtYnoZuK2Jt4=;
        b=itupt1/Vr3JXsuptU2Qf2nJIhIYAeb+xoQTb7CKNBq8nFXSCstF+TnRyO8LJAtNWXv
         yGaxI44JeT6KcUn/lZXyGZhbCCivi9/WKOn72k2QOMeXSaNaiiTKuMXQEWZDREamFWcw
         QUdEvhuGiYsSQ45MVnQSyYamDE0Ldh7FY5oS1qdiB9SKfVx8iJD8wqvtOXkhFjO7gKFz
         Vxa9b1tIuAI+7Bd3c/za/Z4dDteexOrKsFZHAW4xl3bdESCe4q4mv8WaV8VvA+GjnzWG
         h03YYTDA8rDngUQGqNZvvIeL+NcaapquHAlU+3cTVh4nFMizD+1UBHSewUw9usNvOEWl
         Z3EA==
X-Gm-Message-State: AOPr4FXwtnzzhNDH3TinVcy3U0wk7p+9EmxHuvYda2cVX7WxfS+b8efVGVj8osVzHMv8/w==
X-Received: by 10.28.94.5 with SMTP id s5mr7191646wmb.26.1461504891188;
        Sun, 24 Apr 2016 06:34:51 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:50 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292397>

The match_fragment() function is very big and contains a big special case
algorithm that does line by line fuzzy matching. So let's extract this
algorithm in a separate line_by_line_fuzzy_match() function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 129 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 56 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 78849e4..02239d9 100644
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
@@ -2251,7 +2319,7 @@ static int match_fragment(struct image *img,
 			  int match_beginning, int match_end)
 {
 	int i;
-	char *fixed_buf, *buf, *orig, *target;
+	char *fixed_buf, *orig, *target;
 	struct strbuf fixed;
 	size_t fixed_len, postlen;
 	int preimage_limit;
@@ -2312,6 +2380,7 @@ static int match_fragment(struct image *img,
 		 * There must be one non-blank context line that match
 		 * a line before the end of img.
 		 */
+		char *buf;
 		char *buf_end;
 
 		buf = preimage->buf;
@@ -2331,61 +2400,9 @@ static int match_fragment(struct image *img,
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
2.8.1.300.g5fed0c0
