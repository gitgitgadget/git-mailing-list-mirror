Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B297C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 09:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhL1JMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 04:12:07 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:45898 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhL1JMH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 04:12:07 -0500
Received: by mail-pg1-f170.google.com with SMTP id 2so15476517pgb.12
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 01:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGRJ2xQSLqz6kH3JPdeu8SZbU8YqFOqn/1XIBEAN6Ro=;
        b=XhioVTKt7okRYNUpWPgi5IfZIsYl23iQKRRYD8ARohGeXIFHS4FEVPmlatAudsBXPK
         vOstYsk/f7kO3ycLqFTVySM6HB9E9BnO87oBYFqM6p5M+4euZxen77azEyBjrSvos40O
         z2y0iBGUOU+3CR6/sGWSo1F4HPvYeG8AN/VYGh9RsE3fI5WhomwjDI7L2h4CEiuU9E2i
         MHw+eM8R2mphBBNeCZyKikL75PAJnc8xfYxOqhG6hvKzZ9tI55LHR8UIyefU2zFSn48F
         IPvUGFsfjS7Mj42UaJZNVX5PHRhd7Tj3sTNA7VGbXt4AnD9M3ko3igz87plFvIGQ+xJH
         SaSw==
X-Gm-Message-State: AOAM531+g1d7DW9Oq9dV8z+qQs6DWm8dSD1Qu3by8Z5WYmX67hKKsK7p
        LAssYH8hhdjK4ltJfqM02sOQzU8ovSEg59OI6GbqGZXU5pY=
X-Google-Smtp-Source: ABdhPJxIadQL1ecG/DOXn0gTvoNo3rJYbwSGqnPKxeXEkzDEEUC04DTBakvX/fWelmN5IPD817bBnQ+vZnQNLVHlU2I=
X-Received: by 2002:a63:380e:: with SMTP id f14mr18550987pga.227.1640682726733;
 Tue, 28 Dec 2021 01:12:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
 <CAPig+cQjYiARBwSZTsswk442TvDC2UiyOx5wNdRwF6C7i8ENxA@mail.gmail.com> <CABPp-BHMr32MuisNzt-R3O4=HPY63HQT0=ykrbtiASyS1K_JjQ@mail.gmail.com>
In-Reply-To: <CABPp-BHMr32MuisNzt-R3O4=HPY63HQT0=ykrbtiASyS1K_JjQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Dec 2021 04:11:55 -0500
Message-ID: <CAPig+cTFSDw-9Aq+=+r4sHSzTmG7s2T93Z0uqWTxHbKwGFaiYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 27, 2021 at 3:16 PM Elijah Newren <newren@gmail.com> wrote:
> On Sun, Dec 26, 2021 at 11:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Your proposal is _almost_ the same as my suggestion of eventually
> > making per-worktree config the default. The difference is that you're
> > only making it the default if `core.bare=true` or `core.worktree` is
> > set.
>
> Indeed.  :-)
>
> > But do we need that distinction? If people are comfortable with
> > that, then are they comfortable with simply flipping the switch and
> > making per-worktree config the default today regardless of `core.bare`
> > and `core.worktree`?
>
> This is tempting, at least if we leave core.repositoryFormatVersion as
> 0 (see 11664196ac ("Revert "check_repository_format_gently(): refuse
> extensions for old repositories"", 2020-07-15)) when core.bare is
> false and core.worktree was unset.  However, for that case:

I'll try to respond to this email when I can find a quiet block of
time to really concentrate on what you're saying and reason through it
more thoroughly; it will probably require several read-throughs.
