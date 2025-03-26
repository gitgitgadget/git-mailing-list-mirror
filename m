Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BD24EF97
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020391; cv=none; b=gInk6Ib+LcH31iBDZMAlkRbOt2ADuKlxRwLE8skgY4qDmvL3llVb7GiZkppPDwtikkySPdeXSV4jKVtz78flERqerrgVek4BPgkMqFO6fMkUPr5DQ3g2yvVBUj5R2cRYZ0odzm6DeXMWLif14AuTAOavvuYbN3aCUE7fQBEO25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020391; c=relaxed/simple;
	bh=4bAywy4PIYpYXPv0TSkIXjNtit4YwQYek4bv729yTtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZi+fcB31xZgBhVCYOk8XGwZysJOwM3vc9aSbBLQ6omQeEZFx8jhA83hVQ212MMKlwbDnv6XeTtf0KWvYAAjTAHZrZ2sc6r3zcnGBGyPKo0yk1MK1gKGPj5Zhs73y8OgFewrB+FsIBJt4qdlIK1yp4/blg+X8p7SfYeNT50xy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=inlJlPPk; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="inlJlPPk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743020385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3MnCuhwVlFg/EBSuI7HaR8/5BJIwom/0fpo7Son0OA=;
	b=inlJlPPkC4LfccZlDAIBIEi0pQxK9bHXoIZ/1FVzsEKecg2C9OFsowc7K1P6hqZDgMg2rw
	sJylV8uBgCqwbUpl1HpYY4IEZw3nLquehegY/aL8yhL2OVDZP0Irw/9t1Rm5j9CUQaK9Vi
	qt8F5xUCFW0BcKV5vD7+pBRPsea1Q0o=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Mar 2025 21:18:29 +0100
Subject: [PATCH 5/8] pathspec: add optional trie index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-toon-blame-tree-v1-5-4173133f3786@iotcl.com>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
In-Reply-To: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

When checking if a path matches our pathspec list, in the
worst case we walk the whole list linearly to check each
pathspec.  As a result, an operation like a tree diff does
`O(paths * pathspecs)` comparisons. If we assume that the
number of pathspecs may approach the number of paths, this
is `O(n^2)` in the number of paths.  We have to do it this
way in the general case because pathspecs may be arbitrary
fnmatch expressions, and we cannot create any meaningful
index.

However, it is common that all of the pathspecs are vanilla
prefixes (e.g., "git.c" or "Documentation/") that do not use
any wildcards or magic features. In such a case, we can
index the pathspec list to give us faster lookups.

The simplest solution would be to keep the pathspec list
sorted, and use a binary search over the entries for each
path. This turns out to be rather tricky, though, as we are
not looking for an exact match in the list. We must also
find prefix matches, and take care to handle trailing
slashes for directories.

Instead, this patch introduces a pathspec_trie struct, which
represents the pathspecs as a graph of entries. For
example, the pathspec list ["foo/bar", "foo/baz/"] would be
represented as:

        (bar, terminal)
       /
  (foo)
       \
        (baz, terminal, must_be_dir)

To see if a path "foo/eek" is covered by the pathspec, we
walk the trie, matching "foo" but ultimately seeing that
"eek" is not mentioned.

This provides us with two optimizations:

  1. The children of each trie node are simple strings
     representing directory components. This means we can sort
     and binary-search them, giving us logarithmic lookups
     (but note that rather than one log lookup on the whole
     pathname, it is a sequence of smaller log lookups on
     components of the pathname).

  2. Many users of the pathspec code do not feed full
     pathnames, but instead are walking a tree hierarchy
     themselves, and limiting the walk as they go. They can
     walk the trie at the same time, meanining they avoid
     looking repeatedly at parts of the pathspec we already
     know are matched. The current code, by contrast, will
     repeatedly match "foo/" against each pathspec when
     looking at "foo/bar", "foo/baz", etc.

