From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 05/94] builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
Date: Wed, 11 May 2016 15:16:16 +0200
Message-ID: <20160511131745.2914-6-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:26:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U9p-00025r-UM
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbcEKNSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:18:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34169 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcEKNSi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so9408965wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g/RZivqPtWw2BiRjOPw8CIYTVoV/Pw6g9Zz/2dRM8y0=;
        b=KNdfgVAjxJPvPZdSkq4f90cQXpMaa0kcI00TtaLwYjptoJOcbQS5j/byzITOnbibvT
         x94UQBan9pA2/4ipf57dTNe8C4Xl9QZvKcu5KfUhekiHEYbdb26fuk5rbIqUpc0XFyVB
         0b3j6tovluYYYOi0GT25kh3P8/FrUJpqhxBHjAVhdLzres7fBArBuyDhpv3J+PcicSuW
         B6CUROP88+ZlDtp324jUuaQTYuqBIhwZ0x/FNqBGCguWEop6h5HQsCpn7XbQLC42Uxuu
         M2/Tm5dwqbVRqjM478xXPQ2BV/no3e9C86P5QwA8CiNC43j8na9z67/ZK3VYhPL5zcJw
         EzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g/RZivqPtWw2BiRjOPw8CIYTVoV/Pw6g9Zz/2dRM8y0=;
        b=IUDBWhgAGXJsz74t5ovBZJakrPBpKBx/x4VyC+xqDerX5LdmD3UUobpCjY1uRD7LHu
         HRsytH0OR6u3OVJol07X7FCYj3q9KY3GPJaH7DcqCfXg/tOIIetKr/HCWMlQV5P7LffO
         gTDeALt2y/sCkHTAWwGErvxPsVqSNxuXOsjUHYPtt/vVMVaX2Fx7Ms2ICl5x+Qlmh6sZ
         cSQKr9NshYJj0xbaX+bIRl3iGvVtF3X5Q5uILyPoR3bcs4aSGdZwpt4kyLtAQPNb1q5C
         OuyIno1cO8LM+XeHFaYwv7W2YihTYIXX7EpmYzGRxD0Kt2R26ZGsx5oM4PDLHL9I/R5u
         suVw==
X-Gm-Message-State: AOPr4FXHKKbLg6mHp7oB33lKdLEJWVvzwKc9ZBmdHNRiiPWuVyEEkZ43lmeD+5VIz4uENg==
X-Received: by 10.194.234.36 with SMTP id ub4mr3754384wjc.4.1462972716654;
        Wed, 11 May 2016 06:18:36 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:35 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294339>

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
2.8.2.490.g3dabe57
