From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 42/45] pathspec: support :(literal) syntax for noglob pathspec
Date: Sun,  9 Jun 2013 13:26:15 +0700
Message-ID: <1370759178-1709-43-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:29:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ86-00023m-08
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab3FIG30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:29:26 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:47089 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab3FIG3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:29:25 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so6306544pdd.20
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Dm43ZmQP0tf8LPWqj+bjHaVGVAupIgdHoBDRTFbcQ5o=;
        b=fiA7QElFczOv+3efj0pDtKXD9IAEphhfMRFZYjk6LtgTkwQprLwomudS8W5l1AXVCP
         jOo15DchVT1oW67jglPcg/2rh+1JFdp8SnGiDTM9wo0m3cUXNx0y5OuWAdkf68CwMD7r
         GNJQOTTSdS4SXXbD5HcKXOrzc88ZeTK01jEq4VB6vcfOWEVe+Y6bhPclF2Xg2kPykOH3
         yzDnx4d1Gwc39MFM2bHIwmvz3yYDxrbKF0JyIVTz7jvyJv0d9ACgVTXqS67A7hOORphV
         lP8SjB0N/t4HBpwmK5BqJ/KT10qEpsL3ebvNjw6AK5WejpDfSgb2yJ++ZhrCcu5zliWp
         ONqQ==
X-Received: by 10.68.182.33 with SMTP id eb1mr5120202pbc.186.1370759364560;
        Sat, 08 Jun 2013 23:29:24 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id k3sm5533163pbc.23.2013.06.08.23.29.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:29:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:30:55 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226934>


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
index db2a74d..186b566 100644
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
index 76a2e1a..65cac36 100644
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
@@ -1290,7 +1296,10 @@ int read_directory(struct dir_struct *dir, const=
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
index 69adaba..cc6545f 100644
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
 	return ps.raw;
diff --git a/pathspec.h b/pathspec.h
index 4ebaadc..ec15fe6 100644
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
