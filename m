Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D249690C
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461264; cv=none; b=ExOYyZPJIbHCNsHIgv0YKME8gtol0g2dlbx7UnFMfJh/k3Emc67HQBuUsgR65Zgf/Tc30/U3aV912aHdmE7NYg0WIfp7mzroeHuvuFbd78CvtMg9xmMGMrXu+Tohc+sTqgfb5d0BIvdXFTowKp5k5xfEv2lDgECOUqJBWQSNu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461264; c=relaxed/simple;
	bh=oOVGuH4JhAn3r44Fg3/1n2Ltcew3TDupbJOfTBpCZL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt/mAjZwofdQizPzqEN2vYNzlVLqu+u0/q4zi9xe0W/GOtxGPMUbc1u1jggXJ1mzInOhKQRFe3r2NJH4q/jZ/taGwdinFXe2QHNyf3AaNSzOmqsO8iS8QatO1FeYpwTbg1XDVmGV2M6OhbXzZfplMN2ned/K6g3oN9nr0Pst3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=JNTbGwo0; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="JNTbGwo0"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1791461254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOqWu+LK8pm5+/Q3nmEOE9Kt+Mj2mmSdPfWInzG5/OY=;
	b=JNTbGwo02OqKjp/fqYfR6iss20oFBozjKQzF7p9Trs9vF2AxOqefC73x7XAYZoH2ZCK1vG
	UWM/xBCqEtyk/EM/2BTWQ/yqdAQcrpIS++qFWnqwrgjkkJI/pDLR369YNrQhAhG68seJmt
	Spe/vSjmVaQkcB/tIa5DsHCEj/2cD8OojNxNi/uJoONrAoZGBUpdUhCWz76D9I3NppHJrt
	fvm7tyEcpOQvYR1M0Z6RKNtzcjgsJi1EfQcnm7vaPSh05zPMFZDgLqbW7CWLfJ3pVEBpmd
	B92mZQN0BltwbZh7vco/53HIWO9gu+7vkCtIauERsTw71sEBN0AWcVp5LmsNOQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [RFC PATCH 6/6] builtin/ls-files.c: support for precious files
Date: Thu,  8 Oct 2026 14:07:02 +0200
Message-ID: <f5abaac0ff3b1d4598fa27bbcf338e1a36a08098.1791460418.git.mroik@delayed.space>
In-Reply-To: <cover.1791460418.git.mroik@delayed.space>
References: <cover.1791460418.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14002; i=mroik@delayed.space; h=from:subject:message-id; bh=oOVGuH4JhAn3r44Fg3/1n2Ltcew3TDupbJOfTBpCZL0=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqx4djnsjWD++ELOmJZHlm+o3XmQ/rvYzC2YvXi 55Szmlqp3SJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaseHYwAKCRBIeX6hnBm+ 0UVHD/9aWcORZq8DiC/mSBTB30+H4a1sg/r92COYFmCUNGQWt49LogsxwrewcaN85iFyombwiwA LVJcLNi+bDx/ZNN4q7YX1ybMX7vpa5Ilh3uxDD3PYXxUkrW3lrKOSjjIry4cT3BMnkpZBZxRpcm xOEAuZa6UpiPcSsq7BqHcKhEf8TktkvexjDBDSLBCjvyTjSrWPVyCzZyG3XaHK32/GxHUXP9he8 GA6iS9AfmUlz0ZduottWk+moGpRKGwrlYTKBdFFvG0nUc0JfnX2pscIZOwQMWDkikD+kHkJXfgK OuAiVV7Tyvb9kUf/wy5gRIMdGQon6sKSkNc7d14T73Rzt80EZzQ16UBIFbOFSh+zLxIO8o/956b IwTTH6RYwD+euweocKTqNSJJ/potIpXG4hiJukijocYlhRztPBswDAV4DejC1WA/nyBXvL7E9ce rjjwwCvYKzgIaJcXo+QbTmhscTbiP8lijiB3T/cWXpjhXprriGnzryAyT4RzavV3kRpMh9r7bSh QLp1tlW75/ATtU03Hqz88FkPUVpjmtyKVDB5Mt/eeYALhUILuZM3nyHvxpgv8Ggw7dCDg3pWGsc uj8ly5Jrnp5s/qsks2/2m703TtxJOUiVjIs7nvnarMKX8rC0ELClkc72IVcvXw7f5K6GpYj8Dtc z1phjb5g
 8qOlLyQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Teach "git ls-files" new variants of "-i" with --ignored=trashable
