Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FADDC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhK3OSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:18:35 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:36789 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbhK3OSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:18:34 -0500
Received: by mail-pg1-f178.google.com with SMTP id 137so12818107pgg.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7iBhN+QrJrDuLWplSRFS5hEBxSJiGuBUod4TWH1vHA=;
        b=1kAqmCmWUUckOHLVgldlQVLnmQqDlNW762MV7VP2y+VN12dgwqmJnvp69Yttt4f62d
         jhnOFUj/zUvuf9oraWodOW2D5jKqYbA/chvzlC9OYUg6fIKxKk5DQitlVEGzqebmIVnk
         u0Yl2boQhbNEQEhrvvMqwORoH7c+2b3az/Czbx9rl2JottKpHkFj/wxTCEUraQxrJYx4
         vQBgcTt3B3oiCy0UJ4GyO2Wl6G1Mzi9t0LHfFpYe39DluYfnAyDr5GGe5Dwmfd7rcITB
         324ELN1lgsY/44kPoRWV1KF+KX3oKUWfurFluF0V+wL3CE6Uys/BDEx2PbMxkIDfiCRZ
         ew6w==
X-Gm-Message-State: AOAM530tzZRGel+2yykaOYSXhkyq8zJ3LGcQQf3lTRTp+KLQSz7XspyV
        NxJUi8DsmPFYR3mh/Fy5lmSsa8skDsuI/njy9Dw=
X-Google-Smtp-Source: ABdhPJwMcc3GswMLjm/Of/mobH0AWn0lZfRDoBvadRvrJt1kDOOVpZV/keWcWEBFqox181BHlJ5mmJ0/A8co5Grub7E=
X-Received: by 2002:a65:4d4b:: with SMTP id j11mr11508668pgt.181.1638281715526;
 Tue, 30 Nov 2021 06:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <xmqqtufu2pll.fsf@gitster.g> <YaXPUe9Sz3JBlzYL@coredump.intra.peff.net>
In-Reply-To: <YaXPUe9Sz3JBlzYL@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Nov 2021 09:15:04 -0500
Message-ID: <CAPig+cT4+i-R74Lnt9RgkXkDVqx5nThqEMvKG05SP6iRSSsm2w@mail.gmail.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 2:14 AM Jeff King <peff@peff.net> wrote:
>   - flushing causes us to block. This implies our stdout is connected to
>     a pipe or socket, and the other side is not expecting to read. A
>     plausible case here is a client sending us a big input which we find
>     to be bogus (maybe index-pack checking an incoming pack). We call
>     die() to complain about the input, but the client is still writing.
>     In the current code, we'd write out our error and then exit; the
>     client would get SIGPIPE or a write() error and abort. But with a
>     flush here, we could block writing back to the client, and now we're
>     in a deadlock; they are trying to write to us but we are no longer
>     reading, and we are blocked trying to get out a little bit of
>     irrelevant stdout data.
>
> Of the two, the deadlock case worries me more, just because it would be
> quiet subtle and racy. As I said, I think we may be OK, but my reasoning
> there is pretty hand-wavy.

Flushing stdout only if it is attached to a terminal:

    if (isatty(1))
        fflush(stdout);

should address this potential-deadlock concern, I think(?). It's
rather ugly, though, and entering the realm of
too-much-special-casing; it feels like it has the potential of heading
down a rabbit hole where we find more cases which need to be handled
specially.
