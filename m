Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B4C433EF
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 11:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbiBELmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 06:42:52 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45766 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiBELmv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 06:42:51 -0500
Received: by mail-pg1-f177.google.com with SMTP id z131so7232096pgz.12
        for <git@vger.kernel.org>; Sat, 05 Feb 2022 03:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bd5dkfwynuxpfrhSwbRtHtMsbJnUEBgSfwzlGNT1MbE=;
        b=NFXkRgefn8EoJFkW7mwhs1iBae7++kGl5IGA3T/CCxI3l9dZi15W7cNrhj9O/pTcGR
         ZbFkrQajDttxuxIohYH3KUEDl8OPLZ0NUCGR4Ix1Y478yoYXJYu02VGzZ09X4yrQ9YS1
         xAw5f4rxnjEpQoxNjeHeSXmfHQ0p9cWOAPwo6Mh2XPRbkN15zK+znnXE5IfN7Vx0HyRD
         dyDm/WsZgJa9GqJkDtirLHCxTTU5y51nEjyJgalAFafM13v1fpidi+gEyRiC4EhKtaBq
         /li/SQmVeXNHt0RFUJ2zl1ChasbU3CPf526137dNooV/nGh3PhtBPyKX2RcCv/IregjI
         wK0Q==
X-Gm-Message-State: AOAM530a42F7t3XJqy7HE8wGedC4dnnGnwxya6SmjOwvcpizoRJt+wkg
        cOxEtaI4to6rPKVg5zMEOG4Sug1pITbIkmIIhtMD012C2ug=
X-Google-Smtp-Source: ABdhPJwfWQ3J3zNfNEhwJs6vlgvnMzb1huvMwk2S9IUBaCJK/ztAeU7M+vWinJYMeNtUS3ULLTuvPQK1CPWFYFRBlhY=
X-Received: by 2002:a63:2c07:: with SMTP id s7mr2649621pgs.181.1644061371180;
 Sat, 05 Feb 2022 03:42:51 -0800 (PST)
MIME-Version: 1.0
References: <CAPig+cQVNdmHQnhORqh2XtJSMhcOymR99pmKTWOAyhoQ10khSw@mail.gmail.com>
 <20220127200341.333996-1-newren@gmail.com> <CAPig+cSi8_90=-Fvt_fq=VtOW_HzifNhrk1gaa6F1GrEonng+Q@mail.gmail.com>
In-Reply-To: <CAPig+cSi8_90=-Fvt_fq=VtOW_HzifNhrk1gaa6F1GrEonng+Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 5 Feb 2022 06:42:40 -0500
Message-ID: <CAPig+cRCN=QQHupg1eOx9YvsLhgn+dDN6eYvQL6JhzknCa_3=w@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 5, 2022 at 6:23 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jan 27, 2022 at 3:03 PM Elijah Newren <newren@gmail.com> wrote:
> > Some comments on the various code changes:
> >    * clone/push/fetch related:
> >      * there are *many* subprocesses involved in fetch/push and friends,
> >        and they typically need to know the GIT_DIR they are operating on
> >      * this involves: fetch-patch.c, connected.c, bundle.c, clone.c,
> >        transport-helper.c, receive-pack.c, upload-pack.c
> >      * this accounts for the majority of this patch
>
> It does feel a bit like a bandaid to insert new code at these
> locations to set GIT_DIR manually. It's not clear to readers why
> GIT_DIR is needed for these specific cases, nor what the impact is
> when it is not set. Thus, one wonders if such a blanket approach is
> indeed required or if a more narrow and directed fix can be applied,
> such as calling subprograms with an explicit --git-dir= rather than
> setting GIT_DIR with its potentially more broad and
> difficult-to-reason-about impact.

I meant to ask here what was the nature of the various failures you
were seeing without GIT_DIR being set, and whether you had considered
tackling those failures with --git-dir= instead of GIT_DIR. If so,
were the problems too difficult to overcome by --git-dir= alone?
Fleshing out the commit message with such information might be
worthwhile.

By the way, I also didn't mean to imply that the
"difficult-to-reason-about GIT_DIR interaction in relation to
subprograms" problem is new to this patch; it isn't. That problem has
been around for ages (at least since 2007-08-01) but it wasn't as
obvious since the setting of GIT_DIR was so far removed from other
code which runs subprograms, thus readers likely wouldn't be thinking
about GIT_DIR when reading the code which runs subprograms. This patch
only makes the problem more obvious since readers now see the
sequence:

    (1) set GIT_DIR
    (2) launch subprogram

So, a reader is more likely to wonder why GIT_DIR is needed for the
subprogram and what possible wider side-effects it might have.
