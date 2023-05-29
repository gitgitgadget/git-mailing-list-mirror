Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1B2C7EE29
	for <git@archiver.kernel.org>; Mon, 29 May 2023 13:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjE2Niy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2Nix (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 09:38:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666448E
        for <git@vger.kernel.org>; Mon, 29 May 2023 06:38:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53f6a6d3944so1069640a12.3
        for <git@vger.kernel.org>; Mon, 29 May 2023 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google; t=1685367531; x=1687959531;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dMFxcTyw5HLtpQUkzWJ09aK38MQDd8M66ujnn4373Ok=;
        b=MVfthOzYKJ/q1+bO8Utz+YAz84PKmx3yC4pCSohWKJ+mZWZR2Wmdkb9Wy8x+A4vBnD
         2OAoxRIGIkCy7wHYm554eHYgequ3+T6OdhLmcyYlQmM5Q2Hu4OL5HC3nyzZDv3PMxK29
         zjHLT58Fo7lM7h5aYyCgDAoxkMSHDT/XUgcXD+RY/hTRCXtmks6ZiZEZ23+4m6x68NAS
         TXDj5c/cmdMsCNbkW4gHBpx30z3AG84FJyo0oLi5I57gDzqI/UFGjNZ6lRSp9zLEUV3S
         Lp4TIgqL0sQinq2GwsV4MR/hMcPkNZnsIrlN/5Lin+HBI0lxRipE6+i8qTWIEHm0qREg
         NAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367531; x=1687959531;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMFxcTyw5HLtpQUkzWJ09aK38MQDd8M66ujnn4373Ok=;
        b=A1tnJEGKjJ2X9OndTtldTfi9DeSsatp5AcTzQ8dyb9nd38DVi+9paX9UU2S2OrP+vf
         DRbzcHVklOA3V8Uw1g+ek/FHXrIEzuyTg7+sq1jjmqIzIuw558xUpeOqXmYw2CzK2SNF
         SaoM5fwZefGF1/2LJgwuCPCHlI1skbmav/0jm0OrWF3cABQiHBj7xiO2d0pHrEznRYwL
         Ryboa1/20TKAyIHtMC3kaa4SLrrmnbLFfdR7oxTUMnd9Amcs5Rz8uUR4Q/6/T9Cie2u4
         M8/8gEIdkjGmdFTVtSNbop7M7BB/8tcEV5K8QA2NI/uvBmZ+Hz+oYA6XQ3eG3i5DmDMw
         5wWw==
X-Gm-Message-State: AC+VfDxXjIwrel6oFsK5oCAomeco3Fm7RAeXPO0iZfkyYupXruZ+jXXX
        SADdFJIgpfD/dIcSrY9OGnKeeepxndJYvEo9sugeKJvJ5XFOqbNomPo=
X-Google-Smtp-Source: ACHHUZ4x2QqD/9Yxr6zIpYHCdiwDNfGsGnJF0uUYfZCSa7SdiE0jA4rWYjpmOn04mspVM1M8hzRdOuOhnFOOxbHKYjY=
X-Received: by 2002:a17:902:e750:b0:1af:9b8a:9c7b with SMTP id
 p16-20020a170902e75000b001af9b8a9c7bmr11986108plf.47.1685367531498; Mon, 29
 May 2023 06:38:51 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Jolly <paul@myitcv.io>
Date:   Mon, 29 May 2023 14:38:40 +0100
Message-ID: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
Subject: Automatically re-running commands during an interactive rebase or
 post commit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I would appreciate some advice on the best way to solve the following problem.

As part of my project, I have a code generation script that sha256
hashes a number of files to another file. This produces a
deterministic "has this part of the project changed" indicator via the
code generated file's content, that I then use in various cache
invalidation steps.

This means, however, that I need to re-run that code generation script
as part of each commit in order to ensure that the code generated hash
file is current (I have a step in CI that detects if it is not, which
re-runs the code generation script to then see if the commit is
"clean").

As part of my development setup I do a lot of interactive rebasing to
edit earlier commits in a branch (these "stacks" of changes are
reviewed via Gerrit, which understands a relation chain of changes).
Via this workflow, I often do a git rebase and edit an earlier commit
in such a way that I need to re-run the code generation script.

The challenge is that any commit in such a "stack" of commits might
need me to re-run the code generation script. But I clearly don't want
to do this manually!

What I'm looking for is a way to automatically re-run this code
generation script when I commit changes, or perform a rebase-edit step
etc.

I've tried to experiment with how I might do this using git commit
hooks. But so far, my git foo is failing me. It mainly fails because
when doing an edit of an earlier commit via an interactive rebase,
later changes might well conflict (in the generated file) with the
results of the code generator having been re-run on the edited commit.
At this point, my git rebase --continue stops until I have fixed the
conflict. But in almost all situations, the conflict comes in the
generated hash file. Which I fix by simply re-running the code
generation script (I could optionally fix it by doing a git checkout
--theirs, and then re-running the code generation script).

This all feels tantalisingly close to being a perfect workflow! But I
can't quite figure out how to make the git hooks "work" in such a way
that doesn't require any intervention from me (except in those
situations where there is a conflict during the rebase that is _not_
in the code generated file and so does require my intervention).

The code generation step is incredibly fast if there is nothing to do,
and is quite fast even when there is something to do (in any case it
can't avoid doing this work).

Please can someone help nudge me in the right direction?

Many thanks,


Paul
