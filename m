From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/26] mailinfo: move handle_boundary() lower
Date: Tue, 13 Oct 2015 16:16:25 -0700
Message-ID: <1444778207-859-5-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pg-00079E-A2
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbbJMXRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:14 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33971 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbbJMXQz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:16:55 -0400
Received: by pabws5 with SMTP id ws5so3471210pab.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=hkNrRqFGNmtkWrxoLSttd0exQBZ5mwpiau+gYGrHDgc=;
        b=MOBRHzLM0PYbjEwNDjM2f8EgDt+NlDNW0wcsoeRNtRVHVzz9okvxkAZzRJRwO5WK7p
         5jmml8eO8CiTXSDDqSdeEcMSEnvC4aXj3wWd43WeMwTV4SaKjF4QnK8TOm4huGpf/eOJ
         CRvEfRSpaHQeKuJomtRTrCBtLJBMneCWtEaMygeXIEDmmoCIjKIt0n39ajEJLd5h+4Wv
         GxwKyGdFExGPtPWK1uUHLSrzH6sGWl7Ip7eloY/NXh8Qk1MTyfgZuAle1EaU29ZYZWW/
         k5mvG7di75gzHCKmCotg/lVip7v1aZOQwJm5jGQ+UYYoUZ6Y55Pag4jz4U7uGR+030nB
         j8qA==
X-Received: by 10.68.57.238 with SMTP id l14mr29405pbq.150.1444778214959;
        Tue, 13 Oct 2015 16:16:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id xm9sm5841489pbc.32.2015.10.13.16.16.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:16:54 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279552>

This function wants to call find_boundary() and is called only from
one place without any recursing, so it becomes easier to read if it
appears after the called function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 114 ++++++++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 58 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 3b015a5..175c6ae 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -626,64 +626,6 @@ static void decode_transfer_encoding(struct strbuf *line)
 	free(ret);
 }
 
-static void handle_filter(struct strbuf *line);
-
-static int find_boundary(void)
-{
-	while (!strbuf_getline(&line, fin, '\n')) {
-		if (*content_top && is_multipart_boundary(&line))
-			return 1;
-	}
-	return 0;
-}
-
-static int handle_boundary(void)
-{
-	struct strbuf newline = STRBUF_INIT;
-
-	strbuf_addch(&newline, '\n');
-again:
-	if (line.len >= (*content_top)->len + 2 &&
-	    !memcmp(line.buf + (*content_top)->len, "--", 2)) {
-		/* we hit an end boundary */
-		/* pop the current boundary off the stack */
-		strbuf_release(*content_top);
-		free(*content_top);
-		*content_top = NULL;
-
-		/* technically won't happen as is_multipart_boundary()
-		   will fail first.  But just in case..
-		 */
-		if (--content_top < content) {
-			fprintf(stderr, "Detected mismatched boundaries, "
-					"can't recover\n");
-			exit(1);
-		}
-		handle_filter(&newline);
-		strbuf_release(&newline);
-
-		/* skip to the next boundary */
-		if (!find_boundary())
-			return 0;
-		goto again;
-	}
-
-	/* set some defaults */
-	transfer_encoding = TE_DONTCARE;
-	strbuf_reset(&charset);
-
-	/* slurp in this section's info */
-	while (read_one_header_line(&line, fin))
-		check_header(&line, p_hdr_data, 0);
-
-	strbuf_release(&newline);
-	/* replenish line */
-	if (strbuf_getline(&line, fin, '\n'))
-		return 0;
-	strbuf_addch(&line, '\n');
-	return 1;
-}
-
 static inline int patchbreak(const struct strbuf *line)
 {
 	size_t i;
@@ -879,6 +821,62 @@ static void handle_filter(struct strbuf *line)
 	}
 }
 
+static int find_boundary(void)
+{
+	while (!strbuf_getline(&line, fin, '\n')) {
+		if (*content_top && is_multipart_boundary(&line))
+			return 1;
+	}
+	return 0;
+}
+
+static int handle_boundary(void)
+{
+	struct strbuf newline = STRBUF_INIT;
+
+	strbuf_addch(&newline, '\n');
+again:
+	if (line.len >= (*content_top)->len + 2 &&
+	    !memcmp(line.buf + (*content_top)->len, "--", 2)) {
+		/* we hit an end boundary */
+		/* pop the current boundary off the stack */
+		strbuf_release(*content_top);
+		free(*content_top);
+		*content_top = NULL;
+
+		/* technically won't happen as is_multipart_boundary()
+		   will fail first.  But just in case..
+		 */
+		if (--content_top < content) {
+			fprintf(stderr, "Detected mismatched boundaries, "
+					"can't recover\n");
+			exit(1);
+		}
+		handle_filter(&newline);
+		strbuf_release(&newline);
+
+		/* skip to the next boundary */
+		if (!find_boundary())
+			return 0;
+		goto again;
+	}
+
+	/* set some defaults */
+	transfer_encoding = TE_DONTCARE;
+	strbuf_reset(&charset);
+
+	/* slurp in this section's info */
+	while (read_one_header_line(&line, fin))
+		check_header(&line, p_hdr_data, 0);
+
+	strbuf_release(&newline);
+	/* replenish line */
+	if (strbuf_getline(&line, fin, '\n'))
+		return 0;
+	strbuf_addch(&line, '\n');
+	return 1;
+}
+
 static void handle_body(void)
 {
 	struct strbuf prev = STRBUF_INIT;
-- 
2.6.1-320-g86a1181
