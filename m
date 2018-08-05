Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7761F597
	for <e@80x24.org>; Sun,  5 Aug 2018 10:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeHEMSQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 08:18:16 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:37313 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeHEMSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 08:18:16 -0400
Received: by mail-yb0-f194.google.com with SMTP id r3-v6so4256526ybo.4
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 03:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87t+PaoGZFQ9Pl0DZ38/wFBuEyBxU9Xw0pktY+q1ph8=;
        b=jlANbyEz6bzI/vpMONYg9nUQLWsqEdGjNKKN8ddCI4D1BuCEoykn5IFwu/Ln+n9TTV
         EAwvWQynXzupVaZIeDdGswI7CdWCl0+xwiGFYSBQAb6oQ8G5Z97RxkfDsPJYvwwDTUyo
         i7U+y0zOVfMmHqXISLPVbi/edicINT9nGDEeywIj8OaFZusNg2q/Jwqp1bCyGIYx8vQS
         MLJYMGJ/ww4vvq+S2yk7vzaRG13JZTo8fK/FkTwX8pUxMZ9mHdc6n2iUU5rfX855C6QC
         AZWZX7WhmubWZbMRgreec1L4jX04YuDxkVbvY65ZAAxNOyUjVYyjMs3rDG7qfU1ZPZa4
         G+zg==
X-Gm-Message-State: AOUpUlGKv3PAxY5X5kkOfKjELZfCuqvgnuluZ+tgOqLEAwsW/y4wORxk
        cw940a4tRyGYSfiVT3c0dZf8lfvp1hzqELAflo0=
X-Google-Smtp-Source: AAOMgpe6Q0Toj8miHk+4t94tM0VWx2frVJNw1U2hXkVx8kT5Vw4yqAxDVt8OO6K8LvSu6pJbDhmvaaYfwQrNFiunM/0=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr5504077yba.263.1533464052721;
 Sun, 05 Aug 2018 03:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.15.git.gitgitgadget@gmail.com> <7f92d92154143127734a638e41e064adce46a2e2.1533421100.git.gitgitgadget@gmail.com>
In-Reply-To: <7f92d92154143127734a638e41e064adce46a2e2.1533421100.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Aug 2018 06:14:01 -0400
Message-ID: <CAPig+cRWcFVbA76_HT2iVD16bsUmbWdCgk_07rmiGneM5czdOQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] line-log: adjust start/end of ranges individually
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
> When traversing commits and adjusting the ranges, things can get really
> tricky. For example, when the line range of interest encloses several
> hunks of a commit, the line range can actually shrink.
>
> Currently, range_set_shift_diff() does not anticipate that scenario and
> blindly adjusts start and end by the same offset ("shift" the range).
> [...]
> Let's fix this by adjusting the start and the end offsets individually.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/line-log.c b/line-log.c
> @@ -438,7 +438,13 @@ static void range_set_shift_diff(struct range_set *out,
>                                 - (target[j].end-target[j].start);
>                         j++;
>                 }
> -               range_set_append(out, src[i].start+offset, src[i].end+offset);
> +               start_offset = offset;
> +               while (j < diff->target.nr && src[i].end > target[j].end) {
> +                       offset += (parent[j].end-parent[j].start)
> +                               - (target[j].end-target[j].start);
> +                       j++;
> +               }
> +               range_set_append(out, src[i].start+start_offset, src[i].end+offset);

I'm still trying to wrap my head around the original code, so I'm not
even at the point of being able to say if this fix is correct. What
happens if the "start_offset" loop consumes all of 'j' before it even
gets to the new loop? Why does the new loop use '>' whereas the
existing uses '>='?

Having said that, a much easier fix is to use
range_set_append_unsafe() here, and then at the bottom of the loop,
invoke 'sort_and_merge_range_set(out)' to restore range-set invariants
and ensure that neighboring ranges are coalesced. Not only does that
resolve the crash and other weird behavior, but it means you don't
have to add a special-case to range_set_append(), thus the fix becomes
simpler overall.

Aside from simplicity, I think the suggested use of
range_set_append_unsafe() and sort_and_merge_range_set() _is_ the
correct fix anyhow because this code isn't taking care to ensure that
the range, after applying 'offset', doesn't abut or overlap with an
earlier range, and sort_and_merge_range_set() is meant to be used
exactly in cases like this when invariants may be broken.

So, while the suggested fix is simpler and "better" and fixes the
crash, that doesn't necessarily mean that the values computed here are
actually correct. As noted, I'm still trying to grok the computation
of these values, but that's a separate issue from the crash itself.
