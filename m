Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4D4C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D633C2310B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbhAFJIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:08:22 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:36639 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbhAFJIV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 04:08:21 -0500
Received: by mail-ej1-f49.google.com with SMTP id lt17so4137595ejb.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 01:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fknoFHk6mJqwKsMePT16odMlkIYpmH0O8qIJLwGUlls=;
        b=UOiYWNe9eS9JvBbBFSR/Ls4kZawcTcBhAj2YvdkWIdua1aqd5QV6Ke5cgPpM2EKltZ
         ZGirrapx8LpBaa1hHO1ryUfQbQpzjGlpuD1iOhGkI5reCmFJQ0gOjSWg57oprHxOQVUQ
         eIgjRpFWDrHDs0k6CEKYol0UNFO0zD1Msw6QliIBGlBYWl4BWFkhM1a8nqG74RR9mgFX
         aHq3P7ppMP5RR0JvaWO2SvRUvuZpmbf3FFj+5NzcOG6fsC0sJpRlWLa39+WH1o/fAsSN
         v4bpTvS7x6rKV/QQRM/dgitq3eAO9XOqNOJKOM1LJsLz2yLp8oNvkJ4UxPz+sVLqaQh5
         5Upw==
X-Gm-Message-State: AOAM531h1ijzqyI1g5ODgYg429D8hNflu4V1NcPlCPI+jdTAeE586cvZ
        LCyXBGEvnybf3qZCccQ798uodS5spAtjhvyYbqo=
X-Google-Smtp-Source: ABdhPJx/ZEfW7yyfeVm84vu/hARu+NfiqWGKUoS1jUYL/hV2jfOWJTrGRdHPHH0xMbPbLM+HMS2NK2aGqRVVy00MYpA=
X-Received: by 2002:a17:906:b287:: with SMTP id q7mr2060009ejz.311.1609924059198;
 Wed, 06 Jan 2021 01:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-6-rafaeloliveira.cs@gmail.com> <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com>
In-Reply-To: <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 04:07:28 -0500
Message-ID: <CAPig+cSy03+n_gSEiWJ4ebU1GFYvmfqeYCqs4_xzV9=5tyMGag@mail.gmail.com>
Subject: Re: [PATCH 5/7] worktree: `list` escape lock reason in --porcelain
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 5:29 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 04/01/2021 16:21, Rafael Silva wrote:
> > In case the lock reason contains newline characters (i.e: LF or CRLF)
> > this will cause the format to break as each line should correspond to
> > one attribute. This leads to unwanted behavior, specially as the
> > porcelain is intended to be machine-readable. To address this shortcoming
> > let's teach "git worktree list" to escape any newline character before
> > outputting the locked reason for porcelain format.
>
> As the porcelain output format cannot handle worktree paths that contain
> newlines either I think it would be better to add a `-z` flag which uses
> NUL termination as we have for many other commands (diff, ls-files etc).
> This would fix the problem forever without having to worry about quoting
> each time a new field is added.

Adding a `-z` flag makes sense, but that doesn't mean the existing
`--porcelain` is meaningless without it. I see `-z` as a good
complement to `--porcelain`.

Yes, we should fix the problem that the existing porcelain output
doesn't escape the path, but that can be done as a separate bug fix;
it doesn't need to be rolled into this series.

> If you really need to quote the lock reason then please use one of the
> path quoting routines (probably quote_c_style() or write_name_quoted())
> in quote.c rather than rolling your own - the code below gives the same
> output for a string that contains the two characters `\` followed by `n`
> as it does for the single character `\n`. People are (hopefully) used to
> dequoting our path quoting and there are routines out there to do it (we
> have one git Git.pm) using a function in quote.c will allow them to use
> those routines here.

I was going to suggest the same. Thanks.
