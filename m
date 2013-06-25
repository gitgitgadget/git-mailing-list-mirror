From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v15 02/16] path.c: refactor relative_path(), not only strip prefix
Date: Tue, 25 Jun 2013 23:53:43 +0800
Message-ID: <31fc3821962b83e79cd8f59127c8c11ba1551073.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:54:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVZj-0003q3-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab3FYPyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:54:22 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60703 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3FYPyT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:54:19 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so12835691pbc.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=MZAcoVNL1R8erLuJEti1+PukuRqJ121EKJ3tzcXVw5M=;
        b=z3NZe6oSuuC+IISpBkjHJUqbGjNjuVGvHhzy3J9tlgaOaOXNJR7q/0+1fcFSZ/SdSN
         Tm6f+0lXLJ61C3PS23VcNoMGV8O8K7IzlykczzBV3LqHMBY6KSaOlbHvyo85ABbMJET6
         a3FBzxw0sslGPHh11mJ0Esq1UGHH9o4nO0a+DbJ1SEGc38jS1xWSGYJACTZHJ3/jS76H
         8EhEaDoyoTvNQ09vwU5LNcfsEoNZWa9zjbzYW0Zzcwjckp5ykpBI+mpJHnQGYE2E77Pu
         a4iCbEj6mk4doFPfrZnkAL2OlrsoBLl7rIc2UrLBwSGPF9lW0oWL6HBznRBkRDWp6C+a
         H0MA==
X-Received: by 10.66.221.2 with SMTP id qa2mr359277pac.188.1372175658682;
        Tue, 25 Jun 2013 08:54:18 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id pb5sm23760930pbc.29.2013.06.25.08.54.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:54:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g2e9b71f
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228963>

Original design of relative_path() is simple, just strip the prefix
(*base) from the absolute path (*abs). In most cases, we need a real
relative path, such as: ../foo, ../../bar. That's why there is another
reimplementation (path_relative()) in quote.c.

Borrowed some codes from path_relative() in quote.c to refactor
relative_path() in path.c, so that it could return real relative path,
and user can reuse this function without reimplement his/her own.
The function path_relative() in quote.c will be substituted, and I
would use the new relative_path() function when implement the
interactive git-clean later.

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
    /x/y      /a/b/      /x/y                 ../../x/y
    /a/b      (empty)    /a/b                 /a/b
    /a/b      (null)     /a/b                 /a/b

    a/b/c/    a/b/       c/                   c/
    a/b/c/    a/b        c/                   c/
    a/b//c    a//b       c                    c
    a/b/      a/b/       .                    ./
    a/b/      a/b        .                    ./
    a         a/b        a                    ../
    x/y       a/b/       x/y                  ../../x/y
    a/c       a/b        a/c                  ../c
    a/b       (empty)    a/b                  a/b
    a/b       (null)     a/b                  a/b

    (empty)   (null)     (empty)              ./
    (empty)   (empty)    (empty)              ./
    (empty)   /a/b       (empty)              ./
    (null)    (null)     (null)               ./
    (null)    (empty)    (null)               ./
    (null)    /a/b       (segfault)           ./

You may notice that return value "." has been changed to "./".
It is because:

 * Function quote_path_relative() in quote.c will show the relative
   path as "./" if abs(in) and base(prefix) are the same.

 * Function relative_path() is called only once (in setup.c), and
   it will be OK for the return value as "./" instead of ".".

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h               |   2 +-
 path.c                | 116 +++++++++++++++++++++++++++++++++++++-------------
 setup.c               |   5 ++-
 t/t0060-path-utils.sh |  39 ++++++++---------
 test-path-utils.c     |   4 +-
 5 files changed, 113 insertions(+), 53 deletions(-)

diff --git a/cache.h b/cache.h
index dd0fb..c2886 100644
--- a/cache.h
+++ b/cache.h
@@ -758,7 +758,7 @@ int is_directory(const char *);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 const char *absolute_path(const char *path);
-const char *relative_path(const char *abs, const char *base);
+const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, struct string_list *prefixes);
 char *strip_path_suffix(const char *path, const char *suffix);
