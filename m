Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9BF31F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 05:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeGFFjP (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 01:39:15 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41140 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeGFFjO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 01:39:14 -0400
Received: by mail-yw0-f195.google.com with SMTP id q129-v6so989826ywg.8
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 22:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+aSi+MhFNLUX0yeeWtK4/i1I/kLT1IIyI73poxXuqQ=;
        b=NgUZBBbJvlBMwL3Dwqt28LU+75UgxYQ1NvJCa/Er4s1UgLP1D7v6ysTBZPqOLN3AqA
         0ix7Zi3qTJ8p2xY+HU90tzJ4NqSlXUA7rizCL8AZzXU5vY5O7FhCwdcdvxAiMLJC39Lt
         IETcl71lXQmcO5By90cYHirOA/ld1eJ2CEXXuBTSihOExORnYguYgzHVDSkLPfPWz0rb
         iNtVOUh0J807b/Hk8ma3zkaHAFV19OYu2pzG5PFTAsmPipo2mq5lRGR4YXFl+VpmHGnQ
         D+3wiWtofUN9BNR0BM4alhR0qLQCTWEhNVGwjX/M3uByV4DRi2zIPt6BcdFw9WY0XXOy
         0VTQ==
X-Gm-Message-State: APt69E2Ff44cI/PmbCvTSBFlUv1hOZVgNILjt5zaYJxv8R+dP1WwGyec
        /VvNYuuX/aUwozmMMcqaq7lFqX9fbgiWO25IkEs=
X-Google-Smtp-Source: AAOMgpdkIZsHtiyhhAwatwEfbNoEaqByNyr7dMufQUvdv6jhSkY0Wx30Y5jDwuH3enAKa+HQhW5u6HbdGaJtI1pL8Go=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr4101226ywr.16.1530855553446;
 Thu, 05 Jul 2018 22:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-17-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-17-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 01:39:02 -0400
Message-ID: <CAPig+cTJuvOjyzkmAj5axAkS3q1UyeV03jQk6-oB==KyzbEK_w@mail.gmail.com>
Subject: Re: [PATCH v3 16/24] config: create core.multiPackIndex setting
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
> The core.multiPackIndex config setting controls the multi-pack-
> index (MIDX) feature. If false, the setting will disable all reads
> from the multi-pack-index file.
>
> Add comparison commands in t5319-multi-pack-index.sh to check
> typical Git behavior remains the same as the config setting is turned
> on and off. This currently includes 'git rev-list' and 'git log'
> commands to trigger several object database reads.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/cache.h b/cache.h
> @@ -814,6 +814,7 @@ extern char *git_replace_ref_base;
> +extern int core_multi_pack_index;
> diff --git a/config.c b/config.c
> @@ -1313,6 +1313,11 @@ static int git_default_core_config(const char *var, const char *value)
> +       if (!strcmp(var, "core.multipackindex")) {
> +               core_multi_pack_index = git_config_bool(var, value);
> +               return 0;
> +       }

This is a rather unusual commit. This new configuration is assigned,
but it's never actually consulted, which means that it's impossible
for it to have any impact on functionality, yet tests are being added
to check whether it _did_ have any impact on functionality. Confusing.

Patch 17 does consult 'core_multi_pack_index', so it's only at that
point that it could have any impact. This situation would be less
confusing if you swapped patches 16 and 17 (and, of course, move the
declaration of 'core_multi_pack_index' to patch 17 with a reasonable
default value).

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> @@ -61,12 +63,42 @@ test_expect_success 'write midx with one v1 pack' '
> +midx_git_two_modes() {
> +       git -c core.multiPackIndex=false $1 >expect &&
> +       git -c core.multiPackIndex=true $1 >actual &&
> +       test_cmp expect actual
> +}
> +
> +compare_results_with_midx() {
> +       MSG=$1
> +       test_expect_success "check normal git operations: $MSG" '
> +               midx_git_two_modes "rev-list --objects --all" &&
> +               midx_git_two_modes "log --raw"
> +       '
> +}

Here, you define midx_git_two_modes() and compare_results_with_midx()...

>  test_expect_success 'write midx with one v2 pack' '
> -       git pack-objects --index-version=2,0x40 pack/test <obj-list &&
> -       git multi-pack-index --object-dir=. write &&
> -       midx_read_expect 1 17 4 .
> +       git pack-objects --index-version=2,0x40 $objdir/pack/test <obj-list &&
> +       git multi-pack-index --object-dir=$objdir write &&
> +       midx_read_expect 1 17 4 $objdir
>  '
>
> +midx_git_two_modes() {
> +       git -c core.multiPackIndex=false $1 >expect &&
> +       git -c core.multiPackIndex=true $1 >actual &&
> +       test_cmp expect actual
> +}
> +
> +compare_results_with_midx() {
> +       MSG=$1
> +       test_expect_success "check normal git operations: $MSG" '
> +               midx_git_two_modes "rev-list --objects --all" &&
> +               midx_git_two_modes "log --raw"
> +       '
> +}

... and here you define both functions again.

> +
> +compare_results_with_midx "one v2 pack"
