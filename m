Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC5AC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948AE6109F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhHSSKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:10:54 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:44559 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbhHSSKx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:10:53 -0400
Received: by mail-ej1-f41.google.com with SMTP id bq25so14592580ejb.11
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gp21XR3NytoakWl9X1BYsJJe7G9iMCNI0hIdygZQvog=;
        b=qzkNlTxRUvysT7WJXtJ+v8NVJ6TmOFjMJf7TZbdPtDvXhGU0yTQXewRshfbvo2l5+X
         hSkI6QRb9AplAtFuGNEc9ieOugPxBZHRipUKi1Yx2o6Em81v96I7OdBdS8RoV/Z4A847
         ieOP74tcsg3k7j1DofRc0/zYqaoLF7C5/dvAVKJ9sJ/yYMQ/cHNvD2yeGvqObevfzI3K
         vkcFu8eftNW1m/BCxVGJyZSvdguwOEAvMEBpxwfLEvQ6vryk4UytDGMEq92pbEMrGl5S
         sgX4XmvAZOI/xSu7B9l95JpaNI+fieThWzq1scxEq0nFJuXiU0kjDAoqYiviVggKhhbc
         voeA==
X-Gm-Message-State: AOAM530F/7PE+l9eKKEtIjGjRjWRcQRbXPkldCWAGa/gmhQA37AzKcgH
        N7Lcmsg4wqtnOBmWFcFxk/RXOP0fftUPdZHGkok=
X-Google-Smtp-Source: ABdhPJwdE8Br89jpq8Sl7PMqbSRfjfowxmU+hFibqPMm+VLgSeeJpH4HJFyQ0LkvknAZP8QmRmFRuiYUixZakrajkY8=
X-Received: by 2002:a17:906:3bc3:: with SMTP id v3mr16994927ejf.482.1629396616384;
 Thu, 19 Aug 2021 11:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Aug 2021 14:10:05 -0400
Message-ID: <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com>
Subject: Re: [PATCH 0/2] test-lib-functions.sh: keep user's HOME, TERM and
 SHELL for 'test_pause' and 'debug'
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 1:16 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This series proposes two small quality-of-life improvements (in my opinion)
> to the 'test_pause' and 'debug' test functions: using the original values of
> HOME and TERM (before they are changed by the test framework) and using
> SHELL instead of SHELL_PATH.
>
> The later might be too big of a change, but I think it makes sense. We could
> add a new GIT_TEST_* to conditionnaly change the behaviour, but I kept it
> simple for v1.

I also find the test_pause() user-experience suboptimal and appreciate
the idea of improving it. However, this approach seems fatally flawed.
In particular, setting HOME to the user's real home directory could
lead to undesirable results. When I'm using test_pause() to debug a
problem with a test, I'm not just inspecting the test state, but I
quite often interact with the state using the same Git commands as the
test itself would use. Hence, it is very common for me to pause the
test just before the suspect commands and then run those commands
manually (instead of allowing the test script to do so). In such a
scenario, HOME must be pointing at the test's home directory, not at
my real home directory.

Perhaps there's some way to achieve your goal for at least certain
shells by detecting the shell and taking advantage of special shell
features which allow you to launch the shell and run some canned
commands to set up the shell as desired before dropping into an
interactive session[1] -- but it's just an idle thought.

[1]: For Bash, for instance, a quick bit of Googling leads to:
https://serverfault.com/a/586272
