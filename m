From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 02/11] strbuf: add non-variadic function strbuf_vaddf()
Date: Thu, 26 Nov 2009 00:44:11 +0000
Message-ID: <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSTE-00011M-9L
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759900AbZKZAoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759878AbZKZAoR
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:44:17 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46652 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759714AbZKZAoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:44:16 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so298499ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xJKZ8RmFXz190VH89UfLMkRzw76M3RIRt11f2Gj1EFk=;
        b=RlErj/R3GL3M6eMQ/3nXbY4y6QpHe1m867LxjHY4swsvgRLIdrtzCNgTzRMf6pdLiN
         hAPdtBk1PN+jdQ+9n8A9dxjxnPEpnZmnSCWKN67J1IGjA13wADAOTyUfFp918gEl78uv
         16yMAbNOVFWKellHXczeW2AZLasybpKjQX+9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m6YZyUV7lwpsMntcvcW3zP+FBvD69hXfvSMyY40qsuAu1qBAn5gSPd1K/ctjrWAVuV
         dyIZVmj50Ts9NCuI57iJPiEu2KSArgai/UwgaNdyazCigzW5kecAX8i/0xQQe217wKSP
         ZuXYS6/U9UvvozJGO1hrsDF5p/VNuAyuX+1ms=
Received: by 10.213.0.142 with SMTP id 14mr1847057ebb.49.1259196262328;
        Wed, 25 Nov 2009 16:44:22 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 10sm386124eyz.39.2009.11.25.16.44.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:21 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133733>

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
