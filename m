Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D8EC433E2
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 07:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC7D207DA
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 07:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgH3Hgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:36:55 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40729 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgH3Hgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 03:36:51 -0400
Received: by mail-ej1-f66.google.com with SMTP id o18so4436015eje.7
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 00:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADHRgLulCwtA8ybyfWI7F9hOTlPrnqVoEze6KOiVnGA=;
        b=sBHtdlo/go3xfT8m+BiE9k3ynAbUJ2KpXJvRFb9KVrelBvsAjVFUXJD2QbwKsRZccp
         LFweOtefgmmNt+G2ydXKmMVJatNsFqyjeViPxq9yHGAXwdHDLSzBxgj/++7AyBtW7N9e
         MNemUHPGNh6K1SY0JzSu9XSdtmELMMfsp5Sz4Xs1s3t+o5tlg3xmxWkQ6jG/f6T4Cz3z
         vhXJlSw3rq8SdNvNrhgJtLLWcu0gvcAYOEfpyY41eLfGsgHQGCQ07bUDN31vbZnbyk7o
         FkMqkI7ZL9sJYZFMPq4E4QNNoGTn4oDc/L067aj5T4yfDPQEtp61HWResL/NR7rT/59m
         qiOg==
X-Gm-Message-State: AOAM531qvd6b/kZPH9iiH8VMRF43Fe5XJ5L+fURoXt7uJtDJZbM1Ea1F
        uxU9Qg/bP/J2kDRsKtRxjhkap4Fj8Id677pUvKs=
X-Google-Smtp-Source: ABdhPJyB3uOWv0hg5z3GznNUH1IljkBpY7XojVB/Heih5dJEDk6IYYYUsespK+DBxMoeHpncwoAimqVlGiEEXkBrYX0=
X-Received: by 2002:a17:906:3609:: with SMTP id q9mr6594407ejb.138.1598773009314;
 Sun, 30 Aug 2020 00:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200827082129.56149-1-sunshine@sunshineco.com>
 <20200827082129.56149-4-sunshine@sunshineco.com> <xmqqh7soqady.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7soqady.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Aug 2020 03:36:38 -0400
Message-ID: <CAPig+cT-w6LV490MGNyG_ihWkSzdgfnEBrjQCsafjndTRmMgFA@mail.gmail.com>
Subject: Re: [PATCH 3/5] worktree: teach "repair" to fix outgoing links to worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?SGVucsOpIEJvdGhh?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 1:14 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Therefore, teach "git worktree repair" how to repair broken or outdated
> > .git/worktrees/<id>/gitdir files automatically. (For this to work, the
> > command must either be invoked from within the worktree whose gitdir
> > file requires repair, or from within the main or any linked worktree by
> > providing the path of the broken worktree as an argument to "git
> > worktree repair".)
>
> Would git "work" in a corrupt worktree whose gitfile is broken, in
> the sense that it notices that the cwd is the top of the working
> tree of a secondary worktree?

No. For this repair to work, the gitfile in the linked worktree must
be intact; it must be pointing back at the .git/worktrees/<id>
directory so that "git worktree repair" can repair the corresponding
.git/worktrees/<id>/gitdir file.

Making it "work" for the case when both the worktree's gitfile is
broken and .git/worktrees/<id>/gitdir is broken would require an
enhancement like what you mentioned in your review of patch [2/5] in
which the user would manually specify the location of the main
worktree (or repository). That is something which can be added, but I
wanted to keep this initial implementation simple.

> Hmph, if the secondary is _moved_, how would "worktree repair $path"
> would know which <id> the $path corresponds to? Would we just cull
> all the <id> that do not point at working secondary worktrees and
> add the $path as if it were a new one by allocating a new <id>, or
> reusing a randomly chosen <id> that points at a non-existing
> location?

Since this can only work if the linked worktree's gitfile is intact,
and since the content of the gitfile is the path .git/worktrees/<id>,
"git worktree repair" knows the exact <id>, thus the precise
.git/worktrees/<id>/gitdir file to repair. It is deterministic; there
is no guessing about <id>, and there is no creating a new <id>
magically (though I did consider additional repair cases but opted
against them for the initial implementation).
