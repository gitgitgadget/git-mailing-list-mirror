Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8052E1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 07:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbeIUNHF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 09:07:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38750 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389010AbeIUNHF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 09:07:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id s129-v6so4864392qke.5
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 00:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ni79uXRvCVvwNyyyWy7p7Km8ZFwAc7FAoHrJDgSWWDs=;
        b=MMCO91jY486+MSQfjZreuEXz/rtyOJvfxl0vPwSYHVCfpl6Im1ln3cF1fBZnNwJifo
         FJgjLutpjPjeVA+ZQWTN8bysjDczliUFVd0mV5+x4feZRPIJfTOvkWwskvASMLoA2A4k
         8NejkOgD9s0dr2pw3aYCMUadOzzYkbrzjXsRjy8ODOeHMUM6cZ23w3y1Ya/w2WilqrKM
         TTphKgNwC5Mn3yAW9EJOUBpYywO1rN+DzAI1yphRdKt18l3kZtE2KqDUm7jgd81Jah20
         O7AZW4pjcB1M7/u385KIx8N0Pu7ZioAl/kKe8tAcoWuHkp+oInAMvdI0V5Hs10qt7hJ/
         2n+Q==
X-Gm-Message-State: APzg51BVvOQvTIs8QhGbcpGDX089J57NvgDj2VTBEUTmEgTr9Onxxxjr
        1P8BUNCB8CY435ggX+B9ABm1csvorpLIrf1SenQ=
X-Google-Smtp-Source: ANB0VdbvffBg1RMZriwVCtvxcSxP8JLrihwbtbC/6/CrhwNdAGGDUFBmED2u/wdu+8U/f719cjGR9qDINWmFKKarYrE=
X-Received: by 2002:a37:d78e:: with SMTP id t14-v6mr12031495qkt.220.1537514371793;
 Fri, 21 Sep 2018 00:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537466087.git.me@ttaylorr.com> <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
In-Reply-To: <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Sep 2018 03:19:20 -0400
Message-ID: <CAPig+cT7WTyBCQZ75WSjmBqiui383YrKqoHqbLASQkOaGVTfVA@mail.gmail.com>
Subject: Re: [PATCH 3/3] transport.c: introduce core.alternateRefsPrefixes
To:     ttaylorr@github.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 2:04 PM Taylor Blau <ttaylorr@github.com> wrote:
> The recently-introduced "core.alternateRefsCommand" allows callers to
> specify with high flexibility the tips that they wish to advertise from
> alternates. This flexibility comes at the cost of some inconvenience
> when the caller only wishes to limit the advertisement to one or more
> prefixes.
> [...]
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> @@ -44,4 +44,15 @@ test_expect_success 'with core.alternateRefsCommand' '
> +test_expect_success 'with core.alternateRefsPrefixes' '
> +       test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
> +       cat >expect <<-EOF &&
> +       $(git rev-parse one) .have
> +       $(git rev-parse three) .have
> +       $(git rev-parse two) .have
> +       EOF

It's probably a matter of taste as to which is more readable, but this
entire "cat <<EOF" block could be replaced with a simple one-liner:

    printf "%s .have\n" $(git rev-parse one three two) >expect &&

Same comment applies to previous patch, as well.

> +       printf "0000" | git receive-pack fork | extract_haves >actual &&
> +       test_cmp expect actual
> +'
