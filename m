Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D72AC07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 02:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDED60232
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 02:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhGNCW3 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Jul 2021 22:22:29 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:42732 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbhGNCW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 22:22:29 -0400
Received: by mail-ej1-f43.google.com with SMTP id hd33so610939ejc.9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 19:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Afo4AdQD8rkE7xDCtx0uUtPVoBw+/CGYgMTbz9APiCI=;
        b=Fh4QlXp0TZxuh0BD4buHhTFjtdPT6pRnQBoFKKDp7xwoo3pALPGG19R3POYaqCF2Rb
         OJO5zniXY85sZ2GND958mFGwhuagqoinxQSTN1IPkU3WGJ1vy99eUIAafQy8g5zEEH9k
         rMXI8uxV9bGSlCqTjEqjftJMW5HZ/WNwJOauLgLlxOkIzWW4aGzKJQ3/Bw70Mu9nqPnf
         kjguZiJ75W/txtVnlgIc8HPKl1c7DPjQ47Ht+zq8xXV+r7/DVEGuPW4S/azstXejbpxy
         TSkg3t9OwFBpuJct+MRWye6czj0lDJfycsMqyxfEwHsZjFwlybab3w9tEKKcDZD75rZD
         Hs6w==
X-Gm-Message-State: AOAM53077SY+Fx2lC0vKr35FSMEoYcnWr3NrgFFHGD15ql36Y4PnGig+
        nEIJsmYox2wQp35N1RhTLzNm/+jePZhNdsgsFiY=
X-Google-Smtp-Source: ABdhPJxbxGTSqA9j8QF1U3uqVnEsekaIEQVBGxh2rBXg3/6tNmTc0/jn0fyRc9IJVITcQGNJBAcaiQkJXXefm5uWys8=
X-Received: by 2002:a17:906:4a0a:: with SMTP id w10mr9421632eju.371.1626229176435;
 Tue, 13 Jul 2021 19:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <87czsv2idy.fsf@evledraar.gmail.com> <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <patch-4.4-b8062a09f9-20210714T001007Z-avarab@gmail.com>
In-Reply-To: <patch-4.4-b8062a09f9-20210714T001007Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 13 Jul 2021 22:19:25 -0400
Message-ID: <CAPig+cTnRiZaHYw9LBVADoRY695D=ckRbyPzE1qG7o3qCsNeQQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] SANITIZE tests: fix leak in mailmap.c
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 8:12 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Get closer to being able to run t4203-mailmap.sh by fixing a couple of
> memory leak in mailmap.c.
>
> In the free_mailmap_entry() code added in 0925ce4d49 (Add map_user()
> and clear_mailmap() to mailmap, 2009-02-08) the intent was clearly to
> clear the "me" structure, but while we freed parts of the
> mailmap_entry structure, we didn't free the structure itself. The same
> goes for the "mailmap_info" structure.
> ---

Missing sign-off.
