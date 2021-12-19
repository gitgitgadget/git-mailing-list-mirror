Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382B8C433FE
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 23:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhLSXaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 18:30:17 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:41912 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhLSXaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 18:30:16 -0500
Received: by mail-pf1-f172.google.com with SMTP id m1so6086734pfk.8
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 15:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGdCqICX2NiUTQMuOySE07TCVDHuDwn9QpSoeMYKDNg=;
        b=1fok5f+mbK6syh4N1+YlV20QTpnixVYg1BMegoQrEES5gVDQBJGZLznkwqDcRfoxP6
         b4kzzwRyvtXOOZlVG6DarN2JH44bImtwUo8SQR0E/2Z8iyW7j3VNOPAToh0rvvOvWfy9
         c2cPWZwuOx6SFdDjtU2TMkpLoaK39F44k2Z11IPFPKZTNFObWPy0fDN4w5BAN+NU1H87
         B+Fof/H99UkRKpPwRhni8nGpDtbkmfsv5BnUGuRWn/hTcVfa6ptcKkDsvbq8BadzuuIj
         IfUNBJEXmGxQ6W7gioQzJRKaGtkrKfCyFu+XDwaLMM5NqOsnoCt/doGs7E8ogVS8waIh
         IOWg==
X-Gm-Message-State: AOAM532tQlkPDJN47G4EzWi98y12s3kYRGyk+UwO08CrF3fOx8xhyENP
        aNdFAUiL3xq+CkPbbj53WMtUf0FloGoiDMJfERz5smVgpYM=
X-Google-Smtp-Source: ABdhPJye3lQfgndlAaH+2fnS13+xmU7rijWimGbieJ3zp5Bc3GSFQvvkgogvVERx1o4JUB0eNTOxC6fN6ztG8toNQ2o=
X-Received: by 2002:a62:ed1a:0:b0:4ba:da1c:804c with SMTP id
 u26-20020a62ed1a000000b004bada1c804cmr2576020pfh.4.1639956616133; Sun, 19 Dec
 2021 15:30:16 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
 <003f01d7f51f$f7bb0860$e7311920$@nexbridge.com> <CABceR4aP8BVr10RYS_0PFG7ExRTJ3tB541JGC4DJ7CUsMg9+Jw@mail.gmail.com>
 <004001d7f52a$f0367010$d0a35030$@nexbridge.com>
In-Reply-To: <004001d7f52a$f0367010$d0a35030$@nexbridge.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Dec 2021 18:30:05 -0500
Message-ID: <CAPig+cTwmBViAGELF69mkYNoz+S-YW5-dcYuNfGeF-wob-=v9Q@mail.gmail.com>
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Sean Allred <allred.sean@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 19, 2021 at 5:51 PM <rsbecker@nexbridge.com> wrote:
> On December 19, 2021 5:23 PM, Sean Allred wrote:
> > > what about the comparison code where is_bare_repository_cfg is
> > > compared with 1 (it is a boolean and sometimes set to -1). This would
> > > not generally pass a code review.
> >
> > I'm sorry, I'm afraid I don't completely follow.  Wouldn't the most
> > straightforward change be to simply follow the documented
> > recommendation when we create the worktree config in `git sparse-
> > checkout init`?  Specifically,
> >
> >     +    if (is_bare_repository())
> >     +      git_config_set_in_file_gently(config_path, "core.bare", "false");
> >     +
> >
> > Are we saying the comparison within is_bare_repository() may not be
> > appropriate in this case?
>
> I'm suggesting that:
>
>         worktree->is_bare = (is_bare_repository_cfg == 1) ||
>                 is_bare_repository();
>
> the == 1 comparison should not be done for boolean-style variables. It is an int, but initialized to -1. Unless -1 and 1 mean different things, but that is not really documented.

`is_bare_repository_cfg` is not exactly a boolean; it's a tristate,
with -1 meaning "not yet determined". I didn't, at the time, closely
follow the discussion[1] of the particular bit of code you're
questioning, but the `== 1` was mentioned at least a couple times,
once in review by Junio[2], and then in the extra patch commentary by
"jtan" when he submitted v2[3]. Anyhow, if I'm following the original
discussion correctly, then the usage, `== 1` (or the equivalent `> 0`)
is probably correct, and that treating it as a simple boolean (where
-1 is true, too) would be undesirable. (Of course, I haven't traced
through the init code at all, so I don't even know if it can ever be
-1 at this point.) Five existing consumers of this global variable use
`== 1`, and only two use `> 0`, so this usage is at least reasonably
consistent with other parts of the project.

[1]: https://lore.kernel.org/git/20190419172128.130170-1-jonathantanmy@google.com/T/
[2]: https://lore.kernel.org/git/xmqqo954gira.fsf@gitster-ct.c.googlers.com/
[3]: https://lore.kernel.org/git/20190419172128.130170-1-jonathantanmy@google.com/
