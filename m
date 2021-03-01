Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A6DC433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B28960C3E
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbhCAXdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 18:33:05 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:32909 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344126AbhCAWtW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:49:22 -0500
Received: by mail-ed1-f54.google.com with SMTP id c6so22942454ede.0
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 14:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkRJlPCo/8+zkV6ArXpbI7j+v2NbAXXtYdcmeVgI2RA=;
        b=ipTldYhe+O+tUGaVjnIva64sAJazIk7t2mHnRPuqn8JvFkF8+guhzj/C7Pa1e4OnvM
         qrnF8NcFEoJ8AlhEVTOMrd65Q8rbaFb7v4NxJHjTeGCdxKEhYiRHj+QrdI46kLJ7hg6A
         /hVFG/pXW8ldxMUF+JkyiZpTIbGGNxM7QRTsbKLvUU8ftc0ThDaiGNua9W6Eqcg2rLfE
         xcgaiu4C2vrDe47rQe91tA1pLT5g2xI9J8vJOaoA7qqTfDK/zXcyyK41nIT12h4Uw1FE
         bNW43t4X6gaL67C/qhI0H81MjlG+y40OfVdNsBy/DHnTbe8WXqe4OC3jaDcoIognVLsP
         fBXw==
X-Gm-Message-State: AOAM533170b5syGWN8v28kZ1ck4pYyfF3dziWKqJhPNOIHDCp5iBlcHx
        BZ137q3RXg07x9MMyr07VdQXxFDDrqsC3CSOhx8=
X-Google-Smtp-Source: ABdhPJzKgwn/nSQ6d5kzjJ1eBaZToH8oUDVAri5Y/7jPtejVUbldL4jOV/W4SZ1JwEd+4r9MyZs/nEjbAhgTvZx0owg=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr18253871edt.233.1614638869313;
 Mon, 01 Mar 2021 14:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com> <xmqqlfb6mrnx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfb6mrnx.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Mar 2021 17:47:38 -0500
Message-ID: <CAPig+cQ9wBLdKqmgjX4eOT6mvukmHXCDicTo5Ud+4VTkzxcXrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >     if (skip_prefix(msg, "amend:", &arg) ||
> >         skip_prefix(msg, "reword:", &arg)) {
> >         ...
> >     }
>
> You still need to compute "len" because you'd want to tell between
> --fixup="HEAD^{/^area: string}" and --fixup=bogus:HEAD (the latter
> would want to say "no such variant 'bogus' for --fixup", but the
> colon in the former is not the end of the name of variant.

I see what you mean. I vaguely recall quickly scanning over that
earlier discussion about ":" being otherwise legitimate when embedded
in the argument as you demonstrate, but didn't think about it when
reading this code. Perhaps the comment which this code adds:

    * As `amend` suboption contains only alpha
    * character. So check if first non alpha
    * character in fixup_message is ':'.

could be extended a bit to mention that briefly since, without it, the
significance of "alpha-only characters followed by colon" is not
immediately obvious.
