From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] Support pathspec magic :(exclude) and its short form :!
Date: Fri,  6 Dec 2013 14:30:48 +0700
Message-ID: <1386315049-19097-3-git-send-email-pclouds@gmail.com>
References: <1386315049-19097-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 08:26:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vopnr-0005Gd-G0
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 08:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab3LFH0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Dec 2013 02:26:19 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44068 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3LFH0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 02:26:18 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so571168pbb.36
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 23:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xQkjvaF+kbb6zTKVh9pdyAoorf7TslXQ+Ny1/v1F+rI=;
        b=SxTE+Wz08MST55WBPJ5p140edg2w3sozgXpHYdrVz+/NQgiagWXES4Gv56BqLLhuJA
         Gy8A563ehwBx7kQqDCqvsopyjiEhyPw2HG0KmIWMlc7IGNn8HDpZjqRb9MVzaQEyr4x3
         XW7LjoRFBxeCE0Hv1o+BM5fxS+O2J0A+UhcXv5pc4bnDejsiYAqfyzeurUH20bu9s9t/
         DsP+Q4TV/AoIw8caSeVWmm86m085a/oZiKm7DM5ewC/A9V4h03Nk3Xk6uAajmpL1rnNk
         uL9GNON25plwviD9rP3DbrFDzadAza09/oaP0dgsSqjQ9h6na/Da3kQQnCelHjZFwQHi
         exHQ==
X-Received: by 10.68.196.227 with SMTP id ip3mr2428110pbc.163.1386314777628;
        Thu, 05 Dec 2013 23:26:17 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id fk4sm174018747pab.23.2013.12.05.23.26.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 23:26:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Dec 2013 14:31:02 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386315049-19097-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238927>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/glossary-content.txt   |   5 +
 builtin/add.c                        |   5 +-
 dir.c                                |  47 +++++++--
 pathspec.c                           |   9 +-
 pathspec.h                           |   4 +-
 t/t6132-pathspec-exclude.sh (new +x) | 184 +++++++++++++++++++++++++++=
++++++++
 tree-walk.c                          |  83 +++++++++++++++-
 7 files changed, 324 insertions(+), 13 deletions(-)
 create mode 100755 t/t6132-pathspec-exclude.sh

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index b7e7ab5..378306f 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -379,6 +379,11 @@ full pathname may have special meaning:
  - Other consecutive asterisks are considered invalid.
 +
 Glob magic is incompatible with literal magic.
+
+exclude;;
+	After a path matches any non-exclude pathspec, it will be run
+	through all exclude pathspec (magic signature: `!`). If it
+	matches, the path is ignored.
 --
=20
 [[def_parent]]parent::
diff --git a/builtin/add.c b/builtin/add.c
index 226f758..0df73ae 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -540,10 +540,13 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 			       PATHSPEC_FROMTOP |
 			       PATHSPEC_LITERAL |
 			       PATHSPEC_GLOB |
