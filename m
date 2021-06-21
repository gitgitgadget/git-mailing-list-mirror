Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C59DC48BDF
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 02:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEEF6100B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 02:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUCMg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 20 Jun 2021 22:12:36 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:41862 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFUCMg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 22:12:36 -0400
Received: by mail-ej1-f48.google.com with SMTP id ho18so26015412ejc.8
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 19:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=wKw3NzwpTw9dXCx6dpJpDMo4Q1oWPBYu/BRQOFipwKQ=;
        b=jso+AiR7z6kptpWzAr2TxuUlRXpHU76I0BD14T08zSHGurO8A/5ilRqY8f+gzKaBs/
         H8c0XKQ+k7jH6TuqjjNcv8qBBSwHvGL4GDLWr9b8G+TimztC6rKAogvDxLra931S5xNz
         UCbS8Omni0f56k3TkbkVBWgF8cHZwiqpx3UlFW47l1820oTxRyHdETKXwg3lXAfONwVS
         CWIy7YcJyq9vE+x7MDicmWZB2/3962LhHMHJGv3cyVYL9YDlE/lwUfbytDv6eJwSHcJn
         pWJedi02uv6Ob0dp5N+zAzXTct2ROigC/OFhisiOGB5h0X/RViV2tpby7QHN1Iyb3Cqg
         VRZQ==
X-Gm-Message-State: AOAM533ChPJkChXEona3cb7D8F8Fjzj3ULOUAKXRMX4OWLXZUHFIaATP
        vQcvhys44fa8UxTyfzYKnFfCf3oaJirj7qC9TdE=
X-Google-Smtp-Source: ABdhPJwHHxu4CoxIYvizy0ozymw6CXLKizNVzAoRfNm804ZsuDDrDEl8N40EI9B87ozeYTtXfcmbHzwKyGt5gV/Ohmk=
X-Received: by 2002:a17:906:3c44:: with SMTP id i4mr8861096ejg.371.1624241421240;
 Sun, 20 Jun 2021 19:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210620213836.10771-1-rhi@pengutronix.de> <877dio3vg5.fsf@evledraar.gmail.com>
 <YM/yqPsRutV2mUbb@camp.crustytoothpaste.net>
In-Reply-To: <YM/yqPsRutV2mUbb@camp.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 20 Jun 2021 22:10:10 -0400
Message-ID: <CAPig+cQa3JC-YkGeB-NDy-iP=Mv8BRL6jyXTGXzaqpTLcxj8+w@mail.gmail.com>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Roland Hieber <rhi@pengutronix.de>,
        Git List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 10:00 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2021-06-21 at 00:35:49, Ævar Arnfjörð Bjarmason wrote:
> > On Sun, Jun 20 2021, Roland Hieber wrote:
> > > Currently, calling 'git bisect' from a directory other than the top
> > > level of a repository only comes up with an error message:
> > >
> > >     You need to run this command from the toplevel of the working tree.
> >
> > How does this affect out-of-tree scripts that will be run with "git
> > bisect run", is the cwd set to the root as they now might expect git to
> > check, or whatever subdirectory you ran the "run" from?
>
> As for the idea itself, I think it's a good one assuming everything
> continues to work.  It will certainly be more convenient for a lot of
> people.

There have been multiple patches sent to the project over the years
with the same purpose. One problem, I believe, which has never been
fully addressed is what happens when the subdirectory from which
git-bisect is run gets deleted as part of the bisection.

Here are a couple recent threads triggered by previous such patches
(but there are probably several more):

https://lore.kernel.org/git/pull.765.git.1603271344522.gitgitgadget@gmail.com/
https://lore.kernel.org/git/pull.736.git.git.1584868547682.gitgitgadget@gmail.com/
