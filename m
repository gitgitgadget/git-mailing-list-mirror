Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2723C8C9
	for <git@vger.kernel.org>; Wed, 21 May 2025 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870168; cv=none; b=IjEzs0Rvth1Vzwete/n/cSJ5uMNAftIFdFDz5hhUIz2fu7uWG6IasdcJ8FpaNRRvGgU7hguEgpOA/zetLWqKpPyn3bsHJnGII6GU4sNo3r1HkBmDGcQa0JPICphog+ZukQRyMPdEfIRR+ykBrHOdjd3zErW+4qM5vO+KlvLPpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870168; c=relaxed/simple;
	bh=8xIluuTD4boHNS728eY1zSCKqYsoAe2De6g77nyUrTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7pIyvXT+Nxuw4Dy+lEIIHXtDfpD1CmBx3JmX+r+zrqJ3WsfJ37zNiQ0jcH3azzszjzHG2Z7fJF4RCzgcs0lIGae5NMZKaOS+mbSNCTeNfej7efXLv19lbz3FcPcddL4Tili7eGlevAJhynZmCz32ZuVj5YDmJ+OjfIBgUzoS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbNy8Ne2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbNy8Ne2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747870167; x=1779406167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8xIluuTD4boHNS728eY1zSCKqYsoAe2De6g77nyUrTs=;
  b=hbNy8Ne2USuPCmWEOPCLBrjhQMgbfOuS3Ab2p7E6tCiK/a4/nLB9SwJi
   TIX0t9VeXOZW7+XicmCGoAVVczf/BHAwKAGmD2scRbDPTpt4DncBQAv+9
   08j42OdpYOr33Wo8LqyUQzyvOwLugyHat+isJPpVaOgGg6V3cIuTiPZUD
   sFnx2EhO2kdkfvg7RMUYMwOHDPS47YDF1teZfiHeXO1uznrQR+UaHJzNL
   FBu2CixPTBPaiOCPu9hgFDsd3tbXQOmPSTxxGdtJetRpVwUjJd6VWXJfY
   xuMpuPSdBFSJNZXUL/c9YMXwPeVHdnmtSsHMPYhdxtYsoHH9IzOYWy5mk
   A==;
X-CSE-ConnectionGUID: xXYAsBViSg6EGrNqiaCTdw==
X-CSE-MsgGUID: tSlGIjY2RWmWRkcQxMcieQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="75271685"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="75271685"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:29:22 -0700
X-CSE-ConnectionGUID: eSTvhwNBQ7WcbcmODXGdJg==
X-CSE-MsgGUID: uKqX+zDvT8ujxE7YvKsLcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140072362"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:29:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
Date: Wed, 21 May 2025 16:29:17 -0700
Message-ID: <20250521232917.2333291-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.48.1.397.gec9d649cc640
In-Reply-To: <20250521232917.2333291-1-jacob.e.keller@intel.com>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

The --no-index option of git-diff enables using the diff machinery from
git while operating outside of a repository. This mode of git diff is
able to compare directories and produce a diff of their contents.

When operating git diff in a repository, git has the notion of
"pathspecs" which can specify which files to compare. In particular,
when using git to diff two trees, you might invoke:

  $ git diff-tree -r <treeish1> <treeish2>.

where the treeish could point to a subdirectory of the repository.

When invoked this way, users can limit the selected paths of the tree by
using a pathspec. Either by providing some list of paths to accept, or
by removing paths via a negative refspec.

The git diff --no-index mode does not support pathspecs, and cannot
limit the diff output in this way. Other diff programs such as GNU
difftools have options for excluding paths based on a pattern match.
However, using git diff as a diff replacement has several advantages
over many popular diff tools, including coloring moved lines, rename
detections, and similar.

Teach git diff --no-index how to handle pathspecs to limit the
comparisons. This will only be supported if both provided paths are
directories.

For comparisons where one path isn't a directory, the --no-index mode
already has some DWIM shortcuts implemented in the fixup_paths()
function.

Modify the fixup_paths function to return 1 if both paths are
directories. If this is the case, interpret any extra arguments to git
diff as pathspecs via parse_pathspec.

Use parse_pathspec to load the remaining arguments (if any) to git diff
--no-index as pathspec items. Disable PATHSPEC_ATTR support since we do
not have a repository to do attribute lookup. Disable PATHSPEC_FROMTOP
since we do not have a repository root. All pathspecs are treated as
rooted at the provided comparison paths.

