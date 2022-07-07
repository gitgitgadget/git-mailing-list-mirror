Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B7FC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiGGQ7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiGGQ7A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:00 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CA7B86B
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:58:59 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k15so17433370iok.5
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=pEQV3eyRE2OmqHYuRytso+buCe/q9COGAdmre4nbPFw=;
        b=ALU9Ht8y0ZRrYKLiw42dWmKf/16vpDw6iVBUs6kuS/DpVrtQV8uVvM0r2IOJkksn34
         sNejXfcN0MZNRFb31rIO3Jie71KDuHySdERxJg4b/Bk/9VezIxcPMPR+hMJ1XMk/4pxZ
         nQlVr/GPZC4RRN10wwW+WMzC9AQJu3/aTd3w4eYeDNWfLRgwNWSha4XY09/AYHy6Kpna
         qc7+s3pQQjEBcS3L83GUfc3vhU+p4VAwtfew+SgWilWt678ikbfTU3BRGgiXfBK/pfs4
         m3QLaeZ7yu66MZCdaiB8f9T1abd8XjzBVP2GE/9n25hQhK/jPA7kUtVw+zhdI1vujvNS
         aMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pEQV3eyRE2OmqHYuRytso+buCe/q9COGAdmre4nbPFw=;
        b=JI1qwrENXYTfkTCmxOqHx0zLBXglu63k18z7DfwvltSg8SQXxaTi3R0BjZ4+59xA0Y
         RX5+euWNe06Ua0YFbame3x7K8jr+srtjZ/p9GjApFMdivj6PW7PjyLP737qqavEou8oG
         xKdJW/L2C7vkhJ3mgPPSrQ36PS3rPyEc11RYbm+XqHUUJLr9+4tqrrUYKcMxPfVCYHYN
         y3P9zas9Rpz9XL8KdctyP0WwbJ4VKgIoU5sPbjuUef6aZb74667urmK3SuNsNWLHgDJ1
         +Vq8qgsxS4pO8hUEAmzX2ZA26euSW6e8/AvN1ruOEzhPQVpIhsA7aI32n4Dosnym09Wr
         bQrg==
X-Gm-Message-State: AJIora8236c9CIhU4sdvmzrJ9Wu870oAjyJxe/SumrDTBbGxK854+k47
        oiLnHWWntGwDKdH5gvVouzSs87J3rfcBilubqdCm32XUzpQ=
X-Google-Smtp-Source: AGRyM1vzak6P10ZpjJqxVcGtQho07KkGa0iEysqp296+glxvxzpS0U6Z4DcwCUwH94wYrYaVqXQ87yZ30bOHiLJLlX8=
X-Received: by 2002:a05:6602:26d1:b0:669:734a:4c8a with SMTP id
 g17-20020a05660226d100b00669734a4c8amr25719455ioo.209.1657213138870; Thu, 07
 Jul 2022 09:58:58 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Klein <mklein994@gmail.com>
Date:   Thu, 7 Jul 2022 11:58:48 -0500
Message-ID: <CACRpdvnuAYY0U1_3uD8zKgtq05+bgwjzXpZKomro6gqYDNrjGg@mail.gmail.com>
Subject: Bug with splits in new nvimdiff layout
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I encountered a bug when using the new vimdiff layout format.

To recreate this, start with a merge conflict, and merge with this command:

    git mergetool --tool=nvimdiff

I expected the layout to be:

    ------------------------------------------
    |             |           |              |
    |   LOCAL     |   BASE    |   REMOTE     |
    |             |           |              |
    ------------------------------------------
    |                                        |
    |                MERGED                  |
    |                                        |
    ------------------------------------------

The layout when I ran the command was:

    ------------------------------------------
    |                                        |
    |                LOCAL                   |
    |                                        |
    ------------------------------------------
    |             |           |              |
    |   LOCAL     |   LOCAL   |   MERGED     |
    |             |           |              |
    ------------------------------------------

I expected the layout to be the same as what was documented to be the default
for "nvimdiff".

In my init.vim configuration file, I have these lines set:

    set splitbelow
    set splitright

These options globally change the behaviour of the "split" command so that
instead of "split" creating a new window above the current window, or to the
left when used with "vertical", it does the opposite. Docs:
https://neovim.io/doc/user/options.html#'splitbelow'

I recommend using the "leftabove" (a.k.a "aboveleft") command together with
"split". Since these windows are positioned absolutely (according to
"mergetool.nvimdiff.layout"), it shouldn't depend on the user's configuration.
Docs: https://neovim.io/doc/user/windows.html#:leftabove

The previous invocation (i.e. "4wincmd w | wincmd J") didn't run into this
issue, since its not affected by the "splitbelow" and "splitright" options.

Hope this helps,

Matthew

[System Info]
git version:
git version 2.37.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.18.9-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 02 Jul 2022
21:03:06 +0000 x86_64
compiler info: gnuc: 12.1
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
