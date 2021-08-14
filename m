Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444B5C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 03:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1556860F36
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 03:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhHNDIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 23:08:23 -0400
Received: from mta-09-3.privateemail.com ([68.65.122.19]:5259 "EHLO
        MTA-09-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhHNDIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 23:08:23 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Aug 2021 23:08:22 EDT
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
        by mta-09.privateemail.com (Postfix) with ESMTP id 1BDDE18000A4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 23:07:55 -0400 (EDT)
Received: from mail-ot1-f48.google.com (unknown [10.20.151.239])
        by mta-09.privateemail.com (Postfix) with ESMTPA id 02502180009F
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 23:07:54 -0400 (EDT)
Received: by mail-ot1-f48.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso1590468ott.13
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 20:07:54 -0700 (PDT)
X-Gm-Message-State: AOAM532Sxb7Xn9nJLzwHKih6vFIXcg7rTZN3OIbEABri3zJt31fhXseY
        Z7BzkL55ssBwG9dmelCu2uGMaRY6Tw8gI3wfc1o=
X-Google-Smtp-Source: ABdhPJwMSPd88cmAAjtCyy9bDd2tXSHS1VWa0l8x1qP5Z+U1P8z1Vrc8lGaFcmb/5uP4fB/eXP9GfQP5mk9w+cjpzu0=
X-Received: by 2002:a9d:6951:: with SMTP id p17mr4460144oto.74.1628910474487;
 Fri, 13 Aug 2021 20:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.1628640954160.gitgitgadget@gmail.com> <xmqqh7fu314a.fsf@gitster.g>
In-Reply-To: <xmqqh7fu314a.fsf@gitster.g>
From:   Azeem Bande-Ali <me@azeemba.com>
Date:   Fri, 13 Aug 2021 23:07:26 -0400
X-Gmail-Original-Message-ID: <CABye9140=jnkERq8MLEcr_umW1+oaE5Wi39_iQnM3jevV3Hraw@mail.gmail.com>
Message-ID: <CABye9140=jnkERq8MLEcr_umW1+oaE5Wi39_iQnM3jevV3Hraw@mail.gmail.com>
Subject: Re: [PATCH] help.c: help.autocorrect=prompt waits for user action
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Azeem Bande-Ali via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, David Barr <b@rr-dav.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 3:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> If we cannot yet come to consensus that disabling autocorrection
> when running non-interactively is a good idea, at least we should be
> able to do so only for _PROMPT case, like the attached patch at the
> end.

Thanks for the suggestion. I think it makes sense to skip the autocorrection
completely when the setting is "prompt" and the user is not running
interactively.

> > +                     fprintf_ln(stderr, _("Assuming you meant: '%s'."),
> > +                                assumed);
> > +                     answer = git_prompt(_("Continue? (y/N)"), PROMPT_ECHO);
>
> Hmph, the above does not look WRONG per-se, but I wonder if it is
> easier for the users to see a single line, e.g.
>
>         struct strbuf msg = STRBUF_INIT;
>         strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
>         answer = git_prompt(msg.buf, PROMPT_ECHO);
>         strbuf_release(&msg);
>

I looked at the behavior for other settings and they
all behave pretty compactly. So I think this suggested
solution does fit better.

> +       /*
> +        * Disable autocorrection prompt in a non-interactive session
> +        */
> +       if ((autocorrect != AUTOCORRECT_PROMPT) &&
> +           (!isatty(0) || !isatty(2)))
> +               autocorrect = AUTOCORRECT_NEVER;
> +

That should be `(autocorrect == AUTOCORRECT_PROMPT)` right?
So we skip the autocorrect if the user is not running interactively
and has the "prompt" setting.

Thanks for all the feedback! I will send out a patch incorporating
this feedback soon.
