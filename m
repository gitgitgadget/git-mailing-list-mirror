Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B7AC4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A185020878
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIYSxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:53:53 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:36332 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbgIYSxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:53:53 -0400
Received: by mail-ej1-f65.google.com with SMTP id e23so11103eja.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 11:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6EB6IMoQgf+8YUEo10hbFFmlhe8Jgjarq3Ujt1Z6FY=;
        b=NRwuaP7TKkRCL1yfyrxjBIrceYjcgbS7kKygJSjz2D9IYjoRs3IpUTjjuNLDKRpijd
         D5SPbmI5l+qn2CIB4F9HqPjx8zhnW0JDDxYL+Y8kXDd6hSYP1kh2WggJrJEfwGY4OOg4
         n8LbgaWb+914vRiD/2Q8ILw6nZzJXHwgwOKZfpAHDxS1WQqCPhy6AvWQw0yk+3pQdaal
         9/ESHa59IZCEVVopCb1mioRidiJHEZ8yzXmkFWMed+Z52wS7Y/c2v6+DwRvoAsXGtd9W
         z8q52tjQ4sTVmhYSwWc0e3xXCFfE/AOWnLriOW7Ugy8FCmNLJKqghwJnh1MfRRR98m4G
         lK4A==
X-Gm-Message-State: AOAM532pZR+fCZJ8PKPfb3YMQZTeJMrYfV7yO7ezCydxpzxD3kc30jP1
        /FS5qyvWQakcZl6z5LXsy5M9mMP0gRtnDWDjrSM=
X-Google-Smtp-Source: ABdhPJz7sVYwLCxfzvDXZvbkK+Z6GYtUPeYv5pgrul4hsKnMc0Gl3zixDs30kz5hFQMLs0virDhobeBqEUgMR+EEFTg=
X-Received: by 2002:a17:906:c045:: with SMTP id bm5mr3942515ejb.311.1601060030998;
 Fri, 25 Sep 2020 11:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com> <20200925170256.11490-7-shubhunic@gmail.com>
In-Reply-To: <20200925170256.11490-7-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 14:53:40 -0400
Message-ID: <CAPig+cQipTK8ePVLKMeytmaePZ8yWSoFCjue=huKORjPGpTg+Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] t7001: change (cd <path> && git foo) to (git -C
 <path> foo)
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> t7001: change (cd <path> && git foo) to (git -C <path> foo)

This is misleading. We don't want the `git -C` form in a subshell, so
it shouldn't be enclosed in parentheses. Perhaps write it like this:

    t7001 use `git -C` to avoid `cd` outside of subshells

> Let's avoid the use of `cd` outside subshells by encapsulating them
> inside subshells or by using `git -C <dir> ...`.

This is misleading in two ways. First, none of the changes made by
this patch add subshell encapsulation. Second, many of the changes
drop the subhsell in favor of `git -C`, so describing them as "`cd`
outside of subshells" is wrong.

It's also important for the commit message to explain _why_ this
change is important when `cd` is used outside of a subshell. A
possible rewrite might be:

    t7001: avoid using `cd` outside of subshells

    Avoid using `cd` outside of subshells since, if the test fails,
    there is no guarantee that the current working directory is the
    expected one, which may cause subsequent tests to run in the wrong
    directory.

    While at it, make some other tests more concise by replacing
    simple subshells with `git -C`.

In fact, fixing the cases in which `cd` is used outside of a subshell
is much more important than the mere mechanical conversion made to the
other tests by replacing a subshell with `git -C`. As such, I'm
tempted to suggest splitting this patch into two: one which fixes the
cases of `cd` outside of subshell, and another which converts the
simple subshell cases to use `git -C`.

> Signed-off-by: shubham verma <shubhunic@gmail.com>
> ---
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> @@ -11,12 +11,11 @@ test_expect_success 'prepare reference tree' '
>  test_expect_success 'moving the file out of subdirectory' '
> -       cd path0 && git mv COPYING ../path1/COPYING
> +       git -C path0 mv COPYING ../path1/COPYING
>  '
>
> -# in path0 currently
>  test_expect_success 'commiting the change' '
> -       cd .. && git commit -m move-out -a
> +       git commit -m move-out -a
>  '

This transformation looks fine, as do the following two tests which
get the same transformation.

I do have a very slight hesitation, though, that these changes go
against the grain of the tests. In particular, at the top of this
script, we see:

    test_description='git mv in subdirs'

which suggests that the tests really want to test the bare `git mv`
command while actually running in a subdirectory. This would imply
that these test should be rewritten as:

    test_expect_success 'title' '
        (
            cd path0 &&
            ...
        )
    '

However, it's such a minor misgiving that it's probably not worth considering.

> @@ -364,16 +356,10 @@ test_expect_success 'git mv moves a submodule with gitfile' '
> -       (
> -               cd mod &&
> -               git mv ../sub/ .
> -       ) &&
> +       git -C mod mv ../sub/ . &&

Okay. At first glance one might expect you to strip the `../` from the
argument, but indeed `../sub/` is correct since `-C mod` really does
change to the new directory, so the argument is interpreted relative
to `mod`.
