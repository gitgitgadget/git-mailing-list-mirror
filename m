From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/17] get_pathspec(): support narrow pathspec rewriting
Date: Sun,  5 Sep 2010 16:47:37 +1000
Message-ID: <1283669264-15759-11-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:50:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os935-0008Fe-Ab
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab0IEGtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:49:49 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35545 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab0IEGts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:49:48 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so717333pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=C9/luHT5z7qmElm4FDMy/fsi0bDQ/EO2ysTY9ewg0WU=;
        b=SD4/e+M7vNeUv/FSRA/a4LpdCTWX5AmApvdlUgXE1sVxoAClj3ZhxiXflgNfZoTvfc
         ER+byYU+leARW5YZnL/wg6AggD7u3Gea35mr7zS1DgVgCnqnWg+SPeCeJj74MKwijhEx
         iUR0z6TXa4vmP8Qfl+7iTkt+W/Q5OBv3bYsLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mPtcN7oj1E5NDZe26VchVVf4fiS292se+387k1xtqbjIe+jvHss21Ku85WE97s2OLV
         YA8vPvSdrCCIE8OjJzqw8vS0TZtN9agGum40Dawno0qAVuIqam0NkdPE2bxUDUOwjAgl
         EGSREF4UGiGHwjWIKLFaujfywqJ7FJLIaR1Zw=
Received: by 10.114.66.9 with SMTP id o9mr1932730waa.51.1283669387598;
        Sat, 04 Sep 2010 23:49:47 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id d39sm8036461wam.16.2010.09.04.23.49.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:49:46 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:49:37 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155436>

Operations in a narrow repository would only work if you limit
yourself within narrow area. Usually that means users have to either
stay inside narrow area, or do "git blah blah -- narrow/prefix" so
that git won't step on the line. (Of course that only affects commands
that take pathspec)

Make their life easier by appending narrow prefix automatically, as
long as the given pathspecs are simple enough. In other words, fancy
wildcards might not work.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                 |    1 +
 Makefile                   |    1 +
 cache.h                    |    1 +
 setup.c                    |  172 ++++++++++++++++++++++++++++++++++++=
++++++--
 t/t0062-narrow-pathspec.sh |  150 ++++++++++++++++++++++++++++++++++++=
++
 test-get-pathspec.c        |   17 +++++
 6 files changed, 337 insertions(+), 5 deletions(-)
 create mode 100755 t/t0062-narrow-pathspec.sh
 create mode 100644 test-get-pathspec.c

diff --git a/.gitignore b/.gitignore
index fcdd822..af9bae6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -165,6 +165,7 @@
 /test-delta
 /test-dump-cache-tree
 /test-genrandom
+/test-get-pathspec
 /test-index-version
 /test-match-trees
 /test-parse-options
diff --git a/Makefile b/Makefile
index f1aaba9..3bbb571 100644
--- a/Makefile
+++ b/Makefile
@@ -408,6 +408,7 @@ TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
 TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
 TEST_PROGRAMS_NEED_X +=3D test-genrandom
+TEST_PROGRAMS_NEED_X +=3D test-get-pathspec
 TEST_PROGRAMS_NEED_X +=3D test-match-trees
 TEST_PROGRAMS_NEED_X +=3D test-parse-options
 TEST_PROGRAMS_NEED_X +=3D test-path-utils
diff --git a/cache.h b/cache.h
index 88a2ec6..9c014ef 100644
--- a/cache.h
+++ b/cache.h
@@ -417,6 +417,7 @@ extern void set_git_work_tree(const char *tree);
=20
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
=20
+extern const char **get_pathspec_narrow(const char *prefix, const char=
 **pathspec, int narrow);
 extern const char **get_pathspec(const char *prefix, const char **path=
spec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
diff --git a/setup.c b/setup.c
index 2769160..c19d53d 100644
--- a/setup.c
+++ b/setup.c
@@ -123,20 +123,61 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
 	    "Use '--' to separate filenames from revisions", arg);
 }