-			       PATHSPEC_ICASE);
+			       PATHSPEC_ICASE |
+			       PATHSPEC_EXCLUDE);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
+			if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
+				continue;
 			if (!seen[i] &&
 			    ((pathspec.items[i].magic &
 			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
diff --git a/dir.c b/dir.c
index 23b6de4..d10a63f 100644
--- a/dir.c
+++ b/dir.c
@@ -126,10 +126,13 @@ static size_t common_prefix_len(const struct path=
spec *pathspec)
 		       PATHSPEC_MAXDEPTH |
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
-		       PATHSPEC_ICASE);
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
=20
 	for (n =3D 0; n < pathspec->nr; n++) {
 		size_t i =3D 0, len =3D 0, item_len;
+		if (pathspec->items[n].magic & PATHSPEC_EXCLUDE)
+			continue;
 		if (pathspec->items[n].magic & PATHSPEC_ICASE)
 			item_len =3D pathspec->items[n].prefix;
 		else
@@ -279,9 +282,10 @@ static int match_pathspec_item(const struct pathsp=
ec_item *item, int prefix,
  * pathspec did not match any names, which could indicate that the
  * user mistyped the nth pathspec.
  */
-int match_pathspec_depth(const struct pathspec *ps,
-			 const char *name, int namelen,
-			 int prefix, char *seen)
+static int match_pathspec_depth_1(const struct pathspec *ps,
+				  const char *name, int namelen,
+				  int prefix, char *seen,
+				  int exclude)
 {
 	int i, retval =3D 0;
=20
@@ -290,7 +294,8 @@ int match_pathspec_depth(const struct pathspec *ps,
 		       PATHSPEC_MAXDEPTH |
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
-		       PATHSPEC_ICASE);
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -309,8 +314,19 @@ int match_pathspec_depth(const struct pathspec *ps=
,
=20
 	for (i =3D ps->nr - 1; i >=3D 0; i--) {
 		int how;
+
+		if ((!exclude &&   ps->items[i].magic & PATHSPEC_EXCLUDE) ||
+		    ( exclude && !(ps->items[i].magic & PATHSPEC_EXCLUDE)))
+			continue;
+
 		if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
 			continue;
+		/*
+		 * Make exclude patterns optional and never report
+		 * "pathspec ':(exclude)foo' matches no files"
+		 */
+		if (seen && ps->items[i].magic & PATHSPEC_EXCLUDE)
+			seen[i] =3D MATCHED_FNMATCH;
 		how =3D match_pathspec_item(ps->items+i, prefix, name, namelen);
 		if (ps->recursive &&
 		    (ps->magic & PATHSPEC_MAXDEPTH) &&
@@ -334,6 +350,18 @@ int match_pathspec_depth(const struct pathspec *ps=
,
 	return retval;
 }
=20
+int match_pathspec_depth(const struct pathspec *ps,
+			 const char *name, int namelen,
+			 int prefix, char *seen)
+{
+	int positive, negative;
+	positive =3D match_pathspec_depth_1(ps, name, namelen, prefix, seen, =
0);
+	if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
+		return positive;
+	negative =3D match_pathspec_depth_1(ps, name, namelen, prefix, seen, =
1);
+	return negative ? 0 : positive;
+}
+
 /*
  * Return the length of the "simple" part of a path match limiter.
  */
@@ -1375,11 +1403,18 @@ int read_directory(struct dir_struct *dir, cons=
t char *path, int len, const stru
 			       PATHSPEC_MAXDEPTH |
 			       PATHSPEC_LITERAL |
 			       PATHSPEC_GLOB |
-			       PATHSPEC_ICASE);
+			       PATHSPEC_ICASE |
+			       PATHSPEC_EXCLUDE);
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
=20
+	/*
+	 * exclude patterns are treated like positive ones in
+	 * create_simplify. Usually exclude patterns should be a
+	 * subset of positive ones, which has no impacts on
+	 * create_simplify().
+	 */
 	simplify =3D create_simplify(pathspec ? pathspec->_raw : NULL);
 	if (!len || treat_leading_path(dir, path, len, simplify))
 		read_directory_recursive(dir, path, len, 0, simplify);
diff --git a/pathspec.c b/pathspec.c
index 87b3b82..4e6a727 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -71,6 +71,7 @@ static struct pathspec_magic {
 	{ PATHSPEC_LITERAL,   0, "literal" },
 	{ PATHSPEC_GLOB,   '\0', "glob" },
 	{ PATHSPEC_ICASE,  '\0', "icase" },
+	{ PATHSPEC_EXCLUDE, '!', "exclude" },
 };
=20
 /*
@@ -355,7 +356,7 @@ void parse_pathspec(struct pathspec *pathspec,
 {
 	struct pathspec_item *item;
 	const char *entry =3D argv ? *argv : NULL;
-	int i, n, prefixlen;
+	int i, n, prefixlen, nr_exclude =3D 0;
=20
 	memset(pathspec, 0, sizeof(*pathspec));
=20
@@ -412,6 +413,8 @@ void parse_pathspec(struct pathspec *pathspec,
 		if ((flags & PATHSPEC_LITERAL_PATH) &&
 		    !(magic_mask & PATHSPEC_LITERAL))
 			item[i].magic |=3D PATHSPEC_LITERAL;
+		if (item[i].magic & PATHSPEC_EXCLUDE)
+			nr_exclude++;
 		if (item[i].magic & magic_mask)
 			unsupported_magic(entry,
 					  item[i].magic & magic_mask,
@@ -427,6 +430,10 @@ void parse_pathspec(struct pathspec *pathspec,
 		pathspec->magic |=3D item[i].magic;
 	}
=20
+	if (nr_exclude =3D=3D n)
+		die(_("There is nothing to exclude from by :(exclude) patterns.\n"
+		      "Perhaps you forgot to add either ':/' or '.' ?"));
+
=20
 	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
 		if (flags & PATHSPEC_KEEP_ORDER)
diff --git a/pathspec.h b/pathspec.h
index a75e924..0c11262 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -7,12 +7,14 @@
 #define PATHSPEC_LITERAL	(1<<2)
 #define PATHSPEC_GLOB		(1<<3)
 #define PATHSPEC_ICASE		(1<<4)
+#define PATHSPEC_EXCLUDE	(1<<5)
 #define PATHSPEC_ALL_MAGIC	  \
 	(PATHSPEC_FROMTOP	| \
 	 PATHSPEC_MAXDEPTH	| \
 	 PATHSPEC_LITERAL	| \
 	 PATHSPEC_GLOB		| \
-	 PATHSPEC_ICASE)
+	 PATHSPEC_ICASE		| \
+	 PATHSPEC_EXCLUDE)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONES=
TAR */
=20
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
new file mode 100755
index 0000000..62049be
--- /dev/null
+++ b/t/t6132-pathspec-exclude.sh
@@ -0,0 +1,184 @@
+#!/bin/sh
+
+test_description=3D'test case exclude pathspec'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	for p in file sub/file sub/sub/file sub/file2 sub/sub/sub/file sub2/f=
ile; do
+		if echo $p | grep /; then
+			mkdir -p `dirname $p`
+		fi &&
+		: >$p &&
+		git add $p &&
+		git commit -m $p
+	done &&
+	git log --oneline --format=3D%s >actual &&
+	cat <<EOF >expect &&
+sub2/file
+sub/sub/sub/file
+sub/file2
+sub/sub/file
+sub/file
+file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'exclude only should error out' '
+	test_must_fail git log --oneline --format=3D%s -- ":(exclude)sub"
+'
+
+test_expect_success 't_e_i() exclude sub' '
+	git log --oneline --format=3D%s -- . ":(exclude)sub" >actual
+	cat <<EOF >expect &&
+sub2/file
+file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 't_e_i() exclude sub/sub/file' '
+	git log --oneline --format=3D%s -- . ":(exclude)sub/sub/file" >actual
+	cat <<EOF >expect &&
+sub2/file
+sub/sub/sub/file
+sub/file2
+sub/file
+file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 't_e_i() exclude sub using mnemonic' '
+	git log --oneline --format=3D%s -- . ":!sub" >actual
+	cat <<EOF >expect &&
+sub2/file
+file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 't_e_i() exclude :(icase)SUB' '
+	git log --oneline --format=3D%s -- . ":(exclude,icase)SUB" >actual
+	cat <<EOF >expect &&
+sub2/file
+file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 't_e_i() exclude sub2 from sub' '
+	(
+	cd sub &&
+	git log --oneline --format=3D%s -- :/ ":/!sub2" >actual
+	cat <<EOF >expect &&
+sub/sub/sub/file
+sub/file2
+sub/sub/file
+sub/file
+file
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 't_e_i() exclude sub/*file' '
+	git log --oneline --format=3D%s -- . ":(exclude)sub/*file" >actual
+	cat <<EOF >expect &&
+sub2/file
+sub/file2
+file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 't_e_i() exclude :(glob)sub/*/file' '
+	git log --oneline --format=3D%s -- . ":(exclude,glob)sub/*/file" >act=
ual
+	cat <<EOF >expect &&
+sub2/file
+sub/sub/sub/file
+sub/file2
+sub/file
+file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'm_p_d() exclude sub' '
+	git ls-files -- . ":(exclude)sub" >actual
+	cat <<EOF >expect &&
+file
+sub2/file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'm_p_d() exclude sub/sub/file' '
+	git ls-files -- . ":(exclude)sub/sub/file" >actual
+	cat <<EOF >expect &&
+file
+sub/file
+sub/file2
+sub/sub/sub/file
+sub2/file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'm_p_d() exclude sub using mnemonic' '
+	git ls-files -- . ":!sub" >actual
+	cat <<EOF >expect &&
+file
+sub2/file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'm_p_d() exclude :(icase)SUB' '
+	git ls-files -- . ":(exclude,icase)SUB" >actual
+	cat <<EOF >expect &&
+file
+sub2/file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'm_p_d() exclude sub2 from sub' '
+	(
+	cd sub &&
+	git ls-files -- :/ ":/!sub2" >actual
+	cat <<EOF >expect &&
+../file
+file
+file2
+sub/file
+sub/sub/file
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'm_p_d() exclude sub/*file' '
+	git ls-files -- . ":(exclude)sub/*file" >actual
+	cat <<EOF >expect &&
+file
+sub/file2
+sub2/file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'm_p_d() exclude :(glob)sub/*/file' '
+	git ls-files -- . ":(exclude,glob)sub/*/file" >actual
+	cat <<EOF >expect &&
+file
+sub/file
+sub/file2
+sub/sub/sub/file
+sub2/file
+EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/tree-walk.c b/tree-walk.c
index 5ece8c3..680afda 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -662,9 +662,10 @@ static int match_wildcard_base(const struct pathsp=
ec_item *item,
  * Pre-condition: either baselen =3D=3D base_offset (i.e. empty path)
  * or base[baselen-1] =3D=3D '/' (i.e. with trailing slash).
  */
-enum interesting tree_entry_interesting(const struct name_entry *entry=
,
-					struct strbuf *base, int base_offset,
-					const struct pathspec *ps)
+static enum interesting do_match(const struct name_entry *entry,
+				 struct strbuf *base, int base_offset,
+				 const struct pathspec *ps,
+				 int exclude)
 {
 	int i;
 	int pathlen, baselen =3D base->len - base_offset;
@@ -676,7 +677,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		       PATHSPEC_MAXDEPTH |
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
-		       PATHSPEC_ICASE);
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -697,6 +699,10 @@ enum interesting tree_entry_interesting(const stru=
ct name_entry *entry,
 		const char *base_str =3D base->buf + base_offset;
 		int matchlen =3D item->len, matched =3D 0;
=20
+		if ((!exclude &&   item->magic & PATHSPEC_EXCLUDE) ||
+		    ( exclude && !(item->magic & PATHSPEC_EXCLUDE)))
+			continue;
+
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
 			if (!match_dir_prefix(item, base_str, match, matchlen))
@@ -782,3 +788,72 @@ match_wildcards:
 	}
 	return never_interesting; /* No matches */
 }
+
+/*
+ * Is a tree entry interesting given the pathspec we have?
+ *
+ * Pre-condition: either baselen =3D=3D base_offset (i.e. empty path)
+ * or base[baselen-1] =3D=3D '/' (i.e. with trailing slash).
+ */
+enum interesting tree_entry_interesting(const struct name_entry *entry=
,
+					struct strbuf *base, int base_offset,
+					const struct pathspec *ps)
+{
+	enum interesting positive, negative;
+	positive =3D do_match(entry, base, base_offset, ps, 0);
+
+	/*
+	 * case | entry | positive | negative | result
+	 * -----+-------+----------+----------+-------
+	 *   1  |  file |   -1     |  -1..2   |  -1
+	 *   2  |  file |    0     |  -1..2   |   0
+	 *   3  |  file |    1     |   -1     |   1
+	 *   4  |  file |    1     |    0     |   1
+	 *   5  |  file |    1     |    1     |   0
+	 *   6  |  file |    1     |    2     |   0
+	 *   7  |  file |    2     |   -1     |   2
+	 *   8  |  file |    2     |    0     |   2
+	 *   9  |  file |    2     |    1     |   0
+	 *  10  |  file |    2     |    2     |  -1
+	 * -----+-------+----------+----------+-------
+	 *  11  |  dir  |   -1     |  -1..2   |  -1
+	 *  12  |  dir  |    0     |  -1..2   |   0
+	 *  13  |  dir  |    1     |   -1     |   1
+	 *  14  |  dir  |    1     |    0     |   1
+	 *  15  |  dir  |    1     |    1     |   1 (*)
+	 *  16  |  dir  |    1     |    2     |   0
+	 *  17  |  dir  |    2     |   -1     |   2
+	 *  18  |  dir  |    2     |    0     |   2
+	 *  19  |  dir  |    2     |    1     |   1 (*)
+	 *  20  |  dir  |    2     |    2     |  -1
+	 *
+	 * (*) An exclude pattern interested in a directory does not
+	 * necessarily mean it will exclude all of the directory. In
+	 * wildcard case, it can't decide until looking at individual
+	 * files inside. So don't write such directories off yet.
+	 */
+
+	if (!(ps->magic & PATHSPEC_EXCLUDE) ||
+	    positive <=3D entry_not_interesting) /* #1, #2, #11, #12 */
+		return positive;
+
+	negative =3D do_match(entry, base, base_offset, ps, 1);
+
+	/* #3, #4, #7, #8, #13, #14, #17, #18 */
+	if (negative <=3D entry_not_interesting)
+		return positive;
+
+	/* #15, #19 */
+	if (S_ISDIR(entry->mode) &&
+	    positive >=3D entry_interesting &&
+	    negative =3D=3D entry_interesting)
+		return entry_interesting;
+
+	if ((positive =3D=3D entry_interesting &&
+	     negative >=3D entry_interesting) || /* #5, #6, #16 */
+	    (positive =3D=3D all_entries_interesting &&
+	     negative =3D=3D entry_interesting)) /* #9 */
+		return entry_not_interesting;
+
+	return all_entries_not_interesting; /* #10, #20 */
+}
--=20
1.8.5.1.25.g8667982
