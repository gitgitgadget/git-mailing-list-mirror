Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09579C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5451206D7
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgBKR1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:27:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38471 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgBKR1M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:27:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so13425857wrh.5
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 09:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAR5GQPL+pOSHK0JJvQlfL9L3/VKDxT1ans0Ba6SVjc=;
        b=lypVhZHWyAbjNqkqsKroZZAHew0SD9wTG22ED1zATOcoKuDHUE2Z1jPHq3tan0kg9X
         U4eSk8CHXomx7gqXqz24mhbmbEuuUZMieA1VWWNX+SAmV7+pQUEeZPwd95TQs5IeHryw
         NgMyoNGVcascIJV8LWRwWMb+0vg+ZEic1rYFdIyysmVEbfm/ypWKl4G9z8b0a4bhFFnt
         nKEaLlwAikBFpfAPDdrvv2UAUMDTaQU3/aHxniKLXxa4DTdpM79QVEKWezsyIRhNSjKs
         rE3v96PoLrfCEQhlGmXX9WXQwl7JDP/VBCo4wNx/1iJmhNzQIggUgwmpHaDavDRQZ4/7
         zRMA==
X-Gm-Message-State: APjAAAXxbnbRs8+pzBWvHg9px0rNxukp82vCSuZt6IgL8PPGQcTVqcAs
        cixvb7MUTQ2q7f8xEvfG44/5llVOzjEqCRCX52w=
X-Google-Smtp-Source: APXvYqzN1C895c7hh1ItwODfTgNGekaDbo62QpeYC+IiySp9gRSINJTPN7fLzTjB85DUca+r15+6ZLsrJjMUrIG+KOY=
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr9581097wrq.415.1581442031070;
 Tue, 11 Feb 2020 09:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20200211171649.GB2118476@coredump.intra.peff.net> <20200211171852.GA2119034@coredump.intra.peff.net>
In-Reply-To: <20200211171852.GA2119034@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 11 Feb 2020 12:26:58 -0500
Message-ID: <CAPig+cSOWaRij1mfC+LO=KGqmF+KNcTMsBQ331q9fkJdMdY-_Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] mailinfo: treat header values as C strings
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 12:18 PM Jeff King <peff@peff.net> wrote:
> We read each header line into a strbuf, which means that we could
> in theory handle header values with embedded NUL bytes. But in practice,
> the values we parse out are passed to decode_header(), which uses
> strstr(), strchr(), etc. And we would not expect such bytes anyway; they
> are forbidden by RFC822, etc and any non-ASCII characters should be

s/etc/etc./

> encoded with RFC2047 encoding.
>
> So let's switch to using strbuf_addstr(), which saves us some length
> computations (and will enable further cleanups in this code).
>
> Signed-off-by: Jeff King <peff@peff.net>
