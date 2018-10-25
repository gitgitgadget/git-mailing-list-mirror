Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854BC1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 19:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJZDik (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:38:40 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:43092 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeJZDik (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:38:40 -0400
Received: from localhost.localdomain (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id 793C094EF0A;
        Thu, 25 Oct 2018 12:04:38 -0700 (PDT)
From:   Daniels Umanovskis <daniels@umanovskis.se>
To:     git@vger.kernel.org
Cc:     Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH v5] branch: introduce --show-current display option
Date:   Thu, 25 Oct 2018 21:04:21 +0200
Message-Id: <20181025190421.15022-1-daniels@umanovskis.se>
X-Mailer: git-send-email 2.19.1.329.gad8739a7f.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When called with --show-current, git branch will print the current
branch name and terminate. Only the actual name gets printed,
without refs/heads. In detached HEAD state, nothing is output.

Intended both for scripting and interactive/informative use.
Unlike git branch --list, no filtering is needed to just get the
branch name.

Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
---

Submitting v5 now that a week has passed since latest maintainer
comments.

This is basically v4 but with small fixes to the test, as proposed
by Junio on pu, and additionally replacing a subshell
with { .. } since Dscho and Eric discovered the negative
performance effects of subshell invocations.

 Documentation/git-branch.txt |  6 ++++-
 builtin/branch.c             | 25 ++++++++++++++++++--
 t/t3203-branch-output.sh     | 44 ++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bf5316ffa9..0babb9b1be 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
-	[--list] [-v [--abbrev=<length> | --no-abbrev]]
+	[--list] [--show-current] [-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column] [--sort=<key>]
 	[(--merged | --no-merged) [<commit>]]
 	[--contains [<commit]] [--no-contains [<commit>]]
@@ -160,6 +160,10 @@ This option is only applicable in non-verbose mode.
 	branch --list 'maint-*'`, list only the branches that match
 	the pattern(s).
 
+--show-current::
+	Print the name of the current branch. In detached HEAD state,
+	nothing is printed.
+
 -v::
 -vv::
 --verbose::
diff --git a/builtin/branch.c b/builtin/branch.c
index c396c41533..46f91dc06d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -443,6 +443,21 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	free(to_free);
 }
 
+static void print_current_branch_name(void)
+{
+	int flags;
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
+	const char *shortname;
+	if (!refname)
+		die(_("could not resolve HEAD"));
+	else if (!(flags & REF_ISSYMREF))
+		return;
+	else if (skip_prefix(refname, "refs/heads/", &shortname))
+		puts(shortname);
+	else
+		die(_("HEAD (%s) points outside of refs/heads/"), refname);
+}
+
 static void reject_rebase_or_bisect_branch(const char *target)
 {
 	struct worktree **worktrees = get_worktrees(0);
@@ -581,6 +596,7 @@ static int edit_branch_description(const char *branch_name)
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
+	int show_current = 0;
 	int reflog = 0, edit_description = 0;
 	int quiet = 0, unset_upstream = 0;
 	const char *new_upstream = NULL;
@@ -620,6 +636,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL('l', "list", &list, N_("list branch names")),
+		OPT_BOOL(0, "show-current", &show_current, N_("show current branch name")),
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
@@ -662,14 +679,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !copy && !edit_description && !new_upstream && !unset_upstream && argc == 0)
+	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
+	    !show_current && !unset_upstream && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr ||
 	    filter.no_commit)
 		list = 1;
 
-	if (!!delete + !!rename + !!copy + !!new_upstream +
+	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
 	    list + unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -697,6 +715,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!argc)
 			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+	} else if (show_current) {
+		print_current_branch_name();
+		return 0;
 	} else if (list) {
 		/*  git branch --local also shows HEAD when it is detached */
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index ee6787614c..be55148930 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -100,6 +100,50 @@ test_expect_success 'git branch -v pattern does not show branch summaries' '
 	test_must_fail git branch -v branch*
 '
 
+test_expect_success 'git branch `--show-current` shows current branch' '
+	cat >expect <<-\EOF &&
+	branch-two
+	EOF
+	git checkout branch-two &&
+	git branch --show-current >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git branch `--show-current` is silent when detached HEAD' '
+	git checkout HEAD^0 &&
+	git branch --show-current >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'git branch `--show-current` works properly when tag exists' '
+	cat >expect <<-\EOF &&
+	branch-and-tag-name
+	EOF
+	test_when_finished "
+		git checkout branch-one
+		git branch -D branch-and-tag-name
+	" &&
+	git checkout -b branch-and-tag-name &&
+	test_when_finished "git tag -d branch-and-tag-name" &&
+	git tag branch-and-tag-name &&
+	git branch --show-current >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git branch `--show-current` works properly with worktrees' '
+	cat >expect <<-\EOF &&
+	branch-one
+	branch-two
+	EOF
+	git checkout branch-one &&
+	git worktree add worktree branch-two &&
+	{
+		git branch --show-current &&
+		git -C worktree branch --show-current
+	} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch shows detached HEAD properly' '
 	cat >expect <<EOF &&
 * (HEAD detached at $(git rev-parse --short HEAD^0))
-- 
2.19.1.329.gad8739a7f.dirty

