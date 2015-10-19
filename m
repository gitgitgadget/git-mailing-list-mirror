From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 28/34] mailinfo: move check_header() after the helpers it uses
Date: Mon, 19 Oct 2015 00:28:45 -0700
Message-ID: <1445239731-10677-29-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4t0-0002rZ-9S
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbbJSH3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:31 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36610 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbbJSH32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:28 -0400
Received: by pacfv9 with SMTP id fv9so86979296pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=grK8lmcKJbrIPUoEYJ+7eDSvjtD0hNTv+eKsK4C8b7M=;
        b=pk8HUPsktkaGwocrt54QTPkCBKvXh5ZudE+2eIqykHyUtwW6k7gfe3kKgazl8fOxui
         nRfRiwZGnR0B6GQREFAnoakTQIx1S1svqUDJd3LsenxyNGLHZbPQ/ReU4sauFFxL3oe/
         Q0kk38wCEP7YfaQSOmhsu8M9MtZJ1qZYFJALIUAI9QaFswVZsvRgma3N9ywDIhYDlkKc
         gbZuVVYYgzj4LEqqTdVNqRqZRx1iqyRUQn5Mh1jcXhbHwD5m66lhmb23zOu3WPcYI61i
         +WCyXfYy8BGddhrNxyeeqboXCXO3qRSkVLZQh+WRrUPKOkr1TNKT6YpbBSQgEEqsvMEK
         4Z1w==
X-Received: by 10.66.139.232 with SMTP id rb8mr32264126pab.99.1445239767994;
        Mon, 19 Oct 2015 00:29:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id ir4sm34455407pbb.93.2015.10.19.00.29.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:27 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279844>

This way, we can lose a forward decl for decode_header().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 139 ++++++++++++++++++++++++++---------------------------
 1 file changed, 69 insertions(+), 70 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 5a21d93..6fc6aa8 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -293,7 +293,6 @@ static void cleanup_space(struct strbuf *sb)
 	}
 }
 
-static void decode_header(struct mailinfo *mi, struct strbuf *line);
 static const char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
@@ -321,75 +320,6 @@ static int is_format_patch_separator(const char *line, int len)
 	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
 }
 
-static int check_header(struct mailinfo *mi,
-			const struct strbuf *line,
-			struct strbuf *hdr_data[], int overwrite)
-{
-	int i, ret = 0, len;
-	struct strbuf sb = STRBUF_INIT;
-
-	/* search for the interesting parts */
-	for (i = 0; header[i]; i++) {
-		int len = strlen(header[i]);
-		if ((!hdr_data[i] || overwrite) && cmp_header(line, header[i])) {
-			/* Unwrap inline B and Q encoding, and optionally
-			 * normalize the meta information to utf8.
-			 */
-			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
-			decode_header(mi, &sb);
-			handle_header(&hdr_data[i], &sb);
-			ret = 1;
-			goto check_header_out;
-		}
-	}
-
-	/* Content stuff */
-	if (cmp_header(line, "Content-Type")) {
-		len = strlen("Content-Type: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
-		decode_header(mi, &sb);
-		strbuf_insert(&sb, 0, "Content-Type: ", len);
-		handle_content_type(mi, &sb);
-		ret = 1;
-		goto check_header_out;
-	}
-	if (cmp_header(line, "Content-Transfer-Encoding")) {
-		len = strlen("Content-Transfer-Encoding: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
-		decode_header(mi, &sb);
-		handle_content_transfer_encoding(mi, &sb);
-		ret = 1;
-		goto check_header_out;
-	}
-	if (cmp_header(line, "Message-Id")) {
-		len = strlen("Message-Id: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
-		decode_header(mi, &sb);
-		handle_message_id(mi, &sb);
-		ret = 1;
-		goto check_header_out;
-	}
-
-	/* for inbody stuff */
-	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
-		ret = is_format_patch_separator(line->buf + 1, line->len - 1);
-		goto check_header_out;
-	}
-	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
-		for (i = 0; header[i]; i++) {
-			if (!strcmp("Subject", header[i])) {
-				handle_header(&hdr_data[i], line);
-				ret = 1;
-				goto check_header_out;
-			}
-		}
-	}
-
-check_header_out:
-	strbuf_release(&sb);
-	return ret;
-}
-
 static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
 {
 	const char *in = q_seg->buf;
@@ -550,6 +480,75 @@ release_return:
 	strbuf_release(&piecebuf);
 }
 
+static int check_header(struct mailinfo *mi,
+			const struct strbuf *line,
+			struct strbuf *hdr_data[], int overwrite)
+{
+	int i, ret = 0, len;
+	struct strbuf sb = STRBUF_INIT;
+
+	/* search for the interesting parts */
+	for (i = 0; header[i]; i++) {
+		int len = strlen(header[i]);
+		if ((!hdr_data[i] || overwrite) && cmp_header(line, header[i])) {
+			/* Unwrap inline B and Q encoding, and optionally
+			 * normalize the meta information to utf8.
+			 */
+			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
+			decode_header(mi, &sb);
+			handle_header(&hdr_data[i], &sb);
+			ret = 1;
+			goto check_header_out;
+		}
+	}
+
+	/* Content stuff */
+	if (cmp_header(line, "Content-Type")) {
+		len = strlen("Content-Type: ");
+		strbuf_add(&sb, line->buf + len, line->len - len);
+		decode_header(mi, &sb);
+		strbuf_insert(&sb, 0, "Content-Type: ", len);
+		handle_content_type(mi, &sb);
+		ret = 1;
+		goto check_header_out;
+	}
+	if (cmp_header(line, "Content-Transfer-Encoding")) {
+		len = strlen("Content-Transfer-Encoding: ");
+		strbuf_add(&sb, line->buf + len, line->len - len);
+		decode_header(mi, &sb);
+		handle_content_transfer_encoding(mi, &sb);
+		ret = 1;
+		goto check_header_out;
+	}
+	if (cmp_header(line, "Message-Id")) {
+		len = strlen("Message-Id: ");
+		strbuf_add(&sb, line->buf + len, line->len - len);
+		decode_header(mi, &sb);
+		handle_message_id(mi, &sb);
+		ret = 1;
+		goto check_header_out;
+	}
+
+	/* for inbody stuff */
+	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
+		ret = is_format_patch_separator(line->buf + 1, line->len - 1);
+		goto check_header_out;
+	}
+	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
+		for (i = 0; header[i]; i++) {
+			if (!strcmp("Subject", header[i])) {
+				handle_header(&hdr_data[i], line);
+				ret = 1;
+				goto check_header_out;
+			}
+		}
+	}
+
+check_header_out:
+	strbuf_release(&sb);
+	return ret;
+}
+
 static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf *ret;
-- 
2.6.2-383-g144b2e6
