Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AFBC433E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 23:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFB42071A
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 23:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgGWXKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:10:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55571 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgGWXKI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 19:10:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id 9so6363040wmj.5
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 16:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bL3AcsKJDiHSw7S4BoceLsO9odGTdhpSTCuf8HpDKD8=;
        b=Frdilb1pXFm0hcqalBktogHNMjPVQL7X/BBoj1g5Ejzcc8rNTklj0YJuql8Zx05Oge
         ZFHH8L6AddbWQTyAyg5FSwcnZMH2E2S7DwkVC2kNGLljT/xtu1XQP595gsYErHkfWiFd
         WstG0YxC/Nr81cpoHlqCNBxl3tcg7leTf7yzQ0nI48w60/Lk98ZQsRSCyke1FGbgTe0Z
         NLrN+4I9hN2a/B+vU7/t4udoJ/QW8PEqSSiPl91EzP6D7/40ujbNNj/oHe1/Ul5gh4ED
         DMENWcmdc0DgqHdcOZVcY6P1vCzdZhv8qq6tn3oiynPkdiB3xLZKxQJsl0SnZHH1Cf6t
         KCww==
X-Gm-Message-State: AOAM531+NSBBlOh6n8uFVk7JqoQG9WbB+aM7JTXuBUks/l8e8GIo9ifu
        gFbuZkBrJ70JUzEqdgJtMEZHe2q0XZ8neQ04CNc=
X-Google-Smtp-Source: ABdhPJyccJc12vSPI1H5i5WP36wq0XaFcZv1HR7JWdvIlxtlJR1m9wiOaMo0BaVwe3F18SDd7ZpuHmBYWN391DT5UtM=
X-Received: by 2002:a1c:3504:: with SMTP id c4mr6023340wma.177.1595545806557;
 Thu, 23 Jul 2020 16:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com> <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
 <xmqqa6zpq3nt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6zpq3nt.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Jul 2020 19:09:55 -0400
Message-ID: <CAPig+cRXdrg6ceZV27yjV_jB58iDuMi=54SvtArV1BfxExRgMQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        steadmon@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 6:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +     struct strbuf batch_arg = STRBUF_INIT;
> > +
> > -     argv_array_push(&cmd, "--batch-size=0");
> > +     strbuf_addf(&batch_arg, "--batch-size=%"PRIuMAX,
> > +                 (uintmax_t)get_auto_pack_size());
> > +     argv_array_push(&cmd, batch_arg.buf);
> >
> > +     strbuf_release(&batch_arg);
>
> I think I saw a suggestion to use xstrfmt() with free()  instead of
> the sequence of strbuf_init(), strbuf_addf(), and strbuf_release()
> in a similar but different context.  Perhaps we should follow suit
> here, too?

Perhaps I'm missing something obvious, but wouldn't argv_array_pushf()
be even simpler?

    argv_array_pushf(&cmd, "--batch-size=%"PRIuMAX,
        (uintmax_t)get_auto_pack_size());
