From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 25/31] mailinfo: move check_header() after the helpers it uses
Date: Wed, 14 Oct 2015 13:45:51 -0700
Message-ID: <1444855557-2127-26-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:46:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSwm-0001mB-1e
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932937AbbJNUqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:44 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34070 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868AbbJNUqa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:30 -0400
Received: by payp3 with SMTP id p3so16212726pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=ZDk4o88ffH2jKMHdDj2VhnC5PrBi4QoGz4p0hE5cQSI=;
        b=dQko7yH8J4qjaONtM+SGxZjXm+PJgfgW7g/vPSyjUOXaFd3jfpS5Lp0cQ4f/l+KwuQ
         WdYNUGtgS4qETwqicAkfT87msnAYALkcmpS/UFDRfCayYOJoVYszacfgnoRATbPNQt79
         c40b3eIfPYJ59dg8Lgyfx/TGLrnkkx8VWQvBqEyUFOWXA8iINolq883OsErOTf/RR7Zp
         0wVmGZDOFCr5RjUqV1Bqd0MmNTR+kBkMiO0INWBK2haphEL+G5zlfxgCnuvDBfPhGqSR
         8ver83GMsSdz5ivY+0KWm+Kxf5feTuJ5/+dft76Q+yI2xD+TXQpbqlh+zysIqnXqs2wZ
         mkYQ==
X-Received: by 10.66.160.100 with SMTP id xj4mr5673322pab.39.1444855590216;
        Wed, 14 Oct 2015 13:46:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id pf7sm11295946pbc.6.2015.10.14.13.46.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:29 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279601>

This way, we can lose a forward decl for decode_header().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 139 ++++++++++++++++++++++++++---------------------------
 1 file changed, 69 insertions(+), 70 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 0b083d0..ee669b9 100644
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
2.6.1-320-g86a1181
