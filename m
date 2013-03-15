From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 06/45] Add parse_pathspec() that converts cmdline args to struct pathspec
Date: Fri, 15 Mar 2013 13:06:21 +0700
Message-ID: <1363327620-29017-7-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO4s-0004CH-Ej
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab3COGYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:24:46 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:33333 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab3COGYo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:24:44 -0400
Received: by mail-ia0-f174.google.com with SMTP id k38so2849004iah.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=BHrDLBnhjS/ccKOAlMTkhgzNrmYxEoutNiXhRvmS11I=;
        b=fpGTbdnvyZJTgksRE8loDcdNqIArvGKD1bksNfoSHl5xRJyB06hyIl/jN0MzmI8Nk/
         nVQ8rxOyhLNy2cUIpzc8gZI6xK50Lqw8Ag5hnSi5nxsfWV2DU7/Ea/BJgWdXgS4zQWmR
         DJ1rAGDofX9um7znL/H/LeSznUA1Atg7a3Q8tLup2cM3EsL6qUAb5OXqlOtzSct3/788
         XL972HNTWIt51t0Na8jX4ouSFInE85yhErtqTjOmBZm4+TpWujkhlU11GivXelQuEwfe
         iqrSpjKe23jbFA+kW//hpOOKoV59EE3+eYfy5QIj9iWJTRy06Snk4qsVurKLBhlrA+9c
         IMMQ==
X-Received: by 10.50.209.4 with SMTP id mi4mr486895igc.40.1363328684400;
        Thu, 14 Mar 2013 23:24:44 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ua6sm632005igb.0.2013.03.14.23.24.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:24:43 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:07:45 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218194>

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
 dir.c      |   4 +-
 dir.h      |   2 +
 pathspec.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++------=
--------
 pathspec.h |  11 ++++
 4 files changed, 144 insertions(+), 40 deletions(-)

diff --git a/dir.c b/dir.c
index 97ad45b..a442467 100644
--- a/dir.c
+++ b/dir.c
@@ -338,7 +338,7 @@ int match_pathspec_depth(const struct pathspec *ps,
 /*
  * Return the length of the "simple" part of a path match limiter.
  */
-static int simple_length(const char *match)
+int simple_length(const char *match)
 {
 	int len =3D -1;
=20
@@ -350,7 +350,7 @@ static int simple_length(const char *match)
 	}
 }
=20
-static int no_wildcard(const char *string)
+int no_wildcard(const char *string)
 {
 	return string[simple_length(string)] =3D=3D '\0';
 }
