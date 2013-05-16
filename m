From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v10 02/14] quote.c: remove path_relative, use relative_path instead
Date: Thu, 16 May 2013 17:53:33 +0800
Message-ID: <921920c06cfe8a3abb9c73c5b2f61ac692f3bda6.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 11:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucut0-0000gG-Rd
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab3EPJyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:54:08 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:49493 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab3EPJyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:54:05 -0400
Received: by mail-pd0-f172.google.com with SMTP id 6so2197186pdd.17
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=vR3u9e3Ev5nuDujrDzSCqbOQ+Zg8pACyzi4ZPgT+DJg=;
        b=g+D/sRa3JRxfz0nBbtWm5IfDWVKC7vlRsmSsHoX3MQq03OdF2LbVCVO2vXYAi2Z+LF
         skgMyLEeR/YGfQsHygXVmD9zKIXhR6qvytYBZkx2qZfwmvX0WdXIgrPICGMKh5atPK2H
         1uDMPxW1Q2yYo3AxRIXSMvaxzPMAkkkh6AiO2rv+djq6ba2VL7e4R+nS2qxXArbtVr2U
         KLNJ4ncNZ3ACTe47gzuAylFKCzxpDF6K+DWhAviMMMtnEMdo6SBQjYq7S7F1TRqLFpig
         CzsKxWC53LmlSLBFuwv0j3F0j1vZMlF3XbOcPaK+lPOEUfDxGNzzeVBPJ5Khy0OPRXsp
         jjbQ==
X-Received: by 10.66.190.104 with SMTP id gp8mr44186293pac.84.1368698044904;
        Thu, 16 May 2013 02:54:04 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id cd2sm6183092pbd.35.2013.05.16.02.54.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 02:54:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.407.g762149a
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224529>

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
1.8.3.rc1.407.g762149a
