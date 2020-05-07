Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A18C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A998A20661
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgEGWNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 18:13:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37087 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGWNf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 18:13:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so8299791wrx.4
        for <git@vger.kernel.org>; Thu, 07 May 2020 15:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAgNNtS+S0I7tlVQLPsw/qqjbn8OjLx6FIfKT/M7jZ8=;
        b=IfVOyA1cuxqPit4UVUkGm7y312PVa9Z9GkQYZjrN4IIP1e1hTrTXmCQ4p9oIz3avNm
         vQZAWIZWc8Ez1J94men74DGQHbphxaM3d01gXAZNytPFAuQst5b8MoB7VcBmraQ6CtnI
         kNvxfwU57SwFKQCllSp5hnZussBBGE0wGR9Mw8k3JjhPSqgw9zY4TFbDXjPcmnwo2y+I
         6rDZQHDhjPOK3UIkUtzWqOL+QSvo0c/ZLfbI19sehIJBiW2cC3h71RB/QJGQbymvS/V6
         RGW9hZ+RAuXtfcuZ6Nvys6W3BXhBY+PRaGxD9HeV1sBqGHq9NQE+ZIszft+iSt6gc3pf
         W5MQ==
X-Gm-Message-State: AGi0PuYi2H8o/WB/3uHX9kGLSmq4rLpQbVM7AESLgsXOHEoNzCb+vGHN
        Ndr3dqCUkWlrDVhFIyo74/2mxtyg6wij9TRk0jM=
X-Google-Smtp-Source: APiQypJ/vy5wRlTSxgd7+s9HwJDc19jWOqFRYa11vBvG7h8kcHIqHrgKfEcXhpS+oGZ+7T/bf1dZIxYQcza17/LfcQI=
X-Received: by 2002:a5d:6401:: with SMTP id z1mr10428165wru.226.1588889613597;
 Thu, 07 May 2020 15:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
In-Reply-To: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 May 2020 18:13:22 -0400
Message-ID: <CAPig+cTbvmGPjR85RupL4DZjzCwjeHxBqnbPg1+8Gd-Xmzf7CA@mail.gmail.com>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
To:     Christopher Warrington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christopher Warrington <chwarr@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 5:29 PM Christopher Warrington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Sometimes bisect logs have CRLF newlines. (E.g., if they've been edited
> on a Windows machine and their LF-only nature wasn't preserved.)
> Previously, such log files would cause odd failures deep in the guts of
> git bisect, like "?? what are you talking about?" or "couldn't get the
> oid of the rev '...?'" (notice the trailing ?) as each line's CR ends up
> part of the final value read from the log.
>
> This commit fixes that by stripping CRs from the log before further
> processing.
> [...]
> Signed-off-by: Christopher Warrington <chwarr@microsoft.com>
> ---
> diff --git a/git-bisect.sh b/git-bisect.sh
> @@ -209,7 +209,11 @@ bisect_replay () {
> -       while read git bisect command rev
> +
> +       # We remove any CR in the input to handle bisect log files that have
> +       # CRLF line endings. The assumption is that CR within bisect
> +       # commands also don't matter.
> +       tr -d '\r' <"$file" | while read git bisect command rev

Due to portability concerns, I worry about using '\r' here. Indeed
this would be its first use in this codebase. On the other hand,
'\015' is heavily used (at least in the tests), so that would likely
be a safer alternative.

> @@ -231,7 +235,9 @@ bisect_replay () {
> -       done <"$file"
> +       done
> +
> +       get_terms
>         bisect_auto_next

Why the new get_terms() invocation? Is that leftover debugging gunk?

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> @@ -792,6 +792,13 @@ test_expect_success 'bisect replay with old and new' '
> +test_expect_success 'bisect replay with CRLF log' '
> +       awk 1 "ORS=\\r\\n" <log_to_replay.txt >log_to_replay_crlf.txt &&

This would be the first use of awk's ORS in this codebase, which may
invite portability problems. In this codebase, the more typical way to
do this is via a combination of 'sed' and 'tr', however, even better
would be to take advantage of append_cr() from
t/test-lib-functions.sh:

    appenc_cr <log_to_replay.txt >log_to_replay_crlf.txt &&

> +       git bisect replay log_to_replay_crlf.txt >bisect_result_crlf &&
> +       grep "$HASH2 is the first new commit" bisect_result_crlf &&
> +       git bisect reset
> +'
