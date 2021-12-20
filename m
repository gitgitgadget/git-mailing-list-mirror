Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E88FC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 00:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhLTAHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 19:07:36 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:45856 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhLTAHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 19:07:36 -0500
Received: by mail-pf1-f173.google.com with SMTP id u20so2293834pfi.12
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 16:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PELRtjdf5cVtehk64NhgWrSsv+dxI5qwzVXi9pjX8wQ=;
        b=icGPvUQGnTpf0quvq3HMT41jHQ4sx3OHeHPyiUWxpS2PCwzCB7n5GxUcCcg6FqWARV
         Na2Y1aiDnJwMpTvwjyL3N9ThYztCulaPfI1GDDrdHlbdaCOi/mJPsCftR/3nSHS3Smlf
         iEOjWuqiYvfY+NZZCz4LAuEryrWFjO1l/X5dC4gvJb2mbxpyifxR4tEZ5sHowsA1uFwl
         u+0be8a5nL3Te+b1S+ZRzCA+P7eZfAACkfNJmQQjtN7MoDtQyjrNrWi6FE8FR20yriVN
         zpANofVPdCXckEqiPDUA8tXn0EtEVjuCjThNx/MQhoPCnzlbGlNBFKNjrKlrWw7BZsj7
         Id+w==
X-Gm-Message-State: AOAM533Vy0FKB3LvWj91OWFfD2puSVW3q9suLjyKBM23PZn9UrMvEmVZ
        G1LCe+r4QLSjXKXYy95Qcruy9541aC+im7Abs2o=
X-Google-Smtp-Source: ABdhPJyjM6anhaWDKdRZLPmr1n8WRyoSzCUfqzvl+sRXoa0A+MC819PSiwa/RbpNOd7cSVHp3x+VRqozA0RGHS5eFnI=
X-Received: by 2002:a05:6a00:230b:b0:4ae:d8b2:dc0c with SMTP id
 h11-20020a056a00230b00b004aed8b2dc0cmr13484085pfh.67.1639958855473; Sun, 19
 Dec 2021 16:07:35 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
 <003f01d7f51f$f7bb0860$e7311920$@nexbridge.com> <CABceR4aP8BVr10RYS_0PFG7ExRTJ3tB541JGC4DJ7CUsMg9+Jw@mail.gmail.com>
 <004001d7f52a$f0367010$d0a35030$@nexbridge.com> <CAPig+cTwmBViAGELF69mkYNoz+S-YW5-dcYuNfGeF-wob-=v9Q@mail.gmail.com>
 <004301d7f533$b51c0a90$1f541fb0$@nexbridge.com>
In-Reply-To: <004301d7f533$b51c0a90$1f541fb0$@nexbridge.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Dec 2021 19:07:24 -0500
Message-ID: <CAPig+cQs0sp8St3KxrTsuFWU0wXteKHM1DBES0s1pzBpQ0Sv=g@mail.gmail.com>
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Sean Allred <allred.sean@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 19, 2021 at 6:54 PM <rsbecker@nexbridge.com> wrote:
> On December 19, 2021 6:30 PM, Eric Sunshine wrote:
> > `is_bare_repository_cfg` is not exactly a boolean; it's a tristate, with -1
> > meaning "not yet determined". I didn't, at the time, closely follow the
> > discussion[1] of the particular bit of code you're questioning, but the `== 1`
> > was mentioned at least a couple times, once in review by Junio[2], and then
> > in the extra patch commentary by "jtan" when he submitted v2[3]. Anyhow,
> > if I'm following the original discussion correctly, then the usage, `== 1` (or the
> > equivalent `> 0`) is probably correct, and that treating it as a simple boolean
> > (where
> > -1 is true, too) would be undesirable. (Of course, I haven't traced through the
> > init code at all, so I don't even know if it can ever be
> > -1 at this point.) Five existing consumers of this global variable use `== 1`, and
> > only two use `> 0`, so this usage is at least reasonably consistent with other
> > parts of the project.
>
> Thanks for the clarification. It helps to understand the code. Could the variable type be changed to a new typedef like ConfigTriState instead of int to be clear about its semantics? Or perhaps an enum with -1, 0, 1 declared explicitly?

I'm not sure how much value an enum would add in this particular case
since this is a quite common idiom in this codebase. It might be
sufficient merely to add a comment to its declaration in cache.h
explaining its possible values.

What could be even more helpful is some documentation about the entire
setup sequence and how all the different "is bare" and "do we have a
worktree" computations interact since the general setup logic is quite
involved, and there are likely a number of pitfalls which are not
obvious by merely glancing at the code, but which people know about
who have dealt extensively with this code (such as Duy and probably
Peff).
