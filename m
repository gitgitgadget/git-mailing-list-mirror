Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9885BC7EE2F
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 14:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBYOWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 09:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBYOWH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 09:22:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC6193DC
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:22:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so1238129wmi.3
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677334924;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9xPMjZ11z018dKlc5kxB17cefsu7v9Kt+D1O4UMWRE=;
        b=TmY8q07aVEoaVYlMpkVrYRInnJvit3Cr/Yq2LmW8Ta3QPqU1C2psHwLfDnVbM2vLv6
         3c6tKYUzPCfZzcgdRCtPhFYoz2s6kN4joEl7ycjguaWxaKEAJ7D9vcDENXCi0X9nJfBp
         eb51i6Sh5bmnzDSoS4uV1c+2eMqx22OG0yJZn8R4dj9s+WLzw+EqqdKtddHUa5MpoiHO
         /XHWrmQEm/Yqgy+q/mvpvbHODf994ar8bjpNy8R1r4JOfKRR7AsrMSNeIojUmc8v9p9Q
         dv6fEUtLsltktDOu7OGwJFt5vQVu3gkkxjSFT/LYEnU2LEvAj87I5NLX3K7ukalx/yzs
         gBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677334924;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9xPMjZ11z018dKlc5kxB17cefsu7v9Kt+D1O4UMWRE=;
        b=1/kZpADd7Jaq4CJ6Qa/W4EqMDxQ0ZeiUtxEjZ2NSE6CcIhlqR2e9qbf8ML8JZSow6j
         9WodcDDYxYmDH2necHfwnvXIE3HGg3ZLrbuw0FDYc1gh1uKr2zSAWRhFktaqUSm1Gtup
         MgIt2HXBY7PH4Fg0vSDD/DqCfwZVST528vwElKQtn7KcjhrMPXu1fjaDTRlvq6GICm1l
         FDq9VktIVDrL0cgKKNjGQ3P6jZN/tNmXh5DzLRHwlgc232Xs3hzSFspM10x3QfdBiPDM
         zholgi7WB2jV+prSyBBstqlkn+rbqxXZ3ZSBNlz6gI4lyFyJ8ywpgSDtNu41xxJJpmrd
         nGxA==
X-Gm-Message-State: AO0yUKWJyWanxUhjIavtCs+Ej/l848q4MS5QgcpbsdwlJ+a1oeTT1krX
        uhqMlG/k97rPxwYeyjbDLj8=
X-Google-Smtp-Source: AK7set/MFlSbUu1OoV958kYBTjIZv+nIatZomBC7xo4dyvJD9zwwjxmwgt1W7BTLWNVzHF2yPx9t+A==
X-Received: by 2002:a05:600c:30ca:b0:3eb:38e6:f650 with SMTP id h10-20020a05600c30ca00b003eb38e6f650mr721037wmn.41.1677334923896;
        Sat, 25 Feb 2023 06:22:03 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003eb20d4d4a8sm2657249wmk.44.2023.02.25.06.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 06:22:03 -0800 (PST)
Subject: [PATCH v4 2/4] branch: fix die_if_checked_out() when
 ignore_current_worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com>
Message-ID: <356b96bf-4130-6a91-4ce5-4228b071e183@gmail.com>
Date:   Sat, 25 Feb 2023 15:22:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8d9fdd7 (worktree.c: check whether branch is rebased in another
worktree, 2016-04-22) die_if_checked_out() learned a new option
ignore_current_worktree, to modify the operation from "die() if the
branch is checked out in any worktree" to "die() if the branch is
checked out in any worktree other than the current one".

Unfortunately we implemented it by checking the flag is_current in the
worktree that find_shared_symref() returns.

When the same branch is checked out in several worktrees simultaneously,
find_shared_symref() will return the first matching worktree in the list
composed by get_worktrees().  If one of the worktrees with the checked
out branch is the current worktree, find_shared_symref() may or may not
return it, depending on the order in the list.

Instead of find_shared_symref(), let's do the search using use the
recently introduced API is_shared_symref(), and consider
ignore_current_worktree when necessary.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c   | 14 +++++++++-----
 worktree.c |  3 +--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index e5614b53b3..64b7dbfd17 100644
--- a/branch.c
+++ b/branch.c
@@ -820,12 +820,16 @@ void remove_branch_state(struct repository *r, int verbose)
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
 {
 	struct worktree **worktrees = get_worktrees();
-	const struct worktree *wt;
 
-	wt = find_shared_symref(worktrees, "HEAD", branch);
-	if (wt && (!ignore_current_worktree || !wt->is_current)) {
-		skip_prefix(branch, "refs/heads/", &branch);
-		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
+	for (int i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->is_current && ignore_current_worktree)
+			continue;
+
+		if (is_shared_symref(worktrees[i], "HEAD", branch)) {
+			skip_prefix(branch, "refs/heads/", &branch);
+			die(_("'%s' is already checked out at '%s'"),
+				branch, worktrees[i]->path);
+		}
 	}
 
 	free_worktrees(worktrees);
diff --git a/worktree.c b/worktree.c
index 40cb9874b7..34043d8fe0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -435,10 +435,9 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
 					  const char *target)
 {
 
-	for (int i = 0; worktrees[i]; i++) {
+	for (int i = 0; worktrees[i]; i++)
 		if (is_shared_symref(worktrees[i], symref, target))
 			return worktrees[i];
-	}
 
 	return NULL;
 }
-- 
2.39.2
