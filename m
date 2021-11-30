Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE37C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 03:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhK3ECB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 23:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhK3ECA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 23:02:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF4C061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 19:58:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so41310925wrr.8
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 19:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=q7P4useCnDz0k/DCjMmm2TSHwbajN3xgPJ6Dej4bC74=;
        b=lyqA7xeXqggq60adfXCwi8po75tviX/gxyOSp/U60QKdrIzS9dTk4IHeBdWMV+xdaL
         Gs99cP4zmpw4xWGsmENj7lKxyAO6ugqu04MqLIXxTy0W9cf3+WIvB6paFfJ85VuolB5v
         kU2okNdReHg8sJDryGHUtc29Qj3ztnXtQ4yxMny3xPBLe5UKLvefjJ3xpUjQl1eo7R79
         0O/fNNcFb7LXAWCRcI94W5pwk8QRERZL4m92aT5roaqJ8uDC6mWV9EZ5W0XqM1sEcqKY
         hMJu0ACKZ/pPsR6CjYz3dYcd8tBKgGdRapLL1QE5c5DYmrvpydnI+ribPX4Ikk3t/wj/
         r8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q7P4useCnDz0k/DCjMmm2TSHwbajN3xgPJ6Dej4bC74=;
        b=L98M1iBITc0xTBInmuMBOVVRszPRup/TQxBB3X3Qk9FCE7b6wV4Etbty5Tah4ISu6D
         eeJxnOiA6Mgaumm+42YxuD7O/8Z85+XHkGxMrjqVj+5X/sR2MbpT+yQi3+c3DmB5ULfr
         C6gtxS8vjVpOlCjBHzyyHGn6RybJmcURfWtaRgPpbGW1NGbDEvr9raveoxbJbBtCBpgd
         Z8TnzuRCkZ4pYEZra6tc3rCjhnlgVzGHJMaFALbZfJSVQgpF55eCfNJNEnbn0bfX1YAS
         zsSC0kKGgN3wj8WuRVHU9WpEQ7vFaxw9yCDd6stDfoi3Sul4PeIFl1nY40+sYiNxe2Bp
         HdPg==
X-Gm-Message-State: AOAM532+dIl3z6VPla3O/CeAWdtxYWweG78bXcu8fUKuBtUqZ5gv0sVk
        PD+INuUfr47OX2uV3AS1EKvBGNYxAto=
X-Google-Smtp-Source: ABdhPJw9Qnq1JN/n5NeiutvQUc3JPhnvogCUYhqqmkoEixw8ZOUbhEIgPdPT0wrLyz/Ls5+U7P1Bqw==
X-Received: by 2002:a5d:5272:: with SMTP id l18mr38282745wrc.208.1638244720215;
        Mon, 29 Nov 2021 19:58:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm15523131wrt.36.2021.11.29.19.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 19:58:39 -0800 (PST)
Message-Id: <pull.1149.git.git.1638244719381.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 03:58:39 +0000
Subject: [PATCH] sequencer: avoid adding exec commands for non-commit creating
 commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The `--exec <cmd>` is documented as

    Append "exec <cmd>" after each line creating a commit in the final
    history.
    ...
    If --autosquash is used, "exec" lines will not be appended for the
    intermediate commits, and will only appear at the end of each
    squash/fixup series.

Unfortunately, it would also add exec commands after non-pick
operations, such as 'no-op', which could be seen for example with
    git rebase -i --exec true HEAD

todo_list_add_exec_commands() intent was to insert exec commands after
each logical pick, while trying to consider a chains of fixup and squash
commits to be part of the pick before it.  So it would keep an 'insert'
boolean tracking if it had seen a pick or merge, but not write the exec
command until it saw the next non-fixup/squash command.  Since that
would make it miss the final exec command, it had some code that would
check whether it still needed to insert one at the end, but instead of a
simple

    if (insert)

it had a

    if (insert || <condition that is always true>)

That's buggy; as per the docs, we should only add exec commands for
lines that create commits, i.e. only if insert is true.  Fix the
conditional.

There was one testcase in the testsuite that we tweak for this change;
it was introduced in 54fd3243da ("rebase -i: reread the todo list if
`exec` touched it", 2017-04-26), and was merely testing that after an
exec had fired that the todo list would be re-read.  The test at the
time would have worked given any revision at all, though it would only
work with 'HEAD' as a side-effect of this bug.  Since we're fixing this
bug, choose something other than 'HEAD' for that test.

Finally, add a testcase that verifies when we have no commits to pick,
that we get no exec lines in the generated todo list.

Reported-by: Nikita Bobko <nikitabobko@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sequencer: avoid adding exec commands for non-commit creating commands
    
    Original report over at
    https://lore.kernel.org/git/YaVzufpKcC0t+q+L@nand.local/T/#m13fbd7b054c06ba1f98ae66e6d1b9fcc51bb875e

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1149%2Fnewren%2Frebase-exec-empty-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1149/newren/rebase-exec-empty-bug-v1
Pull-Request: https://github.com/git/git/pull/1149

 sequencer.c                 | 2 +-
 t/t3429-rebase-edit-todo.sh | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..aa790f0bba8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5496,7 +5496,7 @@ static void todo_list_add_exec_commands(struct todo_list *todo_list,
 	}
 
 	/* insert or append final <commands> */
-	if (insert || nr == todo_list->nr) {
+	if (insert) {
 		ALLOC_GROW(items, nr + commands->nr, alloc);
 		COPY_ARRAY(items + nr, base_items, commands->nr);
 		nr += commands->nr;
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 7024d49ae7b..abd66f36021 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -13,10 +13,15 @@ test_expect_success 'setup' '
 
 test_expect_success 'rebase exec modifies rebase-todo' '
 	todo=.git/rebase-merge/git-rebase-todo &&
-	git rebase HEAD -x "echo exec touch F >>$todo" &&
+	git rebase HEAD~1 -x "echo exec touch F >>$todo" &&
 	test -e F
 '
 
+test_expect_success 'rebase exec with an empty list does not exec anything' '
+	git rebase HEAD -x "true" 2>output &&
+	! grep "Executing: true" output
+'
+
 test_expect_success 'loose object cache vs re-reading todo list' '
 	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
 	export GIT_REBASE_TODO &&

base-commit: 35151cf0720460a897cde9b8039af364743240e7
-- 
gitgitgadget
