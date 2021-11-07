Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218EFC433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 01:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AA460EFE
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 01:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhKGB6F convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 6 Nov 2021 21:58:05 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:44960 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhKGB6E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 21:58:04 -0400
Received: by mail-ed1-f45.google.com with SMTP id j21so47333553edt.11
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 18:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LBnkvs5Ate6zpcizdq7ZV/y8yRa6HNRQQ18UZMvycCU=;
        b=temzwvoIANogt6yoLs7a/K6rAwm+yKrItbBqm8LO5pRBq0kpGYFyHiI8WjK0xSZcTL
         kxGRqF2BsIsYQl6AEHn2tx4V4ke2za4eHYI/YUHyljD4XnXQkZYrmx729starnk2dXHW
         u8hmv6A4Xzyz8vBHC8Zor2O/enw3f0HDThi5mJ/o9W5I8xz5aBdPd7+StYERWjqvIPff
         4w6bPqzxD+uxoFRyp8Z2lYl7QAhWBvZqHsk746T+9HZ8NK5usmIO4dNgfhxFkcuEY4NL
         mZPCsDa4odO6SowcWcwFUnSqIimKLGwwVJbtrhPuUM+9LkpaCJgRKOmovb/R8k/7KqpT
         Hj+Q==
X-Gm-Message-State: AOAM533DhJnD6ggNC4X39Ao9MANy2pUP+8kWBm8VCvdS60uC/nSJ4inc
        ImcWFUY0fKGThPeSwr0qtjw/LN5EaKqbmD8BxFn+Q1isPro=
X-Google-Smtp-Source: ABdhPJxHD1KZ9Rmy0szdizRILGVm4/twJMLl4kYuJbPd5Q9FcBJt/u8+8zLFBDWy7CN5bBpt/982DpKR12tLl2Ro+is=
X-Received: by 2002:a50:e0c3:: with SMTP id j3mr93019718edl.97.1636250121538;
 Sat, 06 Nov 2021 18:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <patch-07.16-24c8f42aa7d-20211106T205717Z-avarab@gmail.com>
In-Reply-To: <patch-07.16-24c8f42aa7d-20211106T205717Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Nov 2021 21:55:10 -0400
Message-ID: <CAPig+cScGUVDnApjQUz90Pm3_MTiUwD1HgX_DP2gc=TQ3ChkeQ@mail.gmail.com>
Subject: Re: [PATCH 07/16] Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 6, 2021 at 5:03 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Create a new "GIT-PYTHON-DEFINES" file, and untangle the dependency
> issues of the Python by copying over the patterns established for
> building the adjacent Perl code in preceding commits.
>
> As with Perl, there's no real reason to depend on GIT-BUILD-OPTIONS or
> GIT-CFLAGS when building the Python code, nor did we need
> GIT-PREFIX. Let's instead add those variables we care about to a
> "GIT-PYTHON-DEFINES".
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> @@ -2369,18 +2369,14 @@ GIT-PERL-DEFINES: FORCE
> +# Under NO_PERL=Y we'll still make GIT-PERL-DEFINES. We need to depend
> +# on NO_PERL=Y itself for creating "unimplemented.sh" scripts.
> +PYTHON_DEFINES =
> +$(SCRIPT_PYTHON_GEN): GIT-PYTHON-DEFINES
> +ifdef NO_PYTHON
> +PYTHON_DEFINES += $(SHELL_PATH_SQ)
> +PYTHON_DEFINES += $(NO_PYTHON)

The comment above this new Python-related goop is talking about PERL?
Is that intentional?
