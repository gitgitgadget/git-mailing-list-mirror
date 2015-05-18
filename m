From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 11/14] pull: teach git pull about --rebase
Date: Mon, 18 May 2015 23:06:08 +0800
Message-ID: <1431961571-20370-12-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:08:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMeM-0004bU-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbbERPIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:08:09 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36664 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbbERPIC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:08:02 -0400
Received: by pdfh10 with SMTP id h10so153221326pdf.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8mrwYIJSn0n7L7qZ/MpYJqzbfT9spVf0w4bundUlI+8=;
        b=0r4/DybFziwRzuxoYpxvadkN8jV5TAWeiTbLaoOnjFhuAzpF2pS1A5goP5Iy08TFfO
         5bb6d/ozotl8uzHs2bhi41vTZHhpNeGPLfEhG2Wy9dvCdy9O2Hq8f23jSTtybacdjk1G
         +82sL7lnFmO0BOr21AxFqjwIW+ZMwTBePBBAMmfFGfb6fuQ/XQXwLVYjXBoyjcbh4Gp/
         gNXVuVhDKknViFYCUTSP/ye9kvWW/rBLjzHxnUWJO3rJriUwk5Dk4z+p+C+SzC3SvuVx
         /GO1xQqZBSGUG+uT8aewU4BOkIXhyf5q1YiVRGPjl/J1hJjP29EnnArAVe6vwRtE5SHm
         /Lrw==
X-Received: by 10.70.43.10 with SMTP id s10mr45042381pdl.57.1431961681513;
        Mon, 18 May 2015 08:08:01 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:08:00 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269270>

Since cd67e4d (Teach 'git pull' about --rebase, 2007-11-28), if the
--rebase option is set, git-rebase is run instead of git-merge.

Re-implement this by introducing run_rebase(), which is called instead
of run_merge() if opt_rebase is a true value.

Since c85c792 (pull --rebase: be cleverer with rebased upstream
branches, 2008-01-26), git-pull handles the case where the upstream
branch was rebased since it was last fetched. The fork point (old remote
ref) of the branch from the upstream branch is calculated before fetch,
and then rebased from onto the new remote head (merge_head) after fetch.

Re-implement this by introducing get_merge_branch_2() and
get_merge_branch_1() to find the upstream branch for the
specified/current branch, and get_rebase_fork_point() which will find
the fork point between the upstream branch and current branch.

However, the above change created a problem where git-rebase cannot
detect commits that are already upstream, and thus may result in
unnecessary conflicts. cf65426 (pull --rebase: Avoid spurious conflicts
and reapplying unnecessary patches, 2010-08-12) fixes this by ignoring
the above old remote ref if it is contained within the merge base of the
merge head and the current branch.

This is re-implemented in run_rebase() where fork_point is not used if
it is the merge base returned by get_octopus_merge_base().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c              | 227 +++++++++++++++++++++++++++++++++++++++++++-
 t/t5520-pull.sh             |  26 ++---
 t/t5521-pull-options.sh     |   6 +-
 t/t7406-submodule-update.sh |   2 -
 4 files changed, 241 insertions(+), 20 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 81e31a1..f18a21c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -39,6 +39,42 @@ static int parse_opt_passthru(const struct option *opt, const char *arg, int uns
 	return 0;
 }
 