=20
-const char **get_pathspec(const char *prefix, const char **pathspec)
+static const char **dup_pathspec(const char **pathspec)
+{
+	const char **p =3D pathspec;
+	int n =3D 1;
+	if (!p)
+		return NULL;
+	while (*p) {
+		n++;
+		p++;
+	}
+	p =3D xmalloc(sizeof(*p)*n);
+	memcpy(p, pathspec, sizeof(*p)*n);
+	return p;
+}
+
+
+const char **get_pathspec_narrow(const char *prefix, const char **path=
spec, int narrow)
 {
 	const char *entry =3D *pathspec;
-	const char **src, **dst;
+	const char **src, **dst, **p;
 	int prefixlen;
+	const char **narrow_prefix =3D narrow ? get_narrow_prefix() : NULL;
+	int ps_hit_count, np_hit_count;
+	int *ps_hitmap, *np_hitmap;
+	int i, n;
+
+	if (!entry && !prefix) {
+		pathspec =3D dup_pathspec(narrow_prefix);
+		goto done;
+	}
=20
-	if (!prefix && !entry)
-		return NULL;
+	/*
+	 * if prefix is also a prefix of narrow_prefix, use
+	 * it. Otherwise just return narrow_prefix
+	 */
+	if (!entry && narrow_prefix) {
+		p =3D narrow_prefix;
+		while (*p) {
+			if (!prefixcmp(prefix, *p))
+				break;
+			p++;
+		}
+		if (!*p) {
+			pathspec =3D dup_pathspec(narrow_prefix);
+			goto done;
+		}
+		/* otherwise fall through */
+	}
=20
 	if (!entry) {
 		static const char *spec[2];
 		spec[0] =3D prefix;
 		spec[1] =3D NULL;
-		return spec;
+		pathspec =3D spec;
+		goto done;
 	}
=20
 	/* Otherwise we have to re-write the entries.. */
@@ -149,11 +190,132 @@ const char **get_pathspec(const char *prefix, co=
nst char **pathspec)
 		src++;
 	}
 	*dst =3D NULL;
