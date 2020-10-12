Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD740C43457
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 02:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873052074A
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 02:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgJLCYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 22:24:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41763 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJLCYc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 22:24:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id l24so15295953edj.8
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 19:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyS2fTBPz7H/XCu3dJVFDjdmWVsXZT1IS2vZ5d/x6T8=;
        b=EWTWLIgjNuKfgdbT9W1cKRckB1WuhOfbuSKUx7m8hiyo8HmNMCfFztOJ+52pWha264
         /af+iuKK2LxYi4FIdSal9zAzWhoBJ2HFptEz1d4dHuFbo7SRWI2qmUlhpv92qa1oLRw3
         8nwIJSEb+mUT+W9wXetr4E4KHnaOC8lxEOChMx/PKuwcoR3cOpW77YS/Q0Ur78BOM4KI
         RPmwVnMTPRRhcY1EpGfhcrRGB5p08mRGaecT5C2O1jdGk6g4n8dth2Yf4ezrpw/Vcq/y
         JrQGBgcbt6RC1zZzIvo85JattmVAymP3AEwa0BCa+ADvA9gKLImAb7l7sIVykikF/st9
         FcpA==
X-Gm-Message-State: AOAM533gItDALFRbDwOChIZUapy5C8pGJ4yrFVyOkfryUkVvvzD+eARd
        lKX3KTfuzrQveilhOJpj5rXpiDez4d4tHU1hJT4=
X-Google-Smtp-Source: ABdhPJz3FFu/LL1paAuii58NqUXwVoNU58MxoZ5jgVOY5FhiAfqSkY7PUJqfaPDY/ogujcDPyFbPOYspgCbw+p7WWSY=
X-Received: by 2002:aa7:c746:: with SMTP id c6mr11731304eds.221.1602469470281;
 Sun, 11 Oct 2020 19:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201010185521.23032-1-rafaeloliveira.cs@gmail.com>
 <20201011101152.5291-1-rafaeloliveira.cs@gmail.com> <20201011101152.5291-2-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20201011101152.5291-2-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 11 Oct 2020 22:24:19 -0400
Message-ID: <CAPig+cS8hvX4GCsnfLBnQ4Q_AkUad=bw7rjVcaOqSEqcLZvx8w@mail.gmail.com>
Subject: Re: [PATCH v3] worktree: teach `list` to annotate locked worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 11, 2020 at 6:12 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Teach "git worktree list" to append "locked" to its output.
>
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -97,7 +97,8 @@ list::
>  followed by each of the linked working trees.  The output details include
>  whether the working tree is bare, the revision currently checked out, and the

Nit: I'd probably drop the "and" just before the end of this line...

> -branch currently checked out (or "detached HEAD" if none).
> +branch currently checked out (or "detached HEAD" if none), and "locked" if
> +the worktree is locked.

... which would leave just the one "and" here. However, this is minor
and almost certainly not worth a re-roll.

> +test_expect_success '"list" all worktress with locked annotation' '
> +       test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
> +       git worktree add --detach locked master &&
> +       git worktree add --detach unlocked master &&
> +       git worktree lock locked &&
> +       git worktree list >out &&
> +       grep "/locked  *[0-9a-f].* locked$" out &&
> +       ! grep "/unlocked  *[0-9a-f].* locked$" out
> +'

Looks good. With or without the minor suggested documentation tweak,
consider this patch:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
