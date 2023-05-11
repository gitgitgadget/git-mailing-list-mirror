Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43F9C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 05:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbjEKFSN convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 11 May 2023 01:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbjEKFSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 01:18:11 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6926420B
        for <git@vger.kernel.org>; Wed, 10 May 2023 22:18:09 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-61b79b97ed8so38122786d6.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 22:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683782289; x=1686374289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6jV6WzJOMom+MVlDmGpNPC3GtFowCSqs7ZgF8e2ggI=;
        b=FGQyC2pSAEcuUeU7JukrtPY0Y2qCrB9USlyzy9oHf7MPkFejMVgjC/jG2fZj741Cmu
         OJk0l2EospJY/3cpPqWA7VmbmndiUKuJChlgBCgRiyozd6MAnC46HO5+OIgNjZtKWddC
         sj3m4xlsmnZXojPWbdU0eIDCeCUqmgAA8yTTkTns7XCginxbjLvX4c18e2rJjy48XDlz
         edlvw8OOMdhAaQye+yCUTUJZD9tpiCmnjtjHDTJJ8HA+OYadOOvl8F4Mp9JhASEcgfq1
         /PHxoBLmJs+fSVLisZDC9pGFLl7tWw6mtIRCBz/IAC+Et5LUbSmo/QkJ+AO1WhhFq+O1
         K7Pg==
X-Gm-Message-State: AC+VfDxItr2H17OS/s4AYplONrftJ2KvF5jAQF5oUHiIsznlpr+6ErSB
        IPcw/FM/NzrKyk9mgol3wKHIVCHCE+SJufSOX5kw1jRFjrY=
X-Google-Smtp-Source: ACHHUZ448+hVYaNnFE4PxoFbJzaorTsQpw6mUdBtI4vyql4QJMh5si9sZxS+pvat4DAKoErCd79YxBycCFcgFV03xLQ=
X-Received: by 2002:a05:6214:1c8a:b0:5a3:79cd:8ef7 with SMTP id
 ib10-20020a0562141c8a00b005a379cd8ef7mr27544844qvb.23.1683782288833; Wed, 10
 May 2023 22:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1384.v7.git.1669136378754.gitgitgadget@gmail.com> <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 May 2023 01:17:56 -0400
Message-ID: <CAPig+cR+mNDT1NX1dSp92UAvvFwoHGU_D60MSnVkMmuwSx=fhw@mail.gmail.com>
Subject: Re: [PATCH v8] status: modernize git-status "slow untracked files" advice
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 5:07 PM Rudy Rigot via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> `git status` can be slow when there are a large number of
> untracked files and directories since Git must search the entire
> worktree to enumerate them.  When it is too slow, Git prints
> advice with the elapsed search time and a suggestion to disable
> the search using the `-uno` option.  This suggestion also carries
> a warning that might scare off some users.
>
> However, these days, `-uno` isn't the only option.  Git can reduce
> the size and time of the untracked file search when the
> `core.untrackedCache` and `core.fsmonitor` features are enabled by
> caching results from previous `git status` invocations.
>
> Therefore, update the `git status` man page to explain the various
> configuration options, and update the advice to provide more
> detail about the current configuration and to refer to the updated
> documentation.
>
> Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
> ---
>     Changes since v7:
>
>      * Moved tests from new test script to existing one, in order not to
>        needlessly waste a test script number for such a small feature. Two
>        caveats:
>        * The use of test_config in a subshell result in: 'error: bug in the
>          test script: test_when_finished does nothing in a subshell', so
>          I've had to resort to using plain old git config instead.

Sorry, I should have thought of this when making suggestions in my
earlier reviews. For completeness, in case you run across this sort of
issue again if submitting patches in the future, it is possible to get
this working by using the -C option (change to directory) with
test_config() outside of the subshell. For instance:

    test_expect_sucess 'some title' '
        test_config -C slowstatus core.untrackedCache false &&
        test_config -C slowstatus core.fsmonitor false &&
        (
            cd slowstatus &&
            GIT_TEST_UF_DELAY_WARNING=1 git status >out &&
            ...
        )
    '
