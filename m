Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B10C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44476140E
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhGAVdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:33:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:39252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhGAVdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 17:33:02 -0400
Received: (qmail 28964 invoked by uid 109); 1 Jul 2021 21:30:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 21:30:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19287 invoked by uid 111); 1 Jul 2021 21:30:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 17:30:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 17:30:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/3] pathspec: add optional trie index
Message-ID: <YN4z9cIrph/OBvw6@coredump.intra.peff.net>
References: <YN4zKVK7gvuIZ0vK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN4zKVK7gvuIZ0vK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 pathspec.c               | 125 +++++++++++++++++++++++++++++++++++++++
 pathspec.h               |  12 ++++
 t/helper/test-pathspec.c |  98 ++++++++++++++++++++++++++++++
 t/helper/test-tool.c     |   1 +
 t/helper/test-tool.h     |   1 +
 t/t6137-pathspec-trie.sh |  57 ++++++++++++++++++
 7 files changed, 295 insertions(+)
 create mode 100644 t/helper/test-pathspec.c
 create mode 100755 t/t6137-pathspec-trie.sh

diff --git a/Makefile b/Makefile
index c3565fc0f8..675f51a330 100644
--- a/Makefile
+++ b/Makefile
@@ -726,6 +726,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-path-utils.o
+TEST_BUILTINS_OBJS += test-pathspec.o
 TEST_BUILTINS_OBJS += test-pcre2-config.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
diff --git a/pathspec.c b/pathspec.c
index 08f8d3eedc..24a24f627e 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -760,3 +760,128 @@ int match_pathspec_attrs(struct index_state *istate,
 
 	return 1;
 }
+
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
+/*
+ * Do a binary search on one level of the pathspec_trie. If found,
+ * returns the offset of the item in the entry list. If not found,
+ * return a negative value encoding the offset where it would be inserted
+ * (you can recover the true offset with "-pos - 1").
+ */
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
+static struct pathspec_trie *alloc_pathspec_trie(const char *path, size_t len)
+{
+	struct pathspec_trie *ret = xcalloc(1, sizeof(*ret) + len);
+	memcpy(ret->path, path, len);
+	return ret;
+}
+
+/*
+ * Add "path" to the trie rooted at "t".
+ */
+static void add_pathspec_trie(struct pathspec_trie *t, const char *path)
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
+			t->entries[pos] = alloc_pathspec_trie(path, len);
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
+struct pathspec_trie *build_pathspec_trie(const struct pathspec *pathspec)
+{
+	struct pathspec_trie *ret;
+	int i;
+
+	/* we only make a trie for plain-vanilla pathspecs */
+	if (pathspec->has_wildcard || (pathspec->magic & ~PATHSPEC_LITERAL))
+		return NULL;
+
+	ret = alloc_pathspec_trie("", 0);
+
+	/*
+	 * XXX we could construct the trie more efficiently by creating each
+	 * node with all of its entries in sorted order. But this is much
+	 * simpler, and since we only do this once at the start of a traversal,
+	 * it's probably fast enough.
+	 */
+	for (i = 0; i < pathspec->nr; i++)
+		add_pathspec_trie(ret, pathspec->items[i].match);
+
+	return ret;
+}
diff --git a/pathspec.h b/pathspec.h
index fceebb876f..15c9244d08 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -22,6 +22,14 @@ struct index_state;
 
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
+struct pathspec_trie {
+	struct pathspec_trie **entries;
+	int nr, alloc;
+	unsigned terminal:1,
+		 must_be_dir:1;
+	char path[FLEX_ARRAY];
+};
+
 /**
  * See glossary-context.txt for the syntax of pathspec.
  * In memory, a pathspec set is represented by "struct pathspec" and is
@@ -172,4 +180,8 @@ int match_pathspec_attrs(struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
 
+struct pathspec_trie *build_pathspec_trie(const struct pathspec *);
+int pathspec_trie_lookup(const struct pathspec_trie *pst,
+			 const char *path, size_t len);
+
 #endif /* PATHSPEC_H */
diff --git a/t/helper/test-pathspec.c b/t/helper/test-pathspec.c
new file mode 100644
index 0000000000..3f1b8f1a79
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
+	trie = build_pathspec_trie(&pathspec);
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
+int cmd__pathspec(int argc, const char **argv)
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
index c5bd0c6d4c..c5dc6153e0 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -47,6 +47,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-options", cmd__parse_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "path-utils", cmd__path_utils },
+	{ "pathspec", cmd__pathspec },
 	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e8069a3b22..878aba1bc8 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,6 +35,7 @@ int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
+int cmd__pathspec(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pcre2_config(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
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
2.32.0.359.g3de86e008e.dirty

