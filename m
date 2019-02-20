Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5640C1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 16:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfBTQfH (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 11:35:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41348 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfBTQfH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 11:35:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id y15so897599qki.8
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 08:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNf3/qh0Ny9/ii+vu5P4+aW+az32boZ9SLTLs4TTn3E=;
        b=PPAKUShPDepIbasseYlYtjxtQglg2kP5DFPTClIoaAjEc3+qMTniJYWrsfNNE1TRSs
         9QfCAoJXtmNp3usk9J9Emu89wlwUYZhpUta7b6hoSm9ydW+XmB81mic2p4/mNO+x8i1F
         0+LJDH0UBkI8RIFhqfdBpdXM8aybyUoNgJWCZ8asuLdjF7cmXgFFRo3shQu3OaI5zYuj
         vuL9thWNLmJq6rhqJ41DD6+aa3XXxLx7iN0OrOxTPeXpHO1dpXssJdFQsRVCXrnRQkey
         OZxTf4+TB6zYFLhlCktICCKrdk7biZhk+jPbm1kO0+32AGHx+CtrE1cg2umZQalAdDmE
         ENfg==
X-Gm-Message-State: AHQUAuY5lNcij//G3r4qhZrSLHv8EctT+er5RFC2FZeXkd59dYGtZxZm
        Z4N3Qydqzg8U7pawe5r44aeIfSPHcmuMlbZKGQE=
X-Google-Smtp-Source: AHgI3IaiWTSZQ6gVMhdvZrrTQahzYe2hFosyr8pW0b8U1vL3Dq8RU+vpWwlgFIciBrfwoTRCo8W3jjgGyB83uV+JIjI=
X-Received: by 2002:a37:c313:: with SMTP id a19mr24422694qkj.220.1550680506000;
 Wed, 20 Feb 2019 08:35:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <e134801d570d0a0c85424eb80b41893f4d8383ca.1550679076.git.msuchanek@suse.de>
In-Reply-To: <e134801d570d0a0c85424eb80b41893f4d8383ca.1550679076.git.msuchanek@suse.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 Feb 2019 11:34:54 -0500
Message-ID: <CAPig+cSdA8XRwCJQD3o6DZLwesBLRTys7OV6u0wy9Ve3Hp6XPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] worktree: fix worktree add race.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Git List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 11:17 AM Michal Suchanek <msuchanek@suse.de> wrote:
> Git runs a stat loop to find a worktree name that's available and then does
> mkdir on the found name. Turn it to mkdir loop to avoid another invocation of
> worktree add finding the same free name and creating the directory first.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -295,8 +295,12 @@ static int add_worktree(const char *path, const char *refname,
>         if (safe_create_leading_directories_const(sb_repo.buf))
>                 die_errno(_("could not create leading directories of '%s'"),
>                           sb_repo.buf);
> -       while (!stat(sb_repo.buf, &st)) {
> +       while (mkdir(sb_repo.buf, 0777)) {
>                 counter++;
> +               if ((errno != EEXIST) || !counter /* overflow */)
> +                       die_errno(_("could not create directory of '%s'"),
> +                                 sb_repo.buf);
>                 strbuf_setlen(&sb_repo, len);
>                 strbuf_addf(&sb_repo, "%d", counter);
>         }
> @@ -306,8 +310,6 @@ static int add_worktree(const char *path, const char *refname,
>         atexit(remove_junk);
>         sigchain_push_common(remove_junk_on_signal);
> -       if (mkdir(sb_repo.buf, 0777))
> -               die_errno(_("could not create directory of '%s'"), sb_repo.buf);
>         junk_git_dir = xstrdup(sb_repo.buf);
>         is_junk = 1;

Did you audit this "junk" handling to verify that stuff which ought to
be cleaned up still is cleaned up now that the mkdir() and die() have
been moved above the atexit(remove_junk) invocation?

I did just audit it, and I _think_ that it still works as expected,
but it would be good to hear that someone else has come to the same
conclusion.
