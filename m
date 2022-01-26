Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517D6C5DF62
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiAZAjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:39:08 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43742 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiAZAjH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:39:07 -0500
Received: by mail-pg1-f179.google.com with SMTP id g20so1585103pgn.10
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDXN6jpKybHEMZbLRTvi2RmDChwuJtjjlCOG/SZKlGE=;
        b=PfXFYLLduPB+//MGkOpYt1h4NakzPzEtSvMXkhJHN1nHtHY7FbdVnbCL2elNYtMMUj
         gfbZMnxWZAWwEhJAxEkfml5CnJEY5j8lGIqldqa2Mv5wmKJ15zR3IL91XLjKNz0hrENX
         EFIyNUHeQ9WJ79PXiYpHeH4Wg7+T9mQVQOF/fomhctkOPahxB8Za+QfVRkH1OL2yd/qp
         mrlr4NLxg6wGr5/gvmTPo8008AC9baxlRRT074vjznuyIGCVQ1BEeifQUAM9wslGJuZU
         mhzku6k4rb8GQYvcdAFlt4C/mDE9NKamWSurMAqqn29cMzw9+/sqtXDCGfr1QVy2qBnm
         QhLw==
X-Gm-Message-State: AOAM530Eis+3qnWxad0gWzQhKJ95kPf1fQybfXAHjcQJGECwvBT2PP/a
        RmXFApDRpJ9WZhs/KvZYkz1/W4DFGeEdxoV2c2I=
X-Google-Smtp-Source: ABdhPJx1MRuh3z+QJWVBWmlkMlswfh/057iP89PN7H35kLlrOIuZaCTs1VgqqtHEK3Qd2IDT8V5Mwa70cRBftJbshQQ=
X-Received: by 2002:aa7:8d02:0:b0:4c1:b464:9826 with SMTP id
 j2-20020aa78d02000000b004c1b4649826mr20729351pfe.67.1643157547051; Tue, 25
 Jan 2022 16:39:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com> <CAPig+cT3Zqa2BLsZ3ZVPCj4-bW5eb35sWXV-mYLqA-dvzC8XJg@mail.gmail.com>
In-Reply-To: <CAPig+cT3Zqa2BLsZ3ZVPCj4-bW5eb35sWXV-mYLqA-dvzC8XJg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Jan 2022 19:38:56 -0500
Message-ID: <CAPig+cRCzUinKr0iQkDMK0Af4=47xKZJKphcuTRxt4BaxrYwfA@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
To:     Elijah Newren <newren@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 7:32 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jan 25, 2022 at 6:59 PM Elijah Newren <newren@gmail.com> wrote:
> > On Tue, Jan 25, 2022 at 12:27 PM Glen Choo <chooglen@google.com> wrote:
> > > +test_expect_success 'rebase when inside worktree subdirectory' '
> > > +       git init main-wt &&
> > > +       (
> > > +               cd main-wt &&
> > > +               git commit --allow-empty -m "initial" &&
> > > +               # create commit with foo/bar/baz
> > > +               mkdir -p foo/bar &&
> > > +               touch foo/bar/baz &&
> > > +               git add foo/bar/baz &&
> > > +               git commit -m "add foo/bar/baz" &&
> > > +               # create commit with a/b/c
> > > +               mkdir -p a/b &&
> > > +               touch a/b/c &&
> > > +               git add a/b/c &&
> > > +               git commit -m "add a/b/c" &&
>
> This is entirely minor, but all the inner subshells in this test are
> superfluous. [...]

One other minor comment: If the file's timestamp has no significance
to the test, then our style is to create the file with `>` rather than
`touch`, so:

    ... &&
    >foo/bar/baz &&
    ...
    >a/b/c &&
    ...