+enum rebase_type {
+	REBASE_FALSE,
+	REBASE_TRUE,
+	REBASE_PRESERVE
+};
+
+/**
+ * Parses the value of --rebase, branch.*.rebase or pull.rebase. If value is a
+ * false value, returns REBASE_FALSE. If value is a true value, returns
+ * REBASE_TRUE. If value is "preserve", returns REBASE_PRESERVE. Otherwise,
+ * returns -1 to signify an invalid value.
+ */
+static int parse_config_rebase(const char *value)
+{
+	int v = git_config_maybe_bool("pull.rebase", value);
+	if (v >= 0)
+		return v;
+	if (!strcmp(value, "preserve"))
+		return REBASE_PRESERVE;
+	return -1;
+}
+
+/**
+ * Callback for --rebase, which parses arg with parse_config_rebase().
+ */
+static int parse_opt_rebase(const struct option *opt, const char *arg, int unset)
+{
+	int *value = (int*) opt->value;
+
+	if (arg)
+		*value = parse_config_rebase(arg);
+	else
+		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+	return *value >= 0 ? 0 : -1;
+}
+
 static const char * const pull_usage[] = {
 	N_("git pull [options] [<repo> [<refspec>...]]"),
 	NULL
@@ -48,7 +84,8 @@ static const char * const pull_usage[] = {
 static int opt_verbosity;
 static char *opt_progress;
 
-/* Options passed to git-merge */
+/* Options passed to git-merge or git-rebase */
+static int opt_rebase;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_squash;
@@ -82,8 +119,12 @@ static struct option pull_options[] = {
 	  N_("force progress reporting"),
 	  PARSE_OPT_NOARG, parse_opt_passthru},
 
-	/* Options passed to git-merge */
+	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
+	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
+	  N_("false|true|preserve"),
+	  N_("incorporate changes by rebasing rather than merging"),
+	  PARSE_OPT_OPTARG, parse_opt_rebase, 0},
 	{ OPTION_CALLBACK, 'n', NULL, &opt_diffstat, NULL,
 	  N_("do not show a diffstat at the end of the merge"),
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_passthru, (intptr_t) "no-stat" },
@@ -506,11 +547,185 @@ static int run_merge(void)
 	return ret;
 }
 
