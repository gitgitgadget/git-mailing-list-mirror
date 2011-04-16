From: "ZHANG, Le" <r0bertz@gentoo.org>
Subject: [PATCH 1/2] mailinfo.c: Allow convert_to_utf8() to specify both src/dst charset and do conversion alone
Date: Sat, 16 Apr 2011 13:49:31 -0700
Message-ID: <1302986971-28080-1-git-send-email-r0bertz@gentoo.org>
Cc: "ZHANG, Le" <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 22:49:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBCRC-0007hV-L7
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 22:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab1DPUtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 16:49:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64375 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab1DPUtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 16:49:45 -0400
Received: by pvg12 with SMTP id 12so1576456pvg.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 13:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=Fsr2Gutcc08BRrFtM3HEOlC3K6exRs0/5Gsd0piAjBQ=;
        b=ZfoWGCaJF02kVT0JzLaW/uXvy4Y7w3od+SH332F2Ocbm2n7pEcuhFMXFkMR2Dh+yjQ
         8vS2Kas8aveuxnCnxLsuTqkjeWI+WklNyme3ugclsQ8MZB2BmIbYLDkYp/x9VKsCvJ9t
         FFDOEarzq61Z9zqFW9VUguqD3+F7Gobzn1j1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=f0xwiygK8mazM+Nl8ArjL+X19obdEADMS+lH7zUNH8UAXnZHTQ0aKH05a4X7Lib254
         N7DIAlhtUquwJsb5KJA3VOkduHNcHEJsiHS+KOdzkEGagpUBWKlE5hUHGJX/2fSO7Gpv
         nump2FmnLa1kM+d83VvXQEnULSKmXf+l346iQ=
Received: by 10.68.29.230 with SMTP id n6mr4293143pbh.130.1302986984842;
        Sat, 16 Apr 2011 13:49:44 -0700 (PDT)
Received: from localhost (c-67-180-129-150.hsd1.ca.comcast.net [67.180.129.150])
        by mx.google.com with ESMTPS id c3sm1260125pbg.68.2011.04.16.13.49.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 13:49:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc2.5.gb2ee76.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171693>

The convert_to_utf8() function actually converts to whatever charset
"metainfo_charset" variable contains, which is not necessarily UTF-8.
Rename it to convert_to(), and give an extra parameter "to_charset" to
specify what charset to re-encode to.  Also rename its "charset"
parameter to "from_charset" to clarify which is which.

Also convert_to_utf8() tries to guess what the src charset is if it is
not specified. And the guess_charset() function does not do exactly what
its name says. So make convert_to() only do the conversion. Make a new
function guess_and_convert_to().

Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>
---
 builtin/mailinfo.c |   44 ++++++++++++++++++++------------------------
 1 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 71e6262..0f42ff1 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -472,6 +472,20 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 	return out;
 }
 
+static void convert_to(struct strbuf *line, const char *to_charset, const char *from_charset)
+{
+	char *out;
+
+	if (!strcasecmp(to_charset, from_charset))
+		return;
+
+	out = reencode_string(line->buf, to_charset, from_charset);
+	if (!out)
+		die("cannot convert from %s to %s",
+		    from_charset, to_charset);
+	strbuf_attach(line, out, strlen(out), strlen(out));
+}
+
 /*
  * When there is no known charset, guess.
  *
@@ -483,32 +497,14 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
  * Otherwise, we default to assuming it is Latin1 for historical
  * reasons.
  */
-static const char *guess_charset(const struct strbuf *line, const char *target_charset)
+static void guess_and_convert_to(struct strbuf *line, const char *to_charset)
 {
-	if (is_encoding_utf8(target_charset)) {
+	if (is_encoding_utf8(to_charset)) {
 		if (is_utf8(line->buf))
-			return NULL;
-	}
-	return "ISO8859-1";
-}
-
-static void convert_to_utf8(struct strbuf *line, const char *charset)
-{
-	char *out;
-
-	if (!charset || !*charset) {
-		charset = guess_charset(line, metainfo_charset);
-		if (!charset)
 			return;
 	}
 
-	if (!strcasecmp(metainfo_charset, charset))
-		return;
-	out = reencode_string(line->buf, metainfo_charset, charset);
-	if (!out)
-		die("cannot convert from %s to %s",
-		    charset, metainfo_charset);
-	strbuf_attach(line, out, strlen(out), strlen(out));
+    convert_to(line, to_charset, "ISO8859-1");
 }
 
 static int decode_header_bq(struct strbuf *it)
@@ -577,7 +573,7 @@ static int decode_header_bq(struct strbuf *it)
 			break;
 		}
 		if (metainfo_charset)
-			convert_to_utf8(dec, charset_q.buf);
+			convert_to(dec, metainfo_charset, charset_q.buf);
 
 		strbuf_addbuf(&outbuf, dec);
 		strbuf_release(dec);
@@ -602,7 +598,7 @@ static void decode_header(struct strbuf *it)
 	 * This can be binary guck but there is no charset specified.
 	 */
 	if (metainfo_charset)
-		convert_to_utf8(it, "");
+		guess_and_convert_to(it, metainfo_charset);
 }
 
 static void decode_transfer_encoding(struct strbuf *line)
@@ -796,7 +792,7 @@ static int handle_commit_msg(struct strbuf *line)
 
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
-		convert_to_utf8(line, charset.buf);
+		convert_to(line, metainfo_charset, charset.buf);
 
 	if (use_scissors && is_scissors_line(line)) {
 		int i;
-- 
1.7.5.rc2.5.gb2ee76.dirty
