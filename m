From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 15/19] pull: teach git pull about --rebase
Date: Sun, 14 Jun 2015 16:42:02 +0800
Message-ID: <1434271326-11349-16-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43W8-0006em-MP
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbFNInm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:42 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33858 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbbFNInM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:43:12 -0400
Received: by pacgb13 with SMTP id gb13so16500626pac.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dnUut2wvnWvwH8UYKE3ddyQ9f1vFarcpyEvwXB2yg3E=;
        b=BSEeRLphz6Dvyim4U1ePOi2asA6IfNYKrTPAVlVGZ8zLzlckk5x4Lt4L71F31p5p39
         CK25txTrhGkDPD65gZh3bUoe1jbxHmrUovQYrv0G6NNa1dK13PBu427tarSORwRWN9L1
         xLqPfi9IgzugursMvsvHYmmGJFO7voGTV8/n6auqOVdUNzy0qUhynwZ3Na9vw3XwUNcj
         gVEuTBUCHVx291/TSjR+ASVvryqq2iiNAhnMkpp5xd05cJ9Ryuk0AoCyEn9Amyrtxrqn
         hyycklUUJhNkChO6jib/NKpQ79R8oS8jGdb/rxkTushE1lNDUR9+kB/mvBJPT7Tb9dTm
         w4Kw==
X-Received: by 10.66.121.101 with SMTP id lj5mr37565768pab.113.1434271392022;
        Sun, 14 Jun 2015 01:43:12 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.43.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:43:10 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271629>

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

Helped-by: Stefan Beller <sbeller@google.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v3
    
    * use branch_get_upstream()
    
    * style fixes
    
    * adjust to removal of branch->remote in 9e3751d (remote.c: drop
      "remote" pointer from "struct branch", 2015-05-21)
    
    * I realised that if parse_config_rebase() handled the die()-ing and
      error()-ing, it would make the next patch more pleasant.

 builtin/pull.c | 247 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 245 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a2c900e..8915947 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -15,6 +15,53 @@
 #include "dir.h"
 #include "refs.h"
 
+enum rebase_type {
+	REBASE_INVALID = -1,
+	REBASE_FALSE = 0,
+	REBASE_TRUE,
+	REBASE_PRESERVE
+};
+
+/**
+ * Parses the value of --rebase. If value is a false value, returns
+ * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
+ * "preserve", returns REBASE_PRESERVE. If value is a invalid value, dies with
+ * a fatal error if fatal is true, otherwise returns REBASE_INVALID.
+ */
+static enum rebase_type parse_config_rebase(const char *key, const char *value,
+		int fatal)
+{
+	int v = git_config_maybe_bool("pull.rebase", value);
+
+	if (!v)
+		return REBASE_FALSE;
+	else if (v > 0)
+		return REBASE_TRUE;
+	else if (!strcmp(value, "preserve"))
+		return REBASE_PRESERVE;
+
+	if (fatal)
+		die(_("Invalid value for %s: %s"), key, value);
+	else
+		error(_("Invalid value for %s: %s"), key, value);
+
+	return REBASE_INVALID;
+}
+
+/**
+ * Callback for --rebase, which parses arg with parse_config_rebase().
+ */
+static int parse_opt_rebase(const struct option *opt, const char *arg, int unset)
+{
+	enum rebase_type *value = opt->value;
+
+	if (arg)
+		*value = parse_config_rebase("--rebase", arg, 0);
+	else
+		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+	return *value == REBASE_INVALID ? -1 : 0;
+}
+
 static const char * const pull_usage[] = {
 	N_("git pull [options] [<repository> [<refspec>...]]"),
 	NULL
@@ -24,7 +71,8 @@ static const char * const pull_usage[] = {
 static int opt_verbosity;
 static char *opt_progress;
 
-/* Options passed to git-merge */
+/* Options passed to git-merge or git-rebase */
+static enum rebase_type opt_rebase;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_squash;
@@ -58,8 +106,12 @@ static struct option pull_options[] = {
 		N_("force progress reporting"),
 		PARSE_OPT_NOARG),
 
-	/* Options passed to git-merge */
+	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
+	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
+	  N_("false|true|preserve"),
+	  N_("incorporate changes by rebasing rather than merging"),
+	  PARSE_OPT_OPTARG, parse_opt_rebase },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -449,11 +501,194 @@ static int run_merge(void)
 	return ret;
 }
 
