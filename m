Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E09AC1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 21:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527B820738
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 21:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCQVLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:11:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51303 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCQVLz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 17:11:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id a132so896764wme.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 14:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37DjID8Th0sQ0OJRveFgYnDz97qjws3vtM3oq2S93IA=;
        b=sO9ra2gfTz8yd0sogTQM1NFIv6kyLNDbZCLdq1dAF2YrnjyhuvYIPeBdlBjNIhKR4+
         bFM7nEt96DzJvqfRtYb/EbGTGtuxk21mzY5snLr8CgXSYh6e7IgmHWX5yv03t149THmv
         sqZDPmFWbzu1/0+fr2yZxKVbp93oUdnG9Q0B1H+aP+Ie16TSsKH/JP84Fld/YkfokFGB
         KhPiI/U+a5nb88A1SVaou3nGKGq5t0EA2wwYMOKjliaj8JJA4i6j1UBoPFBeO5G6bliz
         /5p/6q8ApXEdfJd1YnfkSCOspJ0rA2TTM+M+DHtPFZTLfA67oYmFmTcLlm3PydDFWuqI
         WKnQ==
X-Gm-Message-State: ANhLgQ0rzJiLmKtRLk5HfQQue95KruiY5pnGJ/e2YF4R4FfOU3/u34qz
        +WY7qKiqQmU1ulsPMaMnRqmIBDdEVrEKrbArws6Memnp
X-Google-Smtp-Source: ADFU+vvWYUHWGDg/SWC8d3AdxgfMVpE8RwThmt7nFwiKab9SnpvjqG29sHtFnR3yl58Ez6+0wNgxps84nb7TyXBcyGY=
X-Received: by 2002:a1c:5401:: with SMTP id i1mr902974wmb.177.1584479513419;
 Tue, 17 Mar 2020 14:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com> <888d9484cf4130e90f451134c236a290a6c5e18d.1584477196.git.me@ttaylorr.com>
In-Reply-To: <888d9484cf4130e90f451134c236a290a6c5e18d.1584477196.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Mar 2020 17:11:42 -0400
Message-ID: <CAPig+cRgnqmwCCjFV32K_ysawHBkJN_y6=Do_oKXjjpy0BSvUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] upload-pack.c: allow banning certain object filter(s)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, james@jramsay.com.au
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 4:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> NB: this introduces an unfortunate possibility that attempt to write the
> ERR sideband will cause a SIGPIPE. This can be prevented by some of
> SZEDZER's previous work, but it is silenced in 't' for now.

s/SZEDZER/SZEDER/

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> @@ -235,6 +235,29 @@ test_expect_success 'implicitly construct combine: filter with repeated flags' '
> +test_expect_success 'upload-pack fails banned object filters' '
> +       # Ensure that configuration keys are normalized by capitalizing
> +       # "blob:None" below:
> +       test_config -C srv.bare uploadpack.filter.blob:None.allow false &&

I found the wording of the comment more confusing than clarifying.
Perhaps rewriting it like this could help:

    Test case-insensitivity by intentional use of "blob:None" rather than
    "blob:none".

or something.

> +       test_must_fail ok=sigpipe git clone --no-checkout --filter.blob:none \
> +               "file://$(pwd)/srv.bare" pc3
> +'
