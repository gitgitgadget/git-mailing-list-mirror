From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH 1/3] strbuf: Add strbuf_vaddf function
Date: Sun, 11 Apr 2010 12:37:30 +0100
Message-ID: <20100411113733.80010.78232.julian@quantumfyre.co.uk>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
Cc: Eric Raymond <esr@thyrsus.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 13:38:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0vUt-0003XF-8E
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 13:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab0DKLi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 07:38:28 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:41424 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751022Ab0DKLi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 07:38:27 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 2471D819C4C4;
	Sun, 11 Apr 2010 12:38:20 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id D0A2220CF4C;
	Sun, 11 Apr 2010 12:38:25 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 47wv0HoFLjlC; Sun, 11 Apr 2010 12:38:25 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 70D7520CF48;
	Sun, 11 Apr 2010 12:38:25 +0100 (BST)
X-git-sha1: 880462d9d504b9d1d962ac9c5c2a7b206c31288c 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144640>

Add strbuf_vaddf which is to strbuf_addf as vprintf is to printf.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 strbuf.c |   13 +++++++++++--
 strbuf.h |    1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index bc3a080..8f312f8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -194,19 +194,28 @@ void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
 
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 {
+	va_list ap;
+
+	va_start(ap, fmt);
+        strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+}
+
+void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list args)
+{
 	int len;
 	va_list ap;
 
 	if (!strbuf_avail(sb))
 		strbuf_grow(sb, 64);
-	va_start(ap, fmt);
+	va_copy(ap, args);
 	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
 	va_end(ap);
 	if (len < 0)
 		die("your vsnprintf is broken");
 	if (len > strbuf_avail(sb)) {
 		strbuf_grow(sb, len);
-		va_start(ap, fmt);
+		va_copy(ap, args);
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
 		va_end(ap);
 		if (len > strbuf_avail(sb)) {
diff --git a/strbuf.h b/strbuf.h
index fac2dbc..ac52834 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -120,6 +120,7 @@ extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *
 
 __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list args);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
-- 
1.7.0.4
