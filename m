From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 23/26] mailinfo: handle errors found in decode_header() better
Date: Tue, 13 Oct 2015 16:16:44 -0700
Message-ID: <1444778207-859-24-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:18:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pg-00079E-UI
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbbJMXSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:18:10 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33461 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbJMXRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:16 -0400
Received: by pabrc13 with SMTP id rc13so34531342pab.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=72WGpOrjUj0R+i729yTpPzS6KHu/fcYhvtR7okBGTlo=;
        b=E2SF2P5GpSD6e7v0vGBBEx+MTWvwN7uc5xirTX3mAGOoCrtYoBVHIRloml8NRV/e19
         HBx2YH1Y0T9FPuJNRmCQBYsd+zOeVXfTM22hED60WGkDgW7ktWzrpGFU67YWgWMlr9ib
         Xx69uHzRg9CRWEr4/wzkjqrM3/PWosPgmvvBaT/GSaBa2xa4eGjchzq2/13OXbQBtEJw
         yvynttejkYI5vrZlwmz7LYNBojQuTVPv7hi4O7pZkmsDeklQ6ZMb2TS62tfJLnsvubBU
         qCBWO6BVwHBiUADp2b0RGwUuaPcl5ZnA03Nap0WlPXP8Mga29PqBMu6N/T3/6416842m
         LeAQ==
X-Received: by 10.69.26.161 with SMTP id iz1mr23425pbd.17.1444778236581;
        Tue, 13 Oct 2015 16:17:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id xz5sm5851852pbb.12.2015.10.13.16.17.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:16 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279554>

The decode_header() function tries to unwrap RFC2047-style quoted
strings but punts when it finds anything it cannot parse.  Allow the
function to report if it punted to the caller, and use the resulting
string in the caller only when the function says it parsed the input
successfully.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 4b9b1cc..6452a4c 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -293,7 +293,7 @@ static void cleanup_space(struct strbuf *sb)
 	}
 }
 
-static void decode_header(struct mailinfo *mi, struct strbuf *line);
+static int decode_header(struct mailinfo *mi, struct strbuf *line);
 static const char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
@@ -336,8 +336,8 @@ static int check_header(struct mailinfo *mi,
 			 * normalize the meta information to utf8.
 			 */
 			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
-			decode_header(mi, &sb);
-			handle_header(&hdr_data[i], &sb);
+			if (!decode_header(mi, &sb))
+				handle_header(&hdr_data[i], &sb);
 			ret = 1;
 			goto check_header_out;
 		}
@@ -347,25 +347,26 @@ static int check_header(struct mailinfo *mi,
 	if (cmp_header(line, "Content-Type")) {
 		len = strlen("Content-Type: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
-		decode_header(mi, &sb);
-		strbuf_insert(&sb, 0, "Content-Type: ", len);
-		handle_content_type(mi, &sb);
+		if (!decode_header(mi, &sb)) {
+			strbuf_insert(&sb, 0, "Content-Type: ", len);
+			handle_content_type(mi, &sb);
+		}
 		ret = 1;
 		goto check_header_out;
 	}
 	if (cmp_header(line, "Content-Transfer-Encoding")) {
 		len = strlen("Content-Transfer-Encoding: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
-		decode_header(mi, &sb);
-		handle_content_transfer_encoding(mi, &sb);
+		if (!decode_header(mi, &sb))
+			handle_content_transfer_encoding(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
 	if (cmp_header(line, "Message-Id")) {
 		len = strlen("Message-Id: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
-		decode_header(mi, &sb);
-		handle_message_id(mi, &sb);
+		if (!decode_header(mi, &sb))
+			handle_message_id(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
@@ -537,11 +538,12 @@ static void convert_to_utf8(struct mailinfo *mi,
 	strbuf_attach(line, out, strlen(out), strlen(out));
 }
 
-static void decode_header(struct mailinfo *mi, struct strbuf *it)
+static int decode_header(struct mailinfo *mi, struct strbuf *it)
 {
 	char *in, *ep, *cp;
 	struct strbuf outbuf = STRBUF_INIT, *dec;
 	struct strbuf charset_q = STRBUF_INIT, piecebuf = STRBUF_INIT;
+	int found_error = -1; /* pessimism */
 
 	in = it->buf;
 	while (in - it->buf <= it->len && (ep = strstr(in, "=?")) != NULL) {
@@ -610,10 +612,13 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 	strbuf_addstr(&outbuf, in);
 	strbuf_reset(it);
 	strbuf_addbuf(it, &outbuf);
+	found_error = 0;
 release_return:
 	strbuf_release(&outbuf);
 	strbuf_release(&charset_q);
 	strbuf_release(&piecebuf);
+
+	return found_error;
 }
 
 static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
-- 
2.6.1-320-g86a1181
