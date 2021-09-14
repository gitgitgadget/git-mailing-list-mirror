Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD9BC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 02:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247EF61151
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 02:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhINCHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 22:07:20 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:34665 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhINCHU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 22:07:20 -0400
Received: by mail-ej1-f51.google.com with SMTP id jg16so25251041ejc.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 19:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O71SMb1K3fpR8ySKzShlc14auesxQW85dk+1WbOyf/0=;
        b=ZWTWKhyFPJKi0CRgALqUEt4ybzorvipBXgU7pKlyZVYZ2ZOcaoyZZJA/LZNA+Adn3L
         Nz8LL6OrDDiiK1D5390fokXqWlKu7MSeKijJm3sD3UdnGevtzR+8u8pTtWeOdgA5j7mL
         SkFF40zuwvm8PKONQNXp1lUzkhiLp+JSMh/M8LYZED1ATjErx75tTRLYZonsUa12ytdK
         WP7IwaTbv+1ykkmI/xxuBw8so8GyeN20j2WTLD96SRgJQRt315qDcvIn07W/IDWMnjEY
         Bgy6s8JGl983bM14dCC/gwPCbZkG1AnnkSu10bBaDKvAHlqG82gwubHOy05jTo8YzbP+
         st+A==
X-Gm-Message-State: AOAM533TsYgPRfQnKF2kLdqVE9b9eWw9cORmZ6dDf1BTzbXdS6m0NAuD
        FMc4/C3+x+cgXJq195JPoF5nduNuYBttravv/Ag=
X-Google-Smtp-Source: ABdhPJxCwXdIYUWeJ9ImaL2MswxiM+a14GCuGs5/kJn5lRozz4qq4/oW5i2Ra6n/XFnxM0FsSXaOhDu/jIX1Sbs4zwA=
X-Received: by 2002:a17:906:b46:: with SMTP id v6mr15967940ejg.262.1631585162783;
 Mon, 13 Sep 2021 19:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210913181221.42635-2-chooglen@google.com>
 <YT+mlW851sRyt842@nand.local> <YT/bfZu5mnMMqq0z@chooglen-macbookpro.roam.corp.google.com>
 <CAPig+cS2E6c9YYKTThPSVpyBkouoL+nK2rgpsZxNODPmTr2hzQ@mail.gmail.com> <YT/2PzbfE2p6TZ9r@nand.local>
In-Reply-To: <YT/2PzbfE2p6TZ9r@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Sep 2021 22:05:51 -0400
Message-ID: <CAPig+cQ8q_nNgRd3taVP4RPpxK3xcDVQ+57Dw0biA0qnghUMkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fsck: verify commit graph when implicitly enabled
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo <chooglen@google.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 9:09 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Mon, Sep 13, 2021 at 07:32:07PM -0400, Eric Sunshine wrote:
> > On Mon, Sep 13, 2021 at 7:19 PM Glen Choo <chooglen@google.com> wrote:
> > > If the variable really is set to false, how might we proceed here? Shall
> > > we stick with test_when_finished?
> >
> > That's probably reasonable, however, for robustness, you should
> > probably use test_unconfig() rather than raw `git config --unset` to
> > clear the variable.
>
> Hmm. I'm not so sure, do other tests rely on the value of that variable?
> If so, test_unconfig() won't restore them.

There may be a misunderstanding. I wasn't saying that test_unconfig()
alone would work. My "That's probably reasonable" referred to Glen's
proposal of combining `git config --unset` with test_when_finished()
to restore the variable. In addition to that, I suggested
test_unconfig() as being a more robust choice in that recipe.

> > Aside: This certainly makes one wonder if we should have a new
> > function in t/test-lib-functions.sh which unsets a variable for the
> > duration of a test only. However, that's outside the scope of this
> > submission.
>
> :-). I thought the same thing to myself when reviewing earlier today.
> That's why I recommended using test_when_finished upthread, but either
> approach is fine (my comments are definitely cosmetic, and don't matter
> to the substance of this thread, so ultimately I am fine with either).

Yep.
