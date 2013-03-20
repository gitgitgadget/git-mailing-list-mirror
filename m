From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/45] Add parse_pathspec() that converts cmdline args to struct pathspec
Date: Wed, 20 Mar 2013 19:16:14 +0700
Message-ID: <1363781779-14947-2-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 13:17:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHx7-0003Kp-01
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169Ab3CTMQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 08:16:34 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:38116 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab3CTMQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:16:33 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so1312128pbb.18
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=D6JnZyPEpN/lLFV5rsBFyaBFZ8b97IXF6pxEAmMNHQI=;
        b=MiCV8bA797QMGbCHQwAIadnd8tPnbuC0sfe4R289dyv4eJF+R9s2gRLWPPuQK3CD5r
         iAg2Mhtwu8h+8jWZHhpIFu6pumd8L+SfaZYZvvK4mc9PILMvlZQ7QCD2PqkcHqSnRcGc
         oofoWYqYzd6Kot1y/UWotgV8/DwoIajO0PsxTmG1JUTw/+8VfA4BT13yPREuhzLQk8Co
         nl7YhjkHwJst0q/uUgtYj/yQut672uZlOoCejftgt3mdpXzpF0kuDzdG95g/PB2Obcnf
         EJu3ZrcXY+t/36nAXPauQHTt+VZR5Fs2B7ObcAwqfiijEdcMw3ppQhe3/SmL9cgOOvyS
         OHug==
X-Received: by 10.68.190.99 with SMTP id gp3mr8730956pbc.117.1363781792653;
        Wed, 20 Mar 2013 05:16:32 -0700 (PDT)
Received: from lanh ([115.74.40.216])
        by mx.google.com with ESMTPS id pb3sm1951096pbc.7.2013.03.20.05.16.29
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:16:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Mar 2013 19:16:28 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218589>

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
 Documentation/technical/api-setup.txt |  19 +++-
 dir.c                                 |   4 +-
 dir.h                                 |   2 +
 pathspec.c                            | 168 ++++++++++++++++++++++++++=
--------
 pathspec.h                            |  11 +++
 5 files changed, 163 insertions(+), 41 deletions(-)

diff --git a/Documentation/technical/api-setup.txt b/Documentation/tech=
nical/api-setup.txt
index 4f63a04..59a947e 100644
--- a/Documentation/technical/api-setup.txt
+++ b/Documentation/technical/api-setup.txt
@@ -8,6 +8,23 @@ Talk about
 * is_inside_git_dir()
 * is_inside_work_tree()
 * setup_work_tree()
-* get_pathspec()
=20
 (Dscho)
+
+Pathspec
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+See glossary-context.txt for the syntax of pathspec. In memory, a
+pathspec set is represented by "struct pathspec" and is prepared by
+parse_pathspec(). This function takes several arguments:
+
+- magic_mask specifies what features that are NOT supported by the
+  following code. If a user attempts to use such a feature,
+  parse_pathspec() can reject it early.
+
+- flags specifies other things that the caller wants parse_pathspec to
+  perform.
+
+- prefix and args come from cmd_* functions
+
+get_pathspec() is obsolete and should never be used in new code.
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
index ab53b8a..ebe9844 100644
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
@@ -194,15 +194,128 @@ static const char *prefix_pathspec(const char *p=
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
+		memset(item, 0, sizeof(*item));
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
@@ -221,32 +334,11 @@ static const char *prefix_pathspec(const char *pr=
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