diff --git a/dir.h b/dir.h
index c3eb4b5..89427fd 100644
--- a/dir.h
+++ b/dir.h
@@ -125,6 +125,8 @@ struct dir_struct {
 #define MATCHED_RECURSIVELY 1
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
+extern int simple_length(const char *match);
+extern int no_wildcard(const char *string);
 extern char *common_prefix(const char **pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
diff --git a/pathspec.c b/pathspec.c
index ab53b8a..bc9d9ac 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -103,10 +103,6 @@ void die_if_path_beyond_symlink(const char *path, =
const char *prefix)
 /*
  * Magic pathspec
  *
- * NEEDSWORK: These need to be moved to dir.h or even to a new
- * pathspec.h when we restructure get_pathspec() users to use the
- * "struct pathspec" interface.
- *
  * Possible future magic semantics include stuff like:
  *
  *	{ PATHSPEC_NOGLOB, '!', "noglob" },
@@ -115,7 +111,6 @@ void die_if_path_beyond_symlink(const char *path, c=
onst char *prefix)
  *	{ PATHSPEC_REGEXP, '\0', "regexp" },
  *
  */
-#define PATHSPEC_FROMTOP    (1<<0)
=20
 static struct pathspec_magic {
 	unsigned bit;
@@ -127,7 +122,7 @@ static struct pathspec_magic {
=20
 /*
  * Take an element of a pathspec and check for magic signatures.
- * Append the result to the prefix.
+ * Append the result to the prefix. Return the magic bitmap.
  *
  * For now, we only parse the syntax and throw out anything other than
  * "top" magic.
@@ -138,10 +133,15 @@ static struct pathspec_magic {
  * the prefix part must always match literally, and a single stupid
  * string cannot express such a case.
  */
-static const char *prefix_pathspec(const char *prefix, int prefixlen, =
const char *elt)
+static unsigned prefix_pathspec(struct pathspec_item *item,
+				unsigned *p_short_magic,
+				const char **raw, unsigned flags,
+				const char *prefix, int prefixlen,
+				const char *elt)
 {
-	unsigned magic =3D 0;
+	unsigned magic =3D 0, short_magic =3D 0;
 	const char *copyfrom =3D elt;
+	char *match;
 	int i;
=20
 	if (elt[0] !=3D ':') {
@@ -183,7 +183,7 @@ static const char *prefix_pathspec(const char *pref=
ix, int prefixlen, const char
 				break;
 			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
 				if (pathspec_magic[i].mnemonic =3D=3D ch) {
-					magic |=3D pathspec_magic[i].bit;
+					short_magic |=3D pathspec_magic[i].bit;
 					break;
 				}
 			if (ARRAY_SIZE(pathspec_magic) <=3D i)
@@ -194,15 +194,127 @@ static const char *prefix_pathspec(const char *p=
refix, int prefixlen, const char
 			copyfrom++;
 	}
=20
+	magic |=3D short_magic;
+	*p_short_magic =3D short_magic;
+
 	if (magic & PATHSPEC_FROMTOP)
-		return xstrdup(copyfrom);
+		match =3D xstrdup(copyfrom);
 	else
-		return prefix_path(prefix, prefixlen, copyfrom);
+		match =3D prefix_path(prefix, prefixlen, copyfrom);
+	*raw =3D item->match =3D match;
+	item->len =3D strlen(item->match);
+	if (limit_pathspec_to_literal())
+		item->nowildcard_len =3D item->len;
+	else
+		item->nowildcard_len =3D simple_length(item->match);
+	item->flags =3D 0;
+	if (item->nowildcard_len < item->len &&
+	    item->match[item->nowildcard_len] =3D=3D '*' &&
+	    no_wildcard(item->match + item->nowildcard_len + 1))
+		item->flags |=3D PATHSPEC_ONESTAR;
+	return magic;
+}
+
+static int pathspec_item_cmp(const void *a_, const void *b_)
+{
+	struct pathspec_item *a, *b;
+
+	a =3D (struct pathspec_item *)a_;
+	b =3D (struct pathspec_item *)b_;
+	return strcmp(a->match, b->match);
+}
+
+static void NORETURN unsupported_magic(const char *pattern,
+				       unsigned magic,
+				       unsigned short_magic)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i, n;
+	for (n =3D i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+		const struct pathspec_magic *m =3D pathspec_magic + i;
+		if (!(magic & m->bit))
+			continue;
+		if (sb.len)
+			strbuf_addstr(&sb, " ");
+		if (short_magic & m->bit)
+			strbuf_addf(&sb, "'%c'", m->mnemonic);
+		else
+			strbuf_addf(&sb, "'%s'", m->name);
+		n++;
+	}
+	/*
+	 * We may want to substitue "this command" with a command
+	 * name. E.g. when add--interactive dies when running
+	 * "checkout -p"
+	 */
+	die(_("%s: pathspec magic not supported by this command: %s"),
+	    pattern, sb.buf);
+}
+
+/*
+ * Given command line arguments and a prefix, convert the input to
+ * pathspec. die() any magic in magic_mask is used.
+ */
+void parse_pathspec(struct pathspec *pathspec,
+		    unsigned magic_mask, unsigned flags,
+		    const char *prefix, const char **argv)
+{
+	struct pathspec_item *item;
+	const char *entry =3D argv ? *argv : NULL;
+	int i, n, prefixlen;
+
+	memset(pathspec, 0, sizeof(*pathspec));
+
+	/* No arguments, no prefix -> no pathspec */
+	if (!entry && !prefix)
+		return;
+
+	/* No arguments with prefix -> prefix pathspec */
+	if (!entry) {
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
+	}
+
+	n =3D 0;
+	while (argv[n])
+		n++;
+
+	pathspec->nr =3D n;
+	pathspec->items =3D item =3D xmalloc(sizeof(*item) * n);
+	pathspec->raw =3D argv;
+	prefixlen =3D prefix ? strlen(prefix) : 0;
+
+	for (i =3D 0; i < n; i++) {
+		unsigned short_magic;
+		entry =3D argv[i];
+
+		item[i].magic =3D prefix_pathspec(item + i, &short_magic,
+						argv + i, flags,
+						prefix, prefixlen, entry);
+		if (item[i].magic & magic_mask)
+			unsupported_magic(entry,
+					  item[i].magic & magic_mask,
+					  short_magic);
+		if (item[i].nowildcard_len < item[i].len)
+			pathspec->has_wildcard =3D 1;
+		pathspec->magic |=3D item[i].magic;
+	}
+
+	qsort(pathspec->items, pathspec->nr,
+	      sizeof(struct pathspec_item), pathspec_item_cmp);
 }
=20
 /*
  * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
- * based interface - see pathspec_magic above.
+ * based interface - see pathspec.c:parse_pathspec().
  *
  * Arguments:
  *  - prefix - a path relative to the root of the working tree
@@ -221,32 +333,11 @@ static const char *prefix_pathspec(const char *pr=
efix, int prefixlen, const char
  */
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
-	const char *entry =3D *pathspec;
-	const char **src, **dst;
-	int prefixlen;
-
-	if (!prefix && !entry)
-		return NULL;
-
-	if (!entry) {
-		static const char *spec[2];
-		spec[0] =3D prefix;
-		spec[1] =3D NULL;
-		return spec;
-	}
-
-	/* Otherwise we have to re-write the entries.. */
-	src =3D pathspec;
-	dst =3D pathspec;
-	prefixlen =3D prefix ? strlen(prefix) : 0;
-	while (*src) {
-		*(dst++) =3D prefix_pathspec(prefix, prefixlen, *src);
-		src++;
-	}
-	*dst =3D NULL;
-	if (!*pathspec)
-		return NULL;
-	return pathspec;
+	struct pathspec ps;
+	parse_pathspec(&ps,
+		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
+		       0, prefix, pathspec);
+	return ps.raw;
 }
=20
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
diff --git a/pathspec.h b/pathspec.h
index a621676..937ec91 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -1,6 +1,10 @@
 #ifndef PATHSPEC_H
 #define PATHSPEC_H
=20
+/* Pathspec magic */
+#define PATHSPEC_FROMTOP	(1<<0)
+#define PATHSPEC_ALL_MAGIC PATHSPEC_FROMTOP
+
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
 struct pathspec {
@@ -8,9 +12,11 @@ struct pathspec {
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
@@ -18,6 +24,11 @@ struct pathspec {
 };
=20
 extern int init_pathspec(struct pathspec *, const char **);
+extern void parse_pathspec(struct pathspec *pathspec,
+			   unsigned magic_mask,
+			   unsigned flags,
+			   const char *prefix,
+			   const char **args);
 extern void copy_pathspec(struct pathspec *dst, const struct pathspec =
*src);
 extern void free_pathspec(struct pathspec *);
=20
--=20
1.8.0.rc0.19.g7bbb31d
