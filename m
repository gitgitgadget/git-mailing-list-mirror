Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AF2C27C76
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 01:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjAVBiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 20:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAVBiO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 20:38:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED161CAF0
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:38:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r9so7893354wrw.4
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reN885+wLybWSyzjKiyi/maW5UK/Zi/nIKPL7TywwMU=;
        b=ESQOM5sDfxxuwQ+zb1EeTerjELVkd8YR028ULlVoeHtCx5PIicW/4CntaRr0yR22wE
         w0BtTlYJyi9ZGG+kpHa77gVm22B7dbET4CrfG9SX7CPu2uj/ZytA6sUkS6N/m+y7mb/o
         N303pmog53Y1sXyVIkGXMBx111zCFIwUkbX42ozGzVIAALFT9nbAchTwikLcSCO6N5i8
         7hgl2v+St4NJ03A1nE2Fa0qFi218CMHjJ1uzZU1OnJCGZIqpC67CAGFjWIx1z+RKsh6D
         Nm/TNkVMQ39Sp71rQ1iGINUQA5QP0+VRvqpkEWhjhxpTiH4ZTny9/ObpXVR9wX3qT0qE
         W2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reN885+wLybWSyzjKiyi/maW5UK/Zi/nIKPL7TywwMU=;
        b=24ZxoPJ+C9r6aDAa07w2U/vaRXwH95QzgVF8tC5drlttAeNQxHWEfSN+aryr3Z2wh8
         L5v8PGyA3TMvnkoDy8gGOO1Q06q3PUV8elrZjFXu0P9CS8opxbC1cG+7jnbewtuzXWwK
         af1uxNp4AA9E4f8eWNruBX4Ww9DZJn8EpKk7ac6d8lI1BonC05oJNHnjIxJ0Lb5xs0I1
         Ngj164nKAPr+yeS2+EbeSDtOzDLzEvq+LLQ9DHay694aO6LZYudeJRNJttk5InYf+hWp
         YzwhWB/AnK+dBMiRmCXl50M+Hx6u4/LFsdfQjqhPC3IUGpnsp1F75Ql9qHP6L9UlzjCt
         Hbcw==
X-Gm-Message-State: AFqh2krf+zkJqF0MCnRE9TFCz+c5fAx7jMN7KSVe91yn3ODbQor4KZam
        iA7WkMImab1oqBJ3gj7KzsT7eGathIA=
X-Google-Smtp-Source: AMrXdXtLQN9QROk91wm2tCaiw9/wUuReY58pWJlU+fxYr+BeT9NgvwlFPPYKCH3fgcsfvKJyM9swKA==
X-Received: by 2002:a05:6000:784:b0:2be:3ccd:7f2f with SMTP id bu4-20020a056000078400b002be3ccd7f2fmr10312278wrb.46.1674351491683;
        Sat, 21 Jan 2023 17:38:11 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id k7-20020adfd227000000b002bdf3809f59sm18763550wrh.38.2023.01.21.17.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 17:38:11 -0800 (PST)
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] bisect: fix "reset" when branch is checked out elsewhere
Message-ID: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
Date:   Sun, 22 Jan 2023 02:38:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 1d0fa89 (checkout: add --ignore-other-wortrees, 2015-01-03) we
have a safety valve in checkout/switch to prevent the same branch from
being checked out simultaneously in multiple worktrees.

If a branch is bisected in a worktree while also being checked out in
another worktree; when the bisection is finished, checking out the
branch back in the current worktree may fail.

Let's teach bisect to use the "--ignore-other-worktrees" flag.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/bisect.c            |  3 ++-
 t/t6030-bisect-porcelain.sh | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index cc9483e851..56da34648b 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -245,7 +245,8 @@ static int bisect_reset(const char *commit)
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
-		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
+		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees",
+				branch.buf, "--", NULL);
 		if (run_command(&cmd)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 98a72ff78a..cc8acbab18 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -122,6 +122,29 @@ test_expect_success 'bisect start without -- takes unknown arg as pathspec' '
 	grep bar ".git/BISECT_NAMES"
 '
 
+test_expect_success 'bisect reset: back in a branch checked out also elsewhere' '
+	echo "shared" > branch.expect &&
+	test_bisect_reset() {
+		git -C $1 bisect start &&
+		git -C $1 bisect good $HASH1 &&
+		git -C $1 bisect bad $HASH3 &&
+		git -C $1 bisect reset &&
+		git -C $1 branch --show-current > branch.output &&
+		cmp branch.expect branch.output
+	} &&
+	test_when_finished "
+		git worktree remove wt1 &&
+		git worktree remove wt2 &&
+		git branch -d shared
+	" &&
+	git worktree add wt1 -b shared &&
+	git worktree add wt2 -f shared &&
+	# we test in both worktrees to ensure that works
+	# as expected with "first" and "next" worktrees
+	test_bisect_reset wt1 &&
+	test_bisect_reset wt2
+'
+
 test_expect_success 'bisect reset: back in the main branch' '
 	git bisect reset &&
 	echo "* main" > branch.expect &&
-- 
2.39.0
