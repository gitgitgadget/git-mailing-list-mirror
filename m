From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v13 03/15] quote.c: remove path_relative, use relative_path instead
Date: Wed, 22 May 2013 09:40:24 +0800
Message-ID: <ef1890e84a0ac4ccf5d4e37605e1fafde8561b45.1369186574.git.worldhello.net@gmail.com>
References: <cover.1369186574.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 03:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uey3N-0001VA-RO
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 03:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab3EVBlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 21:41:04 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36290 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab3EVBkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 21:40:55 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf10so271229pab.38
        for <git@vger.kernel.org>; Tue, 21 May 2013 18:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=NDVhDHa3MR7vquxZ/Wzb39l2wU1A8JOp6z7rr/Ry0mc=;
        b=eiE0pkS2a9FcZEnG5/dz76L5S0c03VoPwJstVIEZNniBRb9qrJ6MQckVIDq2Bq6U6V
         JbYdz+MVz91uxWzGoCEVDnrYC2JVkw9pIo45eNA9UaidrQ7cVzt0adsQTNtLoKQ+uX7Q
         69+UiVfKQccxozWzIzD5IiYhQjqPqMEadNSXvh8AT/EqR9iRaDqzttOmCdRrh+aq3aoC
         WzTe9znQ0sx5jfzVgovUdGIAhlmdmt/VePCo4/gSzl7wKDn7l7/dhRR8RJx9I7Lf6UVf
         wrD92xjWRL2EPGKwngz4lp2GSGCDuORMJ6Oflg9KST/K8KvELOq8BSFTmpaq6IsEYig7
         4/kw==
X-Received: by 10.68.17.8 with SMTP id k8mr5484502pbd.102.1369186855208;
        Tue, 21 May 2013 18:40:55 -0700 (PDT)
Received: from localhost.localdomain ([114.248.150.82])
        by mx.google.com with ESMTPSA id at1sm4939345pbc.10.2013.05.21.18.40.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 18:40:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.368.g7c798dd
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
References: <7vhahwm5n6.fsf@alter.siamese.dyndns.org> <cover.1369186574.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225109>

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
1.8.3.rc3.368.g7c798dd
