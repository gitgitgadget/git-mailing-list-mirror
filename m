Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B46EC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 06:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhLQGJl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 17 Dec 2021 01:09:41 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:38509 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhLQGJl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 01:09:41 -0500
Received: by mail-pj1-f41.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso4748704pjf.3
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 22:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UOCw6M5pRZTC4h2ZXJiNHL43WcgbKu0XbKvjHIUaFQU=;
        b=Nl3e9LKWQFA+OaLCsYYuVds0L/nZ7+/Spqfp8YE7UAcqhvbyB3ADyF/bmR2nEfvA6j
         K4xMeUenY9MuVjt6CtsklPAxFfYqMbS5YnfGanPBKNcfQgpMCVs7rWltLHqiL5fdUQ+7
         Pnd2tY3XkzBlIwWSUIuVPZAGlcCbhftPiZvDWQbXndEwoJzaLdyEQlLlRF8n4ENHne/K
         ppKIGfVEm4MOappSxt4n3s62+Ynwj05baf+7ADuwH/BGTWHL6Exy/QRlhpk45fPSqtPM
         p/5mUfxF6yhFqHK7V4GZFYlnJz3phEO1Z3Tc9cT3s0qy35V3GI9aSb6yYp5LiEebh0j7
         hBVQ==
X-Gm-Message-State: AOAM531IIbLvVIaXrTGZubGhHjyh5RCfVc99JAgMXi70NdyFnKIDUwZ0
        eL0Dpq0Q8xKp7KrSFWvI7+4cKl0hspVVVI7THz4=
X-Google-Smtp-Source: ABdhPJyfQw8NyVCBKino9OTy1JB8zYPNcNXESKzke5gMmpPkUSLCZ8GSO8E3BdnMjfl528U3BAwyg5OV3bfgXHqS/zA=
X-Received: by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP id
 u7-20020a170903124700b00143b9b952a2mr1845296plh.35.1639721380921; Thu, 16 Dec
 2021 22:09:40 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com> <patch-8.8-aca560ca410-20211217T012902Z-avarab@gmail.com>
In-Reply-To: <patch-8.8-aca560ca410-20211217T012902Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Dec 2021 01:09:30 -0500
Message-ID: <CAPig+cQt47U9E8kUFiTBecEPcTaLhRCi5X_T=nPqZM-HJR=n0g@mail.gmail.com>
Subject: Re: [PATCH 8/8] Makefiles: add and use wildcard "mkdir -p" template
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16, 2021 at 11:40 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> But as it turns out we can use this neat trick of only doing a "mkdir
> -p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
> of a performance test similar to thatnoted downthread of [1] in [2]
> shows that this is faster, in addition to being less verbose and more
> reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):

s/thatnoted/that noted/

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/shared.mak b/shared.mak
> @@ -90,3 +92,18 @@ ifndef V
> +## Is racy, but in a good way; we might redundantly (and safely)
> +## "mkdir -p" when running in parallel, but won't need to exhaustively
> +## individual rules for "a" -> "prefix" -> "dir" -> "file" if given a
> +## "a/prefix/dir/file". This can instead be inserted at the start of
> +## the "a/prefix/dir/file" rule.

Is there a word missing between "exhaustively" and "individual"?
