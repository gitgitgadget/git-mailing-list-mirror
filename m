Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F2C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B38961451
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhEHAMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 20:12:02 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:47038 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhEHAMB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 20:12:01 -0400
Received: by mail-ed1-f48.google.com with SMTP id h10so12087314edt.13
        for <git@vger.kernel.org>; Fri, 07 May 2021 17:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1d7cYPVvy4BLyxL2Q67Mlp6fiwJxjm/FO/wDpDDinrM=;
        b=VRCaSwDtwVM16sd9s37ONj4BDYge/Cwiy/1Jkl/Fwuw8UWeYTXe7P6j1HVZ8WCQ8ul
         JJaIMLoshzoST2xpJHfCB++FEGOD9nTRzhnPC7Y/JFkTaBJpAuIQlqwLNn63gvW5pK9R
         hma+ejrX+BWOcbuKE91vH+ZSl++VwSnNyI2ntXwb6dEZSULaXjx1Q3EhmfJMZiYZ3qN9
         shW1EQMHsqN9QvTBR9MFJC7vm6nGSAYbGmspQedXuTzVVtJw9FfDy/4QqPR/R2PlX8W+
         UeImpdM34CAEPvLzNSKSM0XLeyw75wbXSw68xjI2j0/UJmpHSLdYGxep/Vh+EHn597tx
         xH8Q==
X-Gm-Message-State: AOAM533iY1QPIEgxVfN3NBQBYSJ9XoY7q9+CDQs+ZcU4qSG5gGGbgqFs
        9ttlah8qjnkn8IvSdeAD4xEUo87WEKEayckl2O/6C6hgJRI=
X-Google-Smtp-Source: ABdhPJyZFKRLZlFf431Uwa4w7Pzy0g2MERApG6aWxtZFQFbqDBqsmm/QAcKCPyS2nkkd/dm5mIYqw9uXN7boBtgK584=
X-Received: by 2002:aa7:c412:: with SMTP id j18mr14753564edq.163.1620432660567;
 Fri, 07 May 2021 17:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
 <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com>
 <YJXHrXWVDSgg5TZw@coredump.intra.peff.net> <CABPp-BEyUX8j-_rhNTyR5ZiqeLUWbBS-9q5+gEUWOEHpchambQ@mail.gmail.com>
In-Reply-To: <CABPp-BEyUX8j-_rhNTyR5ZiqeLUWbBS-9q5+gEUWOEHpchambQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 May 2021 20:10:49 -0400
Message-ID: <CAPig+cQw5xBK00rtMVw4b6e_21vgp33yYDfdRape202dpWQjbA@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 7, 2021 at 8:04 PM Elijah Newren <newren@gmail.com> wrote:
> I think I figured it out.  I now have the test simplified down to just:
>
> test_expect_success 'avoid traversing into ignored directories' '
>     test_when_finished rm -f output error trace.* &&
>     test_create_repo avoid-traversing-deep-hierarchy &&
>     (
>         mkdir -p untracked/subdir/with/a &&
>         >untracked/subdir/with/a/random-file.txt &&
>
>         GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
>         git clean -ffdxn -e untracked &&
>
>         grep data.*read_directo.*visited ../trace.output \
>             | cut -d "|" -f 9 >../trace.relevant &&
>         cat >../trace.expect <<-EOF &&
>         directories-visited:1
>         paths-visited:4
>         EOF
>         test_cmp ../trace.expect ../trace.relevant
>     )
> '

I believe that you can close the subshell immediately after `git
clean`, which would allow you to drop all the "../" prefixes on
pathnames.

> This relies on a few extra changes to the code: (1) switching the
> existing trace calls in dir.c over to using trace2 variants, and (2)
> adding two new counters (visited_directories and visited_paths) that
> are output using the trace2 framework.  I'm a little unsure if I
> should check the paths-visited counter (will some platform have
> additional files in every directory besides '.' and '..'?  Or not have
> one of those?), but it is good to have it check that the code in this
> case visits no directories other than the toplevel one (i.e. that
> directories-visited is 1).

I can't find the reference, but I recall a reply by jrneider (to some
proposed patch) that not all platforms are guaranteed to have "." and
".." entries (but I'm not sure we need to worry about that presently).
