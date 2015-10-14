From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/31] mailinfo: move transfer_encoding to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:43 -0700
Message-ID: <1444855557-2127-18-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:46:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSwo-0001mB-31
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbbJNUql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:41 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36595 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbbJNUqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:21 -0400
Received: by pabws5 with SMTP id ws5so150032pab.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=z95f+f/zCMCebuZ/Q0FwKX/i9GAYg4GxwE3O6caw4u0=;
        b=znH6FnOIgEFQ9Mm7RW67NBafZHw0Zatcbs0Fe70GDgR4IW1fpPCT3wGLCynH1016wV
         U7NUJWgqAPC5A0oWiSLDF8zz5koWz4fvUujYEivxWiVkWUhXhsdzSOIAX3AMJr0Sqdxm
         N+yv106bY0MxmPgZLMB1ePfe6AsjFPFBeliwLWESnMBwEPwNaghYOlEJ3cu5lpI04Q/N
         CeczGPkRff2AUd2dheT0M34AdPgdlyUqw/08pRzlJdjQF5mjQcnxPBJpHHDhHI02R/8W
         uRC4Jyq0uk3MT98ELU19hs77VMko5G5VP1Xn1MTpUj3vlAktqc7klvINcO2IQjMp9PIf
         bvUQ==
X-Received: by 10.68.98.34 with SMTP id ef2mr5649688pbb.45.1444855580605;
        Wed, 14 Oct 2015 13:46:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id pk2sm11287442pbb.21.2015.10.14.13.46.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:20 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279595>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 00b8b4b..140b31ee 100644
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
2.6.1-320-g86a1181
