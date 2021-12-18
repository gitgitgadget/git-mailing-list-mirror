Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C5AC433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 00:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhLRA5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:57:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65255 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhLRA5A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 19:57:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A3781048B3;
        Fri, 17 Dec 2021 19:56:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=1
        tjXyNY41CkhSA+br/esm15oKGHvouVXsh1zA0mLDMQ=; b=KU7y06FZjQg05VDZi
        qVfxILiP3jD/fuvI2FqELDwWSDgG3izZMKrokqCp1zg5w/wGoJanKFt1WHIYb15Q
        jYN8Vew00D9g4MtUJ8Yn5bun8LQDGO6gMWuLyWJWPNWMQYzv6RF6B05wlHCONtpq
        iQxwbAk5CJ+EdDkLCOdE1lajBY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 519AC1048B2;
        Fri, 17 Dec 2021 19:56:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8A601048B0;
        Fri, 17 Dec 2021 19:56:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] merge: allow to pretend a merge into detached HEAD is made
 into a branch
Date:   Fri, 17 Dec 2021 16:56:56 -0800
Message-ID: <xmqqbl1ezq5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66932CF8-5F9D-11EC-A3A1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a series of patches for a topic-B depends on having topic-A,
the workflow to prepare the topic-B branch would look like this:

    $ git checkout -b topic-B main
    $ git merge --no-ff --no-edit topic-A
    $ git am <mbox-for-topic-B

When topic-A gets updated, recreating the first merge and rebasing
the rest of the topic-B, all on detached HEAD, is a useful
technique.  After updating topic-A with its new round of patches:

    $ git checkout topic-B
    $ prev=$(git rev-parse 'HEAD^{/^Merge branch .topic-A. into}')
    $ git checkout --detach $prev^1
    $ git merge --no-ff --no-edit topic-A
    $ git rebase --onto HEAD $prev @{-1}^0
    $ git checkout -B @{-1}

This will

 (0) check out the current topic-B.
 (1) find the previous merge of topic-A into topic-B.
 (2) detach the HEAD to the parent of the previous merge.
 (3) merge the updated topic-A to it.
 (4) reapply the patches to rebuild the rest of topic-B.
 (5) update topic-B with the result.

without contaminating the reflog of topic-B too much.  topic-B@{1}
is the "logically previous" state before topic-A got updated, for
example.  At (4), comparison (e.g. range-diff) between HEAD and
@{-1} is a meaningful way to sanity check the result, and the same
can be done at (5) by comparing topic-B and topic-B@{1}.

But there is one glitch.  The merge into the detached HEAD done in
the step (3) above gives us "Merge branch 'topic-A' into HEAD", and
does not say "into topic-B".

Teach the "--detached-head-name=<branch>" option to "git merge" and
its underlying "git fmt-merge-message", to pretend as if we were
merging into <branch> (instead of HEAD) when they prepare the merge
message.  The pretend name honors the usual "into <target>"
suppression mechanism, which can be seen in the tests added here.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-fmt-merge-msg.txt |  6 ++++-
 Documentation/git-merge.txt         |  7 +++++-
 builtin/fmt-merge-msg.c             |  4 ++++
 builtin/merge.c                     |  4 ++++
 fmt-merge-msg.c                     |  2 ++
 fmt-merge-msg.h                     |  1 +
 t/t6200-fmt-merge-msg.sh            | 35 ++++++++++++++++++++++++++++-
 7 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 6793d8fc05..235276752f 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,7 +9,7 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log]
+'git fmt-merge-msg' [-m <message>] [--detached-head-name <branch>] [--log[=<n>] | --no-log]
 'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
 
 DESCRIPTION
@@ -44,6 +44,10 @@ OPTIONS
 	Use <message> instead of the branch names for the first line
 	of the log message.  For use with `--log`.
 
+--detached-head-name <branch>::
+	When merging into a detached HEAD, prepare the merge
+	message as if merging to the branch `<branch>` instead.
+
 -F <file>::
 --file <file>::
 	Take the list of merged objects from <file> instead of
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e8cecf5a51..c369c1776a 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
-	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
+	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>]
+	[--detached-head-name <branch>] [<commit>...]
 'git merge' (--continue | --abort | --quit)
 
 DESCRIPTION
@@ -76,6 +77,10 @@ The 'git fmt-merge-msg' command can be
 used to give a good default for automated 'git merge'
 invocations. The automated message can include the branch description.
 
