Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB1E1FDD
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600006; cv=none; b=Gto8ySS/vcZCIt4um9TsFDTvsjee06hOqMxxv3HN/2J34aDcGfC32m/ddSvE3uwhf8WKLdMPRBYqduq7ZxmCFMWlRETJV2yZoIOdhMP1jLJ8tLeinDuHJccKvfUMN3A36ujfRdoU+BVCVWp3mxa4mnCmh/3ElQJ1Q+SBwaigtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600006; c=relaxed/simple;
	bh=pnJDSf3rRlxO4CtbKeQa6Rn4dIYNlO22L4uwKLGON/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fta1ZxTtqhEv1QmM1oqVmFGgStBxW5aK6LtWOOXAPK6O1x+QLKlaFKraMPnDExiS3mo9PuOz8nLRKaG/RydRCE/76irUy95VIWCNrZ3VGbGlWrsk32D2+EnQbVREOqUSPrgFs+pAS4XzpdqAX/kKRywbA5MlRoIM2OMcGr269ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Tu405V3Z; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Tu405V3Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754600002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVnRIokZZl915xnSb0z47gabEBy/lZTxI7bHrJbW0Xs=;
	b=Tu405V3ZvwjpYHnoJpTQxUUX7ldJ6fWolon9T7Txj55g1SfusLQJkDOYNOHd+Epk23sO9y
	tiYKH0A8WC/YwEK8uvxXf/+RHQkHg8BshdEaGb1Mrh7P8PqSf02bW+kTaGXsB83+oNZjCm
	5mOO8R/LuvDhKtnb7W/gZT4el7wBZlI=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 07 Aug 2025 22:52:58 +0200
Subject: [PATCH v2 3/3] diff: teach tree-diff a max-depth parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-toon-max-depth-v2-3-50b7e5c81665@iotcl.com>
References: <20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com>
In-Reply-To: <20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

When you are doing a tree-diff, there are basically two options: do not
recurse into subtrees at all, or recurse indefinitely. While most
callers would want to always recurse and see full pathnames, some may
want the efficiency of looking only at a particular level of the tree.
This is currently easy to do for the top-level (just turn off
recursion), but you cannot say "show me what changed in subdir/, but do
not recurse".

This patch adds a max-depth parameter which is measured from the closest
pathspec match, so that you can do:

  git log --raw --max-depth=1 -- a/b/c

and see the raw output for a/b/c/, but not those of a/b/c/d/
(instead of the raw output you would see for a/b/c/d).

Co-authored-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/diff-options.adoc |  28 ++++++++++
 diff-lib.c                      |   5 ++
 diff.c                          |  24 +++++++++
 diff.h                          |   8 +++
 t/meson.build                   |   1 +
 t/t4072-diff-max-depth.sh       | 116 ++++++++++++++++++++++++++++++++++++++++
 tree-diff.c                     |  78 +++++++++++++++++++++++++--
 7 files changed, 257 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index f3a35d8141..b4cbbd4290 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -893,5 +893,33 @@ endif::git-format-patch[]
 	reverted with `--ita-visible-in-index`. Both options are
 	experimental and could be removed in future.
 
+--max-depth=<depth>::
+	For each pathspec given on command line, descend at most `<depth>`
+	levels of directories. A value of `-1` means no limit.
+	Cannot be combined with wildcards in the pathspec.
+	Given a tree containing `foo/bar/baz`, the following list shows the
+	matches generated by each set of options:
++
+--
+ - `--max-depth=0 -- foo`: `foo`
+
+ - `--max-depth=1 -- foo`: `foo/bar`
+
+ - `--max-depth=1 -- foo/bar`: `foo/bar/baz`
+
+ - `--max-depth=1 -- foo foo/bar`: `foo/bar/baz`
+
+ - `--max-depth=2 -- foo`: `foo/bar/baz`
+--
++
+If no pathspec is given, the depth is measured as if all
+top-level entries were specified. Note that this is different
+than measuring from the root, in that `--max-depth=0` would
+still return `foo`. This allows you to still limit depth while
+asking for a subset of the top-level entries.
++
+Note that this option is only supported for diffs between tree objects,
+not against the index or working tree.
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/diff-lib.c b/diff-lib.c
index 244468dd1a..b8f8f3bc31 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -115,6 +115,9 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 	uint64_t start = getnanotime();
 	struct index_state *istate = revs->diffopt.repo->index;
 
+	if (revs->diffopt.max_depth_valid)
+		die(_("max-depth is not supported for worktree diffs"));
+
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
 	refresh_fsmonitor(istate);
@@ -560,6 +563,8 @@ static int diff_cache(struct rev_info *revs,
 	opts.dst_index = NULL;
 	opts.pathspec = &revs->diffopt.pathspec;
 	opts.pathspec->recursive = 1;
+	if (revs->diffopt.max_depth_valid)
+		die(_("max-depth is not supported for index diffs"));
 
 	init_tree_desc(&t, &tree->object.oid, tree->buffer, tree->size);
 	return unpack_trees(1, &t, &opts);
diff --git a/diff.c b/diff.c
index dca87e164f..b548e952fc 100644
--- a/diff.c
+++ b/diff.c
@@ -4988,6 +4988,9 @@ void diff_setup_done(struct diff_options *options)
 			options->filter = ~filter_bit[DIFF_STATUS_FILTER_AON];
 		options->filter &= ~options->filter_not;
 	}
