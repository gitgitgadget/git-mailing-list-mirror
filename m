Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72BFC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC19C6113E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFUUA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:00:28 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:34504 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhFUUA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:00:28 -0400
Received: by mail-ed1-f47.google.com with SMTP id i5so3170734eds.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GySn5e3aJsrLPxomo49mo2aIeejMGmXkhCqMb7nAXw=;
        b=ShDcxcZPUABTqncHENyfmlJZNgwEAP7gD1aa9k/BtRas48Y+1IdwHEk7HW1lllPBID
         mWV1W9RS9bGZukscCrwFOLaxCh5roA7o6w1wU1TTQQk2IEABlOVUcXeQJl0xjQkbIEHa
         /c3jr6nV3AkkzW5YxSbNTq8CJZBEvBxtCMV5s6D/cc3wls9sTe6SnkGXIfjx/vcYYSyF
         MU29DOIwHcTL34agSAdAuyKEhHKY2ACU/+L4OLTv1YYN7MMMp+y8yqkKqmLIPdYpX6+G
         B3o/2MOdOGtevPIz3y1xBZYoD867+7p5/SP7d0yYEDEJjmQzPRpGPcpMAWNiu7wQwRU9
         JsyQ==
X-Gm-Message-State: AOAM531YSfyg6KWgdWguSUcpom5OoSXQ15RuqeQ/pRh3xHPF7KP5RBYI
        i0u6XM1aqqk1IH5FfwgRPqqI1guW9wLvfWfe7uA=
X-Google-Smtp-Source: ABdhPJw1YbiM2TRkP3FXx0m6eAjCpSjt76xVzvLchLW5KtQdogEpCXENA+wjDwhUx4+5NmBvqjf2o8Ixklq+oM9QvAo=
X-Received: by 2002:a50:fd1a:: with SMTP id i26mr74890eds.181.1624305491761;
 Mon, 21 Jun 2021 12:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621190837.9487-1-kaartic.sivaraam@gmail.com> <20210621190837.9487-2-kaartic.sivaraam@gmail.com>
In-Reply-To: <20210621190837.9487-2-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Jun 2021 15:58:00 -0400
Message-ID: <CAPig+cT66BT7fCfHBJM25D1SBVKAwRpSh+SAaR8YmqZX+7epvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule--helper: remove an unreachable call to usage_with_options
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 3:09 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> The code path in question calls `error` in a particular case.
> But, `error` never returns as it exits directly. This makes
> the call to `usage_with_options` that follows the `error` call
> unreachable.

error() returns -1; you will commonly see:

    if (check_something())
        return error(...);

> So, remove the unreachable `usage_with_options` call.
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -1637,8 +1637,6 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
>         if (all && argc) {
>                 error("pathspec and --all are incompatible");
> -               usage_with_options(git_submodule_helper_usage,
> -                                  module_deinit_options);
>         }

usage_with_options(), on the other hand, exits directly.
