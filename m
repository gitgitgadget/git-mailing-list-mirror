Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450691F453
	for <e@80x24.org>; Fri, 21 Sep 2018 21:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391512AbeIVDA5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 23:00:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40086 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391321AbeIVDA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 23:00:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id e9-v6so2745150qtp.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 14:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4Ie8uVzmiz4r7UXeyUkLlOzA0YvUNf+vh4PLbaANMk=;
        b=B1IsX/0vewJNrXVnINtSfWJyEAixWnsKor4/jDwSC88JE3SRa2Q3Y5md1/VMBOOy0x
         mnNOir22x9u1SGP9ixh89NlkwSfomkshtwp6PYIN8IM4cBnSDPrF31K6hSDl1qUlF+7L
         TkdCgB1ElruknLemqUmCxZxPfkiqP1gSSIJQAbaHLp0c8Xzevoz0r1HvW4i2BXKqxJvw
         kiyyGeLMDWZ9rCu/G0oP8z6fYSHK5pw4d36h8dTosF8gideUQ1NOZfaovfEmHzQbRyAj
         K9OQRXEyUJPhydlG8NBIi37rgyq22LgbXzP9K0T9fiqGB5NGazoxe7kYxFt7j67MekPY
         wUqA==
X-Gm-Message-State: APzg51D0TzDzmXWz6B7GdIgZe2WRMhsX1/Ep+//jaoqmV9ZN93Wx3SzW
        mvWt1JdvFTLpfcFNCLKbFoYEWZvFf0qSHARDMUU=
X-Google-Smtp-Source: ANB0VdYXb7ByyV2VrdV/8OUnYb1fKbHcObO9e2Ez5U4k+alnLSorToAP0s03uglZBjzC/cNdQqFhZ+KW+OJqMdaQQPc=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr33646450qtd.101.1537564218102;
 Fri, 21 Sep 2018 14:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537466087.git.me@ttaylorr.com> <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
In-Reply-To: <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Sep 2018 17:10:06 -0400
Message-ID: <CAPig+cRzY1LXuz3rYnPa5TqGv=Yur7o=h_6H4KNb6=fCV_ofFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 2:47 PM Taylor Blau <me@ttaylorr.com> wrote:
> When in a repository containing one or more alternates, Git would
> sometimes like to list references from its alternates. For example, 'git
> receive-pack' list the objects pointed to by alternate references as
> special ".have" references.
> [...]
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> @@ -0,0 +1,54 @@
> +expect_haves () {
> +       printf "%s .have\n" $(git rev-parse $@) >expect
> +}
> +
> +test_expect_success 'with core.alternateRefsCommand' '
> +       [...]
> +       expect_haves a c >expect &&

This is not great. Both the caller of expect_haves() and
expect_haves() itself redirect to a file named "expect". This works,
but only by accident.

Better would be to make expect_haves() simply a generator to stdout
and let the caller redirect to the file rather than hardcoding the
filename in the function itself (much as extract_haves() takes it its
input on stdin rather than hardcoding a filename). If you take this
approach, then you'd probably want to rename the function, as well;
perhaps call it emit_haves() or something.

> +       printf "0000" | git receive-pack fork >actual &&
> +       extract_haves <actual >actual.haves &&
> +       test_cmp expect actual.haves
> +'
