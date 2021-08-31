Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4FC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD11B610CB
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbhHaQYD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 31 Aug 2021 12:24:03 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:40750 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbhHaQYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:24:02 -0400
Received: by mail-lf1-f54.google.com with SMTP id bq28so39710843lfb.7
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 09:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fT6vIq/y+RQl1YL+2lW7FObGmf0wuj+l+C8tP5zoRLk=;
        b=qdStSjMaEcE5scPi5HBcZOEv022yZqh5/mSzwwvSTv+iuDoAC+xlUFHnnlZhR5/Pew
         CfUrXMhAtl3/0S+xNIM14SzBHO0EOg+WaI3woY1pQzJXJxgfxuSZ6kqNba7pMlXWNCMp
         3+tKSThPzLLbKqZsGrKVIQE3pCOI15t27/XUT8auYxTgnK/cdJ3oGP6Ff2rdBzbmLUPV
         yl2YsT/rNoOnxS8p+d5PZ+i6SNqTqZrUPl8xSuqSDS77iVpIFJsMD3gBxpk8CWN0YDi1
         OXvsxr08oIHQzHxU/aAyd8+9LOMj4Jp6IO3GflbiXjxBFOENolDUhfLvrZkV6dfLxFrB
         EDsQ==
X-Gm-Message-State: AOAM531IhJ1oWI9v8103yFc6Sj4oBOovuRe1mMJjfjznFZG7PiZxaMzt
        peexUdO3amfziymk+N8e22h6nhcW5on3XNmPpp1OkUJY
X-Google-Smtp-Source: ABdhPJxkDsiE8tp9B+3BtaLptn0ZUBeLTn0cRi1p3e0TXCgh9dRUn+JaAHxZ0AEVL8GUH010K6wX364FgYKj8NW+0vg=
X-Received: by 2002:ac2:5321:: with SMTP id f1mr8771930lfh.90.1630426986304;
 Tue, 31 Aug 2021 09:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <patch-4.4-ad8680f529-20210714T172251Z-avarab@gmail.com> <patch-1.1-f11eb44e4c5-20210831T134023Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-f11eb44e4c5-20210831T134023Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Aug 2021 12:22:55 -0400
Message-ID: <CAPig+cTzJJA5z51QUwrzCOPmzn_Xzvc6JgyQT36RENMwpt7gJw@mail.gmail.com>
Subject: Re: [PATCH] mailmap.c: fix a memory leak in free_mailap_{info,entry}()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Marius Storm-Olsen <marius@storm-olsen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 9:43 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> In the free_mailmap_entry() code added in 0925ce4d49 (Add map_user()
> and clear_mailmap() to mailmap, 2009-02-08) the intent was clearly to
> clear the "me" structure, but while we freed parts of the
> mailmap_entry structure, we didn't free the structure itself. The same
> goes for the "mailmap_info" structure.
>
> This brings us from 50 failures when running t4203-mailmap.sh to
> 49. Not really progress as far as the number of failures is concerned,
> but as far as I can tell this fixes all leaks in mailmap.c
> itself. There's still users of it such as builtin/log.c that call
> read_mailmap() without a clear_mailmap(), but that's on them.

As a standalone patch, the "50 failures" is confusing and sounds quite
alarming. Adding even a tiny bit of context:

    s/50 failure/50 SANITIZE failures/

would help reduce the confusion. Alternatively, just dropping the
second paragraph altogether would clear up any misunderstanding since
the first paragraph and the patch body stand well on their own without
any additional explanation.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
