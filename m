Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337CC1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 10:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeHEMrD (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 08:47:03 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39967 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeHEMrD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 08:47:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id z143-v6so2592000ywa.7
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 03:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJewKSb1K5uvm1xfGmXoYCWNFBgj6R8gLq6LdMrInqI=;
        b=poEdvLmWZjPykfLiVhboWptzngF6EvWwWwyQLXKSRiiE4GdpKwqh2ZWb0o+ZSWN15N
         sne8MSReGI4SyDZx6cATD0sDwCsxcK88HnyEgpyNDMksLNzz5CB8T6DfR4z/q3p6jsn+
         cTQ7OO6H1KrcDRQrO2L+3DSolWYaD31xuIl+5sKs11ZU99EGATB/esNVgtifFuBubqei
         NuqzhFOg7V48+ex2YRqxMU6RPmt9pH5g6zf9tMhY6Dir4jzlbxObfFepPWyUnsV7gVEu
         WnX1nKRrgarDLmKqjO9+kHztXnQR2xKfx+4LSjFF9f4ZzwUGt8h9YawpnDwciUEkSXT/
         C0LQ==
X-Gm-Message-State: AOUpUlGk934nipu974ORmsyaQ2BGWAQIS7cql/ZHXl48H4R60QeLgoGe
        vN48lJiLBUjr/yalrz1K9NyID7UnZjo/DpKhUaw=
X-Google-Smtp-Source: AAOMgpcWos9rAgDBCkkXoylOQHedyApzkTIhXZLhc6Y4aBKHoOw8AYVJ0EUOdhwumvhFH/DJuVK+bWDzasTKlBlRy5Y=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr5799460ywk.418.1533465775177;
 Sun, 05 Aug 2018 03:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.15.git.gitgitgadget@gmail.com> <faf35214f0f339b792a30a3bd013056217d9a2c1.1533421101.git.gitgitgadget@gmail.com>
In-Reply-To: <faf35214f0f339b792a30a3bd013056217d9a2c1.1533421101.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Aug 2018 06:42:44 -0400
Message-ID: <CAPig+cRrC2mf1uuQ1C4Ue4OMZQbgcxXbJ9AXs0y6RSnUrcm7Dg@mail.gmail.com>
Subject: Re: [PATCH 4/4] line-log: convert an assertion to a full BUG() call
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 4, 2018 at 6:18 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The assertion in question really indicates a bug, when triggered, so we
> might just as well use the sanctioned method to report it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/line-log.c b/line-log.c
> @@ -72,7 +72,9 @@ void range_set_append(struct range_set *rs, long a, long b)
> -       assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
> +       if (rs->nr > 0 && rs->ranges[rs->nr-1].end > a)
> +               BUG("append %ld-%ld, after %ld-%ld?!?", a, b,
> +                   rs->ranges[rs->nr-1].start, rs->ranges[rs->nr-1].end);

Although this appears to be a faithful translation of the assert() to
BUG(), as mentioned by Andrei in his review of 3/4, the existing
assert() seems to have an off-by-1 error, which means that the "> a"
here really ought to be ">= a".

Given that this file is full of assert()'s, it doesn't necessarily
make sense to convert only this one, so perhaps the patch should be
dropped (since I'm guessing you don't want to convert the rest of
them).
