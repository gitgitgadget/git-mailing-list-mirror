Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F245CC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiAZRxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:53:32 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:46635 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243961AbiAZRxb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 12:53:31 -0500
Received: by mail-pf1-f181.google.com with SMTP id i17so353805pfq.13
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzfJCc7avuHiIu5xigT1aVaJdDC5rdn3aqF0VxhOyVY=;
        b=ehc4NvmRPtRGDCuCK7sMV7mEMrEIHF/DVpi8y2V2LQmr1qtxCwtAAuPRonno2NCf0O
         0+8v4mtFiEUv26VOg844h86uKawL2HFHOPJAixRCUqdRcGMlqj59RTmzi0jBV4JhR48D
         QxZ5vYClaH9bXiDjt57m85JQXkM5Ad2+Mm0dHWCJjW5aYYlkf5hFz8e0x1FZYC3NsbPg
         jEDrAR640uViM7Tf94XPTwdYQqptkJQvn75xeFW6XBrJL6xQkHZZ6oKnVLF83AmrkvIS
         cu/KGDg8O8JspIUzKNEHsJPw7SZL36Io6QvZgXNlakS/sulAqqNlO5ffwyGCCD4USYZj
         7cfQ==
X-Gm-Message-State: AOAM533Hu0bX2xNsINZ0zMmnft/KupcqumTc6Cs4h9H/3rBs70V3mi8z
        KmBc5dfFlgk1la5VRn/4GIWjZMXT9ECIC5qJY6w=
X-Google-Smtp-Source: ABdhPJwL9U3UlvOntD8tioIjm0nre24X9XTUbdA0XPr/pZKnc4l/EJOx+2OqIZj/Zi8HdnqGuRvZ44Xb3fOdwX0Zhtk=
X-Received: by 2002:a63:a10a:: with SMTP id b10mr9520pgf.227.1643219610807;
 Wed, 26 Jan 2022 09:53:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com> <4cdb1e15-31d8-7fa4-b1f3-b43498685e13@gmail.com>
In-Reply-To: <4cdb1e15-31d8-7fa4-b1f3-b43498685e13@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 26 Jan 2022 12:53:19 -0500
Message-ID: <CAPig+cQVNdmHQnhORqh2XtJSMhcOymR99pmKTWOAyhoQ10khSw@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren <newren@gmail.com>, Glen Choo <chooglen@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
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

On Wed, Jan 26, 2022 at 6:00 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 25/01/2022 23:59, Elijah Newren wrote:
> > There's nothing wrong with running checkout from a subdirectory.  It
> > is unfortunate that setup.c auto-discovers both the git directory and
> > the working tree, but sets GIT_DIR without setting GIT_WORK_TREE in
> > the case of a non-main worktree; it's not particularly friendly for
> > subcommands.  Of course, it's also unfortunate that sequencer still
> > forks subprocesses other than those requested by a user with e.g.
> > --exec.
> >
> > But, anyway, I've got a patch that I'll send as soon as it passes CI
> > (https://github.com/git/git/pull/1205).
>
> The patch hasn't come through to me on the mailing list yet, but it
> looks good. I thought we set both GIT_DIR and GIT_WORK_TREE when we were
> in a non-main worktree but obviously we don't. Eric do you happen to
> know if that is intentional?

As far as I know, there is no reason to set GIT_DIR and GIT_WORK_TREE,
in general, when in a linked worktree since each worktree has its own
.git file ("gitfile") which tells Git commands where the repository is
and signals that that directory itself (which contains the .git file)
is indeed a Git worktree.
