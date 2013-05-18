From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 02/15] path.c: refactor relative_path(), not only strip prefix
Date: Sat, 18 May 2013 11:18:54 +0800
Message-ID: <1d8f513cd0d9e739bdd54e0c3f14637c7f0a05de.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:19:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXgS-0004GC-ND
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374Ab3ERDTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:19:31 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:52125 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758596Ab3ERDT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:28 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so880689pbc.23
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=3Yd2BkJyfAWOw/JuugnjG/cQZsfwo1KpZLeXbFqMXL4=;
        b=bjmEt32o9TyzIvyY/1WgaUxPEhXv4TbrZqoOM++jHuy0RmAx83A4wLJLXJnCVexgZX
         /CqS9qhjk1oTBRak8J06ASBf9NBklOoJQGsxR9d3f/0T2nMAFpRA/wOOWXGNQfmGpVNv
         bxsy41d0S4GZWEfebQsA4WEwO4i6mbroA4ux1PU0i/7040dbwv1wacucM1RuAF3VqxYx
         P6pOYGPXmhz23Xr3jV90mZBaMByW5zOG7n4bWmBS6G9lMyJn/cKurMaIhrf3ig71IDdR
         ZkruW/eCG37nU/72P9BLXL9iJ8MBkUfg+deO4lCk2wKNyZT9dkxUXXt9a/sPGyzx7McQ
         pGig==
X-Received: by 10.68.60.130 with SMTP id h2mr50363472pbr.208.1368847167874;
        Fri, 17 May 2013 20:19:27 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224757>

Original design of relative_path() is simple, just strip the prefix
(*base) from the absolute path (*abs). In most cases, we need a real
relative path, such as: ../foo, ../../bar. That's why there is another
reimplementation (path_relative()) in quote.c.

Refactor relative_path() in path.c to return real relative path, so
that user can reuse this function without reimplement his/her own.
I will use this method for interactive git-clean later. Some of the
implementations are borrowed from path_relative() in quote.c.

Different results for relative_path() before and after this refactor:

    abs path  base path  relative (original)  relative (refactor)
    ========  =========  ===================  ===================
    /a/b/c/   /a/b       c/                   c/
    /a/b//c/  //a///b/   c/                   c/
    /a/b      /a/b       .                    ./
    /a/b/     /a/b       .                    ./
    /a        /a/b/      /a                   ../
    /         /a/b/      /                    ../../
    /a/c      /a/b/      /a/c                 ../c
    /a/b      (empty)    /a/b                 /a/b
    /a/b      (null)     /a/b                 /a/b
    (empty)   /a/b       (empty)              ./
    (null)    (empty)    (null)               ./
    (null)    /a/b       (segfault)           ./

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 cache.h               |   2 +-
 path.c                | 112 +++++++++++++++++++++++++++++++++++++++-----------
 setup.c               |   5 ++-
 t/t0060-path-utils.sh |  27 ++++++------
 test-path-utils.c     |   4 +-
 5 files changed, 107 insertions(+), 43 deletions(-)

diff --git a/cache.h b/cache.h
index 94ca1..4016c 100644
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
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 2199b..dfe47 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -191,22 +191,19 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 relative_path /a/b/c/	/a/b/		c/
 relative_path /a/b/c/	/a/b		c/
 relative_path /a//b//c/	//a/b//		c/
-relative_path /a/b	/a/b		.
-relative_path /a/b/	/a/b		.
-relative_path /a	/a/b		/a
-relative_path /		/a/b/		/
-relative_path /a/c	/a/b/		/a/c
-relative_path /a/c	/a/b		/a/c
+relative_path /a/b	/a/b		./
+relative_path /a/b/	/a/b		./
+relative_path /a	/a/b		../
+relative_path /		/a/b/		../../
+relative_path /a/c	/a/b/		../c
+relative_path /a/c	/a/b		../c
 relative_path /a/b	"<empty>"	/a/b
 relative_path /a/b 	"<null>"	/a/b
-relative_path "<empty>"	/a/b		"(empty)"
-relative_path "<empty>"	"<empty>"	"(empty)"
-relative_path "<empty>"	"<null>"	"(empty)"
-relative_path "<null>"	"<empty>"	"(null)"
-relative_path "<null>"	"<null>"	"(null)"
-
-test_expect_failure 'relative path: <null> /a/b => segfault' '
-	test-path-utils relative_path "<null>" "/a/b"
-'
+relative_path "<empty>"	/a/b		./
+relative_path "<empty>"	"<empty>"	./
+relative_path "<empty>"	"<null>"	./
+relative_path "<null>"	"<empty>"	./
+relative_path "<null>"	"<null>"	./
+relative_path "<null>"	/a/b		./
 
 test_done
diff --git a/test-path-utils.c b/test-path-utils.c
index 18267..bc4ad 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -117,14 +117,16 @@ int main(int argc, char **argv)
 	}
 
 	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
+		struct strbuf sb = STRBUF_INIT;
 		const char *abs, *base, *rel;
 		PARSE_ARGV_STRING(abs, argv[2]);
 		PARSE_ARGV_STRING(base, argv[3]);
-		rel = relative_path(abs, base);
+		rel = relative_path(abs, base, &sb);
 		if (!rel)
 			puts("(null)");
 		else
 			puts(strlen(rel) > 0 ? rel : "(empty)");
+		strbuf_release(&sb);
 		return 0;
 	}
 
-- 
1.8.3.rc2.26.g7472058
