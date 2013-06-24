From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v14 03/16] quote.c: remove path_relative, use relative_path instead
Date: Mon, 24 Jun 2013 23:21:27 +0800
Message-ID: <654b2387c27470c3dc81169e8f43c231aa9504ce.1372087065.git.worldhello.net@gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8as-0006Jp-Ni
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab3FXPWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:22:11 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36777 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3FXPWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:22:10 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so538278pdj.28
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=MIjV1juw8MOLeK33g78B9dfU5UY+F4CtE2u/ZBooldM=;
        b=mtMHj1olcn/+HDrFx1Z4bzdxMOB8vklpABFXwTGQzGcdco03zKPsStWOBL3OQQxMXq
         7axKp0RkK+kBZqPpSGHDn/KMlk52jLgx/lpDwI9zNzkFZZMizLJmaDN8vNodJ4m2Z2B1
         N/vz7EVJFq29ls0JUdWiZAgiDj+Phr/MUP8fvP8jo4SmovMACPCuM3g0JAtgliIab05o
         bEXqJSA5v8ZDlm0iGwdxL5z8OivDtFjxVCbMFtem4jmDnu+ATTz0NJOy+IwQ15Mpia6d
         BnA3I4GclE6V11Ow/OJJBnyN0BCoa0eQB6GghHmbtA2Yo31romu5kZjthx4YXBac/QXd
         kAzw==
X-Received: by 10.68.171.226 with SMTP id ax2mr24371182pbc.201.1372087329662;
        Mon, 24 Jun 2013 08:22:09 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id ix3sm18576807pbc.37.2013.06.24.08.22.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 08:22:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g41beab0
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
References: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com> <cover.1372087065.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228825>

Since there is an enhanced version of relative_path() in path.c,
remove duplicate counterpart path_relative() in quote.c.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.8.3.1.756.g41beab0
