Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E30FC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832C12075E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgHUSJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:09:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33547 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHUSJI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:09:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id w14so1683238eds.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9h3sOBY/Tck6Db07/JOSoMRB1VHPGjHp+Qupte7AHc=;
        b=LgEPDPkplaGG23eic0L94ZdjtmzSnwkOOBUUkFDacBTlW8pdB3tAs6RSdGUS3opHG0
         i1gODNjsgBUGXUgUJalrP05oATyHSRyUMCbby7Pdn4gzWgJcQPlrAGsCunaCgwikKzXa
         d4Y56a09yOg5xJX5YUDNxiVgqH47vTOoKHpQ24BENBV+rmt1wrWrPBb5g0pTpPB3gXeJ
         duj9567rTA4LFnuXInOeLaJeOJiuf8omW5fDgOD9d5vye7omZdZzsjFVNqX1oxzpkmF9
         u5j/Ywr+6uJzS1ewV97MQHd9v2C4NOPpIN/n2HgKDJh+VAGwWUvtESKAwOZIZcpXO02/
         /yIQ==
X-Gm-Message-State: AOAM533w//9OLVfEltFz271gLHk0+rF7vvjGkcysWjIfG11O59c4G8Ui
        CRmhYJVctRUZ9oWPfNVNntEKQWg42LTW9eeF+1mFSI8K
X-Google-Smtp-Source: ABdhPJxdDu3nEOa7aG6p32EQBhU4xXWllKGMo+Lmx1H/yS40UAtVrMib+ZSWo52QrcBGeBtFBAmY2srWJsJV/q1w3qo=
X-Received: by 2002:a50:8f85:: with SMTP id y5mr4082864edy.233.1598033346615;
 Fri, 21 Aug 2020 11:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200821175153.GA3263018@coredump.intra.peff.net> <20200821175800.GC3263141@coredump.intra.peff.net>
In-Reply-To: <20200821175800.GC3263141@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Aug 2020 14:08:55 -0400
Message-ID: <CAPig+cRQG6EN7Zq_fYMQOM7y9a6rgwWORZhN=px21-7RorWNdg@mail.gmail.com>
Subject: Re: [PATCH 3/3] index-pack: adjust default threading cap
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 1:58 PM Jeff King <peff@peff.net> wrote:
> So what's a good default value? It's clear that the current cap of 3 is
> too low; our default values are 42% and 57% slower than the best times
> on each machine. The results on the 40-core machine imply that 20
> threads is an actual barrier regardless of the number of cores, so we'll
> take that as a maximum. We get the best results on these machines at
> half of the online-cpus value. That's presumably a result of the
> hyperthreading. That's common on multi-core Intel processors, but not
> necessarily elsewhere. But if we take it as an assumption, we can
> perform optimally on hyperthreaded machines and still do much better
> than the status quo on other machines, as long as we never half below
> the current value of 3.

I'm not familiar with the index-pack machinery, so this response may
be silly, but the first question which came to my mind was whether or
not SSD vs. spinning-platter disk impacts these results, and which of
the two you were using for the tests (which I don't think was
mentioned in any of the commit messages). So, basically, I'm wondering
about the implication of this change for those of us still stuck with
old spinning-platter disks.
