Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A0C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 00:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJNAjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 20:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJNAje (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 20:39:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B330F18F90D
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 17:39:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e20so3956694ybh.2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bas+81lMicbSbX5BQ2cJvVMUg1s0XAk0+owrjrtTV14=;
        b=jIF17pO2BMz3lhWNiljuVZ7Zs2nSfpkoZlv7Vfz7zoQ6m+6eIhEmofVQSs3zR1bHbX
         /CC14vqAGHAT3TyfGeAIUJmAWU0laiLrtfGDGAF6mY8S8bZc3SbfIfOEsBVEsvR3TK94
         K0WhbGcFtqgmnxouXuUB3wOmS0v1HRjBp6S/o5fFPbyg7hb2Sh9LQeTYvwEJypn0S5QQ
         d/ihlw9sukSej3wKZClfVBf0Hm4HdpDvmSCvOslHsg3/tynv1xm7Fr9uxCRlotpV2vLr
         uaZusCuELna0bH6s+jNTuypFsnPDIIxzBxIYY3Opl78bIApNen97mwezznl5J++eHDIi
         wv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bas+81lMicbSbX5BQ2cJvVMUg1s0XAk0+owrjrtTV14=;
        b=fzqvXRwZ5RC/Lw2ZFihTLQg94IEYQ0QDlvi8nw/ZY9ztqoHEfMWUuMK+onDoNFSLFl
         3S84t8/m4a7VdK4mM/jBybXIGhhmba936vMCXrmqO+rOFyb+9bl4abf/aYb9rU9fgHyr
         33u1Fmjt0ThFClDg2UbfakRt5A5II4iKqiXoEpIpH1TKqx67a2U5M7+XXE92RvBtRRQB
         4Q2ERk7zkPbkNDThscRoXeK8DyBSIuhlt2ZdJW/zCZBwv4xPLXxttfCDLb73HrKpmGxK
         iFwRj2UAEc4Gfo1ieN797EbD9ulJnupoxSalXjnhQYj6GCe1SiIhdMaLy32/yPrgmNU3
         +7XQ==
X-Gm-Message-State: ACrzQf3ONTuaJXNAADViY34XUk2OLAxMXt6ylGdP6yPd4SkNrdurkrPR
        qTQ7XTgDrPcqUkI6ye7F0v+Gq89lpgFNbLU7CWeio+XY3TG7cg==
X-Google-Smtp-Source: AMsMyM7nmDhkqVTmErbpvz9Awp6EerTsPNBC44Vo0rAixPiOpobX7wouzVqLkTUkDWBWcliOqtmP95SNb+abv+AY+44=
X-Received: by 2002:a25:1605:0:b0:6bd:284c:62b with SMTP id
 5-20020a251605000000b006bd284c062bmr2423812ybw.391.1665707972893; Thu, 13 Oct
 2022 17:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221011232604.839941-1-calvinwan@google.com> <xmqqczaxmvv9.fsf@gitster.g>
In-Reply-To: <xmqqczaxmvv9.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 13 Oct 2022 17:39:21 -0700
Message-ID: <CAFySSZAi_XtwAQeVDgbjXD7vnGuYgNLNo+6NNJP0QvH64KxPOA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] submodule: parallelize diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Calvin Wan <calvinwan@google.com> writes:
>
> > I also wanted to pose another question to list regarding defaults for
> > parallel processes. For jobs that clearly scale with the number of
> > processes (aka jobs that are mostly processor bound), it is obvious that
> > setting the default number of processes to the number of available cores
> > is the most optimal option. However, this changes when the job is mostly
> > I/O bound or has a combination of I/O and processing. Looking at my use
> > case for `status` on a cold cache (see below), we notice that increasing
> > the number of parallel processes speeds up status, but after a certain
> > number, it actually starts slowing down.
>
> I do not offhand recall how the default parallelism is computed
> there, but if I am correct to suspect that "git grep" has a similar
> scaling pattern, i.e. the threads all need to compete for I/O to
> read from the filesystem to find needles from the haystack, perhaps
> it would give us a precedent to model the behaviour of this part of
> the code, too, hopefully?

Setting grep.threads=0 does default it to the number of available cores
(at least the documentation is clear about this). I tested "git grep" on
my machine and found that it started slowing down after 4 threads --
this is most likely because my NVMe SSD uses 4 PCIe lanes aka it can at
most do 4 reads in parallel. AFAIK, there is no way to tell how many
reads a disk can do in parallel. This coupled with the fact that other
commands have varying levels of IO requirements makes it impossible to
set a "reasonable" amount of threads.
