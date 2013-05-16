From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v10 01/14] path.c: refactor relative_path(), not only strip prefix
Date: Thu, 16 May 2013 17:53:32 +0800
Message-ID: <ff3d9c2d6eb4e7fc3048661ee3558540fc0eeab8.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 11:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucut0-0000gG-9a
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab3EPJyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:54:05 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:60784 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab3EPJyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:54:01 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so2196639pde.37
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=bEBNTBp83yLU5hjacp4iGTzKzGzMz9N+jKhe5mQVahg=;
        b=X+HtaVd0gG/scFkVNzme6pnGe5/Kd1YSde8GLBRWLXMr7pQGyoGo8Z1xwbERJuVDWK
         ZzCdCTPPx4AzBeB7fxdoROOXUd6Xb/+EVP/xGsvVOpG3nHUZe8/l/zzrWSnol0c4eZRB
         z4cjrV6yswiKI+rSNoFgrMjmcC0kaMYCsLCfcdLZyZNGwro9/fWRFntw9I0eejXJR4nR
         hKlOj6QwPUDBATwdnQmJ64v2zRzHYcxbr9nt+4Xhtq4Czy4V9Qn5rk9huRV/Pi7WTPCh
         Y9Yiy5reFlEoeDXTnDt6z2R24YO4zntCJd0MynqVyYxmVp+qPX0KMMYuuc62liYPq46H
         YXUg==
X-Received: by 10.66.118.79 with SMTP id kk15mr11429983pab.193.1368698041330;
        Thu, 16 May 2013 02:54:01 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id cd2sm6183092pbd.35.2013.05.16.02.53.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 02:54:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.407.g762149a
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224530>

Original design of relative_path() is simple, just strip the prefix
(*base) from the abosolute path (*abs). In most cases, we need a real
relative path, such as: ../foo, ../../bar. That's why there is another
reimplementation (path_relative()) in quote.c.

Refactor relative_path() in path.c to return real relative path, so
that user can reuse this function without reimplement his/her own.
I will use this method for interactive git-clean later. Some of the
implementations are borrowed from path_relative() in quote.c.

Different results for relative_path() before and after this refactor:

    base path  abs path  relative (orignal)  relative (refactor)
    =========  ========  ==================  ===================
    /a/b       /a/b/c/   c/                  c/
    //a///b/   /a/b//c/  c/                  c/
    /a/b       /a/b      .                   ./
    /a/b       /a/b/     .                   ./
    /a/b/      /a        /a                  ../
    /a/b/      /         /                   ../../
    /a/b/      /a/c      /a/c                ../c
    (empty)    /a/b      /a/b                /a/b
    NULL       /a/b      /a/b                /a/b
    /a/b       (empty)   (empty)             ./

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 cache.h |   2 +-
 path.c  | 112 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
 setup.c |   5 ++-
 3 files changed, 92 insertions(+), 27 deletions(-)

diff --git a/cache.h b/cache.h
index 7ce9..f0c69 100644
--- a/cache.h
+++ b/cache.h
@@ -737,7 +737,7 @@ int is_directory(const char *);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 const char *absolute_path(const char *path);
-const char *relative_path(const char *abs, const char *base);
+const char *relative_path(const char *abs, const char *base, struct strbuf *sb);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, struct string_list *prefixes);
 char *strip_path_suffix(const char *path, const char *suffix);
