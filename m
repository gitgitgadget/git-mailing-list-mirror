Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D09C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6C22222C
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgJNR4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:56:02 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:38660 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJNR4C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:56:02 -0400
Received: by mail-ej1-f49.google.com with SMTP id ce10so6102615ejc.5
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pC6bH8YGFIFKas1bS1z1FpeMjbO//3teLh54OMIOHN4=;
        b=a9ifjB80rMJc5yyp6OTbjPv8OJVd2YXAAQIobH6YUNZUUk5RF7GqZMF8st4dFW8Odp
         5hTFANEF9OD7nXaWKZEzT3KQTsWkAhzNdL0shCsqxVYFL05TCrK2QrG1mP7UBSWqbiRH
         zv0XUb37/+F/9OdfAFpILHY03SS7FFMXnOUYWmNoL8FzWbPoyr0BgV6La2cxLltxi9S9
         PgP9gn7bsdt/J/yvTR7qsOHj+hIoa0//Nz9dg3oGW9hgHsAs7om4o9rTkMYpF8xWJT1N
         ErkS0d2e/2LR3g56UwluTaMJBqFiRi/aPt96hVVs7+3L8asOlHS/FrYLNJ2INh8LiYeB
         pcWg==
X-Gm-Message-State: AOAM532AiRVDJHPZwuKmoBDMyFpyb3bi9CWtzgOTuqgjjyUvXztil4mV
        6KKzLXCI0YhpypJwEqkwVRvtCpSIs/xXZugi2odtwDUgu50=
X-Google-Smtp-Source: ABdhPJx4ncjnbGT7FcvonF0tXrHdqoKMNo8RsWDn/LVUQ2S3ask6CEohNuQ9KbUGfpfU0CfngC6TfzO5vk36S7qBrQg=
X-Received: by 2002:a17:906:a149:: with SMTP id bu9mr200104ejb.115.1602698160040;
 Wed, 14 Oct 2020 10:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <703071109.20201014201106@yandex.ru>
In-Reply-To: <703071109.20201014201106@yandex.ru>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 14 Oct 2020 10:55:45 -0700
Message-ID: <CAPc5daVAJxfZVz0HwTFwhq-EfERrESU2Ta6-0fAyXrzf3YJREg@mail.gmail.com>
Subject: Re: BUG: git rebase shows different commit message
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> $git log --graph --decorate --pretty=oneline --abbrev-commit
> * 093010ea (local/dev) Change column 'Label' => 'OPFG' and added column 'comment'
> * 86221a47  Updated OpenAPI schema according to SCHEMA 193
> * 6202eb08 Added opfg.html
>
> $git rebase -i --autostash --rebase-merges 86221a47^
> label onto
>
> reset onto
> pick 86221a47 Updated OpenAPI schema according to SCHEMA 193
> pick 093010ea Change column 'Label' => 'OPFG' and added column 'comment'
>
> Here commit message is shown without leading space.
> I  think  that this is wrong. Because if space was shown then I reword
> commit message
>
> r 86221a47 Updated OpenAPI schema according to SCHEMA 193
> pick 093010ea Change column 'Label' => 'OPFG' and added column 'comment'
>
> but now I just do not see that I shold reword it =(

These one-line titles are shown to help you identify the commit to futz with,
not to help you review them. After all, you see only titles here
without the body
of the log message [*1*].

Besides, if the "breakage" in the title were not just an extra
whitespace but some
control characters that take the terminal into an insane state, we
should sanitize
the title we'd show here for identification purposes, so "show the
title as-is" is not
a good idea to begin with.

So, NAK.

[Footnote]
*1* ... and if majority of your commits have a single-liner titles, I cannot
imagine how these logs can be useful to its consumers (i.e. those who
use "git show" after identifying an old commit that broke things using
"git bisect" or "git blame").

A leading whitespace in such a "git log" output would be the least of your
problems in such a history, I would have to say.
