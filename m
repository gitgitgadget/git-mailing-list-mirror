From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 43/46] pathspec: support :(literal) syntax for noglob pathspec
Date: Sun, 14 Jul 2013 15:36:06 +0700
Message-ID: <1373790969-13000-44-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:40:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHrA-0003kD-C3
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab3GNIkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:40:31 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:47032 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab3GNIka (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:40:30 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so10296836pbc.4
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ClLG0hjSopsaNWVufdBoWUbBGEZ42II748QD9hY0EB4=;
        b=nfAiFqKXkl3TQqbxakUvlfjaPp+j1Cq8QRdnjGXHg1QSgVOuhO00o3a7o4r64jx++5
         0WaPHB8DG60TAX8oVR3Bqqb7SSEb4Durl8WQGXmuE85jEEtDHfeJ7XWgyY1fLoaYCiqp
         rdj6Qx7rJwVxHun5NhKDuKVJVeM094Flja8H+QvFU8wmHcUXdlykwSDkUJ+gOgEmUHEH
         R1Nrz1hBPafSA8VzPzM3eEi3Ws1+DIbqcqQbKwqPQjLNMUcvYsyzEEh/7QYM4xKBDbrA
         tTw5Xj3OUynp7ErAm7Y7aktb8pa8wco9bzxIT3yI2j2ddQpv/YwzF1BxbhWElZ06lCjR
         VSoQ==
X-Received: by 10.68.253.161 with SMTP id ab1mr48415293pbd.76.1373791229389;
        Sun, 14 Jul 2013 01:40:29 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id zv11sm57856668pab.3.2013.07.14.01.40.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:40:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:40:41 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230355>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/glossary-content.txt | 20 ++++++++++++++++----
 builtin/add.c                      |  2 +-
 builtin/diff.c                     |  2 +-
 dir.c                              | 15 ++++++++++++---
 pathspec.c                         | 11 ++++++++---
 pathspec.h                         |  4 +++-
 t/t6130-pathspec-noglob.sh         | 18 ++++++++++++++++++
 tree-diff.c                        |  2 +-
 tree-walk.c                        |  5 ++++-
 9 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index dba5062..ca9f20f 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -322,10 +322,22 @@ and a close parentheses `)`, and the remainder is=
 the pattern to match
 against the path.
 +
 The "magic signature" consists of an ASCII symbol that is not
-alphanumeric. Currently only the slash `/` is recognized as a
-"magic signature": it makes the pattern match from the root of
-the working tree, even when you are running the command from
-inside a subdirectory.
+alphanumeric.
++
+--
+top `/`;;
+	The magic word `top` (mnemonic: `/`) makes the pattern match
+	from the root of the working tree, even when you are running
+	the command from inside a subdirectory.
+
+literal;;
+	Wildcards in the pattern such as `*` or `?` are treated
+	as literal characters.
+--
++
+Currently only the slash `/` is recognized as the "magic signature",
+but it is envisioned that we will support more types of magic in later
+versions of Git.
 +
 A pathspec with only a colon means "there is no pathspec". This form
 should not be combined with other pathspec.
diff --git a/builtin/add.c b/builtin/add.c
index 0b80fa8..663ddd1 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -541,7 +541,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		/*
 		 * file_exists() assumes exact match
 		 */
-		GUARD_PATHSPEC(&pathspec, PATHSPEC_FROMTOP);
+		GUARD_PATHSPEC(&pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
diff --git a/builtin/diff.c b/builtin/diff.c
index bb84ba0..2fb8c5d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -368,7 +368,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	}
 	if (rev.prune_data.nr) {
 		/* builtin_diff_b_f() */
-		GUARD_PATHSPEC(&rev.prune_data, PATHSPEC_FROMTOP);
+		GUARD_PATHSPEC(&rev.prune_data, PATHSPEC_FROMTOP | PATHSPEC_LITERAL)=
;
 		if (!path)
 			path =3D rev.prune_data.items[0].match;
 		paths +=3D rev.prune_data.nr;
diff --git a/dir.c b/dir.c
index 79465e7..50ec2f5 100644
--- a/dir.c
+++ b/dir.c
@@ -108,7 +108,10 @@ static size_t common_prefix_len(const struct paths=
pec *pathspec)
 	int n;
 	size_t max =3D 0;
=20
-	GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
+	GUARD_PATHSPEC(pathspec,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_MAXDEPTH |
+		       PATHSPEC_LITERAL);
=20
 	for (n =3D 0; n < pathspec->nr; n++) {
 		size_t i =3D 0, len =3D 0;
@@ -232,7 +235,10 @@ int match_pathspec_depth(const struct pathspec *ps=
,
 {
 	int i, retval =3D 0;
=20
-	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
+	GUARD_PATHSPEC(ps,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_MAXDEPTH |
+		       PATHSPEC_LITERAL);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -1288,7 +1294,10 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const stru
 	 * Check out create_simplify()
 	 */
 	if (pathspec)
-		GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
+		GUARD_PATHSPEC(pathspec,
+			       PATHSPEC_FROMTOP |
+			       PATHSPEC_MAXDEPTH |
+			       PATHSPEC_LITERAL);
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
diff --git a/pathspec.c b/pathspec.c
index b2e3a87..6a16938 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -70,6 +70,7 @@ static struct pathspec_magic {
 	const char *name;
 } pathspec_magic[] =3D {
 	{ PATHSPEC_FROMTOP, '/', "top" },
+	{ PATHSPEC_LITERAL,   0, "literal" },
 };
=20
 /*
@@ -92,13 +93,15 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 				const char *elt)
 {
 	static int literal_global =3D -1;
-	unsigned magic =3D 0, short_magic =3D 0;
+	unsigned magic =3D 0, short_magic =3D 0, global_magic =3D 0;
 	const char *copyfrom =3D elt, *long_magic_end =3D NULL;
 	char *match;
 	int i, pathspec_prefix =3D -1;
=20
 	if (literal_global < 0)
 		literal_global =3D git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0=
);
+	if (literal_global)
+		global_magic |=3D PATHSPEC_LITERAL;
=20
 	if (elt[0] !=3D ':') {
 		; /* nothing to do */
@@ -164,6 +167,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
=20
 	magic |=3D short_magic;
 	*p_short_magic =3D short_magic;
+	magic |=3D global_magic;
=20
 	if (pathspec_prefix >=3D 0 &&
 	    (prefixlen || (prefix && *prefix)))
@@ -236,7 +240,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 				     elt, ce_len, ce->name);
 		}
=20
-	if (literal_global)
+	if (magic & PATHSPEC_LITERAL)
 		item->nowildcard_len =3D item->len;
 	else {
 		item->nowildcard_len =3D simple_length(item->match);
@@ -402,7 +406,8 @@ const char **get_pathspec(const char *prefix, const=
 char **pathspec)
 {
 	struct pathspec ps;
 	parse_pathspec(&ps,
-		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
+		       PATHSPEC_ALL_MAGIC &
+		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, pathspec);
 	return ps._raw;
diff --git a/pathspec.h b/pathspec.h
index 7ef9896..987d70c 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -4,9 +4,11 @@
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP	(1<<0)
 #define PATHSPEC_MAXDEPTH	(1<<1)
+#define PATHSPEC_LITERAL	(1<<2)
 #define PATHSPEC_ALL_MAGIC	  \
 	(PATHSPEC_FROMTOP	| \
-	 PATHSPEC_MAXDEPTH)
+	 PATHSPEC_MAXDEPTH	| \
+	 PATHSPEC_LITERAL)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index 39ef619..49c148e 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -47,18 +47,36 @@ test_expect_success 'no-glob option matches literal=
ly (vanilla)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'no-glob option matches literally (vanilla)' '
+	echo vanilla >expect &&
+	git log --format=3D%s -- ":(literal)foo" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no-glob option matches literally (star)' '
 	echo star >expect &&
 	git --literal-pathspecs log --format=3D%s -- "f*" >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success 'no-glob option matches literally (star)' '
+	echo star >expect &&
+	git log --format=3D%s -- ":(literal)f*" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no-glob option matches literally (bracket)' '
 	echo bracket >expect &&
 	git --literal-pathspecs log --format=3D%s -- "f[o][o]" >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success 'no-glob option matches literally (bracket)' '
+	echo bracket >expect &&
+	git log --format=3D%s -- ":(literal)f[o][o]" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no-glob environment variable works' '
 	echo star >expect &&
 	GIT_LITERAL_PATHSPECS=3D1 git log --format=3D%s -- "f*" >actual &&
diff --git a/tree-diff.c b/tree-diff.c
index 21a50d8..ccf9d7c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -202,7 +202,7 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	 * path. Magic that matches more than one path is not
 	 * supported.
 	 */
-	GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP);
+	GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
 #if 0
 	/*
 	 * We should reject wildcards as well. Unfortunately we
diff --git a/tree-walk.c b/tree-walk.c
index 37b157e..676bd7f 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -636,7 +636,10 @@ enum interesting tree_entry_interesting(const stru=
ct name_entry *entry,
 	enum interesting never_interesting =3D ps->has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
=20
-	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
+	GUARD_PATHSPEC(ps,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_MAXDEPTH |
+		       PATHSPEC_LITERAL);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
--=20
1.8.2.83.gc99314b
