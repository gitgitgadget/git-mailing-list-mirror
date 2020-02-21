Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28FC35641
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 22:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D39E20722
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 22:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBUW2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:28:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36463 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUW2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 17:28:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so3721785wru.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 14:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Xad03dqk1b+t+4478wu8QhzY1Drlg+LJ0oFpIu9Y64=;
        b=qlMpV0OD1DeW3zMKu47BfXdrMg/kv7/j+dnzXWwqcx5gZVDDJ1+G2QJ9ckKW7YKmMO
         oHlP2sX7RW+nSS7J65yqGt7gzu7oCUCrQra/peh2F3+X68d+DDYJdjrkde7rUz1WeMGg
         m06j+mNhotY02jyVLdXTZJdYixxItgKy7qo8lfHVwsQAcQvne0ToHTj36zcHS4/TpaOe
         XQ4QQjtH0hGrpJbt0esfyXAhA2lFApJbDS4jf0eqqqGEXs/82KqdYd/U21MFEClieHCk
         sjR4js1vsCkc9Y3OcBzV/dwg+/MSuQWJbgkxVsgOK/gT6yvAP7+90cPpLsARlo4/BrJo
         J4kQ==
X-Gm-Message-State: APjAAAUD3reNWJZT8GPwrqea8Cj24Zo+zVjyshaq9gGQPC+aRNej+82C
        AgwdV3WV5uM3RElDSAqpzn/82O2FHXB4ahN46E8=
X-Google-Smtp-Source: APXvYqz4j8NfTzBm7U3LEHQhAH+hlVscjQlgmGOERdClPFQhagHdnNGQxmqmpfjvTONkFL0o0dsVypNCf7TlREG7iG4=
X-Received: by 2002:a5d:5752:: with SMTP id q18mr52851399wrw.277.1582324131517;
 Fri, 21 Feb 2020 14:28:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.559.git.1582321003.gitgitgadget@gmail.com> <3cf866d0384a0743e6625dd4e5124f00a5db5e7d.1582321003.git.gitgitgadget@gmail.com>
In-Reply-To: <3cf866d0384a0743e6625dd4e5124f00a5db5e7d.1582321003.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Feb 2020 17:28:40 -0500
Message-ID: <CAPig+cRYCC9MvAgVecEuvK1wqvWpVWS0ipmKPMKSctFbjHThvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] http: add client cert for HTTPS proxies.
To:     Jorge Lopez Silva via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jorge <JALopezSilva@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 21, 2020 at 4:37 PM Jorge Lopez Silva via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Git currently supports performing connections to HTTPS proxies but we
> don't support doing mutual authentication with them (through TLS). This
> commit adds the necessary options to be able to send a client
> certificate to the HTTPS proxy.
> [...]
> Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
> ---
> diff --git a/http.c b/http.c
> @@ -1018,9 +1046,23 @@ static CURL *get_curl_handle(void)
>  #if LIBCURL_VERSION_NUM >= 0x073400
> -               else if (starts_with(curl_http_proxy, "https"))
> +               else if (starts_with(curl_http_proxy, "https")) {
>                         curl_easy_setopt(result,
>                                 CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
> +
> +                       if (http_proxy_ssl_cert != NULL) {
> +                               curl_easy_setopt(result,
> +                                       CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
> +                               }
> +                       if (http_proxy_ssl_key != NULL) {
> +                               curl_easy_setopt(result,
> +                                       CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
> +                               }
> +                       if (http_proxy_ssl_key_passwd != NULL) {
> +                               curl_easy_setopt(result,
> +                                       CURLOPT_PROXY_KEYPASSWD, http_proxy_ssl_key_passwd);
> +                               }
> +                       }
>  #endif

All the closing braces in this hunk seem to be over-indented. Also,
all of the braces for the one-liner 'if' bodies can be dropped, thus
making it less noisy.
