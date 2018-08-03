Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1191F597
	for <e@80x24.org>; Fri,  3 Aug 2018 06:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeHCIiS (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 04:38:18 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:32820 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeHCIiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 04:38:18 -0400
Received: by mail-yw1-f65.google.com with SMTP id c135-v6so593775ywa.0
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 23:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3A+x3/+tuVXWAjadzDnhsCTlP6VA7fVQwEaA74owy0=;
        b=KArNb2tB7uTPPuzpHYNU5GGlRT+bTSIm1jJnfVLcuV/eb5b0nY8dT4MXqpAp9hk6AW
         eZ4uXDw0Pqu7xEBNu32avAI9qRGTzUNjUKlywFDHxYd3HU15MRj6a8ZON8GuA1ipkA5V
         oBoJFEQTwzECi/bubkotNMg4lYH0RCWl9KrS/GymRdEemmuIYNuyShWSX6rNgH/sDQiV
         ng18ZFPWzn5/Dz2C58wLIteGQArxs9/afXulpUO/HuC30RjHURVJ4RFaPlGdfNOxaFqS
         lRSlfN7zGDyOd2Ojs1LHVJsZZ+YIO6OI+mn26t9DIQve8VYEN3CVLYyCPmUYH+Ow2nad
         YPaQ==
X-Gm-Message-State: AOUpUlH8p2YrLtLYkQL2bVPQ3dNJx7RLl14i9tUTvaBCbmHDyxdi2UOF
        yhQCFbImoHKCgMSrow6jl+29v9NiP0wvwxKnhiQ=
X-Google-Smtp-Source: AAOMgpdQmdGxtPO8kwn6nCuxW9X0FrdbwqYBhaCKuWQy4zFiR19gK9TV30XtcPUiKuesfdo1KFcc7nvBBzUsRPt4z6I=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr1404606ywc.70.1533278609642;
 Thu, 02 Aug 2018 23:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180802093208.27420-1-sunshine@sunshineco.com> <20180803060749.GA237521@aiede.svl.corp.google.com>
In-Reply-To: <20180803060749.GA237521@aiede.svl.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Aug 2018 02:43:17 -0400
Message-ID: <CAPig+cTbXt30ic+6T32zRRfBRAZo6LtgS+XGQ_Tw7UtFkbHYew@mail.gmail.com>
Subject: Re: [PATCH] color: protect against out-of-bounds array access/assignment
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 2:26 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Sunshine wrote:
> > +     if (fd < 0 || fd >= ARRAY_SIZE(want_auto))
> > +         BUG("file descriptor out of range: %d", fd);
>
> The indentation looks wrong here.

Yep, that's weird. I can't figure out how that got indented with four
spaces rather than a TAB. I just re-typed the entire change in my
editor as I believe I typed it earlier, and the editor correctly
auto-indented it with a TAB. Odd. Thanks for catching it.

> Combining that with the other suggestions from this thread, I end up
> with this v2:

This looks good to me. Thanks. And, if needed:

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

(patch left unsnipped)

> -- >8 --
> From: Eric Sunshine <sunshine@sunshineco.com>
> Subject: color: protect against out-of-bounds reads and writes
>
> want_color_fd() is designed to work only with standard output and
> error file descriptors and stores information about each descriptor in
> an array. However, it doesn't verify that the passed-in descriptor
> lives within that set, which, with a buggy caller, could lead to
> access or assignment outside the array bounds.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  color.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/color.c b/color.c
> index b1c24c69de..ebb222ec33 100644
> --- a/color.c
> +++ b/color.c
> @@ -343,6 +343,9 @@ int want_color_fd(int fd, int var)
>
>         static int want_auto[3] = { -1, -1, -1 };
>
> +       if (fd < 1 || fd >= ARRAY_SIZE(want_auto))
> +               BUG("file descriptor out of range: %d", fd);
> +
>         if (var < 0)
>                 var = git_use_color_default;
>
> --
> 2.18.0.597.ga71716f1ad
