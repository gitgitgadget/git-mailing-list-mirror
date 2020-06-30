Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5121C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A89C206B6
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgF3Ttd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:49:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44539 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgF3Tsu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 15:48:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id b6so21294454wrs.11
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 12:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNBNl0DzJ+f/U0ZrCD9j3dp2tN1PeK56W+8xB9aIRIw=;
        b=fzv5SKGgdkLIyiFQlA1ORtUtKiRV5MzQZA8f0Z7jFzizN3qboZAZICOVZW6msOcoGj
         s3UtUSsc4BQYkPjvjSg329kBZaSaWDvQV2wgXqcTnRUBtTUzqtMrzrhAiqAqKNfmh1H2
         Wk5mvLwE8vpT+HtXvtVrgiy55bA2Zb6ZTwW5hewHInFzSLa52aMfcldhmhcYj5jTSHeN
         OehrWt3Mq/d9qtbYbkbiawNsalC8IuT5Ab5YJqWEhKNn+O5stN0lsJS5Y5sSlVh6PWdd
         i60VpOhZpH9hCDgCaMChDcJTMddpcejHDg0oMqB8gb0ITa6dUvCUxHLKZMdx2QuUTfir
         Fe4g==
X-Gm-Message-State: AOAM532ruNSUF4qvgOi/ElaA6H6Ri2LiaGS9EZEGIWHhvn+bKTCnKAvl
        DRelKVyakRFZpNp7Qi906j4HLgHwjsZEB1Zzi1g=
X-Google-Smtp-Source: ABdhPJx2bb+vAdJY4s8QdU6dg+5tKE3y5jcm3hcE2RAa0vABYlJz/lwAG+wXHQrjVGh0wj/Nypy2S7dQMjMxP3Z1Sqo=
X-Received: by 2002:adf:f34f:: with SMTP id e15mr23395677wrp.415.1593546527888;
 Tue, 30 Jun 2020 12:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593536481.git.me@ttaylorr.com> <5a20a97658fa8e6c874c9c9cafb2cf49e39f94d6.1593536481.git.me@ttaylorr.com>
 <CAPig+cQv3cHe5ci3mDvNKYXbVQt6Rp5icG-woaDCqfAtzZ6SZw@mail.gmail.com>
 <20200630183928.GB26550@syl.lan> <20200630190325.GB1888406@coredump.intra.peff.net>
In-Reply-To: <20200630190325.GB1888406@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Jun 2020 15:48:36 -0400
Message-ID: <CAPig+cTYg6DggGRkCmFb2aKfj_3OysjMNXofqMSOuewRotrQaQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] t4216: fix broken '&&'-chain
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 3:03 PM Jeff King <peff@peff.net> wrote:
> [...] what are we improving, and why?
>
> The original code handled the fact that the file might not exist by not
> including its exit code in the &&-chain which leads to the function's
> return value. Your new code does so by putting it in the &&-chain but
> asking "rm" to ignore errors. Is one better than the other?
>
> I think so, but my argument would be more along the lines of:
>
>   - without "-f", "rm" will complain about a missing file, which is
>     distracting noise in the test log

Indeed, a nice detail when reading verbose test output; one less thing
to distract the attention from the real/important problems.

>   - once "-f" is added in to suppress that, we might as well add the
>     command to the &&-chain. That's our normal style, so readers don't
>     have to wonder if it's important or not. Plus it would help avoid a
>     broken chain if more commands are added at the beginning of the
>     function.

The bit about commands possibly being added at the beginning of the
function probably deserves its own bullet point. I often (relatively
speaking) cite that reason when asking people to &&-chain variable
assignments at the beginning of a function.

    func () {
        a=1 &&
        b=2 &&
        ...
    }
