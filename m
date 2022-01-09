Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4396C433F5
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 20:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiAIUuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jan 2022 15:50:03 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:51061 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiAIUuC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jan 2022 15:50:02 -0500
Received: by mail-pj1-f52.google.com with SMTP id pf13so3110161pjb.0
        for <git@vger.kernel.org>; Sun, 09 Jan 2022 12:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPv5MQAGMemXyh9A+aXBOWQBSRAa6ACcWgaTu6MKn7w=;
        b=VE0LEkekCQA8k8FU2NpV8Fq8lblTexIaW8KFILId6sfv7d2W2/F+Ffeyso2lRfgBBl
         mgroPE8OCG9W7geCQM+JhAa80jkZfWmIU2A92W1CHS3D3Jnl2PAHRgSSE8XfSB2v5JsQ
         cr8e3ldjGEPIWq++4sgPxU8KxHC8HGNG9H/PGhyBLT2p0GNMC9LgnSjbdTdMQFWLujXJ
         r/sZ2sffnuOqgckqH1ObHWsx9/b09TeN9ybh0bjJBCvU1LWLCm1wvhna0M/HpUoD1KrK
         GtiotlE4BpQAJrot79u89j3/AyZBuzLlHT/0B/5zGGpJ3dSFT2ERv5xXJNWTS63ReFB5
         E+DA==
X-Gm-Message-State: AOAM533xVEVi68slgfxjHkKTpC85FyIjNn+JIr6TOs7rjJBLD+iB+uWB
        p4gR5uaPErotdFUnqzalYOMntDBxOWQOKoC1JV8=
X-Google-Smtp-Source: ABdhPJw3bbQPy+EcgkS4qTPqw2Oojll13PlcEYu28tp1aIcfDWBclhBmugUR4aTworOwfxywgUX4cvwNOj7hyB2wHqg=
X-Received: by 2002:a17:90b:4a84:: with SMTP id lp4mr27295893pjb.150.1641761397589;
 Sun, 09 Jan 2022 12:49:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <20220103095337.600536-1-fs@gigacodes.de> <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
 <xmqqee5oieb2.fsf@gitster.g> <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
 <xmqqmtkcguvm.fsf@gitster.g> <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
 <20220104125534.wznwbkyxfcmyfqhb@fs> <xmqqo84rcn3j.fsf@gitster.g>
 <CAPig+cQinNZp_2=eo7nokMCZ9gc-tAKO1V_jejL2Ei9J63tSDQ@mail.gmail.com> <20220105103611.upfmcrudw6n3ymx6@fs>
In-Reply-To: <20220105103611.upfmcrudw6n3ymx6@fs>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 Jan 2022 15:49:46 -0500
Message-ID: <CAPig+cQMP_Ppg6uywAcFhaVqSoa71dD6UjXbUtC-bvK0WzJnZA@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 5:36 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> On 05.01.2022 02:09, Eric Sunshine wrote:
> >> >      line = strchrnul(line + 1, '\n')) {
> >> >       while (*line == '\n')
> >> >               line++;
> >> >       if (!*line)
> >> >               break;
> >
> >Indeed, the existing code is confusing me. I've been staring at it for
> >several minutes and I think I'm still failing to understand the
> >purpose of the +1 in the strchrnul() call. Perhaps I'm missing
> >something obvious(?).
>
> This whole loop was basically copied from parse_gpg_output() above. Without
> the +1 this would always find the same line in the buffer. The +1 skips over
> the previously found LF.

I still don't see the point of +1 in the strchrnul() call. After:

    line = strchrnul(line + 1, '\n'))

`line` is going to point either at '\n' or at NUL. Then:

    while (*line == '\n')
        line++;

skips over the '\n' if present. So, by the time the next loop
iteration starts, `line` will already be pointing past the '\n' we
just found, thus the +1 seems pointless (and maybe even buggy).

But perhaps I have a blind spot and am missing something obvious...
