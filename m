Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645DA1F5827
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340578; cv=none; b=CWEWgAi+XSBxsVfPN6NPbaUySkL/sYGUvbdWr3qQ2gCKlBEXi3ey5LvcjIbNX2SxPxpSTvQ75HGi4dDoKjXolLLgOrpYoINfpDxPKQpK0GivQvwfa0miy01l806kg8OBCg6c5Z7BOIUjelNyp5B6SAeWsWYVtqL7sc1ZUX2EPac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340578; c=relaxed/simple;
	bh=ap3szIxVcj/R/OKo2YMhJMU/roFllBmMTtU2IIa0CL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8oOSX3vQhT5bS+jGl7x6WZm+Qut/CsOoZ/PTlXrvxYAh2391XyyNn24pIK/ZOVXjYqQERqUVik7+x8+RQy/eRZFq2Zs7TwcS6HwpYGujGKGgaNRUZuC1DtYQzl8Jxu7FrxrUcECRwViaxFhGaCKXjvawL/Xch7R+TsFbZMCg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldadxDib; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldadxDib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747340577; x=1778876577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ap3szIxVcj/R/OKo2YMhJMU/roFllBmMTtU2IIa0CL0=;
  b=ldadxDibNqW6AUSTwgbI/29684arEwvjjv4B/Tord14IHvUwre2uURWC
   MhpidUrDmPz1gAvM56K3fiikykrWgqFmN9twbDmuufeK+9kuTy+1Dd/mc
   qJzjV6hTS1NVkLSeYqmsxKKPjS8aWYhHKl4XReQxDYGeSNuOZ8oMOfZtb
   IEY7Ycmft7zQUIWYSR2egNHQfPfj2zZta5JcdzQf3bXXCuj+ctbjCY+I8
   6qWuomboAqb9QuPxZBKwUB9O73ZT2rniheKuwCPKETFi+8cvD3QUrP2qo
   sUa3EBvVsMWe+5aaAgTDnTcKY8nwCXezjUDpP+4hI8ffLjpFOPRT+FmVn
   w==;
X-CSE-ConnectionGUID: 4G1WdhRXQG2zr4p6kK0avw==
X-CSE-MsgGUID: RsiadFGJRHaEygDSXXnFNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48993245"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="48993245"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:22:56 -0700
X-CSE-ConnectionGUID: x7+18jr2Qkq+IydPHQ/WQg==
X-CSE-MsgGUID: 1kMVEAhASRaJHRwI/FE8zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="175602366"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:22:56 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH RFC v2] diff --no-index: support limiting by pathspec
Date: Thu, 15 May 2025 13:22:50 -0700
Message-ID: <20250515202250.3293814-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.48.1.397.gec9d649cc640
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

This is because the --no-index mode already employs some DWIM shortcuts
when dealing with comparing a directory and a file.

Executing git diff --no-index D F is interpreted as if:

  $ git diff --no-index D/$(basename F) F

Similarly, if you do git diff --no-index F D.

Modify the fixup_paths function to return 1 if both paths are
directories. If this is the case, interpret any extra arguments to git
diff as pathspecs via parse_pathspec. Add a new PATHSPEC_NO_REPOSITORY
flag to indicate to the parser that we do not have repository. Use this
to aid in error message reporting in the event that the user happens to
invoke git diff --no-index from a repository.

Extend the prefix_path_gently function to correctly handle a prefix
which does not end in '/', by inserting one as appropriate.

Use parse_pathspec to load the remaining arguments (if any) to git diff
--no-index as pathspec items. Disable PATHSPEC_ATTR support since we do
not have a repository to do attribute lookup. Disable PATHSPEC_FROMTOP
since we do not have a repository root. All pathspecs are treated as
rooted at the provided comparison paths.

Load the pathspecs twice, once prefixed with paths[0] and once prefixed
with paths[1]. I considered trying to avoid this, but don't yet have a
workable solution that reuses the same pathspec objects. We need the
directory paths as prefixes otherwise the match_pathspec won't compare
properly.

Pass the pathspec object for both paths into queue_diff, who in-turn
passes these along to read_directory_contents.

Modify read_directory_contents to check against the pathspecs when
scanning the directory. In order to properly recurse, we must handle
leading directory checks. Thus, a new "match_leading_pathspecs" variant
is created, which sets the DO_MATCH_LEADING_PATHSPEC flag. This is
required to correctly handle nested directories. Consider this:

  $ git diff --no-index a b c/d

This should include all paths in a and b which match the c/d pathspec.
In particular, if there was 'a/c/d' we need to match it. But to check
'a/c/d', we need to first get to that part, which requires comparing
'a/c' first. Without DO_MATCH_LEADING_PATHSPEC, 'a/c' won't match the
'a/c/d' pathspec string.

This implementation appears to work ok, but I still need to create some
unit tests. I also think this might be a little hacky, and I am not sure
how folks feel about parsing separate pathspecs for both entries.