+/**
+ * Returns remote's upstream branch for the current branch. If remote is NULL,
+ * the current branch's configured default remote is used. Returns NULL if
+ * `remote` does not name a valid remote, HEAD does not point to a branch,
+ * remote is not the branch's configured remote or the branch does not have any
+ * configured upstream branch.
+ */
+static const char *get_upstream_branch(const char *remote)
+{
+	struct remote *rm;
+	struct branch *curr_branch;
+	const char *curr_branch_remote;
+
+	rm = remote_get(remote);
+	if (!rm)
+		return NULL;
+
+	curr_branch = branch_get("HEAD");
+	if (!curr_branch)
+		return NULL;
+
+	curr_branch_remote = remote_for_branch(curr_branch, NULL);
+	assert(curr_branch_remote);
+
+	if (strcmp(curr_branch_remote, rm->name))
+		return NULL;
+
+	return branch_get_upstream(curr_branch, NULL);
+}
+
+/**
+ * Derives the remote tracking branch from the remote and refspec.
+ *
+ * FIXME: The current implementation assumes the default mapping of
+ * refs/heads/<branch_name> to refs/remotes/<remote_name>/<branch_name>.
+ */
+static const char *get_tracking_branch(const char *remote, const char *refspec)
+{
+	struct refspec *spec;
+	const char *spec_src;
+	const char *merge_branch;
+
+	spec = parse_fetch_refspec(1, &refspec);
+	spec_src = spec->src;
+	if (!*spec_src || !strcmp(spec_src, "HEAD"))
+		spec_src = "HEAD";
+	else if (skip_prefix(spec_src, "heads/", &spec_src))
+		;
+	else if (skip_prefix(spec_src, "refs/heads/", &spec_src))
+		;
+	else if (starts_with(spec_src, "refs/") ||
+		starts_with(spec_src, "tags/") ||
+		starts_with(spec_src, "remotes/"))
+		spec_src = "";
+
+	if (*spec_src) {
+		if (!strcmp(remote, "."))
+			merge_branch = mkpath("refs/heads/%s", spec_src);
+		else
+			merge_branch = mkpath("refs/remotes/%s/%s", remote, spec_src);
+	} else
+		merge_branch = NULL;
+
+	free_refspec(1, spec);
+	return merge_branch;
+}
+
+/**
+ * Given the repo and refspecs, sets fork_point to the point at which the
+ * current branch forked from its remote tracking branch. Returns 0 on success,
+ * -1 on failure.
+ */
+static int get_rebase_fork_point(unsigned char *fork_point, const char *repo,
+		const char *refspec)
+{
+	int ret;
+	struct branch *curr_branch;
+	const char *remote_branch;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+
+	curr_branch = branch_get("HEAD");
+	if (!curr_branch)
+		return -1;
+
+	if (refspec)
+		remote_branch = get_tracking_branch(repo, refspec);
+	else
+		remote_branch = get_upstream_branch(repo);
+
+	if (!remote_branch)
+		return -1;
+
+	argv_array_pushl(&cp.args, "merge-base", "--fork-point",
+			remote_branch, curr_branch->name, NULL);
+	cp.no_stdin = 1;
+	cp.no_stderr = 1;
+	cp.git_cmd = 1;
+
+	ret = capture_command(&cp, &sb, GIT_SHA1_HEXSZ);
+	if (ret)
+		goto cleanup;
+
+	ret = get_sha1_hex(sb.buf, fork_point);
+	if (ret)
+		goto cleanup;
+
+cleanup:
+	strbuf_release(&sb);
+	return ret ? -1 : 0;
+}
+
+/**
+ * Sets merge_base to the octopus merge base of curr_head, merge_head and
+ * fork_point. Returns 0 if a merge base is found, 1 otherwise.
+ */
+static int get_octopus_merge_base(unsigned char *merge_base,
+		const unsigned char *curr_head,
+		const unsigned char *merge_head,
+		const unsigned char *fork_point)
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
+static int run_rebase(const unsigned char *curr_head,
+		const unsigned char *merge_head,
+		const unsigned char *fork_point)
+{
+	int ret;
+	unsigned char oct_merge_base[GIT_SHA1_RAWSZ];
+	struct argv_array args = ARGV_ARRAY_INIT;
+
+	if (!get_octopus_merge_base(oct_merge_base, curr_head, merge_head, fork_point))
+		if (!is_null_sha1(fork_point) && !hashcmp(oct_merge_base, fork_point))
+			fork_point = NULL;
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
+	argv_array_pushv(&args, opt_strategies.argv);
+	argv_array_pushv(&args, opt_strategy_opts.argv);
+	if (opt_gpg_sign)
+		argv_array_push(&args, opt_gpg_sign);
+
+	argv_array_push(&args, "--onto");
+	argv_array_push(&args, sha1_to_hex(merge_head));
+
+	if (fork_point && !is_null_sha1(fork_point))
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
 
 	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
 		const char *path = mkpath("%s/git-pull", git_exec_path());
@@ -483,6 +718,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_sha1("HEAD", orig_head))
 		hashclr(orig_head);
 
+	if (opt_rebase)
+		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
+			hashclr(rebase_fork_point);
+
 	if (run_fetch(repo, refspecs))
 		return 1;
 
@@ -524,6 +763,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
-- 
2.1.4
