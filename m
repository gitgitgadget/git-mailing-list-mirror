From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 39/45] parse_pathspec: make sure the prefix part is wildcard-free
Date: Sun,  9 Jun 2013 13:26:12 +0700
Message-ID: <1370759178-1709-40-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ7g-0001oh-E5
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab3FIG3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:29:00 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:46070 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab3FIG27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:28:59 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so2004136pbc.29
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=c9VyLeQ1OhsAbaAyYB8amxHAvi1TQOYmx/4uhKnUdRo=;
        b=hnhsyaTcYMlCGjc0VQ2exQfTlk8Ua7h5PbgtR7gY8zXS5/kTK5LvxD5Xvhr2CleLGn
         S5CRCp5UDXK2W61E4BvSFbWUsNGFm1p5utfIznJ2eY9sh9JOZ+GHlIa4anoz30raJT++
         zyifMfcdcYU8qod9BOPWmGSJ+BqvBHrR9DtebwAWvcQrGO2jPVySJP6OuTDcqSgpwcUV
         5lso+uKbdowpPMSh6C+gOji0vON1H4hdHI3Alf89axshoLNYdTQr+1TywiefErNxD/Aq
         ZT2SHeQRqc1S1tKya+X0egjVCYpJRa71Ix8gDZXEMnhXUnf00Nw5q9AHnpiACy0mOpF3
         ArXA==
X-Received: by 10.66.159.168 with SMTP id xd8mr9081146pab.146.1370759339112;
        Sat, 08 Jun 2013 23:28:59 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id do4sm5556505pbc.8.2013.06.08.23.28.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:28:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:30:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226931>

Prepending prefix to pathspec is a trick to workaround the fact that
commands can be executed in a subdirectory, but all git commands run
at worktree's root. The prefix part should always be treated as
literal string. Make it so.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h    |  2 ++
 path.c     | 15 ++++++++++++++-
 pathspec.c | 21 +++++++++++++++++----
 pathspec.h |  2 +-
 setup.c    | 24 ++++++++++++++++++++----
 5 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index b3d8b29..276330e 100644
--- a/cache.h
+++ b/cache.h
@@ -408,6 +408,7 @@ extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path=
);
+extern char *prefix_path_gently(const char *prefix, int len, int *rema=
ining, const char *path);
 extern const char *prefix_filename(const char *prefix, int len, const =
char *path);
 extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix,
@@ -720,6 +721,7 @@ const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 const char *absolute_path(const char *path);
 const char *relative_path(const char *abs, const char *base);
+int normalize_path_copy_len(char *dst, const char *src, int *prefix_le=
n);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, struct string_list *pref=
ixes);
 char *strip_path_suffix(const char *path, const char *suffix);
diff --git a/path.c b/path.c
index 04ff148..f4b49d6 100644
--- a/path.c
+++ b/path.c
@@ -492,8 +492,14 @@ const char *relative_path(const char *abs, const c=
har *base)
  *
  * Note that this function is purely textual.  It does not follow syml=
inks,
  * verify the existence of the path, or make any system calls.
+ *
+ * prefix_len !=3D NULL is for a specific case of prefix_pathspec():
+ * assume that src =3D=3D dst and src[0..prefix_len-1] is already
+ * normalized, any time "../" eats up to the prefix_len part,
+ * prefix_len is reduced. In the end prefix_len is the remaining
+ * prefix that has not been overridden by user pathspec.
  */
-int normalize_path_copy(char *dst, const char *src)
+int normalize_path_copy_len(char *dst, const char *src, int *prefix_le=
n)
 {
 	char *dst0;
=20
@@ -568,11 +574,18 @@ int normalize_path_copy(char *dst, const char *sr=
c)
 		/* Windows: dst[-1] cannot be backslash anymore */
 		while (dst0 < dst && dst[-1] !=3D '/')
 			dst--;
+		if (prefix_len && *prefix_len > dst - dst0)
+			*prefix_len =3D dst - dst0;
 	}
 	*dst =3D '\0';
 	return 0;
 }