Some other gotchas and open questions:

 1) pathspecs must all come after the first two path arguments, you
    can't re-arrange them to come first. I'm treating them sort of like
    the treeish arguments to git diff-tree.

 2) The pathspecs are interpreted relative to the provided paths, and
    thus will always need to be specified as relative paths, and will be
    interpreted as relative to the root of the search for each path
    separately.

 3) negative pathspecs have to be fully qualified from the root, i.e.
    ':(exclude)file' will only exclude 'a/file' and not 'a/b/file'
    unless you also use '(glob)' or similar. I think this matches the
    other pathspec support, but I an not 100% sure.

I feel like some of these changes are a bit hacky and could use some
further refinement or suggestion, but the core idea appears to work
reasonably well!

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
This version uses pathspecs and hopefully works in a reasonable enough way
to not be too confusing. Still needs tests, likely needs to be broken up
into smaller pieces, or some of the hacks need to be smoothed over. I
have executed this, but didn't run the full test suite yet.

 pathspec.h      | 10 ++++++
 diff-no-index.c | 85 ++++++++++++++++++++++++++++++++++++++++---------
 dir.c           | 24 ++++++++++++--
 pathspec.c      |  7 +++-
 setup.c         |  4 ++-
 5 files changed, 110 insertions(+), 20 deletions(-)

diff --git a/pathspec.h b/pathspec.h
index de537cff3cb6..363fb6309663 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -76,6 +76,11 @@ struct pathspec {
  * allowed, then it will automatically set for every pathspec.
  */
 #define PATHSPEC_LITERAL_PATH (1<<6)
+/*
+ * For git diff --no-index, indicate that we are operating without
+ * a repository or index.
+ */
+#define PATHSPEC_NO_REPOSITORY (1<<7)
 
 /**
  * Given command line arguments and a prefix, convert the input to
@@ -184,6 +189,11 @@ int match_pathspec(struct index_state *istate,
 		   const char *name, int namelen,
 		   int prefix, char *seen, int is_dir);
 
+int match_leading_pathspec(struct index_state *istate,
+			   const struct pathspec *ps,
+			   const char *name, int namelen,
+			   int prefix, char *seen, int is_dir);
+
 /*
  * Determine whether a pathspec will match only entire index entries (non-sparse
  * files and/or entire sparse directories). If the pathspec has the potential to
diff --git a/diff-no-index.c b/diff-no-index.c
index 9739b2b268b9..4535d032c27f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,20 +15,43 @@
 #include "gettext.h"
 #include "revision.h"
 #include "parse-options.h"
+#include "pathspec.h"
 #include "string-list.h"
 #include "dir.h"
 
-static int read_directory_contents(const char *path, struct string_list *list)
+static int read_directory_contents(const char *path, struct string_list *list,
+				   const struct pathspec *pathspec)
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
+		len = match.len;
+	}
 
+	while ((e = readdir_skip_dot_and_dotdot(dir))) {
+		if (pathspec) {
+			strbuf_setlen(&match, len);
+			strbuf_addstr(&match, e->d_name);
+
+			if (!match_leading_pathspec(NULL, pathspec,
+						    match.buf, match.len,
+						    0, NULL,
+						    e->d_type == DT_DIR ? 1 : 0))
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
@@ -131,7 +154,8 @@ static struct diff_filespec *noindex_filespec(const struct git_hash_algo *algop,
 }
 
 static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
-		      const char *name1, const char *name2, int recursing)
+		      const char *name1, const char *name2, int recursing,
+		      const struct pathspec *ps1, const struct pathspec *ps2)
 {
 	int mode1 = 0, mode2 = 0;
 	enum special special1 = SPECIAL_NONE, special2 = SPECIAL_NONE;
@@ -171,9 +195,9 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory_contents(name1, &p1))
+		if (name1 && read_directory_contents(name1, &p1, ps1))
 			return -1;
-		if (name2 && read_directory_contents(name2, &p2)) {
+		if (name2 && read_directory_contents(name2, &p2, ps2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
@@ -218,7 +242,7 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 				n2 = buffer2.buf;
 			}
 
-			ret = queue_diff(o, algop, n1, n2, 1);
+			ret = queue_diff(o, algop, n1, n2, 1, ps1, ps2);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
@@ -258,8 +282,10 @@ static void append_basename(struct strbuf *path, const char *dir, const char *fi
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
@@ -282,25 +308,30 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
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
+	struct pathspec pathspec1, pathspec2, *ps1 = NULL, *ps2 = NULL;
 	int i, no_index;
 	int ret = 1;
 	const char *paths[2];
@@ -317,7 +348,7 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	options = add_diff_options(no_index_options, &revs->diffopt);
 	argc = parse_options(argc, argv, revs->prefix, options,
 			     diff_no_index_usage, 0);
-	if (argc != 2) {
+	if (argc < 2) {
 		if (implicit_no_index)
 			warning(_("Not a git repository. Use --no-index to "
 				  "compare two paths outside a working tree"));
@@ -337,7 +368,27 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 		paths[i] = p;
 	}
 
-	fixup_paths(paths, &replacement);
+	/* TODO: should we try to catch pathspec-like paths first and warn or
+	 * error? We accepted those as valid 'paths' before so it seems
+	 * unlikely we can change that behavior.
+	 */
+	if (fixup_paths(paths, &replacement)) {
+		parse_pathspec(&pathspec1, PATHSPEC_FROMTOP | PATHSPEC_ATTR,
+			       PATHSPEC_PREFER_FULL | PATHSPEC_NO_REPOSITORY,
+			       paths[0], &argv[2]);
+		if (pathspec1.nr)
+			ps1 = &pathspec1;
+
+		parse_pathspec(&pathspec2, PATHSPEC_FROMTOP | PATHSPEC_ATTR,
+			       PATHSPEC_PREFER_FULL | PATHSPEC_NO_REPOSITORY,
+			       paths[1], &argv[2]);
+		if (pathspec2.nr)
+			ps2 = &pathspec2;
+	} else if (argc > 2) {
+		warning(_("Limiting comparison with pathspecs is only "
+			  "supported if both paths are directories."));
+		usage_with_options(diff_no_index_usage, options);
+	}
 
 	revs->diffopt.skip_stat_unmatch = 1;
 	if (!revs->diffopt.output_format)
@@ -354,7 +405,7 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	setup_diff_pager(&revs->diffopt);
 	revs->diffopt.flags.exit_with_status = 1;
 
-	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0))
+	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0, ps1, ps2))
 		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
