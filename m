From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/34] mailinfo: do not let handle_body() touch global "line" directly
Date: Mon, 19 Oct 2015 00:28:24 -0700
Message-ID: <1445239731-10677-8-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4u5-0003YO-1u
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbbJSH3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:08 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33803 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbbJSH3C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:02 -0400
Received: by padhk11 with SMTP id hk11so21767635pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Tz4rRJykwQFTq3pk4wksaYOkOoj+7sUcYK87B7RQwgc=;
        b=rkJujABxONAVrEOEIVZOIBiW8/RXrN14gssd8nwJe+HbfNZMkkqFNU+M9XiFSLRguk
         eNBygO9Sr+CEvAAEjRVdagSnu9CaguVnH9XGKhnCNADHI/tg5FMwRVmHQPaM5S4UTwHB
         FXUZfhBbUNF2KBojAhthSjxncwV3rGYdHxhbg7tg2D2l86en5GQrqLOAXX/dZHK3F4rV
         /7gtADWOJgfv5+Vq1O/fq3X+cYSyuhrT2Qh4nNvcbFjwI6P8hKSYDCUWzr6AMS0bvgMg
         8X+yXLfK5aEjTQmFJItVa7eMZYfzp6x4lSRlaJa6pxHnBHNlJxdYbSc2dVWdD1F4tPVi
         yVwg==
X-Received: by 10.68.254.7 with SMTP id ae7mr33434717pbd.131.1445239742494;
        Mon, 19 Oct 2015 00:29:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id zi1sm15509440pbc.10.2015.10.19.00.29.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:02 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279862>

This function has a single caller, and called with the global "line"
holding the first line of the e-mail body after the caller finished
processing the e-mail headers.  The function then goes into a loop
to process each line of the input, starting from what was given by
its caller, and fills the same global "line" variable from the input
as it needs to process more lines.

Let the caller explicitly pass a pointer to this global "line"
variable as an argument, and have the function itself use that
strbuf throughout, instead of referring to the global "line" itself.

There are helper functions that this function calls that still touch
the global directly; they will be updated as the series progresses.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 1518708..52be7db 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -844,7 +844,7 @@ again:
 	return 1;
 }
 
-static void handle_body(void)
+static void handle_body(struct strbuf *line)
 {
 	struct strbuf prev = STRBUF_INIT;
 	int filter_stage = 0;
@@ -858,7 +858,7 @@ static void handle_body(void)
 
 	do {
 		/* process any boundary lines */
-		if (*content_top && is_multipart_boundary(&line)) {
+		if (*content_top && is_multipart_boundary(line)) {
 			/* flush any leftover */
 			if (prev.len) {
 				handle_filter(&prev, &filter_stage, &header_stage);
@@ -869,7 +869,7 @@ static void handle_body(void)
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
@@ -993,7 +993,7 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 	while (read_one_header_line(&line, fin))
 		check_header(&line, p_hdr_data, 1);
 
-	handle_body();
+	handle_body(&line);
 	fclose(patchfile);
 
 	handle_info();
-- 
2.6.2-383-g144b2e6
