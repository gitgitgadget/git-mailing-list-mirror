Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6FBC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0E824670
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBSSi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:38:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38312 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgBSSi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 13:38:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id e8so1760581wrm.5
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 10:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzXvEsJA4WyYrQnFsWaZnooMxdlp0j/aXTT01nZ5tqw=;
        b=q3AytCfBjMPp3nLywmt8DpqW2tfZDpMANK5CTkAXKSWD0Atb2hmWzNL9TWHmH3nbuj
         Tf1R7r4kEfRX4U3HHgbJqaX7/B5tlRycaFDQ+Jso1jzQCGGrkacDHuHXouApIKLowNIb
         WQEohrwLjg+JUhwE1lBoTQLRR0oPPEomUBAsiddAO6/yfn9f/wZ1nw+jVm5q80y4LFff
         MIiv0IiTB8ai3nibZZChvQYqxNdutBC1y2VLqHOIW9K9X5UIkUBPUeOIAYBh3o2mg3yo
         B3tT6Pb0m8I0kkhiRuLm0iV2d4LAdov1wYawOzMaBpf/3bxBBLAEUI26lw++PS/hK+Gm
         ylbw==
X-Gm-Message-State: APjAAAXnPnUGwVgXcMRoOZrL6bFlJqDr887UikbO8pIbgsn2H9vREs3Y
        /FQ08P87gmVINLyp4uysyG/tGYuUZ5NfvxHnpwE=
X-Google-Smtp-Source: APXvYqyrD+DbzTOUBM4/1v0gUuf+Osy8RoYf3GWtAHg5SUS7lNYpVHWtyCvm687Ieqy6ZnmQWUkFhjGDzzB0Lvlx954=
X-Received: by 2002:a5d:534b:: with SMTP id t11mr36934219wrv.120.1582137503746;
 Wed, 19 Feb 2020 10:38:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.556.git.1582129312.gitgitgadget@gmail.com> <dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com>
In-Reply-To: <dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Feb 2020 13:38:12 -0500
Message-ID: <CAPig+cSRQXRtSscKUUJBA0NShRQfA=NHohnA2GMRmgbpWr_MvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] partial-clone: demonstrate bugs in partial fetch
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 11:22 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> The tests are ordered in this way because if I swap the test order the
> tag test will succeed instead of fail. I believe this is because somehow
> we need the srv.bare repo to not have any tags when we clone, but then
> have tags in our next fetch.

This ordering requirement might deserve an in-code comment in the test
script itself.

More below...

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> @@ -374,6 +374,32 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
> +test_expect_failure 'verify fetch succeeds when asking for new tags' '
> +       git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
> +       for i in I J K
> +       do
> +               test_commit -C src $i &&
> +               git -C src branch $i
> +       done &&

If test_commit() or git-branch fail, those failures will go unnoticed.
You can fix this by bailing from the loop, like this:

    for i in I J K
    do
        test_commit -C src $i &&
        git -C src branch $i || return 1
    done &&

Same comment applies to the other new test.

> +       git -C srv.bare fetch --tags origin +refs/heads/*:refs/heads/* &&
> +       git -C tag-test fetch --tags origin
> +'
> +
> +test_expect_failure 'verify fetch downloads only one pack when updating refs' '
> +       git clone --filter=blob:none "file://$(pwd)/srv.bare" pack-test &&
> +       ls pack-test/.git/objects/pack/*pack >pack-list &&
> +       test_line_count = 2 pack-list &&
> +       for i in A B C
> +       do
> +               test_commit -C src $i &&
> +               git -C src branch $i
> +       done &&
> +       git -C srv.bare fetch origin +refs/heads/*:refs/heads/* &&
> +       git -C pack-test fetch origin &&
> +       ls pack-test/.git/objects/pack/*pack >pack-list &&
> +       test_line_count = 3 pack-list
> +'
