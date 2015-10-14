From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 24/31] mailinfo: move read_one_header_line() closer to its callers
Date: Wed, 14 Oct 2015 13:45:50 -0700
Message-ID: <1444855557-2127-25-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSxv-00032o-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962AbbJNUrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:47:43 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33652 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833AbbJNUq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:29 -0400
Received: by pabrc13 with SMTP id rc13so64159227pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=ifrXuWPKQsfnzPROtLZcF4bh3KWTvX+kF5KNFrR6Cr8=;
        b=Dhodus5JBFVETNF1n6IO6uv4RH9pEqjOWSpF6P+6coJi8ls4GMfgadduwYFgMTtE15
         vAg+vKsG9HI1GYLf5TXINtOGFna+p4EEslkOLUuldEwvW3PHhpAKQ8b2LqrfgqgjS9In
         zs9s8D62xrXekjIF9Jb9eT9bNfo6Zb9wkEn8Hxyxk9ZA6aOY6bG85Hnsv81fNBGWo6TH
         xc5T2MYN56ldlN6MFqHszGeEoNLDiwlTkquB3LFVDuR9jzQyicxNYBL1zf7MxV53jNfo
         1+RT7f2LSonq8MqitW1uDRPpYZscqT10+tEjQ8MD60NWBt+69rSH6KonXnawsMVFT3eW
         66jg==
X-Received: by 10.68.249.34 with SMTP id yr2mr5656391pbc.73.1444855589033;
        Wed, 14 Oct 2015 13:46:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id ug4sm11349371pac.11.2015.10.14.13.46.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:28 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279614>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 132 ++++++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 138ca3b..0b083d0 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -390,72 +390,6 @@ check_header_out:
 	return ret;
 }
 
-static int is_rfc2822_header(const struct strbuf *line)
-{
-	/*
-	 * The section that defines the loosest possible
-	 * field name is "3.6.8 Optional fields".
-	 *
-	 * optional-field = field-name ":" unstructured CRLF
-	 * field-name = 1*ftext
-	 * ftext = %d33-57 / %59-126
-	 */
-	int ch;
-	char *cp = line->buf;
-
-	/* Count mbox From headers as headers */
-	if (starts_with(cp, "From ") || starts_with(cp, ">From "))
-		return 1;
-
-	while ((ch = *cp++)) {
-		if (ch == ':')
-			return 1;
-		if ((33 <= ch && ch <= 57) ||
-		    (59 <= ch && ch <= 126))
-			continue;
-		break;
-	}
-	return 0;
-}
-
-static int read_one_header_line(struct strbuf *line, FILE *in)
-{
-	/* Get the first part of the line. */
-	if (strbuf_getline(line, in, '\n'))
-		return 0;
-
-	/*
-	 * Is it an empty line or not a valid rfc2822 header?
-	 * If so, stop here, and return false ("not a header")
-	 */
-	strbuf_rtrim(line);
-	if (!line->len || !is_rfc2822_header(line)) {
-		/* Re-add the newline */
-		strbuf_addch(line, '\n');
-		return 0;
-	}
-
-	/*
-	 * Now we need to eat all the continuation lines..
-	 * Yuck, 2822 header "folding"
-	 */
-	for (;;) {
-		int peek;
-		struct strbuf continuation = STRBUF_INIT;
-
-		peek = fgetc(in); ungetc(peek, in);
-		if (peek != ' ' && peek != '\t')
-			break;
-		if (strbuf_getline(&continuation, in, '\n'))
-			break;
-		continuation.buf[0] = ' ';
-		strbuf_rtrim(&continuation);
-		strbuf_addbuf(line, &continuation);
-	}
-
-	return 1;
-}
-
 static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
 {
 	const char *in = q_seg->buf;
@@ -794,6 +728,72 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 	}
 }
 
+static int is_rfc2822_header(const struct strbuf *line)
+{
+	/*
+	 * The section that defines the loosest possible
+	 * field name is "3.6.8 Optional fields".
+	 *
+	 * optional-field = field-name ":" unstructured CRLF
+	 * field-name = 1*ftext
+	 * ftext = %d33-57 / %59-126
+	 */
+	int ch;
+	char *cp = line->buf;
+
+	/* Count mbox From headers as headers */
+	if (starts_with(cp, "From ") || starts_with(cp, ">From "))
+		return 1;
+
+	while ((ch = *cp++)) {
+		if (ch == ':')
+			return 1;
+		if ((33 <= ch && ch <= 57) ||
+		    (59 <= ch && ch <= 126))
+			continue;
+		break;
+	}
+	return 0;
+}
+
+static int read_one_header_line(struct strbuf *line, FILE *in)
+{
+	/* Get the first part of the line. */
+	if (strbuf_getline(line, in, '\n'))
+		return 0;
+
+	/*
+	 * Is it an empty line or not a valid rfc2822 header?
+	 * If so, stop here, and return false ("not a header")
+	 */
+	strbuf_rtrim(line);
+	if (!line->len || !is_rfc2822_header(line)) {
+		/* Re-add the newline */
+		strbuf_addch(line, '\n');
+		return 0;
+	}
+
+	/*
+	 * Now we need to eat all the continuation lines..
+	 * Yuck, 2822 header "folding"
+	 */
+	for (;;) {
+		int peek;
+		struct strbuf continuation = STRBUF_INIT;
+
+		peek = fgetc(in); ungetc(peek, in);
+		if (peek != ' ' && peek != '\t')
+			break;
+		if (strbuf_getline(&continuation, in, '\n'))
+			break;
+		continuation.buf[0] = ' ';
+		strbuf_rtrim(&continuation);
+		strbuf_addbuf(line, &continuation);
+	}
+
+	return 1;
+}
+
 static int find_boundary(struct mailinfo *mi, struct strbuf *line)
 {
 	while (!strbuf_getline(line, mi->input, '\n')) {
-- 
2.6.1-320-g86a1181
