Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BDDC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 23:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiBPXmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:42:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiBPXmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 18:42:16 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC99F39E
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 15:42:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso2178918pfa.10
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 15:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=vgTC7hxNuMwAsNSCxYUKxtmTGBDZdg9MHLK1M+ReTUs=;
        b=e7F9C2gPnKASDi32liXyqtrZUp/k6AoXGCE64fsF2RGPB9nVST/Ml5MYeV17SNke0R
         icQuIfR+ig3EH3mFKfxQvkoKNOMAF7/BfcfkvmS/ARS9zN6+PKlgAbzGCgy7IUExgzRa
         h8jXzYqS1OWwX/LpRKbXXJ2yEmIiHTVUYo/wg4xD4ZllI3dUAkMSuN+GAEZsY4p9L7Tq
         JWFDT/+P/Qgb11ZuqFr1HI8qHVN9vm67E5ie3i68/mY5UF8wUNcAk83RTbFSN/BPzqJi
         k+o3ClFykFnZkC0J2PnmXsjWIVj7gNQAmFvAqWCOfrOKPBj3dMQMeZx4SMAYWdp1YYwh
         22kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=vgTC7hxNuMwAsNSCxYUKxtmTGBDZdg9MHLK1M+ReTUs=;
        b=CQz4OzcA5uHxUWwxlusb1N72Olt8gW6Wy1/n7MROkv42oFnWnmUc0OiwXqKbYw8G6D
         Wx/kKtovJgveAdw2+oxBhTUHRGx4RcT41vljC15rg8B9F6zKQII0YnuQoPkHFp6n3qmY
         ZXRcswnLHL3VNlhqVEl+BvegYJT6r9pvzBFW5WLEdBdCwCAgRWql7jqevwOFDrtr21Rl
         lASjhWNWRwY8ZZ4TISmImSr0itejEnos1kVF7LdfTocmolFORdZDU0UYns5P0hmgCM5n
         9fo72FFrvtwCKDHFJ5D0I/z+6SayiTzR41uhikeXVVyv9CG7ZR+o+jKOUFlQsuErHe0A
         8GBQ==
X-Gm-Message-State: AOAM532zlUi2AM104xmSFe7kK7Td4XPNFlyeI4LzE7gBUphtl98PgY4v
        26dtMEtvjjJqZ1nsFZg1kM2qlBSvaaX8CkhTHHRn
X-Google-Smtp-Source: ABdhPJxfnNFmi6gPjx9T/6YrYTTirSirGpY5zVzKplMdVwWi5w6zgfK+/60/dVX3err2FTDh/14gM5WnMjP5Fln3fOK6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:6c15:0:b0:364:e7ce:8624 with
 SMTP id y21-20020a656c15000000b00364e7ce8624mr297560pgu.14.1645054921874;
 Wed, 16 Feb 2022 15:42:01 -0800 (PST)
Date:   Wed, 16 Feb 2022 15:41:57 -0800
In-Reply-To: <CAP8UFD1bdLESqzbZcYKYfib836vrDTfyCmYfT-9B-1ToJB0EWg@mail.gmail.com>
Message-Id: <20220216234157.1976077-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 5/6] fetch: make `--atomic` flag cover backfilling of tags
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:
> > Fix this by pulling up creation of the reference transaction such that
> > we can pass the same transaction to both the code which updates local
> > references and to the code which backfills tags. This allows us to only
> > commit the transaction in case both actions succeed.
> 
> Maybe this could be seen as a regression by users who are mostly
> interested in the local references though.

I don't think we need to worry about this - as far as I know,
backfilling of tags only happens when the server doesn't support
include-tag, which was introduced in 2009 (and in my experience, they
all do). And in the rare case that backfilling happens, I think the user
would want to have atomicity in the also rare case that the first fetch
succeeds and the second fails.
