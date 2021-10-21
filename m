Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64089C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3810A61130
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhJUFDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 01:03:13 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:38630 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUFDM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 01:03:12 -0400
Received: by mail-ed1-f44.google.com with SMTP id r4so101060edi.5
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 22:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5BecTo8a93sO8fXbR6s1Cmxun1Lwiv8TwArVXGrv7g=;
        b=B6fOcTf8tb1KfPqbuXI8VprmYbnVXwvm9D0c1iOCm/2ohFtpI54J8dqrlZmKt0coQk
         MR+CXlFtELM/LhheHoc3zc5PFDTsj5/+cj/3DtXerAFUWGwM504ARIf4h4kh16ZpxYja
         +407BMo26s0G5aNxr70VEiZlgllCIoMIAoufNAFutsCYS2XYXwtYaaTW9OsEsGjmJMA4
         vKWsJeAJLzIqcsK4zQS5D9JisVHvrmOroYimAVheKm8FcBRlr494zVkcCwI/SpjbF1QS
         x7OIEaL49o6Gsmt6kqpU8HeakMSBS+X3BdeddjtE7YhOXdPtsSWmIBxJLTvSrS9FkA8M
         nMQw==
X-Gm-Message-State: AOAM532hVQ9qXkTkL6V/6ZZL4x22X6RGkb9QBMGJQoE8fZE6VfOIijm6
        kYRYqYx1yAn0FF1gFw/KS0V3AzW6gGzr/Zw+0qo=
X-Google-Smtp-Source: ABdhPJzIdiuk7Ldvt/vwnlvt7clQsEOJGoRIrNnpj2dKfLO7MVKBSw5nxkPMrnGfpNQa/QMZgk8EocqUJFKSi5+HFf0=
X-Received: by 2002:a17:906:480a:: with SMTP id w10mr4690168ejq.262.1634792456471;
 Wed, 20 Oct 2021 22:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634787555.git.me@ttaylorr.com> <b0c79904ab7bdaee7a1bc7a55b0fb26b1f2cf8d3.1634787555.git.me@ttaylorr.com>
In-Reply-To: <b0c79904ab7bdaee7a1bc7a55b0fb26b1f2cf8d3.1634787555.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Oct 2021 01:00:45 -0400
Message-ID: <CAPig+cSnrrT_wELSLbk=Shfu_e_6YM9LpMw2X75-oN0QqOAY3Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] midx.c: don't leak MIDX from verify_midx_file
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 11:39 PM Taylor Blau <me@ttaylorr.com> wrote:
> The function midx.c:verify_midx_file() allocate a MIDX struct by calling
> load_multi_pack_index(). But when cleaning up, it calls free() without
> freeing any resources associated with the MIDX.

s/allocate/allocates/

> Call the more appropriate close_midx() which does free those resources,
> which causes t5319.3 to pass when Git is compiled with SANITIZE=leak.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/midx.c b/midx.c
> @@ -1611,7 +1611,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
> -               return verify_midx_error;
> +               goto cleanup;
>         }
> @@ -1689,7 +1689,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>         stop_progress(&progress);
>
> +cleanup:
>         free(pairs);
> +       close_midx(m);
>
>         return verify_midx_error;
>  }

Using the `goto` idiom to ensure cleanup makes perfect sense. For a
few reasons[*], I did spend a some moments wondering if the cognitive
load might be a bit lower by instead adding two close_midx() calls --
one at the early return and one just before the normal return --
rather than using a `goto`, but it's so subjective that it's not worth
worrying about.

FOOTNOTES

[*] First, unlike most cases in which the `goto` jumps over relatively
short blocks of code, the distance in this case between `goto` and the
new label is significant and it's not easy to see at a glance what is
being skipped and how important it might be. Second, `pairs` is still
NULL at the point of the `goto`; I spent extra time checking and
double-checking what free(pairs) was doing in this instance. Finally,
there are enough start/stop-progress calls in this function that it
requires extra mental effort to determine that this `goto` is indeed
safe (at least for the present).
