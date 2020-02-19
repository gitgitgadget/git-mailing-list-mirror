Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C467C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E54824654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSVAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:00:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33454 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSVAA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 16:00:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id m10so1251714wmc.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 12:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uprang2/kwKa8HS7o4QsjKfEWy/Nemp3jiNj3x4xltM=;
        b=eBwrJUQWdo77oLSdx8T5yE+RnXZR+dKDuJQiAxkZDXdNqO8oty8V4B/d0Bc0XdoeCM
         lovKV8ykML7DPXN7lYxS0BxY/A+aqBNPPqmUw2c3gh0E+7ECsJL9nAg3jZGaApxaHjGy
         mxC/7YIPEqZ9xbYvVJYgv7yCwpgv1eT0LY1qGN4Ic5RKry9mryKHnWylxecwgQNH0THR
         x7t2H5JPksTrp8bpwL3fsn8QsostR53/k8LasONn4Zig9rbDbx/IFzfrSfPRXjAyY/Dv
         E3Qh43dfWv+xIoHJrB5dLe7J0mvTeHbzTJeaA40ZOEaVXjrc+mizI8H3QiZcLULppzWc
         CAcw==
X-Gm-Message-State: APjAAAVM5ooXIV7UgFUyUdrJLrGxFND6U7FD8ekEVDmdqqkjzt+TyYEL
        7Mt9oSPEYb8Tv8ilY3zKzXwkn0K95r3Q8TMp1PA=
X-Google-Smtp-Source: APXvYqwP6sAQ+1qFl/Y8pM8GGJt7Oz87lUNeS3noVU804d4ziEpyupIJehW/hEbm7/o9aEWH1mwJIwTzESfNXueiulk=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr1169668wmf.130.1582145998999;
 Wed, 19 Feb 2020 12:59:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
 <dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com>
 <xmqqimk2e1vl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimk2e1vl.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Feb 2020 15:59:48 -0500
Message-ID: <CAPig+cT+MO_JmZf_qfxu8ZkPLWDOpZSe8rZxt-7LK4d6+RJ6JA@mail.gmail.com>
Subject: Re: [PATCH 1/2] partial-clone: demonstrate bugs in partial fetch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 3:52 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +test_expect_failure 'verify fetch succeeds when asking for new tags' '
> > +     git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
> > +     for i in I J K
> > +     do
> > +             test_commit -C src $i &&
> > +             git -C src branch $i
> > +     done &&
> > +     git -C srv.bare fetch --tags origin +refs/heads/*:refs/heads/* &&
> > +     git -C tag-test fetch --tags origin
> > +'
>
> Is this about an ultra-recent regresssion?  When applied directly on
> top of v2.25.0, this one seems to pass already without any change.

True, although both fail when applied atop "master".
