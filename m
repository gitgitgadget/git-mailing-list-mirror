Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A795C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 22:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhLTWIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:08:00 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:33561 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhLTWH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 17:07:59 -0500
Received: by mail-pf1-f181.google.com with SMTP id 205so5719361pfu.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 14:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Wa1vyUGwEitQPV+5nRW2q9P4zV2RAhwAS8Y85OYBIw=;
        b=oIyASaM9kqKFj6bo3t3qOECgV2mm8Sf8e0gEtH2CT64LoDvySum/0U57apQLU01nlA
         Gv8aOdjGtD22Um5fJsMsj1iwGDaEyqgf6cuaOosFy5dS75UnUeJTx9GrF16qiP05dE0x
         bYKCOiAeOSIB0TyjEnUubqUtqegCN9ODg9r7eBp1O8N8Ia7EkuAoceZkp9l55CTCVw3v
         RhunFsTxpskHsNBC/dvkitx+Ueor9ZJ5lK4aerzOQviz0dsOi8TF7zMVHFcDH4YIFMOy
         GFxxCdes9QdTNRwqsJb6SPpbpQiawCUpkYVwkdkaVewo1RSzx1va7tp5YnfVYH7qepSf
         v1DQ==
X-Gm-Message-State: AOAM533oY790DPYaoDlQoG7Dy6MGicyxqqCoY/uIcG/CSVPnPTPdAL61
        VJBID0A9KHsfY+aRRKiiGHx/d0xy/jwOzUb8DhyNPfr+P4W4tQ==
X-Google-Smtp-Source: ABdhPJxUEh4vGE/mpsz6jy6wueMxU7Ji0ASf9S2CLxgEpyZ4oqf1YWirgEy52sZj+hdqKkwFxqDszE/vsV9mI7vWyZ4=
X-Received: by 2002:a63:e245:: with SMTP id y5mr125259pgj.139.1640038079261;
 Mon, 20 Dec 2021 14:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20211220140928.1205586-1-fs@gigacodes.de> <20211220140928.1205586-3-fs@gigacodes.de>
In-Reply-To: <20211220140928.1205586-3-fs@gigacodes.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Dec 2021 17:07:48 -0500
Message-ID: <CAPig+cRGnMQaDj-qocpAbhQqyksCNqGub+LsspWf7-Dwy=TKzg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] crypto sign: add cryptoSign.* config
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`On Mon, Dec 20, 2021 at 9:09 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> Since git now supports multiple cryptographic methods/formats to sign
> objects, the `gpg.` configuration prefix is misleading.
> Add `cryptoSign.`, but keep `gpg.` as a compatibility alias at least for
> all existing options.
> `gpg.mintrustlevel` is moved to `cryptosign.gpg.mintrustlevel` while
> also still allowing the former.
> ---
> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> @@ -1,6 +1,17 @@
> +cryptoSign.format::
> +gpg.format::
> +       Specifies which key format to use when signing with `--crypto-sign`.
> +       Default is "openpgp". Other possible values are "x509", "ssh".
> +
> +cryptoSign.<format>.program::
> +gpg.<format>.program::
> +       Use this to customize the program used for the signing format you
> +       chose (see `cryptoSign.format`). The default value for

This is a somewhat minor comment, but I find that grouping these
config keys together like this gives too much weight to the old
`gpg.foo` ones, making it seem as if they're still first-class
citizens which people can use freely. If you instead organize them as
below, then it is easier to see at a glance that the old keys
shouldn't be used:

    cryptoSign.format::
        Specifies which key format to use when signing...

    cryptoSign.<format>.program::
        Use this to customize the program used...

    ...

    gpg.format::
        Deprecated synonym of `cryptoSign.format`.

    gpg.<format>.program::
        Deprecated synonym of `cryptoSign.<format>.program`.

The same observation about grouping of config keys applies to the
remainder of the documentation changes in this patch.
