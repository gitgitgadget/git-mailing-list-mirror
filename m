Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45570C433E2
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A87320849
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgETOXA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 20 May 2020 10:23:00 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41894 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgETOW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:22:58 -0400
Received: by mail-wr1-f50.google.com with SMTP id h17so3326313wrc.8
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=udpAl9FpahbLrIYQqb4sFbYLXcDRR1tnjvFtKXNdiC0=;
        b=M4lKaPV1ftBcdatNDC60jc/gZmmQANV9jDlf/sSkoXkrAeS+7v/pgv+EpDyTwFJxUQ
         OQUQa+CYWncCA1o2gS+0b3OVB2oyGrvOgYagyB50sStvZaM+haPxn0nb+S8529oFoW7a
         T0CLGuS6maKFObYjYartdZE+wlhVSGATyjcr2Iw8t3nx8NILUJ97GoaC0izPmUgpGHDO
         PRtS3Oi6EIJF/VPo7R9JeieqzaD6vaTHnAnJAOeQith1lZ2yLaKiyXtot0d8zXyLbpwg
         1piJx3Wp9q4QxUMS36UNqXtAf4oOr02fpIVKYfzjrq4o6AkJCv0Lq7OOEg+QylvGeHuZ
         5fUw==
X-Gm-Message-State: AOAM533dCwI+LhLkAK8V2NMShTYX6osj45C0p7N2IbuzF2IMsrBAp6H/
        JznX7F9iwWc6VdV4zc2/Rs5SfU/KIP/ZPBb0qe8=
X-Google-Smtp-Source: ABdhPJx5GeYk8TwshxFVNPWFAQmeUm0Xp+62HUULuDeNFgM7zYewOs/v1To7RiCP2gutUe1VOX2RiYSLcsg61/8yYvk=
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr4421522wrt.415.1589984576897;
 Wed, 20 May 2020 07:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <89526b3a-297d-591d-6e12-48580d697ed5@gmail.com>
In-Reply-To: <89526b3a-297d-591d-6e12-48580d697ed5@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 May 2020 10:22:45 -0400
Message-ID: <CAPig+cTU8+N6Chimpoa2_T-TcXxw-3B9-9pjCLz7WeOh472P_A@mail.gmail.com>
Subject: Re: Bug: git worktree remove and overwritten directory
To:     =?UTF-8?Q?Jonathan_M=C3=BCller?= <jonathanmueller.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 6:36 AM Jonathan Müller
<jonathanmueller.dev@gmail.com> wrote:
> It seems to be impossible to remove a git worktree whose location has
> been replaced by the main working tree [...]
>
> cd test
> git worktree add ../test2 some-branch
> cd ../
> rm -rf test2  # Remove the worktree folder
> mv test test2 # Main git repository now located where the worktree used
> to be
>
> Afterwards, `git worktree list` reports:
>
> /home/foonathan/test2  e7bb748 [master]
> /home/foonathan/test2  e7bb748 [some-branch]
>
> And both `git worktree remove .` and `git worktree remove ../test2`
> report an error `fatal: '../test2' is a main working tree`. I had to
> manually remove the corresponding folder from `.git/worktree` to get rid
> of it. The issue is especially annoying, because you can't check out
> `some-branch` anymore (as it's already checked out in the worktree).

Git tries hard to prevent the same directory from being registered to
multiple worktrees, however, there is not much it can do to prevent a
person from shooting himself in the foot by making changes like this
outside of Git's control. Thus, this seems like a case of "if it
hurts, don't do it".

However, "git worktree" could possibly do a better job of helping you
recover from such a situation. In particular, I think it should be
reasonably easy to enhance "git worktree prune" to detect this
situation and automatically prune the non-main now-bogus worktree
entry.

It may be possible to special-case "git worktree remove" to detect
this situation and automatically prune the bogus entry too, but I'm
quite hesitant to suggest that sort of special case both because the
implementation would likely be ugly, and it could lead to a plethora
of additional ugly special-cases as people discover even more ways to
shoot themselves in the feet.

If you have ideas about how else the situation can be improved, please
feel free to share them, as such discussion may shed light on
possibilities which are not presently obvious.
