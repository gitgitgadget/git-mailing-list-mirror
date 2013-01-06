From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/21] Add parse_pathspec() that converts cmdline args to struct pathspec
Date: Sun,  6 Jan 2013 13:20:49 +0700
Message-ID: <1357453268-12543-3-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjc1-0007Si-1o
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139Ab3AFGVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:21:16 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:45987 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3AFGVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:21:15 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so9911896pbc.4
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2x0td8ZdkXTdscZIYcQWgRp4MqOg4UCBg2pAfRzTRRg=;
        b=A/d2jX10ZMGzDCouRz929E4FwZj43a0FwYm09FOJVWngRmCgRqtNmEICEe9gGumoR7
         S0EyB4vFV41HCPT1hZork+QqFg1qdV0ZRt/ky48osbHWLvt6x/AzzHcO+JwvAVK0iAu5
         wwAFd0/T2zNbAl7oSwkv57WelCNfZhCYosfu2lZhMLvKzd1AE7SaXPYTnghuGlf36AU4
         iAZDWyBzE1xuNi0snmbQ7O3trPwpuq15Zwci6HLh4tzPz6PqLTRiSjRp/NG9FNB4Ip4j
         0HHCqaD/C5DbwktmXnoSbwhYtYWQWJPWmAQ79NeLywr6wJQesRIkyhuibjRXXz+xwd50
         W0Mw==
X-Received: by 10.66.83.196 with SMTP id s4mr167400382pay.74.1357453274058;
        Sat, 05 Jan 2013 22:21:14 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id sb3sm35287065pbc.44.2013.01.05.22.21.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:21:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:21:23 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212756>

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
 dir.c   |  2 +-
 dir.h   |  1 +
 setup.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++--------=
--------
 3 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/dir.c b/dir.c
index c391d46..31f0995 100644
--- a/dir.c
+++ b/dir.c
@@ -291,7 +291,7 @@ int match_pathspec_depth(const struct pathspec *ps,
 /*
  * Return the length of the "simple" part of a path match limiter.
  */
-static int simple_length(const char *match)
+int simple_length(const char *match)
 {
 	int len =3D -1;
=20
diff --git a/dir.h b/dir.h
index f5c89e3..1d4888b 100644
--- a/dir.h
+++ b/dir.h
@@ -66,6 +66,7 @@ struct dir_struct {
 #define MATCHED_RECURSIVELY 1
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
+extern int simple_length(const char *match);
 extern char *common_prefix(const char **pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
diff --git a/setup.c b/setup.c
index f108c4b..4fcdae6 100644
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
@@ -185,7 +185,10 @@ static struct pathspec_magic {
  * the prefix part must always match literally, and a single stupid
  * string cannot express such a case.
  */
-static const char *prefix_pathspec(const char *prefix, int prefixlen, =
const char *elt)
+static unsigned prefix_pathspec(struct pathspec_item *item,
+				const char **raw,
+				const char *prefix, int prefixlen,
+				const char *elt)
 {
 	unsigned magic =3D 0;
 	const char *copyfrom =3D elt;
@@ -241,39 +244,87 @@ static const char *prefix_pathspec(const char *pr=
efix, int prefixlen, const char
 	}
=20
 	if (magic & PATHSPEC_FROMTOP)
-		return xstrdup(copyfrom);
+		item->match =3D xstrdup(copyfrom);
 	else
-		return prefix_path(prefix, prefixlen, copyfrom);
+		item->match =3D prefix_path(prefix, prefixlen, copyfrom);
+	*raw =3D item->match;
+	item->len =3D strlen(item->match);
+	item->nowildcard_len =3D simple_length(item->match);
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
+		unsigned applied_magic;
+		const char *arg =3D argv[i];
+
+		applied_magic =3D prefix_pathspec(item + i, argv + i,
+						prefix, prefixlen, arg);
+		if (applied_magic & ~magic_mask)
+			die(_("pathspec magic in '%s' is not supported"
+			      " by this command"), arg);
+		if (item[i].nowildcard_len < item[i].len)
+			pathspec->has_wildcard =3D 1;
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
