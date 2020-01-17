Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67819C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 16:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451D220684
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 16:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgAQQXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:23:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42427 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgAQQXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 11:23:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so23205493wro.9
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 08:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYHamfmZjpyuN2+34pT0NNVPKaLbAi9hislN8uM0dpo=;
        b=sl4fl0/1CaOWrNz6ayz3gDJBhbvndPu6EwVULL8UUVY/nEQvc+8d9xNsed5yt1UTAe
         ysGJkliypDycn8HJATlxYRvcwVy3E55DfeWeVq+sSQElBGBiRAR5mvo5cBUiry5NEDmU
         acnosgqkynq/e0EfCfWbkIj+VWALnndnWARvsHGx4XCUjIcw/BDThgNk6C1vBe2K2fpl
         VqqaswZKLvDRO35mHl5CABNog/nuLsQ2Dh4Ji8coxnp7U2KgKir7Afppg/Ceiy+ljutF
         VA5khnTPR3OGiI7YGPuhF5pz6bTLNRnUGc/RJhacVp17QXw2Mexnq09ggpmab8YDLz6M
         EOQw==
X-Gm-Message-State: APjAAAWIpw79SiK8QHIR48eB8x3d3UPmI96uzBikZ7kouyc2ONBzh51s
        suUekReWwIgeOuIhJaJRAxkvOsOBVdV3/kMQ92E=
X-Google-Smtp-Source: APXvYqyGi5vvL5rRDVhUDLYyj52Ha8WFG2ZihcSTiD4bpViRfdiuCF03SI8QeKby848tUISsFo+o/ilZHPIMExqp3SQ=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr4142889wrr.226.1579278197757;
 Fri, 17 Jan 2020 08:23:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
In-Reply-To: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Jan 2020 11:23:06 -0500
Message-ID: <CAPig+cTK86FPm1kk-P=dvegu+FTzV3k5Z12Etz_jpE=JdyztDQ@mail.gmail.com>
Subject: Re: [PATCH] fetch: add --no-update-remote-refs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 10:29 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -174,6 +174,30 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
> +test_expect_success 'fetch --no-update-remote-refs keeps existing refs' '
> +       cd "$TRASH_DIRECTORY" &&

Why does the prologue of this test use `cd "$TRASH_DIRECTORY"` when
all the other tests use `cd "$D"`?

> +       git clone "$D" remote-refs &&
> +       git -C remote-refs rev-parse remotes/origin/master >old &&
> +       git -C remote-refs update-ref refs/remotes/origin/master master~1 &&
> +       git -C remote-refs rev-parse remotes/origin/master >new &&
> +       git -C remote-refs fetch --no-update-remote-refs origin &&
> +       git -C remote-refs rev-parse remotes/origin/master >actual &&
> +       test_cmp new actual &&
> +       git -C remote-refs fetch origin &&
> +       git -C remote-refs rev-parse remotes/origin/master >actual &&
> +       test_cmp old actual
> +'

I wouldn't expect a re-roll just for this (nor do I insist upon such a
change), but this is one of those cases when -C hurts, rather than
helps, readability, due to the amount of noise it adds to nearly every
line of the test. Using a subshell makes for less noisy code:

    git clone "$D" remote-refs &&
    (
        cd remote-refs &&
        git rev-parse remotes/origin/master >old &&
        git update-ref refs/remotes/origin/master master~1 &&
        git rev-parse remotes/origin/master >new &&
        git fetch --no-update-remote-refs origin &&
        git rev-parse remotes/origin/master >actual &&
        test_cmp new actual &&
        git fetch origin &&
        git rev-parse remotes/origin/master >actual &&
        test_cmp old actual
    )

> +test_expect_success 'fetch --no-update-remote-refs --prune with refspec' '
> +       git -C remote-refs update-ref refs/remotes/origin/foo/otherbranch master &&
> +       git -C remote-refs update-ref refs/hidden/foo/otherbranch master &&
> +       git -C remote-refs fetch --prune --no-update-remote-refs origin +refs/heads/*:refs/hidden/* &&
> +       git -C remote-refs rev-parse remotes/origin/foo/otherbranch &&
> +       test_must_fail git -C remote-refs rev-parse refs/hidden/foo/otherbranch &&
> +       git -C remote-refs fetch --prune --no-update-remote-refs origin &&
> +       test_must_fail git -C remote-refs rev-parse remotes/origin/foo/otherbranch
> +'

Ditto.
