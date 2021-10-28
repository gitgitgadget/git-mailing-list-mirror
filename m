Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4E2C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 01:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4792610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 01:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhJ1BYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 21:24:04 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44799 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJ1BYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 21:24:03 -0400
Received: by mail-ed1-f42.google.com with SMTP id eg18so952450edb.11
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 18:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAqzM0vak0J7Qm4LDYp7oPFW7EYq756S5Fpk4eBDP0w=;
        b=yRpjCD9Xp0eRkvegsXtMTByDMg6LUkpzecsPiuL1Hq4rElns7u9BM8I82nwK52i9Le
         9ZuROF1bsVizha2RSBpAsAuaEwqZ64vfvkePlDH0nnSyCL3KISqrZfQH/G0+Y+UgOdG8
         5OBr1mGmRhp9vXA+2mxQmw8vnkGUd17GE0l0ubud3C+v2vqonZgCyd/ejat6NWq0gNRe
         Rw7ZKFucCNYSCfe119ehdygQ5oR1vsjswjf/YZb62b54kR0JE+vZ+9bRSx7u1+AU3upr
         fWTZCvdSJpBfvG1PspS6S0AomBCwzDh1auKh9aZus2gvMM8eDmvDh6oYkleDk/77tjke
         lAlA==
X-Gm-Message-State: AOAM5332KMffAKu6VEgfBGSiE6K3D+W+owftb+Ya3C8RIkS/ZRMjrkcL
        xvhU6KGEZuBw3crYPMhY7XfaQ+dDTb6xpVJWUiNUIPqXEP8=
X-Google-Smtp-Source: ABdhPJyeBQn3ZjgBk8FjbhBzSbR2taCdB6grLUVey4roQMZ9fl9745VIxAWa4rnldOefMmZrnDtKo6AXaAmkijXMEHQ=
X-Received: by 2002:a17:906:128d:: with SMTP id k13mr1354921ejb.517.1635384096729;
 Wed, 27 Oct 2021 18:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211028002102.19384-1-e@80x24.org>
In-Reply-To: <20211028002102.19384-1-e@80x24.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Oct 2021 21:21:25 -0400
Message-ID: <CAPig+cSTL-Rr+-aHqm3rsM=PLrz+BaDj7+nXGYKnKcEHgEiGOQ@mail.gmail.com>
Subject: Re: [PATCH] allow disabling fsync everywhere
To:     Eric Wong <e@80x24.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 8:21 PM Eric Wong <e@80x24.org> wrote:
> "core.fsync" and the "GIT_FSYNC" environment variable now exist
> for disabling fsync() even on packfiles and other critical data.
> [...]
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
> diff --git a/write-or-die.c b/write-or-die.c
> @@ -57,7 +58,9 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
>  void fsync_or_die(int fd, const char *msg)
>  {
> -       while (fsync(fd) < 0) {
> +       if (use_fsync < 0)
> +               use_fsync = git_env_bool("GIT_FSYNC", 1);
> +       while (use_fsync && fsync(fd) < 0) {
>                 if (errno != EINTR)
>                         die_errno("fsync error on '%s'", msg);
>         }

This is minor, but placing `use_fsync` in the `while` condition makes
the logic harder to digest. The intent would be clearer at-a-glance if
structured like this:

    if (use_fsync < 0)
        use_fsync = git_env_bool("GIT_FSYNC", 1);
    if (!use_fsync)
        return;
    while (fsync(fd) < 0) {
        if (errno != EINTR)
            die_errno("fsync error on '%s'", msg);
    }
