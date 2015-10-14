From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/31] mailinfo: move handle_boundary() lower
Date: Wed, 14 Oct 2015 13:45:31 -0700
Message-ID: <1444855557-2127-6-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyE-0003N6-N8
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbbJNUq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:26 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34750 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbbJNUqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:05 -0400
Received: by payp3 with SMTP id p3so16203981pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Mx8WIvO8+fwPQuVEvQ5VUmw1txFT6VHmqRUDxQoPUDE=;
        b=criXn+9qW/4TJ3ya0pqnFefTJlapRADMp77awkaST5SKW+MH3nJB/TuDnqJoR97luT
         PjRPKNRZoAyXgRj0nnLMaTtFD69lbhBuU7ok/kSRyKQz3XGIQ1hE18YRMwMD61jTomkM
         Wi3+qeKvv6kESjdIsToeWN+jGiPbrw7fKu8MaD9kP76UwmHIF/3vkhPXbjTNiCg1pzmS
         hmI2ACxkd+FMq7/4t0vO3bhcqvZN6epwEa6/K5of8FPq1uTsiNIhy1NzOQmUmKFLOBQE
         DLV48D4Xsz3CUCc4FmSrUfaZDiRRmgSTvWg0kYnSTghPuqxfli3MIc8qk2BEciVRHAl0
         T3rA==
X-Received: by 10.68.197.168 with SMTP id iv8mr5585697pbc.81.1444855565285;
        Wed, 14 Oct 2015 13:46:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id lo9sm11334148pab.19.2015.10.14.13.46.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:04 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279619>

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
2.6.1-320-g86a1181
