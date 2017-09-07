Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215D120286
	for <e@80x24.org>; Thu,  7 Sep 2017 22:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756118AbdIGWEe (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 18:04:34 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33338 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755580AbdIGWEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 18:04:33 -0400
Received: by mail-pf0-f182.google.com with SMTP id y29so744566pff.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9hD2Dn/T9et1N58xxgkmm2F+Oj/LxESzbKGVesI+jek=;
        b=pKw4xDMBLQf5JCvnm8O5qaV3QU9kTsUpVhAGhG5l25nWeCIAsc8QGMG6kHW44S5VIF
         aePfVebUavg2SCeq8TepSnkMGHKhcEAZLKKbrKL1/gO4KxjFqQ2Ihag3lttQzOOcf4Xz
         Calxt1oW7p0tUMOOIp2SHR0z3KvG39nBHGMFywuu82hE7V8pGh3uXEThqoVUhoYReQAG
         e3SUDj7X7IjuU537jYC87efAPbUuCIQcT8Kr7KDlRgteRGZBPx0IZmZbmoRgQ+emyDYC
         YlJS8JURT0mq7SuhJ+Lddxh/YUANYBAT2T04nQ6E7HC9gfDWGUJIa61Ko+R7Os86u9PP
         hXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9hD2Dn/T9et1N58xxgkmm2F+Oj/LxESzbKGVesI+jek=;
        b=I9omGfBIh8scrocmgr1ATqT5g55m5QLbrZpoiGLjp0dzfl6TmTsOeE6Ncb4uXPv1+T
         RNpHEY0FEcZ+t8/n85iWRRqWKW2MpU+vtdXvlvj3XZ1hB6bP2hZSeVCPFaMhDSAy7Nk2
         v1eTasz0pYHdx+8FG6pyXheJDinpqgRyTIisU+esb4BsDDqNPPt3GQjCIvV+aj0kC266
         dcmjk+BeYk6XUCUFt4A8umgaSUC2jkOITDC7rsgkesuY20Gofb+cStM3cyxcUBQ3c+VB
         n+xjazz12afZevMcsqRJlbGQt2ch64DJz8La6j/uUps28VXB1fEYFjz+KwK+jKip6TPh
         hmMQ==
X-Gm-Message-State: AHPjjUh84K857jBMpcpAOROZY9VqIyEoT8XEt76Ygi8eA0V1cfrcjRg1
        sW7Q981410Vc00xh
X-Google-Smtp-Source: ADKCNb45x2MHu+06nfHoFeb2VUw5d8nb99lHGkSsnbqGXkOsDiaGwEIeVpxHTos/eWU8ey0knfjYaw==
X-Received: by 10.84.129.98 with SMTP id 89mr908198plb.383.1504821872319;
        Thu, 07 Sep 2017 15:04:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4555:ce05:c519:8f90])
        by smtp.gmail.com with ESMTPSA id r138sm591078pgr.12.2017.09.07.15.04.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Sep 2017 15:04:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv3] builtin/merge: honor commit-msg hook for merges
Date:   Thu,  7 Sep 2017 15:04:29 -0700
Message-Id: <20170907220429.31312-1-sbeller@google.com>
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

'git merge --continue' is currently implemented as calling cmd_commit
with no further arguments. This works for most other merge related options,
such as demonstrated via the --allow-unrelated-histories flag in the
test. The --no-verify option however is not remembered across invocations
of git-merge. Originally the author assumed an alternative in which the
'git merge --continue' command accepts the --no-verify flag, but that
opens up the discussion which flags are allows to the continued merge
command and which must be given in the first invocation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> I didn't check how "merge --continue" is implemented, but we need to
> behave exactly the same way over there, too.  Making sure that it is
> a case in t7504 may be a good idea, in addition to the test you
> added.

First I understood this as if we'd want to support
'git merge --continue --no-verify' eventually, but by now I think we want
to 'carry over' the meaning from the first invocation of git-merge.

For that I added a test.

Thanks,
Stefan

 builtin/merge.c            |  8 ++++++
 t/t7504-commit-msg-hook.sh | 64 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 68 insertions(+), 4 deletions(-)

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
index 88d4cda299..302a3a2082 100755
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
@@ -217,7 +243,36 @@ test_expect_success "hook doesn't edit commit message (editor)" '
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
+'
+
+test_expect_failure 'merge --continue remembers --no-verify' '
+	test_when_finished "git branch -D newbranch" &&
+	test_when_finished "git checkout -f master" &&
+	git checkout master &&
+	echo a >file2 &&
+	git add file2 &&
+	git commit --no-verify -m "add file2 to master" &&
+	git checkout -b newbranch master^ &&
+	echo b >file2 &&
+	git add file2 &&
+	git commit --no-verify file2 -m in-side-branch &&
+	git merge --no-verify -m not-rewritten-by-hook master &&
+	# resolve conflict:
+	echo c >file2 &&
+	git add file2 &&
+	git merge --continue &&
+	commit_msg_is not-rewritten-by-hook
 '
 
 # set up fake editor to replace `pick` by `reword`
@@ -237,4 +292,5 @@ test_expect_success 'hook is called for reword during `rebase -i`' '
 
 '
 
+
 test_done
-- 
2.14.0.rc0.3.g6c2e499285

