Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01575C433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 00:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB0C217A0
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 00:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgL0AfX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 26 Dec 2020 19:35:23 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:42204 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgL0AfW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Dec 2020 19:35:22 -0500
Received: by mail-ej1-f50.google.com with SMTP id d17so9920417ejy.9
        for <git@vger.kernel.org>; Sat, 26 Dec 2020 16:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8TdFmm89mykux1vkAXCsJmiX9NfIaOk537BDNyx2Fgo=;
        b=eHNfTk2VuiEQ0H9sTCemBu4pW1qYbk1GO+rzGtNZuW7pEDbv0sAqoaJk5LwjQ/YHEJ
         DmvfPUPM0ER+NeKLHjqQdj90BrKn9pp04KEgN1t6+Psvu978HqC/AI6hBgKl5ySv9Xcr
         CBzES5qO6koYKLrILe/8ys6xJaWanoknvlVo0WmnKtTtvNGKYBxP4oIkrYg8Ol/+V18J
         PTfLHcY/8BkC3Ur8ZT4MdxuIEwNu4lX6P3O/cvgUWoGzuO8c802zlbq4RnvzGbSCRKxY
         BEAh3RMnYu3s09GzUj3FDYZUGRDK5xzQ0O92jyRTPnpQYQLJrFKKFbHsbBB5Bn3BQtC3
         Fgzg==
X-Gm-Message-State: AOAM531Vp9erzTBE/jJNX6WQ9lQN7R4RZesq0fB5CJaezk/FdrEj3OJb
        tFitgXVCmsPVEPDuLsbVtfaz99zCFTkwEE9+4pM=
X-Google-Smtp-Source: ABdhPJwUJHyhF+RPB63w1vyJwRpUOXp3XRiSBaeFuzCoCYENaJitF1jdpl6ltxfyeZ/9R8LIwFz5qIw5UW3WPlnGEUw=
X-Received: by 2002:a17:906:6b88:: with SMTP id l8mr36482680ejr.482.1609029280837;
 Sat, 26 Dec 2020 16:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20201226134420.722643-1-Jeremie.Detrey@altu.fr>
 <xmqqeejcqlpq.fsf@gitster.c.googlers.com> <X+e48UEE4wf3fMNI@pica>
In-Reply-To: <X+e48UEE4wf3fMNI@pica>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 26 Dec 2020 19:34:30 -0500
Message-ID: <CAPig+cQqObQj6djn_EvfurbwsEKuU2fB+GZ8EE1HA-Hn1hUkuQ@mail.gmail.com>
Subject: Re: [PATCH] git-remote: load config whenever create_symref() might be called
To:     =?UTF-8?B?SsOpcsOpbWllIERldHJleQ==?= <Jeremie.Detrey@altu.fr>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Shulhan <m.shulhan@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 26, 2020 at 5:31 PM Jérémie Detrey <Jeremie.Detrey@altu.fr> wrote:
> Junio C Hamano:
> > My gut feeling says that the best place to call git_config() on
> > git_default_config would actually be in cmd_remote(), immediately
> > before we call parse_options() to parse the main options shared by
> > all subcommands of "git remote".  Is there a reason why codepaths
> > other than the three you singled out should *not* be affected by the
> > basic set of configuration variables?
>
> No, none that I can think of. I'll leave more knowledgeable people
> than me confirm this, but if that's the way to go, I'll be happy to
> submit a revised patch following your suggestion :)

I took a quick look at builtin/remote.c. It appears that several of
the subcommands already make their own calls to git_config(), each
with its own special-purpose `config_fn_t` as argument. Jérémie's
patch, which invokes git_config() for specific cases, therefore, is
consistent with existing practice in that file. Taking the approach of
calling git_config() once before parse_options() should be possible
but would require more surgery. The end result after surgery likely
would be more maintainable going forward, but the localized fixes his
patch makes might be reasonable in the short term. (But I'm not an
area expert, so don't take my word for it.)
