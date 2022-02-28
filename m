Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFEDC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 08:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiB1IgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 03:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiB1If7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 03:35:59 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28B565D3B
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 00:35:20 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id gb21so10466000pjb.5
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 00:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdrK3xHSK2YMTUE/KUJJX9FUcpFvnYjjQ7elDJgqqA0=;
        b=54jqqQ3SjOn1FtgtE4qxGFaPkwSNhHQk5wvKe/MSt2z/8wH5jp242NaD7V/DgiFixW
         Jn2WOFQz7mr4FeI3UMhBMWWpKFmDNQaVxpFzSB2FNAeTkgECSKOe6ylhLqaDEchVZCqV
         bKTM9LaJJfkY1x56gKqMFCc7Zaa5lZxaRlu9eSbVDIzOrwhU7G5+kpGYlbPQtRZ/FJYi
         JvaRoAMOSJZ5eMidOrKDdYE0iv+HEdFaCLAYG7uwMBLpwL2o80OiNje+eDkKQWT4wULT
         bMC17qc8W2ApkHI1CWcZC68H2Cb8yTz0DZPO4eO4odNfZIQGleRP8UqKyfeYGCjWvWhk
         mU2w==
X-Gm-Message-State: AOAM530VKQloruWeNYy4XVBY8BcDobJDkLsX6zTCtT4md8Bxs9Q28AkQ
        m8qE2f2T3jHV7LRmLa/J80Nu4v+OXiJx8hRI37Kht4V+ppFv5g==
X-Google-Smtp-Source: ABdhPJzyVoYeQXrNKRUrYVqCEAOcph6fo6bQY3nVqlMnHBz2KdE5Rb+/ql2fuWKWot+N6MaRQqNAeiVp+qIYUY3muaY=
X-Received: by 2002:a17:903:2289:b0:151:64c6:20fd with SMTP id
 b9-20020a170903228900b0015164c620fdmr4734197plh.64.1646037320358; Mon, 28 Feb
 2022 00:35:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com> <xmqqh78mesj6.fsf@gitster.g>
In-Reply-To: <xmqqh78mesj6.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 28 Feb 2022 03:35:09 -0500
Message-ID: <CAPig+cQF3y64bPN8h4XvAYGX-g0LZedh-cAM+JLKdW_DPAWJaw@mail.gmail.com>
Subject: Re: [PATCH] worktree: add -z option for list subcommand
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 12:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +-z::
> > +     When `--porcelain` is specified with `list` terminate each line with a
> > +     NUL rather than a newline. This makes it possible to parse the output
> > +     when a worktree path contains a newline character.
>
> This makes it sound as if it were impossible.  As the changes this
> patch makes to the documentation and the code indicate, we were
> already doing quote_c_style(), so it is not quite correct to say so.
>
> Perhaps "makes it easier" is more accurate?
>
> Unless the original wasn't using quote_c_style() correctly and
> wasn't quoting its output, that is?

That's the case. It is impossible without this patch since `git
worktree list --porcelain` does not call quote_c_style() for the
worktree path; it only calls quote_c_style() for the lock reason.
Fixing this oversight for the worktree path for non-`-z` mode has
potential backward-compatibility concerns. I had argued[1] that we
might be able to sell it as a pure bug fix, but Phillip was
concerned[2] that it might break existing tooling. (I also share that
concern, but to a lesser degree, perhaps, since worktrees with oddball
names containing newline or a leading double-quote must be exceedingly
rare.)

[1]: https://lore.kernel.org/git/CAPig+cQq_RnanDQ3jHfNz_L58WyzmsUJBhtdrLxa=H0v_io+WA@mail.gmail.com/
[2]: https://lore.kernel.org/git/936f9b7c-6d54-00bc-f136-4cb4c2836eb6@gmail.com/

> > +             if (line_terminator) {
> > +                     quote_c_style(reason, &sb, NULL, 0);
> > +                     reason = sb.buf;
> > +             }
> > +             printf("locked %s%c", reason, line_terminator);
>
> OK.  I suspect write_name_quoted() may be a better fit that does not
> require us to have our own strbuf, but this should be OK.

Nice suggestion.
