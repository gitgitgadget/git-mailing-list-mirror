Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94041F4B7
	for <e@80x24.org>; Wed, 28 Aug 2019 06:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfH1GAv (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 02:00:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51855 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfH1GAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 02:00:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id k1so1377205wmi.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 23:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1t0ws28OS7nlgdOkVITb7Z0CYN5ALJcns0KrSARrO4=;
        b=Akx6X4u8+PQTqaVdqDCm9+jt7sPM9S1iMHdLNuiR/LhEciNvaP4eFaDYN+QKeAAZWf
         z1fyPLiEp+cekRzB5lVXbEPCwEQJObeXo9qenFJ8GgFY9s6Hosga0/rwoUrOR336x5mW
         9uLvvvT+lm538ME/UzL2LRBPL47yxPcFhyGCcoFX4rnYAVPjSKArHROTlGeN2IT2uzJ4
         Tybc1Nkd3vu5JdHF/NVTx2t6CxQTx7knmQJepHAsPKXM+oXNxMtIQqdD4P76l66MN6Oj
         QH7QYH5++jhos3ZB7FLDswETJL4ZA4s2EqekFmzkx0sAmSwTOjcmNox+ljDZ3uVycONV
         oLjg==
X-Gm-Message-State: APjAAAWTG31B/ydULJrBuDhRLEhYbDZOgZZ9jK2YqHEfWwr6/telXZ62
        YZygqDHSm2QPCt6b9R0wSiqmwsfD6LN27BWoEV8=
X-Google-Smtp-Source: APXvYqxyBx3RTUVZ+ULlSHEvvYI5ArWCtra9qcc3ALrNdwcNgmcqiIQI9O9JijZAq5fLFW5S9aqQo2dMWz00wEKW6dw=
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr2512049wmg.120.1566972049207;
 Tue, 27 Aug 2019 23:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190826235226.15386-1-newren@gmail.com> <20190828002210.8862-1-newren@gmail.com>
 <20190828002210.8862-3-newren@gmail.com>
In-Reply-To: <20190828002210.8862-3-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Aug 2019 02:00:38 -0400
Message-ID: <CAPig+cQco8vtj498G_3tbsF_PFxXidUPgPZtOdNYqySGuz5c_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] t3427: accelerate this test by using fast-export
 and fast-import
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 8:22 PM Elijah Newren <newren@gmail.com> wrote:
> fast-export and fast-import can easily handle the simple rewrite that
> was being done by filter-branch, and should be significantly faster on
> systems with a slow fork.  Timings from before and after on two laptops
> that I have access to (measured via `time ./t3427-rebase-subtree.sh`,
> i.e. including everything in this test -- not just the filter-branch or
> fast-export/fast-import pair):
> [...]
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> @@ -11,6 +11,12 @@ commit_message() {
> +extract_files_subtree() {

Style nit: add space before opening '('

(However, commit_message() function just above this doesn't follow
that style, so...)

> +       git fast-export --no-data HEAD -- files_subtree/ \
> +               | sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
> +               | git fast-import --force --quiet

This would be a bit less noisy if you ended each line with the pipe
operator, allowing you to drop the backslashes:

    git fast-export --no-data HEAD -- files_subtree/ |
        sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" |
        git fast-import --force --quiet

> +}

Not sure any of this is worth a re-roll.