+/**
+ * Returns the merge branch for the current branch. Returns NULL if repo is not
+ * a valid remote, HEAD does not point to a branch, repo is not the branch's
+ * configured remote or the branch does not have any configured merge branch.
+ */
+static char *get_merge_branch_1(const char *repo)
+{
+	struct remote *rm;
+	struct branch *curr_branch;
+
+	if (repo && !(rm = remote_get(repo)))
+		return NULL;
+	if (!(curr_branch = branch_get("HEAD")))
+		return NULL;
+	if (repo && curr_branch->remote != rm)
+		return NULL;
+	if (!curr_branch->merge_nr)
+		return NULL;
+	return xstrdup(curr_branch->merge[0]->dst);
+}
+
+/**
+ * Given a refspec, returns the merge branch. Returns NULL if the refspec src
+ * does not refer to a branch.
+ *
+ * FIXME: It should return the tracking branch. Currently only works with the
+ * default mapping.
+ */
+static char *get_merge_branch_2(const char *repo, const char *refspec)
+{
+	struct refspec *spec;
+	const char *remote;
+	char *merge_branch;
+
+	spec = parse_fetch_refspec(1, &refspec);
+	remote = spec->src;
+	if (!*remote || !strcmp(remote, "HEAD"))
+		remote = "HEAD";
+	else if (skip_prefix(remote, "heads/", &remote))
+		;
+	else if (skip_prefix(remote, "refs/heads/", &remote))
+		;
+	else if (starts_with(remote, "refs/") ||
+		starts_with(remote, "tags/") ||
+		starts_with(remote, "remotes/"))
+		remote = "";
+
+	if (*remote) {
+		if (!strcmp(repo, "."))
+			merge_branch = mkpathdup("refs/heads/%s", remote);
+		else
+			merge_branch = mkpathdup("refs/remotes/%s/%s", repo, remote);
+	} else
+		merge_branch = NULL;
+
+	free_refspec(1, spec);
+	return merge_branch;
+}
+
+/**
+ * Sets fork_point to the point at which the current branch forked from its
+ * remote merge branch. Returns 0 on success, -1 on failure.
+ */
+static int get_rebase_fork_point(unsigned char fork_point[GIT_SHA1_RAWSZ],
+		const char *repo, const char *refspec)
+{
+	int ret;
+	struct branch *curr_branch;
+	char *remote_merge_branch;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!(curr_branch = branch_get("HEAD")))
+		return -1;
+
+	if (refspec)
+		remote_merge_branch = get_merge_branch_2(repo, refspec);
+	else
+		remote_merge_branch = get_merge_branch_1(repo);
+
+	if (!remote_merge_branch)
+		return -1;
+
+	argv_array_pushl(&args, "merge-base", "--fork-point",
+			remote_merge_branch, curr_branch->name, NULL);
+	cp.argv = args.argv;
+	cp.no_stdin = 1;
+	cp.no_stderr = 1;
+	cp.git_cmd = 1;
+
+	if ((ret = capture_command(&cp, &sb, GIT_SHA1_HEXSZ)))
+		goto cleanup;
+
+	if ((ret = get_sha1_hex(sb.buf, fork_point)))
+		goto cleanup;
+
+cleanup:
+	free(remote_merge_branch);
+	strbuf_release(&sb);
+	return ret ? -1 : 0;
+}
+
+/**
+ * Sets merge_base to the octopus merge base of curr_head, merge_head and
+ * fork_point. Returns 0 if a merge base is found, 1 otherwise.
+ */
+static int get_octopus_merge_base(unsigned char merge_base[GIT_SHA1_HEXSZ],
+		unsigned char curr_head[GIT_SHA1_RAWSZ],
+		unsigned char merge_head[GIT_SHA1_RAWSZ],
+		unsigned char fork_point[GIT_SHA1_RAWSZ])
+{
+	struct commit_list *revs = NULL, *result;
+
+	commit_list_insert(lookup_commit_reference(curr_head), &revs);
+	commit_list_insert(lookup_commit_reference(merge_head), &revs);
+	if (!is_null_sha1(fork_point))
+		commit_list_insert(lookup_commit_reference(fork_point), &revs);
+
+	result = reduce_heads(get_octopus_merge_bases(revs));
+	free_commit_list(revs);
+	if (!result)
+		return 1;
+
+	hashcpy(merge_base, result->item->object.sha1);
+	return 0;
+}
+
+/**
+ * Given the current HEAD SHA1, the merge head returned from git-fetch and the
+ * fork point calculated by get_rebase_fork_point(), runs git-rebase with the
+ * appropriate arguments and returns its exit status.
+ */
+static int run_rebase(unsigned char curr_head[GIT_SHA1_RAWSZ],
+		unsigned char merge_head[GIT_SHA1_RAWSZ],
+		unsigned char fork_point[GIT_SHA1_RAWSZ])
+{
+	int ret;
+	unsigned char oct_merge_base[GIT_SHA1_RAWSZ];
+	struct argv_array args = ARGV_ARRAY_INIT;
+
+	if (!get_octopus_merge_base(oct_merge_base, curr_head, merge_head, fork_point))
+		if (!is_null_sha1(fork_point) && !hashcmp(oct_merge_base, fork_point))
+			hashclr(fork_point);
+
+	argv_array_push(&args, "rebase");
+
+	/* Shared options */
+	argv_push_verbosity(&args);
+
+	/* Options passed to git-rebase */
+	if (opt_rebase == REBASE_PRESERVE)
+		argv_array_push(&args, "--preserve-merges");
+	if (opt_diffstat)
+		argv_array_push(&args, opt_diffstat);
+	argv_push_strategies(&args);
+	argv_push_strategy_opts(&args);
+	if (opt_gpg_sign)
+		argv_array_push(&args, opt_gpg_sign);
+
+	argv_array_push(&args, "--onto");
+	argv_array_push(&args, sha1_to_hex(merge_head));
+
+	if (!is_null_sha1(fork_point))
+		argv_array_push(&args, sha1_to_hex(fork_point));
+	else
+		argv_array_push(&args, sha1_to_hex(merge_head));
+
+	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	argv_array_clear(&args);
+	return ret;
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
 	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
 	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
+	unsigned char rebase_fork_point[GIT_SHA1_RAWSZ];
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -532,6 +747,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_sha1("HEAD", orig_head))
 		hashclr(orig_head);
 
+	if (opt_rebase)
+		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
+			hashclr(rebase_fork_point);
+
 	if (run_fetch(repo, refspecs))
 		return 1;
 
@@ -573,6 +792,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(*merge_heads.sha1, curr_head);
+	} else if (opt_rebase) {
+		if (merge_heads.nr > 1)
+			die(_("Cannot rebase onto multiple branches."));
+		return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
 	} else
 		return run_merge();
 }
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9414cc1..3798b96 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -212,7 +212,7 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 	test "$(git rev-parse third)" = "$(git rev-parse second)"
 '
 
-test_expect_failure '--rebase' '
+test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
 	git commit -m file file &&
@@ -226,7 +226,7 @@ test_expect_failure '--rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
-test_expect_failure '--rebase fails with multiple branches' '
+test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy master 2>err &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
@@ -310,7 +310,7 @@ test_expect_failure 'pull.rebase=invalid fails' '
 	! git pull . copy
 '
 
