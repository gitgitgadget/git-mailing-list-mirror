Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64956B72
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193180; cv=none; b=C4n99YdObMlIyaBhhlbEeKpgF5JmfBosaI3d0YY6vOhPYvjVyUCBYWaYVdGAidIFhZX02kT3htKrjaYg5UxnbLIvw9Smn8V3GcWrwl5jldQNBEDq9oeBKLqkTsL6LHHUef+T3H9oa/tGLnpRwQbiF7nadHLH+erMqhQR+tGbgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193180; c=relaxed/simple;
	bh=WJ9YDSUzn+SYZm0anPDTFnNO/tJa7ehfRYugY2PjtJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUqf6ijOdu13NfmdcpHktzv3R5Dv+UedUlrFQsjSR559f/omBzix0J9Cn0oCnW1pV2q/l6BLR8HAwCV/UEnQWkluciEZpWPJOn+rjRKfQaaKEqwtcNeN9LmHwiTOeSbEAGuVVq/yBoHvbB/7tB2EI5WnN0jHREnHbJfymG3+6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>
Subject: [PATCH v3 1/2] diff: implement config.diff.renames=copies-harder
Date: Mon, 11 Mar 2024 21:38:53 +0000
Message-ID: <20240311213928.1872437-2-sam@gentoo.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311213928.1872437-1-sam@gentoo.org>
References: <20240311213928.1872437-1-sam@gentoo.org>
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

Signed-off-by: Sam James <sam@gentoo.org>
---
 Documentation/config/diff.txt   |  8 +++++---
 Documentation/config/status.txt |  4 +++-
 diff.c                          | 11 +++++++++--
 diff.h                          |  1 +
 diffcore-rename.c               |  6 ++++--
 merge-ort.c                     |  2 +-
 merge-recursive.c               |  2 +-
 7 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 6c7e09a1ef..d50bae8c66 100644
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
index 2ff8237f8f..5236088878 100644
--- a/Documentation/config/status.txt
+++ b/Documentation/config/status.txt
@@ -33,7 +33,9 @@ status.renames::
 	Whether and how Git detects renames in linkgit:git-status[1] and
 	linkgit:git-commit[1] .  If set to "false", rename detection is
 	disabled. If set to "true", basic rename detection is enabled.
-	If set to "copies" or "copy", Git will detect copies, as well.
+	If set to "copies" or "copy", Git will detect copies, as well.  If set
+	to "copies-harder", Git will spend extra cycles to find more copies even
+	in unmodified paths, see '--find-copies-harder' in linkgit:git-diff[1].
 	Defaults to the value of diff.renames.
 
 status.showStash::
diff --git a/diff.c b/diff.c
index e50def4538..a6433dec30 100644
--- a/diff.c
+++ b/diff.c
@@ -204,6 +204,8 @@ int git_config_rename(const char *var, const char *value)
 {
 	if (!value)
 		return DIFF_DETECT_RENAME;
+	if (!strcasecmp(value, "copies-harder"))
+		return DIFF_DETECT_COPY_HARDER;
 	if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
 		return  DIFF_DETECT_COPY;
 	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
@@ -4848,8 +4850,12 @@ void diff_setup_done(struct diff_options *options)
 	else
 		options->flags.diff_from_contents = 0;
 
-	if (options->flags.find_copies_harder)
+	/* Just fold this in as it makes the patch-to-git smaller */
+	if (options->flags.find_copies_harder ||
+	    options->detect_rename == DIFF_DETECT_COPY_HARDER) {
+		options->flags.find_copies_harder = 1;
 		options->detect_rename = DIFF_DETECT_COPY;
+	}
 
 	if (!options->flags.relative_name)
 		options->prefix = NULL;
@@ -5280,7 +5286,8 @@ static int diff_opt_find_copies(const struct option *opt,
 	if (*arg != 0)
 		return error(_("invalid argument to %s"), opt->long_name);
 
-	if (options->detect_rename == DIFF_DETECT_COPY)
+	if (options->detect_rename == DIFF_DETECT_COPY ||
+	    options->detect_rename == DIFF_DETECT_COPY_HARDER)
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
index 5a6e2bcac7..d54078de7d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -299,7 +299,8 @@ static int find_identical_files(struct hashmap *srcs,
 		}
 		/* Give higher scores to sources that haven't been used already */
 		score = !source->rename_used;
-		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
+		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY &&
+		    options->detect_rename != DIFF_DETECT_COPY_HARDER)
 			continue;
 		score += basename_same(source, target);
 		if (score > best_score) {
@@ -1405,7 +1406,8 @@ void diffcore_rename_extended(struct diff_options *options,
 	trace2_region_enter("diff", "setup", options->repo);
 	info.setup = 0;
 	assert(!dir_rename_count || strmap_empty(dir_rename_count));
-	want_copies = (detect_rename == DIFF_DETECT_COPY);
+	want_copies = (detect_rename == DIFF_DETECT_COPY ||
+		       detect_rename == DIFF_DETECT_COPY_HARDER);
 	if (dirs_removed && (break_idx || want_copies))
 		BUG("dirs_removed incompatible with break/copy detection");
 	if (break_idx && relevant_sources)
diff --git a/merge-ort.c b/merge-ort.c
index 817f7b57c7..bfb895544b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4788,7 +4788,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * sanity check them anyway.
 	 */
 	assert(opt->detect_renames >= -1 &&
-	       opt->detect_renames <= DIFF_DETECT_COPY);
+	       opt->detect_renames <= DIFF_DETECT_COPY_HARDER);
 	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
 	assert(opt->buffer_output <= 2);
 	assert(opt->obuf.len == 0);
diff --git a/merge-recursive.c b/merge-recursive.c
index d58c05ad2c..9e59c75b3e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3704,7 +3704,7 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 	assert(opt->branch1 && opt->branch2);
 
 	assert(opt->detect_renames >= -1 &&
-	       opt->detect_renames <= DIFF_DETECT_COPY);
+	       opt->detect_renames <= DIFF_DETECT_COPY_HARDER);
 	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
 	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
 	assert(opt->rename_limit >= -1);
-- 
2.44.0

