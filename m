Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F077209AB
	for <e@80x24.org>; Tue,  5 Sep 2017 23:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbdIEX35 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 19:29:57 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34825 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752921AbdIEX34 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 19:29:56 -0400
Received: by mail-pg0-f41.google.com with SMTP id 188so8842310pgb.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 16:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ztkQufoUInkYIGrxKfzrsAdtGMT2AryEsaV80xan/0=;
        b=YEq8id3rG7d3I2P+YzIOdxV86unDPO7Vaqj6xx6AbS4rkMFguz7mv5nLYaLbyV/5Fe
         4X3khOjI+Tk03QSQClvQ7wLS2cHYCJ/7lgGiwssrYjcdYepRpV0NXDDipwwmoV5YxYjY
         lElqwr95ps5HjOp4dpf9WDwVR3ycFQT/rsHZ5myPVZv2B8ZLZDQTJ8gU61pAUTp/SBfp
         tvPANmrrSMVBKhGwC/tvwbbY9OzQVFw4F0XkP4ukG1erc+Bafx+egHnCCoxEyCQppB8R
         OnYecQMHPjauuIYF0PoGAOSp/8/OopYw9KTyQzaEsNENHi3RNEJCNE3COTgAOup426JJ
         r/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ztkQufoUInkYIGrxKfzrsAdtGMT2AryEsaV80xan/0=;
        b=SZzhDTy+WsNd5O9feiiKABNHQyeOQUtE3pmgNSk9PSOURJnY/KIRNOGmMvJRQG29SC
         pqRRmzefih7oZEaZITpi0or1/271z/k+rTyZvA59TWyAkqt+erjFcBPThcQmnAw+zKua
         /3/W8LSmcEYEPWfgs++BdN7diOuRPR0iGizFGzDZXxuKoqo5XmBpU9Z3pCvwmtfVMPYl
         ktEUk3hECUu+T7rbCth7SaMUN1ZLoTrb55GxTnS5a985CsWwFhQjOJ1M7CVo53cirrmX
         PgEC/OQDLw4s4e+BPZ/Q9jZeZ8Sa+uE+/t3V0a2KJdZL1mZ+fmFNzPx/orXgB39gMrFS
         cvPg==
X-Gm-Message-State: AHPjjUjdAZJz2ni8GC9OXs56D3UDVWEQFjTNU63euvMaUnrqIev9O7Tq
        C0G4TjRwW3UcMsnb
X-Google-Smtp-Source: ADKCNb78V3y1PGvBCm3m5hm0O0/NEsWgbqqHSBlTrt6edX96jl6CLYFHjvzzKpq6JQ9U1Wl8eXf7uA==
X-Received: by 10.98.58.16 with SMTP id h16mr5397670pfa.153.1504654195757;
        Tue, 05 Sep 2017 16:29:55 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:68f1:5dd3:a20b:9946])
        by smtp.gmail.com with ESMTPSA id q72sm96556pfk.73.2017.09.05.16.29.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 05 Sep 2017 16:29:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv2] builtin/merge: honor commit-msg hook for merges
Date:   Tue,  5 Sep 2017 16:29:53 -0700
Message-Id: <20170905232953.22330-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to 65969d43d1 (merge: honor prepare-commit-msg hook, 2011-02-14)
merge should also honor the commit-msg hook: When a merge is stopped due
to conflicts or --no-commit, the subsequent commit calls the commit-msg
hook.  However, it is not called after a clean merge. Fix this
inconsistency by invoking the hook after clean merges as well.

This change is motivated by Gerrit's commit-msg hook to install a ChangeId
trailer into the commit message. Without such a ChangeId, Gerrit refuses
to accept any commit by default, such that the inconsistency of (not)
running the commit-msg hook between commit and merge leads to confusion
and might block people from getting their work done.

As the githooks man page is very vocal about the possibility of skipping
the commit-msg hook via the --no-verify option, implement the option
in merge, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

addressed all but one issues.

Junio writes:
> I didn't check how "merge --continue" is implemented, but we need to
> behave exactly the same way over there, too.  Making sure that it is
> a case in t7504 may be a good idea, in addition to the test you
> added.

After inspection of the code I do not think it is a good idea, because
(a) it clutters the test suite with something "obvious" for now,
    the call to cmd_commit will be the same as git-commit on the
    command line and