After loading the pathspec data, calculate skip offsets for skipping
past the root portion of the paths. This is required to ensure that
pathspecs start matching from the provided path, rather than matching
from the absolute path. We could instead pass the paths as prefix values
to parse_pathspec. This is slightly problematic because the paths come
from the command line and don't necessarily have the proper trailing
slash. Additionally, that would require parsing pathspecs multiple
times.

Pass the pathspec object and the skip offsets into queue_diff, which
in-turn must pass them along to read_directory_contents.

Modify read_directory_contents to check against the pathspecs when
scanning the directory. Use the skip offset to skip past the initial
root of the path, and only match against portions that are below the
intended directory structure being compared.

The search algorithm for finding paths is recursive with read_dir. To
make pathspec matching work properly, we must set both
DO_MATCH_DIRECTORY and DO_MATCH_LEADING_PATHSPEC.

Without DO_MATCH_DIRECTORY, paths like "a/b/c/d" will not match against
pathspecs like "a/b/c". This is usually achieved by setting the is_dir
parameter of match_pathspec.

Without DO_MATCH_LEADING_PATHSPEC, paths like "a/b/c" would not match
against pathspecs like "a/b/c/d". This is crucial because we recursively
iterate down the directories. We could simply avoid checking pathspecs
at subdirectories, but this would force recursion down directories
which would simply be skipped.

If we always passed DO_MATCH_LEADING_PATHSPEC, then we will
incorrectly match in certain cases such as matching 'a/c' against
':(glob)**/d'. The match logic will see that a matches the leading part
of the **/ and accept this even tho c doesn't match.

To avoid this, use the match_leading_pathspec() variant recently
introduced. This sets both flags when is_dir is set, but leaves them
both cleared when is_dir is 0.

Add test cases and documentation covering the new functionality. Note
for the documentation I opted not to move the placement of '--' which is
sometimes used to disambiguate arguments. The diff --no-index mode
requires exactly 2 arguments determining what to compare. Any additional
arguments are interpreted as pathspecs and must come afterwards. Use of
'--' would not actually disambiguate anything, since there will never be
ambiguity over which arguments represent paths or pathspecs.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/diff.c              |  2 +-
 diff-no-index.c             | 85 +++++++++++++++++++++++++++++--------
 Documentation/git-diff.adoc | 10 +++--
 t/t4053-diff-no-index.sh    | 75 ++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 21 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index fa963808c318..c6231edce4e8 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -35,7 +35,7 @@ static const char builtin_diff_usage[] =
 "   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <blob> <blob>\n"
-"   or: git diff [<options>] --no-index [--] <path> <path>"
+"   or: git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]"
 "\n"
 COMMON_DIFF_OPTIONS_HELP;
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 9739b2b268b9..4aeeb98cfa8f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,20 +15,45 @@
 #include "gettext.h"
 #include "revision.h"
 #include "parse-options.h"
+#include "pathspec.h"
 #include "string-list.h"
 #include "dir.h"
 
-static int read_directory_contents(const char *path, struct string_list *list)
+static int read_directory_contents(const char *path, struct string_list *list,
+				   const struct pathspec *pathspec,
+				   int skip)
 {
+	struct strbuf match = STRBUF_INIT;
+	int len;
 	DIR *dir;
 	struct dirent *e;
 
 	if (!(dir = opendir(path)))
 		return error("Could not open directory %s", path);
 
-	while ((e = readdir_skip_dot_and_dotdot(dir)))
-		string_list_insert(list, e->d_name);
+	if (pathspec) {
+		strbuf_addstr(&match, path);
+		strbuf_complete(&match, '/');
+		strbuf_remove(&match, 0, skip);
 
+		len = match.len;
+	}
+
+	while ((e = readdir_skip_dot_and_dotdot(dir))) {
+		if (pathspec) {
+			strbuf_setlen(&match, len);
+			strbuf_addstr(&match, e->d_name);
+
+			if (!match_leading_pathspec(NULL, pathspec,
+						    match.buf, match.len,
+						    0, NULL, e->d_type == DT_DIR ? 1 : 0))
+				continue;
+		}
+
+		string_list_insert(list, e->d_name);
+	}
+
+	strbuf_release(&match);
 	closedir(dir);
 	return 0;
 }