+
+	if (options->pathspec.has_wildcard && options->max_depth_valid)
+		die("max-depth cannot be used with wildcard pathspecs");
 }
 
 int parse_long_opt(const char *opt, const char **argv,
@@ -5622,6 +5625,23 @@ static int diff_opt_rotate_to(const struct option *opt, const char *arg, int uns
 	return 0;
 }
 
+static int diff_opt_max_depth(const struct option *opt,
+			      const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!git_parse_int(arg, &options->max_depth))
+		return error(_("invalid value for '%s': '%s'"),
+			     "--max-depth", arg);
+
+	options->flags.recursive = 1;
+	options->max_depth_valid = options->max_depth >= 0;
+
+	return 0;
+}
+
 /*
  * Consider adding new flags to __git_diff_common_options
  * in contrib/completion/git-completion.bash
@@ -5894,6 +5914,10 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
 			       N_("select files by diff type"),
 			       PARSE_OPT_NONEG, diff_opt_diff_filter),
+		OPT_CALLBACK_F(0, "max-depth", options, N_("<depth>"),
+			       N_("maximum tree depth to recurse"),
+			       PARSE_OPT_NONEG, diff_opt_max_depth),
+
 		{
 			.type = OPTION_CALLBACK,
 			.long_name = "output",
diff --git a/diff.h b/diff.h
index 62e5768a9a..bbced5f745 100644
--- a/diff.h
+++ b/diff.h
@@ -404,6 +404,14 @@ struct diff_options {
 	struct strmap *additional_path_headers;
 
 	int no_free;
+
+	/*
+	 * The value '0' is a valid max-depth (for no recursion), and value '-1'
+	 * also (for unlimited recursion), so the extra "valid" flag is used to
+	 * determined whether the user specified option --max-depth.
+	 */
+	int max_depth;
+	int max_depth_valid;
 };
 
 unsigned diff_filter_bit(char status);
