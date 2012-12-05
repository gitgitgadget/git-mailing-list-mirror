From: "=?iso-8859-1?q?Jean-No=EBl?= AVILA" <avila.jn@gmail.com>
Subject: [PATCH] Add directory pattern matching to attributes
Date: Wed, 5 Dec 2012 23:15:34 +0100
Message-ID: <201212052315.35004.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 23:16:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgNG7-00042L-It
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 23:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab2LEWPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 17:15:44 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:33293 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017Ab2LEWPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 17:15:42 -0500
Received: from coriandre.localnet (unknown [IPv6:2a01:e35:2ef1:f910:216:6fff:fe38:e8a3])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1C6CB94001B
	for <git@vger.kernel.org>; Wed,  5 Dec 2012 23:15:36 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211141>

The manpage of gitattributes says: "The rules how the pattern
matches paths are the same as in .gitignore files" and the gitignore
pattern rules has a pattern ending with / for directory matching.

This rule is specifically relevant for the 'export-ignore' rule used
for git archive.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 archive.c                       |    2 +-
 attr.c                          |   47 ++++++++++++++++++++++++-------------
 attr.h                          |    4 ++--
 builtin/check-attr.c            |    7 ++++--
 builtin/pack-objects.c          |    2 +-
 convert.c                       |    2 +-
 ll-merge.c                      |    4 ++--
 t/t5002-archive-attr-pattern.sh |   49 +++++++++++++++++++++++++++++++++++++++
 userdiff.c                      |    2 +-
 ws.c                            |    2 +-
 10 files changed, 94 insertions(+), 27 deletions(-)
 create mode 100644 t/t5002-archive-attr-pattern.sh

diff --git a/archive.c b/archive.c
index 4666404..b8ff14f 100644
--- a/archive.c
+++ b/archive.c
@@ -123,7 +123,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	path_without_prefix = path.buf + args->baselen;
 
 	setup_archive_check(check);
-	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
+	if (!git_check_attr(path_without_prefix, mode, ARRAY_SIZE(check), check)) {
 		if (ATTR_TRUE(check[0].value))
 			return 0;
 		args->convert = ATTR_TRUE(check[1].value);
diff --git a/attr.c b/attr.c
index 887a9ae..da386f2 100644
--- a/attr.c
+++ b/attr.c
@@ -548,7 +548,7 @@ static void bootstrap_attr_stack(void)
 	attr_stack = elem;
 }
 
-static void prepare_attr_stack(const char *path)
+static void prepare_attr_stack(const char *path, unsigned mode)
 {
 	struct attr_stack *elem, *info;
 	int dirlen, len;
@@ -645,28 +645,43 @@ static void prepare_attr_stack(const char *path)
 }
 
 static int path_matches(const char *pathname, int pathlen,
-			const char *pattern,
+			const unsigned mode, char *pattern,
 			const char *base, int baselen)
 {
-	if (!strchr(pattern, '/')) {
+	size_t len;
+	char buf[PATH_MAX];
+	char * lpattern = buf;
+	len = strlen(pattern);
+	if (PATH_MAX <= len)
+		return 0;
+	strncpy(buf,pattern,len);
+	buf[len] ='\0';
+	if (len && lpattern[len - 1] == '/') {
+		if (S_ISDIR(mode))
+			lpattern[len - 1] = '\0';
+		else
+			return 0;
+	}
+
+	if (!strchr(lpattern, '/')) {
 		/* match basename */
 		const char *basename = strrchr(pathname, '/');
 		basename = basename ? basename + 1 : pathname;
-		return (fnmatch_icase(pattern, basename, 0) == 0);
+		return (fnmatch_icase(lpattern, basename, 0) == 0);
 	}
 	/*
 	 * match with FNM_PATHNAME; the pattern has base implicitly
 	 * in front of it.
 	 */
-	if (*pattern == '/')
-		pattern++;
+	if (*lpattern == '/')
+		lpattern++;
 	if (pathlen < baselen ||
 	    (baselen && pathname[baselen] != '/') ||
 	    strncmp(pathname, base, baselen))
 		return 0;
 	if (baselen != 0)
 		baselen++;
-	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) == 0;
+	return fnmatch_icase(lpattern, pathname + baselen, FNM_PATHNAME) == 0;
 }
 
 static int macroexpand_one(int attr_nr, int rem);