and --ignored=precious, where git shows only trashable files with the
first and only precious files with the second. If no optional argument
is passed "ls-files" retains the current behaviour.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/ls-files.c                 | 73 ++++++++++++++++++++++++++---
 dir.c                              | 74 ++++++++++++++++++++++++++----
 dir.h                              | 34 +++++++++++++-
 t/t2205-add-worktree-config.sh     |  2 +-
 t/t3001-ls-files-others-exclude.sh | 27 +++++++++++
 5 files changed, 190 insertions(+), 20 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d1cc7e92f4..63dd769385 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -163,8 +163,21 @@ static void show_dir_entry(struct index_state *istate,
 	write_name(ent->name);
 }
 
-static void show_other_files(struct index_state *istate,
-			     const struct dir_struct *dir)
+static void show_precious_files(struct index_state *istate,
+				const struct dir_struct *dir)
+{
+	int i;
+
+	for (i = 0; i < dir->precious_nr; i++) {
+		struct dir_entry *ent = dir->precious[i];
+		if (!index_name_is_other(istate, ent->name, ent->len))
+			continue;
+		show_dir_entry(istate, tag_other, ent);
+	}
+}
+
+static void show_entries_files(struct index_state *istate,
+			       const struct dir_struct *dir)
 {
 	int i;
 
@@ -176,6 +189,24 @@ static void show_other_files(struct index_state *istate,
 	}
 }
 
