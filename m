Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44575C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351457AbhLCNLZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 3 Dec 2021 08:11:25 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:34566 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbhLCNLY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:11:24 -0500
Received: by mail-pg1-f170.google.com with SMTP id 200so3000291pga.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J7uVeLtAiQJiuuVgaIkwyJR3QHc2xhBDJQKK5Ls0jxo=;
        b=CIYx6sEqhEC/qBTi3BJMVOFhrTkRj+2NXw5isB9GsWqZqL4gcq0E130Wyz2FixQyhY
         i6A89iJmQ/awxr5MMfUn3ZxGD2sKltEKSQ5EAnYm2fHwYVGRquzQGbFTNgPFtuUCtqUf
         ekAa+sOeK3meD86D55Wuf4c8LgJ2FJcLX8hAawhU63uUThUbZH+UD1BkbqABlSZGWurD
         DmGCG39jtuB9B+axaUWSXsIlSVtNqXeOnV3l7ONQ7UuwlK5QFa35Pf5mxG179cPc0HRS
         48S8H2cBuuqnyJ6r+++YdKKToxoxosPDVXWImYEse/ghcNBquNT81G/VRsnDoWuJDYVo
         lTgA==
X-Gm-Message-State: AOAM532gEnqUcL8mK0tPz90kvvwQs1+Nts/05V8ylJkUCfMEoViy6LVn
        afzaqvrI1WFXQWZhLs2f9gmB/3mo13VdrDHFOQG1ns+6nDJ+OA==
X-Google-Smtp-Source: ABdhPJxcpiKakzDJvMSRchx85niZ8u0coVcJshfwLkRLZnHEZkYENH+CQi7IY57jucAvZ+uSef5SYycDm1bxKsmT58s=
X-Received: by 2002:a63:380e:: with SMTP id f14mr4365399pga.227.1638536880598;
 Fri, 03 Dec 2021 05:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20211203034420.47447-1-sunshine@sunshineco.com>
 <20211203034420.47447-2-sunshine@sunshineco.com> <211203.86fsrat592.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.86fsrat592.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Dec 2021 08:07:49 -0500
Message-ID: <CAPig+cQ1+Hm=2jNKais-X6ahKCkG4Xo9Z4WsqTYryETc9a4mTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] worktree: send "chatty" messages to stderr
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 4:19 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Dec 02 2021, Eric Sunshine wrote:
> >       git worktree add --detach orig &&
> >       sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
> >       mv orig moved &&
> > -     git worktree repair moved >out 2>err &&
> > +     git worktree repair moved 2>err &&
> >       test_cmp expect .git/worktrees/orig/gitdir &&
> > -     test_i18ngrep "gitdir incorrect" out &&
> > -     test_must_be_empty err
> > +     test_i18ngrep "gitdir incorrect" err
> >  '
>
> This is just a "for bonus points", but maybe we could/should while we're
> at it harden and make the tests more exhaustive by checking the full
> output of both, e.g.
>
>         cat >actual.out <<-\EOF &&
>         Preparing worktree (checking out 'bar')
>         EOF
>         cat >actual.err <<-\EOF &&
>         fatal: 'bar' is already checked out at '.../wherever'
>         EOF
>         <cmd> [...]
>         test_cmp expect.out actual.out &&
>         test_cmp expect.err actual.err
>
> Doesn't need a re-roll etc., just if you're interested... :)

To be clear, with the application of the current patch, both of those
messages would need to be in the `actual.err` file, and `actual.out`
would be empty; not one message in each file as in your snippet.

That aside, there's still potentially output which is outside the
control of git-worktree. In the case of this particular negative test,
your suggestion should work, but for a positive test, it would be
harder and uglier (though, of course, not impossible). For instance,
for a successful `git worktree add`, the output is:

    Preparing worktree (new branch 'foobar')
    Updating files: 100% (3993/3993), done.
    HEAD is now at abe6bb3905 Gobbledygook

The subsequent lines come from git-reset (which, by the way, is
sending "HEAD is now at" to stdout, though they probably should be on
stderr, but that's a separate issue).

Anyhow, such a change to the tests should be a separate topic. The
user-facing problem addressed by the current patch series need not be
held up by a behind-the-scenes change to testing.
