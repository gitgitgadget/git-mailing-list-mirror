From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 32/34] mailinfo: handle charset conversion errors in the caller
Date: Mon, 19 Oct 2015 00:28:49 -0700
Message-ID: <1445239731-10677-33-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4t0-0002rZ-TM
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbbJSH3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:34 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35157 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbbJSH3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:33 -0400
Received: by pasz6 with SMTP id z6so22270737pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=3Kxx20a0Z/WRgdogBBe+ZZWlieW8XU6bVaVLILSzmB4=;
        b=nb+Wpq9FHYxPAAFVAbcRFsmYfHLZJd8OUsQixyzWbtz4bOsramJQRuA/n/Ssl+qEsl
         Ve71vtQp8+kvDHUUro8uue+F7RduRBbb4lGPhLlJsR0s1c0qBN6xc3APM5WVidZv4Qky
         xhYDMlajTpmWGYoAeVJnhyV/xQGBCnaNIXqugUSwaWL8xatfhyXqNhOvJ5hsXY/KNiD0
         YllUq0aTLkoeUMkySDR1+KxTWpi99XCklyEmr2hnqg2+N2SB9YZnjfvoy5vrXAl05jSb
         UlmgmEmQj4j7CpEpKafewYvPJnk2isOPczLKw3q6iPRfGfiGcJzZbCKgi4PucYisuLQe
         PiLw==
X-Received: by 10.68.196.202 with SMTP id io10mr33397448pbc.108.1445239772651;
        Mon, 19 Oct 2015 00:29:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id qy7sm34858030pab.37.2015.10.19.00.29.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:32 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279843>

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
index df6cfef..4fbf38f 100644
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
2.6.2-383-g144b2e6
