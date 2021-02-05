Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25650C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC7764DFA
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhBEHR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 02:17:58 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:37372 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhBEHR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 02:17:57 -0500
Received: by mail-ej1-f51.google.com with SMTP id jj19so10220936ejc.4
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 23:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJxN1l82GrDO+dgJnwo2UXQJGXlf5flEbFVBad18XIg=;
        b=AHJZHccJqNVAS3T4+obZvWLAxrr/UZDaO3hrMgTNOA/y47mdiHaPVCEcK1jGIQMQ3/
         t3DTG/ERrY9wKfWZodqyj7Pva9/py6Md35a+Fg4Du6l4pIZQ+Qz0UzBEuSUzyPMdgCt4
         efSzWRzJUYKYSMxnwIyh/AO7wuoPoCZvF08AJ2G+kvm9cj+Gz1+sa+EAKgtzGrSQ7n60
         vUASbFrHqdhbaOunVpNbJ9+pJ3nibdNucSQYVp9UxnRswBi7vTH11SM4lb0nK62Yl4/J
         OmqCyfu7zg4NN6arKEeNUdk9riJC7KeN5dTp0bJVCv6JTLRhsuyshli26Wvqgh9TIV7x
         19mg==
X-Gm-Message-State: AOAM533NIZ9Yh2CxEJuts50ULl1k3PVsH/nFSYuaHR8xf/oCfGcaBGvK
        +X5bUaXVwaNU42CIL5fZeotR/fz2ltou5YrPZ/s=
X-Google-Smtp-Source: ABdhPJzEKzlWfSDOTm4IFvvLsMr8zuYQN4my4WrPoaM64MXZ4A/d7j7OuElL1Vls75jc7LWct/VfsQOElQfgY4RnwZ8=
X-Received: by 2002:a17:906:3649:: with SMTP id r9mr2761068ejb.202.1612509435569;
 Thu, 04 Feb 2021 23:17:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.954.git.git.1612388043875.gitgitgadget@gmail.com> <xmqqa6skbw9u.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6skbw9u.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Feb 2021 02:17:04 -0500
Message-ID: <CAPig+cRos+wGuwqbjuAV11kM5U0TPbBO9F4o4VJzQ4eZyxArMA@mail.gmail.com>
Subject: Re: [PATCH] status: fix verbose status coloring inconsistency
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lance Ward via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Lance Ward <ljward10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 5:51 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Lance Ward via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >  t/t7527-status-color-pipe.sh | 55 ++++++++++++++++++++++++++++++++++++
>
> Don't we already have test that checks "status" output including its
> coloring already? I'd rather see us adding to existing test script,
> than allocating a new number for a small subset of features being
> tested for a command.  After all, test numbers are limited resource.

t7508 seems like a good place for these tests.

> > +test_expect_success 'git status' '
> > +     git status >raw &&
> > +     test_decode_color <raw >out &&
> > +     grep "original$" out
> > +'
>
> Not "new file: *original$" or something less false-positive prone?

The "new file:" message is localized, so this `grep` will need to
become `test_i18ngrep` again (as it was in the original submission) if
this approach is adopted, which is fine.

> > +test_expect_success 'git -c color.status=never status' '
> > +     git -c color.status=never status >raw &&
> > +     test_decode_color <raw >out &&
> > +     grep "original$" out
> > +'
>
> Would it make sense to have tests for color.status=true, I wonder.
> It requires tty to actually "see" the colors output but sending
> the output to tty is the normal use case, so we should care...

I wondered if `color.status=true` might already be tested by t7508 but
apparently it only checks `auto`.

> > +test_expect_success 'git -c color.status=always status -v' '
> > +     git -c color.status=always status -v >raw &&
> > +     test_decode_color <raw >out &&
> > +     grep "<CYAN>@@ -0,0 +1 @@<RESET>" out &&
> > +     grep "GREEN>+<RESET><GREEN>1<RESET>" out
> > +'
>
> Are we forcing the standard palette?

As this is a stand-alone test script with a well-controlled initial
configuration, I expect it would be using the default palette. t7508
does assign a custom palette for `color.status` but not, apparently,
for `color.diff`, so it presumably should be okay there, as well.
