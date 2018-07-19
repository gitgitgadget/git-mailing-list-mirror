Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8466F1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeGSV4U (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 17:56:20 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35746 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbeGSV4U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 17:56:20 -0400
Received: by mail-yw0-f196.google.com with SMTP id t18-v6so3616842ywg.2
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 14:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llsqkIk9Qy4qvg/Qm0Hy/i5zlJYFnBcVuJrX6IERY0g=;
        b=q8DDdcmlCYdfGzQR+kAD8ealiH++8hYY6wPfObNScAS5/6SWJFh4vYvXsf7VWO73BN
         6VGyBefu9Ti7l7VesexiSRqjjLjq/hJnunUoz93ZZV99bqiHqLTOK5tiwH4SqvwtyJU/
         czqddwxaAE3iXF63kL7nod96KmyhbFrk3bWowTUULzDTVeT64OGnBj+MUXJfR2hU3Om+
         J4Zl1O4KlUYYMyNrAPXIT1nlWM5InyZGioCU0kLHb3osszcp/MEh789DR369PWmykFXf
         P/QyQ+fRJqdSoM1B1XOFPwksrEmagJoNpH80Tn1ZH2B/ASUT+gDNdjoBbjDtE4BtUzHR
         25YQ==
X-Gm-Message-State: AOUpUlG4ZiDpUy5ImRCyRMRu4oKez7vci6z+/tH0/kZ+skGfk2jzzWJ/
        pLuxw+MINvBD2k6LgEtS6Imw8Q0/L/CbQFuI5Zg=
X-Google-Smtp-Source: AAOMgpde9k78viJXGxU9prVIQHoWflY6mkItg7Jqg2RhKaL5ypJdVaaD5NZFB+uIXzH96tJfMtW7dmailF7Y5CA+4uI=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr6232401ywk.74.1532034686621;
 Thu, 19 Jul 2018 14:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180719203259.GA7869@sigill.intra.peff.net> <20180719203901.GA8079@sigill.intra.peff.net>
In-Reply-To: <20180719203901.GA8079@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Jul 2018 17:11:15 -0400
Message-ID: <CAPig+cSErDoZ5XFjfJsqfEKZ6PSKfOos=9HW-7FDXU1XEtuktA@mail.gmail.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 4:39 PM Jeff King <peff@peff.net> wrote:
> [...]
> Let's start by banning strcpy() and sprintf(). It's not
> impossible to use these correctly, but it's easy to do so
> incorrectly, and there's always a better option.
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/banned.h b/banned.h
> @@ -0,0 +1,19 @@
> +/*
> + * This header lists functions that have been banned from our code base,
> + * because they're too easy to misuse (and even if used correctly,
> + * complicate audits). Including this header turns them into compile-time
> + * errors.
> + */

When the above talks about "including this header", the implication is
that it must be included _after_ the system header(s) which declare
the banned functions. I wonder if that requirement should be stated
here explicitly.

(Probably not worth a re-roll.)

> +#define BANNED(func) sorry_##func##_is_a_banned_function()
> +
> +#define strcpy(x,y) BANNED(strcpy)
> diff --git a/git-compat-util.h b/git-compat-util.h
> @@ -1239,4 +1239,6 @@ extern void unleak_memory(const void *ptr, size_t len);
>  #define UNLEAK(var) do {} while (0)
>  #endif
>
> +#include "banned.h"
