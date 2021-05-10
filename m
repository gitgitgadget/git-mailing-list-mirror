Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B928C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 02:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB8F613D0
	for <git@archiver.kernel.org>; Mon, 10 May 2021 02:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhEJCte convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 9 May 2021 22:49:34 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:42688 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhEJCtd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 22:49:33 -0400
Received: by mail-ed1-f51.google.com with SMTP id j26so13242854edf.9
        for <git@vger.kernel.org>; Sun, 09 May 2021 19:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTXzHYX6dh79jhTHkO4MV4M8Wysna17B2PVdID3V+gw=;
        b=kPFoDieEcP1WwjBJCa66LjF/aT4sTl1WDTDR3v9qNB2vd+KnZoZEjEegTJFN22s7RA
         npHuKaz26Bg8b7C1jx+1Vm2Dw6IhC0CmIXwQPvddEmCAYE8Mz+vnQoeW3+5mMB1Wzr1r
         DgiwJAaHNI7/4lzKJg9Q31AKlU+uz2hP7y5Re0lDNl4mlG/8/ncII5zGNXJDgg1FpdJ5
         QSNJlAbRRH9hom4Y85V3Vo7crSfGEWc5vK+Kk0REm0HipS3H/O1fvw+j9FwkRn7AMLPA
         /NRKvYrpsyM9Hg933sjwP6owT+XndHQrJBfZi0VXAO82/WwyQ56Ge7VYljBV6IL/AG3P
         GGTg==
X-Gm-Message-State: AOAM533NXtvcARf6m4ZgPtJMU9ooYxmOrqlzMo7k3Pu0A+wLhwATCYD6
        dmRde/mYQrJqNEheofnWQ9y4Yqq5SBziNRsuJUyYda0tbso=
X-Google-Smtp-Source: ABdhPJwzFal8A27fxtucMxrtVriWRz2xybAN040E4r60tEgN72sRZott75d4tRnWQFAn+VDb9vea8YGuaZ4WytRy908=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr27264197eds.291.1620614908615;
 Sun, 09 May 2021 19:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210501145220.2082670-1-lenaic@lhuard.fr> <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr> <YJiKXRywBhhGXC5Q@danh.dev>
In-Reply-To: <YJiKXRywBhhGXC5Q@danh.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 May 2021 22:48:17 -0400
Message-ID: <CAPig+cQdU_0uPKDkbuz3XqdYePAMNPcF_u+Enx+qfgRGvtiseA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 9:20 PM Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2021-05-09 23:32:17+0200, Lénaïc Huard <lenaic@lhuard.fr> wrote:
> > +static int systemd_timer_delete_units(const char *cmd)
> > +{
> > +     return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, cmd) ||
> > +            systemd_timer_enable_unit(0, SCHEDULE_DAILY, cmd) ||
> > +            systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, cmd) ||
> > +            systemd_timer_delete_unit_templates();
> > +}
>
> Argh, we're disabling those systemd timer units first, by passing 0 as
> first argument of systemd_timer_delete_units.
>
> The fact that I read that twice, and still wrote down above reply
> makes me think that above code is not self-explanatory enough.
> May we switch to something else? Let's say using enum?

This is modeled after existing scheduler functions in this file, in
which the `enable` argument is a simple 0 or 1, so changing this to an
enum just for this function would be inconsistent. Changing all the
functions to `enum` in a preparatory patch could indeed improve
readability, however, that's tangential cleanup which may be outside
the scope of this submission.

> > +     file = xfopen(filename, "w");
> > +     free(filename);
>
> I'm sure if we should use FREE_AND_NULL(filename) instead?
> Since, filename will be reused later.

Indeed, probably a good idea, as it would make catching mistakes easier.

> > +            "ExecStart=\"%1$s/git\" --exec-path=\"%1$s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
>
> I think others have strong opinion on not using "%1$s",
> and prefer simple "%s" and using "exec_path" twice instead.

I brought it up only because I hadn't seen it in Git sources, and
wasn't sure if we'd want to start using it. Aside from Ævar, who
seemed reasonably in favor of it, nobody else chimed in, so it could
go either way, I suppose.

> > +test_systemd_analyze_verify () {
> > +     if test_have_prereq SYSTEMD_ANALYZE
> > +     then
> > +             systemd-analyze verify "$@"
> > +     else
> > +             true
>
> The "else" leg is not necessary.

This was patterned after the existing test_xmllint() function in this
file which has the `else true` leg. I wrote test_xmllint(), so I'll
take blame. But you're right, the `if` will return success if the
prerequisite is not set, so the `else` leg is indeed not needed.
(Cleaning up the test_xmllint() function is outside the scope of this
patch.)

> > +test_expect_success 'start and stop Linux/systemd maintenance' '
> > +     write_script print-args <<-\EOF &&
> > +     echo $* >>args
>
> To avoid any possible incompatibility with zillion echo implementation
> out there. printf should be prefered over echo. Not a in this test
> case, however, it costs us nothing anyway.
>
>         printf "%s\n" "$*"

This, too, is patterned after existing auxiliary scripts created by
these test functions, and you're correct that it's potentially
dangerous. A manual inspection of all the existing instances shows
that `echo $*` happens to be safe for those cases but that doesn't
excuse being sloppy about it, so the existing cases probably ought to
be cleaned up. But, again, that is outside the scope of this series.
For this particular case, though...

> > +     for frequency in hourly daily weekly
> > +     do
> > +             echo "--user enable --now git-maintenance@${frequency}.timer" >>expect || return 1
> > +     done &&
>
> And here, we can have a nicer syntax with printf:
>
>         printf "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
>
> With printf, we don't even need "rm -f expect" above.

... you're quite correct that `printf` is the way to go both here and
in the generated `print-args` script since these arguments start with
hyphen.
