Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C509C43381
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 06:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52627235F7
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 06:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbhAJGfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 01:35:04 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:44604 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbhAJGfE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 01:35:04 -0500
Received: by mail-ed1-f53.google.com with SMTP id p22so15397431edu.11
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 22:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaN8h1OUnpkPPo4gPWzsf5Gg2+64vKjRJkyWw2XREOw=;
        b=jgaA9joXsyWnj+prZcR3nzspgetrQqCRxNW55EEGSgADVfT9cjjKtsqPo77k1T4mnr
         URuT9OA+tavog3kRlrq2NR668XTDxk6SSH6MGt0r57uryduYNhvk9H0gHWBiO/z1cI1S
         3AjRhP72qgqRwfDcKDZcykajH3PGPH59G9Lkvwu/e4mqtSJnW0NJ8jJb5oMb9omk10r4
         0khOpCt4kwNPwmAviL2RSYwD7wB0PGX7yYWe073IFZEcYlPrRO+W9qpQN+IZxYgRpYZ7
         mQq1CjoWYSL3wyTl5tWu7iM5Hk1nxvVapKW/oNZk5PI/ItIYYNv7mAu4E9F95/UMWvUX
         7r+Q==
X-Gm-Message-State: AOAM531t89BKj44YX0cUGqnLicBfJ64AfzHAiPUVZVYeSAWJUbmxRBwc
        /wdeWWwBgaqznqNGvOKlA7sGCnSLtfdg4jSqiF4=
X-Google-Smtp-Source: ABdhPJz6r1RRgKXgsnMYzRw487i+8ne4MQjsSCQF5rc4N/qkKuw72gTLZQKp46wlkio+gnYfCYKyjalVNiyMCvfM2FY=
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr10474083edm.291.1610260462136;
 Sat, 09 Jan 2021 22:34:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
 <pull.776.v7.git.1609852108.gitgitgadget@gmail.com> <3576c7aa54e08c11ac86675ca9bc11b80366d390.1609852109.git.gitgitgadget@gmail.com>
In-Reply-To: <3576c7aa54e08c11ac86675ca9bc11b80366d390.1609852109.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Jan 2021 01:34:11 -0500
Message-ID: <CAPig+cRBK778CTj1mbg03HOcCCZXn9v+FLDkhA0ho+wd=GTCNQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] maintenance: use launchctl on macOS
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 8:08 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> The need for a user id requires us to run 'id -u' which works on
> POSIX systems but not Windows. Further, the need for fully-qualitifed
> path names including $HOME behaves differently in the Git internals and
> the external test suite. The $HOME variable starts with "C:\..." instead
> of the "/c/..." that is provided by Git in these subcommands. The test
> therefore has a prerequisite that we are not on Windows. The cross-
> platform logic still allows us to test the macOS logic on a Linux
> machine.

You forgot to remove the above paragraph...

> We strive to make these tests work on all platforms, but Windows caused
> some headaches. In particular, the value of getuid() called by the C
> code is not guaranteed to be the same as `$(id -u)` invoked by a test.
> This is because `git.exe` is a native Windows program, whereas the
> utility programs run by the test script mostly utilize the MSYS2 runtime,
> which emulates a POSIX-like environment. Since the purpose of the test
> is to check that the input to the hook is well-formed, the actual user
> ID is immaterial, thus we can work around the problem by making the the
> test UID-agnostic. Another subtle issue is the $HOME environment
> variable being a Windows-style path instead of a Unix-style path. We can
> be more flexible here instead of expecting exact path matches.

...when you added this paragraph from my separate patch which you
folded into this patch for v7. The two paragraphs are at odds with one
another.
