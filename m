Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A89C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 20:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF8D61CC2
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 20:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhGGUNW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 7 Jul 2021 16:13:22 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:40830 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGUNV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 16:13:21 -0400
Received: by mail-ed1-f53.google.com with SMTP id t3so5061706edc.7
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 13:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZG+nUMyA13J+/ok6Q3OZCMSZ6Pg5cd/ToERAZ3vU3Jk=;
        b=t2Mh5LqOvdAY3GaY5z7EG+E8TFoZSVEiQd5o/iRKU7ytw+cwvMH3wX6yaTTMhqGJTo
         +6XtzH8pJAK1mn4dA80CLr5DCj9Fsmap+xyb0h7Gkg2dOlPX6jVghoNBj2Zr98tSax7b
         1Pe0IbzVQHPCb9XWhCDEH6HKLL8pzwTYWouXvn28IiGemEZXt0sgomSctmn+6F7lPfiN
         1d70nslTBA/zWyatmj4jfsESVMc3F5O9I2rBBzVLJi/bCyhFao8lajlkql2AMxZvcO3K
         rcWZjzd7XGYiJuioxRAx5Y4pjF9cm+1Y/ZxDDuv5YViLyZBWVho5XBZYZ721WsnYeqCc
         i02A==
X-Gm-Message-State: AOAM531b0HlLEJvZmNokc746D+k/kewOYNfY7gjUhxTSgNxgCfGF+Ho6
        yNBkj3q57ZOK+f7mUilnY5OtAf6zSKZOMbjuH3w=
X-Google-Smtp-Source: ABdhPJzRpkjLYzuS552enITIx9pEw5Rs6dUiBu3Zg++vT6EnwvqmR8B7xIJop9kDsbGPFgwZAN2AiAefwRBY4CIL2YE=
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr32838245ede.94.1625688640277;
 Wed, 07 Jul 2021 13:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com> <patch-2.3-a920a9971e8-20210707T103712Z-avarab@gmail.com>
In-Reply-To: <patch-2.3-a920a9971e8-20210707T103712Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Jul 2021 16:10:29 -0400
Message-ID: <CAPig+cSCKbcK5Dfi3CNh=kNngwG5==2afFPVxy2wA9S_dTa9oQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] strbuf.h API users: don't hardcode 8192, use STRBUF_HINT_SIZE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 7, 2021 at 6:38 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Change a couple of users of strbuf_init() that pass a hint of 8192 to
> pass STRBUF_HINT_SIZE instead.
>
> Both of these hardcoded occurrences pre-date the use of the strbuf
> API. See 5242bcbb638 (Use strbuf API in cache-tree.c, 2007-09-06) and
> af6eb82262e (Use strbuf API in apply, blame, commit-tree and diff,
> 2007-09-06).
>
> In both cases the exact choice of 8192 is rather arbitrary, e.g. for
> commit buffers I think 1024 or 2048 would probably be a better
> default (this commit message is getting this commit close to the
> former, but I daresay it's already way above the average for git
> commits).
>
> In any case, if we ever tweak STRBUF_HINT_SIZE we'll probably do so on
> the basis of some codease-wide performance tests, so replacing the

Did you mean? s/codease/code/

> hardcoded value with STRBUF_HINT_SIZE should be safe, they're the same
> now, and if we change STRBUF_HINT_SIZE in the future this is one of
> the main codepaths we'll be testing.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
