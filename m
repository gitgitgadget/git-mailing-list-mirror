From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/31] mailinfo: always pass "line" as an argument
Date: Wed, 14 Oct 2015 13:45:33 -0700
Message-ID: <1444855557-2127-8-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSy5-0003Fh-N3
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932836AbbJNUq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:29 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34783 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbbJNUqI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:08 -0400
Received: by payp3 with SMTP id p3so16204841pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=NTsWMGDVlRjjPP7GZ4DV5HRevsCJn1HsZxUKJQIZJFA=;
        b=vdFNkg1CKvLiJy6AczpP+KgenfLviYsfczyEKm18hzCiX+HNfcPbC8xl8iaX0nDTMc
         qRM4CHCUO5ktFQdvCOLuap2+e/QdXvsc9wRey5roZ8sLAFHig2OnAX7v//DRbO1TRuS4
         4bg4qCNU8oEbgIJyIWfMiR8ewMbl1jbZqA04k9MHkWwc2TUZvLxJDuD5chHPcK+kYWij
         cmnK6luSXAoKUJ1zJ8hpQ95UbRvlsGLUwqi84T9Q7zLC5ZYf67w5bZ1Lc3Z+4AJfwpiX
         owF63ME231Bkz/2jcwA9OfqKQmS05xODZ/7t/I6wGReYgU7/iCbeNQZluQwW6eT2S2S3
         SL2w==
X-Received: by 10.68.102.2 with SMTP id fk2mr5591349pbb.129.1444855567892;
        Wed, 14 Oct 2015 13:46:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id yi8sm11337251pab.22.2015.10.14.13.46.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:07 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279615>

Some functions in this module accessed the global "struct strbuf
line" while many others used a strbuf passed as an argument.
Convert the former to ensure that nobody deeper in the callchains
relies on the global one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 1518708..721d999 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -12,7 +12,7 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
 static int keep_subject;
 static int keep_non_patch_brackets_in_subject;
 static const char *metainfo_charset;
-static struct strbuf line = STRBUF_INIT;
+static struct strbuf line_global = STRBUF_INIT;
 static struct strbuf name = STRBUF_INIT;
 static struct strbuf email = STRBUF_INIT;
 static char *message_id;
@@ -788,23 +788,23 @@ static void handle_filter(struct strbuf *line, int *filter_stage, int *header_st
 	}
 }
 
-static int find_boundary(void)
+static int find_boundary(struct strbuf *line)
 {
-	while (!strbuf_getline(&line, fin, '\n')) {
-		if (*content_top && is_multipart_boundary(&line))
+	while (!strbuf_getline(line, fin, '\n')) {
+		if (*content_top && is_multipart_boundary(line))
 			return 1;
 	}
 	return 0;
 }
 
-static int handle_boundary(int *filter_stage, int *header_stage)
+static int handle_boundary(struct strbuf *line, int *filter_stage, int *header_stage)
 {
 	struct strbuf newline = STRBUF_INIT;
 
 	strbuf_addch(&newline, '\n');
 again:
-	if (line.len >= (*content_top)->len + 2 &&
-	    !memcmp(line.buf + (*content_top)->len, "--", 2)) {
+	if (line->len >= (*content_top)->len + 2 &&
+	    !memcmp(line->buf + (*content_top)->len, "--", 2)) {
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
 		strbuf_release(*content_top);
@@ -823,7 +823,7 @@ again:
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
-		if (!find_boundary())
+		if (!find_boundary(line))
 			return 0;
 		goto again;
 	}
@@ -833,18 +833,18 @@ again:
 	strbuf_reset(&charset);
 
 	/* slurp in this section's info */
-	while (read_one_header_line(&line, fin))
-		check_header(&line, p_hdr_data, 0);
+	while (read_one_header_line(line, fin))
+		check_header(line, p_hdr_data, 0);
 
 	strbuf_release(&newline);
 	/* replenish line */
-	if (strbuf_getline(&line, fin, '\n'))
+	if (strbuf_getline(line, fin, '\n'))
 		return 0;
-	strbuf_addch(&line, '\n');
+	strbuf_addch(line, '\n');
 	return 1;
 }
 
-static void handle_body(void)
+static void handle_body(struct strbuf *line)
 {
 	struct strbuf prev = STRBUF_INIT;
 	int filter_stage = 0;
@@ -852,24 +852,24 @@ static void handle_body(void)
 
 	/* Skip up to the first boundary */
 	if (*content_top) {
-		if (!find_boundary())
+		if (!find_boundary(line))
 			goto handle_body_out;
 	}
 
 	do {
 		/* process any boundary lines */
-		if (*content_top && is_multipart_boundary(&line)) {
+		if (*content_top && is_multipart_boundary(line)) {
 			/* flush any leftover */
 			if (prev.len) {
 				handle_filter(&prev, &filter_stage, &header_stage);
 				strbuf_reset(&prev);
 			}
-			if (!handle_boundary(&filter_stage, &header_stage))
+			if (!handle_boundary(line, &filter_stage, &header_stage))
 				goto handle_body_out;
 		}
 
 		/* Unwrap transfer encoding */
-		decode_transfer_encoding(&line);
+		decode_transfer_encoding(line);
 
 		switch (transfer_encoding) {
 		case TE_BASE64:
@@ -878,7 +878,7 @@ static void handle_body(void)
 			struct strbuf **lines, **it, *sb;
 
 			/* Prepend any previous partial lines */
-			strbuf_insert(&line, 0, prev.buf, prev.len);
+			strbuf_insert(line, 0, prev.buf, prev.len);
 			strbuf_reset(&prev);
 
 			/*
@@ -886,7 +886,7 @@ static void handle_body(void)
 			 * multiple new lines.  Pass only one chunk
 			 * at a time to handle_filter()
 			 */
-			lines = strbuf_split(&line, '\n');
+			lines = strbuf_split(line, '\n');
 			for (it = lines; (sb = *it); it++) {
 				if (*(it + 1) == NULL) /* The last line */
 					if (sb->buf[sb->len - 1] != '\n') {
@@ -904,10 +904,10 @@ static void handle_body(void)
 			break;
 		}
 		default:
-			handle_filter(&line, &filter_stage, &header_stage);
+			handle_filter(line, &filter_stage, &header_stage);
 		}
 
-	} while (!strbuf_getwholeline(&line, fin, '\n'));
+	} while (!strbuf_getwholeline(line, fin, '\n'));
 
 handle_body_out:
 	strbuf_release(&prev);
@@ -990,10 +990,10 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 	ungetc(peek, in);
 
 	/* process the email header */
-	while (read_one_header_line(&line, fin))
-		check_header(&line, p_hdr_data, 1);
+	while (read_one_header_line(&line_global, fin))
+		check_header(&line_global, p_hdr_data, 1);
 
-	handle_body();
+	handle_body(&line_global);
 	fclose(patchfile);
 
 	handle_info();
-- 
2.6.1-320-g86a1181