Note that this patch just introduces the data structure; the
code is not used anywhere yet.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                 |   1 +
 pathspec.c               | 119 +++++++++++++++++++++++++++++++++++++++++++++++
 pathspec.h               |  23 +++++++++
 t/helper/meson.build     |   1 +
 t/helper/test-pathspec.c |  98 ++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c     |   1 +
 t/helper/test-tool.h     |   1 +
 t/meson.build            |   1 +
 t/t6137-pathspec-trie.sh |  57 +++++++++++++++++++++++
 9 files changed, 302 insertions(+)

diff --git a/Makefile b/Makefile
index 92fdfc76df..c90607baa1 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,7 @@ TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-partial-clone.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-path-walk.o
+TEST_BUILTINS_OBJS += test-pathspec.o
 TEST_BUILTINS_OBJS += test-pcre2-config.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-proc-receive.o
diff --git a/pathspec.c b/pathspec.c
index 89663645e1..0e381fd748 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -17,6 +17,125 @@
 #include "quote.h"
 #include "wildmatch.h"
 
+/*
+ * This is basically a strcmp, but we do not want the caller
+ * to have to terminate "a", so we pretend as if it had a NUL.
+ */
+static int pathspec_trie_cmp(const char *a, size_t a_len,
+			     const char *b)
+{
+	int ret = strncmp(a, b, a_len);
+	return ret ?
+		ret :
+		(unsigned char)0 - (unsigned char )b[a_len];
+}
+
+static struct pathspec_trie *pathspec_trie_alloc(const char *path, size_t len)
+{
+	struct pathspec_trie *ret = xcalloc(1, sizeof(*ret) + len);
+	memcpy(ret->path, path, len);
+	return ret;
+}
+
+/*
+ * Add "path" to the trie rooted at "t".
+ */
+static void pathspec_trie_add(struct pathspec_trie *t, const char *path)
+{
+	/*
+	 * Special case the empty path (i.e., "."), as our splitting algorithm
+	 * below assumes at least one component.
+	 */
+	if (!*path) {
+		t->terminal = 1;
+		return;
+	}
+
+	while (1) {
+		const char *slash = strchrnul(path, '/');
+		size_t len = slash - path;
+		int pos;
+
+		pos = pathspec_trie_lookup(t, path, len);
+		if (pos < 0) {
+			ALLOC_GROW(t->entries, t->nr + 1, t->alloc);
+
+			pos = -pos - 1;
+			if (pos < t->nr)
+				memmove(t->entries + pos + 1,
+					t->entries + pos,
+					sizeof(*t->entries) * (t->nr - pos));
+			t->entries[pos] = pathspec_trie_alloc(path, len);
+			t->nr++;
+		}
+
+		t = t->entries[pos];
+		path += len;
+
+		if (!*path) {
+			t->must_be_dir = 0;
+			t->terminal = 1;
+			return;
+		}
+
+		while (*path == '/')
+			path++;
+		if (!*path) {
+			/*
+			 * if we were already a terminal, then do not set
+			 * must_be_dir; we are "foo/", but we already had a
+			 * pathspec "foo", which is a superset of us.
+			 */
+			if (!t->terminal)
+				t->must_be_dir = 1;
+			t->terminal = 1;
+			return;
+		}
+	}
+}
+
+struct pathspec_trie *pathspec_trie_build(const struct pathspec *pathspec)
+{
+	struct pathspec_trie *ret;
+	int i;
+
+	/* we only make a trie for plain-vanilla pathspecs */
+	if (pathspec->has_wildcard || (pathspec->magic & ~PATHSPEC_LITERAL))
+		return NULL;
+
+	ret = pathspec_trie_alloc("", 0);
+
+	/*
+	 * XXX we could construct the trie more efficiently by creating each
+	 * node with all of its entries in sorted order. But this is much
+	 * simpler, and since we only do this once at the start of a traversal,
+	 * it's probably fast enough.
+	 */
+	for (i = 0; i < pathspec->nr; i++)
+		pathspec_trie_add(ret, pathspec->items[i].match);
+
+	return ret;
+}
+
+int pathspec_trie_lookup(const struct pathspec_trie *parent,
+			 const char *path, size_t len)
+{
+	int lo = 0, hi = parent->nr;
+	while (lo < hi) {
+		int mi = lo + ((hi - lo) / 2);
+		int cmp;
+
+		cmp = pathspec_trie_cmp(path, len, parent->entries[mi]->path);
+		if (!cmp)
+			return mi;
+		if (cmp < 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+	return -lo - 1;
+}
+
 /*
  * Finds which of the given pathspecs match items in the index.
  *
diff --git a/pathspec.h b/pathspec.h
index de537cff3c..71bafb78a9 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -2,6 +2,7 @@
 #define PATHSPEC_H
 
 struct index_state;
+struct pathspec;
 
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP	(1<<0)
@@ -22,6 +23,28 @@ struct index_state;
 
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
+struct pathspec_trie {
+	struct pathspec_trie **entries;
+	int nr, alloc;
+	unsigned terminal:1,
+		 must_be_dir:1;
+	char path[FLEX_ARRAY];
+};
+
+/*
+ * Build a pathspec_trie for the given pathspec.
+ */
+struct pathspec_trie *pathspec_trie_build(const struct pathspec *);
+
+/*
+ * Do a binary search on one level of the pathspec_trie. If found,
+ * returns the offset of the item in the entry list. If not found,
+ * return a negative value encoding the offset where it would be inserted
+ * (you can recover the true offset with "-pos - 1").
+ */
+int pathspec_trie_lookup(const struct pathspec_trie *pst,
+			 const char *path, size_t len);
+
 /**
  * See glossary-content.txt for the syntax of pathspec.
  * In memory, a pathspec set is represented by "struct pathspec" and is
diff --git a/t/helper/meson.build b/t/helper/meson.build
index d2cabaa2bc..f6dc3e443b 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -42,6 +42,7 @@ test_tool_sources = [
   'test-partial-clone.c',
   'test-path-utils.c',
   'test-path-walk.c',
+  'test-pathspec.c',
   'test-pcre2-config.c',
   'test-pkt-line.c',
   'test-proc-receive.c',
diff --git a/t/helper/test-pathspec.c b/t/helper/test-pathspec.c
new file mode 100644
index 0000000000..c04417681f
--- /dev/null
+++ b/t/helper/test-pathspec.c
@@ -0,0 +1,98 @@
+#include "test-tool.h"
+#include "pathspec.h"
+
+static const char usage_msg[] =
+"test-tool pathspec trie [pathspecs...] -- [paths....]";
+
+/*
+ * XXX Yuck. This is a lot of complicated code specific to our test. Even if it
+ * runs correctly, we have no real guarantee that the actual trie users are
+ * doing it right. And reusing their code is tough, because it happens as part
+ * of their own traversals (e.g., we walk the pathspec trie while walking the
+ * tree objects themselves).
+ *
+ * This whole test program should probably go away in favor of directly testing
+ * the tree-diff code.
+ */
+static int trie_match(const struct pathspec_trie *pst,
+		      const char *path)
+{
+	int pathlen = strlen(path);
+	int is_dir = 0;
+
+	if (pathlen > 0 && path[pathlen-1] == '/') {
+		is_dir = 1;
+		pathlen--;
+	}
+
+	while (pathlen) {
+		const char *slash = memchr(path, '/', pathlen);
+		int component_len;
+		int pos;
+
+		if (slash)
+			component_len = slash - path;
+		else
+			component_len = pathlen;
+
+		pos = pathspec_trie_lookup(pst, path, component_len);
+		if (pos < 0)
+			return 0;
+
+		pst = pst->entries[pos];
+		path += component_len;
+		pathlen -= component_len;
+
+		while (pathlen && *path == '/') {
+			path++;
+			pathlen--;
+		}
+
+		if (pst->terminal) {
+			if (!pst->must_be_dir)
+				return 1;
+			if (pathlen)
+				return 1;
+			return is_dir;
+		}
+	}
+	return 0;
+}
+
+static int cmd_trie(const char **argv)
+{
+	const char **specs, **paths;
+	struct pathspec pathspec;
+	struct pathspec_trie *trie;
+
+	paths = specs = argv;
+	while (*paths && strcmp(*paths, "--"))
+		paths++;
+	if (*paths)
+		*paths++ = NULL;
+
+	parse_pathspec(&pathspec, 0, 0, "", specs);
+	trie = pathspec_trie_build(&pathspec);
+	if (!trie)
+		die("unable to make trie from pathspec");
+
+	for (; *paths; paths++) {
+		if (trie_match(trie, *paths))
+			printf("yes\n");
+		else
+			printf("no\n");
+	}
+	return 0;
+}
+
+int cmd__pathspec(int argc UNUSED, const char **argv)
+{
+	const char *cmd = argv[1];
+
+	if (!cmd)
+		usage(usage_msg);
+	else if (!strcmp(cmd, "trie"))
+		return cmd_trie(argv + 2);
+	else
+		die("unknown cmd: %s", cmd);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 50dc4dac4e..bc0a1b9245 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -54,6 +54,7 @@ static struct test_cmd cmds[] = {
 	{ "partial-clone", cmd__partial_clone },
 	{ "path-utils", cmd__path_utils },
 	{ "path-walk", cmd__path_walk },
+	{ "pathspec", cmd__pathspec },
 	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
 	{ "proc-receive", cmd__proc_receive },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 41cc3730dc..5e79fa38ca 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -46,6 +46,7 @@ int cmd__parse_options_flags(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__parse_subcommand(int argc, const char **argv);
 int cmd__partial_clone(int argc, const char **argv);
+int cmd__pathspec(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__path_walk(int argc, const char **argv);
 int cmd__pcre2_config(int argc, const char **argv);
diff --git a/t/meson.build b/t/meson.build
index 6f6485c8b4..bb29c36b2a 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -788,6 +788,7 @@ integration_tests = [
   't6134-pathspec-in-submodule.sh',
   't6135-pathspec-with-attrs.sh',
   't6136-pathspec-in-bare.sh',
+  't6137-pathspec-trie.sh',
   't6200-fmt-merge-msg.sh',
   't6300-for-each-ref.sh',
   't6301-for-each-ref-errors.sh',
diff --git a/t/t6137-pathspec-trie.sh b/t/t6137-pathspec-trie.sh
new file mode 100755
index 0000000000..ca2935c7db
--- /dev/null
+++ b/t/t6137-pathspec-trie.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+test_description='test optimized pathspec trie lookup'
+. ./test-lib.sh
+
+# This is a basic lookup test; the offsets are there to provide
+# some variation in where we land in our binary search.
+ps="faa fzz foo/bar foo/baa foo/bzz"
+for offset in a "a b" "a b c"; do
+	test_expect_success "lookups with ps=$offset $ps" "
+		cat >expect <<-\\EOF &&
+		no
+		yes
+		yes
+		no
+		EOF
+		test-tool pathspec trie $offset $ps -- f faa foo/bar foo/baz >actual &&
+		test_cmp expect actual
+	"
+done
+
+test_expect_success 'pathspecs match by prefix' '
+	cat >expect <<-\EOF &&
+	yes
+	yes
+	yes
+	EOF
+	test-tool pathspec trie foo -- foo foo/bar foo/with/deep/subdirs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'trailing slash sets must_be_dir' '
+	cat >expect <<-\EOF &&
+	no
+	yes
+	yes
+	EOF
+	test-tool pathspec trie dir/ -- dir dir/ dir/foo
+'
+
+test_expect_success 'overlapping pathspecs allow the "loose" side' '
+	echo yes >expect &&
+	test-tool pathspec trie foo foo/ -- foo >actual &&
+	test_cmp expect actual &&
+	test-tool pathspec trie foo/ foo -- foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"." at the root matches everything' '
+	cat >expect <<-\EOF &&
+	yes
+	yes
+	EOF
+	test-tool pathspec trie . -- foo foo/bar
+'
+
+test_done

-- 
2.49.0.rc2

