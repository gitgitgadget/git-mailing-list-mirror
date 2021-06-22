Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B72CC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 22:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB516134F
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 22:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFVWmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 18:42:35 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]:36774 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhFVWme (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 18:42:34 -0400
Received: by mail-qv1-f51.google.com with SMTP id im10so443066qvb.3
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 15:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Klj/ssVtrigw92bBrIQ1CfsEH9ceTg1zCX5RzYFsJwo=;
        b=iNqGnaY5/dDi8bAsGL6TPbSRZGHeWa3zH0PlxPnbbHH2yphBS35I00vs0sU3hC2VlT
         xrm2EX7M0+OM+/eXdCxYhGIr4FFf3fHHfqa+hFL/AIILKJwH4nuAird8Z5bSmcLPR6Ym
         Xd3XFUT9y7Du/4pg3P2YR/JSCbrTEXqaL2EbusMUZA6VG4oyTXSq1ddfQDu1DvtdlDnN
         bNN2isyRqx5vPrpY9wznu6jLV7EmxH22cXq9fgCwDs8kbnU6KvS9oiZ2NhD/IzkBPGHM
         fugbYvJRdtcXhrt057NNCmEyjba7l8Xw1CLcfu4D/f+MvTx4HIJYhIwTNPU0uGHNQhse
         R4+g==
X-Gm-Message-State: AOAM530FsHSJO0WubD36p0Ksfx0EJG1MNsi2DDxGSmB+Q4nRQbX+ibtJ
        Bn0McJY6njhlJExyDbioRGG54QGzimemqw==
X-Google-Smtp-Source: ABdhPJwUGj3zYq2XjveWAkPYpamXwnakizcpjP65yr63CndZSADdgoFQGLfnFCR2pM4stzCumNTtvw==
X-Received: by 2002:ad4:4d09:: with SMTP id l9mr1257924qvl.25.1624401617333;
        Tue, 22 Jun 2021 15:40:17 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id a18sm1142904qkn.37.2021.06.22.15.40.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 15:40:17 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id r7so666482qta.12
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 15:40:16 -0700 (PDT)
X-Received: by 2002:ac8:5755:: with SMTP id 21mr1016030qtx.267.1624401616745;
 Tue, 22 Jun 2021 15:40:16 -0700 (PDT)
MIME-Version: 1.0
From:   Avishay Matayev <me@avishay.dev>
Date:   Wed, 23 Jun 2021 01:40:06 +0300
X-Gmail-Original-Message-ID: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
Message-ID: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there!

Fugitive[1] is a vim plugin that wraps git and many of its commands
into the editor in a really awesome way, I won't meddle into it too
much as you can read about it in its README, but as you understand, it
uses git, a lot.

Some git commands use a pager, which is usually a program that needs a
pty to function properly (`less`, for example). Fugitive can't really
use a pty for the pager as vim runs its subprocesses without a pty.
Therefore Fugitive just creates its own pager (which is a simple
window in vim) and pastes the git command output there.

The only problem left is that Fugitive can't reliably know when git
decides to use the pager, for example `git reflog show` does raise the
pager while `git reflog expire` does not. Fugitive currently maintains
an (very possibly) incomplete list of commands that need a pager but
maintaining it manually isn't ideal.

I started discussing this on an issue in Fugitive's github page[2] and
Tim Pope (the creator and maintainer of Fugitive, thank you!)
explained that `git` doesn't use a pager if there is no pty so it's
impossible to override its behavior.

We had some ideas how to make this feasible (as you can read on the
thread) but for brevity's sake I'll present the best (IMO) idea:
Essentially, at `pager.c`, don't short-circuit in `git_pager` (or
`setup_pager`?) due to pty absence if a new environment variable is
present, perhaps something like `GIT_PAGER_FORCE` which will override
the `PAGER` and `GIT_PAGER` variables. This will allow Fugitive to
apply custom logic through to pager to know if one exists and present
the window in vim.

I will appreciate any written thoughts on the matter, thank you :)

P.S. I am a complete newbie in regards to mailing lists etiquette,
pardon me if I've done anything incorrect
P.P.S. I CC'd Junio C Hamano because he signed off on (almost?) all
changes to `pager.c`, sorry if that was wrong of me (You probably got
this mail twice because of a misconfiguration, oops)


1. https://github.com/tpope/vim-fugitive
2. https://github.com/tpope/vim-fugitive/issues/1772
