Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7641F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 13:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405965AbfJWNlJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 09:41:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37851 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbfJWNlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 09:41:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id e11so13444720wrv.4
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 06:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QezBoIVLMZlctMZfsI4mBUDO87qNhOm2d3n5pzkf53Q=;
        b=eCHgm+mOa09kFXjyQgplMw1h/DmE/5ZoP2MMH2prektrYRjRhH/erOmbiPzDtdFPUv
         VTlW/eEpfasmSZ4t0dD1qwHd1FxNBEw23uPQvVGwaU9gTTQl5ooP1UQ7KE8UwlmhROxG
         hHSrLmpTNf1DkVS6EQEQGmUY8IK6SowsDJKRB3o+mpvvqJ2IastHT0zu4J342+WSeAfw
         lpqVU/OVpVDwnQ2xkCUximTXmBOYIvYNDoFJxxYbfHxTDyay4s9g+z9hHnNmCyitpVaU
         BdwNPL974UjZ0KjQgwo09QdNojDUBjKxwZzZPISgr0DOdc0ww8dxpsfkfxSBQe3M6LXc
         HNxw==
X-Gm-Message-State: APjAAAUwNH1bp+bHyHTLGTOyYlgn4a8xb8xjdXtxhjBme3mYIHHhjXHe
        jblivB2tWbY520mI4Y04i9wkU2GDP2weeUsBdfk=
X-Google-Smtp-Source: APXvYqwqfhR+FrTj9i2uxCNd5PXDHSbpKeUNGUjx8yrgHYKkPHqUI9rN4YIBJJesZMiLGK4XsQgsJ54AcSN6oRA/RVM=
X-Received: by 2002:adf:f44e:: with SMTP id f14mr8253579wrp.56.1571838067703;
 Wed, 23 Oct 2019 06:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571832176.git.liu.denton@gmail.com> <5feddf15978e77b19d8b3e2e5761e394e0bda3e7.1571832177.git.liu.denton@gmail.com>
In-Reply-To: <5feddf15978e77b19d8b3e2e5761e394e0bda3e7.1571832177.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 23 Oct 2019 09:40:56 -0400
Message-ID: <CAPig+cQF+0mTLgva0YRAJ81Aj2Z_oJ+q4kzezREEyCZuv=2XKQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] t4108: demonstrate bug in apply
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 8:04 AM Denton Liu <liu.denton@gmail.com> wrote:
> Currently, apply does not respect the merge.conflictStyle setting.
> Demonstrate this by making the 'apply with --3way' test case generic and
> extending it to show that the configuration of
> merge.conflictStyle = diff3 causes a breakage.
>
> Change print_sanitized_diff() to also sanitize `|||||||` conflict markers.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> @@ -46,28 +46,42 @@ test_expect_success 'apply without --3way' '
> +test_apply_with_3way () {
> +       status="$1" &&
> +       shift &&
> +       description="$1" &&
> +       shift &&
> +       preamble="$1" &&
> +       shift &&
> +
> +       test_expect_$status "apply with --3way ($description)" "
> +               $preamble &&
> +
> +               # Merging side should be similar to applying this patch
> +               git diff ...side >P.diff &&
> +               [...]
> +       "
> +}
>
> +test_apply_with_3way success default true
> +test_apply_with_3way failure 'merge.conflictStyle = diff3' 'test_config merge.conflictStyle diff3'

This isn't the prettiest way to achieve this; the "success"/"failure"
arguments, especially, are somewhat ugly. A perhaps more palatable
alternative which gives you the same benefit of re-using the common
code but avoids the ugliness while still allowing customization (now
and in the future):

    test_apply_with_3way () {
        # Merging side should be similar to applying this patch
        git diff ...side >P.diff &&
        [...]
    }

    test_expect_success 'apply with --3way (default)' '
        test_apply_with_3way
    '

    test_expect_failure 'apply with --3way (merge.conflictStyle = diff3)' '
        test_config merge.conflictStyle diff3 &&
        test_apply_with_3way
    '
