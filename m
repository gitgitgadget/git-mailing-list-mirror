Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBB3C433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 17:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358630AbhK1RGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 12:06:05 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:41528 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbhK1REE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 12:04:04 -0500
Received: by mail-pj1-f46.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso11910801pjb.0
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 09:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWKuXfBVfSIJYRelzPs5ZwSkBh/5pNSiVlFfsmhUzds=;
        b=R8hl3bIf9J5cHm4PxDCvmMEzYzbIrOKX7nVguSB8R4CfJuPzLYedl/nxVmfDuFdhOl
         gY51MBY2sqHZCCvl4wDkyg3PtuOxLXLYV3fiSnOFNXUEw3xEiUjgZ8AfCNSsTI3o/0n1
         Bu5/UFwax8LpB05GaPFyUOwWlzMjINyX31vlJ/jnyjQNA18cOsIBonvc6W4YF4AGw2FN
         k+XW8LUfqwx//vwQpqnsbVI0fR3OU2gDDlXsv6kVdqsWniWOVBViZ/GLB9izVxR3ToFm
         LMLhmNmFl8cWcSLMGIV/F4kQR5tUKTb3grmwXDAGQuJD0Z4EtCfvK2R2UirrLLe85mHC
         NMTw==
X-Gm-Message-State: AOAM530iGVmrcdJ/qjLqJnoia8G3xyp2nYsKJOWtA4qj3+EuyUNg7N2T
        wp3H4SudUBcHAPdYbvtOdRJa45swxGhETOEvyvI=
X-Google-Smtp-Source: ABdhPJwcDxSIM0r81cObhOf0FEV5V+Yrw5MTuhXOLmTtUu5Tld51o5O2M1KiSYdR/6tRLx1Db4xgJOGxt83YbxXKMDQ=
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr32608726pjb.236.1638118847891;
 Sun, 28 Nov 2021 09:00:47 -0800 (PST)
MIME-Version: 1.0
References: <CA+34VNLj6VB1kCkA=MfM7TZR+6HgqNi5-UaziAoCXacSVkch4A@mail.gmail.com>
 <CAPig+cQ224Tz5iQ5Yt4fMadehLmrJWGzH7kwUSr+UT4hcQf14w@mail.gmail.com> <CA+34VNJbOHYhYgN+p7EsGiRAzf+aAQGeMxCzG1dizFjDRVQVbg@mail.gmail.com>
In-Reply-To: <CA+34VNJbOHYhYgN+p7EsGiRAzf+aAQGeMxCzG1dizFjDRVQVbg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Nov 2021 12:00:37 -0500
Message-ID: <CAPig+cTGq-10ZTBts2LXRVdPMf2vNMX8HTuhg_+ZHSiLX-brOQ@mail.gmail.com>
Subject: Re: misleading message printed when worktree add fails
To:     Baruch Burstein <bmburstein@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[please comment inline on this list rather than top-posting]

On Sun, Nov 28, 2021 at 11:47 AM Baruch Burstein <bmburstein@gmail.com> wrote:
> > When I perform these actions, I see a "fatal error" message which
> > clearly indicates failure, not success:
> >
> >     % git worktree add ../foo bar
> >     Preparing worktree (checking out 'bar')
> >     fatal: 'bar' is already checked out at '.../wherever'
>
> I see them in the other order:
>
>     fatal: 'master' is already checked out at 'C:/Users/bmbur/temp'
>     Preparing worktree (checking out 'master')
>
> which I understood as "there was an error, but we managed to recover
> somehow and set up the worktree anyway"

Okay, that's happening because the "Preparing" message is sent to
stdout, whereas the "fatal" error is sent to stderr, and the streams
are being flushed on Windows in a different order than what we
typically see on Unix platforms even though the "Preparing" message is
actually output first by the code.

A general fix (not specific to git-worktree) might be to have die()
(or maybe vreportf()?) flush stdout before reporting the error message
on stderr. That should make output order more predictable, such that
general status messages appear before error messages.
