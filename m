Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BDF4E1
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] diff: implement config.diff.renames=copies-harder
Date: Tue, 26 Dec 2023 20:20:17 +0000
Message-ID: <20231226202102.3392518-1-sam@gentoo.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a config value for 'diff.renames' called 'copies-harder'
which make it so '-C -C' is in effect always passed for 'git log -p',
'git diff', etc.

This allows specifying that 'git log -p', 'git diff', etc should always act
as if '-C --find-copies-harder' was passed.

It has proven this especially useful for certain types of repository (like
Gentoo's ebuild repositories) because files are often copies of a previous
version:

Suppose a directory 'sys-devel/gcc' contains recipes for building
GCC, with one file for each supported upstream branch:
   gcc-13.x.build.recipe
   gcc-12.x.build.recipe
   gcc-11.x.build.recipe
   gcc-10.x.build.recipe

gcc-13.x.build.recipe was started as a copy of gcc-12.x.build.recipe
(which was started as a copy of gcc-11.x.build.recipe, etc.). Previous versions
are kept around to support parallel installation of multiple versions.

Being able to easily observe the diff relative to other recipes within the
directory has been a quality of life improvement for such repo layouts.

Cc: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Sam James <sam@gentoo.org>
---
v2: Improve the commit message using Elijah Newren's example (it is indeed
precisely what I was thinking of, but phrased better), and improve the documentation
to explain better what the new config option actually does & refer to git-diff's
--find-copies-harder.

 Documentation/config/diff.txt   |  8 +++++---
 Documentation/config/status.txt |  3 ++-
 diff.c                          | 12 +++++++++---
 diff.h                          |  1 +
 diffcore-rename.c               |  4 ++--
 merge-ort.c                     |  2 +-
 merge-recursive.c               |  2 +-
 7 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index bd5ae0c337..cdd8a74ec0 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -131,9 +131,11 @@ diff.renames::
 	Whether and how Git detects renames.  If set to "false",
 	rename detection is disabled. If set to "true", basic rename
 	detection is enabled.  If set to "copies" or "copy", Git will
-	detect copies, as well.  Defaults to true.  Note that this
-	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
-	linkgit:git-log[1], and not lower level commands such as
+	detect copies, as well.  If set to "copies-harder", Git will spend extra
+	cycles to find more copies even in unmodified paths, see
+	'--find-copies-harder' in linkgit:git-diff[1]. Defaults to true.
+	Note that this affects only 'git diff' Porcelain like linkgit:git-diff[1]
+	and linkgit:git-log[1], and not lower level commands such as
 	linkgit:git-diff-files[1].
 
 diff.suppressBlankEmpty::
diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
index 2ff8237f8f..7ca7a4becd 100644
--- a/Documentation/config/status.txt
+++ b/Documentation/config/status.txt
@@ -33,7 +33,8 @@ status.renames::
 	Whether and how Git detects renames in linkgit:git-status[1] and
 	linkgit:git-commit[1] .  If set to "false", rename detection is
 	disabled. If set to "true", basic rename detection is enabled.
-	If set to "copies" or "copy", Git will detect copies, as well.
+	If set to "copies" or "copy", Git will detect copies, as well.  If
+	set to "copies-harder", Git will try harder to detect copies.
 	Defaults to the value of diff.renames.
 
 status.showStash::
diff --git a/diff.c b/diff.c
index a2def45644..585acf9a99 100644
--- a/diff.c
+++ b/diff.c
@@ -206,8 +206,11 @@ int git_config_rename(const char *var, const char *value)
 {
 	if (!value)
 		return DIFF_DETECT_RENAME;
+	if (!strcasecmp(value, "copies-harder"))
+		return DIFF_DETECT_COPY_HARDER;
 	if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
-		return  DIFF_DETECT_COPY;
+		return DIFF_DETECT_COPY;
+
 	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
 }
 
@@ -4849,8 +4852,11 @@ void diff_setup_done(struct diff_options *options)
 	else
 		options->flags.diff_from_contents = 0;
 
-	if (options->flags.find_copies_harder)
+	/* Just fold this in as it makes the patch-to-git smaller */
+	if (options->flags.find_copies_harder || options->detect_rename == DIFF_DETECT_COPY_HARDER) {
+		options->flags.find_copies_harder = 1;
 		options->detect_rename = DIFF_DETECT_COPY;
+	}
 
 	if (!options->flags.relative_name)
 		options->prefix = NULL;
@@ -5281,7 +5287,7 @@ static int diff_opt_find_copies(const struct option *opt,
 	if (*arg != 0)
 		return error(_("invalid argument to %s"), opt->long_name);
 
-	if (options->detect_rename == DIFF_DETECT_COPY)
+	if (options->detect_rename == DIFF_DETECT_COPY || options->detect_rename == DIFF_DETECT_COPY_HARDER)
 		options->flags.find_copies_harder = 1;
 	else
 		options->detect_rename = DIFF_DETECT_COPY;
diff --git a/diff.h b/diff.h
index 66bd8aeb29..b29e5b777f 100644
--- a/diff.h
+++ b/diff.h
@@ -555,6 +555,7 @@ int git_config_rename(const char *var, const char *value);
 
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
+#define DIFF_DETECT_COPY_HARDER 3
 
 #define DIFF_PICKAXE_ALL	1
 #define DIFF_PICKAXE_REGEX	2
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5a6e2bcac7..856291d66f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -299,7 +299,7 @@ static int find_identical_files(struct hashmap *srcs,
 		}
 		/* Give higher scores to sources that haven't been used already */
 		score = !source->rename_used;
-		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
+		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY && options->detect_rename != DIFF_DETECT_COPY_HARDER)
 			continue;
 		score += basename_same(source, target);
 		if (score > best_score) {
@@ -1405,7 +1405,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	trace2_region_enter("diff", "setup", options->repo);
 	info.setup = 0;
 	assert(!dir_rename_count || strmap_empty(dir_rename_count));
-	want_copies = (detect_rename == DIFF_DETECT_COPY);
+	want_copies = (detect_rename == DIFF_DETECT_COPY || detect_rename == DIFF_DETECT_COPY_HARDER);
 	if (dirs_removed && (break_idx || want_copies))
 		BUG("dirs_removed incompatible with break/copy detection");
 	if (break_idx && relevant_sources)
diff --git a/merge-ort.c b/merge-ort.c
index 6491070d96..7749835465 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4782,7 +4782,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * sanity check them anyway.
 	 */
 	assert(opt->detect_renames >= -1 &&
-	       opt->detect_renames <= DIFF_DETECT_COPY);
+	       opt->detect_renames <= DIFF_DETECT_COPY_HARDER);
 	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
 	assert(opt->buffer_output <= 2);
 	assert(opt->obuf.len == 0);
diff --git a/merge-recursive.c b/merge-recursive.c
index e3beb0801b..d52dd53660 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3708,7 +3708,7 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 	assert(opt->branch1 && opt->branch2);
 
 	assert(opt->detect_renames >= -1 &&
-	       opt->detect_renames <= DIFF_DETECT_COPY);
+	       opt->detect_renames <= DIFF_DETECT_COPY_HARDER);
 	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
 	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
 	assert(opt->rename_limit >= -1);
-- 
2.43.0

