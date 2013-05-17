From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v11 03/15] quote.c: remove path_relative, use relative_path instead
Date: Fri, 17 May 2013 17:20:07 +0800
Message-ID: <7b8ea0b3ddb930e92d24934e43592eee302bf189.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 11:20:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGqG-0006AW-EE
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 11:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab3EQJUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 05:20:42 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:35868 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3EQJUk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 05:20:40 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so3130175pbc.32
        for <git@vger.kernel.org>; Fri, 17 May 2013 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=PzOcOpDwPCHY23QsNlFBfPyKIpkJNo1LfaIALMqfBTY=;
        b=TPg9fkibGO9VO5gzAdQA1hfK6jZcCMps8a38i36nCQFUMm6gm7F49Bav4vjo7ZcmsN
         L6Qft9+r1wJcCfD7G2aaWCKJmApgNITvvazRQCAQiLC5niTjxpEo9ZXnE/7PpCd5yaEo
         IZXHZAmzSXV8lBMPSBMoF2BNs5N6NbKa23YNbHIJNHY10mQa0f3ojnbyx6R2R0GVqV7X
         lZhgVa6LzN2e1sBdKNh8WhcD3MzdD75NVie459oxMbHSZsmc7WpHVvU24rFj31yB73Xi
         sn09Gblk/pPC6PAf77QgqKtCHqDvztWZVrrdV2sineheHW4irX6m5WvTX4VrsFu9DmYv
         jVGg==
X-Received: by 10.66.249.232 with SMTP id yx8mr48462625pac.118.1368782439601;
        Fri, 17 May 2013 02:20:39 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id 10sm10531002pbm.0.2013.05.17.02.20.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 02:20:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.380.g956c2b2
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224668>

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
1.8.3.rc2.380.g956c2b2
