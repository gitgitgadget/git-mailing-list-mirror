From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/34] mailinfo: move handle_boundary() lower
Date: Mon, 19 Oct 2015 00:28:22 -0700
Message-ID: <1445239731-10677-6-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4sV-0002V5-TX
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbbJSH3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:03 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34783 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbJSH3A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:00 -0400
Received: by padhk11 with SMTP id hk11so21766627pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=3HCplBTUcdIf/FmeECvB31ttXh/IZzeej8lJT9EJnM4=;
        b=WAxnNNYtoRLca809dhkl4Qub1fP3/N0ml2v0m/2SEFpcgwV1GEyOKMjgVcmhCfV/JK
         2FPF7x1EPgOlNg3Yyac2noacQQiL8OjRnWoB0Xzf3LgEp/OYNd01UoFVraS2QfXqMmql
         kVNTsXanK2tFy8o3FtAYINIhpIzLzQtrscq1va4+JneHSkKTTLnZ6nL39/d+VPa3/3Wc
         Q1W4uWr+1QWkE0wk37cre3neLoGddudwuKp5yQX2EqiD7zhu9uarJ9x32+7/jxKLtlN8
         g5W9NVM9WMLtUyDly2y0XyUR223/DW8l9Kce9HY+nzHnVeRdgKjeBZ0CWt7pxey86IuC
         fMig==
X-Received: by 10.68.213.4 with SMTP id no4mr13454423pbc.85.1445239740063;
        Mon, 19 Oct 2015 00:29:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id xa4sm34856384pac.28.2015.10.19.00.28.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:28:59 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279835>

This function wants to call find_boundary() and is called only from
one place without any recursing, so it becomes easier to read if it
appears after the called function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 114 ++++++++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 58 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 73be47c..2b7f97b 100644
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
@@ -851,6 +793,62 @@ static void handle_filter(struct strbuf *line)
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
2.6.2-383-g144b2e6
