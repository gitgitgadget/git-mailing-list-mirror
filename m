From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 02/10] parse_pathspec: make sure the prefix part is wildcard-free
Date: Sun, 13 Jan 2013 19:49:31 +0700
Message-ID: <1358081379-17752-3-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:50:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN0n-0000nf-OY
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab3AMMtm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:49:42 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:50233 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab3AMMtk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:49:40 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1416938dak.6
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=JK1IexTc06eoT4PeK9P3RiB/jawlqU4olyB0gntXUhc=;
        b=mS5NMnRdLFVTxa12Bdq3loLPKG22nsEscqPUNV2kO4XzL0s4X69XlJ3E6uTSzJp+FG
         dcXLcHQHS8+jU/tUG3prRnzRlIGdAylaFd2qXn/BerNwg+9rOvtrvhPiurGPD0YDPIfS
         rD2sHKACVm0OCin1ojaqRQNZA7i3JQmeHcOHKPpUoGGtEK4BFmkdagVhqy5i9+O5vseU
         R8YIDEwdOogziOrK/QtxNYRU8jwr9n6QBOKRF5G7ABDk31JXCNcSOrb8LyNwWNWsww0x
         UhFeXXRRraHwKcPSfIKt8qPCkZTamN2okD2y9VVUUlsc2Hqpi8PAILNPxaBzactA+AD8
         2ygg==
X-Received: by 10.66.85.74 with SMTP id f10mr223058412paz.38.1358081380387;
        Sun, 13 Jan 2013 04:49:40 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id bi8sm6774055pab.15.2013.01.13.04.49.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:49:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:49:54 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213374>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h                    |  1 +
 path.c                     | 15 ++++++++++++++-
 setup.c                    | 24 +++++++++++++++--------
 t/t6131-pathspec-prefix.sh | 47 ++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 78 insertions(+), 9 deletions(-)
 create mode 100755 t/t6131-pathspec-prefix.sh

diff --git a/cache.h b/cache.h
index c7a8d28..f3de28d 100644
--- a/cache.h
+++ b/cache.h
@@ -747,6 +747,7 @@ const char *real_path(const char *path);
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
index d3d3f8b..7baf334 100644
--- a/path.c
+++ b/path.c
@@ -487,8 +487,14 @@ const char *relative_path(const char *abs, const c=
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
@@ -563,11 +569,18 @@ int normalize_path_copy(char *dst, const char *sr=
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
diff --git a/setup.c b/setup.c
index 9db6093..c5e97c9 100644
--- a/setup.c
+++ b/setup.c
@@ -5,10 +5,11 @@
 static int inside_git_dir =3D -1;
 static int inside_work_tree =3D -1;
=20
-static char *prefix_path_gently(const char *prefix, int len, const cha=
r *path)
+static char *prefix_path_gently(const char *prefix, int *p_len, const =
char *path)
 {
 	const char *orig =3D path;
 	char *sanitized;
+	int len =3D *p_len;
 	if (is_absolute_path(orig)) {
 		const char *temp =3D real_path(path);
 		sanitized =3D xmalloc(len + strlen(temp) + 1);
@@ -19,7 +20,7 @@ static char *prefix_path_gently(const char *prefix, i=
nt len, const char *path)
 			memcpy(sanitized, prefix, len);
 		strcpy(sanitized + len, path);
 	}
-	if (normalize_path_copy(sanitized, sanitized))
+	if (normalize_path_copy_len(sanitized, sanitized, p_len))
 		goto error_out;
 	if (is_absolute_path(orig)) {
 		size_t root_len, len, total;
@@ -44,7 +45,7 @@ static char *prefix_path_gently(const char *prefix, i=
nt len, const char *path)
=20
 char *prefix_path(const char *prefix, int len, const char *path)
 {
-	char *r =3D prefix_path_gently(prefix, len, path);
+	char *r =3D prefix_path_gently(prefix, &len, path);
 	if (!r)
 		die("'%s' is outside repository", path);
 	return r;
@@ -53,7 +54,7 @@ char *prefix_path(const char *prefix, int len, const =
char *path)
 int path_inside_repo(const char *prefix, const char *path)
 {
 	int len =3D prefix ? strlen(prefix) : 0;
-	char *r =3D prefix_path_gently(prefix, len, path);
+	char *r =3D prefix_path_gently(prefix, &len, path);
 	if (r) {
 		free(r);
 		return 1;
@@ -261,10 +262,14 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
 			copyfrom++;
 	}
=20
-	if (magic & PATHSPEC_FROMTOP)
+	if (magic & PATHSPEC_FROMTOP) {
 		match =3D xstrdup(copyfrom);
-	else
-		match =3D prefix_path(prefix, prefixlen, copyfrom);
+		prefixlen =3D 0;
+	} else {
+		match =3D prefix_path_gently(prefix, &prefixlen, copyfrom);
+		if (!match)
+			die("%s: '%s' is outside repository", elt, copyfrom);
+	}
 	*raw =3D item->match =3D match;
 	item->original =3D elt;
 	item->len =3D strlen(item->match);
@@ -300,8 +305,11 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	item->flags =3D 0;
 	if (limit_pathspec_to_literal())
 		item->nowildcard_len =3D item->len;
-	else
+	else {
 		item->nowildcard_len =3D simple_length(item->match);
+		if (item->nowildcard_len < prefixlen)
+			item->nowildcard_len =3D prefixlen;
+	}
 	if (item->nowildcard_len < item->len &&
 	    item->match[item->nowildcard_len] =3D=3D '*' &&
 	    no_wildcard(item->match + item->nowildcard_len + 1))
diff --git a/t/t6131-pathspec-prefix.sh b/t/t6131-pathspec-prefix.sh
new file mode 100755
index 0000000..db59091
--- /dev/null
+++ b/t/t6131-pathspec-prefix.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description=3D'Verify the exact matching of prefix part in pathsp=
ec'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir a\* ab &&
+	: >a\*/foo &&
+	: >ab/foo &&
+	git add .
+'
+
+test_expect_success 'prefix has wildcards but treated as literal' '
+	(
+		cd a\* &&
+		git ls-files --cached foo
+	) >actual &&
+	echo foo >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'prefix is reduced to empty' '
+	(
+		cd a\* &&
+		git ls-files --cached ../a\*/foo
+	) >actual &&
+	cat <<\EOF >expected &&
+foo
+../ab/foo
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'prefix is reduced to empty (2)' '
+	(
+		cd a\* &&
+		git ls-files --cached non-existing//../fancy/.//../../a\*/foo
+	) >actual &&
+	cat <<\EOF >expected &&
+foo
+../ab/foo
+EOF
+	test_cmp expected actual
+'
+
+test_done
--=20
1.8.0.rc2.23.g1fb49df
