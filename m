Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39467C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 15:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3E120734
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 15:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgFJPVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:21:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38393 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgFJPVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 11:21:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id f185so2197873wmf.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 08:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nY6aTStW/Ywv2p0mXrs8hKKSrwlgYRjdTb8lzr7+lBs=;
        b=AaK3Nfl9074w/lV2xUQ+w5vNeTPe0QCAJhGuVT5Q4PPpf0SIRAiQPoNsRRChcVdd9u
         UsD9iHiF0b9CCujy+ISk35Rl8qP+GokKan/ErGW65LcWRzFrxDsY1EuRU8LOva2hndUO
         hn/OkPwrJ5e5y/WB1Yz7Ms9mmOPG1/pFLUt7ghVWe1PgjHrGIFwHX+OEbgryypKOId3f
         58uAAT87qxyFSWiBxAIjT3hLYn4JyNTpkzArLSiWZfNoKjjOTKr40kBgm9PCEamqJe5E
         g8J6l2IiXEmIgFF8yQ8zD5FRpFyE5nFRB6tQu376cFrEvmlDD8SbK5dVZ2ieuW+TYhdF
         ognw==
X-Gm-Message-State: AOAM531y+ZKfO/MSY0kuRVwNdDaZqyDr/YmdGTCYDbhYEJDHfgQF7P1b
        hJRAqqo8kzJub8VV9JuOXstk5mX3r/Lr/k2DD7w=
X-Google-Smtp-Source: ABdhPJza8Yp2E7M9NP93Is75oiNwOYvee4kcu9VSkgqG44yNH8Y75PQDHNRewItnfAze8MBgzF5i/N+B0ym2pPIZP2U=
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr3653805wmg.130.1591802482189;
 Wed, 10 Jun 2020 08:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200610063049.74666-1-sunshine@sunshineco.com>
 <20200610063049.74666-5-sunshine@sunshineco.com> <20200610115028.GA11750@konoha>
In-Reply-To: <20200610115028.GA11750@konoha>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 10 Jun 2020 11:21:11 -0400
Message-ID: <CAPig+cQjR78+wanyRXhB33qsVwHqjSAc_c1O+CG6ZkJi6W3mDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] worktree: prune duplicate entries referencing same
 worktree path
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Jonathan_M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 7:50 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> > +static int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath)
>
> What exactly is the role of 'wtpath' in here? Maybe this is explained in
> the later patches.

'wtpath' holds the location of the worktree. It's used in this patch
by prune_worktrees() to collect a list of paths which haven't been
marked for pruning. Once it has the full list, it passes it to
prune_dups() for pruning duplicate entries.

> > +static int prune_cmp(const void *a, const void *b)
>
> Can we rename the function arguments better? 'a' and 'b' sound very
> naive to me. Maybe change these to something more like: 'firstwt' and
> 'secondwt'? Yeah even this sounds kiddish but you get the idea right? Or
> like 'wt' and 'wt_dup'?

As with any language, C has its idioms, as does Git itself. Sticking
to idioms makes it easier for others to understand the code
at-a-glance. Short variable names, such as "i" and "j" for indexes,
"n" for counters, "s" and "t" for strings, are very common among
experienced programmers. Likewise, "a" and "b" are well-understood as
the arguments of a "comparison" function. There are many such examples
in the Git source code itself. Here are just a few:

    cmp_uint32(const void *a_, const void *b_)
    maildir_filename_cmp(const char *a, const char *b)
    tipcmp(const void *a_, const void *b_)
    cmp_by_tag_and_age(const void *a_, const void *b_)
    cmp_remaining_objects(const void *a, const void *b)
    version_cmp(const char *a, const char *b)
    diffnamecmp(const void *a_, const void *b_)
    spanhash_cmp(const void *a_, const void *b_)
    void_hashcmp(const void *a, const void *b)
    pathspec_item_cmp(const void *a_, const void *b_)

> > +test_expect_success 'prune duplicate (linked/linked)' '
> > +   test_when_finished rm -fr .git/worktrees w1 w2 &&
>
> Nit: maybe make it 'rm -rf' as that's the popular way of doing it?

It's true that "-rf" has wider usage in Git tests than "-fr", though
the latter is heavily used, as well. Ordinarily, matching the style
already present in a particular script would be a good way to choose
between the two, however, the worktree-related test scripts which this
series touches already have a mix of the two. This is the first use of
combined "-r" and "-f" in this particular script, so I could go with
the more common "-rf", however, it's not worth re-rolling just for
that.

Thanks for the review.
