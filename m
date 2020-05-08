Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA556C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92293207DD
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgEHPir (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 11:38:47 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36538 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgEHPir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 11:38:47 -0400
Received: by mail-wr1-f49.google.com with SMTP id z8so2415052wrw.3
        for <git@vger.kernel.org>; Fri, 08 May 2020 08:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xC8nbtwOu8dc8qLfCl7NUEmw77Z7RznmAsKrP8a23g0=;
        b=F9PirErAaUVS77RDnrnwo2wbfgsby7ukY0cy3N2j4PSFYWbwIojwXouH2h7gijqOeM
         jM3ZNGHxVu+ulM1spfaXgbTwPzBwoV+0hfuG8tHDO+SLjtr5LqqNeq/PAoh0P1lgp0E9
         KFQLU8fKKMEUPZ/CETcX0P2kfU4zpMGsMvpcgQO/YR5dTHq0iYkBTiv1hEfa6FqhSBfN
         QihBI5IlKbPgVa1HS+xE4M9BL6yo0J0s6RnUHv3Y04UYrPeAs4AO5kgBxpmXYmc9Fjnw
         ed+xRdrFlHbWc9u90oHXgG+NOVpLeg5fTF+O+1ZjWYcrtp0xcXSpuQrI8ykDqX2fynIF
         ChZQ==
X-Gm-Message-State: AGi0PubbcbFpaT4iPIfFctfVaXJ+w2CdE5EvGdeghceATD+wuTJRaJVR
        R58S192nx3WJQc1r1yrNizRZZgmaWPk39LxhH4dDGA==
X-Google-Smtp-Source: APiQypLTLcjz8E72n+yxM5eNL3xdjbGlozm0KT4jQSZwNf7CcrRTOVHMVYGZFo5qx+8hOFQOxvtZllf5MkTVH49blVk=
X-Received: by 2002:adf:f786:: with SMTP id q6mr3552992wrp.120.1588952325370;
 Fri, 08 May 2020 08:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
 <xmqqtv0t6l84.fsf@gitster.c.googlers.com> <20200506181239.GA5683@konoha>
 <xmqqwo5o6hzp.fsf@gitster.c.googlers.com> <20200507044028.GA5168@konoha>
 <xmqqv9l849i4.fsf@gitster.c.googlers.com> <20200508054728.GA8615@konoha>
 <CAP8UFD0=_8D8hkT5VVPV_F++dr131bkjby357fA+QfhQxktcMg@mail.gmail.com> <xmqq8si21mlz.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqq8si21mlz.fsf_-_@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 May 2020 11:38:34 -0400
Message-ID: <CAPig+cQP_9onrq-z5db1GhXSSHaeKJ+UhNewWP25wLCsMRzSrA@mail.gmail.com>
Subject: Re: Re* [PATCH v4] submodule: port subcommand 'set-url' from shell to C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        chrisitan.couder@gmail.com, Denton Liu <liu.denton@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 8, 2020 at 11:18 AM Junio C Hamano <gitster@pobox.com> wrote:
> + - Do not explicitly compare an integral value with constant 0 or a
> +   pointer value with constant NULL for equality; just say !value
> +   instead.  To validate a counted array at ptr that has cnt elements
> +   in it, write:
> +
> +       if (!ptr || !cnt)
> +               BUG("array should not be empty at this point");
> +
> +   and not:
> +
> +       if (ptr == NULL || cnt == 0);
> +               BUG("array should not be empty at this point");

This talks only about '=='. People might still use 0 or NULL with
'!='. I wonder if the example can include '!=', as well. Perhaps:

    if (!ptr)
        BUG("...");
    if (cnt)
        foo(ptr, cnt);

instead of:

    if (ptr == NULL)
        BUG("...");
    if (cnt != 0)
        foo(ptr, cnt);

or something.

Also, would you want to talk about not comparing against NUL character?

    if (*s)
        foo(s);

instead of:

    if (*s != '\0')
        foo(s);

Maybe that's overkill since NUL is an integral value which is already
covered by your earlier statement (but perhaps some people would
overlook that).