=20
+int normalize_path_copy(char *dst, const char *src)
+{
+	return normalize_path_copy_len(dst, src, NULL);
+}
+
 /*
  * path =3D Canonical absolute path
  * prefixes =3D string_list containing normalized, absolute paths with=
out
diff --git a/pathspec.c b/pathspec.c
index 17f25d6..e2ee268 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -150,10 +150,14 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
 	magic |=3D short_magic;
 	*p_short_magic =3D short_magic;
=20
-	if (magic & PATHSPEC_FROMTOP)
+	if (magic & PATHSPEC_FROMTOP) {
 		match =3D xstrdup(copyfrom);
-	else
-		match =3D prefix_path(prefix, prefixlen, copyfrom);
+		prefixlen =3D 0;
+	} else {
+		match =3D prefix_path_gently(prefix, prefixlen, &prefixlen, copyfrom=
);
+		if (!match)
+			die(_("%s: '%s' is outside repository"), elt, copyfrom);
+	}
 	*raw =3D item->match =3D match;
 	/*
 	 * Prefix the pathspec (keep all magic) and put to
@@ -167,6 +171,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	} else
 		item->original =3D elt;
 	item->len =3D strlen(item->match);
+	item->prefix =3D prefixlen;
=20
 	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
 	    (item->len >=3D 1 && item->match[item->len - 1] =3D=3D '/') &&
@@ -198,13 +203,20 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
=20
 	if (limit_pathspec_to_literal())
 		item->nowildcard_len =3D item->len;
-	else
+	else {
 		item->nowildcard_len =3D simple_length(item->match);
+		if (item->nowildcard_len < prefixlen)
+			item->nowildcard_len =3D prefixlen;
+	}
 	item->flags =3D 0;
 	if (item->nowildcard_len < item->len &&
 	    item->match[item->nowildcard_len] =3D=3D '*' &&
 	    no_wildcard(item->match + item->nowildcard_len + 1))
 		item->flags |=3D PATHSPEC_ONESTAR;
+
+	/* sanity checks, pathspec matchers assume these are sane */
+	assert(item->nowildcard_len <=3D item->len &&
+	       item->prefix         <=3D item->len);
 	return magic;
 }
=20
@@ -284,6 +296,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		item->match =3D prefix;
 		item->original =3D prefix;
 		item->nowildcard_len =3D item->len =3D strlen(prefix);
+		item->prefix =3D item->len;
 		raw[0] =3D prefix;
 		raw[1] =3D NULL;
 		pathspec->nr =3D 1;
diff --git a/pathspec.h b/pathspec.h
index 16bbb7b..bbcfa74 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -21,7 +21,7 @@ struct pathspec {
 		const char *match;
 		const char *original;
 		unsigned magic;
-		int len;
+		int len, prefix;
 		int nowildcard_len;
 		int flags;
 	} *items;
diff --git a/setup.c b/setup.c
index d1ece5d..ff4499e 100644
--- a/setup.c
+++ b/setup.c
@@ -5,7 +5,19 @@
 static int inside_git_dir =3D -1;
 static int inside_work_tree =3D -1;
=20
-static char *prefix_path_gently(const char *prefix, int len, const cha=
r *path)
+/*
+ * Normalize "path", prepending the "prefix" for relative paths. If
+ * remaining_prefix is not NULL, return the actual prefix still
+ * remains in the path. For example, prefix =3D sub1/sub2/ and path is
+ *
+ *  foo          -> sub1/sub2/foo  (full prefix)
+ *  ../foo       -> sub1/foo       (remaining prefix is sub1/)
+ *  ../../bar    -> bar            (no remaining prefix)
+ *  ../../sub1/sub2/foo -> sub1/sub2/foo (but no remaining prefix)
+ *  `pwd`/../bar -> sub1/bar       (no remaining prefix)
+ */
+char *prefix_path_gently(const char *prefix, int len,
+			 int *remaining_prefix, const char *path)
 {
 	const char *orig =3D path;
 	char *sanitized;
@@ -13,13 +25,17 @@ static char *prefix_path_gently(const char *prefix,=
 int len, const char *path)
 		const char *temp =3D real_path(path);
 		sanitized =3D xmalloc(len + strlen(temp) + 1);
 		strcpy(sanitized, temp);
+		if (remaining_prefix)
+			*remaining_prefix =3D 0;
 	} else {
 		sanitized =3D xmalloc(len + strlen(path) + 1);
 		if (len)
 			memcpy(sanitized, prefix, len);
 		strcpy(sanitized + len, path);
+		if (remaining_prefix)
+			*remaining_prefix =3D len;
 	}
-	if (normalize_path_copy(sanitized, sanitized))
+	if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix))
 		goto error_out;
 	if (is_absolute_path(orig)) {
 		size_t root_len, len, total;
@@ -44,7 +60,7 @@ static char *prefix_path_gently(const char *prefix, i=
nt len, const char *path)
=20
 char *prefix_path(const char *prefix, int len, const char *path)
 {
-	char *r =3D prefix_path_gently(prefix, len, path);
+	char *r =3D prefix_path_gently(prefix, len, NULL, path);
 	if (!r)
 		die("'%s' is outside repository", path);
 	return r;
@@ -53,7 +69,7 @@ char *prefix_path(const char *prefix, int len, const =
char *path)
 int path_inside_repo(const char *prefix, const char *path)
 {
 	int len =3D prefix ? strlen(prefix) : 0;
-	char *r =3D prefix_path_gently(prefix, len, path);
+	char *r =3D prefix_path_gently(prefix, len, NULL, path);
 	if (r) {
 		free(r);
 		return 1;
--=20
1.8.2.83.gc99314b
