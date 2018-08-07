Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB837208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 10:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbeHGMh0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 08:37:26 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:42901 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeHGMh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 08:37:26 -0400
Received: by mail-yb0-f194.google.com with SMTP id c10-v6so6408569ybf.9
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 03:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ha5e8UwePzY429PFwuDld7sUZcHhckdxssjvCyjl5HI=;
        b=CJYZCCe+i8HH2wzuVMe62QkXn1PxJvNhmaab1r6FdcwhwlD6OrixIbVZNWfbC/5hFm
         0nVPOT8mK45tKSGxs6qbXm6JiHFqm+f2OKkbSR6fT+R6S+rXuO3FrV8hcjwFE5w0Hx3K
         kE3Guwyj2FO/EHXsHJ7NFwqO5bqaAv5gthDAOHLvNOEOOGvcXk9EK92v4XVr8ioTB/ah
         xtKS9NhhcPt8NbtRyjCqr+FkgZscL+u7wiYxeLknWRHzXRP59xjfrkCmVkScECC4DOb7
         tl3p6QB97Vt4P7rpjOSW3xyWMxpDNPZDxpWcOkCOMVnJKVVgUbbMAjOMUV0TBxI7ArV6
         O2tQ==
X-Gm-Message-State: AOUpUlH5aK0vJizNXWb1t4WwTRFF/KqFk92rmYctHKsDtQ70si1U+qfl
        0igdp4UToPzazg4JzEStPZYNpimOxlNLrKLWoFU=
X-Google-Smtp-Source: AAOMgpeJHMo2Y+sBJqG/LqbWpu6VwPLAhOh72eBEAKwh4afjRmixdUoN0KDzTEUVhD1r4510LjfXbNn5pDsJAbtYCvY=
X-Received: by 2002:a25:d349:: with SMTP id e70-v6mr6392598ybf.287.1533637427362;
 Tue, 07 Aug 2018 03:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net> <20180807093452.22524-3-phillip.wood@talktalk.net>
In-Reply-To: <20180807093452.22524-3-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Aug 2018 06:23:35 -0400
Message-ID: <CAPig+cQkY1_qDu=fdbA0gVPH88B47bM5BpgbYY8ivsj1Y0QHTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sequencer: fix quoting in write_author_script
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 5:35 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>      - Reverted the implementation to v2 with more robust detection of the
>        missing "'" on the last line of the author script based on a
>        suggestion by Eric. This means that this series needs to progress
>        closely with Eric's series of fixes or the fallback code will never
>        be called.

Thanks for working on this. I haven't read the patch closely yet, but
one thing caught my attention as I ran my eye over it...

> +static int quoting_is_broken(const char *s, size_t n)
> +{
> +       /* Skip any empty lines in case the file was hand edited */
> +       while (n > 0 && s[--n] == '\n')
> +               ; /* empty */
> +       if (n > 0 && s[n] != '\'')
> +               return 1;

To be "technically correct", I think the condition in the 'if'
statement should be ">=". It should never happen in practice that the
entire content of the file is a single character followed by zero or
more newlines, but using the proper condition ">=" would save future
readers of this code a "huh?" moment.