diff --git a/path.c b/path.c
index 04ff..fbe52c9b 100644
--- a/path.c
+++ b/path.c
@@ -441,42 +441,100 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
-const char *relative_path(const char *abs, const char *base)
+/*
+ * Give path as relative to prefix.
+ *
+ * The strbuf may or may not be used, so do not assume it contains the
+ * returned path.
+ */
+const char *relative_path(const char *in, const char *prefix,
+			  struct strbuf *sb)
 {
-	static char buf[PATH_MAX + 1];
-	int i = 0, j = 0;
-
-	if (!base || !base[0])
-		return abs;
-	while (base[i]) {
-		if (is_dir_sep(base[i])) {
-			if (!is_dir_sep(abs[j]))
-				return abs;
-			while (is_dir_sep(base[i]))
+	int in_len = in ? strlen(in) : 0;
+	int prefix_len = prefix ? strlen(prefix) : 0;
+	int in_off = 0;
+	int prefix_off = 0;
+	int i = 0,j = 0;
+
+	if (!in_len)
+		return "./";
+	else if (!prefix_len)
+		return in;
+
+	while (i < prefix_len && j < in_len && prefix[i] == in[j]) {
+		if (is_dir_sep(prefix[i])) {
+			while (is_dir_sep(prefix[i]))
 				i++;
-			while (is_dir_sep(abs[j]))
+			while (is_dir_sep(in[j]))
 				j++;
+			prefix_off = i;
+			in_off = j;
+		} else {
+			i++;
+			j++;
+		}
+	}
+
+	if (
+	    /* "prefix" seems like prefix of "in" */
+	    i >= prefix_len &&
+	    /*
+	     * but "/foo" is not a prefix of "/foobar"
+	     * (i.e. prefix not end with '/')
+	     */
+	    prefix_off < prefix_len) {
+		if (j >= in_len) {
+			/* in="/a/b", prefix="/a/b" */
+			in_off = in_len;
+		} else if (is_dir_sep(in[j])) {
+			/* in="/a/b/c", prefix="/a/b" */
+			while (is_dir_sep(in[j]))
+				j++;
+			in_off = j;
+		} else {
+			/* in="/a/bbb/c", prefix="/a/b" */
+			i = prefix_off;
+		}
+	} else if (
+		   /* "in" is short than "prefix" */
+		   j >= in_len &&
+		   /* "in" not end with '/' */
+		   in_off < in_len) {
+		if (is_dir_sep(prefix[i])) {
+			/* in="/a/b", prefix="/a/b/c/" */
+			while (is_dir_sep(prefix[i]))
+				i++;
+			in_off = in_len;
+		}
+	}
+	in += in_off;
+	in_len -= in_off;
+
+	if (i >= prefix_len) {
+		if (!in_len)
+			return "./";
+		else
+			return in;
+	}
+
+	strbuf_reset(sb);
+	strbuf_grow(sb, in_len);
+
+	while (i < prefix_len) {
+		if (is_dir_sep(prefix[i])) {
+			strbuf_addstr(sb, "../");
+			while (is_dir_sep(prefix[i]))
+				i++;
 			continue;
-		} else if (abs[j] != base[i]) {
-			return abs;
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
+	if (!is_dir_sep(prefix[prefix_len - 1]))
+		strbuf_addstr(sb, "../");
+
+	strbuf_addstr(sb, in);
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
index 72e89..76c779 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -191,33 +191,30 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 relative_path /a/b/c/	/a/b/		c/
 relative_path /a/b/c/	/a/b		c/
 relative_path /a//b//c/	//a/b//		c/	POSIX
-relative_path /a/b	/a/b		.
-relative_path /a/b/	/a/b		.
-relative_path /a	/a/b		/a	POSIX
-relative_path /		/a/b/		/	POSIX
-relative_path /a/c	/a/b/		/a/c	POSIX
-relative_path /a/c	/a/b		/a/c	POSIX
-relative_path /x/y	/a/b/		/x/y	POSIX
+relative_path /a/b	/a/b		./
+relative_path /a/b/	/a/b		./
+relative_path /a	/a/b		../
+relative_path /		/a/b/		../../
+relative_path /a/c	/a/b/		../c
+relative_path /a/c	/a/b		../c
+relative_path /x/y	/a/b/		../../x/y
 relative_path /a/b	"<empty>"	/a/b	POSIX
 relative_path /a/b 	"<null>"	/a/b	POSIX
 relative_path a/b/c/	a/b/		c/
 relative_path a/b/c/	a/b		c/
 relative_path a/b//c	a//b		c
-relative_path a/b/	a/b/		.
-relative_path a/b/	a/b		.
-relative_path a		a/b		a	# TODO: should be: ..
-relative_path x/y	a/b		x/y	# TODO: should be: ../../x/y
-relative_path a/c	a/b		a/c	# TODO: should be: ../c
+relative_path a/b/	a/b/		./
+relative_path a/b/	a/b		./
+relative_path a		a/b		../
+relative_path x/y	a/b		../../x/y
+relative_path a/c	a/b		../c
 relative_path a/b	"<empty>"	a/b
 relative_path a/b 	"<null>"	a/b
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
index 8a6d2..1bf473 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -117,14 +117,16 @@ int main(int argc, char **argv)
 	}
 
 	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
+		struct strbuf sb = STRBUF_INIT;
 		const char *in, *prefix, *rel;
 		normalize_argv_string(&in, argv[2]);
 		normalize_argv_string(&prefix, argv[3]);
-		rel = relative_path(in, prefix);
+		rel = relative_path(in, prefix, &sb);
 		if (!rel)
 			puts("(null)");
 		else
 			puts(strlen(rel) > 0 ? rel : "(empty)");
+		strbuf_release(&sb);
 		return 0;
 	}
 
-- 
1.8.3.1.756.g2e9b71f