@@ -131,7 +156,8 @@ static struct diff_filespec *noindex_filespec(const struct git_hash_algo *algop,
 }
 
 static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
-		      const char *name1, const char *name2, int recursing)
+		      const char *name1, const char *name2, int recursing,
+		      const struct pathspec *ps, int skip1, int skip2)
 {
 	int mode1 = 0, mode2 = 0;
 	enum special special1 = SPECIAL_NONE, special2 = SPECIAL_NONE;
@@ -171,9 +197,9 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory_contents(name1, &p1))
+		if (name1 && read_directory_contents(name1, &p1, ps, skip1))
 			return -1;
-		if (name2 && read_directory_contents(name2, &p2)) {
+		if (name2 && read_directory_contents(name2, &p2, ps, skip2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
@@ -218,7 +244,7 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 				n2 = buffer2.buf;
 			}
 
-			ret = queue_diff(o, algop, n1, n2, 1);
+			ret = queue_diff(o, algop, n1, n2, 1, ps, skip1, skip2);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
@@ -258,8 +284,10 @@ static void append_basename(struct strbuf *path, const char *dir, const char *fi
  * DWIM "diff D F" into "diff D/F F" and "diff F D" into "diff F D/F"
  * Note that we append the basename of F to D/, so "diff a/b/file D"
  * becomes "diff a/b/file D/file", not "diff a/b/file D/a/b/file".
+ *
+ * Return 1 if both paths are directories, 0 otherwise.
  */
-static void fixup_paths(const char **path, struct strbuf *replacement)
+static int fixup_paths(const char **path, struct strbuf *replacement)
 {
 	struct stat st;
 	unsigned int isdir0 = 0, isdir1 = 0;
@@ -282,26 +310,31 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 	if ((isdir0 && ispipe1) || (ispipe0 && isdir1))
 		die(_("cannot compare a named pipe to a directory"));
 
-	if (isdir0 == isdir1)
-		return;
+	/* if both paths are directories, we will enable pathspecs */
+	if (isdir0 && isdir1)
+		return 1;
+
 	if (isdir0) {
 		append_basename(replacement, path[0], path[1]);
 		path[0] = replacement->buf;
-	} else {
+	} else if (isdir1) {
 		append_basename(replacement, path[1], path[0]);
 		path[1] = replacement->buf;
 	}
+
+	return 0;
 }
 
 static const char * const diff_no_index_usage[] = {
-	N_("git diff --no-index [<options>] <path> <path>"),
+	N_("git diff --no-index [<options>] <path> <path> [<pathspec>...]"),
 	NULL
 };
 
 int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 		  int implicit_no_index, int argc, const char **argv)
 {
-	int i, no_index;
+	struct pathspec pathspec, *ps = NULL;
+	int i, no_index, skip1 = 0, skip2 = 0;
 	int ret = 1;
 	const char *paths[2];
 	char *to_free[ARRAY_SIZE(paths)] = { 0 };
@@ -317,13 +350,12 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	options = add_diff_options(no_index_options, &revs->diffopt);
 	argc = parse_options(argc, argv, revs->prefix, options,
 			     diff_no_index_usage, 0);
-	if (argc != 2) {
+	if (argc < 2) {
 		if (implicit_no_index)
 			warning(_("Not a git repository. Use --no-index to "
 				  "compare two paths outside a working tree"));
 		usage_with_options(diff_no_index_usage, options);
 	}
-	FREE_AND_NULL(options);
 	for (i = 0; i < 2; i++) {
 		const char *p = argv[i];
 		if (!strcmp(p, "-"))
@@ -337,7 +369,23 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 		paths[i] = p;
 	}
 
-	fixup_paths(paths, &replacement);
+	if (fixup_paths(paths, &replacement)) {
+		parse_pathspec(&pathspec, PATHSPEC_FROMTOP | PATHSPEC_ATTR,
+			       PATHSPEC_PREFER_FULL | PATHSPEC_NO_REPOSITORY,
+			       NULL, &argv[2]);
+		if (pathspec.nr)
+			ps = &pathspec;
+
+		skip1 = strlen(paths[0]);
+		skip1 += paths[0][skip1] == '/' ? 0 : 1;
+		skip2 = strlen(paths[1]);
+		skip2 += paths[1][skip2] == '/' ? 0 : 1;
+	} else if (argc > 2) {
+		warning(_("Limiting comparison with pathspecs is only "
+			  "supported if both paths are directories."));
+		usage_with_options(diff_no_index_usage, options);
+	}
+	FREE_AND_NULL(options);
 
 	revs->diffopt.skip_stat_unmatch = 1;
 	if (!revs->diffopt.output_format)
@@ -354,7 +402,8 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	setup_diff_pager(&revs->diffopt);
 	revs->diffopt.flags.exit_with_status = 1;
 
-	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0))
+	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0, ps,
+		       skip1, skip2))
 		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