diff --git a/t/meson.build b/t/meson.build
index 03245e2160..adae038f4a 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -487,6 +487,7 @@ integration_tests = [
   't4069-remerge-diff.sh',
   't4070-diff-pairs.sh',
   't4071-diff-minimal.sh',
+  't4072-diff-max-depth.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4072-diff-max-depth.sh b/t/t4072-diff-max-depth.sh
new file mode 100755
index 0000000000..0fbf1321f7
--- /dev/null
+++ b/t/t4072-diff-max-depth.sh
@@ -0,0 +1,116 @@
+#!/bin/sh
+
+test_description='check that diff --max-depth will limit recursion'
+. ./test-lib.sh
+
+make_dir() {
+	mkdir -p "$1" &&
+	echo "$2" >"$1/file"
+}
+
+make_files() {
+	echo "$1" >file &&
+	make_dir one "$1" &&
+	make_dir one/two "$1" &&
+	make_dir one/two/three "$1"
+}
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m empty &&
+	git tag empty &&
+	make_files added &&
+	git add . &&
+	git commit -m added &&
+	make_files modified &&
+	git add . &&
+	git commit -m modified &&
+	make_files index &&
+	git add . &&
+	make_files worktree
+'
+
+test_expect_success '--max-depth is disallowed with wildcard pathspecs' '
+	test_must_fail git diff-tree --max-depth=0 HEAD^ HEAD -- "f*"
+'
+
+check_one() {
+	type=$1; shift
+	args=$1; shift
+	path=$1; shift
+	depth=$1; shift
+	test_expect_${expect:-success} "diff-$type $args, path=$path, depth=$depth" "
+		for i in $*; do echo \$i; done >expect &&
+		git diff-$type --max-depth=$depth --name-only $args -- $path >actual &&
+		test_cmp expect actual
+	"
+}
+
+# For tree comparisons, we expect to see subtrees at the boundary
+# get their own entry.
+check_trees() {
+	check_one tree "$*" '' 0 file one
+	check_one tree "$*" '' 1 file one/file one/two
+	check_one tree "$*" '' 2 file one/file one/two/file one/two/three
+	check_one tree "$*" '' 3 file one/file one/two/file one/two/three/file
+	check_one tree "$*" '' -1 file one/file one/two/file one/two/three/file
+	check_one tree "$*" one 0 one
+	check_one tree "$*" one 1 one/file one/two
+	check_one tree "$*" one 2 one/file one/two/file one/two/three
+	check_one tree "$*" one 3 one/file one/two/file one/two/three/file
+	check_one tree "$*" one/two 0 one/two
+	check_one tree "$*" one/two 1 one/two/file one/two/three
+	check_one tree "$*" one/two 2 one/two/file one/two/three/file
+	check_one tree "$*" one/two 2 one/two/file one/two/three/file
+	check_one tree "$*" one/two/three 0 one/two/three
+	check_one tree "$*" one/two/three 1 one/two/three/file
+}
+
+# But for index comparisons, we do not store subtrees at all, so we do not
+# expect them.
+check_index() {
+	check_one "$@" '' 0 file
+	check_one "$@" '' 1 file one/file
+	check_one "$@" '' 2 file one/file one/two/file
+	check_one "$@" '' 3 file one/file one/two/file one/two/three/file
+	check_one "$@" one 0
+	check_one "$@" one 1 one/file
+	check_one "$@" one 2 one/file one/two/file
+	check_one "$@" one 3 one/file one/two/file one/two/three/file
+	check_one "$@" one/two 0
+	check_one "$@" one/two 1 one/two/file
+	check_one "$@" one/two 2 one/two/file one/two/three/file
+	check_one "$@" one/two/three 0
+	check_one "$@" one/two/three 1 one/two/three/file
+
+	# Value '-1' for '--max-depth is the same as recursion without limit,
+	# and thus should always succeed.
+	local expect=
+	check_one "$@" '' -1 file one/file one/two/file one/two/three/file
+}
+
+# Check as a modification...
+check_trees HEAD^ HEAD
+# ...and as an addition...
+check_trees empty HEAD
+# ...and as a deletion.
+check_trees HEAD empty
+
+# We currently only implement max-depth for trees.
+expect=failure
+# Check index against a tree
+check_index index "--cached HEAD"
+# and index against the worktree
+check_index files ""
+expect=
+
+test_expect_success 'find shortest path within embedded pathspecs' '
+	cat >expect <<-\EOF &&
+	one/file
+	one/two/file
+	one/two/three/file
+	EOF
+	git diff-tree --max-depth=2 --name-only HEAD^ HEAD -- one one/two >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/tree-diff.c b/tree-diff.c
index e00fc2f450..5988148b60 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -13,6 +13,7 @@
 #include "tree-walk.h"
 #include "environment.h"
 #include "repository.h"
+#include "dir.h"
 
 /*
  * Some mode bits are also used internally for computations.
@@ -48,6 +49,73 @@
 		free((x)); \
 } while(0)
 
+/* Returns true if and only if "dir" is a leading directory of "path" */
+static int is_dir_prefix(const char *path, const char *dir, int dirlen)
+{
+	return !strncmp(path, dir, dirlen) &&
+		(!path[dirlen] || path[dirlen] == '/');
+}
+
+static int check_recursion_depth(const struct strbuf *name,
+				 const struct pathspec *ps,
+				 int max_depth)
+{
+	int i;
+
+	if (!ps->nr)
+		return within_depth(name->buf, name->len, 1, max_depth);
+
+	/*
+	 * We look through the pathspecs in reverse-sorted order, because we
+	 * want to find the longest match first (e.g., "a/b" is better for
+	 * checking depth than "a/b/c").
+	 */
+	for (i = ps->nr - 1; i >= 0; i--) {
+		const struct pathspec_item *item = ps->items+i;
+
+		/*
+		 * If the name to match is longer than the pathspec, then we
+		 * are only interested if the pathspec matches and we are
+		 * within the allowed depth.
+		 */
+		if (name->len >= item->len) {
+			if (!is_dir_prefix(name->buf, item->match, item->len))
+				continue;
+			return within_depth(name->buf + item->len,
+					    name->len - item->len,
+					    1, max_depth);
+		}
+
+		/*
+		 * Otherwise, our name is shorter than the pathspec. We need to
+		 * check if it is a prefix of the pathspec; if so, we must
+		 * always recurse in order to process further (the resulting
+		 * paths we find might or might not match our pathspec, but we
+		 * cannot know until we recurse).
+		 */
+		if (is_dir_prefix(item->match, name->buf, name->len))
+			return 1;
+	}
+	return 0;
+}
+
+static int should_recurse(const struct strbuf *name, struct diff_options *opt)
+{
+	if (!opt->flags.recursive)
+		return 0;
+	if (!opt->max_depth_valid)
+		return 1;
+
+	/*
+	 * We catch this during diff_setup_done, but let's double-check
+	 * against any internal munging.
+	 */
+	if (opt->pathspec.has_wildcard)
+		BUG("wildcard pathspecs are incompatible with max-depth");
+
+	return check_recursion_depth(name, &opt->pathspec, opt->max_depth);
+}
+
 static void ll_diff_tree_paths(
 	struct combine_diff_path ***tail, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
@@ -170,9 +238,13 @@ static void emit_path(struct combine_diff_path ***tail,
 		mode = 0;
 	}
 
-	if (opt->flags.recursive && isdir) {
-		recurse = 1;
-		emitthis = opt->flags.tree_in_recursive;
+	if (isdir) {
+		strbuf_add(base, path, pathlen);
+		if (should_recurse(base, opt)) {
+			recurse = 1;
+			emitthis = opt->flags.tree_in_recursive;
+		}
+		strbuf_setlen(base, old_baselen);
 	}
 
 	if (emitthis) {

-- 
2.50.1.327.g047016eb4a

