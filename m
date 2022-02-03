Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E910FC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353622AbiBCS6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbiBCS62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:58:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F14C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:58:28 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n10so8003788edv.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=pWu2lXNNtxIu+MP/UP0hDyO01TwjiCFtSqUdxz0lVeE=;
        b=hU7C+9KUe2MMZMRRV/oVYIv2KN+t+GBnHNm50llRRcTbfEFcJsRMKd4yoFj1fokVg7
         S1nod77P0Ibb06KTV2hCkbK9ou2+9zGoN3p3J2ZQPtWPoH2noA7w8eMh68wTKjJ1grc+
         B55/f1oFTBLu2Do4Nvl7snBQCejRBSufSj2N2bl7THl2cLyaTZpdgh02ikMekS+W4BDn
         sevl+jwf1kThDuOvvIDwKxJpnY9D+gBBQyNJnoQapQrh+D409dGU0O4aJeJyoigz2rcc
         fEh3R2IWh8NZIxtGlU2iLfOnf5r+CqeGh5kbvxBiXOac7PJBJmf+kpi8vS5OSmP+y7T0
         Yq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pWu2lXNNtxIu+MP/UP0hDyO01TwjiCFtSqUdxz0lVeE=;
        b=PqYcBMNAvB1yaWs45gaTkxMy8gcIUH+cwJuuZ7oUf3vGbsqt3NHW/xrMBFFDFqKHgO
         luO1eFVHsHvyo30xfHAcaGatsO+uUaMM4YB1dvMiIEud7GKMxAqELvSE9rRKttT3NcMZ
         ZXLT5fN8o0nZauivMigNqOh9BLRgbkUsflIGLpM8tuWs+WeKdBSalG7RyVtgRstrebYd
         xh/YD4fYJzatcooQ3dpqZ8wDeWYB5L6qxkRJHPYENUiE2ZcgogJ/zJRtZhFUKomtBmML
         zCioZxiX/+ASY3y4yorHMIBUGSRk/Sfj/UtMRVuwpPgYHLl/GQ/tvN0/mghwsPTvX9z8
         wBDg==
X-Gm-Message-State: AOAM531MCDt8Xjg5Ovm6xpsNpDoiRkPfwXjlS/NG5EIgXJ3l+V0XYwIK
        mVh/E4YelJ0OPsqJAHZReOy2m/YQzfK7zW6ioqV39G6x2+QwFg==
X-Google-Smtp-Source: ABdhPJy+sQ1PX00+ZA+9GhRm1bPmJXmp1stvtNhWUwJTQhVcxj3HwGyK1rHOgYfDrWHbUBE2+vgYvMHEK/fhVvbzlnQ=
X-Received: by 2002:a05:6402:27c9:: with SMTP id c9mr36852371ede.178.1643914706544;
 Thu, 03 Feb 2022 10:58:26 -0800 (PST)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 3 Feb 2022 19:58:15 +0100
Message-ID: <CAPMMpog6vKBfYEWqKDgK7YQQ96pPVMH7hYPXUHMnJsgLNgYMXA@mail.gmail.com>
Subject: branch.autoSetupMerge option for "if name matches only"?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

In trying to recommend sane simple understandable git flows for large
numbers of (often not git-proficient) users, I've found upstream
tracking branches to be a sticky area.

The main problem is that when users intentionally create a new branch
"test1" from origin/master, for example, they automatically get
upstream tracking... but after they've pushed their new branch to the
remote, they (unless they do something "wrong") typically have
tracking switched to "origin/test1" (after a weird error about not
pushing to a differently-named upstream - because they have
push.default set to "simple", the safe default - unless they're using
a GUI that sweeps this under the rug). So the behavior of "pull"
changes dramatically, from the user's perspective, after the first
time they push. Until that point, the system is behaving "weird".

On the other hand, when another user wants to work on "test1"
directly, they branch from "origin/test1", they get upstream tracking,
and everything is normal/predictable.

I *think* the simplest / most understandable behavior for most users
would be a variation on the current branch.autoSetupMerge=true
behavior, except *only set up tracking if the local branch name
matches*.

This new branch.autoSetupMerge behavior (dare we call it "simple", to
match push.default?) would mean that when branching from origin/master
to test1, you would not get an upstream. Pull would say something like
"hey, you haven't pushed yet", and everything would be understandable.

Is this a scheme that makes sense to people here?

Alternatively, another workable option for my not-so-sophisticated
users would be something like branch.autoSetupMerge=current, which
would simply always assume the same-name branch on the same remote. If
this were a new branch, initial pulls would say "but there's no such
branch on the remote!", and the first push would be even simpler,
succeeding without the current surprising "The current branch has no
upstream branch -0 run this slightly-more-complex command" message.

Are my users the only ones who get caught out by the default tracking
behavior when branching from a different upstream branch (but *expect*
tracking when creating a local instance of a remote branch)?

Thanks,
Tao
