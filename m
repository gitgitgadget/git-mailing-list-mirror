Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7301C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0FF64E60
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356407AbhCDAWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:24 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33771 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842535AbhCCIGa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 03:06:30 -0500
Received: by mail-ed1-f43.google.com with SMTP id c6so28726588ede.0
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 00:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rWgrEoUQ4UCMxJIVV0XWD5CtZhl7VtRiS2x44Bcqx0=;
        b=bJKUjMWrTE9YZNg8FW3zuTQd6ernoFyZ1C7NyRDzyZrwjdIj3xFcAd7bzsJhJSOyjy
         lxphXPJRX2+GWrj3x3sI06//FjMuzrvf7Hs68hW+v6skt7g5UfzbtNlanlLXv9V6iy54
         dcWBfzZLkHbw3/I3FOoNU87mAvr9mmy2Hq9R166pBA8FN2OshSaHSuWi8pOwmCXlbtBs
         IBLzBsxXRNAwZ2aO9QOdXRxQY6sdlfpqCExHQh0hrXOdDNNfXIDYnkfHo2gbZSq9OjPW
         vHu+ClIKCxZXAkFZJj+WcocaHrGhfdiQEivEIyWYJj5RRzPb9uTwvqAONhtgpnCQdLO1
         5Dtg==
X-Gm-Message-State: AOAM533lUwDR0oLbuge2rNs0gE4TLw3EKf/uvU9fBV1K1YTEPZ/pMvA/
        /EP9oRv2vnAoqZEPQiW/7b0W9trDl9ZNzkahTzSmPoN4
X-Google-Smtp-Source: ABdhPJyazyBG0wSu8O9IiIzQSqtnB6iK2oiSXqJyjNa2hDC5dEKcXBG9mJ1QhlcYHMRpserMWlzd5zwyTAoHBJZDNs0=
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr5180331ejc.231.1614758272051;
 Tue, 02 Mar 2021 23:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
 <xmqqlfb6mrnx.fsf@gitster.c.googlers.com> <CAPSFM5fmK_3rFfTbD7o3qCcYYeMXoX7K-HhGorXDPcFseBEDzQ@mail.gmail.com>
In-Reply-To: <CAPSFM5fmK_3rFfTbD7o3qCcYYeMXoX7K-HhGorXDPcFseBEDzQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Mar 2021 02:57:41 -0500
Message-ID: <CAPig+cQcjUzXpW1OBCiEC3Sr13uyeesqK49KWmgnY1iHNnS2Rw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 3, 2021 at 2:41 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> On Tue, 2 Mar 2021 at 04:02, Junio C Hamano <gitster@pobox.com> wrote:
> > But the use of starts_with() in the original patch is bogus, I
> > think.  fixup_message[] by the time the comparison is made is
> > NULL terminated at where the colon was originally, so we should be
> > doing !strcmp() to reject "--fixup=amendo:HEAD~2" with "no, 'amendo'
> > is not a valid variant name for --fixup option".
>
> I am not sure about this because we used the starts_with() so that it can
> support the _any_ prefix of `amend` or `reword` i.e to make all below
> like combinations possible :
> --fixup=a:HEAD~2
> --fixup=am:HEAD~2
>
> So, I am not sure if we need to replace it with !strcmp and work for
> the specified prefix only ?

Hmm, I see. I didn't follow whatever discussion led to the decision to
use this sort of prefix matching, but I have to wonder if it is a good
idea. Was the idea that it behave similarly to sequencer commands in
`git rebase --interactive` which are often abbreviated to a single
letter? I personally would feel much more comfortable requiring a
full-word match for `amend` and `reword` at initial implementation.
That leaves the door open to later loosening it to do prefix-matching
if enough people request such a feature, whereas starting with
prefix-matching closes that door since we can never later tighten it
to require full words.

Anyhow, if the decision is to keep this behavior, then it almost
certainly deserves an in-code comment explaining the sort of
prefix-matching it's doing since it's otherwise too easy for readers
to be fooled as Junio and I were by not noticing that you had reversed
the arguments to starts_with().
