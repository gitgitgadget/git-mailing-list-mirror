From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v15 03/16] quote.c: substitute path_relative with relative_path
Date: Tue, 25 Jun 2013 23:53:44 +0800
Message-ID: <e1aa7e7d2e9ec1cd021ceffa7fd5cc4e858dd30b.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:54:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVZk-0003q3-QS
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab3FYPy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:54:26 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:57160 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab3FYPyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:54:22 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so12807064pac.29
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=nLxUnFo/bUjdSb38wRXxR/6nAZd5eJY5PwMjdnMLjp8=;
        b=iRiBZIp2xJ+cLmu1C1U/4xoBTqGTfdtZ0AsDtZCjPOj+jKAk6bKxBf94iOoq24JFSB
         ahwUWOD3vnksY8zb7MGS5JOI4P5R1zZMJEFaAE/FOMrejZzI44OdU5Ixq7DZ0DY4zOKT
         ULupevgMw1VnWFSJJUofaH2+GXuBRRTXG5g1EbSFscUYiKhhZ3kORynE38epIc23bPy/
         +s+qNNB3LTzhPRm7Vb+cWvEaH+0kVPkkjDAOdnj7gNueHbfyDzOk/8LKLD6wOeLiD6L1
         aZdpkiBBRvIOeMYSAeirtZnSCtaNm3l7xAzm32J3f4ar7sPkwH9bMv7LUMVMxoWA5Ses
         Zmvg==
X-Received: by 10.68.170.97 with SMTP id al1mr29537038pbc.0.1372175662060;
        Tue, 25 Jun 2013 08:54:22 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id pb5sm23760930pbc.29.2013.06.25.08.54.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:54:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g2e9b71f
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228964>

Substitute the function path_relative in quote.c with the function
relative_path. Function relative_path can be treated as an enhanced
and robust version of path_relative.

Outputs of path_relative and it's replacement (relative_path) are the
same for the following cases:

    path      prefix     output of path_relative  output of relative_path
    ========  =========  =======================  =======================
    /a/b/c/   /a/b/      c/                       c/
    /a/b/c    /a/b/      c                        c
    /a/       /a/b/      ../                      ../
    /         /a/b/      ../../                   ../../
    /a/c      /a/b/      ../c                     ../c
    /x/y      /a/b/      ../../x/y                ../../x/y
    a/b/c/    a/b/       c/                       c/
    a/        a/b/       ../                      ../
    x/y       a/b/      ../../x/y                 ../../x/y
    /a/b      (empty)    /a/b                     /a/b
    /a/b      (null)     /a/b                     /a/b
    a/b       (empty)    a/b                      a/b
    a/b       (null)     a/b                      a/b

But if both of the path and the prefix are the same, or the returned
relative path should be the current directory, the outputs of both
functions are different. Function relative_path returns "./", while
function path_relative returns empty string.

    path      prefix     output of path_relative  output of relative_path
    ========  =========  =======================  =======================
    /a/b/     /a/b/      (empty)                  ./
    a/b/      a/b/       (empty)                  ./
    (empty)   (null)     (empty)                  ./
    (empty)   (empty)    (empty)                  ./

But not panic, the callers of path_relative can handle such cases, or
never encounter this issue at all. E.g.

 * In function quote_path_relative, if the output of path_relative is
   empty, append "./" to it, like:

       if (!out->len)
           strbuf_addstr(out, "./");

 * Another caller is write_name_quoted_relative, which is only used by
   builtin/ls-files.c. git-ls-files only show files, so path of files
   will never be identical with the prefix of a directory.

The following differences show that path_relative can not handle
extra slashes properly.

    path      prefix     output of path_relative  output of relative_path
    ========  =========  =======================  =======================
    /a//b//c/ //a/b//    ../../../../a//b//c/     c/
    a/b//c    a//b       ../b//c                  c

And if prefix has no trailing slash, path_relative can not work properly
either. But since prefix always has a trailing slash, so it's not a
problem.

    path      prefix     output of path_relative  output of relative_path
    ========  =========  =======================  =======================
    /a/b/c/   /a/b       b/c/                     c/
    /a/b      /a/b       b                        ./
    /a/b/     /a/b       b/                       ./
    /a        /a/b/      ../../a                  ../
    a/b/c/    a/b        b/c/                     c/
    a/b/      a/b        b/                       ./
    a         a/b        ../a                     ../
    x/y       a/b/       ../x/y                   ../../x/y
    a/c       a/b        c                        ../c
    /a/       /a/b       (empty)                  ../
    (empty)   /a/b       ../../                   ./

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/ls-files.c |  7 +++++--
 quote.c            | 55 ++----------------------------------------------------
 2 files changed, 7 insertions(+), 55 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 3a410c..d100 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -48,8 +48,11 @@ static const char *tag_resolve_undo = "";
 
 static void write_name(const char* name, size_t len)
 {
-	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
-			line_terminator);
+	/* Since prefix_len is ignored in write_name_quoted_relative, we
+	 * should turn off prefix here in case of running "git ls-files"
+	 * with "--full-name" option */
+	write_name_quoted_relative(name, len, prefix_len ? prefix : NULL,
+			prefix_len, stdout, line_terminator);
 }
 
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
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
1.8.3.1.756.g2e9b71f
