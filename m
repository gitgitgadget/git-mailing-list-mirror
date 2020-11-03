Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61523C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C9820786
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgKCSpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:45:51 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43003 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCSpu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 13:45:50 -0500
Received: by mail-ej1-f66.google.com with SMTP id i19so14682717ejx.9
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 10:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCfchY8vKoomyZEejPlW+riTkD0t8tF072SJA8TKKgw=;
        b=NIfmnyYYfbH5dbYwOycM1KYUwbzyT0jyf9Av7KCiKCZP5r6VRA9E4dJvd4bbtpkzus
         7WGFJpxHuO6oneL6XPZsrVgAhi20Y/XNEX+Z7eT1E/z5IwrPxrtmMl7KUyuaR2RKs0xl
         Ls2yWr6b4oHizgWOOIpy64qKuPObkf8u/qI/htCVQOZCTsBn+xAIlqGtu/cZ+cnk8mVP
         PAEP6OdtIAnow82MPOX3uK0H/E4mrGiwudCD+CdhpsPIMK9+KsON6RkQTrcSOsuM74Wa
         F8IpHymnaMyzMqxsF4Hv7B0U0OnuShu669nirlS4JiULgX+YK5rF/Q+MHUWGoTle1xTF
         Y2PQ==
X-Gm-Message-State: AOAM5302Kpwz/LwHR6QotVxkesWEniZiPm+v0+RiyxgDzqsFe+oxmWSx
        eZxSqwOExiPeXiaq8Glq/VL0nPBQL1fEwbjtBIU=
X-Google-Smtp-Source: ABdhPJxP/K4PuObz2lNr6cJKyiOyZTbyfsssLW2EfrUE4oERMQgQ+U06shxOqkrANURne2chhAXhQZhRb03MjV+/opU=
X-Received: by 2002:a17:906:c357:: with SMTP id ci23mr2737886ejb.311.1604429147699;
 Tue, 03 Nov 2020 10:45:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.git.1604412196.gitgitgadget@gmail.com> <832fdf16872cbfee4a5e15b559b2b40dabd545f4.1604412197.git.gitgitgadget@gmail.com>
In-Reply-To: <832fdf16872cbfee4a5e15b559b2b40dabd545f4.1604412197.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Nov 2020 13:45:36 -0500
Message-ID: <CAPig+cR1zSqY_y02JBdtjh_+9Pp2dOtGrHHmf-ah5sU6Lhzp6Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] maintenance: use launchctl on macOS
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 3, 2020 at 9:05 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> maintenance: use launchctl on macOS

A few comments below (not necessarily worth a re-roll)...

> The launchctl command needs to be aligned with a user id in order
> to initialize the command environment. This must be done using
> the 'launchctl bootstrap' subcommand. This subcommand is new as
> of macOS 10.11, which was released in September 2015. Before that
> release the 'launchctl load' subcommand was recommended. The best
> source of information on this transition I have seen is available
> at [2].

It's not clear whether or not this is saying that git-maintenance will
dynamically adapt to work with modern and older 'launchctl'. A glance
at the actual code reveals that it knows only about modern
'bootstrap'. Perhaps this could be a bit clearer by saying that it
only supports modern versions, and that support for older versions can
be added later if needed. (For those of us who are stuck with 10-20
year old hardware and OS versions, 2015 isn't that long ago.)

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -1491,6 +1491,214 @@ static int maintenance_unregister(void)
> +static int bootout(const char *filename)
> +{
> +       int result;
> +       struct strvec args = STRVEC_INIT;
> +       char *uid = get_uid();
> +       const char *launchctl = getenv("GIT_TEST_CRONTAB");
> +       if (!launchctl)
> +               launchctl = "/bin/launchctl";
> +
> +       strvec_split(&args, launchctl);
> +       strvec_push(&args, "bootout");
> +       strvec_pushf(&args, "gui/%s", uid);
> +       strvec_push(&args, filename);
> +
> +       result = run_command_v_opt(args.v, 0);
> +
> +       strvec_clear(&args);
> +       free(uid);
> +       return result;
> +}
> +
> +static int bootstrap(const char *filename)
> +{
> +       int result;
> +       struct strvec args = STRVEC_INIT;
> +       char *uid = get_uid();
> +       const char *launchctl = getenv("GIT_TEST_CRONTAB");
> +       if (!launchctl)
> +               launchctl = "/bin/launchctl";
> +
> +       strvec_split(&args, launchctl);
> +       strvec_push(&args, "bootstrap");
> +       strvec_pushf(&args, "gui/%s", uid);
> +       strvec_push(&args, filename);
> +
> +       result = run_command_v_opt(args.v, 0);
> +
> +       strvec_clear(&args);
> +       free(uid);
> +       return result;
> +}

The bootout() and bootstrap() functions seem to be identical except
for one string literal. Code could be reduced by refactoring and
passing that string literal in as an argument.

> +static int remove_plist(enum schedule_priority schedule)
> +{
> +       const char *frequency = get_frequency(schedule);
> +       char *name = get_service_name(frequency);
> +       char *filename = get_service_filename(name);
> +       int result = bootout(filename);
> +       free(filename);
> +       free(name);
> +       return result;
> +}

The result of get_service_name() is only ever passed to
get_service_filename(). If get_service_filename() made the call to
get_service_name() itself, it would free up callers from having to
remember to free(name), thus reducing the likelihood of a possible
leak.

> +static int schedule_plist(const char *exec_path, enum schedule_priority schedule)
> +{
> +       plist = fopen(filename, "w");
> +
> +       if (!plist)
> +               die(_("failed to open '%s'"), filename);

You can replace the fopen() and die() with a single call to xfopen().

> +       /* bootout might fail if not already running, so ignore */
> +       bootout(filename);
> +       if (bootstrap(filename))
> +               die(_("failed to bootstrap service %s"), filename);

I'm guessing that 'launchctl bootout' won't print a confusing and
unexpected error message if the plist is not presently registered?

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -389,12 +389,58 @@ test_expect_success 'stop from existing schedule' '
> +test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
> +       echo "#!/bin/sh\necho \$@ >>args" >print-args &&
> +       chmod a+x print-args &&

Note that $@ loses its special magic if not surrounded by quotes, thus
acts just like $*. So, either use "$@" or $* depending upon your
requirements, but in the case of 'echo', it's just not going to matter
at all, so $* is fine.

To construct the script, you can do this instead, which is easier to
read and handles the 'chmod' for you:

    write_script print-args <<-\EOF
    echo $* >>args
    EOF

> +       for frequency in hourly daily weekly
> +       do
> +               PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
> +               grep schedule=$frequency "$PLIST" &&
> +               echo "bootout gui/$UID $PLIST" >>expect &&
> +               echo "bootstrap gui/$UID $PLIST" >>expect || return 1
> +       done &&

My gut feeling is that this would be more robust if you manually
determine UID in the test script the same way as the git-maintenance
command itself does using '/usr/bin/id -u' rather than relying upon
inheriting UID from the user's environment.

> +       # stop does not remove plist files, but boots them out

Is this desirable? Should git-maintenance do a better job of cleaning
up after itself?