(b) piping through --[no-]verify would either introduce irregularities
    ("Why do we pipe through --no-verify, when --sign-off is more important?")
    or miss important options to pipe through: 

	static int continue_current_merge;
...
	OPT_BOOL(0, "continue", &continue_current_merge,
		N_("continue the current in-progress merge")),
...
	if (continue_current_merge) {
		int nargc = 1;
		const char *nargv[] = {"commit", NULL};

		if (orig_argc != 2)
			usage_msg_opt(_("--continue expects no arguments"),
			      builtin_merge_usage, builtin_merge_options);

		/* Invoke 'git commit' */
		ret = cmd_commit(nargc, nargv, prefix);
		goto done;
	}

Thanks,
Stefan

 builtin/merge.c            |  8 ++++++++
 t/t7504-commit-msg-hook.sh | 45 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 7df3fe3927..780435d7a1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -73,6 +73,7 @@ static int show_progress = -1;
 static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
+static int verify_msg = 1;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -236,6 +237,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
+	OPT_BOOL(0, "verify", &verify_msg, N_("verify commit-msg hook")),
 	OPT_END()
 };
 
@@ -780,6 +782,12 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		if (launch_editor(git_path_merge_msg(), NULL, NULL))
 			abort_commit(remoteheads, NULL);
 	}
+
+	if (verify_msg && run_commit_hook(0 < option_edit, get_index_file(),
+					  "commit-msg",
+					  git_path_merge_msg(), NULL))
+		abort_commit(remoteheads, NULL);
+
 	read_merge_msg(&msg);
 	strbuf_stripspace(&msg, 0 < option_edit);
 	if (!msg.len)
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 88d4cda299..1cd54af3cc 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -101,6 +101,10 @@ cat > "$HOOK" <<EOF
 exit 1
 EOF
 
+commit_msg_is () {
+	test "$(git log --pretty=format:%s%b -1)" = "$1"
+}
+
 test_expect_success 'with failing hook' '
 
 	echo "another" >> file &&
@@ -135,6 +139,32 @@ test_expect_success '--no-verify with failing hook (editor)' '
 
 '
 
+test_expect_success 'merge fails with failing hook' '
+
+	test_when_finished "git branch -D newbranch" &&
+	test_when_finished "git checkout -f master" &&
+	git checkout --orphan newbranch &&
+	: >file2 &&
+	git add file2 &&
+	git commit --no-verify file2 -m in-side-branch &&
+	test_must_fail git merge --allow-unrelated-histories master &&
+	commit_msg_is "in-side-branch" # HEAD before merge
+
+'
+
+test_expect_success 'merge bypasses failing hook with --no-verify' '
+
+	test_when_finished "git branch -D newbranch" &&
+	test_when_finished "git checkout -f master" &&
+	git checkout --orphan newbranch &&
+	: >file2 &&
+	git add file2 &&
+	git commit --no-verify file2 -m in-side-branch &&
+	git merge --no-verify --allow-unrelated-histories master &&
+	commit_msg_is "Merge branch '\''master'\'' into newbranch"
+'
+
+
 chmod -x "$HOOK"
 test_expect_success POSIXPERM 'with non-executable hook' '
 
@@ -178,10 +208,6 @@ exit 0
 EOF
 chmod +x "$HOOK"
 
-commit_msg_is () {
-	test "$(git log --pretty=format:%s%b -1)" = "$1"
-}
-
 test_expect_success 'hook edits commit message' '
 
 	echo "additional" >> file &&
@@ -217,7 +243,17 @@ test_expect_success "hook doesn't edit commit message (editor)" '
 	echo "more plus" > FAKE_MSG &&
 	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify &&
 	commit_msg_is "more plus"
+'
 
+test_expect_success 'hook called in git-merge picks up commit message' '
+	test_when_finished "git branch -D newbranch" &&
+	test_when_finished "git checkout -f master" &&
+	git checkout --orphan newbranch &&
+	: >file2 &&
+	git add file2 &&
+	git commit --no-verify file2 -m in-side-branch &&
+	git merge --allow-unrelated-histories master &&
+	commit_msg_is "new message"
 '
 
 # set up fake editor to replace `pick` by `reword`
@@ -237,4 +273,5 @@ test_expect_success 'hook is called for reword during `rebase -i`' '
 
 '
 
+
 test_done
-- 
2.14.0.rc0.3.g6c2e499285