-test_expect_failure '--rebase=false create a new merge commit' '
+test_expect_success '--rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=false . copy &&
@@ -319,7 +319,7 @@ test_expect_failure '--rebase=false create a new merge commit' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_failure '--rebase=true rebases and flattens keep-merge' '
+test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase=true . copy &&
@@ -327,7 +327,7 @@ test_expect_failure '--rebase=true rebases and flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_failure '--rebase=preserve rebases and merges keep-merge' '
+test_expect_success '--rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=preserve . copy &&
@@ -340,7 +340,7 @@ test_expect_success '--rebase=invalid fails' '
 	! git pull --rebase=invalid . copy
 '
 
-test_expect_failure '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
+test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase . copy &&
@@ -348,7 +348,7 @@ test_expect_failure '--rebase overrides pull.rebase=preserve and flattens keep-m
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_failure '--rebase with rebased upstream' '
+test_expect_success '--rebase with rebased upstream' '
 
 	git remote add -f me . &&
 	git checkout copy &&
@@ -366,7 +366,7 @@ test_expect_failure '--rebase with rebased upstream' '
 
 '
 
-test_expect_failure '--rebase with rebased default upstream' '
+test_expect_success '--rebase with rebased default upstream' '
 
 	git update-ref refs/remotes/me/copy copy-orig &&
 	git checkout --track -b to-rebase2 me/copy &&
@@ -377,7 +377,7 @@ test_expect_failure '--rebase with rebased default upstream' '
 
 '
 
-test_expect_failure 'rebased upstream + fetch + pull --rebase' '
+test_expect_success 'rebased upstream + fetch + pull --rebase' '
 
 	git update-ref refs/remotes/me/copy copy-orig &&
 	git reset --hard to-rebase-orig &&
@@ -409,7 +409,7 @@ test_expect_failure 'pull --rebase dies early with dirty working directory' '
 
 '
 
-test_expect_failure 'pull --rebase works on branch yet to be born' '
+test_expect_success 'pull --rebase works on branch yet to be born' '
 	git rev-parse master >expect &&
 	mkdir empty_repo &&
 	(cd empty_repo &&
@@ -456,14 +456,14 @@ test_expect_success 'setup for detecting upstreamed changes' '
 	)
 '
 
-test_expect_failure 'git pull --rebase detects upstreamed changes' '
+test_expect_success 'git pull --rebase detects upstreamed changes' '
 	(cd dst &&
 	 git pull --rebase &&
 	 test -z "$(git ls-files -u)"
 	)
 '
 
-test_expect_failure 'setup for avoiding reapplying old patches' '
+test_expect_success 'setup for avoiding reapplying old patches' '
 	(cd dst &&
 	 test_might_fail git rebase --abort &&
 	 git reset --hard origin/master
@@ -485,7 +485,7 @@ test_expect_failure 'setup for avoiding reapplying old patches' '
 	)
 '
 
-test_expect_failure 'git pull --rebase does not reapply old patches' '
+test_expect_success 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 test_must_fail git pull --rebase &&
 	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 4176e11..56e7377 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -19,7 +19,7 @@ test_expect_success 'git pull -q' '
 	test_must_be_empty out)
 '
 
-test_expect_failure 'git pull -q --rebase' '
+test_expect_success 'git pull -q --rebase' '
 	mkdir clonedqrb &&
 	(cd clonedqrb && git init &&
 	git pull -q --rebase "../parent" >out 2>err &&
@@ -38,7 +38,7 @@ test_expect_success 'git pull' '
 	test_must_be_empty out)
 '
 
-test_expect_failure 'git pull --rebase' '
+test_expect_success 'git pull --rebase' '
 	mkdir clonedrb &&
 	(cd clonedrb && git init &&
 	git pull --rebase "../parent" >out 2>err &&
@@ -54,7 +54,7 @@ test_expect_success 'git pull -v' '
 	test_must_be_empty out)
 '
 
-test_expect_failure 'git pull -v --rebase' '
+test_expect_success 'git pull -v --rebase' '
 	mkdir clonedvrb &&
 	(cd clonedvrb && git init &&
 	git pull -v --rebase "../parent" >out 2>err &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1ffd837..dda3929 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -11,8 +11,6 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 
 . ./test-lib.sh
 
-skip_all='skipping submodule update tests, requires git pull --rebase'
-test_done
 
 compare_head()
 {
-- 
2.1.4