diff --git a/path.c b/path.c
index 04ff..e24ea 100644
--- a/path.c
+++ b/path.c
@@ -441,42 +441,104 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
-const char *relative_path(const char *abs, const char *base)
+/*
+ * Give path as relative to prefix.
+ *
+ * The strbuf may or may not be used, so do not assume it contains the
+ * returned path.
+ */
+const char *relative_path(const char *abs, const char *base,
+			  struct strbuf *sb)
 {
-	static char buf[PATH_MAX + 1];
-	int i = 0, j = 0;
-
-	if (!base || !base[0])
+	int abs_off, base_off, i, j;
+	int abs_len, base_len;
+
+	abs_len = abs? strlen(abs): 0;
+	base_len = base ? strlen(base) : 0;
+	abs_off = 0;
+	base_off = 0;
+	i = 0;
+	j = 0;
+
+	if (!abs_len)
+		return "./";
+	else if (!base_len)
 		return abs;
-	while (base[i]) {
+
+	while (i < base_len && j < abs_len && base[i] == abs[j]) {
 		if (is_dir_sep(base[i])) {
-			if (!is_dir_sep(abs[j]))
-				return abs;
 			while (is_dir_sep(base[i]))
 				i++;
 			while (is_dir_sep(abs[j]))
 				j++;
-			continue;
-		} else if (abs[j] != base[i]) {
+			base_off = i;
+			abs_off = j;
+		} else {
+			i++;
+			j++;
+		}
+	}
+
+	if (
+	    /* base seems like prefix of abs */
+	    i >= base_len &&
+	    /*
+	     * but "/foo" is not a prefix of "/foobar"
+	     * (i.e. base not end with '/')
+	     */
+	    base_off < base_len) {
+		if (j >= abs_len) {
+			/* abs="/a/b", base="/a/b" */
+			abs_off = abs_len;
+		} else if (is_dir_sep(abs[j])) {
+			/* abs="/a/b/c", base="/a/b" */
+			while (is_dir_sep(abs[j]))
+				j++;
+			abs_off = j;
+		} else {
+			/* abs="/a/bbb/c", base="/a/b" */
+			i = base_off;
+		}
+	} else if (
+		   /* abs is short than base (prefix of base) */
+		   j >= abs_len &&
+		   /* abs not end with '/' */
+		   abs_off < abs_len) {
+		if (is_dir_sep(base[i])) {
+			/* abs="/a/b", base="/a/b/c/" */
+			while (is_dir_sep(base[i]))
+				i++;
+			abs_off = abs_len;
+		}
+	}
+	abs += abs_off;
+	abs_len -= abs_off;
+
+	if (i >= base_len) {
+		if (!abs_len)
+			return "./";
+		else
 			return abs;
+	}
+
+	strbuf_reset(sb);
+	strbuf_grow(sb, abs_len);
+
+	while (i < base_len) {
+		if (is_dir_sep(base[i])) {
+			strbuf_addstr(sb, "../");
+			while (is_dir_sep(base[i]))
+				i++;
+			continue;
 		}
 		i++;
-		j++;
 	}
-	if (
-	    /* "/foo" is a prefix of "/foo" */
-	    abs[j] &&
-	    /* "/foo" is not a prefix of "/foobar" */
-	    !is_dir_sep(base[i-1]) && !is_dir_sep(abs[j])
-	   )
-		return abs;
-	while (is_dir_sep(abs[j]))
-		j++;
-	if (!abs[j])
-		strcpy(buf, ".");
-	else
-		strcpy(buf, abs + j);
-	return buf;
+	if (!is_dir_sep(base[base_len - 1]))
+		strbuf_addstr(sb, "../");
+
+	strbuf_addstr(sb, abs);
+
+	return sb->buf;
 }
 
 /*
diff --git a/setup.c b/setup.c
index 94c1e..0d9ea 100644
--- a/setup.c
+++ b/setup.c
@@ -360,6 +360,7 @@ int is_inside_work_tree(void)
 
 void setup_work_tree(void)
 {
+	struct strbuf sb = STRBUF_INIT;
 	const char *work_tree, *git_dir;
 	static int initialized = 0;
 
@@ -379,8 +380,10 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
 
-	set_git_dir(relative_path(git_dir, work_tree));
+	set_git_dir(relative_path(git_dir, work_tree, &sb));
 	initialized = 1;
+
+	strbuf_release(&sb);
 }
 
 static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
-- 
1.8.3.rc1.407.g762149a
