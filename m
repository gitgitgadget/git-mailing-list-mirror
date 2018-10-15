Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CE31F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeJOVvx (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 17:51:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44700 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeJOVvw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 17:51:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id c56-v6so21518643qtd.11
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 07:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KQday2OVmKN5rUY6/jVC0hWcF5vpTg5g1PLoo/SVLU=;
        b=iW3aNzvDfv2fDUxLtArx03KHtGyz42Cu/gfXgnjjDZIh4M7mhetRvZwzPt/Cl/nLoe
         6MSUCwptAH2gj15yFFOd6c3yT/oYTfGrawcmWAFAszolsjvcSFlCq04Lk1HePinHsxaV
         2O8odlndHuR3AOKZEgHFcppk3Ya+qda/PVE+lId23Yox5HMmgmg9vDu+35kq8txHZ/JK
         unXhxXusmG8yr7xU0X1eUj+3tfj4haHRVZMht/sDZDn/VQxzFf8ATgFUCmGCAoqLGCWI
         ZPM8yC6nPOnu0JfXwrcjh6ZCT+BEbN6tpCs5fm9hVw1F0O+i9iDPgO1VZL8Mk0tE7b7K
         TuYw==
X-Gm-Message-State: ABuFfogFDnvyqdK5gquP1LEB08Q/2jWXZZsk1duKY6mR0dzS8Tg+3i9G
        oxq+50ETiCswMSThoWzOnlB+Na/vyou+vN9iGbA=
X-Google-Smtp-Source: ACcGV61kZieBxQ0ZjUcNSQfQZlCjd0j4zuaR3HnlpH2Ln9JDrFACjKvvjEXDw8b/opWuVLqt+EmufIzyoJBADUgfwDg=
X-Received: by 2002:a0c:8a08:: with SMTP id 8mr8489674qvt.203.1539612385833;
 Mon, 15 Oct 2018 07:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.46.git.gitgitgadget@gmail.com> <8c5ecdb6c9a73405036672db8bc1e36c5c6c6951.1539598481.git.gitgitgadget@gmail.com>
In-Reply-To: <8c5ecdb6c9a73405036672db8bc1e36c5c6c6951.1539598481.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Oct 2018 10:06:14 -0400
Message-ID: <CAPig+cT2K9hCTaLbTW-3ueKV6vaokkLiVSUvZ7yZ+sncZnjvNw@mail.gmail.com>
Subject: Re: [PATCH 1/3] http: add support for selecting SSL backends at runtime
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 6:14 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This patch adds the Git side of that feature: by setting http.sslBackend
> to "openssl" or "schannel", Git for Windows can now choose the SSL
> backend at runtime.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/http.c b/http.c
> @@ -995,6 +1003,33 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
> +#if LIBCURL_VERSION_NUM >= 0x073800
> +       if (http_ssl_backend) {
> +               const curl_ssl_backend **backends;
> +               struct strbuf buf = STRBUF_INIT;
> +               int i;
> +
> +               switch (curl_global_sslset(-1, http_ssl_backend, &backends)) {
> +               case CURLSSLSET_UNKNOWN_BACKEND:
> +                       strbuf_addf(&buf, _("Unsupported SSL backend '%s'. "
> +                                           "Supported SSL backends:"),
> +                                           http_ssl_backend);
> +                       for (i = 0; backends[i]; i++)
> +                               strbuf_addf(&buf, "\n\t%s", backends[i]->name);
> +                       die("%s", buf.buf);

This is the only 'case' arm which utilizes 'strbuf buf', and it
die()s, so no leak despite a lack of strbuf_release(). Okay.

> +               case CURLSSLSET_NO_BACKENDS:
> +                       die(_("Could not set SSL backend to '%s': "
> +                             "cURL was built without SSL backends"),
> +                           http_ssl_backend);
> +               case CURLSSLSET_TOO_LATE:
> +                       die(_("Could not set SSL backend to '%s': already set"),
> +                           http_ssl_backend);
> +               case CURLSSLSET_OK:
> +                       break; /* Okay! */
> +               }
> +       }
> +#endif