+--detached-head-name <branch>::
+	When merging into a detached HEAD, prepare the default merge
+	message as if merging to the branch `<branch>` instead.
+
 -F <file>::
 --file=<file>::
 	Read the commit message to be used for the merge commit (in
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 48a8699de7..255c45b17a 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -12,6 +12,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
 	const char *inpath = NULL;
 	const char *message = NULL;
+	char *detached_head_name = NULL;
 	int shortlog_len = -1;
 	struct option options[] = {
 		{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
@@ -23,6 +24,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		  DEFAULT_MERGE_LOG_LEN },
 		OPT_STRING('m', "message", &message, N_("text"),
 			N_("use <text> as start of message")),
+		OPT_STRING(0, "detached", &detached_head_name, N_("name"),
+			   N_("use <name> instead of detached HEAD")),
 		OPT_FILENAME('F', "file", &inpath, N_("file to read from")),
 		OPT_END()
 	};
@@ -56,6 +59,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	opts.add_title = !message;
 	opts.credit_people = 1;
 	opts.shortlog_len = shortlog_len;
+	opts.detached_head_name = detached_head_name;
 
 	ret = fmt_merge_msg(&input, &output, &opts);
 	if (ret)
diff --git a/builtin/merge.c b/builtin/merge.c
index 5f0476b0b7..d0b624bd65 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -87,6 +87,7 @@ static int signoff;
 static const char *sign_commit;
 static int autostash;
 static int no_verify;
+static char *detached_head_name;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  NO_TRIVIAL },
@@ -286,6 +287,8 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_LOWLEVEL_CALLBACK, 'F', "file", &merge_msg, N_("path"),
 		N_("read message from file"), PARSE_OPT_NONEG,
 		NULL, 0, option_read_message },
+	OPT_STRING(0, "detached", &detached_head_name, N_("name"),
+		   N_("use <name> instead of detached HEAD")),
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
@@ -1121,6 +1124,7 @@ static void prepare_merge_message(struct strbuf *merge_names, struct strbuf *mer
 	opts.add_title = !have_message;
 	opts.shortlog_len = shortlog_len;
 	opts.credit_people = (0 < option_edit);
+	opts.detached_head_name = detached_head_name;
 
 	fmt_merge_msg(merge_names, merge_msg, &opts);
 	if (merge_msg->len)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5216191488..72b96d45e6 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -656,6 +656,8 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		die("No current branch");
 	if (starts_with(current_branch, "refs/heads/"))
 		current_branch += 11;
+	else if (!strcmp(current_branch, "HEAD") && opts->detached_head_name)
+		current_branch = opts->detached_head_name;
 
 	find_merge_parents(&merge_parents, in, &head_oid);
 
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
index f2ab0e0085..b5f3a5ec54 100644
--- a/fmt-merge-msg.h
+++ b/fmt-merge-msg.h
@@ -9,6 +9,7 @@ struct fmt_merge_msg_opts {
 	unsigned add_title:1,
 		credit_people:1;
 	int shortlog_len;
+	const char *detached_head_name;
 };
 
 extern int merge_log_config;
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 06c5fb5615..b6fa76189e 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -573,7 +573,28 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 	test_cmp expected .git/MERGE_MSG
 '
 
+test_expect_success 'merge --detached=<name>' '
+	test_when_finished "git checkout main" &&
+	git checkout -B side main &&
+	git commit --allow-empty -m "One step ahead" &&
+
+	git checkout --detach main &&
+	git merge --no-ff side &&
+	git show -s --format="%s" >full.0 &&
+	head -n1 full.0 >actual &&
+	# expect that HEAD is shown as-is
+	grep -e "Merge branch .side. into HEAD$" actual &&
+
+	git reset --hard main &&
+	git merge --no-ff --detached=main side &&
+	git show -s --format="%s" >full.1 &&
+	head -n1 full.1 >actual &&
+	# expect that we pretend to be merging to main, that is suppressed
+	grep -e "Merge branch .side.$" actual
+'
+
 test_expect_success 'merge.suppressDest configuration' '
+	test_when_finished "git checkout main" &&
 	git checkout -B side main &&
 	git commit --allow-empty -m "One step ahead" &&
 	git checkout main &&
@@ -590,7 +611,19 @@ test_expect_success 'merge.suppressDest configuration' '
 	git -c merge.suppressDest="ma?*[rn]" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
 	head -n1 full.3 >actual &&
 	grep -e "Merge branch .side." actual &&
-	! grep -e " into main$" actual
+	! grep -e " into main$" actual &&
+
+	git checkout --detach HEAD &&
+	git -c merge.suppressDest="main" fmt-merge-msg <.git/FETCH_HEAD >full.4 &&
+	head -n1 full.4 >actual &&
+	grep -e "Merge branch .side. into HEAD$" actual &&
+
+	git -c merge.suppressDest="main" fmt-merge-msg \
+		--detached=main <.git/FETCH_HEAD >full.5 &&
+	head -n1 full.5 >actual &&
+	grep -e "Merge branch .side." actual &&
+	! grep -e " into main$" actual &&
+	! grep -e " into HEAD$" actual
 '
 
 test_done
-- 
2.34.1-472-g213ab46be7

