Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726A81F516
	for <e@80x24.org>; Mon, 25 Jun 2018 23:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933521AbeFYXwq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 25 Jun 2018 19:52:46 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:35722 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFYXwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 19:52:45 -0400
Received: by mail-yb0-f178.google.com with SMTP id x15-v6so2603033ybm.2
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 16:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qEPD5hcwP2QGkSiD2YSvlbmSOWEl542y9YGidF+W3g4=;
        b=oWtSY56oWfZTcv+KxOG7mJFHvE799SlZOx0nSerhYCSh4rVVRAs7nkJ8e8d3F5B98K
         HdFgCpZKSHQeILRz1pyueIxRtjZKZdB2PLs3zDsw7aETSkt9VOUnS/O8barLzaARLgaX
         eh6xGaW9h8r+IHOAH7jo2FC5X08T1MWk7TIYtuG/snppIqU9jeLm3JNG0wdLnt32l41U
         dn7T9FsVNxTEqadXbJXA1A5ybxcFb4jjGzSzMxDm32vx39ETkT887lTdN/s8Xedf9Qf4
         ZYprncXMReoKjDuSeFcGMsoPCivhXxutilMZ8McJx1xTvXsCcToyhslZlGlBR33RCdzw
         ZvdQ==
X-Gm-Message-State: APt69E0EX0okMzuPWUPJsmWFBso6ud6rXa6LG1o1Y9QPKNr7W6SunVeN
        1qunnXw7Eraw9BAUBavYc2ScddyvLfCTlffRk7I=
X-Google-Smtp-Source: ADUXVKJgMKPfBBX1V+kj0F8nAhdnA4MRFSXbTltD8wUVZNIup9UsHTaTb8KuUYW6aIcWhWyyoQzw0SOBaubJK+AXl+M=
X-Received: by 2002:a25:c04b:: with SMTP id c72-v6mr7295109ybf.12.1529970764894;
 Mon, 25 Jun 2018 16:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180625143434.89044-1-dstolee@microsoft.com>
 <20180625143434.89044-12-dstolee@microsoft.com>
In-Reply-To: <20180625143434.89044-12-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Jun 2018 19:52:32 -0400
Message-ID: <CAPig+cRWwTAFRJOwQOi4USk5UZke=2sz_JVDh3+XRKCcBGD5ow@mail.gmail.com>
Subject: Re: [PATCH v2 11/24] midx: read pack names into array
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 10:35 AM Derrick Stolee <stolee@gmail.com> wrote:
> diff --git a/midx.c b/midx.c
> @@ -210,6 +227,20 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
> +static size_t write_midx_pack_lookup(struct hashfile *f,
> +                                    char **pack_names,
> +                                    uint32_t nr_packs)
> +{
> +       uint32_t i, cur_len = 0;
> +
> +       for (i = 0; i < nr_packs; i++) {
> +               hashwrite_be32(f, cur_len);
> +               cur_len += strlen(pack_names[i]) + 1;
> +       }
> +
> +       return sizeof(uint32_t) * (size_t)nr_packs;
> +}

This static function is never used, thus breaks the build with DEVELOPER=1:

    midx.c:567:15: error: ‘write_midx_pack_lookup’ defined but not used
        [-Werror=unused-function]
    cc1: all warnings being treated as errors
