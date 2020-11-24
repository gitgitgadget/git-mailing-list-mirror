Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EBAC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF6B20644
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 17:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390792AbgKXRZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 12:25:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44243 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgKXRZL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 12:25:11 -0500
Received: by mail-ed1-f65.google.com with SMTP id l5so21709073edq.11
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 09:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCn0yB+f/a8ykbSV6JaEwviXPoCXS6QzQXIYIJk9qiI=;
        b=RL6YPBSEqe1X+bKvwwC6cNCa9OYQ0QF1TFTogSqMZAjVEOx83TkiZ0TzNU0bKr80rP
         mkwi23WOTnD0q/d9AzH9GhRgsJKtUMtrRHtSHgq8kOG1RZyzFvWU3KFDvEgQxnvdJ5RN
         KoqTh6tYz4lyLi3pFXqq8iyV7wyLOdOsIe3zGb38SX0YYDxAX4oJnLqxAZIwvuPbTMg6
         DFTymfXgdCa5b484ezIu+6aWSc88D3fJYVs/ieW9z6ak6qdYMBE5OtNUJdVI1hAOEHEO
         kE7+ArmVdBAIQLAUZ7b42dhwAezjpmKIRnm4874pQYfB5h437oR/ic7e0Ge5fQziB/Ly
         zyfA==
X-Gm-Message-State: AOAM531hry3tb5eDoT+Pe8PgOfGBPBFfrph5JmiMrChDFytzBkXq0Mg5
        cRYR7BpsQbZbYVO8+IRlqWir0EazazQJb47HMHs=
X-Google-Smtp-Source: ABdhPJwGfobjW80ae3/f+bXXvH+CtNZKo6ta9+QY5MOOKyKH/bkuje9ySraaSpZDcyCa/lR+xGPjQ282zDeSgTLPO1Y=
X-Received: by 2002:a50:c30d:: with SMTP id a13mr5066721edb.89.1606238709016;
 Tue, 24 Nov 2020 09:25:09 -0800 (PST)
MIME-Version: 1.0
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com> <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Nov 2020 12:24:57 -0500
Message-ID: <CAPig+cQ-iWVz2Q1PtvbV0hk_HHRFqAFjxAF2DZ6doh2RxpZJhw@mail.gmail.com>
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 11:45 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> The "git maintenance run" and "git maintenance start" commands holds a
> file-based lock at the .git/maintenance.lock and .git/schedule.lock
> respectively. These locks are used to ensure only one maintenance process
> is executed at the time as both operations involves writing data into
> the git repository.
>
> The path to the lock file is built using the "the_repository->objects->odb->path"
> that results in SEGFAULT when we have no repository available as
> "the_repository->objects->odb" is set to NULL.

This issue came up in review recently[1] in an unrelated way.

[1]: https://lore.kernel.org/git/CAPig+cRFQfg-NLx5dO+BjQpYduhOYs-_+ZRd=DhO8ebWjGB0iA@mail.gmail.com/

> Let's teach the maintenance_run_tasks() and update_background_schedule() to return
> an error and fails the command when we have no repository available.
>
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -441,4 +441,9 @@ test_expect_success 'register preserves existing strategy' '
> +test_expect_success 'run and start command fails when no git repository' '
> +       test_must_fail git -C /tmp/ maintenance run &&
> +       test_must_fail git -C /tmp/ maintenance start
> +'

I wouldn't feel comfortable relying upon existence of /tmp/. It might
be sufficient to do this instead:

    mv .git save.git &&
    test_when_finished "mv save.git .git" &&
    test_must_fail git maintenance run &&
    test_must_fail git maintenance start
