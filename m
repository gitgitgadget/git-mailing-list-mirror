From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v13 02/15] path.c: refactor relative_path(), not only strip prefix
Date: Thu, 30 May 2013 14:56:36 +0800
Message-ID: <1ef36bab8e64a5fd55e431213fe88662ac35f36d.1369896222.git.worldhello.net@gmail.com>
References: <CANYiYbGiAdMtOwdAf1cgV74cJjaM1dABTE6LEe+LAWoEaUBSXw@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 08:57:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhwnE-0000xU-8B
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 08:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967663Ab3E3G44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 02:56:56 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:54693 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967623Ab3E3G4z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 02:56:55 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so10018018pdj.29
        for <git@vger.kernel.org>; Wed, 29 May 2013 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UrLqvDAql3zcPYbcUsgZylBtNk34WPTro3mRsG8TsCA=;
        b=wCwUh9G7ptRH8u4Mvwklc/FG6MigF/e1JW7l3k2KLx8qzg6do31d2pzqz/ggOjgcut
         YXx/YZGnlUh81fo9Klq0v2aumxGoE+tK3uyFEbS4DLiuI3sgxEoGlUys02nsSuxV4j6K
         JDhhG3u8xJq23zyTrLt8kjQ7wTjn6u7M0UxBxzpgXB6cl2W2QS43DAPLCtUnSYDZEQgt
         6rZKHzC6xW1kMEylOLFRV4zLNsC64EainVlYDoS/dVjrIi3oqQreSW7UDkixUb8CxuFC
         g8KAqvXkmHJhjS06VDqIbc5eFT9LeMwg5r882vauHFnvQ4nuHmWI84+01hVJUdFiGNvp
         moeg==
X-Received: by 10.66.26.52 with SMTP id i20mr6860847pag.209.1369897014171;
        Wed, 29 May 2013 23:56:54 -0700 (PDT)
Received: from localhost.localdomain ([114.248.151.127])
        by mx.google.com with ESMTPSA id l4sm40658791pbo.6.2013.05.29.23.56.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 23:56:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.368.g7c798dd
In-Reply-To: <CANYiYbGiAdMtOwdAf1cgV74cJjaM1dABTE6LEe+LAWoEaUBSXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225934>

2013/5/26 Jiang Xin <worldhello.net@gmail.com>:
> 2013/5/22 Michael Haggerty <mhagger@alum.mit.edu>:
>
>> The old and new versions both seem to be (differently) inconsistent
>> about when the output has a trailing slash.  What is the rule?
>
> The reason for introducing patch 02/15 is that we don't want to reinvent
> the wheel. Patch 06/15 (git-clean: refactor git-clean into two phases)
> needs to save relative_path of each git-clean candidate file/directory in
> del_list, but the public method in path.c (i.e. relative_path) is not
> powerful, and static method in quote.c (i.e. path_relative) can note be
> used directly. One way is to enhanced relative_path in path.c, like this
> patch.
>
> Since we combine the two methods (relative_path in path.c and
> path_relative in quote.c), the new relative_path must be compatible
> with the original two methods.
>
> relative_path in path.c
> =======================
>
> relative_path is called only once in setup.c:
>
>         if (getenv(GIT_WORK_TREE_ENVIRONMENT))
>                 setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
>
>         set_git_dir(relative_path(git_dir, work_tree));
>         initialized = 1;
>
> and set_git_dir only set the environment GIT_DIR_ENVIRONMENT
> like this:
>
>         int set_git_dir(const char *path)
>         {
>                 if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
>                         return error("Could not set GIT_DIR to '%s'", path);
>                 setup_git_env();
>                 return 0;
>         }
>
> So the only restriction for relative_path is that the return value can
> not be blank. If the abs and base arguments for relative_path are
> the same, the return value should be "." ("./" is also OK), then
> set the envionment GIT_DIR_ENVIRONMENT to "." (or "./").
>
> path_relative in quote.c
> ========================
>
> We can not simply move "path_relative" in quote.c to "relative_path"
> in path.c directly. It is because:
>
> * The arguments for "relative_path" are from user input. So must
>    validate (remove duplicate slash) before use. But "path_relative"
>    does not check duplicate slash in arguments.
>
> * "path_relative" will return blank string, if abs and base are the same.
>
> Also I noticed that "quote_path_relative" of quote.c (which calls
> path_relative) will transform the blank string from path_relative to
> "./" (not ".")
>
>         char *quote_path_relative(const char *in, int len,
>         ...
>                 const char *rel = path_relative(in, len, &sb, prefix, -1);
>                 ...
>                 if (!out->len)
>                         strbuf_addstr(out, "./");
>
> That's why the "path_relative" in path.c refactor the output of "." into "./".
>
Hi, Junio

I have updated comment and commit log in this patch. You can substitute
commit bd4d1 (path.c: refactor relative_path(), not only strip prefix)
in jx/clean-interactive branch with this one.

-- 8< --
Subject: [PATCH] path.c: refactor relative_path(), not only strip prefix

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
    /a/b      (empty)    /a/b                 /a/b
    /a/b      (null)     /a/b                 /a/b
    (empty)   /a/b       (empty)              ./
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
index 04ff..8ff16 100644
--- a/path.c
+++ b/path.c
@@ -441,42 +441,104 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
-const char *relative_path(const char *abs, const char *base)
+/*
+ * Give relative path for abs to base.
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
+	abs_len = abs ? strlen(abs) : 0;
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
index dcc530..95ef4 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -117,14 +117,16 @@ int main(int argc, char **argv)
 	}
 
 	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
+		struct strbuf sb = STRBUF_INIT;
 		const char *abs, *base, *rel;
 		normalize_argv_string(&abs, argv[2]);
 		normalize_argv_string(&base, argv[3]);
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
1.8.3.rc3.368.g7c798dd
