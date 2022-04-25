Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C871C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 08:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiDYIMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiDYIMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 04:12:16 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB70DA9
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 01:09:11 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id i62so596674pgd.6
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 01:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFtpuFTIqyKX6jQBzXLcWgYzvyN9+1w2Hvw33gaRbv4=;
        b=PomjAOAU8naSmTsC4FHG7BccK8anXQwbJKvVo2h0+RvsBH4gEtAootsE/Is9cgHL7p
         5qZMDXdIVB5oGSJF53vu9I2DcaQDcs7N2plvo7EVGq8uTxwAGHG9ZK9yR/M6HyYlgU0N
         6QMHzxfx2GHUKoOnA6h2D6aoejTeRZSYTNGwKiyK2l/vWKu0KaRtsxAwhK84MOvV+jWF
         ShOxdDHAnB84H287MxVCbA1l06u/bCDpjrWN/6SvprfcQLjWp1lC82+KcbV5Bw6TdoHD
         23DIiBLF+gXnwKTt9Eaing3GxIpgBE0tOzp02MqELDnmGlCkRcBGfd/lyPj4y40f23P0
         xD5g==
X-Gm-Message-State: AOAM533wuyJ16cKpg+M9Wtle4vSYG3/yH6ZHQURC0/nu7SvHM4YRoESf
        PMCZnbAm93NSQou6FDjENejbu7jphUN5pAUAnxs=
X-Google-Smtp-Source: ABdhPJz3Q3Jm5imsoe48Lq5lqlmOGWDUcCXh8hrHHarE2pDUB1NncA0gQKa18U9wKvz43YNZdIAdzzgwjQxf1Oswz48=
X-Received: by 2002:a63:7247:0:b0:39d:8460:7431 with SMTP id
 c7-20020a637247000000b0039d84607431mr13976337pgn.227.1650874151277; Mon, 25
 Apr 2022 01:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220424064114.nwzldz5s2bnkrlu5@kong-HP>
In-Reply-To: <20220424064114.nwzldz5s2bnkrlu5@kong-HP>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Apr 2022 04:09:00 -0400
Message-ID: <CAPig+cQsGZ5Uw13vr5r_SZ9APZwovtxSW5N4QGpieHRx1_6zRg@mail.gmail.com>
Subject: Re: help for git format-patch lost diffstat
To:     FanJun Kong <bh1scw@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2022 at 9:00 AM FanJun Kong <bh1scw@gmail.com> wrote:
> First, I created two commits to a demo project.
>
> when I use command:
> git format-patch --cover-letter -1
> [...]
> FanJun Kong (1):
>   First commit.
>    1.c | 4 ++++
>    1 file changed, 4 insertions(+)
>
> ok, you can see the cover letter has diffstat, just above "--".
>
> git format-patch --cover-letter -2
> [...]
> FanJun Kong (2):
>   First commit.
>   Second commit.
>
> Comparing with last command, I just want to get 2 patches,
> but this time the diffstat is missing.
>
> I am not sure if this is a bug or I miss some options.

This is expected behavior according to this code in
make_cover_letter() in builtin/log.c:

    /* We can only do diffstat with a unique reference point */
    if (origin)
        show_diffstat(rev, origin, head);

The problem is that when you format both patches of a two-commit
repository, `origin` is NULL because there is no commit preceding the
initial commit; the initial commit is the root of the history. Thus,
there is nothing prior to the first patch against which to create a
diffstat.

I have not investigated, but it may be possible to teach
show_diffstat() how to generate a diffstat against the "emptiness"
preceding the initial commit, but nobody has done so yet. Perhaps this
would be a good project for someone interested in contributing to the
project (or perhaps not -- as mentioned, I haven't investigated how
hard this would be).