+
+	/*
+	 * And filter rewritten entries against narrow_prefix..  The
+	 * rule is, if a prefix is "x" and we have narrow prefix x/y,
+	 * then that prefix is taken out and replaced by x/y. If we
+	 * have two narrow prefix x/y and x/z, both will be in.
+	 */
+	if (narrow_prefix) {
+		for (n =3D 0, p =3D narrow_prefix; *p; p++)
+			n++;
+
+		np_hitmap =3D xmalloc(sizeof(*np_hitmap) * ((n+32)/32));
+		memset(np_hitmap, 0, sizeof(*np_hitmap) * ((n+32)/32));
+		ps_hitmap =3D xmalloc(sizeof(*ps_hitmap) * ((dst-pathspec+32)/32));
+		memset(ps_hitmap, 0, sizeof(*ps_hitmap) * ((dst-pathspec+32)/32));
+
+#define HIT(hitmap, x) hitmap[(x) / 32] |=3D 1 << ((x) % 32)
+#define GOT_HIT(hitmap, x) (hitmap[(x) / 32] & (1 << ((x) % 32)))
+		/*
+		 * Let's see how many narrow prefix we hit, then we
+		 * know if pathspec has enough space, or we need a
+		 * bigger one.
+		 */
+		src =3D pathspec;
+		ps_hit_count =3D 0;
+		/* np_hit_count can't be counted here because one
+		   narrow prefix can be hit many times */
+		while (*src) {
+			int pathspec_hit =3D 0, hit =3D 0;
+			p =3D narrow_prefix;
+			while (*p) {
+				if (!prefixcmp(*p, *src)) {
+					HIT(np_hitmap, p - narrow_prefix);
+					pathspec_hit++;
+				}
+				else if (!prefixcmp(*src, *p)) {
+					/*
+					 * If any of previous pathspec has hit
+					 * a narrow prefix, that narrow prefix
+					 * will be included as a replacement for
+					 * the pathspec. So any other pathspecs
+					 * that are stricter than that pathspec
+					 * is redundant, mark pathspec_hit to remove
+					 * it.
+					 */
+					if (GOT_HIT(np_hitmap, p - narrow_prefix))
+						pathspec_hit++;
+					hit++;
+				}
+				p++;
+			}
+			if (!hit && !pathspec_hit)
+				die("Pathspec %s is outside narrow area", *src);
+			if (pathspec_hit) {
+				HIT(ps_hitmap, src-pathspec);
+				ps_hit_count++;
+			}
+			src++;
+		}
+
+		/* All pathspec is inside narrow area */
+		if (!ps_hit_count)
+			goto done;
+
+		np_hit_count =3D 0;
+		for (i =3D 0; i < n; i++)
+			if (GOT_HIT(np_hitmap, i))
+				np_hit_count++;
+
+		/*
+		 * All pathspec is a prefix of narrow_prefix, or one
+		 * pathspec hits all narrow_prefix, just use
+		 * narrow_prefix instead. Of course we need to check
+		 * what narrow_prefix is hit.
+		 */
+		if (ps_hit_count =3D=3D (dst - pathspec) || n =3D=3D np_hit_count) {
+			pathspec =3D dup_pathspec(narrow_prefix);
+			for (i =3D 0; i < n; i++) {
+				if (GOT_HIT(np_hitmap, i))
+					continue; /* hit, go on */
+				memcpy(pathspec+i, pathspec+i+1, (n-i) * sizeof(*pathspec));
+			}
+			goto done;
+		}
+
+		/*
+		 * So we have ps_hit pathspecs hit, which will be
+		 * removed, and a np_hit_count prefixes hit, which
+		 * will be in.
+		 *
+		 * Check if we have enough space for the new
+		 * np_hit_count prefix.
+		 */
+		p =3D ps_hit_count < np_hit_count ? xmalloc(sizeof(*p)*(dst-pathspec=
-ps_hit_count+np_hit_count+1)) : pathspec;
+		src =3D pathspec;
+		dst =3D p;
+		while (*src) {
+			if (GOT_HIT(ps_hitmap, src-pathspec)) {
+				src++;
+				continue;
+			}
+			*dst++ =3D *src++;
+		}
+		for (i =3D 0; i < n; i++) {
+			if (GOT_HIT(np_hitmap, i))
+				*dst++ =3D narrow_prefix[i];
+		}
+		*dst =3D NULL;
+		pathspec =3D p;
+	}
+
 	if (!*pathspec)
 		return NULL;
+done:
+	if (pathspec)
+		trace_argv_printf(pathspec, "trace: pathspec: ");
+	else
+		trace_printf("trace: pathspec: <empty>\n");
 	return pathspec;
 }
