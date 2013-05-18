From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 03/15] quote.c: remove path_relative, use relative_path instead
Date: Sat, 18 May 2013 11:18:55 +0800
Message-ID: <2833373ff27b064b34d6a2bd827ceb05df272d62.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:19:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXgU-0004GC-8c
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495Ab3ERDTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:19:36 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:48744 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759358Ab3ERDTb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:31 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so4150609pab.3
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=zXy6zoGVXWAIE0b1aMYmYkA6XtWWYHj5SR3rIi25mBQ=;
        b=yionifa2jzLlGsr+adevUwozB8L8NfN8juiomSpa4gjNhEpjWOdYY7qpuqINcqmvOX
         fH8VP4IfM7C5U1tr1J1TvdA9wLwq/2z6kyEwslP8A4ZLmZVkTV8BDJPt5ObaeIXs5eMv
         kq2yRvg7/cX7cKfZq8MRV4LF6gC3TCvk0VmHqQM8Vcyko1gzQFDgYi6ruQqK1Y63HuE+
         ETeY9saw2S0c1vHB4dgpth2J8Gp4oq2LkO7cG8ysUvPhzh/g5sZJDA3BX8ViePNYutpz
         JG0B9V6ubbHm7Nhx3iKo9szJ69WJ7J9msMe2UwcFhxytPIvnv2waqaYHoFfllyubHINq
         RVVg==
X-Received: by 10.66.144.170 with SMTP id sn10mr51334702pab.42.1368847170612;
        Fri, 17 May 2013 20:19:30 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224755>

Since there is an enhanced version of relative_path() in path.c,
remove duplicate counterpart path_relative() in quote.c.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 quote.c | 55 ++-----------------------------------------------------
 1 file changed, 2 insertions(+), 53 deletions(-)

diff --git a/quote.c b/quote.c
index 91122..64ff3 100644
--- a/quote.c
+++ b/quote.c
@@ -312,75 +312,24 @@ void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 	fputc(terminator, fp);
 }
 
-static const char *path_relative(const char *in, int len,
-				 struct strbuf *sb, const char *prefix,
-				 int prefix_len);
-
 void write_name_quoted_relative(const char *name, size_t len,
 				const char *prefix, size_t prefix_len,
 				FILE *fp, int terminator)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	name = path_relative(name, len, &sb, prefix, prefix_len);
+	name = relative_path(name, prefix, &sb);
 	write_name_quoted(name, fp, terminator);
 
 	strbuf_release(&sb);
 }
 
-/*
- * Give path as relative to prefix.
- *
- * The strbuf may or may not be used, so do not assume it contains the
- * returned path.
- */
-static const char *path_relative(const char *in, int len,
-				 struct strbuf *sb, const char *prefix,
-				 int prefix_len)
-{
-	int off, i;
-
-	if (len < 0)
-		len = strlen(in);
-	if (prefix_len < 0) {
-		if (prefix)
-			prefix_len = strlen(prefix);
-		else
-			prefix_len = 0;
-	}
-
-	off = 0;
-	i = 0;
-	while (i < prefix_len && i < len && prefix[i] == in[i]) {
-		if (prefix[i] == '/')
-			off = i + 1;
-		i++;
-	}
-	in += off;
-	len -= off;
-
-	if (i >= prefix_len)
-		return in;
-
-	strbuf_reset(sb);
-	strbuf_grow(sb, len);
-
-	while (i < prefix_len) {
-		if (prefix[i] == '/')
-			strbuf_addstr(sb, "../");
-		i++;
-	}
-	strbuf_add(sb, in, len);
-
-	return sb->buf;
-}
-
 /* quote path as relative to the given prefix */
 char *quote_path_relative(const char *in, int len,
 			  struct strbuf *out, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *rel = path_relative(in, len, &sb, prefix, -1);
+	const char *rel = relative_path(in, prefix, &sb);
 	strbuf_reset(out);
 	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
 	strbuf_release(&sb);
-- 
1.8.3.rc2.26.g7472058
