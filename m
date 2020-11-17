Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94012C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459D62222B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgKQXHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:07:22 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:42677 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgKQXHW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 18:07:22 -0500
Received: by mail-ej1-f68.google.com with SMTP id i19so9441ejx.9
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 15:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBA3X+VivjFOrvF8v4Kq84x/ohmBvwxHpEZARmkhPVM=;
        b=tNKDONXJWsz8KvTf0YwZqADf+75RszYbQntgcbQg3WA6lVrVOkoIZcIWdT/8NfYpBI
         57b/i6wp4NA+ls23TIYoAeY6b5QQ80PujjEbG2Au29xPa+fEiuL0caPllBatLf57RrXP
         BNE1fg7SVCgq9dDZ+3VKR+583ljMmtUWiNlYxfQz3Zv8LGj9SW2rgnJ7OvJp+xehYJxN
         2cv2elWKe0ySzsnyxtjLA5Fynq+x2c6QLcPjRP3HBK1O615jpwQRJ77lxhMo0mNKMLRl
         RoC008bv5DjQGkwDWYPgsdr6ZYhebCmS9yml6nAOBA3J0KPDeuqCwGwuNI4BjZv53Kx7
         ZQ2w==
X-Gm-Message-State: AOAM530g+IMWooqQlNtjzBCWP5LI9LL/1j13g444MgsleCte+b2wsD6t
        vQvw13Avlr4UwMG61Fu8ZpAZN9BKKlb17q2BKt4=
X-Google-Smtp-Source: ABdhPJw56/PA5KYpyaraaHhEmxRRX6VBgjN8YYPzvSLj6pbaajM4/qOGgxf563jYMUJUGlDLhZ88uh94+t7eDRxTSZk=
X-Received: by 2002:a17:907:42cf:: with SMTP id nz23mr21861350ejb.138.1605654438813;
 Tue, 17 Nov 2020 15:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20201114084327.14891-1-martin.agren@gmail.com>
 <20201117021318.GA30463@coredump.intra.peff.net> <CAN0heSoGnAKjTz2tiHpe2==Y-w7M03eiEpW2hU67FRbv=G+H8w@mail.gmail.com>
 <20201117225401.GA642410@coredump.intra.peff.net>
In-Reply-To: <20201117225401.GA642410@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Nov 2020 18:07:07 -0500
Message-ID: <CAPig+cQnA_zqtjOu2OryM57jVMQeo32U3iBYVzxFkPnZ9Zd+cA@mail.gmail.com>
Subject: Re: [PATCH] list-objects-filter-options: fix function name in BUG
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 5:55 PM Jeff King <peff@peff.net> wrote:
> I actually wonder if it is time to drop HAVE_VARIADIC_MACROS completely.
> They are in C99, and we have been introducing many other C99-isms. It
> would be a minor cleanup to a few bits of code, which perhaps isn't
> worth the risk. But I also have a vague memory of not being able to
> implement some interfaces because we couldn't count on them.
>
> Poking around, 3689539127 (add helpers for allocating flex-array
> structs, 2016-02-22) points out one such case. I think discussion of
> BUG_ON() got blocked by that, too. Looks like we also discussed them in
> the big "C99 weather balloon" thread:

There was also an idea[1] to use variadic macros to prevent `errno`
from being clobbered in a case like this:

    die_errno(_("blah %s"), foobar());

In which, if foobar() changes `errno`, then die_errno() reports the wrong value.

[1]: https://lore.kernel.org/git/CAPig+cQKMxwadf9aGyC5ESa-vxDy9PzrYo+m+JaVQ3S=12PyQQ@mail.gmail.com/
