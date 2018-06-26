Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81D11F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeFZU7n (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:59:43 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42990 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbeFZU7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:59:43 -0400
Received: by mail-yb0-f196.google.com with SMTP id i3-v6so3991566ybl.9
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAAze66hw+GteCoDi8vB/EQ6uMr+tcGjG7SeSb2avtM=;
        b=biZlLnG4WAzL7oLFhyW3kC1E0hNJWI+BLx7CTMRTj1mjZJTpiOOJvvdFTQCNal4f2s
         yWBPUUp/ftxZbFvGVic99Fazt1ijmAqmAiRiwraJw1XoKjQic/Y0yy+iEbKeRsKxeByr
         C02FtJ1Rk2EadMq9B6kub067X5Hcn6jR2vmvP16SnxGltHTX7wNFV6sQ94JNA3u717Ic
         VYbXRWPAEhwpPHM609dT0SG8UBuxp5QW2RD2edW0CecehV1tKK+qGT4UzAz5LZvSxqXb
         /QuM5jZloEea4UxPFuQiC92ubIz0GXc0p9ms/90jNXNzAFZevxLvsO0lx9taHt9fApAf
         iOBw==
X-Gm-Message-State: APt69E1er9Y0EBAimJ0uPzVC9JHGh+vHUAusXhaIwfCK49Zmpn+odGRr
        Yk6ZHsRYvnv6XPeFIn8vErzOlpR4ITMBsJUhg4w=
X-Google-Smtp-Source: ADUXVKIBQH9A+Qyzvw0Ry91IhsiBqo3tLi2biEX9PZ4mhQlz/ss1v8iq+fHiiX50Nqij+BKZWzuPPEy3cY4r84SOm1Y=
X-Received: by 2002:a25:c04b:: with SMTP id c72-v6mr1688376ybf.12.1530046781115;
 Tue, 26 Jun 2018 13:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com> <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net> <20180626202244.GB2341@sigill.intra.peff.net>
In-Reply-To: <20180626202244.GB2341@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 16:59:30 -0400
Message-ID: <CAPig+cR1Jxdo_YGSCQRyFD4AMq2wrBzpESHhHkjTEnVG1mMRbQ@mail.gmail.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 4:22 PM Jeff King <peff@peff.net> wrote:
> So obviously that means "I don't think there's a good solution with this
> approach".
>
> That whole final patch simultaneously impresses and nauseates me. Your
> commit message says "no attempt is made at properly parsing shell code",
> but we come pretty darn close. I almost wonder if we'd be better off
> just parsing some heuristic subset and making sure (via review or
> linting) that our tests conform.

I'm not sure I agree with "come pretty darn close", but your idea is
an interesting one. It would sidestep the concern with "rm -fr" and
friends (though it will probably still nauseate you). Let me cogitate
about it a bit...

> Another option is to not enable this slightly-more-dangerous linting by
> default. But that would probably rob it of its usefulness, since it
> would just fall to some brave soul to later crank up the linting and fix
> everybody else's mistakes.

I considered that, as well, and came to the same conclusion.
