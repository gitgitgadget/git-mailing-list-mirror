Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C31C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2658E61469
	for <git@archiver.kernel.org>; Mon, 10 May 2021 20:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhEJUyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 16:54:11 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:38683 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhEJUyG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 16:54:06 -0400
Received: by mail-ej1-f48.google.com with SMTP id b25so26516949eju.5
        for <git@vger.kernel.org>; Mon, 10 May 2021 13:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhePuW5aEibr04IXOHFZuKQR1wO4OswUEFLQCdQyAqA=;
        b=mmvGVnot0HjfNhKS6xQv9FSgyKsNMCyyd6c/qkK4Ga0rTc+nrPWb8mFI1wsXMf2Z/S
         LzNOZInDS+nYAKc5xrO5oHMMddDT0N86q6jm6tLsnEGL0LQ+AUkwbXs++8QHcX4EHvAp
         Vvht2GCrcnaUIYFezoAekzIIkf5wnsVOz4F5BDOXvOP5jL7BK6A8LRB6j6shLRRn19IL
         UrLY/M3wq2Y5YSPWNGp8gw/Ve1ivD17f4YFvHdvJifLvMUs/R6LDKsH1XHAwDyLP76wJ
         nt6aw4PcM3FuEv1110hSBmDoTZoVwK7UmakdVpIDKer5MLMVWTcyIckLqy8zccglWECj
         cFlg==
X-Gm-Message-State: AOAM532Xwscz/zZoyCDBFa8pkcfcmniFIbIJQuSZ3JQBBaZPAEFk2UH5
        OmjssXkK7NvJrk+jRdbtlersTv48fqPItevVPS5eIlhY
X-Google-Smtp-Source: ABdhPJwJKgyxSQ1x9OJ7lBXpTyt/kf+ti7XPoDG9DvaqXGpGx/4Y6p0/PapXfQkABVq/pnAwic3IS23fDbJMQ5B7PFo=
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr28266051ejc.231.1620679980549;
 Mon, 10 May 2021 13:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210501145220.2082670-1-lenaic@lhuard.fr> <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr> <3fd17223-8667-24be-2e65-f1970d411bdf@gmail.com>
 <CAPig+cRvs+d-Tv4WyuD967v5Pbfhmwj-ruwyBXhwcR=5chQAmQ@mail.gmail.com> <72be08d4-1b2d-f400-f99d-c348ae667bdb@gmail.com>
In-Reply-To: <72be08d4-1b2d-f400-f99d-c348ae667bdb@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 May 2021 16:52:49 -0400
Message-ID: <CAPig+cTmWBMJctFpfWe_Fw5w5oo_jMuLOSSXGs_o=tD89uAzkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 4:09 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> It is outside the scope of this patch but a possibly nicer pattern would
> be to have a function get_command_name(const char *default) that checks
> GIT_TEST_MAINT_SCHEDULER and returns the command name from that or the
> default if it is not set. We would then call that function to get the
> command name when we want to run a command. That way all the extra
> complexity is localized around the command call (and consists of a
> single function call), the usual command name is visible in the function
> calling the command and we'd avoid littering all the function signatures
> with a argument that is only relevant for testing.

Yup, that would be a nice eventual cleanup. I agree that it is outside
the scope of this submission.
