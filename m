Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3A5208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbdIEVBX (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 17:01:23 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37861 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbdIEVBW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 17:01:22 -0400
Received: by mail-pg0-f52.google.com with SMTP id d8so11503070pgt.4
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s2BggOvbV6aSvywt/AIswmfQijWFNRji2XKObGMA/dQ=;
        b=vN+eracLL0MSTCS7NlGI/nvvoCsk1jSmwI8yt8XLJcncKUBIhx6qLotFhCs/SbbU3/
         +rvbj7/EWO/vCbzr7tBvyII1BYkqw6Ulq3oM/cOoUaMeNH6s74V+o1EDFKBeo/MHOfom
         jTYFIC3r1fP1uJwuHsmrYtYRfPaJTxdTIAixt1ZBJcOnRjHfjn8qT3+l1yuQTstnHFC3
         /XTpjGBqUXKH3nXbVPmf5yXXziq0kDzK5Z4A/8s55KcDa0f9pqzqBCQhYREmXLKUKHO6
         WUv7DXhNTZpuZQY3Lv2RK2EY4eNZYYxiWwuL7+OSn9rdxRFTrrY9H6e+0sRxBhpSOwzT
         oAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s2BggOvbV6aSvywt/AIswmfQijWFNRji2XKObGMA/dQ=;
        b=t19r9/cmf2EzlTKz1nrN/uHTYAG1ou8Z4avpIDP7T7XIO/rzZCeG1twlzLLjFS9h4s
         rA3nJ0y9kRBLgSJnor54p3/31hOBF+pI3rig1ILm5uyy52LqRWwdh1gOCmWsbaGhypCH
         TUgDDn1T9dfqheCT2J+hRdrqEQrTvYkhZzc3GdAKvvo2U4Eb8vwatiVyisOpnKq8/3uG
         e9rvceQ2O81f3wNmE8Oyjhh35BpxdyH3wmQXgecUvkvsq3u5CzYDnVA/aH0MH6AJl3bD
         XlY2c5zWvGcyuJPdedCMWIQK0xV51GgZ8dLm080cdgmaCDm17CVWF5ooHPv21ITaG/+F
         /Itg==
X-Gm-Message-State: AHPjjUjyT8l7oAB7W3TQfTa9uHrdiiCxo/yzYrifZ5HYCXi1eSmgYstF
        YzKvO1vlSI0WZTQQUEVv/Q==
X-Google-Smtp-Source: ADKCNb5U/AoEfRznwlVH9ANubLSHvzp8VQqJzDYkxpyHpFz8xlbzi8U5UyV5fO3IfAbQjvEm5caE+A==
X-Received: by 10.84.211.35 with SMTP id b32mr5831033pli.162.1504645279712;
        Tue, 05 Sep 2017 14:01:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:68f1:5dd3:a20b:9946])
        by smtp.gmail.com with ESMTPSA id i186sm2544627pfg.84.2017.09.05.14.01.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 05 Sep 2017 14:01:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] builtin/merge: honor commit-msg hook for merges
Date:   Tue,  5 Sep 2017 14:01:16 -0700
Message-Id: <20170905210116.26343-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to 65969d43d1 (merge: honor prepare-commit-msg hook, 2011-02-14)
merge should also honor the commit-msg hook; the reason is the same as
in that commit: When a merge is stopped due to conflicts or --no-commit,
the subsequent commit calls the commit-msg hook.  However, it is not
called after a clean merge. Fix this inconsistency by invoking the hook
after clean merges as well.

This change is motivated by Gerrits commit-msg hook to install a change-id
trailer into the commit message. Without such a change id, Gerrit refuses
to accept (merge) commits by default, such that the inconsistency of
(not) running commit-msg hook between commit and merge leads to confusion
and might block people from getting their work done.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/merge.c            |  8 ++++++++
 t/t7504-commit-msg-hook.sh | 45 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 7df3fe3927..087efd560d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -73,6 +73,7 @@ static int show_progress = -1;
 static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
+static int no_verify;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -236,6 +237,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
 	OPT_END()
 };
 
@@ -780,6 +782,12 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		if (launch_editor(git_path_merge_msg(), NULL, NULL))
 			abort_commit(remoteheads, NULL);
 	}
+
+	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
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

