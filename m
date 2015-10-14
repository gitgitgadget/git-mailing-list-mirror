From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 29/31] mailinfo: handle charset conversion errors in the caller
Date: Wed, 14 Oct 2015 13:45:55 -0700
Message-ID: <1444855557-2127-30-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:47:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSxH-0002Kx-J9
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946AbbJNUq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:59 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32768 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447AbbJNUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:39 -0400
Received: by pabrc13 with SMTP id rc13so64162762pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=rZsyS7Ld7jR8QYRWGC1kg7pGKitgcHmQQNzLw6+iBgI=;
        b=As+eAVVP1HKgffrlFxaGOPLRZS688zq8N8UbyUv4NEyQ84ncBJp7pryDgd16Tdvn/O
         77Hml1/TF9X+fFAy/+3GOvI9XYyqAivUTM3mqL2PWLIX9qgo4dwFeop23PnTmbaWISOs
         XQ2hFfsw/vBh+XtztmObWWDI4k7vQkM+xZU9SIQ3fLrmzMic6Y8MVi846/lH5V5iDFG6
         z9tI4mxuEc9kCCNqzvT9NyjZ9r3D+138w1vPznt+CFbF3w93IdxqrvwhKODtitR3iJF5
         2tPpxG3oD0vPOcQOSnzQrDpXHhNaZneZJdjUgP+gmsB/UdJSqf37t/MTq1pULHdy+246
         RdWg==
X-Received: by 10.66.193.162 with SMTP id hp2mr5633592pac.108.1444855599505;
        Wed, 14 Oct 2015 13:46:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id qv5sm11268523pbc.71.2015.10.14.13.46.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:34 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279608>

Instead of dying in convert_to_utf8(), just report an error and let
the callers handle it.  Between the two callers:

 - decode_header() silently punts when it cannot parse a broken
   RFC2047 encoded text (e.g. when it sees anything other than B or
   Q after it sees "=?<charset>") by jumping to release_return,
   returning the string it successfully parsed out so far, to the
   caller.  A piece of string that convert_to_utf8() cannot handle
   can be treated the same way.

 - handle_commit_msg() doesn't cope with a malformed line well, so
   die there for now.  We'll lift this even higher in later changes
   in this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailinfo.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 59479f6..7969bf4 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -344,21 +344,22 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 	return out;
 }
 
-static void convert_to_utf8(struct mailinfo *mi,
-			    struct strbuf *line, const char *charset)
+static int convert_to_utf8(struct mailinfo *mi,
+			   struct strbuf *line, const char *charset)
 {
 	char *out;
 
 	if (!mi->metainfo_charset || !charset || !*charset)
-		return;
+		return 0;
 
 	if (same_encoding(mi->metainfo_charset, charset))
-		return;
+		return 0;
 	out = reencode_string(line->buf, mi->metainfo_charset, charset);
 	if (!out)
-		die("cannot convert from %s to %s",
-		    charset, mi->metainfo_charset);
+		return error("cannot convert from %s to %s",
+			     charset, mi->metainfo_charset);
 	strbuf_attach(line, out, strlen(out), strlen(out));
+	return 0;
 }
 
 static void decode_header(struct mailinfo *mi, struct strbuf *it)
@@ -424,7 +425,8 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 			dec = decode_q_segment(&piecebuf, 1);
 			break;
 		}
-		convert_to_utf8(mi, dec, charset_q.buf);
+		if (convert_to_utf8(mi, dec, charset_q.buf))
+			goto release_return;
 
 		strbuf_addbuf(&outbuf, dec);
 		strbuf_release(dec);
@@ -637,7 +639,8 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		mi->header_stage = 0;
 
 	/* normalize the log message to UTF-8. */
-	convert_to_utf8(mi, line, mi->charset.buf);
+	if (convert_to_utf8(mi, line, mi->charset.buf))
+		exit(128);
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
-- 
2.6.1-320-g86a1181