@@ -693,7 +708,7 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 	return rem;
 }
 
-static int fill(const char *path, int pathlen, struct attr_stack *stk, int rem)
+static int fill(const char *path, int pathlen, unsigned mode, struct attr_stack *stk, int rem)
 {
 	int i;
 	const char *base = stk->origin ? stk->origin : "";
@@ -702,7 +717,7 @@ static int fill(const char *path, int pathlen, struct attr_stack *stk, int rem)
 		struct match_attr *a = stk->attrs[i];
 		if (a->is_macro)
 			continue;
-		if (path_matches(path, pathlen,
+		if (path_matches(path, pathlen, mode,
 				 a->u.pattern, base, strlen(base)))
 			rem = fill_one("fill", a, rem);
 	}
@@ -737,26 +752,26 @@ static int macroexpand_one(int attr_nr, int rem)
  * Collect all attributes for path into the array pointed to by
  * check_all_attr.
  */
-static void collect_all_attrs(const char *path)
+static void collect_all_attrs(const char *path, unsigned mode)
 {
 	struct attr_stack *stk;
 	int i, pathlen, rem;
 
-	prepare_attr_stack(path);
+	prepare_attr_stack(path, mode);
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
 	pathlen = strlen(path);
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, stk, rem);
+		rem = fill(path, pathlen, mode, stk, rem);
 }
 
-int git_check_attr(const char *path, int num, struct git_attr_check *check)
+int git_check_attr(const char *path, unsigned mode, int num, struct git_attr_check *check)
 {
 	int i;
 
-	collect_all_attrs(path);
+	collect_all_attrs(path, mode);
 
 	for (i = 0; i < num; i++) {
 		const char *value = check_all_attr[check[i].attr->attr_nr].value;
@@ -768,11 +783,11 @@ int git_check_attr(const char *path, int num, struct git_attr_check *check)
 	return 0;
 }
 
-int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
+int git_all_attrs(const char *path, unsigned mode, int *num, struct git_attr_check **check)
 {
 	int i, count, j;
 
-	collect_all_attrs(path);
+	collect_all_attrs(path, mode);
 
 	/* Count the number of attributes that are set. */
 	count = 0;
diff --git a/attr.h b/attr.h
index 8b08d33..125d9c2 100644
--- a/attr.h
+++ b/attr.h
@@ -36,7 +36,7 @@ struct git_attr_check {
  */
 char *git_attr_name(struct git_attr *);
 
-int git_check_attr(const char *path, int, struct git_attr_check *);
+int git_check_attr(const char *path, unsigned mode, int, struct git_attr_check *);
 
 /*
  * Retrieve all attributes that apply to the specified path.  *num
@@ -45,7 +45,7 @@ int git_check_attr(const char *path, int, struct git_attr_check *);
  * objects describing the attributes and their values.  *check must be
  * free()ed by the caller.
  */
-int git_all_attrs(const char *path, int *num, struct git_attr_check **check);
+int git_all_attrs(const char *path, unsigned mode, int *num, struct git_attr_check **check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 075d01d..2928480 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -46,14 +46,17 @@ static void output_attr(int cnt, struct git_attr_check *check,
 static void check_attr(const char *prefix, int cnt,
 	struct git_attr_check *check, const char *file)
 {
+	struct stat st;
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
+	stat(full_path,&st);
 	if (check != NULL) {
-		if (git_check_attr(full_path, cnt, check))
+		stat(full_path,&st);
+		if (git_check_attr(full_path, st.st_mode, cnt, check))
 			die("git_check_attr died");
 		output_attr(cnt, check, file);
 	} else {
-		if (git_all_attrs(full_path, &cnt, &check))
+		if (git_all_attrs(full_path, st.st_mode, &cnt, &check))
 			die("git_all_attrs died");
 		output_attr(cnt, check, file);
 		free(check);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5e14064..acf75d4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -894,7 +894,7 @@ static int no_try_delta(const char *path)
 	struct git_attr_check check[1];
 
 	setup_delta_attr_check(check);
-	if (git_check_attr(path, ARRAY_SIZE(check), check))
+	if (git_check_attr(path, 0, ARRAY_SIZE(check), check))
 		return 0;
 	if (ATTR_FALSE(check->value))
 		return 1;
diff --git a/convert.c b/convert.c
index 6602155..e01c290 100644
--- a/convert.c
+++ b/convert.c
@@ -759,7 +759,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
+	if (!git_check_attr(path, 0, NUM_CONV_ATTRS, ccheck)) {
 		ca->crlf_action = git_path_check_crlf(path, ccheck + 4);
 		if (ca->crlf_action == CRLF_GUESS)
 			ca->crlf_action = git_path_check_crlf(path, ccheck + 0);
diff --git a/ll-merge.c b/ll-merge.c
index acea33b..a8d3b2a 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -346,7 +346,7 @@ static int git_path_check_merge(const char *path, struct git_attr_check check[2]
 		check[0].attr = git_attr("merge");
 		check[1].attr = git_attr("conflict-marker-size");
 	}
-	return git_check_attr(path, 2, check);
+	return git_check_attr(path, 0, 2, check);
 }
 
 static void normalize_file(mmfile_t *mm, const char *path)
@@ -403,7 +403,7 @@ int ll_merge_marker_size(const char *path)
 
 	if (!check.attr)
 		check.attr = git_attr("conflict-marker-size");
-	if (!git_check_attr(path, 1, &check) && check.value) {
+	if (!git_check_attr(path, 0, 1, &check) && check.value) {
 		marker_size = atoi(check.value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
new file mode 100644
index 0000000..3274057
--- /dev/null
+++ b/t/t5002-archive-attr-pattern.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='git archive attribute pattern tests'
+
+. ./test-lib.sh
+
+test_expect_exists() {
+	test_expect_success " $1 exists" "test -e $1"
+}
+
+test_expect_missing() {
+	test_expect_success " $1 does not exist" "test ! -e $1"
+}
+
+test_expect_success 'setup' '
+	echo ignored >ignored &&
+	echo ignored export-ignore >>.git/info/attributes &&
+	git add ignored &&
+
+	mkdir not-ignored-dir &&
+	echo ignored-in-tree >not-ignored-dir/ignored &&
+	echo not-ignored-in-tree >not-ignored-dir/not-ignored &&
+	git add not-ignored-dir &&
+
+	mkdir ignored-dir &&
+	echo ignored by ignored dir >ignored-dir/ignored-by-ignored-dir &&
+	echo ignored-dir/ export-ignore >>.git/info/attributes &&
+	git add ignored-dir &&
+
+	git commit -m. &&
+
+	git clone --bare . bare &&
+	cp .git/info/attributes bare/info/attributes
+'
+
+test_expect_success 'git archive' '
+	git archive HEAD >archive.tar &&
+	(mkdir archive && cd archive && "$TAR" xf -) <archive.tar
+'
+
+test_expect_missing	archive/ignored
+test_expect_missing	archive/not-ignored-dir/ignored
+test_expect_exists	archive/not-ignored-dir/not-ignored
+test_expect_exists	archive/not-ignored-dir/
+test_expect_missing	archive/ignored-dir/
+test_expect_missing	archive/ignored-dir/ignored-by-ignored-dir
+
+
+test_done
diff --git a/userdiff.c b/userdiff.c
index ed958ef..2faec37 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -275,7 +275,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 
 	if (!path)
 		return NULL;
-	if (git_check_attr(path, 1, &check))
+	if (git_check_attr(path, 0, 1, &check))
 		return NULL;
 
 	if (ATTR_TRUE(check.value))
diff --git a/ws.c b/ws.c
index b498d75..f122451 100644
--- a/ws.c
+++ b/ws.c
@@ -88,7 +88,7 @@ unsigned whitespace_rule(const char *pathname)
 	struct git_attr_check attr_whitespace_rule;
 
 	setup_whitespace_attr_check(&attr_whitespace_rule);
-	if (!git_check_attr(pathname, 1, &attr_whitespace_rule)) {
+	if (!git_check_attr(pathname, 0, 1, &attr_whitespace_rule)) {
 		const char *value;
 
 		value = attr_whitespace_rule.value;
-- 
1.7.10.4
