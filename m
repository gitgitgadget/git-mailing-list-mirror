From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 39/45] parse_pathspec: make sure the prefix part is wildcard-free
Date: Wed, 20 Mar 2013 19:16:19 +0700
Message-ID: <1363781779-14947-7-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 13:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHxa-0003aq-C2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941Ab3CTMRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 08:17:10 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:59356 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933759Ab3CTMRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:17:09 -0400
Received: by mail-da0-f52.google.com with SMTP id f10so961249dak.39
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=VKtm5vt6PIs2SwWFJyuHl3/dMRxp8dCl18U9IVRcKYY=;
        b=PEGKkiB5gSZgCGW145yPeTW+wjIsWq1oyeo+N34yRRwCuP88WBvgYq6eA5pIr7bLqV
         ecp8ts7/ggg7smyvNDgojt3QVf0DlPQdml5gED4qQnJ/UJajCbaLKkiCY3YAOLIN/f++
         kjK8XMvDD6byKVvF9xQZEk1JNd5GcyVTlN1BY+D2CRH3CfIs+3AZmahOKwBUjwwyBn/h
         fjtaWEUJPKc5bifP8Q6EruST44eTvc7Sjiof/KcytR+SrfhIjFZ2M1nnexxER/IEPCnx
         567CsJxT/M5+IJYaw9/Qbla1RnThIfZdYWLB753kK3hy2IALodOaDZW0buwl0wWQfTHk
         TQOA==
X-Received: by 10.69.1.101 with SMTP id bf5mr8388845pbd.208.1363781828361;
        Wed, 20 Mar 2013 05:17:08 -0700 (PDT)
Received: from lanh ([115.74.40.216])
        by mx.google.com with ESMTPS id f4sm1954173pbc.6.2013.03.20.05.17.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:17:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Mar 2013 19:16:59 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218594>

Prepending prefix to pathspec is a trick to workaround the fact that
commands can be executed in a subdirectory, but all git commands run
at worktree's root. The prefix part should always be treated as
literal string. Make it so.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h    |  2 ++
 path.c     | 15 ++++++++++++++-
 pathspec.c | 17 +++++++++++++----
 pathspec.h |  2 +-
 setup.c    |  9 +++++----
 5 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 6297783..17e0b26 100644
--- a/cache.h
+++ b/cache.h
@@ -401,6 +401,7 @@ extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path=
);
+extern char *prefix_path_gently(const char *prefix, int *p_len, const =
char *path);
 extern const char *prefix_filename(const char *prefix, int len, const =
char *path);
 extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix,
@@ -712,6 +713,7 @@ const char *real_path(const char *path);
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
diff --git a/pathspec.c b/pathspec.c
index 9cd3f2c..01f8844 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -149,10 +149,14 @@ static unsigned prefix_pathspec(struct pathspec_i=
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
+		match =3D prefix_path_gently(prefix, &prefixlen, copyfrom);
+		if (!match)
+			die("%s: '%s' is outside repository", elt, copyfrom);
+	}
 	*raw =3D item->match =3D match;
 	/*
 	 * Prefix the pathspec (keep all magic) and put to
@@ -166,6 +170,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	} else
 		item->original =3D elt;
 	item->len =3D strlen(item->match);
+	item->prefix =3D prefixlen;
=20
 	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
 	    (item->len >=3D 1 && item->match[item->len - 1] =3D=3D '/') &&
@@ -197,8 +202,11 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
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
@@ -283,6 +291,7 @@ void parse_pathspec(struct pathspec *pathspec,
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
index acdc634..e661a71 100644
--- a/setup.c
+++ b/setup.c
@@ -5,10 +5,11 @@
 static int inside_git_dir =3D -1;
 static int inside_work_tree =3D -1;
=20
-static char *prefix_path_gently(const char *prefix, int len, const cha=
r *path)
+char *prefix_path_gently(const char *prefix, int *p_len, const char *p=
ath)
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
--=20
1.8.0.rc0.19.g7bbb31d
