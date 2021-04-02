Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A928BC433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D5C60C40
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhDBWdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 18:33:11 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36436 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhDBWdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 18:33:10 -0400
Received: by mail-ed1-f51.google.com with SMTP id o19so6715253edc.3
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 15:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVg4kJV1j+bq44xgLE9FHpuH0MjcUD3uX2eFZip2zMQ=;
        b=s/7z0lrHT5GgRAiK2gr4gbaFJd1MS2xqW3DuBkiVjndQuHHf8/lc2201asCz1DsqyF
         I0KC+YgQN7A+BMOrSOwU6WISeFnskBMAtfF1xOibwQutEPfDkn3UTnc6ncdtL36pIton
         ETeod5Ee2ORe16plf5F7tbKYzHNaduEJVl/Qka/99rf7NKwNf2E7K41v+knrcfyifupD
         6/I1ZeZIJBmAqz0PdW6YfbdAsSWMoZZHlZH4BKr/AwdKCIlXzccUI/d/ly6u6akmMb3U
         6gZej6bfLb6CZkN/AAE8SDQnni91U9wsbuc2Yd2Grs+cocmL8u8yz8PW2QSuVfvTIxiu
         1eZQ==
X-Gm-Message-State: AOAM533gM6naK9Xndv/O9FChPQzhdcYVFhh8MR7DUztdU0raSt4r6fAK
        l+unq80k9eVyA4dWvtOVfBsVxzQoai6zvq5UuXo=
X-Google-Smtp-Source: ABdhPJx3xgzPfXibFYsoFOyvIRSYhy6sG+eNNwsbUFZjrYTV4o6FbY1vw0l4NKLo9kD5zW+tmnYy+mj7h4wEHt49aXg=
X-Received: by 2002:aa7:da14:: with SMTP id r20mr17553826eds.181.1617402787775;
 Fri, 02 Apr 2021 15:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com> <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com> <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
In-Reply-To: <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Apr 2021 18:32:56 -0400
Message-ID: <CAPig+cRxjLObLvF9kUAuftCxQ+iiFEisagDBWpAAPwdVMUATKQ@mail.gmail.com>
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch refspec?
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 2, 2021 at 4:43 PM Derrick Stolee <stolee@gmail.com> wrote:
> I have a branch available [1], but I'm seeing some failures only
> on FreeBSD [2] and I can't understand why that platform is failing
> this test. The current version (as of this writing) does not do
> the substring replacement technique, and hence it just gives up
> on exact matches. I will try the substring approach as an
> alternative and see where that gets me.
>
> [1] https://github.com/gitgitgadget/git/pull/924
> [2] https://github.com/gitgitgadget/git/pull/924/checks?check_run_id=2256079534

The "+" in patterns such as `+refs/heads/\\*:refs/prefetch...` is what
is throwing it off. FreeBSD `grep` doesn't seem to like it, though
it's not clear why. Escaping it the same way as you escaped "*"
doesn't make it work. Replacing "+" with catchall "." does work, so
that's one way to fix it.

However, all the escaping you need to do in these refspec patterns to
pass them to `grep` is ugly. A much better solution may be to change
the `grep` in test-lib-functions.sh:test_subcommand() to `grep -F` to
force it to match literally. That way, you can drop all the backslash
escaping, including those in front of "[" and "]". A cursory audit of
callers test_subcommand() seems to indicate that none of them pass
regex patterns, so using `-F` is probably safe and a good idea.

By the way, the `coccinelle` check is also "failing", correctly
suggesting that you change:

    strbuf_addf(&replace, ":refs/prefetch/");

to:

    strbuf_addstr(&replace, ":refs/prefetch/");

in `builtin/gc.c`.
