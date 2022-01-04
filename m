Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98F0C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 00:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiADAmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 19:42:03 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:41708 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiADAmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 19:42:02 -0500
Received: by mail-pj1-f43.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so1400072pjp.0
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 16:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oV0Ktrw7UkYzW2K3KRhYrQM2+N1lwPKZ0MJUw0HuX8U=;
        b=OdBxewo7xhVz2FaUR0hyfQXqHmrmv5MckYHX2ZqRo1N3Vtrd3J0HQTn0pYQkZ9u7mz
         tpoB92s+wlQTfQi3wEHSNhyrYBOzp0YVEB6nS1rShIPrXPkikGoEIJLms7ZviMDDt7y0
         26jzfCxzDlSp0BRKsjsoXceoEvFQr3Yi4LuBfLAgLgS5ipp5JY7pEJX35C1+dhdNCTgg
         5GUVShIy219hvGk9rjFiYmCPQO8+Or+nurd5+PUnAhnHN5s0f1TplutULbT3YZdaZx7e
         aOP2/c0tBx783PkK9qn3wtW09ry5mGVQ85zjEbGhE+vhWnfYAMJKCLA0NhYAoI9ZMerV
         v4+g==
X-Gm-Message-State: AOAM530fPRKF7ktQ/qfoSvu37U378rl+MMTUGac8rVSRnVQa3mxS8xY+
        /yPAVTMz81QNxuapt7d3lDufJQP4FUZ6qnvf+wo=
X-Google-Smtp-Source: ABdhPJxYQQEQ9/Brn8ODYqdXgxmrO3nNOT6rPLiNvqp11SxS1d2qe7nrmlptCNeV4P0Q6W6pitGSyfl4pSRJP0ly8os=
X-Received: by 2002:a17:902:b688:b0:149:a1d6:c731 with SMTP id
 c8-20020a170902b68800b00149a1d6c731mr21611842pls.145.1641256921832; Mon, 03
 Jan 2022 16:42:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <20220103095337.600536-1-fs@gigacodes.de> <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
 <xmqqee5oieb2.fsf@gitster.g>
In-Reply-To: <xmqqee5oieb2.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Jan 2022 19:41:51 -0500
Message-ID: <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 3, 2022 at 6:34 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Mon, Jan 3, 2022 at 9:24 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> >> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
> >> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
> >> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms
> >> this hypothesis. Signature verification passes with the fix.
> >> ---
> >> -                       trust_size = strcspn(line, "\n");
> >> +                       trust_size = strcspn(line, "\n"); /* truncate at LF */
> >> +                       if (trust_size && trust_size != strlen(line) &&
> >> +                           line[trust_size - 1] == '\r')
> >> +                               trust_size--; /* the LF was part of CRLF at the end */
> >
> > I may be misunderstanding, but isn't the strlen() unnecessary?
> >
> >     if (trust_size && line[trust_size] &&
> >         line[trust_size - 1] == '\r')
> >             trust_size--;
>
> That changes behaviour when "line" has more than one lines in it.
> strcspn() finds the first LF, and the posted patch ignores CRLF not
> at the end of line[].  Your variant feels more correct if the
> objective is to find the end of the first line (regardless of the
> choice of the end-of-line convention, either LF or CRLF) and omit
> the line terminator.

Okay, that makes sense if that's the intention of the patch. Perhaps
the commit message should mention that `line` might contain multiple
lines and that it's only interested in the very last LF (unless it's
already obvious to everyone else, even though it wasn't to me). I
think it can still be done without strlen(), but it gets uglier and
less obvious[*], so strlen() is probably the way to go, and I presume
this isn't a hot path, so no big reason to avoid strlen().

[*] Like this, for instance, which is safe because there must be at
least one character after the '\n' since this is a NUL-terminated
string:

    if (trust_size && line[trust_size] == '\n'
        line[true_size + 1] == '\0' &&
        line[trust_size - 1] == '\r')
