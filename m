Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C7C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB4C2076E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgJ3DAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:00:05 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:40985 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgJ3DAB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:00:01 -0400
Received: by mail-ej1-f65.google.com with SMTP id s15so6606217ejf.8
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6T9sHxU9vYt5AFbO949EsfSug0WvuvKsfgujgKIQ44=;
        b=foF2CziIi0K1G6tYsiY1c4OpTu+JCYhm47syxOK3ZszrmZ+68ErQZAqQPsS5fEUVFb
         ZtJyDPdR05unhFGhZDMar5uC6R+NkY1RkEQlKSY8M7hwI5ngVzJhb0HjNCj6hyKu1ypB
         cDJJypTaDIomd/wUZ5UrLBpJvVLjlcWUd6kY1YVZecFO/YltHFaXDjMCwhND1O+FWXM1
         zDivzMe9lmUPoCpWuURT0N0xnRURSfRl5BWKEZkcxwFZpLLummKMIOPxVy3aBpAc/E5M
         guZ8zv4QHeA7Z/33f1O7J1FSu/tXjVr6jqH1AQoeEJh4RWP/EJq0cvtH7f8RTDsVXOZR
         OeYw==
X-Gm-Message-State: AOAM5314J0COEYbq/Q/TZy4Xvu69mrwqeDcW/pJX+p/AFSN0PHTM84em
        8bAbSAaocc0kvenN9zxPktr1nUS3kgY0g2jytFb+pLvw
X-Google-Smtp-Source: ABdhPJzIk+TV3OLFgXu9tdwzcwBr8fRF3uti71XlK2f5P7FaeLSW0ZSpzcij5PiusHHgPrEyZcv51WIAHDDR/UykG0M=
X-Received: by 2002:a17:907:43c3:: with SMTP id i3mr368497ejs.231.1604026799377;
 Thu, 29 Oct 2020 19:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
In-Reply-To: <1604022059-18527-1-git-send-email-dan@mutual.io>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Oct 2020 22:59:48 -0400
Message-ID: <CAPig+cTOkd248WKh5KyVfScRf8fqcOQPj4V3waGQ3XWEcugiKg@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to haves
To:     Daniel Duvall <dan@mutual.io>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 9:51 PM Daniel Duvall <dan@mutual.io> wrote:
> [...]
> Instead, upload-pack should gently peek for an EOF between the sending
> of shallow/unshallow lines (followed by flush) and the reading of client
> haves. If the client has hung up at this point, exit normally.
>
> Signed-off-by: Daniel Duvall <dan@mutual.io>
> ---
> diff --git a/t/t9904-upload-pack-stateless-timely-eof.sh b/t/t9904-upload-pack-stateless-timely-eof.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +
> +test_description='stateless upload-pack gently handles EOF just after want/shallow/depth/flush'
> +
> +. ./test-lib.sh
> +
> +D=$(pwd)

What is the purpose of this assignment? It doesn't seem to be used
anywhere in this script.

> +test_expect_success 'upload-pack outputs flush and exits ok' '
> +       test_commit initial &&
> +       head=$(git rev-parse HEAD) &&
> +       hexsz=$(test_oid hexsz) &&
> +
> +       printf "%04xwant %s\n%04xshallow %s\n000ddeepen 1\n0000" \
> +               $(($hexsz + 10)) $head $(($hexsz + 13)) $head >request &&
> +
> +       git upload-pack --stateless-rpc "$(pwd)" <request >actual &&
> +
> +       printf "0000" >expect &&
> +
> +       test_cmp expect actual
> +'
> +
> +test_done
