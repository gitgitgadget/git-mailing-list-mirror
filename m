From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/31] Add parse_pathspec() that converts cmdline args to struct pathspec
Date: Sun, 13 Jan 2013 19:35:11 +0700
Message-ID: <1358080539-17436-4-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMnJ-0005kp-PN
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab3AMMft convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:35:49 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:46628 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979Ab3AMMft (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:35:49 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so1413749dan.37
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=GU9Cjfsfepf9GeEBgtZ68fydOijRJXWParewsv/NjYI=;
        b=Kfoo6qJHe5r52XlhnnoOtUGfFTcXwxxc+nLFAeBehXx9AD+QIBCAT02gYVOnkTH+/r
         sPqyBGlHWS1gaBsrhIY3zJEndSpMd1NjoqODt4Vk4S+LwsyLaCz5lAiwqwIdCYl858uf
         Uq8ZHr29y2xyh8dzHyFGkb0s7DOXYstHbr8+QvZR9Yn529GBbucS1gLoQJJ+z6s1ki5s
         Zz81Yoiji8CADnPyJanTbGNA+zN13YHN2pnJjAnnYm4uwBnSV9rLWskXPTWk5kGkLJYH
         7JX0fouufRQj6ggA77TkN6jfyMc0od22JEr9buswXIJtJHBOq9JcH7xBv1k3lwMVvjVR
         48mQ==
X-Received: by 10.66.76.97 with SMTP id j1mr4319918paw.70.1358080548595;
        Sun, 13 Jan 2013 04:35:48 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id ov4sm6286797pbb.45.2013.01.13.04.35.45
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:35:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:36:01 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213343>

Currently to fill a struct pathspec, we do:

   const char **paths;
   paths =3D get_pathspec(prefix, argv);
   ...
   init_pathspec(&pathspec, paths);

"paths" can only carry bare strings, which loses information from
command line arguments such as pathspec magic or the prefix part's
length for each argument.

parse_pathspec() is introduced to combine the two calls into one. The
plan is gradually replace all get_pathspec() and init_pathspec() with
parse_pathspec(). get_pathspec() now becomes a thin wrapper of
parse_pathspec().

parse_pathspec() allows the caller to reject the pathspec magics that
it does not support. When a new pathspec magic is introduced, we can
enable it per command after making sure that all underlying code has no
problem with the new magic.

"flags" parameter is currently unused. But it would allow callers to
pass certain instructions to parse_pathspec, for example forcing
literal pathspec when no magic is used.

With the introduction of parse_pathspec, there are now two functions
that can initialize struct pathspec: init_pathspec and
parse_pathspec. Any semantic changes in struct pathspec must be
reflected in both functions. init_pathspec() will be phased out in
favor of parse_pathspec().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |   2 ++
 dir.c   |   4 +--
 dir.h   |   2 ++
 setup.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++-------=
--------
 4 files changed, 90 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index 72675a1..759c62a 100644
--- a/cache.h
+++ b/cache.h
@@ -481,9 +481,11 @@ struct pathspec {
 	int nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
+	unsigned magic;
 	int max_depth;
 	struct pathspec_item {
 		const char *match;
+		unsigned magic;
 		int len;
 		int nowildcard_len;
 		int flags;
diff --git a/dir.c b/dir.c
index 12a76d7..8454c13 100644
--- a/dir.c
+++ b/dir.c
@@ -323,7 +323,7 @@ int match_pathspec_depth(const struct pathspec *ps,
 /*
  * Return the length of the "simple" part of a path match limiter.
  */
-static int simple_length(const char *match)
+int simple_length(const char *match)
 {
 	int len =3D -1;
=20
@@ -335,7 +335,7 @@ static int simple_length(const char *match)
 	}
 }
=20
-static int no_wildcard(const char *string)
+int no_wildcard(const char *string)
 {
 	return string[simple_length(string)] =3D=3D '\0';
 }
diff --git a/dir.h b/dir.h
index ae1bc46..0cf5ccf 100644
--- a/dir.h
+++ b/dir.h
@@ -88,6 +88,8 @@ struct dir_struct {
 #define MATCHED_RECURSIVELY 1
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
+extern int simple_length(const char *match);
+extern int no_wildcard(const char *string);
 extern char *common_prefix(const char **pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
diff --git a/setup.c b/setup.c
index f108c4b..92adefc 100644
--- a/setup.c
+++ b/setup.c
@@ -174,7 +174,7 @@ static struct pathspec_magic {
=20
 /*
  * Take an element of a pathspec and check for magic signatures.
- * Append the result to the prefix.
+ * Append the result to the prefix. Return the magic bitmap.
  *
  * For now, we only parse the syntax and throw out anything other than
  * "top" magic.
@@ -185,10 +185,14 @@ static struct pathspec_magic {
  * the prefix part must always match literally, and a single stupid
  * string cannot express such a case.
  */
-static const char *prefix_pathspec(const char *prefix, int prefixlen, =
const char *elt)
+static unsigned prefix_pathspec(struct pathspec_item *item,
+				const char **raw, unsigned flags,
+				const char *prefix, int prefixlen,
+				const char *elt)
 {
 	unsigned magic =3D 0;
 	const char *copyfrom =3D elt;
+	char *match;
 	int i;
=20
 	if (elt[0] !=3D ':') {
@@ -241,39 +245,95 @@ static const char *prefix_pathspec(const char *pr=
efix, int prefixlen, const char
 	}
=20
 	if (magic & PATHSPEC_FROMTOP)
-		return xstrdup(copyfrom);
+		match =3D xstrdup(copyfrom);
 	else
-		return prefix_path(prefix, prefixlen, copyfrom);
+		match =3D prefix_path(prefix, prefixlen, copyfrom);
+	*raw =3D item->match =3D match;
+	item->len =3D strlen(item->match);
+	item->flags =3D 0;
+	if (limit_pathspec_to_literal())
+		item->nowildcard_len =3D item->len;
+	else
+		item->nowildcard_len =3D simple_length(item->match);
+	if (item->nowildcard_len < item->len &&
+	    item->match[item->nowildcard_len] =3D=3D '*' &&
+	    no_wildcard(item->match + item->nowildcard_len + 1))
+		item->flags |=3D PATHSPEC_ONESTAR;
+	return magic;
 }
=20
-const char **get_pathspec(const char *prefix, const char **pathspec)
+static int pathspec_item_cmp(const void *a_, const void *b_)
 {
-	const char *entry =3D *pathspec;
-	const char **src, **dst;
-	int prefixlen;
+	struct pathspec_item *a, *b;
=20
-	if (!prefix && !entry)
-		return NULL;
+	a =3D (struct pathspec_item *)a_;
+	b =3D (struct pathspec_item *)b_;
+	return strcmp(a->match, b->match);
+}
+
+/*
+ * Given command line arguments and a prefix, convert the input to
+ * pathspec. die() if any magic other than ones in magic_mask.
+ */
+static void parse_pathspec(struct pathspec *pathspec,
+			   unsigned magic_mask, unsigned flags,
+			   const char *prefix, const char **argv)
+{
+	struct pathspec_item *item;
+	const char *entry =3D *argv;
+	int i, n, prefixlen;
+
+	memset(pathspec, 0, sizeof(*pathspec));
+
+	/* No arguments, no prefix -> no pathspec */
+	if (!entry && !prefix)
+		return;
=20
+	/* No arguments with prefix -> prefix pathspec */
 	if (!entry) {
-		static const char *spec[2];
-		spec[0] =3D prefix;
-		spec[1] =3D NULL;
-		return spec;
+		static const char *raw[2];
+
+		pathspec->items =3D item =3D xmalloc(sizeof(*item));
+		item->match =3D prefix;
+		item->nowildcard_len =3D item->len =3D strlen(prefix);
+		raw[0] =3D prefix;
+		raw[1] =3D NULL;
+		pathspec->nr =3D 1;
+		pathspec->raw =3D raw;
+		return;
 	}
=20
-	/* Otherwise we have to re-write the entries.. */
-	src =3D pathspec;
-	dst =3D pathspec;
+	n =3D 0;
+	while (argv[n])
+		n++;
+
+	pathspec->nr =3D n;
+	pathspec->items =3D item =3D xmalloc(sizeof(*item) * n);
+	pathspec->raw =3D argv;
 	prefixlen =3D prefix ? strlen(prefix) : 0;
-	while (*src) {
-		*(dst++) =3D prefix_pathspec(prefix, prefixlen, *src);
-		src++;
+
+	for (i =3D 0; i < n; i++) {
+		const char *arg =3D argv[i];
+
+		item[i].magic =3D prefix_pathspec(item + i, argv + i, flags,
+						prefix, prefixlen, arg);
+		if (item[i].magic & ~magic_mask)
+			die(_("pathspec magic in '%s' is not supported"
+			      " by this command"), arg);
+		if (item[i].nowildcard_len < item[i].len)
+			pathspec->has_wildcard =3D 1;
+		pathspec->magic |=3D item[i].magic;
 	}
-	*dst =3D NULL;
-	if (!*pathspec)
-		return NULL;
-	return pathspec;
+
+	qsort(pathspec->items, pathspec->nr,
+	      sizeof(struct pathspec_item), pathspec_item_cmp);
+}
+
+const char **get_pathspec(const char *prefix, const char **pathspec)
+{
+	struct pathspec ps;
+	parse_pathspec(&ps, PATHSPEC_FROMTOP, 0, prefix, pathspec);
+	return ps.raw;
 }
=20
 /*
--=20
1.8.0.rc2.23.g1fb49df
