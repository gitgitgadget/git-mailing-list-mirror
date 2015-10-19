From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 27/34] mailinfo: move read_one_header_line() closer to its callers
Date: Mon, 19 Oct 2015 00:28:44 -0700
Message-ID: <1445239731-10677-28-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4t9-0002y8-G5
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbbJSH3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:30 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34292 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbbJSH31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:27 -0400
Received: by padhk11 with SMTP id hk11so21778688pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=a9/rS+VyaHVZqPoMAftS9Sf/ZGjciqWMaZ5RXq7cHyg=;
        b=y4yONThGc6xwkz+XJzhoq9+4sfGZ5OEyenO560xhslchcS8yd+yHg8gS7RfkZjnjXh
         Z2oADOvW0SoJklEksV5URdrvyqfrH2hCs1ymUjvMCVZgZwr477mKMiq2kKBTBzSPW7na
         wVt3IZhOXSIqbYmnzXESGEmzTKPieyd3D4z/ZrfRbdA4UupE8WHaSsdOMV1kFod8k1zV
         jdIb47g8+0rJvPEWOKNzZUJMX+tSdh7iHqS/VmCpE8KyR6hGypVuPbAVH1qMxTD4X7SL
         n5K8EXDthz/DZEYgdhHTXPlosKEod6m7NVLNgGZxB+nVzys/iBZZWSZQK6Du4o1jDupM
         NyJg==
X-Received: by 10.68.107.65 with SMTP id ha1mr20832767pbb.143.1445239766919;
        Mon, 19 Oct 2015 00:29:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id z12sm34493284pbt.30.2015.10.19.00.29.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:25 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279846>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 132 ++++++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 81bb3c7..5a21d93 100644
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
2.6.2-383-g144b2e6
