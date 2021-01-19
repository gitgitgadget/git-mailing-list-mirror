Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36324C4646E
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1978520776
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbhASRRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:17:09 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:41562 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388992AbhASRQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 12:16:59 -0500
Received: by mail-ej1-f54.google.com with SMTP id g12so29601813ejf.8
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 09:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cO/duRDNvhbzE8Has/8FX7mxlxWIlQLh1IgGIic1eqQ=;
        b=PpC7PwLq6E0OCid6jpG45kd/dWOklY30epgGVhagHNhfe7mV95nd3Vu6RU6yTuibmb
         uSXdxVf+V8Z5cxIDVndl86Jbn3GRFFyQkqwY3qWYggHYmpVMAhOsOc/OTJ5gvODWIX+I
         13Fo6mXWa6nK0rwI4KacCLImmPdC8R/T0Mpe/frnVrnGJGKI9k4Ow7MOaYXPtlbvbBxL
         3BM+WhospGwAgyvAGaIRS4H2jPO5sR47VI+52NvVUkffvbU4tNlZWdpElLuZtNESSm3a
         KiXVlV5UNuxuILHOMEB2G06QsPTNmBvC/hAbGZ6MUCFbWkVEVdOT8YP2my87aESO+M3M
         L7fQ==
X-Gm-Message-State: AOAM531hXoDc+NavWJZJIV7N0054ryySFzsXI/stE0L7AMp2JCZ3Exlr
        uTMIsFRQBz2aMhwyDseP/foZ2khjumFbINX/+T7nJ/mdSGKC5Q==
X-Google-Smtp-Source: ABdhPJxOSOROh5HqnkiMMCvB2w4A4EcY9UfdUkZyoE6Iv19SOZMj7KpOahz9WjJvZKWQM5epcwIWM8AElefxjWgpI8k=
X-Received: by 2002:a17:906:d0c1:: with SMTP id bq1mr3556091ejb.202.1611076576669;
 Tue, 19 Jan 2021 09:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com> <20210117234244.95106-5-rafaeloliveira.cs@gmail.com>
 <CAPig+cSHpP8-QxmQhNuBd3sgn7D6ZfBnK7+1Yw50aakD2UqGFg@mail.gmail.com> <gohp6kbldlfkig.fsf@gmail.com>
In-Reply-To: <gohp6kbldlfkig.fsf@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Jan 2021 12:16:05 -0500
Message-ID: <CAPig+cRZCfuhdX7O4RFLbzxoOeQF1BEopjJM=3SfuuEd+cCEMw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] worktree: teach `list --porcelain` to annotate
 locked worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 3:20 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Eric Sunshine writes:
> > On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
> > <rafaeloliveira.cs@gmail.com> wrote:
> >> +               quote_c_style(reason, &sb, NULL, CQUOTE_NODQ);
> >
> > This needs a change, and it's totally my fault that it does. In my
> > previous review, I mentioned that if the lock reason contains special
> > characters, we want those special characters escaped and the reason
> > quoted, but _only_ if it contains special characters. However, I then
> > incorrectly said to call quote_c_style() with CQUOTE_NODQ to achieve
> > that behavior. In fact, CQUOTE_NODQ gives us the wrong behavior since
> > it avoids quoting the string which, as Phillip pointed out, makes it
> > impossible to distinguish between a string which just happens to
> > contain the two-character sequence '\' and 'n', and an escaped newline
> > "\n". So, the above should really be:
> >
> Alright, I believe I've got the whole picture now and sorry for the
> confusion. You and Phillip clearly stated in the review cycle that the
> reason should be quoted because of the aforementioned reasons and I
> dropped when I was working on this version.

It was my fault by confusing you with the misleading mention of CQUOTE_NODQ.

> >> +       git worktree add --detach locked1 &&
> >> +       git worktree add --detach locked2 &&
> >> +       git worktree add --detach unlocked &&
> >
> > So, the purpose of the `unlocked` worktree in this test is to prove
> > that it didn't accidentally get annotated with `locked`? (Since, if it
> > did get annotated, then `actual` would contain too many lines and not
> > match `expect`.) Is that correct?
>
> Yes, this is what I intended to check when adding the `unlocked`
> worktree. I'm considering how to make this more explicit so it's clear
> for readers why the `unlocked` worktree exists in this test.

A simple in-code comment should suffice, I would think:

    git worktree add --detach locked1 &&
    git worktree add --detach locked2 &&
    # unlocked worktree should not be annotated "locked"
    git worktree add --detach unlocked &&
