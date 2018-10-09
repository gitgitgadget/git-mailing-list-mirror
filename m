Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3401F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 18:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJJBtn (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 21:49:43 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:60522 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJJBtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 21:49:43 -0400
Received: from localhost.localdomain (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id EE42794E081;
        Tue,  9 Oct 2018 11:31:25 -0700 (PDT)
From:   Daniels Umanovskis <daniels@umanovskis.se>
To:     git@vger.kernel.org
Cc:     Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH 1/2] branch: introduce --current display option
Date:   Tue,  9 Oct 2018 20:31:13 +0200
Message-Id: <20181009183114.16477-1-daniels@umanovskis.se>
X-Mailer: git-send-email 2.19.1.274.g059d67db4.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When called with --current, git branch will print the current
branch name and terminate. It will print HEAD in detached-head state.

Rationale: finding out the current branch is useful interactively,
but especially in scripting. git branch --list prints many branches,
and prepends the current one with an asterisk, meaning sed or other
filtering is necessary to just get the current branch.
git rev-parse --abbrev-ref HEAD is the current way to achieve this
output, but that is not intuitive or easy to understand.

Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
---
 builtin/branch.c         | 17 +++++++++++++++++
 t/t3203-branch-output.sh | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index c396c4153..e4c6b0490 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -443,6 +443,18 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	free(to_free);
 }
 
+static void print_current_branch_name()
+{
+	struct strbuf out = STRBUF_INIT;
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	char *shortname = shorten_unambiguous_ref(refname, 0);
+	strbuf_addf(&out, _("%s"), shortname);
+	fwrite(out.buf, 1, out.len, stdout);
+	putchar('\n');
+	free(shortname);
+	strbuf_release(&out);
+}
+
 static void reject_rebase_or_bisect_branch(const char *target)
 {
 	struct worktree **worktrees = get_worktrees(0);
@@ -581,6 +593,7 @@ static int edit_branch_description(const char *branch_name)
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
+	int current = 0;
 	int reflog = 0, edit_description = 0;
 	int quiet = 0, unset_upstream = 0;
 	const char *new_upstream = NULL;
@@ -620,6 +633,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL('l', "list", &list, N_("list branch names")),
+		OPT_BOOL(0, "current", &current, N_("show current branch name")),
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
@@ -697,6 +711,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!argc)
 			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+	} else if (current) {
+		print_current_branch_name();
+		return 0;
 	} else if (list) {
 		/*  git branch --local also shows HEAD when it is detached */
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index ee6787614..396d81568 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -100,6 +100,24 @@ test_expect_success 'git branch -v pattern does not show branch summaries' '
 	test_must_fail git branch -v branch*
 '
 
+test_expect_success 'git branch `--current` shows current branch' '
+	cat >expect <<-\EOF &&
+	branch-two
+	EOF
+    git checkout branch-two &&
+	git branch --current >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git branch `--current` shows detached HEAD properly' '
+	cat >expect <<-\EOF &&
+	HEAD
+	EOF
+    git checkout HEAD^0 &&
+	git branch --current >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch shows detached HEAD properly' '
 	cat >expect <<EOF &&
 * (HEAD detached at $(git rev-parse --short HEAD^0))
-- 
2.19.1.274.g059d67db4.dirty

