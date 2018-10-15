Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766EA1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJOV4L (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 17:56:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34627 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeJOV4K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 17:56:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id p6-v6so11903562qkg.1
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 07:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3Y2dL1DmsUcYhsl5Po1jOoT+j+BGYIQicYHfjjWf3w=;
        b=ibhrvhjjPeUd5sta7+4aHG0xmsaTyF61XRpsY4booUf2ed6XdfWQwQx6OXmDDkgJ8Q
         HyVr/jsLKkCL8pwyM1CZoGa1Q0glPaOCft+Jc5Viwteuh8PJviDkGqRca5jXTqpMlVYM
         N8PaYJag3t+whPuPvMKx4fd/uMygMMutWNWEFcXcemX39kaQINub0c33ycAJMC+McxRe
         yn19vbKrk9ILeEq1XhqvjoiG3LLfyVFTo+36XN7fbu24vThiqf95e1xcMb1UykoaasoQ
         uSaMmJT9/AVYp/8pGB08Xj78+Af9Zfn3pJnh57qRakU3JWoP0bh/MDjw3KIJMOAkz/e+
         Aorw==
X-Gm-Message-State: ABuFfohZrZyFejRmBjjuomW6wqjtyrlS5Rw8gPKebGwl1tYab40nZU98
        w9C3ilrWMdxCAAUrR4KRQhD/E/GlTPrDUYwN2KaViw==
X-Google-Smtp-Source: ACcGV61xCsCbBG2G9MGZB2P/DrO7lMi+kWGa57VIwNpAyh0pTLL5Cc5XWwJQBc19FgM7DHYiKdVvWvQSk5dEhVg9Y1I=
X-Received: by 2002:ae9:e20b:: with SMTP id c11-v6mr15612531qkc.220.1539612643070;
 Mon, 15 Oct 2018 07:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.46.git.gitgitgadget@gmail.com> <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
In-Reply-To: <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Oct 2018 10:10:32 -0400
Message-ID: <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks
 in cURL
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        github@brendanforster.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 6:14 AM Brendan Forster via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This config value is only used if http.sslBackend is set to "schannel",
> which forces cURL to use the Windows Certificate Store when validating
> server certificates associated with a remote server.
>
> This is only supported in cURL 7.44 or later.
> [...]
> Signed-off-by: Brendan Forster <github@brendanforster.com>
> ---
> diff --git a/http.c b/http.c
> @@ -811,6 +818,16 @@ static CURL *get_curl_handle(void)
> +       if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
> +           !http_schannel_check_revoke) {
> +#if LIBCURL_VERSION_NUM >= 0x072c00
> +               curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
> +#else
> +               warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
> +                       "your curl version is too old (>= 7.44.0)");

This message is confusing. If your curl is too old, shouldn't the ">=" be a "<"?

> +#endif
> +       }
