Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56168C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA7E6147E
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhEJS0m convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 May 2021 14:26:42 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:46906 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhEJS0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 14:26:41 -0400
Received: by mail-ed1-f41.google.com with SMTP id r11so5003325edt.13
        for <git@vger.kernel.org>; Mon, 10 May 2021 11:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kz858ZU3ZNgWCBisXHhnUjg0aDi21L/v15V6PBgagsg=;
        b=qOcmKdfAt6B0IJjNLuVivfgWUINPbYhOCv7YsEKFC/6n9vzCzYULYz5oagc/DxX+jx
         bFo+MqqFPO+w85FzMJAc47A53ffhm7sk/UFly5xIr1lk8byIqs0Vy1OiPefhvmslRuZe
         dNNbeHEhnJwDB8YdyLIyAYQBjDQonxyBhYZPwv03q/uSTVx6CfsPTVJ09GVcX4XHY8Ij
         tpdee/Ka5qArRqW68v5IqlM85fLicGOXBCOTIe0lZyERJBdMm3xvfQ2uMXL6Hjqqb0d/
         ZMvOXAcQbASpyWUrisKkAZ1NlPs/UgwRFPIBEkD/bKECHcRIKWN5Onw63/R9l5aVDwEt
         KJCQ==
X-Gm-Message-State: AOAM531LmrFq5pOyB0PCXjtI0z5j6JN2LvqUjUm+Pmc5HKh3AnhSuubF
        6flF3U+MTF9ZsucvzE1ZrYYqtrZcFPZYJ/RvnBk=
X-Google-Smtp-Source: ABdhPJwIQMZpeTZgvKDmK2nCrc/Gl40x8AWA6opxI7WvJW1LjQTOen0tMV8Xx6zIyJfi2ILJsIP9PUXnKd61J0UDDOg=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr31651919eds.291.1620671134930;
 Mon, 10 May 2021 11:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210501145220.2082670-1-lenaic@lhuard.fr> <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr> <3fd17223-8667-24be-2e65-f1970d411bdf@gmail.com>
In-Reply-To: <3fd17223-8667-24be-2e65-f1970d411bdf@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 May 2021 14:25:23 -0400
Message-ID: <CAPig+cRvs+d-Tv4WyuD967v5Pbfhmwj-ruwyBXhwcR=5chQAmQ@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 2:04 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 09/05/2021 22:32, Lénaïc Huard wrote:
> > +static int systemd_timer_enable_unit(int enable,
> > +                                  enum schedule_priority schedule,
> > +                                  const char *cmd)
>
> The cmd argument is pointless, it will always be "systemctl" and you
> have even hard coded that value into the error message below.

The reason that `cmd` is passed around everywhere is that the actual
command can be overridden by GIT_TEST_MAINT_SCHEDULER which allows the
test script to mock up a scheduler command rather than running the
real scheduler command. I haven't read the new version of the patch
closely yet, but after a quick scan, I'm pretty confident that this is
still the case (despite the aggressive changes the patch makes to the
areas around GIT_TEST_MAINT_SCHEDULER).

As for hardcoding the command name in the error message, that seems
perfectly fine since, under normal circumstances, it _will_ be that
command (it's only different when testing).
