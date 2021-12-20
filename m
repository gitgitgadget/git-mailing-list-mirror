Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E18DC433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 22:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhLTWxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:53:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55777 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhLTWxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 17:53:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3FDC17AF78;
        Mon, 20 Dec 2021 17:53:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=coIi1YYV6irGagc3onyLH/bZoz7+DyWwGm4Apw
        +o1Pk=; b=C9A3BJQ/yKbehJnmtlb7HnWkjvx+0vsYWExX4S7wpqmlolsCRYbhsQ
        VC9ja+/PvaqVjoerc/HTVUH9cdTQOwU4LTLbUKoRr2jQIHY8EYqXZn6XRWh4kV2z
        nMpymQnOziQFiKwCCvr7YUmg3z0iHW03VpHTrQowceyvd9uR7tftw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC38A17AF77;
        Mon, 20 Dec 2021 17:53:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 533D517AF74;
        Mon, 20 Dec 2021 17:53:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2] merge: allow to pretend a merge is made into a different
 branch
References: <xmqqbl1ezq5j.fsf@gitster.g> <87a6gyiamm.fsf@osv.gnss.ru>
        <xmqq35mnz2x6.fsf@gitster.g>
Date:   Mon, 20 Dec 2021 14:53:43 -0800
In-Reply-To: <xmqq35mnz2x6.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        20 Dec 2021 07:55:33 -0800")
Message-ID: <xmqqee66ubuw.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFA15C98-61E7-11EC-AE49-C85A9F429DF0-77302942!pb-smtp20.pobox.com
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

