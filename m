Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB7C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B7365227
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 16:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCHQoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 11:44:32 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:42124 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCHQoK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 11:44:10 -0500
Received: by mail-ej1-f54.google.com with SMTP id c10so21643357ejx.9
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 08:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3OE5dlBHTpS9q8NX1v6Zy1gUYuJ39HPmg/LAXFVWPc=;
        b=Fs197XI9KKycmU+VZbMuCt9F+Yr/O7OP9bG9PdeGdLNTu93ed5jtuymbeIFh+40lHg
         7MGMHkr1KV6xQ0pul+EeB2TfZjmcG+w2OQaRUwSrNWCfk+VLu18KxQ8di0GAmXYdPq2p
         zcOi40C8X9jto+dC7m9GT9TNUc0TXp+jt8POCdSKBLd5mLQw2wHcbAybg+gK5RDRwwPI
         ZSlFFOaazrt39HXUC4J/v3G5WX4E+IkUb3LAOW+mLVkELWiBAtuq3twE+tGWwzFDTQ5T
         iydrf0CoS5e5jy3YbdZ/6h9y+zSxMIr54CrTamQuF/rLm4iWfqdaBoBQy4YnYKHOP7Yl
         lReQ==
X-Gm-Message-State: AOAM532ixWey1LBgm5DdqZdb/At+vdcZyu93ixK46HGZqLcdwQtU+Tc2
        WSWfpbiz/NUAp2oHRpfVB0x88XbHNch//wjeX8s=
X-Google-Smtp-Source: ABdhPJw1LGNBoZKiJ9Zp7ENakGbhDtFOrcJHYXjtkh/hIo95aIXKb9bsRf9WSRfCW7x3Y5kTUZ4eQdyGMvtJkGuzq9M=
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr16424098ejc.231.1615221849361;
 Mon, 08 Mar 2021 08:44:09 -0800 (PST)
MIME-Version: 1.0
References: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com> <20210308131718.546055-1-sandals@crustytoothpaste.net>
In-Reply-To: <20210308131718.546055-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 Mar 2021 11:43:58 -0500
Message-ID: <CAPig+cRoZPg96aSgPoswYf-fz1_1Hxc1NfAER0kUB8Hy00WB9Q@mail.gmail.com>
Subject: Re: [PATCH] builtin/init-db: handle bare clones when core.bare set to false
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, jvusich@amazon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 8:18 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In 552955ed7f ("clone: use more conventional config/option layering",
> 2020-10-01), clone learned to read configuration options earlier in its
> execution, before creating the new repository.  However, that led to a
> problem: if the core.bare setting is set to false in the global config,
> cloning a bare repository segfaults.  This happens because the
> repository is falsely thought to be non-bare, but clone has set the work
> tree to NULL, which is then dereferenced.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Perhaps this deserves a:

    Reported-by: Joseph Vusich <jvusich@amazon.com>

> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> @@ -104,6 +104,13 @@ test_expect_success 'redirected clone -v does show progress' '
> +test_expect_success 'clone does not segfault with --bare and core.bare=false' '
> +       test_config_global core.bare false &&
> +       git clone --bare "file://$(pwd)/parent" clone-bare &&

Can this be done more simply as:

    git clone --bare parent clone-bare &&

or even:

    git clone --bare . clone-bare &&

without mucking about with $(pwd)?

> +       git -C clone-bare rev-parse --is-bare-repository >is-bare &&
> +       test "$(cat is-bare)" = true

These days, we'd probably say:

    echo true >expect &&
    git -C clone-bare rev-parse --is-bare-repository >actual &&
    test_cmp expect actual

but it's subjective and minor; not at all worth a re-roll.
