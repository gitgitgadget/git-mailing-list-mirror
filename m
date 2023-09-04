Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1D6C83F3F
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 14:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbjIDOlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjIDOlr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 10:41:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4411AC
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 07:41:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so2109152a12.2
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1693838502; x=1694443302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0x5WuSyYHAvPOTLAoT49uq8pcNO7dq4F5hhSG1a9vY=;
        b=aVf++mH9bhAvIyCXRHRwZjbKXIy5HWSlkf25Hr7dS2eZOYCEOSWtNVZwgyMYQAAO+g
         pUNtAsw7K77aDTe4E5ZyxOsSzGxH59PwFWBW5Na5PNZafzI8ChShE2U82FtdvnvK/DeJ
         JAkv8nfCn2695jd9A+sQiW5MJNwFvFQyO43vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693838502; x=1694443302;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0x5WuSyYHAvPOTLAoT49uq8pcNO7dq4F5hhSG1a9vY=;
        b=Jft9JZ5BCwBtQj9++peoT/8V2tIwGyV2zE9CyG/+lmB9VtRmJd+ei8US1yfb18yT+B
         2HPcYFG7flBCmw6pRIJQxupaHeU7Y95VnBYKZ3clihvM47NdHxwhIGxCv5KPToLDFY4M
         kysMGBJKRYbVVKK9JsPVnBiZYOiOy/asrWNZZ7R/B2PXR/l13T0p5Vz0cSZCoJ7bSk/m
         E14IctN8EqFnk9uAqVIUwQWR+B53uc+A8OE/Ih1JSsNuOW5PpD64WiScyvvhy0fPTvsR
         htb+qFKtCX3nZwYx4hNrqDE4Vsly8BbS4/AQKoTn3pX8ZpFD3ZaIh5s6rDbQCe92HRX5
         RFLQ==
X-Gm-Message-State: AOJu0Yw8xFdgOiHSxDA0aWtwuaAj3AanpQPrJGLYat8GoMUX4NZz3+gx
        5gwCxQu+Upj6lHdUvVXX7OgXEmaKHZX4DKLeAu2C/Rk8E7pTY/OaBgoZsA==
X-Google-Smtp-Source: AGHT+IGUI00KltzcUiTysLzMYs2/X8dkUI22mK+/+gOIr5zwSnBlc9uZWUdn27kjWixOlJWZlhOJiibzarj8tGG6p1g=
X-Received: by 2002:aa7:d603:0:b0:523:4922:c9c4 with SMTP id
 c3-20020aa7d603000000b005234922c9c4mr8480612edr.11.1693838501561; Mon, 04 Sep
 2023 07:41:41 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 4 Sep 2023 16:41:31 +0200
Message-ID: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
Subject: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     git <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I work with a project that often, or typically, benefits from having
multiple worktrees where users are working with different versions of
the code.

Worktrees make particular sense in this project for all the usual
reasons, plus the fact that it is a very *large* repo - multiple gigs
of repo, and very fast-moving; cloning and fetching less often is
nice.

One problem that we found users to have, early on when we introduced
worktrees, was that it was not obvious to users that there was (or why
there was) a "main" worktree, containing the actual ".git" repo, and
"subsidiary" worktrees, in the same directory location. Git by default
makes worktrees *subfolders* of the initial/main worktree/folder, but
we put them alongside each other to make other project tooling be able
to treat all worktrees consistently; in daily use there is absolutely
no difference between them, in all the "project tooling" there cannot
be a practical difference... but if you choose to delete a worktree,
and it happens to be the "special" one that contains the repo...
you've just lost stuff that you didn't expect to lose (any local
branches and stashes, basically).

Because worktree use was so useful/widespread/critical on this
project, and we already had a custom cloning process that introduced
selective refspecs etc, we introduced a special clone topology: the
initial clone is a bare repo, and that folder gets a specific clear
name (ending in .git). Then we create worktrees attached to that bare
repo.

Generally speaking, this has worked *very* well: I would recommend it
generally as a recognized/supported local-repo-setup. The most
important thing that makes this *possible* is the fact that "git
rev-parse --is-bare-repository" returns True in the bare repo folder,
where the lack of index and HEAD shouldn't bother git, and it returns
False in any one of the worktrees. It feels like things were designed
to work this way, even though I can find no explicit mention of this
topology in the docs.

However, from time to time something weird happens: Today I finally
started to understand why I was seeing a crazy GC error about bitmaps,
intermittently: It seems to be because "git gc" wants to create
bitmaps in bare repos, but can't do so properly when we're in a
partial clone... or something like that?

EG repro:
```
git clone --bare https://github.com/ksylor/ohshitgit dangit_shared.git
--filter=blob:none
git -C dangit_shared.git worktree add $PWD/dangit_wt3
cd dangit_wt3/
echo "this is some new unique blob in the repo" > new_blob.txt
git add new_blob.txt && git commit -m "new blob"
cd ../dangit_shared.git/
git gc
```

This yields, at the end of the GC run:
```
warning: Failed to write bitmap index. Packfile doesn't have full
closure (object bf86ed1b2602ac3a8d4724bcdf6707b156673aac is missing)
fatal: failed to write bitmap index
fatal: failed to run repack
```

On the other hand, running "git gc" in one of the worktrees works fine
(except you first need to delete a couple of ".tmp-*" files from the
"objects/pack" folder, if you already got the error above).

I at first thought this was a bug - but as I realized the problematic
behavior was tied to the "core.bare" setting (and its expression at
runtime through "git rev-parse --is-bare-repository"), it became more
obvious that maybe the system could/should be able to make assumptions
about the kind of repo that has this "true", and assume there are no
local-object-derived non-promisor packfiles (or whatever it is about
this example that makes things unhappy).

So, I guess I'm confused as to what "core.bare" is supposed to mean:
Is it intended to mean "there is no index nor HEAD here, and that's
good, don't worry" (in which case my setup is presumably "supported",
and the gc behavior is buggy?), or is it intended to mean "this is the
kind of repository in which there are no worktrees" (in which case I
am abusing the system and get the errors I deserve)?

CC Dscho, who made the worktree support that I rely on work about 16
years ago it seems, and Taylor Blau and Patrick Steinhardt, who I
think have made changes in the area of the code concerned with whether
or not we try to create bitmaps, and might have an opinion as to
whether the assumptions made by "gc" at the moment are unsafe, or my
use or "core.bare" in this context is wrong.

Thanks for any feedback!
Tao
