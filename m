Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C53BC433FE
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 03:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CE461980
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 03:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhKGDIk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 6 Nov 2021 23:08:40 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41936 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhKGDIj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 23:08:39 -0400
Received: by mail-ed1-f42.google.com with SMTP id ee33so48145662edb.8
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 20:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3jkiW3asH5RMTb/jEKN6WLNCWNjmH7DzciA52h4F148=;
        b=VScnW41x/zSrS4Sd1J0tVQsFNH2ldlFRnya74bvEqHqtTSrivNTZI8qowZBQ1QnQes
         JN19ZdTP7jb63zIUScRzPnznbMCMA78EJWrze3Sh1JDzJKj+WNDf8E3YHXs3KPpt8CWn
         c0lpn0l/QM9bMHxjCHXg662kknp9lQwldGzKxYe12qBDWMFvxPn+rHn2liDnQboimaRw
         9K3bEpRK3szDxBImWUv2tK7sFlnc1rZbFrWGXc9cXeqFRbO4NaS/NcAE9s7+rLO84AZi
         dhB5HRgbNhzCqcBMgq2rNdVVWzVyTIIJunlZ1v6KEVK0gxaKAtIyv71Vb2KRXoSTnN1b
         sG1A==
X-Gm-Message-State: AOAM5315jWscP5lZHr/OtDs/dnuIPBzuvHFRcLP0A8hEYWdZ3RcDiFcT
        4mVv+Y4sqa5HcfIvjIwb0el2/zU+Q/mYEvhPCng=
X-Google-Smtp-Source: ABdhPJy8p0hB7gEwaqfiHhq0f/D+zamTdKzPKOo/SAarOHHqUYnu4ewq2Yf/E3Gwzmw0k+JpXaPkIQQ4EagAI89nP/A=
X-Received: by 2002:a05:6402:50d0:: with SMTP id h16mr18229755edb.70.1636254356892;
 Sat, 06 Nov 2021 20:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
 <patch-09.10-49f9e30792b-20211106T214259Z-avarab@gmail.com>
In-Reply-To: <patch-09.10-49f9e30792b-20211106T214259Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Nov 2021 23:05:45 -0400
Message-ID: <CAPig+cQLNmi3DiK9Rdq-58Nw2iEdp-CeGXsG5o8EcQpEWAc6TQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 6, 2021 at 5:47 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Stop having GET_OID_ONLY_TO_DIE imply GET_OID_QUIETLY in
> get_oid_with_context_1().
>
> The *_DIE flag was added in 33bd598c390 (sha1_name.c: teach lookup
> context to get_sha1_with_context(), 2012-07-02), and then later
> tweaked in 7243ffdd78d (get_sha1: avoid repeating ourselves via
> ONLY_TO_DIE, 2016-09-26).
>
> Everything in that commit makes sense, but only for callers that
> expect to fail in an initial call to get_oid_with_context_1(), e.g. as
> "git show 0017" does via handle_revision_arg(), and then would like to
> call get_oid_with_context_1() again via this
> maybe_die_on_misspelt_object_name() function.
>
> In the subsequent commit we'll add a new caller that excepts to call
> this only once, but who would still like to have all the error
> messaging that GET_OID_ONLY_TO_DIE gives it, in addition to any
> regular errors.

s/excepts/expects/

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
