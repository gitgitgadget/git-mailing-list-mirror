Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685E7C4332F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 19:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481A761184
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 19:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhIUTIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:08:02 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:45821 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhIUTIB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 15:08:01 -0400
Received: by mail-ed1-f48.google.com with SMTP id c22so187941edn.12
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 12:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bHI18FenQxNOvbTeR62c0Hy/Lim3lGMY6fvBgbv1lc=;
        b=6ClG/DTd1sXe+cehBv5gxK93j7gnCKryANkv0mEQCcK+nNpX8489wF4RWfT9ZLodtB
         /WJHZCMend9euJbMfZ9pe4u4EI/tQ7QpWM0a7wWN8qe4LOshx5ofxZoEWpyZRvwJkHSf
         uEXhgrG6u2mTMpSdhthQkAnFbdrkqAkSSoC+zPD2oKcz+zjyqyf4IEN8XQu3RgquK1jv
         UAGvNDzRzaHKQVo6nQNAUSSSuO2/RwtDVD8RvcXEj5joMtkGKWexyaD+K1LbLlLg7S41
         1tTJo/zJWZ3MY3JwwzTs169QY/xhT2P71M8n5vUn8dj3+f72GD/Nb5Rklcju4WiMP1zo
         DlRw==
X-Gm-Message-State: AOAM532u0WvU5qkyFqY6MtyC8AM24ViF1I/gwYXlDlhjqdveNcBrzF3j
        RA6qKt+7tCkbdjvscn/LFW4kMLLyi6LVqaEUOiWTQVbO
X-Google-Smtp-Source: ABdhPJzffV3zqvBJtejPEy9L0W6/2xYn8qK1DKwDswFn9P+1so6JUvzsqiFsclQ5RRpScFmggjkETd57KB4KTaZd+vE=
X-Received: by 2002:a50:9d09:: with SMTP id v9mr36364373ede.70.1632251191724;
 Tue, 21 Sep 2021 12:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
In-Reply-To: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Sep 2021 15:06:20 -0400
Message-ID: <CAPig+cS6DZ5DtSpvdrjjQVs5f=pCKkNwaGxU558Qvt50mi9z-A@mail.gmail.com>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Daniel Stenberg <daniel@haxx.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 2:41 PM Jeff King <peff@peff.net> wrote:
> When HTTP/2 is in use, we fail to correctly redact "Authorization" (and
> other) headers in our GIT_TRACE_CURL output.
>
> We get the headers in our CURLOPT_DEBUGFUNCTION callback, curl_trace().
> It passes them along to curl_dump_header(), which in turn checks
> redact_sensitive_header(). We see the headers as a text buffer like:
>
>   Host: ...
>   Authorization: Basic ...
>
> After breaking it into lines, we match each header using skip_prefix().
> This is case-insensitive, even though HTTP headers are case-insensitive.
> This has worked reliably in the past because these headers are generated
> by curl itself, which is predictable in what it sends.

Did you mean "This is case-sensitive..."?

> But when HTTP/2 is in use, instead we get a lower-case "authorization:"
> header, and we fail to match it. The fix is simple: we should match with
> skip_iprefix().
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