=20
+const char **get_pathspec(const char *prefix, const char **pathspec)
+{
+	return get_pathspec_narrow(prefix, pathspec, 1);
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
diff --git a/t/t0062-narrow-pathspec.sh b/t/t0062-narrow-pathspec.sh
new file mode 100755
index 0000000..ef5d059
--- /dev/null
+++ b/t/t0062-narrow-pathspec.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+
+test_description=3D'Narrow pathspec rewrite tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir a b c &&
+	mkdir a/aa a/ab a/ac &&
+	mkdir b/ba b/bb b/bc &&
+	mkdir a/aa/aaa a/aa/aab a/aa/aac &&
+	mkdir a/ab/aba a/ab/abb a/ab/abc
+'
+
+test_expect_success '() no pathspec' '
+	test-get-pathspec >result &&
+	: >expected &&
+	test_cmp expected result
+'
+
+test_expect_success '() [a] no pathspec' '
+	echo a >.git/narrow &&
+	test-get-pathspec >result &&
+	echo a >expected &&
+	test_cmp expected result
+'
+
+# Because narrow prefix is "a". put a/ to check that the prefix is
+# actually from command line not from narrow prefix
+test_expect_success '() [a] a/' '
+	echo a >.git/narrow &&
+	test-get-pathspec a/ >result &&
+	echo a/ >expected &&
+	test_cmp expected result
+'
+
+test_expect_success '() [a] a/aa' '
+	echo a >.git/narrow &&
+	test-get-pathspec a/aa >result &&
+	echo a/aa >expected &&
+	test_cmp expected result
+'
+
+test_expect_success '() [a] b' '
+	echo a >.git/narrow &&
+	test_must_fail test-get-pathspec b
+'
+
+test_expect_success '() [a/aa] a' '
+	echo a/aa >.git/narrow &&
+	test-get-pathspec a >result &&
+	echo a/aa >expected &&
+	test_cmp expected result
+'
+
+test_expect_success '() [a/aa] a/ab' '
+	echo a/aa >.git/narrow &&
+	test_must_fail test-get-pathspec a/ab
+'
+
+test_expect_success '() [a/aa a/ab] a' '
+	echo a/aa >.git/narrow &&
+	echo a/ab >>.git/narrow &&
+	test-get-pathspec a >result &&
+	echo a/aa >expected &&
+	echo a/ab >>expected &&
+	test_cmp expected result
+'
+
+test_expect_success '() [a/aa a/ab] a a/aa/aab' '
+	echo a/aa >.git/narrow &&
+	echo a/ab >>.git/narrow &&
+	test-get-pathspec a a/aa/aab >result &&
+	echo a/aa >expected &&
+	echo a/ab >>expected &&
+	test_cmp expected result
+'
+
+test_expect_success '() [a/aa a/ab] a/aa a/ab/abc' '
+	echo a/aa >.git/narrow &&
+	echo a/ab >>.git/narrow &&
+	test-get-pathspec a/aa a/ab/abc >result &&
+	echo a/ab/abc >expected &&
+	echo a/aa >>expected &&
+	test_cmp expected result
+'
+
+# a/aa is replaced by a/aa/aaa and a/aa/aab
+# reallocation must be done
+test_expect_success '() [a/aa/aaa a/aa/aab a/ab] a/aa a/ab/abc' '
+	echo a/aa/aaa >.git/narrow &&
+	echo a/aa/aab >>.git/narrow &&
+	echo a/ab >>.git/narrow &&
+	test-get-pathspec a/aa a/ab/abc >result &&
+	echo a/ab/abc >expected &&
+	echo a/aa/aaa >>expected &&
+	echo a/aa/aab >>expected &&
+	test_cmp expected result
+'
+
+test_expect_success '() [a b] no pathspec' '
+	echo a >.git/narrow &&
+	echo b >>.git/narrow &&
+	test-get-pathspec >result &&
+	echo a >expected &&
+	echo b >>expected &&
+	test_cmp expected result
+'
+
+test_expect_success '(a) no pathspec' '
+	: >.git/narrow
+	(
+	cd a
+	test-get-pathspec >result &&
+	echo a/ >expected &&
+	test_cmp expected result
+	)
+'
+
+test_expect_success '(a) [a] no pathspec' '
+	echo a >.git/narrow &&
+	(
+	cd a
+	test-get-pathspec >result &&
+	echo a/ >expected &&
+	test_cmp expected result
+	)
+'
+
+test_expect_success '(a) [a] aa' '
+	echo a >.git/narrow &&
+	(
+	cd a
+	test-get-pathspec aa >result &&
+	echo a/aa >expected &&
+	test_cmp expected result
+	)
+'
+
+test_expect_success '(b) [a] no pathspec' '
+	echo a >.git/narrow &&
+	(
+	cd b
+	test-get-pathspec >result &&
+	echo a >expected &&
+	test_cmp expected result
+	)
+'
+
+test_done
diff --git a/test-get-pathspec.c b/test-get-pathspec.c
new file mode 100644
index 0000000..413c5b0
--- /dev/null
+++ b/test-get-pathspec.c
@@ -0,0 +1,17 @@
+#include "cache.h"
+
+int main(int argc, char **argv)
+{
+	int gitdir;
+	const char *prefix =3D setup_git_directory_gently(&gitdir); /* get na=
rrow_prefix */
+	const char **p;
+
+	p =3D get_pathspec(prefix, (const char **)argv+1);
+	if (!p)
+		return 0;
+	while (*p) {
+		printf("%s\n", *p);
+		p++;
+	}
+	return 0;
+}
--=20
1.7.1.rc1.69.g24c2f7
