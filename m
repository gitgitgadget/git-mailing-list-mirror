Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A291F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeJWGqB (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:46:01 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42127 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbeJWGqA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:46:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id u20-v6so11880732qkk.9
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SE83uMWx5TbGGKiHAZZt/sMPvEa4o7T1OCEI/UFEgNw=;
        b=ay7ahHxP1pnjtgOjLcLSbyviYohJ5NJAVR3Qy7mIXeVgnMXuhUTUalJ+Q8/rhM5Rbp
         7G17XrGeEMK6aaVck4xPRCgbN+KAVItwlmjaZAB1hfIPLmoTuy1Xbhd5Oqz6KlBK/qxk
         oDoB4/4XW/TFcjTfFf4VBlJHCn+j2VlnzEkMAdZ6X3VPJgQv5yNOx/EZyR8y5bGgIygj
         mZmBZJXm4pLYm+Es243oCJAXFbOD0wcENk3JK8KG2YpH92GTNunkJrQ/6xf0U6NsLDqd
         6L5B8pkogKHSZVpeGjOyTjaeM0B6NSCGTFhQ5ovEVod0c+LOjxquWwwoYmw8lZBoogFy
         KXiw==
X-Gm-Message-State: ABuFfohRkoqrQDiwVzHefYk03MXc8cz8rSzXrxZj5ovWIuuDSIVuabSx
        lPJLWii/8oUGhxWQGgQjB7zPpmk9Q504aDeQHkgdFQ==
X-Google-Smtp-Source: ACcGV61e00ZJ0mUHq6VU0h7Ox5MVcpi2yEI8KqTmcO+Mc1T76tMehGi1qahSVHjxXYBnNgtS2H7m68w11lXF3yF5fN4=
X-Received: by 2002:a37:ef08:: with SMTP id j8-v6mr46421849qkk.26.1540247134874;
 Mon, 22 Oct 2018 15:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.52.git.gitgitgadget@gmail.com> <pull.52.v2.git.gitgitgadget@gmail.com>
 <07140a71dd9ed3f709970f0ce5eb6aa014417b25.1540246499.git.gitgitgadget@gmail.com>
In-Reply-To: <07140a71dd9ed3f709970f0ce5eb6aa014417b25.1540246499.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Oct 2018 18:25:24 -0400
Message-ID: <CAPig+cSgRttNJTScnYaE6G2kgpFzwYMnroH=bCKtc0a2Y5CiBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rebase (autostash): use an explicit OID to apply
 the stash
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 6:15 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When `git stash apply <argument>` sees an argument that consists only of
> digits, it tries to be smart and interpret it as `stash@{<number>}`.
>
> Unfortunately, an all-digit hash (which is unlikely but still possible)
> is therefore misinterpreted as `stash@{<n>}` reflog.
>
> To prevent that from happening, let's append `^0` after the stash hash,
> to make sure that it is interpreted as an OID rather than as a number.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> @@ -253,6 +253,8 @@ static int apply_autostash(struct rebase_options *opts)
>
>         if (read_one(path, &autostash))
>                 return error(_("Could not read '%s'"), path);
> +       /* Ensure that the hash is not mistake for a number */

s/mistake/mistaken/
