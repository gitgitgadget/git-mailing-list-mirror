From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 02/11] strbuf: add non-variadic function strbuf_vaddf()
Date: Thu, 26 Nov 2009 00:39:09 +0000
Message-ID: <1259195958-2372-3-git-send-email-kusmabite@gmail.com>
References: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-2-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlecode.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:39:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSOS-0007kB-WB
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbZKZAjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934965AbZKZAjU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:39:20 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41835 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934864AbZKZAjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:39:19 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so295613ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xJKZ8RmFXz190VH89UfLMkRzw76M3RIRt11f2Gj1EFk=;
        b=Ik1pOsL73cPhdiphJ2+b/Rwc7RJP/lpKD6B8bhyLJUbwf9CjnYZyRUcE8av72ZYjbc
         ewI9JpOcv6Jn+IOl82v66bsExZWRas1HfJDRMRJ33BZy1jRSmtUPXW0oq/dywhwsjtNd
         SzAvzdxcb3Ve9pL+pWz7kICB7HL7vDTcFz5Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ckDdc0xNKiD9W0oGmOmtniUPIHXNPGFmMSxm8cEufAicN/82J4pHjIYlIsSKgf5rFb
         sN8V8L/z5yO3iscB07lxXuAEwdyunO8m/t6NsVlwLJSZQ/GjAye6FxFCHUoTBthWzNAx
         X5asXK/buTtwx2cC31AJ7pJAm71EZyGOdpTOE=
Received: by 10.213.24.12 with SMTP id t12mr1842733ebb.70.1259195966139;
        Wed, 25 Nov 2009 16:39:26 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 7sm387084eyg.25.2009.11.25.16.39.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:39:25 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259195958-2372-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133719>

From: Mike Pape <dotzenlabs@gmail.com>

This patch adds strbuf_vaddf, which takes a va_list as input
instead of the variadic input that strbuf_addf takes. This
is useful for fowarding varargs to strbuf_addf.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 strbuf.c |   15 +++++++++------
 strbuf.h |    1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index a6153dc..e1833fb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -190,23 +190,18 @@ void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
+void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
 {
 	int len;
-	va_list ap;
 
 	if (!strbuf_avail(sb))
 		strbuf_grow(sb, 64);
-	va_start(ap, fmt);
 	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
-	va_end(ap);
 	if (len < 0)
 		die("your vsnprintf is broken");
 	if (len > strbuf_avail(sb)) {
 		strbuf_grow(sb, len);
-		va_start(ap, fmt);
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
-		va_end(ap);
 		if (len > strbuf_avail(sb)) {
 			die("this should not happen, your snprintf is broken");
 		}
@@ -214,6 +209,14 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list va;
+	va_start(va, fmt);
+	strbuf_vaddf(sb, fmt, va);
+	va_end(va);
+}
+
 void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
 		   void *context)
 {
diff --git a/strbuf.h b/strbuf.h
index d05e056..8686bcb 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -119,6 +119,7 @@ extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
 
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
-- 
1.6.5.rc2.7.g4f8d3
