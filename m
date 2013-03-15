From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 42/45] pathspec: support :(literal) syntax for noglob pathspec
Date: Fri, 15 Mar 2013 13:06:57 +0700
Message-ID: <1363327620-29017-43-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:29:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO8l-0008PN-WA
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718Ab3COG2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:28:53 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:60609 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab3COG2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:28:52 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so4019410ieb.31
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=M0qEL60EiXtmP3D2pE8bvBAXXJ/cidxmGbVOeElvsgs=;
        b=iCmUnOqlhwnDf5b0u7gB+LWgWRLMCQoXM/qGBph6p5Seb1kDdzWwLgdfxtgOjYWfJ0
         9oxsenZjE+lU85ZSlusHM8nBOSO7MC1fw2zMybFxX/I7Wjd6JiP1jptQKWF1W3hwovkx
         Qs4tCbDSobkaioLShRk69C3CALqnJC+ET0+vScYvtAD36Y2ndZaxLkx7bYUS+EKmtVAq
         A9qkkJQ/yWV3rWawBq7MoGhQ4ysumyxZ34K4O5Dp6e3N8pwAfnO51+z9wL9wHvlE2COe
         4d6lH9sZzvVQQsWFcP3vJJm/bq1ZeryukBYZMjCSJ6Gyjy7cz8e5687WW1S7Z+6TX4Aq
         ONOg==
X-Received: by 10.50.45.166 with SMTP id o6mr461168igm.78.1363328932308;
        Thu, 14 Mar 2013 23:28:52 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id s8sm765830igs.0.2013.03.14.23.28.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:28:51 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:11:54 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218229>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/glossary-content.txt |  4 ++++
 builtin/add.c                      |  2 +-
 builtin/diff.c                     |  2 +-
 dir.c                              | 15 ++++++++++++---
 pathspec.c                         | 11 ++++++++---
 pathspec.h                         |  4 +++-
 t/t6130-pathspec-noglob.sh         | 18 ++++++++++++++++++
 tree-diff.c                        |  2 +-
 tree-walk.c                        |  5 ++++-
 9 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index eb7ba84..8b91aeb 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -323,6 +323,10 @@ top `/`;;
 	The magic word `top` (mnemonic: `/`) makes the pattern match
 	from the root of the working tree, even when you are running
 	the command from inside a subdirectory.
+
+literal;;
+	Wildcards in the pattern such as `*` or `?` are treated
+	as literal characters.
 --
 +
 Currently only the slash `/` is recognized as the "magic signature",
diff --git a/builtin/add.c b/builtin/add.c
index aa0709e..8bc6b45 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -426,7 +426,7 @@ int cmd_add(int argc, const char **argv, const char=
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
index 6b4e3f9..b78435f 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -372,7 +372,7 @@ int cmd_diff(int argc, const char **argv, const cha=
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
index 4f5a2c9..8d9ed24 100644
--- a/dir.c
+++ b/dir.c
@@ -65,7 +65,10 @@ static size_t common_prefix_len(const struct pathspe=
c *pathspec)
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
@@ -189,7 +192,10 @@ int match_pathspec_depth(const struct pathspec *ps=
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
@@ -1338,7 +1344,10 @@ int read_directory(struct dir_struct *dir, const=
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
index 7b3dfc0..e57196d 100644
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
@@ -163,6 +166,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
=20
 	magic |=3D short_magic;
 	*p_short_magic =3D short_magic;
+	magic |=3D global_magic;
=20
 	if (pathspec_prefix >=3D 0 &&
 	    (prefixlen || (prefix && *prefix)))
@@ -235,7 +239,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 				     elt, ce_len, ce->name);
 		}
=20
-	if (literal_global)
+	if (magic & PATHSPEC_LITERAL)
 		item->nowildcard_len =3D item->len;
 	else {
 		item->nowildcard_len =3D simple_length(item->match);
@@ -395,7 +399,8 @@ const char **get_pathspec(const char *prefix, const=
 char **pathspec)
 {
 	struct pathspec ps;
 	parse_pathspec(&ps,
-		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
+		       PATHSPEC_ALL_MAGIC &
+		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, pathspec);
 	return ps.raw;
diff --git a/pathspec.h b/pathspec.h
index 8f339a5..d5db7d5 100644
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
1.8.0.rc0.19.g7bbb31d
