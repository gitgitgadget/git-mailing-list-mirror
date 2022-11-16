Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A7DC4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 00:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiKPAji (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 19:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiKPAjg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 19:39:36 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6EE2C64E
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 16:39:33 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id h206so12078053iof.10
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 16:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haSb88UnvJvrtSeOUyDS/SroIuRJ6muCUp6EDLSvS9I=;
        b=FqNbT2Zv91PlXrVCOWXprQTScpVJDQZogMnw0ksx9pFk41tfwohdHOdBPBkdueuFhm
         g0WhdffrfuGFwjePdhOebVZctXH1nmW/3nAwTmFTzrgqM/HKaoE9AYwOGv/GO9VrDTJN
         18E1jf0OmxHMuEozvhoqnnk4vfiWwlA7yLBm2KNDQWC5OyCncQ/rqZlACX6oYxkqLMt2
         Z71e4yX8juwwlWJxLH24LZHQ5PAMgII0l9ouVSjeaSROHmSYX/DefoxiTA6mTL4DZbch
         NiyHz/6o/hDvbSiRxea5ORxgGVGiHwOHW3laq6dMP+8espMJ/gBJn9FMTbbNCBIEqQ9z
         Twbw==
X-Gm-Message-State: ANoB5plNf1Mm6g+GlLn2z9X589QgsOawIEV/rWf0mE+hX8RChbrbTumy
        cBPUhtFStZ44FX6xa/rpntr1HWtwj5Brgn5EjFNWrd6xvus=
X-Google-Smtp-Source: AA0mqf4UDZDceRaP0rgn6PvW7aheoftnPg2Ukkn6RTsb9FfWH6W8b8nTkU7DfMfiNPHC4hyzCH1W1r6mzk261taOFTU=
X-Received: by 2002:a5d:9344:0:b0:6a1:48d3:149e with SMTP id
 i4-20020a5d9344000000b006a148d3149emr9269799ioo.136.1668559172860; Tue, 15
 Nov 2022 16:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
In-Reply-To: <20221110233137.10414-1-jacobabel@nullpo.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Nov 2022 19:39:21 -0500
Message-ID: <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 6:32 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> While working with the worktree based git workflow, I realised that setting
> up a new git repository required switching between the traditional and
> worktree based workflows. Searching online I found a SO answer [1] which
> seemed to support this and which indicated that adding support for this should
> not be technically difficult.
>
>   * adding orphan branch functionality (as is present in `git-switch`)
>     to `git-worktree-add`

I haven't had a chance yet to read v3, but can we take a step back for
a moment and look at this topic from a slightly different angle?
Setting aside the value of adding --orphan to `git worktree add`
(which, I'm perfectly fine with, as mentioned earlier), I have a
question about whether the solution proposed by this series is the
best we can do.

As I understand it, the actual problem this series wants to solve is
that it's not possible to create a new worktree from an empty bare
repository; for instance:

    % git init --bare foo.git
    % git -C foo.git worktree add -b main bar
    Preparing worktree (new branch 'main')
    fatal: not a valid object name: 'HEAD'
    %

This series addresses that shortcoming by adding --orphan, so that the
following works:

    % git init --bare foo.git
    % git -C foo.git worktree add --orphan main bar
    Preparing worktree (new branch 'main')
    %

However, is this really the best and most user-friendly and most
discoverable solution? Is it likely that users are somehow going to
instinctively use --orphan when they see the "fatal: not a valid
object name: 'HEAD'" error message?

Wouldn't a better solution be to somehow fix `git worktree add -b
<branch>` so that it just works rather than erroring out? I haven't
delved into the implementation to determine if this is possible, but
if it is, it seems a far superior "fix" for the problem shown above
since it requires no extra effort on the user's part, and doesn't
raise any discoverability red-flags (since nothing needs to be
"discovered" if `-b <branch>` works as expected in the first place).

If fixing `-b <branch>` to "just work" is possible, then --orphan is
no longer a needed workaround but becomes "icing on the cake".

> Changes from v2:
>
>   * Changed orphan creation behavior to match `git switch --orphan` instead of
>     `git checkout --orphan` [2][3]. As a result `--orphan` no longer accepts a
>     `<commit-ish>` and creates the orphan branch with a clean working directory.

Thanks for making this change.
