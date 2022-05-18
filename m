Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAAFC433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 18:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbiERSyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 14:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbiERSyP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 14:54:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C406A15EA52
        for <git@vger.kernel.org>; Wed, 18 May 2022 11:54:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i19so5505602eja.11
        for <git@vger.kernel.org>; Wed, 18 May 2022 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blazepod-co.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aRYpd5vwe3H2b+164ENKsc0KFtKv0lTBVwF+0HizOkM=;
        b=osxqkfzQcQWYcObQg7K2r91f/HiTn8hVsZQClyuwc7Nk/Pe3q1SEbKe4BADLu0VGW1
         /9nEEet8V/ltIkF02Vnbz7ENHsxai9vc7zZPaQS1LkxoAcmMjSHcoPzGiNMsNGhAj04A
         S2RD1+qD2kmaodK7EYr0MypMyCsP4lUwZivsLMzRe66j7RRLMWSqmKXt4i6c5yOwFCww
         GsVpRWPPbL2dcEnH1HhefNTvhTeQnEZxQI+ccVCX6pSqoMtAGGaHFKo1X4qxPSM4IYop
         aItqhtKpFCGpJQYx99+UPJY7OK6hcy07lZL76XB/LKAMqxymAerZlZq3zV7qHbqt2r5n
         s0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aRYpd5vwe3H2b+164ENKsc0KFtKv0lTBVwF+0HizOkM=;
        b=sOiX1oTmwvmTljD++NjMh9Hfph+8UFKFWi7yeVc7HmjbQtYuPQJG4GMmLoQoYSjS2Q
         v2he0CManxdo9FQGL10TMPYViP7w/YXpXoRcO6uNo044nN8gKTchh1Ng6FFVe9osWdyd
         x7iaXpVQP/haDKaSHoW98a1MqdCvDvp8rKqAdV1kGTpplplpEeVNmp408n+tPMlSvOxy
         U0BIB4ZUcVZjWDl9pibNwcXOMyqezc4y6HuZM9SVcd0JxQ59WW1qbDczAzjmWfvA892t
         SLM+nzF+oPbVIOoo6GLIullHZ6VTEUF9JTAnuB1PU0sjrZLWpc4P9AWi/nHNSWpKyT9o
         2myA==
X-Gm-Message-State: AOAM530HXn3/lpNxoJz4SCtdudXkQ/TJnpynNK/qPxa1X0TjOovJUxLn
        tUlgDZuw4X6GeFgpoVETUlbsubNWJETPuS4EoYNhmA==
X-Google-Smtp-Source: ABdhPJwz21Y7UTo6VOv8WiITYRhkm8FgNXcnf9hAJQ6INWnaGYjiUlNbPRx8L2InJt0vUJc3NbANHdZTYBa81+OKD7o=
X-Received: by 2002:a17:907:72d0:b0:6f5:108c:a34 with SMTP id
 du16-20020a17090772d000b006f5108c0a34mr928052ejc.218.1652900052093; Wed, 18
 May 2022 11:54:12 -0700 (PDT)
MIME-Version: 1.0
From:   Nadav Goldstein <nadav.goldstein@blazepod.co>
Date:   Wed, 18 May 2022 21:53:36 +0300
Message-ID: <CAApwGmCsQNK42=5x1OxdovgVxdzj2Vs5H1FaUJhAGCXvmA5pzw@mail.gmail.com>
Subject: Re: [PATCH] stash: added safety flag for stash clear subcommand
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        nadav.goldstein96@gmail.com, nadav.goldstein@blazepod.co
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you all for your detailed replies!

I thought deeply on the issues that you presented, and I wonder
whether modeling after git clean --dry-run accomplish the goal I aimed
to solve.
If we make "git stash clear" to by default not clear the stash and
just present the stashes to be dropped (and require -f to force
clearing the stash), wouldn't we essentially make a duplicate of "git
stash list"?

My goal is to not be afraid to have git stash clear in your terminal
history, while indeed performing the clearing of the whole stack when
fired.

I thought presenting a confirmation dialog before clearing would
suffice as a solution, but I like the idea of listing all of the
stashes to be dropped and requesting confirmation (and in the future
allow selection of specific stashes to be dropped as you suggested).

Regarding making it opt out instead of opt in, I am afraid there are
tools that use git stash clean automatically, and making the
confirmation opt-out (by default confirm) we can potentially break
them, don't you think it would be more gentle to the git community to
make it opt in? Of course one major downside is that users need to
"find" it so the adaptation will be much slower, but I feel it's for
the best.

What do you think? I do agree that --interactive is not a good name
and a bit misleading, can you help me think of a better name that will
be more of a suit? maybe -c|--confirm, and using
stashClear.requireConfirm? Or -p|--prompt?
