From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 44/45] pathspec: support :(glob) syntax
Date: Fri, 15 Mar 2013 13:06:59 +0700
Message-ID: <1363327620-29017-45-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:29:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO93-0000KW-6S
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab3COG3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:29:10 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:51817 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab3COG3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:29:08 -0400
Received: by mail-ie0-f169.google.com with SMTP id 13so4044835iea.28
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=g6XbJdu52YzNeTLp4xZktw7bvfOnLerSflACf60JWfI=;
        b=WadJSV83yiczSweDTiY/qbLfD2tI1r/MDBLSGZSMbk6qB/sj/kXcpupACCdeK/FGY5
         Wg8WEKgAB9PyWRXBZA1vKU8gK0iOpaD5eYGiJEjylalzg829YLRR9OWeBgLyeJH1f8At
         xyFuXAsc1axJtq3A8b0X6mHM3R8/Sdvxoqwx95+xz5SfPFh4TaxIkkR8dQnqx2h321sD
         C9VPyUilY4sK+NLm8E8XnDIgkNUa84lWkjuP7/ml4SNVDXLQdzzpDoc40G5bo6KBMEd+
         zePLVjGLPSOhZ2zm7XWqtc5O0nUrJgmMfQQ/kJc0carLrqf7NSpkCbubVQ2xctHLu16+
         vnSg==
X-Received: by 10.50.34.132 with SMTP id z4mr502154igi.32.1363328948092;
        Thu, 14 Mar 2013 23:29:08 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id vb15sm737355igb.9.2013.03.14.23.29.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:29:07 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:12:09 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218231>

:(glob)path differs from plain pathspec that it uses wildmatch with
WM_PATHNAME while the other uses fnmatch without FNM_PATHNAME. The
difference lies in how '*' (and '**') is processed.

With the introduction of :(glob) and :(literal) and their global
options --[no]glob-pathspecs, the user can:

 - make everything literal by default via --noglob-pathspecs
   --literal-pathspecs cannot be used for this purpose as it
   disables _all_ pathspec magic.

 - individually turn on globbing with :(glob)

 - make everything globbing by default via --glob-pathspecs

 - individually turn off globbing with :(literal)

The implication behind this is, there is no way to gain the default
matching behavior (i.e. fnmatch without FNM_PATHNAME). You either get
new globbing or literal. The old fnmatch behavior is considered
deprecated and discouraged to use.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt              | 19 +++++++++++++++++
 Documentation/glossary-content.txt | 29 +++++++++++++++++++++++++
 builtin/add.c                      |  9 ++++++--
 builtin/ls-tree.c                  |  2 +-
 cache.h                            |  2 ++
 dir.c                              | 28 ++++++++++++++-----------
 dir.h                              |  9 ++++----
 git.c                              |  8 +++++++
 pathspec.c                         | 43 ++++++++++++++++++++++++++++++=
