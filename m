From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 20/34] mailinfo: move transfer_encoding to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:37 -0700
Message-ID: <1445239731-10677-21-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tH-00032X-Sg
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbbJSH3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:25 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36404 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbJSH3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:18 -0400
Received: by pacfv9 with SMTP id fv9so86974526pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=TgtzofUadQ/BSrTNUgZ2WYDUZpX/dXILljh38SaprFY=;
        b=NJbHyJfXGrW1QbJUrLoPyTlJNIaflpEj04Huca9We5BaiSw2kkKdZchYI4P2EF/G2b
         DOSXdCtXxSzS+kdaDMPy3TYUwOxjhTDa5b8Tl3U5JEzR+FtL18HSkNpS5dIpiCOx9Rfg
         r8LaCxy3AYA/VY1nRY64p7SMtq5qPbJ2hVNAK9/A6VmXHfIFEu88oRWiGU9GZz1w6pRX
         aPziX9AqfElNDaRTXCIbmomylidEO7dfnbx07Zshj3XJRWOoWDCJjhRjyaiiNNOeTt7Y
         kDViK5U8MnyS5k4R6+7yYk2HMo9Kzsg7HbSnfasdVxj2ANZ2FsngkELwWlRm07vSipIw
         op9A==
X-Received: by 10.68.174.193 with SMTP id bu1mr32830755pbc.136.1445239758049;
        Mon, 19 Oct 2015 00:29:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id yp9sm34814762pab.1.2015.10.19.00.29.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:17 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279852>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 737d0fc..18781b7 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -23,14 +23,14 @@ struct mailinfo {
 	const char *metainfo_charset;
 
 	char *message_id;
+	enum  {
+		TE_DONTCARE, TE_QP, TE_BASE64
+	} transfer_encoding;
 	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
 };
 
-static enum  {
-	TE_DONTCARE, TE_QP, TE_BASE64
-} transfer_encoding;
 
 static struct strbuf charset = STRBUF_INIT;
 
@@ -214,14 +214,15 @@ static void handle_message_id(struct mailinfo *mi, const struct strbuf *line)
 		mi->message_id = strdup(line->buf);
 }
 
-static void handle_content_transfer_encoding(const struct strbuf *line)
+static void handle_content_transfer_encoding(struct mailinfo *mi,
+					     const struct strbuf *line)
 {
 	if (strcasestr(line->buf, "base64"))
-		transfer_encoding = TE_BASE64;
+		mi->transfer_encoding = TE_BASE64;
 	else if (strcasestr(line->buf, "quoted-printable"))
-		transfer_encoding = TE_QP;
+		mi->transfer_encoding = TE_QP;
 	else
-		transfer_encoding = TE_DONTCARE;
+		mi->transfer_encoding = TE_DONTCARE;
 }
 
 static int is_multipart_boundary(const struct strbuf *line)
@@ -356,7 +357,7 @@ static int check_header(struct mailinfo *mi,
 		len = strlen("Content-Transfer-Encoding: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
 		decode_header(mi, &sb);
-		handle_content_transfer_encoding(&sb);
+		handle_content_transfer_encoding(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
@@ -615,11 +616,11 @@ release_return:
 	strbuf_release(&piecebuf);
 }
 
-static void decode_transfer_encoding(struct strbuf *line)
+static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf *ret;
 
-	switch (transfer_encoding) {
+	switch (mi->transfer_encoding) {
 	case TE_QP:
 		ret = decode_q_segment(line, 0);
 		break;
@@ -838,7 +839,7 @@ again:
 	}
 
 	/* set some defaults */
-	transfer_encoding = TE_DONTCARE;
+	mi->transfer_encoding = TE_DONTCARE;
 	strbuf_reset(&charset);
 
 	/* slurp in this section's info */
@@ -876,9 +877,9 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 		}
 
 		/* Unwrap transfer encoding */
-		decode_transfer_encoding(line);
+		decode_transfer_encoding(mi, line);
 
-		switch (transfer_encoding) {
+		switch (mi->transfer_encoding) {
 		case TE_BASE64:
 		case TE_QP:
 		{
-- 
2.6.2-383-g144b2e6
