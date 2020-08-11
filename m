Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8467AC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639FD20782
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHKTZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:25:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38945 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 15:25:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id g75so3485572wme.4
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 12:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SwlXf2pWXGJ7sy14aVscafDMW2KVLaOVFYgYuxf4Ao=;
        b=QTR+zj9nwmFZ1Wokrz6s8YWnS5q1+itcm/O/cH2Ij2jgeBsVRGaCybcciJOu6ku+s7
         2Xzl8QWuS9PL6YfOEx8ej0ihef6feoGC8IYlHP+DhOrhj61nXXag7esEqtoid5ZR7E/w
         A/kcU2rQLInxSpS/6nZPHyhG74rbUFXbSETfhjezJYGLU+mC3l+sHDh5TI7H5Xo+IAJ7
         12NQZ5z1/l+mQ4ZSo+degMZCuUV74ZGA0MoH01bN12g7LVd3wuazNj1Ny4qk+t/9SpUO
         5sBMHXsxcTvTizOh+Ea+My9n5SCoNZCovcgHPGP5NXkJuvxWOMkTUAcDzI24EFsVrEfC
         OCow==
X-Gm-Message-State: AOAM5322SJQ7uBwYniYXbt/peXghnbimUyKNSBeZAJD3CE1pexVBDd0r
        3PPOzk+Ln1iGm9/s5xE7jo+jfd9e//7fYKqFCe8=
X-Google-Smtp-Source: ABdhPJyaO8DoMu4bVbjwWZP8MKNJ1Mz2b26ECk5u85+h1NezgG6VTdTP7gVuEhTi4enCecj7TvD3VI1Zdana5vMOav8=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr5115478wmc.53.1597173914857;
 Tue, 11 Aug 2020 12:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com> <20200811183258.GB33865@syl.lan>
In-Reply-To: <20200811183258.GB33865@syl.lan>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 11 Aug 2020 15:25:03 -0400
Message-ID: <CAPig+cSroWZEoOL78COmPS4rkvKLE-yCiqh6Part+5gUgVon+A@mail.gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 2:33 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Sun, Aug 09, 2020 at 01:42:09PM -0400, Eric Sunshine wrote:
> > +             test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
>
> Not related to your patch, but I've seen this style of "x$1" in a few
> places in test-lib-functions.sh. Why can't this be written as 'test "$1"
> = -'?

Short answer: To prevent 'test' from thinking that the argument is a switch.

Longer answer:

'test' can accept both switches (i.e. "-e") and non-switch arguments.
Keep in mind, too, that all the quoting is stripped by the shell
_before_ 'test' ever sees its arguments. Let's say that the caller has
a filename whose name actually is "-e" and passes that in as $1. So,
what does 'test' see?

    test -e = -

Rather than comparing literal string "-e" to literal string "-", it's
instead (almost) asking if the file named "=" exists; I say "almost"
because it's actually an error since switch -e only accepts one
argument, but it's being given two arguments, "=" and "-".

You might say that having a file named "-e" (or similar) is unlikely,
however, what is not unlikely is a caller passing "-" for
standard-input as $1. In this case, 'test' sees:

    test - = -

which may or may not be an error in a particular implementation of
'test'. Some implementations may understand that "-" is not a valid
switch, thus infer that you're actually asking for an equality
comparison between arguments, but other implementations may complain
either that there is no switch named "-" or that those arguments
simply make no sense.

This is why it's a very common idiom in shell programming with 'test'
to see "x" prepended, thus ensuring that the argument can't be
confused with a switch.