+++-----
 pathspec.h                         |  4 +++-
 tree-walk.c                        |  9 ++++----
 11 files changed, 131 insertions(+), 31 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3bbbbdc..d96df8d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -443,6 +443,17 @@ help ...`.
 	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
 	variable to `1`.
=20
+--glob-pathspecs:
+	Add "glob" magic to all pathspec. This is equivalent to setting
+	the `GIT_GLOB_PATHSPECS` environment variable to `1`. Disabling
+	globbing on individual pathspecs can be done using pathspec
+	magic ":(literal)"
+
+--noglob-pathspecs:
+	Add "literal" magic to all pathspec. This is equivalent to setting
+	the `GIT_NOGLOB_PATHSPECS` environment variable to `1`. Enabling
+	globbing on individual pathspecs can be done using pathspec
+	magic ":(glob)"
=20
 GIT COMMANDS
 ------------
@@ -834,6 +845,14 @@ GIT_LITERAL_PATHSPECS::
 	literal paths to Git (e.g., paths previously given to you by
 	`git ls-tree`, `--raw` diff output, etc).
=20
+GIT_GLOB_PATHSPECS::
+	Setting this variable to `1` will cause git to treat all
+	pathspecs as glob patterns (aka "glob" magic).
+
+GIT_NOGLOB_PATHSPECS::
+	Setting this variable to `1` will cause git to treat all
+	pathspecs as literal (aka "literal" magic).
+
=20
 Discussion[[Discussion]]
 ------------------------
diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index 8b91aeb..40f2d29 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -327,6 +327,35 @@ top `/`;;
 literal;;
 	Wildcards in the pattern such as `*` or `?` are treated
 	as literal characters.
+
+glob;;
+	Git treats the pattern as a shell glob suitable for
+	consumption by fnmatch(3) with the FNM_PATHNAME flag:
+	wildcards in the pattern will not match a / in the pathname.
+	For example, "Documentation/{asterisk}.html" matches
+	"Documentation/git.html" but not "Documentation/ppc/ppc.html"
+	or "tools/perf/Documentation/perf.html".
++
+Two consecutive asterisks ("`**`") in patterns matched against
+full pathname may have special meaning:
+
+ - A leading "`**`" followed by a slash means match in all
+   directories. For example, "`**/foo`" matches file or directory
+   "`foo`" anywhere, the same as pattern "`foo`". "**/foo/bar"
+   matches file or directory "`bar`" anywhere that is directly
+   under directory "`foo`".
+
+ - A trailing "/**" matches everything inside. For example,
+   "abc/**" matches all files inside directory "abc", relative
+   to the location of the `.gitignore` file, with infinite depth.
+
+ - A slash followed by two consecutive asterisks then a slash
+   matches zero or more directories. For example, "`a/**/b`"
+   matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
+
+ - Other consecutive asterisks are considered invalid.
++
+Glob magic is incompatible with literal magic.
 --
 +
 Currently only the slash `/` is recognized as the "magic signature",
diff --git a/builtin/add.c b/builtin/add.c
index 8bc6b45..d07cd1b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -426,11 +426,16 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		/*
 		 * file_exists() assumes exact match
 		 */
-		GUARD_PATHSPEC(&pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
+		GUARD_PATHSPEC(&pathspec,
+			       PATHSPEC_FROMTOP |
+			       PATHSPEC_LITERAL |
+			       PATHSPEC_GLOB);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
-			if (!seen[i] && !file_exists(path)) {
+			if (!seen[i] &&
+			    ((pathspec.items[i].magic & PATHSPEC_GLOB) ||
+			     !file_exists(path))) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
 					if (is_path_excluded(&check, path, -1, &dtype))
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index bdb03f3..1056634 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,7 +173,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec_depth() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, PATHSPEC_GLOB,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
diff --git a/cache.h b/cache.h
index 17e0b26..bdc98e2 100644
--- a/cache.h
+++ b/cache.h
@@ -365,6 +365,8 @@ static inline enum object_type object_type(unsigned=
 int mode)
 #define GIT_NOTES_REWRITE_REF_ENVIRONMENT "GIT_NOTES_REWRITE_REF"
 #define GIT_NOTES_REWRITE_MODE_ENVIRONMENT "GIT_NOTES_REWRITE_MODE"
 #define GIT_LITERAL_PATHSPECS_ENVIRONMENT "GIT_LITERAL_PATHSPECS"
+#define GIT_GLOB_PATHSPECS_ENVIRONMENT "GIT_GLOB_PATHSPECS"
+#define GIT_NOGLOB_PATHSPECS_ENVIRONMENT "GIT_NOGLOB_PATHSPECS"
=20
 /*
  * Repository-local GIT_* environment variables
diff --git a/dir.c b/dir.c
index 8d9ed24..77cd427 100644
--- a/dir.c
+++ b/dir.c
@@ -38,26 +38,28 @@ int fnmatch_icase(const char *pattern, const char *=
string, int flags)
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD :=
 0));
 }
=20
-inline int git_fnmatch(const char *pattern, const char *string,
-		       int flags, int prefix)
+inline int git_fnmatch(const struct pathspec_item *item,
+		       const char *pattern, const char *string,
+		       int prefix)
 {
-	int fnm_flags =3D 0;
-	if (flags & GFNM_PATHNAME)
-		fnm_flags |=3D FNM_PATHNAME;
 	if (prefix > 0) {
 		if (strncmp(pattern, string, prefix))
 			return FNM_NOMATCH;
 		pattern +=3D prefix;
 		string +=3D prefix;
 	}
-	if (flags & GFNM_ONESTAR) {
+	if (item->flags & PATHSPEC_ONESTAR) {
 		int pattern_len =3D strlen(++pattern);
 		int string_len =3D strlen(string);
 		return string_len < pattern_len ||
 		       strcmp(pattern,
 			      string + string_len - pattern_len);
 	}
-	return fnmatch(pattern, string, fnm_flags);
+	if (item->magic & PATHSPEC_GLOB)
+		return wildmatch(pattern, string, WM_PATHNAME, NULL);
+	else
+		/* wildmatch has not learned no FNM_PATHNAME mode yet */
+		return fnmatch(pattern, string, 0);
 }
=20
 static size_t common_prefix_len(const struct pathspec *pathspec)
@@ -68,7 +70,8 @@ static size_t common_prefix_len(const struct pathspec=
 *pathspec)
 	GUARD_PATHSPEC(pathspec,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_MAXDEPTH |
-		       PATHSPEC_LITERAL);
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB);
=20
 	for (n =3D 0; n < pathspec->nr; n++) {
 		size_t i =3D 0, len =3D 0;
@@ -163,8 +166,7 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 	}
=20
 	if (item->nowildcard_len < item->len &&
-	    !git_fnmatch(match, name,
-			 item->flags & PATHSPEC_ONESTAR ? GFNM_ONESTAR : 0,
+	    !git_fnmatch(item, match, name,
 			 item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
=20
@@ -195,7 +197,8 @@ int match_pathspec_depth(const struct pathspec *ps,
 	GUARD_PATHSPEC(ps,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_MAXDEPTH |
-		       PATHSPEC_LITERAL);
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -1347,7 +1350,8 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 		GUARD_PATHSPEC(pathspec,
 			       PATHSPEC_FROMTOP |
 			       PATHSPEC_MAXDEPTH |
-			       PATHSPEC_LITERAL);
+			       PATHSPEC_LITERAL |
+			       PATHSPEC_GLOB);
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
diff --git a/dir.h b/dir.h
index 13da62c..da67237 100644
--- a/dir.h
+++ b/dir.h
@@ -208,10 +208,9 @@ extern int fnmatch_icase(const char *pattern, cons=
t char *string, int flags);
 /*
  * The prefix part of pattern must not contains wildcards.
  */
-#define GFNM_PATHNAME 1		/* similar to FNM_PATHNAME */
-#define GFNM_ONESTAR  2		/* there is only _one_ wildcard, a star */
-
-extern int git_fnmatch(const char *pattern, const char *string,
-		       int flags, int prefix);
+struct pathspec_item;
+extern int git_fnmatch(const struct pathspec_item *item,
+		       const char *pattern, const char *string,
+		       int prefix);
=20
 #endif
diff --git a/git.c b/git.c
index 39ba6b1..65c386a 100644
--- a/git.c
+++ b/git.c
@@ -143,6 +143,14 @@ static int handle_options(const char ***argv, int =
*argc, int *envchanged)
 			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged =3D 1;
+		} else if (!strcmp(cmd, "--glob-pathspecs")) {
+			setenv(GIT_GLOB_PATHSPECS_ENVIRONMENT, "1", 1);
+			if (envchanged)
+				*envchanged =3D 1;
+		} else if (!strcmp(cmd, "--noglob-pathspecs")) {
+			setenv(GIT_NOGLOB_PATHSPECS_ENVIRONMENT, "1", 1);
+			if (envchanged)
+				*envchanged =3D 1;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/pathspec.c b/pathspec.c
index 61a47b8..7ddcf55 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -57,7 +57,6 @@ char *find_pathspecs_matching_against_index(const str=
uct pathspec *pathspec)
  *
  * Possible future magic semantics include stuff like:
  *
- *	{ PATHSPEC_NOGLOB, '!', "noglob" },
  *	{ PATHSPEC_ICASE, '\0', "icase" },
  *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
  *	{ PATHSPEC_REGEXP, '\0', "regexp" },
@@ -71,6 +70,7 @@ static struct pathspec_magic {
 } pathspec_magic[] =3D {
 	{ PATHSPEC_FROMTOP, '/', "top" },
 	{ PATHSPEC_LITERAL,   0, "literal" },
+	{ PATHSPEC_GLOB,   '\0', "glob" },
 };
=20
 /*
@@ -93,6 +93,8 @@ static unsigned prefix_pathspec(struct pathspec_item =
*item,
 				const char *elt)
 {
 	static int literal_global =3D -1;
+	static int glob_global =3D -1;
+	static int noglob_global =3D -1;
 	unsigned magic =3D 0, short_magic =3D 0, global_magic =3D 0;
 	const char *copyfrom =3D elt, *long_magic_end =3D NULL;
 	char *match;
@@ -103,6 +105,22 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	if (literal_global)
 		global_magic |=3D PATHSPEC_LITERAL;
=20
+	if (glob_global < 0)
+		glob_global =3D git_env_bool(GIT_GLOB_PATHSPECS_ENVIRONMENT, 0);
+	if (glob_global)
+		global_magic |=3D PATHSPEC_GLOB;
+
+	if (noglob_global < 0)
+		noglob_global =3D git_env_bool(GIT_NOGLOB_PATHSPECS_ENVIRONMENT, 0);
+
+	if (glob_global && noglob_global)
+		die(_("global 'glob' and 'noglob' pathspec settings are incompatible=
"));
+
+	if ((global_magic & PATHSPEC_LITERAL) &&
+	    (global_magic & ~PATHSPEC_LITERAL))
+		die(_("global 'literal' pathspec setting is incompatiable "
+		      "with all other global pathspec settings"));
+
 	if (elt[0] !=3D ':' || literal_global) {
 		; /* nothing to do */
 	} else if (elt[1] =3D=3D '(') {
@@ -166,12 +184,20 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
=20
 	magic |=3D short_magic;
 	*p_short_magic =3D short_magic;
+
+	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specifed */
+	if (noglob_global && !(magic & PATHSPEC_GLOB))
+		global_magic |=3D PATHSPEC_LITERAL;
+
 	magic |=3D global_magic;
=20
 	if (pathspec_prefix >=3D 0 &&
 	    (prefixlen || (prefix && *prefix)))
 		die("BUG: 'prefix' magic is supposed to be used at worktree's root")=
;
=20
+	if ((magic & PATHSPEC_LITERAL) && (magic & PATHSPEC_GLOB))
+		die("%s: 'literal' and 'glob' are incompatible", elt);
+
 	if (pathspec_prefix >=3D 0) {
 		match =3D xstrdup(copyfrom);
 		prefixlen =3D pathspec_prefix;
@@ -247,10 +273,17 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
 			item->nowildcard_len =3D prefixlen;
 	}
 	item->flags =3D 0;
-	if (item->nowildcard_len < item->len &&
-	    item->match[item->nowildcard_len] =3D=3D '*' &&
-	    no_wildcard(item->match + item->nowildcard_len + 1))
-		item->flags |=3D PATHSPEC_ONESTAR;
+	if (magic & PATHSPEC_GLOB) {
+		/*
+		 * FIXME: should we enable ONESTAR in _GLOB for
+		 * pattern "* * / * . c"?
+		 */
+	} else {
+		if (item->nowildcard_len < item->len &&
+		    item->match[item->nowildcard_len] =3D=3D '*' &&
+		    no_wildcard(item->match + item->nowildcard_len + 1))
+			item->flags |=3D PATHSPEC_ONESTAR;
+	}
 	return magic;
 }
=20
diff --git a/pathspec.h b/pathspec.h
index d5db7d5..9a0c5d5 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -5,10 +5,12 @@
 #define PATHSPEC_FROMTOP	(1<<0)
 #define PATHSPEC_MAXDEPTH	(1<<1)
 #define PATHSPEC_LITERAL	(1<<2)
+#define PATHSPEC_GLOB		(1<<3)
 #define PATHSPEC_ALL_MAGIC	  \
 	(PATHSPEC_FROMTOP	| \
 	 PATHSPEC_MAXDEPTH	| \
-	 PATHSPEC_LITERAL)
+	 PATHSPEC_LITERAL	| \
+	 PATHSPEC_GLOB)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
diff --git a/tree-walk.c b/tree-walk.c
index 676bd7f..a44f528 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -639,7 +639,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 	GUARD_PATHSPEC(ps,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_MAXDEPTH |
-		       PATHSPEC_LITERAL);
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -685,8 +686,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 				return entry_interesting;
=20
 			if (item->nowildcard_len < item->len) {
-				if (!git_fnmatch(match + baselen, entry->path,
-						 item->flags & PATHSPEC_ONESTAR ? GFNM_ONESTAR : 0,
+				if (!git_fnmatch(item, match + baselen, entry->path,
 						 item->nowildcard_len - baselen))
 					return entry_interesting;
=20
@@ -727,8 +727,7 @@ match_wildcards:
=20
 		strbuf_add(base, entry->path, pathlen);
=20
-		if (!git_fnmatch(match, base->buf + base_offset,
-				 item->flags & PATHSPEC_ONESTAR ? GFNM_ONESTAR : 0,
+		if (!git_fnmatch(item, match, base->buf + base_offset,
 				 item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
 			return entry_interesting;
--=20
1.8.0.rc0.19.g7bbb31d
