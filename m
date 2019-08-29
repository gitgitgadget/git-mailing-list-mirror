Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760C51F461
	for <e@80x24.org>; Thu, 29 Aug 2019 22:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfH2Wpg (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 18:45:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38917 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfH2Wpf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 18:45:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id n2so4018825wmk.4
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 15:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPlhl2EKph2K8pobKPwfApjpXZuToXzeNtDDvYIJ0d0=;
        b=ZueeqEt4gui6HTfaXYatGu0Wp82n0CbAz4RHgpjQ7eVqFnCoYpFPa0AhoyLJctlFUZ
         K7j7gAHbaIWBBKJewX9IeIlPNLbFo6BmHhwPrjJ11Rs5hHgMLxVYeHaiJsL6sMucRUOx
         uAQ6+5Xp2Ov8gQsj4xYwgFcrM0+0T21r95LDdzr3Pd90J81JWbA2KVy9n9NXhcyjhhZI
         1MpvNax4qCZdlvVvSNSh/tjD6O0KRdywDo+YqtGtxCR7lHuaeAY8j+VI7JY6s0hniVtQ
         uXDj9Oy1PWU4kjYClp/xanX4NWcL6h4ZrVFF7DdSIz3qWNxeBnjDVA0+CM2ajzBHHMzP
         wOiQ==
X-Gm-Message-State: APjAAAUrZ1tCfLw+68yhlXOmKAgEDYd/DDCnGWpfVQGcszDrY0YrRlAX
        OVEaDZ4BKKEpVrwvvhZzMXNBdGGkdsUtZA8hDoA=
X-Google-Smtp-Source: APXvYqzfQiahXQNIk4HwLYsoMVFxnijBZ8YezpmdcY++7JwONNw2+2NkBMtG8xqD1teuenMPp4AadHXoOVCeO40oEKA=
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr13891173wmh.129.1567118732787;
 Thu, 29 Aug 2019 15:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190829223811.12072-1-jon@jonsimons.org> <20190829223811.12072-2-jon@jonsimons.org>
In-Reply-To: <20190829223811.12072-2-jon@jonsimons.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Aug 2019 18:45:21 -0400
Message-ID: <CAPig+cQDPsXvOYa3HYo_cYeVq4PhJE_2RGw9n+92=t3BA0-yaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] list-objects-filter: only parse sparse OID when 'have_git_dir'
To:     Jon Simons <jon@jonsimons.org>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 6:38 PM Jon Simons <jon@jonsimons.org> wrote:
> Fix a bug in partial cloning with sparse filters by ensuring to check
> for 'have_git_dir' before attempting to resolve the sparse filter OID.
> [...]
> Signed-off-by: Jon Simons <jon@jonsimons.org>
> ---
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> @@ -241,6 +241,27 @@ test_expect_success 'fetch what is specified on CLI even if already promised' '
> +test_expect_success 'setup src repo for sparse filter' '
> +       git init sparse-src &&
> +       git -C sparse-src config --local uploadpack.allowfilter 1 &&
> +       git -C sparse-src config --local uploadpack.allowanysha1inwant 1 &&
> +       for n in 1 2 3 4
> +       do
> +               test_commit -C sparse-src "this-is-file-$n" file.$n.txt || return 1
> +       done &&
> +       test_write_lines /file1.txt /file3.txt >sparse-src/odd-files &&
> +       test_write_lines /file2.txt /file4.txt >sparse-src/even-files &&
> +       test_write_lines /* >sparse-src/all-files &&

Hmm, does this work correctly? I would expect the /* to expand to all
names at the root of your filesystem, which isn't what you want. You
want the literal string "/*", which means you should quote it (with
double quotes inside the test body). I'd also suggest using the simple
'echo' for this one as you did in v1 since it's more obvious that
you're writing just a single line to the file, whereas using
test_write_lines() has the potential to confuses readers.

> +       git -C sparse-src add odd-files even-files all-files &&
> +       git -C sparse-src commit -m "some sparse checkout files"
> +'
