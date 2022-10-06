Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CBDC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 22:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiJFWbL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 6 Oct 2022 18:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJFWbK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 18:31:10 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3EC695C
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 15:31:07 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id m14so1696554ilf.12
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 15:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBR51s1BNT1VV6AxJd5A3G0+zZuH+HDisQztjVpjL+Q=;
        b=l9Rp4UKbcOvcriJ1MutSNb7yLZ/QpbpXcjLRsRW1wi4uAYo7UY/hgADJh8LTR4gMR8
         WmeAU4elDUrEgBHDjU87A1yoU7ITzw4YSAZCjWUhiFj3JbzVcI0jY8eKsjKyO4COg0De
         B3Jftz/akAo6pcpsxqugiEYKLhEbniP7G5jSmOaJEQFS+ndrEnNvZdTHoLWxieKIp8C0
         T+aUQorZxexS8NTJ32UwwkGUIQVfSHunf6TJRt3ICGYAq+/QqbRcl43fE5zF5ITbKhbg
         j+heQM9nEWLrUQc2UJ0XcLQDpM0KKeretmWNyWjnjhpEHkLJOyWIze09f5mpqH5391OO
         zscg==
X-Gm-Message-State: ACrzQf3XwtZi8v7poRtE3rxXIE0RNSu5BZlXaJc96KDehLrk9NZWMsdI
        8ICZ+SVsXdA4cUSAn0OPhdk+zhdp39EcpaKrCfs=
X-Google-Smtp-Source: AMsMyM70HnKqtzyBQh+qe9aVJYfg3ntyU7vTBrHM6pV45+1t/k0wNuPXYqpCkj358fUeE9wXAZjySYMNi+QQqSUat78=
X-Received: by 2002:a05:6e02:12c1:b0:2f1:870a:ad64 with SMTP id
 i1-20020a056e0212c100b002f1870aad64mr909627ilm.147.1665095467020; Thu, 06 Oct
 2022 15:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
 <7cee38788a7a3c2c09a238e01c5bd825445f999d.1665085395.git.gitgitgadget@gmail.com>
 <36cd156b-edb2-062c-9422-bf39aad39a6d@web.de>
In-Reply-To: <36cd156b-edb2-062c-9422-bf39aad39a6d@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Oct 2022 18:30:56 -0400
Message-ID: <CAPig+cT7_H6EDU9s1G38QrepACzN2vzCopAn7S=PDb0so_F21A@mail.gmail.com>
Subject: Re: [PATCH 1/2] builtin/merge-file: fix compiler error on MacOS with
 clang 11.0.0
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 6, 2022 at 5:25 PM René Scharfe <l.s.r@web.de> wrote:
> Am 06.10.22 um 21:43 schrieb Jeff Hostetler via GitGitGadget:
> > Add extra set of braces around zero initialization of two array/structure
> > variables to resolve compiler errors/warnings from clang 11.0.0 on MacOS.
> > This is not needed on clang 14.0.
>
> Not sure how the Apple version numbers map to LLVM versions.  I can
> reproduce it with Godbolt's Compiler Explorer with clang 8, but not
> with clang 9 or higher: https://godbolt.org/z/f7f7s9xxz
>
> > builtin/merge-file.c:29:23: error: suggest braces around initialization \
> >                           of subobject [-Werror,-Wmissing-braces]
> >         mmfile_t mmfs[3] = { 0 };
> >                              ^
> >                              {}
>
> {0} is an idiom to zero-initialize any struct, no matter how deeply
> nested.  It's valid C and the compiler warning about it is not helpful.
> Shouldn't we rather silence it with -Wno-missing-braces?

That was indeed Ævar's suggestion in [1]:

    Since this is only a warning, and only a practical issue with
    -Werror I wonder if a config.mak.dev change wouldn't be better,
    i.e. to provide a -Wno-missing-braces for this older clang
    version.

The problem is that Apple seems to invent their version numbers out of
thin air with no relation to reality[2,3], so it may take some effort
to work out suitable "version mapping rules" for config.mak.dev, and
nobody has done it yet.

[1]: https://lore.kernel.org/git/220712.86lesy6cri.gmgdl@evledraar.gmail.com/
[2]: https://lore.kernel.org/git/Ys0hhYjPExuNWynE@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/YQ2LdvwEnZN9LUQn@coredump.intra.peff.net/
