Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47119C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74752075F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgIYUUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgIYUSx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:18:53 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26936C05BD41
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 13:10:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q13so274061ejo.9
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 13:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSNRW2mJ+38Y9IikZXLZZQnzgQGSXFBMXGBqA+7W3ng=;
        b=EAZYnXCoY/CUN7zWA1POqBzFU1i1WtH4W2yEBDaZyMLIVyFXq0rGwIhJA15nKCVTCO
         7k/9nNSnRA0XAVspWWYlmm/ZHTFxFliNu7QbugDYG9hvOOOnJ5ef9AZE3HISfoBNRFQi
         k002pukbx9zDMVlR40zxxZzBxaPkDZeBOLKZOKw/4VNnPDxIF1/g5tijijPPtnXqywML
         Ml9zXRmznft7yztfamg/V65++J4REyL/gSk3dvHOfyrZg7QIXSL91ggr3hfhiFXFO1Y9
         pbeXRtqsLsgZcT2zP2HZWWC9DW6QBoCwcMRdQ/wXhOx0arVhwdwIxb+ZsUgAx5vRLQSI
         vnng==
X-Gm-Message-State: AOAM532OIJkqabnqglFW+yQcBA+RvUL/cZOa3uWBrpeGPU/MBLKd0FvU
        cckE+1/AHXll1nkMLY2WovDdZyNLAYgegTQnv/IDc+fl
X-Google-Smtp-Source: ABdhPJyWjPq4rkpXvwIy+vhApmSmFR08vhmfx3dNja8oOdGZbyFFztPhCjULL7hlxGC7ILve0hNgQgzdg9KQwHT45LU=
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr4408823ejq.138.1601064315616;
 Fri, 25 Sep 2020 13:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200925070120.GA3669667@coredump.intra.peff.net> <20200925070211.GB62741@coredump.intra.peff.net>
In-Reply-To: <20200925070211.GB62741@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 16:05:04 -0400
Message-ID: <CAPig+cTfYmNAP_65RDa_fZOyuQEH65HuLs-UYSPT0yJ=s6BftA@mail.gmail.com>
Subject: Re: [PATCH 2/8] shortlog: refactor committer/author grouping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 3:02 AM Jeff King <peff@peff.net> wrote:
> In preparation for adding more grouping types, let's
> refactor the committer/author grouping code. In particular:
>
>   - the master option is now "--group", to make it clear
>     that the various group types are mutually exclusive. The
>     "--committer" option is an alias for "--group=committer".
>
>   - we keep an enum rather than a binary flag, to prepare
>     for more values
>
>   - we prefer switch statements to ternary assignment, since
>     other group types will need more custom code
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> @@ -47,9 +47,18 @@ OPTIONS
> +--group=<type>::
> +       By default, `shortlog` collects and collates author identities;
> +       using `--group` will collect other fields.
> +       `<type>` is one of:
> ++
> + - `author`, commits are grouped by author (this is the default)
> + - `committer`, commits are grouped by committer (the same as `-c`)

I had trouble interpreting "(this is the default)". It made me think
that <type> is optional:

    --group[=<type>]

but that isn't the case at all. Instead, it means that if --group
isn't specified, then grouping is done by `author` by default. It also
repeats what the general description of --group already says with
regard to the default, thus it is redundant to say it again when
describing the `author` type. Therefore, perhaps drop "(this is the
default)" altogether?
