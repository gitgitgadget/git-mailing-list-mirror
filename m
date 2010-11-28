From: "ZHANG, Le" <r0bertz@gentoo.org>
Subject: [PATCH v4 1/4] mailinfo.c: convert_to_utf8(): added a target_charset parameter
Date: Mon, 29 Nov 2010 03:10:14 +0800
Message-ID: <1290971417-4474-2-git-send-email-r0bertz@gentoo.org>
References: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
Cc: "ZHANG, Le" <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 20:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMmeB-000182-AV
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab0K1TKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:10:42 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42660 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab0K1TKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 14:10:41 -0500
Received: by gwj20 with SMTP id 20so1663586gwj.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 11:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=zPtm8FNaCVu/rR6fiQGBXX839FCgQw62s479Jv8ca4Y=;
        b=qRX6X0GiQdr648Imw8MqTLpHeg7L0CatkyVqOMH0XplsrEg9z3/SaL8vWf+M28ud6+
         PSkKeuxtBwHHvWkWdT/DChgr1KP71YLu0NF9JgqWDqlgabmKldKFwxQUNSE8LiZ4K7MX
         mrXmA7KRLrm9ED7c9/dxRRazfj3H5iw9l7/B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=N+c4c29bBhuDSgkpNIqYGYu1gqrsmUMzpaxMDg7k5Ijz/Oq8xdkSDgVmPSSN0L3/6y
         LR+RV+nRGsYkizr+BsNCWXfPRMbbp3t0WbHgincM8tFwAuFWF6vtQR0oF08Su4djjiMm
         1TLVZVMylroS4uAu9wiEbO7GlfgGU/J8cLgR4=
Received: by 10.151.46.18 with SMTP id y18mr8913660ybj.324.1290971440612;
        Sun, 28 Nov 2010 11:10:40 -0800 (PST)
Received: from localhost ([183.37.0.219])
        by mx.google.com with ESMTPS id q8sm3989321ybk.12.2010.11.28.11.10.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 11:10:39 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.344.gb3680.dirty
In-Reply-To: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162346>

This is required for my recode-patch patch which needs a seperate patch_charset variable.

Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>
---
 builtin/mailinfo.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2320d98..1406d9f 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -492,22 +492,22 @@ static const char *guess_charset(const struct strbuf *line, const char *target_c
 	return "ISO8859-1";
 }
 
-static void convert_to_utf8(struct strbuf *line, const char *charset)
+static void convert_to_utf8(struct strbuf *line, const char *charset, const char *target_charset)
 {
 	char *out;
 
 	if (!charset || !*charset) {
-		charset = guess_charset(line, metainfo_charset);
+		charset = guess_charset(line, target_charset);
 		if (!charset)
 			return;
 	}
 
-	if (!strcasecmp(metainfo_charset, charset))
+	if (!strcasecmp(target_charset, charset))
 		return;
-	out = reencode_string(line->buf, metainfo_charset, charset);
+	out = reencode_string(line->buf, target_charset, charset);
 	if (!out)
 		die("cannot convert from %s to %s",
-		    charset, metainfo_charset);
+		    charset, target_charset);
 	strbuf_attach(line, out, strlen(out), strlen(out));
 }
 
@@ -577,7 +577,7 @@ static int decode_header_bq(struct strbuf *it)
 			break;
 		}
 		if (metainfo_charset)
-			convert_to_utf8(dec, charset_q.buf);
+			convert_to_utf8(dec, charset_q.buf, metainfo_charset);
 
 		strbuf_addbuf(&outbuf, dec);
 		strbuf_release(dec);
@@ -602,7 +602,7 @@ static void decode_header(struct strbuf *it)
 	 * This can be binary guck but there is no charset specified.
 	 */
 	if (metainfo_charset)
-		convert_to_utf8(it, "");
+		convert_to_utf8(it, "", metainfo_charset);
 }
 
 static void decode_transfer_encoding(struct strbuf *line)
@@ -796,7 +796,7 @@ static int handle_commit_msg(struct strbuf *line)
 
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
-		convert_to_utf8(line, charset.buf);
+		convert_to_utf8(line, charset.buf, metainfo_charset);
 
 	if (use_scissors && is_scissors_line(line)) {
 		int i;
-- 
1.7.3.2.344.gb3680.dirty
