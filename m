From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <avila.jn@gmail.com>
Subject: [PATCH v2] Add directory pattern matching to attributes
Date: Wed, 19 Dec 2012 22:33:52 +0100
Message-ID: <201212192233.53002.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 22:34:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlRHQ-0003s8-Am
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 22:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195Ab2LSVeC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 16:34:02 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:44219 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009Ab2LSVeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 16:34:01 -0500
Received: from coriandre.localnet (unknown [IPv6:2a01:e35:2ef1:f910:216:6fff:fe38:e8a3])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 35C5994019C
	for <git@vger.kernel.org>; Wed, 19 Dec 2012 22:33:54 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211850>

The manpage of gitattributes says: "The rules how the pattern
matches paths are the same as in .gitignore files" and the gitignore
pattern matching has a pattern ending with / for directory matching.

This rule is specifically relevant for the 'export-ignore' rule used
for git archive.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
This patch was not reviewed when I submitted it for the second time. Is there
any pending work which prevents it from being merged?

 archive.c                       |    3 ++-
 attr.c                          |   32 ++++++++++++++++------
 t/t5002-archive-attr-pattern.sh |   57 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 9 deletions(-)
 create mode 100644 t/t5002-archive-attr-pattern.sh

diff --git a/archive.c b/archive.c
index 4666404..93e00bb 100644
--- a/archive.c
+++ b/archive.c
@@ -120,6 +120,8 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	strbuf_add(&path, args->base, args->baselen);
 	strbuf_add(&path, base, baselen);
 	strbuf_addstr(&path, filename);
+	if (S_ISDIR(mode) || S_ISGITLINK(mode))
+		strbuf_addch(&path, '/');
 	path_without_prefix = path.buf + args->baselen;
 
 	setup_archive_check(check);
@@ -130,7 +132,6 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-		strbuf_addch(&path, '/');
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
 		err = write_entry(args, sha1, path.buf, path.len, mode);
diff --git a/attr.c b/attr.c
index 097ae87..cdba88a 100644
--- a/attr.c
+++ b/attr.c
@@ -564,17 +564,31 @@ static void bootstrap_attr_stack(void)
 	attr_stack = elem;
 }
 
+static const char *find_basename(const char *path)
+{
+	char pathbuf[PATH_MAX];
+	int pathlen;
+	const char *cp;
+
+	pathlen =strlen(path);
+	if (path[pathlen-1] != '/') {
+		cp =strrchr(path, '/');
+		return cp ? cp + 1: path;
+	} else {
+		strncpy(pathbuf, path, pathlen);
+		pathbuf[pathlen-1] = '\0';
+		cp =strrchr(pathbuf, '/');
+		return cp ? path + (cp - pathbuf) + 1 : path;
+	}
+}
+
 static void prepare_attr_stack(const char *path)
 {
 	struct attr_stack *elem, *info;
 	int dirlen, len;
 	const char *cp;
 
-	cp = strrchr(path, '/');
-	if (!cp)
-		dirlen = 0;
-	else
-		dirlen = cp - path;
+	dirlen = find_basename(path) - path;
 
 	/*
 	 * At the bottom of the attribute stack is the built-in
@@ -668,6 +682,10 @@ static int path_matches(const char *pathname, int pathlen,
 	const char *pattern = pat->pattern;
 	int prefix = pat->nowildcardlen;
 
+	if ((pat->flags & EXC_FLAG_MUSTBEDIR) &&
+	    ((!pathlen) || (pathname[pathlen-1] != '/')))
+		return 0;
+
 	if (pat->flags & EXC_FLAG_NODIR) {
 		return match_basename(basename,
 				      pathlen - (basename - pathname),
@@ -758,9 +776,7 @@ static void collect_all_attrs(const char *path)
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
-	basename = strrchr(path, '/');
-	basename = basename ? basename + 1 : path;
-
+	basename = find_basename(path);
 	pathlen = strlen(path);
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
new file mode 100644
index 0000000..0c847fb
--- /dev/null
+++ b/t/t5002-archive-attr-pattern.sh
@@ -0,0 +1,57 @@
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
+	echo not-ignored-in-tree >not-ignored-dir/ignored-only-if-dir &&
+	git add not-ignored-dir &&
+
+	mkdir ignored-only-if-dir &&
+	echo ignored by ignored dir >ignored-only-if-dir/ignored-by-ignored-dir &&
+	echo ignored-only-if-dir/ export-ignore >>.git/info/attributes &&
+	git add ignored-only-if-dir &&
+
+
+	mkdir -p one-level-lower/two-levels-lower/ignored-only-if-dir &&
+	echo ignored by ignored dir >one-level-lower/two-levels-lower/ignored-only-if-dir/ignored-by-ignored-dir &&
+	git add one-level-lower &&
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
+test_expect_exists	archive/not-ignored-dir/ignored-only-if-dir
+test_expect_exists	archive/not-ignored-dir/
+test_expect_missing	archive/ignored-only-if-dir/
+test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
+test_expect_exists	archive/one-level-lower/
+test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-only-if-dir/
+test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-ony-if-dir/ignored-by-ignored-dir
+
+
+test_done
-- 
1.7.10.4
