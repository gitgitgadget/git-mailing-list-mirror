Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63FFC4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiL1TgR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 28 Dec 2022 14:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL1TgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 14:36:16 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C913CCA
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 11:36:15 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 79so11094075pgf.11
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 11:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBYq7UaMElBVdhl1Tkr3uqHA7n4ut3QcVwh7UNASDzo=;
        b=378SVBcS2C5NdHxvlJJLBbYz1cbSXe5A8lxz1UWwJKgq4YzHnxkfrwAWSI30FVHoyG
         zTxXblcDflanhp3Uj8SdG4JtAdTD/YxKjviduiefKPat/qF9F/m+s7FljQpzjgfFVEjN
         BZgrVWSJ4EFptn6VzQM/9Rc59nsG+UZxAMTOaicmLSjwUyMHAbqTAUcyGtbRDEsQ62LX
         VLGgyCkUnip2rwja9RWpqXc0Ji98kk4hK61WGde2gNeS6fofGwt/cXvNJtJ0oJIWZyuW
         9rUmxut8x/K7w2DZzrmsd5VRy1gBf8znmmJRdBc5z9d0uuU6nGrWQJwX3xGZPESuoBtc
         UzzA==
X-Gm-Message-State: AFqh2krciqgJImv+TueGa8+vVqPozTmAWvO4J6BDl/tc2iUPCtcYWzgf
        WqOuuxaw3pMKgvqqTkQSDH3phmXMucWLUfi79VU=
X-Google-Smtp-Source: AMrXdXs9w8nk3fyyRBdHs8fPgiA5LzOG0vq2uweQdEid4Q6A5nq5afhOf2Ww3dNs6LG+mTvURRvmAMOVlStH8On1fRI=
X-Received: by 2002:a63:5f91:0:b0:493:def0:12a1 with SMTP id
 t139-20020a635f91000000b00493def012a1mr1319432pgb.514.1672256174729; Wed, 28
 Dec 2022 11:36:14 -0800 (PST)
MIME-Version: 1.0
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <patch-20.20-8ecc68c3e93-20221228T175512Z-avarab@gmail.com>
In-Reply-To: <patch-20.20-8ecc68c3e93-20221228T175512Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Dec 2022 14:36:03 -0500
Message-ID: <CAPig+cS3-j9hHwuoP-vOsbwwTDWPm4RLxPKi0Tn_sWqbNm8KRg@mail.gmail.com>
Subject: Re: [PATCH 20/20] grep API: plug memory leaks by freeing "header_list"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2022 at 1:03 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> When the "header_list" struct member was added in [1] it wasn't made
> to free the list using loop added for the adjacent "pattern_list"
> member, see [2] for when we started freeing it.
>
> Let's start doing o by splitting up the loop in free_grep_patterns()
> into a utility function. This makes e.g. this command leak-free when
> run on git.git:

s/o by/so by/

>         ./git -P log -1 --color=always --author=A origin/master
>
> 1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
>    not union, 2010-01-17)
> 2. b48fb5b6a95 (grep: free expressions and patterns when done.,
>    2006-09-27)
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
