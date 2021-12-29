Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33077C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 12:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhL2MNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 07:13:48 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:43761 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhL2MNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 07:13:47 -0500
Received: by mail-il1-f181.google.com with SMTP id d3so9008902ilr.10
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 04:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvbqJNcKoL/YY02VnO3L1s9RB6gu+0yLzxmcXsWGDt4=;
        b=lBTx28k5Ep+S65EFCxLrjcBFDONgzr6vBx+/WUWHdV0Kkwr7qyTDnM29VYvF400eYk
         aMFJ9MmtA0gykR1YWqHMOhS0DA48feoHSGMf7wVSFVz5HtUFnxqKpZGSWf+r2C1uYfvo
         qrVIfTFclrIBvXqXyiKk2HLI6MNtcuRrAF/KcRcqBcH7597xi7h5TgZER+GFeQ0mZezA
         tARDsTOD/y0WMEnytaaQleyudFtNnE51qrBiQgtLZi8EUNPR/5VxXdZwR4B0eM/aWN7/
         YuV8RrzkTvpK8LBaljxMPPpIBIFXC1ct4u+dHpEvJHAnp6V98+6PNFSH/nIxlQl1jaoP
         nSaQ==
X-Gm-Message-State: AOAM530XiWMVPwN4O9Gv8p0lUptqXSKovlNWX0TUvWr5ns0ZvqqE1sNG
        8h4Ui3du5HCVSJe9eWbGvydXzMEuABSVMeBiUDVTJGEyYh4=
X-Google-Smtp-Source: ABdhPJwQKbA+tmhkqJ8QFOfEEIEa24JXBf1MWpyAjALbJzHhrHI8RePAZPyF5M3rZrkonH80Sg9H6CgR8UCDprPWNZk=
X-Received: by 2002:a05:6e02:148a:: with SMTP id n10mr7940317ilk.142.1640780027185;
 Wed, 29 Dec 2021 04:13:47 -0800 (PST)
MIME-Version: 1.0
References: <3e1548ab-5e20-9555-bd10-d6cbf2ffbce4@gmail.com>
 <CA+JQ7M-By65FVPnMFnwE8zx3T4O7DV3_5Kf2P6eZhP4Zcemorg@mail.gmail.com>
 <a8f3246f-2b50-e713-16c3-1d23b80a42a1@gmail.com> <CA+JQ7M9Ht5vSfDDEuYyK7pBPBvgjzi7L6jEYX8dkP4PMFK-M2Q@mail.gmail.com>
In-Reply-To: <CA+JQ7M9Ht5vSfDDEuYyK7pBPBvgjzi7L6jEYX8dkP4PMFK-M2Q@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 29 Dec 2021 13:13:10 +0100
Message-ID: <CA+JQ7M-gornjkB78Dgx-bHW7Ps=C2936vDNUakQ-VG8KAyZ=YA@mail.gmail.com>
Subject: Re: request: allow passing -X <strategy-option> to git checkout
 <path> to auto-solve merge conflicts
To:     Andrey Butirsky <butirsky@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a tangent, you can set up your own merge tools.

So in git config you can add something like:

[mergetool "both"]
cmd = "sed -i -e '/^<<<<<<<$/d' -e '/^=======$/d' -e '/^>>>>>>>$/d' -- $MERGED"

and call it with git mergetool --tool=both

On Tue, Dec 28, 2021 at 10:50 PM Erik Cervin Edin <erik@cervined.in> wrote:
>
> > On Tue, Dec 28, 2021 at 9:44 PM Andrey Butirsky <butirsky@gmail.com> wrote:
> > Thanks Erik, please post your further replies to the mailing list so
> > others could see it also.
>
> Mea culpa
>
> > On a topic,
> > I'm not familiar with Git code-base so don't know if it even possible in
> > it's current architecture..
>
> It looks like
> builtin/checkout.c checkout_merged
> is responsible and calls
> ll-merge.c ll_merge
>
> I think other commands that allow merging strategies may use other
> "merge drivers".
>
> From commit a944af1d86e6171d68ed2a3aa67b1d68f00e1fe8
> > merge: teach -Xours/-Xtheirs to binary ll-merge driver
> >
> > The (discouraged) -Xours/-Xtheirs modes of merge are supposed to
> > give a quick and dirty way to come up with a random mixture of
> > cleanly merged parts and punted conflict resolution to take contents
> > from one side in conflicting parts.  These options however were only
> > passed down to the low level merge driver for text.
>
> It looks possible.
> But perhaps the sentiment is that it's not adviceable?