+static void show_ignored_files(struct index_state *istate,
+			       const struct dir_struct *dir)
+{
+	show_entries_files(istate, dir);
+	show_precious_files(istate, dir);
+}
+
+static void show_other_files(struct index_state *istate,
+			     const struct dir_struct *dir)
+{
+	if (dir->flags & DIR_SHOW_IGNORED)
+		show_ignored_files(istate, dir);
+	else if (dir->flags & DIR_SHOW_PRECIOUS)
+		show_precious_files(istate, dir);
+	else
+		show_entries_files(istate, dir);
+}
+
 static void show_killed_files(struct index_state *istate,
 			      const struct dir_struct *dir)
 {
@@ -547,6 +578,30 @@ static const char * const ls_files_usage[] = {
 	NULL
 };
 
+static int option_parse_ignored(const struct option *opt, const char *arg, int unset)
+{
+	enum dir_struct_flags *flags = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	/*
+	 * Reset in case --ignored=<type> is specified multiple times, we keep
+	 * the last one.
+	 */
+	*flags &= ~(DIR_SHOW_IGNORED | DIR_SHOW_TRASHABLE | DIR_SHOW_PRECIOUS);
+
+	if (!arg)
+		*flags |= DIR_SHOW_IGNORED;
+	else if (!strcmp(arg, "trashable"))
+		*flags |= DIR_SHOW_TRASHABLE;
+	else if (!strcmp(arg, "precious"))
+		*flags |= DIR_SHOW_PRECIOUS;
+	else
+		die(_("'%s' argument is not a valid value"), arg);
+
+	return 0;
+}
+
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -615,9 +670,9 @@ int cmd_ls_files(int argc,
 			N_("show modified files in the output")),
 		OPT_BOOL('o', "others", &show_others,
 			N_("show other files in the output")),
-		OPT_BIT('i', "ignored", &dir.flags,
+		OPT_CALLBACK_F('i', "ignored", &dir.flags, N_("type"),
 			N_("show ignored files in the output"),
-			DIR_SHOW_IGNORED),
+			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, option_parse_ignored),
 		OPT_BOOL('s', "stage", &show_stage,
 			N_("show staged contents' object name in the output")),
 		OPT_BOOL('k', "killed", &show_killed,
@@ -704,7 +759,9 @@ int cmd_ls_files(int argc,
 		tag_skip_worktree = "S ";
 		tag_resolve_undo = "U ";
 	}
-	if (show_modified || show_others || show_deleted || (dir.flags & DIR_SHOW_IGNORED) || show_killed)
+	if (show_modified || show_others || show_deleted ||
+	    (dir.flags & (DIR_SHOW_IGNORED | DIR_SHOW_TRASHABLE | DIR_SHOW_PRECIOUS)) ||
+	    show_killed)
 		require_work_tree = 1;
 	if (show_unmerged)
 		/*
@@ -753,10 +810,12 @@ int cmd_ls_files(int argc,
 	if (pathspec.nr && error_unmatch)
 		ps_matched = xcalloc(pathspec.nr, 1);
 
-	if ((dir.flags & DIR_SHOW_IGNORED) && !show_others && !show_cached)
+	if ((dir.flags & (DIR_SHOW_IGNORED | DIR_SHOW_TRASHABLE | DIR_SHOW_PRECIOUS)) &&
+	    !show_others && !show_cached)
 		die("ls-files -i must be used with either -o or -c");
 
-	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
+	if ((dir.flags & (DIR_SHOW_IGNORED | DIR_SHOW_TRASHABLE | DIR_SHOW_PRECIOUS)) &&
+	    !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
 
 	/* With no flags, we default to showing the cached files */
diff --git a/dir.c b/dir.c
index ffc1818533..274a934e12 100644
--- a/dir.c
+++ b/dir.c
@@ -281,10 +281,25 @@ int fill_directory(struct dir_struct *dir,
 {
 	const char *matched_prefix;
 	size_t prefix_len;
+	unsigned exclusive;
+	int i;
 
-	unsigned exclusive_flags = DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO;
-	if ((dir->flags & exclusive_flags) == exclusive_flags)
-		BUG("DIR_SHOW_IGNORED and DIR_SHOW_IGNORED_TOO are exclusive");
+	const unsigned exclusive_with_too[] = {
+		DIR_SHOW_IGNORED,
+		DIR_SHOW_TRASHABLE,
+		DIR_SHOW_PRECIOUS,
+	};
+	const char *exclusive_bug_text[] = {
+		"DIR_SHOW_IGNORED",
+		"DIR_SHOW_TRASHABLE",
+		"DIR_SHOW_PRECIOUS",
+	};
+	for (i = 0; i < 3; i++) {
+		exclusive = (exclusive_with_too[i] | DIR_SHOW_IGNORED_TOO);
+		if ((dir->flags & exclusive) == exclusive)
+			BUG("%s and DIR_SHOW_IGNORED_TOO are exclusive",
+			    exclusive_bug_text[i]);
+	}
 
 	/*
 	 * Calculate common prefix for the pathspec, and
@@ -1859,6 +1874,21 @@ struct path_pattern *last_matching_pattern(struct dir_struct *dir,
 			basename, dtype_p);
 }
 
+/*
+ * Loads the exclude lists for the directory containing pathname, then
+ * scans all exclude lists to determine whether pathname is precious.
+ * Returns 1 if true, otherwise 0.
+ */
+int is_precious(struct dir_struct *dir, struct index_state *istate,
+		const char *pathname, int *dtype_p)
+{
+	struct path_pattern *pattern =
+		last_matching_pattern(dir, istate, pathname, dtype_p);
+	if (pattern)
+		return !!(pattern->flags & PATTERN_FLAG_PRECIOUS);
+	return 0;
+}
+
 /*
  * Loads the exclude lists for the directory containing pathname, then
  * scans all exclude lists to determine whether pathname is trashable.
@@ -1911,6 +1941,17 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir,
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
+static struct dir_entry *dir_add_precious(struct dir_struct *dir,
+				      struct index_state *istate,
+				      const char *pathname, int len)
+{
+	if (index_file_exists(istate, pathname, len, repo_ignore_case(the_repository)))
+		return NULL;
+
+	ALLOC_GROW(dir->precious, dir->precious_nr+1, dir->internal.precious_alloc);
+	return dir->precious[dir->precious_nr++] = dir_entry_new(pathname, len);
+}
+
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
 				  const char *pathname, int len)
@@ -2528,13 +2569,18 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	    (directory_exists_in_index(istate, path->buf, path->len) == index_nonexistent))
 		return path_none;
 
-	excluded = is_excluded(dir, istate, path->buf, &dtype);
+	excluded = is_excluded(dir, istate, path->buf, &dtype) ||
+		   is_trashable(dir, istate, path->buf, &dtype) ||
+		   is_precious(dir, istate, path->buf, &dtype);
 
 	/*
 	 * Excluded? If we don't explicitly want to show
 	 * ignored files, ignore it
 	 */
-	if (excluded && !(dir->flags & (DIR_SHOW_IGNORED|DIR_SHOW_IGNORED_TOO)))
+	if (excluded && !(dir->flags & (DIR_SHOW_IGNORED|
+					DIR_SHOW_TRASHABLE|
+					DIR_SHOW_PRECIOUS|
+					DIR_SHOW_IGNORED_TOO)))
 		return path_excluded;
 
 	switch (dtype) {
@@ -2704,20 +2750,28 @@ static void add_path_to_appropriate_result_list(struct dir_struct *dir,
 	const struct pathspec *pathspec,
 	enum path_treatment state)
 {
+	int dtype;
+
 	/* add the path to the appropriate result list */
 	switch (state) {
 	case path_excluded:
-		if (dir->flags & DIR_SHOW_IGNORED)
-			dir_add_name(dir, istate, path->buf, path->len);
-		else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+		if (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_TRASHABLE | DIR_SHOW_PRECIOUS)) {
+			dtype = resolve_dtype(cdir->d_type, istate, path->buf, path->len);
+			if (is_precious(dir, istate, path->buf, &dtype))
+				dir_add_precious(dir, istate, path->buf, path->len);
+			else
+				dir_add_name(dir, istate, path->buf, path->len);
+		} else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
 			((dir->flags & DIR_COLLECT_IGNORED) &&
 			exclude_matches_pathspec(path->buf, path->len,
-						 pathspec)))
+						 pathspec))) {
 			dir_add_ignored(dir, istate, path->buf, path->len);
+		}
 		break;
 
 	case path_untracked:
-		if (dir->flags & DIR_SHOW_IGNORED)
+		if (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_TRASHABLE |
+				  DIR_SHOW_PRECIOUS))
 			break;
 		dir_add_name(dir, istate, path->buf, path->len);
 		if (cdir->fdir)
diff --git a/dir.h b/dir.h
index 5424036e4e..58e5467cda 100644
--- a/dir.h
+++ b/dir.h
@@ -212,14 +212,30 @@ struct untracked_cache {
 struct dir_struct {
 
 	/* bit-field of options */
-	enum {
+	enum dir_struct_flags {
 
 		/**
 		 * Return just ignored files in `entries[]`, not untracked files.
 		 * This flag is mutually exclusive with `DIR_SHOW_IGNORED_TOO`.
+		 * This is a superset of DIR_SHOW_TRASHABLE and DIR_SHOW_PRECIOUS.
+		 *
+		 * This flag should probably be dropped throughout the codebase
+		 * in favour of (DIR_SHOW_TRASHABLE | DIR_SHOW_PRECIOUS).
 		 */
 		DIR_SHOW_IGNORED = 1<<0,
 
+		/**
+		 * Return just trashable files in `entries[]`, not untracked files.
+		 * This flag is mutually exclusive with `DIR_SHOW_IGNORED_TOO`.
+		 */
+		DIR_SHOW_TRASHABLE = 1<<10,
+
+		/**
+		 * Return just precious files in `entries[]`, not untracked files.
+		 * This flag is mutually exclusive with `DIR_SHOW_IGNORED_TOO`.
+		 */
+		DIR_SHOW_PRECIOUS = 1<<11,
+
 		/* Include a directory that is not tracked. */
 		DIR_SHOW_OTHER_DIRECTORIES = 1<<1,
 
@@ -243,7 +259,8 @@ struct dir_struct {
 		/**
 		 * Similar to `DIR_SHOW_IGNORED`, but return ignored files in
 		 * `ignored[]` in addition to untracked files in `entries[]`.
-		 * This flag is mutually exclusive with `DIR_SHOW_IGNORED`.
+		 * This flag is mutually exclusive with `DIR_SHOW_IGNORED`,
+		 * `DIR_SHOW_TRASHABLE` and `DIR_SHOW_PRECIOUS`.
 		 */
 		DIR_SHOW_IGNORED_TOO = 1<<5,
 
@@ -278,12 +295,18 @@ struct dir_struct {
 	/* The number of members in `entries[]` array. */
 	int nr; /* output only */
 
+	/* The number of members in `precious[]` array. */
+	int precious_nr; /* output only */
+
 	/* The number of members in `ignored[]` array. */
 	int ignored_nr; /* output only */
 
 	/* An array of `struct dir_entry`, each element of which describes a path. */
 	struct dir_entry **entries; /* output only */
 
+	/* Used for listing precious files with `DIR_SHOW_PRECIOUS`. */
+	struct dir_entry **precious; /* output only */
+
 	/**
 	 * used for ignored paths with the `DIR_SHOW_IGNORED_TOO` and
 	 * `DIR_COLLECT_IGNORED` flags.
@@ -307,6 +330,9 @@ struct dir_struct {
 		/* Keeps track of allocation of `entries[]` array.*/
 		int alloc;
 
+		/* Keeps track of allocation of `precious[]` array.*/
+		int precious_alloc;
+
 		/* Keeps track of allocation of `ignored[]` array. */
 		int ignored_alloc;
 
@@ -442,6 +468,10 @@ struct path_pattern *last_matching_pattern(struct dir_struct *dir,
 					   struct index_state *istate,
 					   const char *name, int *dtype);
 
+int is_precious(struct dir_struct *dir,
+		struct index_state *istate,
+		const char *name, int *dtype);
+
 int is_trashable(struct dir_struct *dir,
 		struct index_state *istate,
 		const char *name, int *dtype);
diff --git a/t/t2205-add-worktree-config.sh b/t/t2205-add-worktree-config.sh
index 43d950de64..a743470196 100755
--- a/t/t2205-add-worktree-config.sh
+++ b/t/t2205-add-worktree-config.sh
@@ -244,7 +244,7 @@ test_expect_success '3a: setup--add repo dir' '
 test_expect_success '3b: ignored' '
 	(
 	cd test3 &&
-	git --git-dir=repo/.git ls-files -io --directory --exclude-standard >actual-ignored-unsorted &&
+	git --git-dir=repo/.git ls-files -i -o --directory --exclude-standard >actual-ignored-unsorted &&
 	sort actual-ignored-unsorted >actual-ignored &&
 	sort expect-ignored-unsorted >expect-ignored &&
 	test_cmp expect-ignored actual-ignored
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 29a0a25b30..977cbd6b6e 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -55,6 +55,7 @@ expect
 !*.8' >.git/ignore
 
 echo '*.1
+$wasder
 /*.3
 !*.6' >.gitignore
 echo '*.2
@@ -76,6 +77,32 @@ test_expect_success 'git ls-files --others with various exclude options.' '
 	test_cmp expect output
 '
 
+test_expect_success 'git ls-files -o -i' '
+	touch wasder &&
+	git ls-files -o -i --exclude-standard >output &&
+	cat output &&
+	test_grep "wasder" output
+'
+
+test_expect_success 'git ls-files -o --ignored=trashable' '
+	git ls-files -o --ignored=trashable --exclude-standard >output &&
+	cat output &&
+	test_grep ! "wasder" output
+'
+
+test_expect_success 'git ls-files -o --ignored=precious' '
+	git ls-files -o --ignored=precious --exclude-standard >output &&
+	cat output &&
+	test_grep "wasder" output
+'
+
+test_expect_success 'git ls-files -o --ignored=trashable' '
+	test_when_finished rm wasder &&
+	git ls-files -o --ignored=precious --ignored=trashable --exclude-standard >output &&
+	cat output &&
+	test_grep ! "wasder" output
+'
+
 # Test \r\n (MSDOS-like systems)
 printf '*.1\r\n/*.3\r\n!*.6\r\n' >.gitignore
 
-- 
2.56.0

