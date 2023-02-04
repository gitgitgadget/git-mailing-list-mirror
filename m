Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C843C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 22:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjBDW5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 17:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDW5S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 17:57:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E7C23C59
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 14:57:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j25so3931042wrc.4
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 14:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkGV84LzyNqPexFlKIGd6ONrrJdBMh2cxNjgZg1dkE4=;
        b=GYp9jIPpaD/mt6HUDi23ttg89itpYnbxI2pMj3X8tGu+Qe0sMQ64ufYMKXk7qZ7cPv
         4heLuhEDMOYwRHlSs1Axhs2X9p/0eG9KisK4QPe0Z8K2ru+YrHkyi5WYc+msG35kGvMe
         0ZGzfiOp5mbWjP/H7BPaJttg5HQiTAnOZnw1ytJbOxfmahfN6ZqKQPXWr8n8HPlQQiY0
         Ywo+cnisQ5eNnv2l/dSf2VqW8zTpvjMtXLGpjpx/ktflG+Hc/hJzgkycK9lE50XS1WCS
         bYwJc+gY8j6EEHo+UiXTsGN0EC+VA4Iw/216yGAxLCB1qZSvuIuhtzCzlnKTkJdwqgZF
         1rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkGV84LzyNqPexFlKIGd6ONrrJdBMh2cxNjgZg1dkE4=;
        b=PJ55qB75oCmd2A5G1lK3Ni5U93Xq/levbxF08ZkAv7xAN6Qsn7MeVCG7lullxFsl6m
         n4qWjkZFPxaI7GkY4ep0vJgWpsdXbx/KXNvbylQK/xbwoznfnyw7YkV0El0pxKTBcC7+
         tkoBiQXdiz2zC0ppettSLTKYCcf4xNz/3qRZwAEFaoV3aLqYc/cFuIf9zoefdDF4xnT6
         hZby72HwFxfc3IYWWKRNEaYrzkFaD266JjZZFssjHpDXWS5ZAz1+YRyRMRmYbRhjmu0N
         3RR0GiDdF8davn+FA+pvhvNI8IA8b+8+qYaZ+1Xgn3agvO9hNZlOTufX/mYV4ZyFQZMg
         6Pmw==
X-Gm-Message-State: AO0yUKXOwDM5P75tTt49T5KceiViAYnDy+eUwg6kOigqs7hMnX2r5qAQ
        6GjbApP/ssbGY+wsL98gh7ew3uETFvc=
X-Google-Smtp-Source: AK7set8/n93rI4v/LrUeZ17OyW9XxQyzbbiV/gfISpG51WW9+JhgmYHKwW562o0PWHN6cB2cQmgqqA==
X-Received: by 2002:a5d:456e:0:b0:2c3:db61:20ec with SMTP id a14-20020a5d456e000000b002c3db6120ecmr3918760wrc.23.1675551435855;
        Sat, 04 Feb 2023 14:57:15 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id l13-20020adffe8d000000b002bfbda53b98sm2373571wrr.35.2023.02.04.14.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 14:57:15 -0800 (PST)
Subject: [PATCH v2] bisect: fix "reset" when branch is checked out elsewhere
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
Message-ID: <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com>
Date:   Sat, 4 Feb 2023 23:57:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
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
Range-diff against v1:
1:  f902db6bfb ! 1:  72e1526313 bisect: fix "reset" when branch is checked out elsewhere
    @@ builtin/bisect.c: static int bisect_reset(const char *commit)
      
      		cmd.git_cmd = 1;
     -		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
    -+		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees",
    -+				branch.buf, "--", NULL);
    ++		strvec_pushl(&cmd.args, "checkout", NULL);
    ++		if (!commit)
    ++			strvec_pushl(&cmd.args, "--ignore-other-worktrees", NULL);
    ++		strvec_pushl(&cmd.args, branch.buf, "--", NULL);
      		if (run_command(&cmd)) {
      			error(_("could not check out original"
      				" HEAD '%s'. Try 'git bisect"

 builtin/bisect.c            |  5 ++++-
 t/t6030-bisect-porcelain.sh | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 7301740267..46fba8db50 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -244,7 +244,10 @@ static int bisect_reset(const char *commit)
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
-		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
+		strvec_pushl(&cmd.args, "checkout", NULL);
+		if (!commit)
+			strvec_pushl(&cmd.args, "--ignore-other-worktrees", NULL);
+		strvec_pushl(&cmd.args, branch.buf, "--", NULL);
 		if (run_command(&cmd)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3ba4fdf615..fb01bd6abc 100755
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
