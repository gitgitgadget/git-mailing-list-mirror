Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C981F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 05:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932097AbeGFFEc (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 01:04:32 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38403 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbeGFFEb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 01:04:31 -0400
Received: by mail-yb0-f194.google.com with SMTP id i9-v6so4098996ybo.5
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 22:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+sXWJdaIMTknxzHm8ulJaGp5TSclDsc0XHhqk8mS+Q=;
        b=ejAH+HXge0XEOAYJvk2xNTazLd3B3OiTshOsjJ+TK6gmCXSbZJSTSOgBmC8FoCyH1U
         k2LP8LAmRI+Mx9RpmKrBF/65F55q+sZK7doO8qhwVbHNgz4hVAkZlEAWMuIp52rfgdNN
         ReozaD8MzYb8o8jcsnqWXgK22TbFTt77sBjoRNNHEpCLESQHWOR62l4r9RdsveA89978
         iVGkWAF6O0bSkiEUXTTj0bxSyVit0DuoB90ok9gg4A+peT5DwQR/3qAFnRM3/vpljPIY
         G1iyHtTTZrp+EDgY2xjHHwZzF0lSdYtt+jqw7oe8irZ/+BE5OSPhKAVmd5XRANtynNYo
         e4LA==
X-Gm-Message-State: APt69E3e78mRU2tJLmGxFsY1ba0pQ+z8U4gGDA6bXbd96FBJfpz+r+FD
        dzEm33rDPxHHVH4AASWY4TQT7HhhqPSoDohEx58=
X-Google-Smtp-Source: AAOMgpfFffp2Jcs8Ea0LY4w9nqXAQxsOOzLPG7+rAqmcOVBILmzywfHvZxo5D95yc+ZiEn3zl6YqScH8D9M2269RO2s=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr4430161ybf.287.1530853471187;
 Thu, 05 Jul 2018 22:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-14-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-14-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 01:04:20 -0400
Message-ID: <CAPig+cRK0GWVueJgM-DKSFSJxiE5OhN98F8ZXkBDnLwrVSDFMA@mail.gmail.com>
Subject: Re: [PATCH v3 13/24] midx: write object ids in a chunk
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/midx.c b/midx.c
> @@ -18,9 +18,10 @@
> @@ -384,6 +391,32 @@ static size_t write_midx_pack_names(struct hashfile *f,
> +static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
> +                                   struct pack_midx_entry *objects,
> +                                   uint32_t nr_objects)
> +{
> +       struct pack_midx_entry *list = objects;
> +       uint32_t i;
> +       size_t written = 0;
> +
> +       for (i = 0; i < nr_objects; i++) {
> +               struct pack_midx_entry *obj = list++;
> +
> +               if (i < nr_objects - 1) {
> +                       struct pack_midx_entry *next = list;
> +                       if (oidcmp(&obj->oid, &next->oid) >= 0)
> +                               BUG("OIDs not in order: %s >= %s",
> +                               oid_to_hex(&obj->oid),
> +                               oid_to_hex(&next->oid));

The above two lines are arguments to BUG(), thus should be indented more.

> +               }
> +
