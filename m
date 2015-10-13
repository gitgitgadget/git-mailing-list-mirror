From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/26] mailinfo: always pass "line" as an argument
Date: Tue, 13 Oct 2015 16:16:27 -0700
Message-ID: <1444778207-859-7-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8op-0006FA-9p
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbbJMXRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:17 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33207 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbbJMXQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:16:57 -0400
Received: by pabrc13 with SMTP id rc13so34525111pab.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=XJLxuhIEuUkvha7Ie0VTvLLLO3uOGjKL74GXwmZ+7x0=;
        b=AtpIDvI/KujiHEzF/8Aqf4+XjpP7MgnyBxsMhm7beXorYoGn/QXjuU1+OBsQWZusjq
         cTQi5t5DQglG42WdBknQxekmWe54GEAI0mVH90P4aeWUbN1y2kXXORuYsqarv5H4ReSN
         aj7ErNunVl3YNbx0JU/O4pnygPSug/ysq6U9ja8fLAICIe0T2YhdF8lbUN3/vsh8Vdpu
         0Opy+OO68A3GDy3xUgt+SzvP15zftUupH97hPtek8gI5pbJdLwuV3oMPrVW2F7jVXJct
         w8hR9GtO1BnBzUZFcQTqg/f9518Qmxb26SxhX6bxvi2Uj0hVGPTFcdJKunWcjq2pD/w6
         ZGUw==
X-Received: by 10.66.229.67 with SMTP id so3mr57344pac.66.1444778217356;
        Tue, 13 Oct 2015 16:16:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id uc1sm5867135pab.20.2015.10.13.16.16.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:16:56 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279536>

Some functions in this module accessed the global "struct strbuf
line" while many others used a strbuf passed as an argument.
Convert the former to ensure that nobody deeper in the callchains
relies on the global one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 5a74811..c3c7d67 100644
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
@@ -817,23 +817,23 @@ static void handle_filter(struct strbuf *line, int *filter_stage, int *header_st
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
@@ -852,7 +852,7 @@ again:
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
-		if (!find_boundary())
+		if (!find_boundary(line))
 			return 0;
 		goto again;
 	}
@@ -862,18 +862,18 @@ again:
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
@@ -881,24 +881,24 @@ static void handle_body(void)
 
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
@@ -907,7 +907,7 @@ static void handle_body(void)
 			struct strbuf **lines, **it, *sb;
 
 			/* Prepend any previous partial lines */
-			strbuf_insert(&line, 0, prev.buf, prev.len);
+			strbuf_insert(line, 0, prev.buf, prev.len);
 			strbuf_reset(&prev);
 
 			/*
@@ -915,7 +915,7 @@ static void handle_body(void)
 			 * multiple new lines.  Pass only one chunk
 			 * at a time to handle_filter()
 			 */
-			lines = strbuf_split(&line, '\n');
+			lines = strbuf_split(line, '\n');
 			for (it = lines; (sb = *it); it++) {
 				if (*(it + 1) == NULL) /* The last line */
 					if (sb->buf[sb->len - 1] != '\n') {
@@ -933,10 +933,10 @@ static void handle_body(void)
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
@@ -1019,10 +1019,10 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 	ungetc(peek, in);
 
 	/* process the email header */
-	while (read_one_header_line(&line, fin))
-		check_header(&line, p_hdr_data, 1);
+	while (read_one_header_line(&line_global, fin))
+		check_header(&line_global, p_hdr_data, 1);
 
-	handle_body();
+	handle_body(&line_global);
 	handle_info();
 
 	return 0;
-- 
2.6.1-320-g86a1181
