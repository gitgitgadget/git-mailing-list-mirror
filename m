Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD74EC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94B661601
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhA0XM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:12:57 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:41411 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhA0XIu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 18:08:50 -0500
Received: by mail-ej1-f48.google.com with SMTP id g12so5021235ejf.8
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 15:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lkadsa0sPeBE/P/3BI54U/XxhTKrJs4zEGoKi+I7cV8=;
        b=koJcZOQ9PnCGrPrfDYi4q6RA+2SFZH/Tv9jkr8cyK/w16lPjjKn6YnkeHW+bWwNF2n
         4GcHeqKB9jO858Yc5u/yPys5IGGvlx/8wZCiNpKpjoHJoqu1hXlGgUgWEWn374zuWPkX
         g8TnX3QxjZY6kzf9kcjmIiZsIpMHw47rHEtvOgm3Y7REGoV5scyBzHVwxbYl5cj6cgWM
         Dy2mA3u2S2UZ9/FOx23qZTkq7fio+iwsSdRNKmFXKB9USVEXHIQI9NbTIIzDIMRy/21b
         1ref6xp1lWVBVBH+kCnrhZvDYbWuGSCY5G7w3cfYIFMOpuELZcj6YSgxEJkEURY7qUdC
         bZ9g==
X-Gm-Message-State: AOAM530BVdbrmgcT3gbYjGdO2XoJwO4vJnlJ47HqGYky1zCZiKje3MHW
        Zd8VOTgNEoqQfBhbNjIRct+SRviH9SJtfzIMy1tEwIJ0TBsCjg==
X-Google-Smtp-Source: ABdhPJz+Kt0lT+tDoHo1gSrY3JNw61vr4JiRn5ZpYug/2kSIXzuiLLGU36UFEQfkygPkQB7GV2y3GT+WE1Ji/xNmBjU=
X-Received: by 2002:a17:906:2617:: with SMTP id h23mr8580419ejc.168.1611788888850;
 Wed, 27 Jan 2021 15:08:08 -0800 (PST)
MIME-Version: 1.0
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net> <YBHmY7vNxu2hqOa/@coredump.intra.peff.net>
In-Reply-To: <YBHmY7vNxu2hqOa/@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Jan 2021 18:07:57 -0500
Message-ID: <CAPig+cQTV6ACiOj+GKoBwj15TZBr5craVPT6dYzzSDfrX9a3YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rev-list: add --disk-usage option for calculating
 disk usage
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 5:20 PM Jeff King <peff@peff.net> wrote:
> This patch implements a --disk-usage option which produces the same
> answer in a fraction of the time. Here are some timings using a clone of
> torvalds/linux:
>
>   [rev-list piped to cat-file, no bitmaps]
>   $ time git rev-list --objects --all |
>     cut -d' ' -f1 |
>     git cat-file --buffer --batch-check='%(objectsize:disk)' |
>     perl -lne '$total += $_; END { print $total }'
>   1455691059
>   real  0m34.336s
>   user  0m46.533s
>   sys   0m2.953s

This example shows the computed size (1455691059)...

> But the real win is with bitmaps. If we use them without the new option:
>
>   [rev-list piped to cat-file, bitmaps]
>   $ time git rev-list --objects --all --use-bitmap-index |
>     cut -d' ' -f1 |
>     git cat-file --batch-check='%(objectsize:disk)' |
>     perl -lne '$total += $_; END { print $total }'
>   real  0m9.954s
>   user  0m11.234s
>   sys   0m8.522s

...however, this example does not (but all the others do). Simple
copy/paste error?

Not worth a re-roll, of course.