@@ -370,5 +419,7 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	for (i = 0; i < ARRAY_SIZE(to_free); i++)
 		free(to_free[i]);
 	strbuf_release(&replacement);
+	if (ps)
+		clear_pathspec(ps);
 	return ret;
 }
diff --git a/Documentation/git-diff.adoc b/Documentation/git-diff.adoc
index dec173a34517..272331afbaec 100644
--- a/Documentation/git-diff.adoc
+++ b/Documentation/git-diff.adoc
@@ -14,7 +14,7 @@ git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
 git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
 git diff [<options>] <commit>...<commit> [--] [<path>...]
 git diff [<options>] <blob> <blob>
-git diff [<options>] --no-index [--] <path> <path>
+git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -31,14 +31,18 @@ files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-`git diff [<options>] --no-index [--] <path> <path>`::
+`git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]`::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
 	running the command in a working tree controlled by Git and
 	at least one of the paths points outside the working tree,
 	or when running the command outside a working tree
-	controlled by Git. This form implies `--exit-code`.
+	controlled by Git. This form implies `--exit-code`. If both
+	paths point to directories, additional pathspecs may be
+	provided. These will limit the files included in the
+	difference. All such pathspecs must be relative as they
+	apply to both sides of the diff.
 
 `git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]`::
 
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 5e5bad61ca1e..01db9243abfe 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -295,4 +295,79 @@ test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff --no-index F F rejects pathspecs' '
+	test_must_fail git diff --no-index -- a/1 a/2 a 2>actual.err &&
+	test_grep "usage: git diff --no-index" actual.err
+'
+
+test_expect_success 'diff --no-index D F rejects pathspecs' '
+	test_must_fail git diff --no-index -- a a/2 a 2>actual.err &&
+	test_grep "usage: git diff --no-index" actual.err
+'
+
+test_expect_success 'diff --no-index F D rejects pathspecs' '
+	test_must_fail git diff --no-index -- a/1 b b 2>actual.err &&
+	test_grep "usage: git diff --no-index" actual.err
+'
+
+test_expect_success 'diff --no-index rejects absolute pathspec' '
+	test_must_fail git diff --no-index -- a b $(pwd)/a/1
+'
+
+test_expect_success 'diff --no-index with pathspec' '
+	test_expect_code 1 git diff --name-status --no-index a b 1 >actual &&
+	cat >expect <<-EOF &&
+	D	a/1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --no-index with pathspec no matches' '
+	test_expect_code 0 git diff --name-status --no-index a b missing
+'
+
+test_expect_success 'diff --no-index with negative pathspec' '
+	test_expect_code 1 git diff --name-status --no-index a b ":!2" >actual &&
+	cat >expect <<-EOF &&
+	D	a/1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup nested' '
+	mkdir -p c/1/2 &&
+	mkdir -p d/1/2 &&
+	echo 1 >c/1/2/a &&
+	echo 2 >c/1/2/b
+'
+
+test_expect_success 'diff --no-index with pathspec nested negative pathspec' '
+	test_expect_code 0 git diff --no-index c d ":!1"
+'
+
+test_expect_success 'diff --no-index with pathspec nested pathspec' '
+	test_expect_code 1 git diff --name-status --no-index c d 1/2 >actual &&
+	cat >expect <<-EOF &&
+	D	c/1/2/a
+	D	c/1/2/b
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --no-index with pathspec glob' '
+	test_expect_code 1 git diff --name-status --no-index c d ":(glob)**/a" >actual &&
+	cat >expect <<-EOF &&
+	D	c/1/2/a
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --no-index with pathspec glob and exclude' '
+	test_expect_code 1 git diff --name-status --no-index c d ":(glob,exclude)**/a" >actual &&
+	cat >expect <<-EOF &&
+	D	c/1/2/b
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.48.1.397.gec9d649cc640