Teach the "--into-name=<branch>" option to "git merge" and its
underlying "git fmt-merge-message", to pretend as if we were merging
into <branch>, no matter what branch we are actually merging into,
when they prepare the merge message.  The pretend name honors the
usual "into <target>" suppression mechanism, which can be seen in
the tests added here.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 
Range-diff:
1:  0ada838311 ! 1:  273df9ed2a merge: allow to pretend a merge into detached HEAD is made into a branch
    @@ Metadata
     Author: Junio C Hamano <gitster@pobox.com>
     
      ## Commit message ##
    -    merge: allow to pretend a merge into detached HEAD is made into a branch
    +    merge: allow to pretend a merge is made into a different branch
     
         When a series of patches for a topic-B depends on having topic-A,
         the workflow to prepare the topic-B branch would look like this:
    @@ Commit message
         the step (3) above gives us "Merge branch 'topic-A' into HEAD", and
         does not say "into topic-B".
     
    -    Teach the "--detached-head-name=<branch>" option to "git merge" and
    -    its underlying "git fmt-merge-message", to pretend as if we were
    -    merging into <branch> (instead of HEAD) when they prepare the merge
    -    message.  The pretend name honors the usual "into <target>"
    -    suppression mechanism, which can be seen in the tests added here.
    +    Teach the "--into-name=<branch>" option to "git merge" and its
    +    underlying "git fmt-merge-message", to pretend as if we were merging
    +    into <branch>, no matter what branch we are actually merging into,
    +    when they prepare the merge message.  The pretend name honors the
    +    usual "into <target>" suppression mechanism, which can be seen in
    +    the tests added here.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ Documentation/git-fmt-merge-msg.txt: git-fmt-merge-msg - Produce a merge commit
      --------
      [verse]
     -'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log]
    -+'git fmt-merge-msg' [-m <message>] [--detached-head-name <branch>] [--log[=<n>] | --no-log]
    ++'git fmt-merge-msg' [-m <message>] [--into-name <branch>] [--log[=<n>] | --no-log]
      'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
      
      DESCRIPTION
    @@ Documentation/git-fmt-merge-msg.txt: OPTIONS
      	Use <message> instead of the branch names for the first line
      	of the log message.  For use with `--log`.
      
    -+--detached-head-name <branch>::
    -+	When merging into a detached HEAD, prepare the merge
    -+	message as if merging to the branch `<branch>` instead.
    ++--into-name <branch>::
    ++	Prepare the merge message as if merging to the branch `<branch>`,
    ++	instead of the name of the real branch to which the merge is made.
     +
      -F <file>::
      --file <file>::
    @@ Documentation/git-merge.txt: SYNOPSIS
      	[--[no-]allow-unrelated-histories]
     -	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
     +	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>]
    -+	[--detached-head-name <branch>] [<commit>...]
    ++	[--into-name <branch>] [<commit>...]
      'git merge' (--continue | --abort | --quit)
      
      DESCRIPTION
    @@ Documentation/git-merge.txt: The 'git fmt-merge-msg' command can be
      used to give a good default for automated 'git merge'
      invocations. The automated message can include the branch description.
      
    -+--detached-head-name <branch>::
    -+	When merging into a detached HEAD, prepare the default merge
    -+	message as if merging to the branch `<branch>` instead.
    ++--into-name <branch>::
    ++	Prepare the default merge message as if merging to the branch
    ++	`<branch>`, instead of the name of the real branch to which
    ++	the merge is made.
     +
      -F <file>::
      --file=<file>::
    @@ builtin/fmt-merge-msg.c: int cmd_fmt_merge_msg(int argc, const char **argv, cons
      {
      	const char *inpath = NULL;
      	const char *message = NULL;
    -+	char *detached_head_name = NULL;
    ++	char *into_name = NULL;
      	int shortlog_len = -1;
      	struct option options[] = {
      		{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
    @@ builtin/fmt-merge-msg.c: int cmd_fmt_merge_msg(int argc, const char **argv, cons
      		  DEFAULT_MERGE_LOG_LEN },
      		OPT_STRING('m', "message", &message, N_("text"),
      			N_("use <text> as start of message")),
    -+		OPT_STRING(0, "detached", &detached_head_name, N_("name"),
    -+			   N_("use <name> instead of detached HEAD")),
    ++		OPT_STRING(0, "into-name", &into_name, N_("name"),
    ++			   N_("use <name> instead of the real target branch")),
      		OPT_FILENAME('F', "file", &inpath, N_("file to read from")),
      		OPT_END()
      	};
    @@ builtin/fmt-merge-msg.c: int cmd_fmt_merge_msg(int argc, const char **argv, cons
      	opts.add_title = !message;
      	opts.credit_people = 1;
      	opts.shortlog_len = shortlog_len;
    -+	opts.detached_head_name = detached_head_name;
    ++	opts.into_name = into_name;
      
      	ret = fmt_merge_msg(&input, &output, &opts);
      	if (ret)
    @@ builtin/merge.c: static int signoff;
      static const char *sign_commit;
      static int autostash;
      static int no_verify;
    -+static char *detached_head_name;
    ++static char *into_name;
      
      static struct strategy all_strategy[] = {
      	{ "recursive",  NO_TRIVIAL },
    @@ builtin/merge.c: static struct option builtin_merge_options[] = {
      	{ OPTION_LOWLEVEL_CALLBACK, 'F', "file", &merge_msg, N_("path"),
      		N_("read message from file"), PARSE_OPT_NONEG,
      		NULL, 0, option_read_message },
    -+	OPT_STRING(0, "detached", &detached_head_name, N_("name"),
    -+		   N_("use <name> instead of detached HEAD")),
    ++	OPT_STRING(0, "into-name", &into_name, N_("name"),
    ++		   N_("use <name> instead of the real target")),
      	OPT__VERBOSITY(&verbosity),
      	OPT_BOOL(0, "abort", &abort_current_merge,
      		N_("abort the current in-progress merge")),
    @@ builtin/merge.c: static void prepare_merge_message(struct strbuf *merge_names, s
      	opts.add_title = !have_message;
      	opts.shortlog_len = shortlog_len;
      	opts.credit_people = (0 < option_edit);
    -+	opts.detached_head_name = detached_head_name;
    ++	opts.into_name = into_name;
      
      	fmt_merge_msg(merge_names, merge_msg, &opts);
      	if (merge_msg->len)
     
      ## fmt-merge-msg.c ##
     @@ fmt-merge-msg.c: int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
    + 
    + 	memset(&merge_parents, 0, sizeof(merge_parents));
    + 
    +-	/* get current branch */
    ++	/* learn the commit that we merge into and the current branch name */
    + 	current_branch = current_branch_to_free =
    + 		resolve_refdup("HEAD", RESOLVE_REF_READING, &head_oid, NULL);
    + 	if (!current_branch)
      		die("No current branch");
    - 	if (starts_with(current_branch, "refs/heads/"))
    +-	if (starts_with(current_branch, "refs/heads/"))
    ++
    ++	if (opts->into_name)
    ++		current_branch = opts->into_name;
    ++	else if (starts_with(current_branch, "refs/heads/"))
      		current_branch += 11;
    -+	else if (!strcmp(current_branch, "HEAD") && opts->detached_head_name)
    -+		current_branch = opts->detached_head_name;
      
      	find_merge_parents(&merge_parents, in, &head_oid);
    - 
     
      ## fmt-merge-msg.h ##
     @@ fmt-merge-msg.h: struct fmt_merge_msg_opts {
      	unsigned add_title:1,
      		credit_people:1;
      	int shortlog_len;
    -+	const char *detached_head_name;
    ++	const char *into_name;
      };
      
      extern int merge_log_config;
    @@ t/t6200-fmt-merge-msg.sh: test_expect_success 'merge-msg with "merging" an annot
      	test_cmp expected .git/MERGE_MSG
      '
      
    -+test_expect_success 'merge --detached=<name>' '
    ++test_expect_success 'merge --into-name=<name>' '
     +	test_when_finished "git checkout main" &&
     +	git checkout -B side main &&
     +	git commit --allow-empty -m "One step ahead" &&
    @@ t/t6200-fmt-merge-msg.sh: test_expect_success 'merge-msg with "merging" an annot
     +	grep -e "Merge branch .side. into HEAD$" actual &&
     +
     +	git reset --hard main &&
    -+	git merge --no-ff --detached=main side &&
    ++	git merge --no-ff --into-name=main side &&
     +	git show -s --format="%s" >full.1 &&
     +	head -n1 full.1 >actual &&
     +	# expect that we pretend to be merging to main, that is suppressed
    ++	grep -e "Merge branch .side.$" actual &&
    ++
    ++	git checkout -b throwaway main &&
    ++	git merge --no-ff --into-name=main side &&
    ++	git show -s --format="%s" >full.2 &&
    ++	head -n1 full.2 >actual &&
    ++	# expect that we pretend to be merging to main, that is suppressed
     +	grep -e "Merge branch .side.$" actual
     +'
     +
    @@ t/t6200-fmt-merge-msg.sh: test_expect_success 'merge.suppressDest configuration'
     +	grep -e "Merge branch .side. into HEAD$" actual &&
     +
     +	git -c merge.suppressDest="main" fmt-merge-msg \
    -+		--detached=main <.git/FETCH_HEAD >full.5 &&
    ++		--into-name=main <.git/FETCH_HEAD >full.5 &&
     +	head -n1 full.5 >actual &&
     +	grep -e "Merge branch .side." actual &&
     +	! grep -e " into main$" actual &&

 Documentation/git-fmt-merge-msg.txt |  6 ++++-
 Documentation/git-merge.txt         |  8 +++++-
 builtin/fmt-merge-msg.c             |  4 +++
 builtin/merge.c                     |  4 +++
 fmt-merge-msg.c                     |  7 +++--
 fmt-merge-msg.h                     |  1 +
 t/t6200-fmt-merge-msg.sh            | 42 ++++++++++++++++++++++++++++-
 7 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 6793d8fc05..6f28812f38 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,7 +9,7 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log]
+'git fmt-merge-msg' [-m <message>] [--into-name <branch>] [--log[=<n>] | --no-log]
 'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
 
 DESCRIPTION
@@ -44,6 +44,10 @@ OPTIONS
 	Use <message> instead of the branch names for the first line
 	of the log message.  For use with `--log`.
 
+--into-name <branch>::
+	Prepare the merge message as if merging to the branch `<branch>`,
+	instead of the name of the real branch to which the merge is made.
+
 -F <file>::
 --file <file>::
 	Take the list of merged objects from <file> instead of
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e4f3352eb5..ed0990621f 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
-	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
+	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>]
+	[--into-name <branch>] [<commit>...]
 'git merge' (--continue | --abort | --quit)
 
 DESCRIPTION
@@ -76,6 +77,11 @@ The 'git fmt-merge-msg' command can be
 used to give a good default for automated 'git merge'
 invocations. The automated message can include the branch description.
 
+--into-name <branch>::
+	Prepare the default merge message as if merging to the branch
+	`<branch>`, instead of the name of the real branch to which
+	the merge is made.
+
 -F <file>::
 --file=<file>::
 	Read the commit message to be used for the merge commit (in
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 48a8699de7..8d8fd393f8 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -12,6 +12,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
 	const char *inpath = NULL;
 	const char *message = NULL;
+	char *into_name = NULL;
 	int shortlog_len = -1;
 	struct option options[] = {
 		{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
@@ -23,6 +24,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		  DEFAULT_MERGE_LOG_LEN },
 		OPT_STRING('m', "message", &message, N_("text"),
 			N_("use <text> as start of message")),
+		OPT_STRING(0, "into-name", &into_name, N_("name"),
+			   N_("use <name> instead of the real target branch")),
 		OPT_FILENAME('F', "file", &inpath, N_("file to read from")),
 		OPT_END()
 	};
@@ -56,6 +59,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	opts.add_title = !message;
 	opts.credit_people = 1;
 	opts.shortlog_len = shortlog_len;
+	opts.into_name = into_name;
 
 	ret = fmt_merge_msg(&input, &output, &opts);
 	if (ret)
diff --git a/builtin/merge.c b/builtin/merge.c
index ea3112e0c0..1ba5951d49 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -87,6 +87,7 @@ static int signoff;
 static const char *sign_commit;
 static int autostash;
 static int no_verify;
+static char *into_name;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  NO_TRIVIAL },
@@ -286,6 +287,8 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_LOWLEVEL_CALLBACK, 'F', "file", &merge_msg, N_("path"),
 		N_("read message from file"), PARSE_OPT_NONEG,
 		NULL, 0, option_read_message },
+	OPT_STRING(0, "into-name", &into_name, N_("name"),
+		   N_("use <name> instead of the real target")),
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
@@ -1122,6 +1125,7 @@ static void prepare_merge_message(struct strbuf *merge_names, struct strbuf *mer
 	opts.add_title = !have_message;
 	opts.shortlog_len = shortlog_len;
 	opts.credit_people = (0 < option_edit);
+	opts.into_name = into_name;
 
 	fmt_merge_msg(merge_names, merge_msg, &opts);
 	if (merge_msg->len)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5216191488..d25594545c 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -649,12 +649,15 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 	memset(&merge_parents, 0, sizeof(merge_parents));
 
-	/* get current branch */
+	/* learn the commit that we merge into and the current branch name */
 	current_branch = current_branch_to_free =
 		resolve_refdup("HEAD", RESOLVE_REF_READING, &head_oid, NULL);
 	if (!current_branch)
 		die("No current branch");
-	if (starts_with(current_branch, "refs/heads/"))
+
+	if (opts->into_name)
+		current_branch = opts->into_name;
+	else if (starts_with(current_branch, "refs/heads/"))
 		current_branch += 11;
 
 	find_merge_parents(&merge_parents, in, &head_oid);
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
index f2ab0e0085..99054042dc 100644
--- a/fmt-merge-msg.h
+++ b/fmt-merge-msg.h
@@ -9,6 +9,7 @@ struct fmt_merge_msg_opts {
 	unsigned add_title:1,
 		credit_people:1;
 	int shortlog_len;
+	const char *into_name;
 };
 
 extern int merge_log_config;
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 06c5fb5615..d861d7ca28 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -573,7 +573,35 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 	test_cmp expected .git/MERGE_MSG
 '
 
+test_expect_success 'merge --into-name=<name>' '
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
+	git merge --no-ff --into-name=main side &&
+	git show -s --format="%s" >full.1 &&
+	head -n1 full.1 >actual &&
+	# expect that we pretend to be merging to main, that is suppressed
+	grep -e "Merge branch .side.$" actual &&
+
+	git checkout -b throwaway main &&
+	git merge --no-ff --into-name=main side &&
+	git show -s --format="%s" >full.2 &&
+	head -n1 full.2 >actual &&
+	# expect that we pretend to be merging to main, that is suppressed
+	grep -e "Merge branch .side.$" actual
+'
+
 test_expect_success 'merge.suppressDest configuration' '
+	test_when_finished "git checkout main" &&
 	git checkout -B side main &&
 	git commit --allow-empty -m "One step ahead" &&
 	git checkout main &&
@@ -590,7 +618,19 @@ test_expect_success 'merge.suppressDest configuration' '
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
+		--into-name=main <.git/FETCH_HEAD >full.5 &&
+	head -n1 full.5 >actual &&
+	grep -e "Merge branch .side." actual &&
+	! grep -e " into main$" actual &&
+	! grep -e " into HEAD$" actual
 '
 
 test_done
-- 
2.34.1-472-g213ab46be7

