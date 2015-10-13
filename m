From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/26] mailinfo: move transfer_encoding to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:37 -0700
Message-ID: <1444778207-859-17-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pE-0006XH-C2
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbbJMXRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:36 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34832 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbbJMXRI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:08 -0400
Received: by padcn9 with SMTP id cn9so3398159pad.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=QfrRgvKycJsZDlmFdXnueu6uEvJx9IvxgumRplm4SaE=;
        b=dYuzBSwzc26DfZ/2MWtd9y0cd2dhpPHZatnlB+Kt13xErV5YsUOh7AudUli7IFBRjg
         MQO/A2CLjKvd5y3JHquE62JwYLucsBQLgdddPFYC7O6rcewsO6l8u9Knhmu+SIPOPrOq
         uMv4ETUNUiThai7fUuySLjS8YW0futR3i4IcOeenkPhfKIk68JM7xRVgmTETUA1VkNRI
         6dvbc1TWp6ZY+UZdL1ePyMphYOrNuISTSNCGjz7s5Y6O/35Xr5FASTNsDc25DunqjwRs
         nzUJ2PKF2u5qp1y/BW8HnkMAKomvRf4kFqaGbwhjXUQsol92B7wYEWwq3hmykkXel2cD
         ChEg==
X-Received: by 10.66.235.4 with SMTP id ui4mr42798903pac.129.1444778228066;
        Tue, 13 Oct 2015 16:17:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id qr8sm2168173pbb.47.2015.10.13.16.17.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:07 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279539>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 7e01efa..fbfa27e 100644
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
@@ -867,7 +868,7 @@ again:
 	}
 
 	/* set some defaults */
-	transfer_encoding = TE_DONTCARE;
+	mi->transfer_encoding = TE_DONTCARE;
 	strbuf_reset(&charset);
 
 	/* slurp in this section's info */
@@ -905,9 +906,9 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
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
