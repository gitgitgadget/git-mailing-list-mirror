Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBDDC433E9
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 08:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC55822CF6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 08:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbhAXILw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 03:11:52 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:37500 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbhAXILn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 03:11:43 -0500
Received: by mail-ed1-f54.google.com with SMTP id g1so11542751edu.4
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 00:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnXX1PJDeLrrcNEwHgQD3Fnwz30tLQqlCWxHo6kwGwo=;
        b=Q1hhbWRxU21/7TRgalVZflmzEvn368/zu0TOmznY4n05/8kcJIQpnAX23hlbFKFz9X
         3weOZ0diNfSJIpDGj9qDtM3tyTs1pJ7u67chn0t20HdfwGuHAhw6hWZ/kLXHRSTrAqoV
         yWg/RlZWJOc82vHpj66Ljd8p0C6nOeQXAmZIBeXI60LF/Rh4b5DVBRLGuWUk3GlrKE4A
         ZWyB7r6CXmd0G0aDfoSfs0WA3tK7tvBBJDP8ib0Ke4QamJ+qOPXEdRSSQw7OOCveBt5n
         q0A8ouxIufOqDMKm7Mjb5dnaUofad7U720lq2Sw4xSD7Pe4WZJF8D5POuV3UFlj5lQ1+
         SChw==
X-Gm-Message-State: AOAM5339bOx9TCLxHXjbQ0dQ+LsAB6T87dcnerl6bdrB5txMU7OIFgep
        tbIrtFAFqaPxHiUc7pY64kHNdPW/2rkr8A8uc5ze44E6EFsbAQ==
X-Google-Smtp-Source: ABdhPJw6LPIUCh9iXnUKu0IJ5jFs+kEJQpYwUPd9zHv8L2ZQHY+jDGO2jVDezmNZFJpUs51pWH7mwcQh/TkwN5In8Gs=
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr54972edz.89.1611475861806;
 Sun, 24 Jan 2021 00:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com> <20210119212739.77882-6-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210119212739.77882-6-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 24 Jan 2021 03:10:50 -0500
Message-ID: <CAPig+cRBDSWCmrV+6w0gXaSH+xWEX1354NhfyjhCouDdsfEAGA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] worktree: teach `list --porcelain` to annotate
 locked worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 4:28 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> [...]
> Teach "list --porcelain" to do the same and add a "locked" attribute
> followed by its reason, thus making both default and porcelain format
> consistent. If the locked reason is not available then only "locked"
> is shown.
> [...]
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -72,6 +72,36 @@ test_expect_success '"list" all worktrees with locked annotation' '
> +test_expect_success '"list" all worktrees --porcelain with locked' '
> +       test_when_finished "rm -rf locked1 locked2 unlocked out actual expect && git worktree prune" &&
> +       echo "locked" >expect &&
> +       echo "locked with reason" >>expect &&
> +       git worktree add --detach locked1 &&
> +       git worktree add --detach locked2 &&
> +       # unlocked worktree should not be annotated with "locked"
> +       git worktree add --detach unlocked &&
> +       git worktree lock locked1 &&
> +       git worktree lock locked2 --reason "with reason" &&
> +       test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&

There's a minor problem here. If the second `git worktree lock`
command fails, test_when_finished() will never be invoked, which means
that the first lock won't get cleaned up, thus the worktree won't get
pruned. To fix, you'd want:

    git worktree lock locked1 &&
    test_when_finished "git worktree unlock locked1" &&
    git worktree lock locked2 --reason "with reason" &&
    test_when_finished "git worktree unlock locked2" &&

> +       git worktree list --porcelain >out &&
> +       grep "^locked" out >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success '"list" all worktrees --porcelain with locked reason newline escaped' '
> +       test_when_finished "rm -rf locked_lf locked_crlf out actual expect && git worktree prune" &&
> +       printf "locked \"locked\\\\r\\\\nreason\"\n" >expect &&
> +       printf "locked \"locked\\\\nreason\"\n" >>expect &&
> +       git worktree add --detach locked_lf &&
> +       git worktree add --detach locked_crlf &&
> +       git worktree lock locked_lf --reason "$(printf "locked\nreason")" &&
> +       git worktree lock locked_crlf --reason "$(printf "locked\r\nreason")" &&
> +       test_when_finished "git worktree unlock locked_lf && git worktree unlock locked_crlf" &&

Same issue as above.

> +       git worktree list --porcelain >out &&
> +       grep "^locked" out >actual &&
> +       test_cmp expect actual
> +'