@@ -370,5 +421,9 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	for (i = 0; i < ARRAY_SIZE(to_free); i++)
 		free(to_free[i]);
 	strbuf_release(&replacement);
+	if (ps1)
+		clear_pathspec(ps1);
+	if (ps2)
+		clear_pathspec(ps2);
 	return ret;
 }
diff --git a/dir.c b/dir.c
index a374972b6243..7f6079475397 100644
--- a/dir.c
+++ b/dir.c
@@ -397,9 +397,13 @@ static int match_pathspec_item(struct index_state *istate,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
-	if (item->attr_match_nr &&
-	    !match_pathspec_attrs(istate, name - prefix, namelen + prefix, item))
-		return 0;
+	if (item->attr_match_nr) {
+		/* TODO: is there a better way to handle this? */
+		if (!istate)
+			BUG("magic PATHSPEC_ATTR requires an index");
+		if (!match_pathspec_attrs(istate, name - prefix, namelen + prefix, item))
+			return 0;
+	}
 
 	/* If the match was just the prefix, we matched */
 	if (!*match)
@@ -577,6 +581,20 @@ int match_pathspec(struct index_state *istate,
 					 prefix, seen, flags);
 }
 
+int match_leading_pathspec(struct index_state *istate,
+			   const struct pathspec *ps,
+			   const char *name, int namelen,
+			   int prefix, char *seen, int is_dir)
+{
+	unsigned flags = DO_MATCH_LEADING_PATHSPEC;
+
+	if (is_dir)
+		flags |= DO_MATCH_DIRECTORY;
+
+	return match_pathspec_with_flags(istate, ps, name, namelen,
+					 prefix, seen, flags);
+}
+
 /**
  * Check if a submodule is a superset of the pathspec
  */
diff --git a/pathspec.c b/pathspec.c
index 2b4e434bc0aa..7a46da50dc77 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -492,7 +492,12 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		if (!match) {
 			const char *hint_path;
 
-			if (!have_git_dir())
+			/* TODO: should we have a different error message?
+			 * Really, we can't have absolute paths for pathspec
+			 * in git diff --no-index since it must be relative to
+			 * both directories in order to work at all.
+			 */
+			if ((flags & PATHSPEC_NO_REPOSITORY) || !have_git_dir())
 				die(_("'%s' is outside the directory tree"),
 				    copyfrom);
 			hint_path = repo_get_work_tree(the_repository);
diff --git a/setup.c b/setup.c
index f93bd6a24a5d..56ebf1218442 100644
--- a/setup.c
+++ b/setup.c
@@ -139,7 +139,9 @@ char *prefix_path_gently(const char *prefix, int len,
 			return NULL;
 		}
 	} else {
-		sanitized = xstrfmt("%.*s%s", len, len ? prefix : "", path);
+		sanitized = xstrfmt("%.*s%s%s", len, len ? prefix : "",
+				    len && prefix[len - 1] == '/' ? "" : "/",
+				    path);
 		if (remaining_prefix)
 			*remaining_prefix = len;
 		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
-- 
2.48.1.397.gec9d649cc640

