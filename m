Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A614C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B36460EE5
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhHDWRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:17:41 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:33311 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbhHDWRe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:17:34 -0400
Received: by mail-ej1-f51.google.com with SMTP id hs10so6104134ejc.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8cm3/US7j4EiKd5uBzTML+3l4LJpVZWNtyZ5zvypbg=;
        b=EYql6WdrLYRS08Bb6ynfTEmbjYSvtzdjeWb6ictOEX1/GgMalHaDQKqeq5kbsY1K+d
         BLJIicLfs52TvcfxMFkJhCoNhZzGdBxi8xTjs0i8Dx02WIX7PyRknH2VrBRNpYKmD2tK
         dDOImcCUlAOomFuCWj9/YBLzKuZOpCR2yewMQJiekdKWZaaAFE5fsd1xvwalh+/E/U5S
         qH3d/hWltlLIDC+6PpwEEVyRgmZUc35HgKINxmwq9j0/D08BV6gDPLI152I9m8gg6/gL
         GgnE300GwaYDTSUKUG+Ak4WrO70CnS+Fo1MKfYAL0+kqlZfJng7Ro5E+deffWLowwvo8
         v33g==
X-Gm-Message-State: AOAM531EjEPBAbM9s2jGonuonEkF6V/Z1Vth0lLFLFx2bmQ1z6mu3yM3
        Tceh+UKRYrWb7Jz3Y5eeKI+dG7ppOslWvtjNAro=
X-Google-Smtp-Source: ABdhPJxNT5tkANruA6+V9f/bM1kKBFtpheVjkGq3u7RyrpHtge+63vQJTohR0gUzS9u/aGmoQDmRz7dHtIb4e4i/hRo=
X-Received: by 2002:a17:906:e0ce:: with SMTP id gl14mr1353356ejb.168.1628115440580;
 Wed, 04 Aug 2021 15:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st>
 <20210804203829.661565-1-kim@eagain.st> <xmqq35rooqr5.fsf@gitster.g> <CDB2GX6ICZMC.1FDRFIKZU9GU6@schmidt>
In-Reply-To: <CDB2GX6ICZMC.1FDRFIKZU9GU6@schmidt>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Aug 2021 18:17:09 -0400
Message-ID: <CAPig+cTVOC_MndYTQqCY5PpCtXWSRm17FULf7eW26giVoCN-6Q@mail.gmail.com>
Subject: Re: [PATCH v3] upload-pack.c: treat want-ref relative to namespace
To:     Kim Altintop <kim@eagain.st>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 4, 2021 at 6:04 PM Kim Altintop <kim@eagain.st> wrote:
> On Wed Aug 4, 2021 at 11:15 PM CEST, Junio C Hamano wrote:
> > Kim Altintop <kim@eagain.st> writes:
> > > +   env GIT_NAMESPACE=ns test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
> >
> > I am not sure why we want "env" in front (it does not hurt, but it
> > should be unnecessary, as test-tool is a plain-vanilla binary
> > executable, not a shell function). Is this a workaround for a buggy
> > test linter or something?
>
> The linter did indeed ask me to write `GIT_NAMESPACE=ns && export GIT_NAMESPACE
> && test-tool ...` in v1 of the patch, but now it doesn't... nevermind, I must
> have held something the wrong way.

The linter will complain about unportable:

    export FOO=bar

and ask you to write it as:

    FOO=bar && export FOO

which is probably what you encountered.

It will also complain about

    FOO=bar some-command

which should be rewritten as:

    env FOO=bar some-command

if, and only if, `some-command` is a shell function. If not a shell
function, then:

    FOO=bar some-command

is just fine.
