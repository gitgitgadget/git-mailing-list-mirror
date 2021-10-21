Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E011DC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22F261130
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhJUFMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 01:12:54 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:35763 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhJUFMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 01:12:53 -0400
Received: by mail-ed1-f50.google.com with SMTP id w19so518201edd.2
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 22:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKn9JB4ft3d9wVe3HV49+nFXvYuZEp5/4fO/34BzLic=;
        b=6+sp637WHbx+2pJYk2QOkMjJ1OSAjJobvcnlyUkFVyAyIlA6ifDG7DcnIAc3YdY8sC
         r1NNjMDGCBvkAoiHtTCaH1o6oiz4wyxRZp5+O+jYEjsjeT8hDJUmI37vJatgklDZoP7H
         Z4hWzMVlrEDNo5cRHyY3k+j2Q9yrwW9XBum1m3NnKlBikuD4hHr0KtDvXXO/Zdahhiz2
         BHK0MchfWTPvMUaMwhGPSzie6+FUeKhUTpiAo6Zk8kkDcOcdIFwsbhutFQiYDc20l2b+
         lqJ6ekRMqMERtmRO8hF5UI5PGNgOD/JtuO/XKvrD6qFkQcX56t1NpX38u2jlr1ZPmDej
         reKQ==
X-Gm-Message-State: AOAM530M1upkgXDofsPzpgBcNQQ6h8RWkinW44766HV+PmGnYXLXFY2D
        ntyMeKq91JP7JEmBVVuFVRBLMOg7JuFNjETegIs=
X-Google-Smtp-Source: ABdhPJy1AD2hf19uioQIQGjcEBGIRkZ4mfUajHPmkMYYuqOwMTxSItEaeDwQ8mWT+n2fHeszBRJqqgRW6BrjFz8Phzg=
X-Received: by 2002:a17:906:3842:: with SMTP id w2mr4761925ejc.28.1634793037000;
 Wed, 20 Oct 2021 22:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634787555.git.me@ttaylorr.com> <e65ac7deb5973b8209e8d94ad9140e005e22c44e.1634787555.git.me@ttaylorr.com>
In-Reply-To: <e65ac7deb5973b8209e8d94ad9140e005e22c44e.1634787555.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Oct 2021 01:10:26 -0400
Message-ID: <CAPig+cToh_8x+72-g6cdvt559N4GqKwfmBDE9BxTpkXOFrRbsA@mail.gmail.com>
Subject: Re: [PATCH 09/11] pack-bitmap.c: more aggressively free in free_bitmap_index()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 11:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> The function free_bitmap_index() is somewhat lax in what it frees. There
> are two notable examples:
>
>   - While it does call kh_destroy_oid_map on the "bitmaps" map (which
>     maps) commit OIDs to their corresponding bitmaps, the bitmaps
>     themselves are not freed. Note here that we recycle already-freed
>     ewah_bitmaps into a pool, but these are handled correctly by
>     ewah_pool_free().

The parentheses placement seems off; it's not clear what the intent
is. Perhaps either move the closing parenthesis to just before the
comma or drop them altogether.

>   - We never bother to free the extended index's "positions" map, which
>     we always allocate in load_bitmap().
>
> Fix both of these.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
