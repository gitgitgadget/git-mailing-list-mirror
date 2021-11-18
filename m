Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32DFC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C74D6142A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhKRWRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:17:30 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44733 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhKRWR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 17:17:29 -0500
Received: by mail-ed1-f54.google.com with SMTP id l25so17153218eda.11
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iop7l/Hi9SaMo797z0EaZCObriKlmtFanuGuvQu65MM=;
        b=gLOV6f/m6eL2ZGJzU89g5F8vfeYm2ulF+p6xO5I+mmnADf7eJaMwOsj+rXJ8WktvzD
         ai3aLar8LTn/0g6g9JasePBh8C/s7NFXntqzFSaTrskl9LC9ovNTX/ehm75PrC81NTu9
         W5tnK36KzlqdGIQy4i8jv6IgFva+nCr2Z/lf2qeGkn3CnxP9ok+zqu1+612iVKpvzD2D
         P19QMTLC2dygnTgh4exUBUjrxiagHEs+DP73Rw+Ctwy5llWRS2S9vtIhKnDE73tCkz0u
         MbfByy8/z+S7zvZUp0EEQmYI/i/lH7rXXPmZ0puh6gXe71K37huSTauke12X5Ss0Bcsq
         hPYg==
X-Gm-Message-State: AOAM530tUFdZqBrG+gLZe7s5xqeYV40rFVN6uancuH95W7CBVmxutYC+
        vMzNamJIocxBf/cWRtdy/wpzH1yrD94oROvd/yg=
X-Google-Smtp-Source: ABdhPJwBugIumaZ2hxSCRMm+ljzxeej53q2gO8jHNHJnGq0nHKpY3m6y6NATnOXpd4iAlJu1hNiaa9BJxTyGp19zhfM=
X-Received: by 2002:a50:d49d:: with SMTP id s29mr16723974edi.55.1637273667561;
 Thu, 18 Nov 2021 14:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20211117162727.650857-1-fs@gigacodes.de> <20211118171411.147568-1-fs@gigacodes.de>
In-Reply-To: <20211118171411.147568-1-fs@gigacodes.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Nov 2021 17:14:16 -0500
Message-ID: <CAPig+cTVX5yYp-1eUjCgj6aox9vYpzm+JFvson37M0R_pnxRvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ssh signing: support non ssh-* keytypes
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 12:14 PM Fabian Stelzer <fs@gigacodes.de> wrote:
> The user.signingKey config for ssh signing supports either a path to a
> file containing the key or for the sake of convenience a literal string
> with the ssh public key. To differentiate between those two cases we
> check if the first few characters contain "ssh-" which is unlikely to be
> the start of a path. ssh supports other key types which are not prefixed
> with "ssh-" and will currently be treated as a file path and therefore
> fail to load. To remedy this we move the prefix check into its own
> function and introduce the prefix `key::` for literal ssh keys. This way
> we don't need to add new key types when they become available. The
> existing `ssh-` prefix is retained for compatibility with current user
> configs but removed from the official documentation to discourage its
> use.

I think we usually avoid removing documentation for something which is
still supported (even if deprecated) for the very real reason that
people will still encounter the old form in the wild, whether in
configuration files, in blogs, or elsewhere, and may be perplexed to
discover that the form is not documented (thus not understand how or
why it seems to be working). Instead, we can discourage its use by
mentioning clearly that it is deprecated and that `key::` should be
used instead.

> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> @@ -36,10 +36,10 @@ user.signingKey::
>         This option is passed unchanged to gpg's --local-user parameter,
>         so you may specify a key using any method that gpg supports.
> -       If gpg.format is set to "ssh" this can contain the literal ssh public
> -       key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
> -       corresponds to the private key used for signing. The private key
> -       needs to be available via ssh-agent. Alternatively it can be set to
> -       a file containing a private key directly. If not set git will call
> -       gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the first
> -       key available.
> +       If gpg.format is set to `ssh` this can contain the path to either
> +       your private ssh key or the public key when ssh-agent is used.
> +       Alternatively it can contain a public key prefixed with `key::`
> +       directly (e.g.: "key::ssh-rsa XXXXXX identifier"). The private key
> +       needs to be available via ssh-agent. If not set git will call
> +       gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the
> +       first key available.

Thus, perhaps this text could end with:

    For backward compatibility, a raw key which begins with "ssh-",
    such as "ssh-rsa XXXXXX identifier", is treated as "key::ssh-rsa
    XXXXXX identifier", but this form is deprecated; use the `key::`
    form instead.
