Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11959C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 05:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBAF206B5
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 05:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgHKFoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:44:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34916 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgHKFoO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 01:44:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id f1so10263839wro.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 22:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqEtMFxL8j5KEntLomZIDBFvw4WExexC5xyxnKhMdMU=;
        b=hWmYk+/Yk11Fp/y6zHXt+f1KRRlnLAx46Usg52gOTPqK/mETVzodwmxpqNrj2ogyp+
         1W936XXMiO9+qKPF1knh8LudemIJyQL2IGvCd+HjDPVNHNB7UQB3C+tMsux/rP6yXeWa
         Nn3KAvnhNR/wQz13gwwCnHyCgMlGRmMaCXn5Wzy6qFYYB/ZIR2NSBNOCfFxrPhlA4loX
         A4jehEwnufaRdpSvFaL08YZM1/cwkdY+VqrYRGxqka8JFnABB3pZmOQH4zkLol4Hp4hC
         IUooSN790rpzCiqYHS72BmOo6WprxVWXDzG8zqmGIUqk23kUA5zUGglFP7cHqRr/vqxY
         qOaw==
X-Gm-Message-State: AOAM532mrN6cPy7R0MC1a/+hIgwhW/JBvtRuFciatSjyZUnrMAZ+krRT
        N2dXm+rsvEnrlmZ0yvFh/1RscHO8WHKwQxa/pNLMjauL
X-Google-Smtp-Source: ABdhPJwni1q1k2VnMS1+NvdJMB+0wOUq7SAz/nJxczXQwbjyA4NyRHlJC0+C7n3vdxOXfvRCMRj09GNkTZIeHBS1O0U=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr29599697wrs.226.1597124651619;
 Mon, 10 Aug 2020 22:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200809225316.19503-1-sunshine@sunshineco.com> <20200810095648.GA37030@coredump.intra.peff.net>
In-Reply-To: <20200810095648.GA37030@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 11 Aug 2020 01:44:00 -0400
Message-ID: <CAPig+cSMzEuMYNnHhMGwqGFgjWfX0+j1KoOSK8V7Wav97p+UVw@mail.gmail.com>
Subject: Re: [PATCH] init: disallow --separate-git-dir with bare repository
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 5:56 AM Jeff King <peff@peff.net> wrote:
> On Sun, Aug 09, 2020 at 06:53:16PM -0400, Eric Sunshine wrote:
> > However, an outright bare repository (such as one created by "git init
> > --bare"), has no worktree, so using --separate-git-dir to separate it
> > from its non-existent worktree is nonsensical. Therefore, make it an
> > error to use --separate-git-dir on a bare repository.
>
> I agree that it seems like nonsense. I'm a little curious what it
> happens to do today, just because I'd wonder if it could possibly be of
> any use to somebody.

The current behavior does some goofy stuff which I can't imagine being
useful to anyone. For instance:

    % git init --bare --separate-git-dir bar.git foo.git
    % ls -1
    bar.git
    foo.git
    % cat foo.git
    gitdir: /.../bar.git
    %

So, I just initialized a bare repository "foo.git" which isn't
actually a directory at all but instead is just a 'gitlink' file. What
can I do with file "foo.git"? Not a whole lot. "bar.git" is the actual
repository.

The case of re-initializing a bare repository with --separate-git-dir
is even weirder:

    % rm -rf foo.git bar.git
    % git init --bare foo.git
    % # ... add some commits ...
    % git -C foo.git rev-parse master
    86e28bed5ac8f5ea774690b4fc0eddb434800e9e
    % git -C foo.git init --separate-git-dir ../bar.git
    % ls -FA bar.git
    HEAD         config       hooks/       objects/
    branches/    description  info/        refs/
    % ls -FA foo.git
    .git         branches/    description  info/        refs/
    HEAD         config       hooks/       objects/
    % cat foo.git/.git
    gitdir: /.../bar.git
    % git -C bar.git rev-parse master --
    fatal: bad revision 'master'
    % git -C foo.git rev-parse master --
    fatal: bad revision 'master'
    % rm foo.git/.git
    % git -C foo.git rev-parse master
    86e28bed5ac8f5ea774690b4fc0eddb434800e9e
    %

So, the repository doesn't actually move at all; it stays at
"foo.git". And "bar.git", even though it looks like a repository, is
actually empty; all the objects are still in "foo.git". Plus "foo.git"
is _broken_ by the ".git" file which --separate-git-dir placed there.

So, it's meaningless and perhaps destructive behavior using
--separate-git-dir with a bare repository,

> > Implementation note: "git init" considers a repository bare if told so
> > explicitly via --bare or if it guesses it to be so based upon
> > heuristics. In the explicit --bare case, a conflict with
> > --separate-git-dir is easy to detect early. In the guessed case,
> > however, the conflict can only be detected once "bareness" is guessed,
> > which happens after "git init" has begun creating the repository.
> > Technically, we can get by with a single late check which would cover
> > both cases, however, erroring out early, when possible, without leaving
> > detritus provides a better user experience.
>
> I think we'd clean up that detritus with our atexit handler, but I like
> the extra check here. It lets us give a slightly more specific message
> when we can catch it early ("these two options are incompatible").

With only the latter (after-the-fact) check:

    % git init --bare --separate-git-dir bar.git foo.git
    fatal: --separate-git-dir incompatible with bare repository
    % ls -1
    foo.git
    % ls -A foo.git/
    %

It leaves the directory "foo.git" around, though the directory is
empty. With the earlier check in place, it avoids leaving that empty
directory.

> The patch itself looks good, assuming my "I'd wonder..." line of inquiry
> above produces nothing of value. :)

I can't find any value in the current behavior, so I'm pretty well
convinced that this patch is desirable (even if I don't quite like
repeating the check).

I didn't add any of the above explanation-by-examples to the commit
message because it seemed too much detail.
