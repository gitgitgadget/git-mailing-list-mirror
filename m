Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73088C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 03:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiADDG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 22:06:29 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:44630 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiADDG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 22:06:28 -0500
Received: by mail-pj1-f45.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so1646998pji.3
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 19:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzcEw+dHw8C6u7ZSxBdnG9Hc8WICKkfulZhKU8H+Xlw=;
        b=IHnpXv2VLy6q+9WF8MTyyyVazPjqnh27Rbfee/1LE2IVCmlWs5ipF6zAJApftiqIFl
         32gpM81TC4AfU6lO+xl4vu0RuohYLArPfzXMhpbyG/pReBiZTxcR6DOk4m70uEirrUBG
         S8g1iy6lP3XCGe/QOJT0mZc7SFjoelyUc2LpH9A6IjtorPKshYN75lPbKdB5ReJTgOwU
         zyoBLGJuV+1lMfBmrCMcidQKOZUrTXWOgJZmLcxNFC67IZBNY0BA+yD2WetaLXEjdPwF
         I3dPt6dawEa9jFxiptfHtfTNNI5pDR8xSRj0QecKU+jScJdgHK7FdGbuVGWLrzD6pv/S
         hVvw==
X-Gm-Message-State: AOAM533fJaq89MruF1vlgYxiKgKrCCijISXTyDMZC/hPmXaE+fZELEbT
        hjaxnUzYt5E5o/+yhJ0DGiihsx3hiB/z7+DX18Y=
X-Google-Smtp-Source: ABdhPJzBuWjJaVoCIORz1uKRANyNOsEVb9Gh3gte4yJOcTMTnK9yt5Rho2sv27po3N2+zeifQcchF9YQFlhJonT0W1o=
X-Received: by 2002:a17:902:8346:b0:148:997d:f60b with SMTP id
 z6-20020a170902834600b00148997df60bmr47974373pln.64.1641265587428; Mon, 03
 Jan 2022 19:06:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <20220103095337.600536-1-fs@gigacodes.de> <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
 <xmqqee5oieb2.fsf@gitster.g> <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
 <xmqqmtkcguvm.fsf@gitster.g>
In-Reply-To: <xmqqmtkcguvm.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Jan 2022 22:06:14 -0500
Message-ID: <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
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

On Mon, Jan 3, 2022 at 8:19 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Mon, Jan 3, 2022 at 6:34 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> > On Mon, Jan 3, 2022 at 9:24 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> >> >> -                       trust_size = strcspn(line, "\n");
> >> >> +                       trust_size = strcspn(line, "\n"); /* truncate at LF */
> >> >> +                       if (trust_size && trust_size != strlen(line) &&
> >> >> +                           line[trust_size - 1] == '\r')
> >> >> +                               trust_size--; /* the LF was part of CRLF at the end */
> >> >
> >> > I may be misunderstanding, but isn't the strlen() unnecessary?
> >> >
> >> >     if (trust_size && line[trust_size] &&
> >> >         line[trust_size - 1] == '\r')
> >> >             trust_size--;
> >>
> >> That changes behaviour when "line" has more than one lines in it.
> >> strcspn() finds the first LF, and the posted patch ignores CRLF not
> >> at the end of line[].  Your variant feels more correct if the
> >> objective is to find the end of the first line (regardless of the
> >> choice of the end-of-line convention, either LF or CRLF) and omit
> >> the line terminator.
> >
> > Okay, that makes sense if that's the intention of the patch. Perhaps
> > the commit message should mention that `line` might contain multiple
> > lines and that it's only interested in the very last LF (unless it's
> > already obvious to everyone else, even though it wasn't to me).
>
> I do not think that is the case.  strcspn(line, "\n") will stop at
> the first one, so unless it is guaranteed that "line" has only one
> line in it, the patch as posted is not correct.  Your variant
> without strlen() feels more correct, as I said.

Okay, sorry for my unclear thinking. The existing code (before this
patch) does indeed seem to be interested only in the first line of
`line`, in which case I agree that the patch's use of strlen() does
not appear to be correct if `line` could ever contain more than one
line.
