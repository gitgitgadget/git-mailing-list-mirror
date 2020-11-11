Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23EEC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 08:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B6F206B5
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 08:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgKKIMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:12:34 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46340 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKIMe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 03:12:34 -0500
Received: by mail-ed1-f43.google.com with SMTP id t11so1293399edj.13
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 00:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TchOnsFESQjzVLVU5MSvnSTx2dJac7BBfrb/aB6lQ9c=;
        b=i0hZ7zOFkUdhuiynIFvt53Ft0V6h6hh0bgBfzOpUXu+aftO/RbGwRZMdGr5GgmGUDy
         8T8jKCb0dZL2SPp5vEnInXvwbia7L+5zt2jY0MAgyh778pgUhSaDWAZ3WXdUa+6d8zK0
         dE+1+bqWiws8rJhVlisMPZl1cNFUZ+GOTlKfgVk32LC+i5SzybiNxFZWKfxkh4RVgDfA
         YoC2XKdedw0lPtBDBf4k5WGvN2QzrBXB/Wgce5aE87xQOM5mVdWav9Q1ZeDu5alpgcM9
         0Zacgm84+MnaE+a7XfEXHTbf3FsLpnKzo7odfMLLuOnDSqyvlq4dcL57sguPdtH6Y2dR
         zMmA==
X-Gm-Message-State: AOAM531qFOGLYHLPDvvE4OAa0185wzjtZUvJmPKR4wE0F7pEGVrjkkc0
        hj+bn3mMZlIgiG54152YyiVY9Glajau77xL/lT4=
X-Google-Smtp-Source: ABdhPJyJUEl53IWCKPp61N9fXRWtLhqWnqFmpjKPZZ7Q3fBuDX+PbZAQa9KApxwLAnlrm5gFhml5IuhGulb9w+iiSIU=
X-Received: by 2002:a50:fc89:: with SMTP id f9mr3869413edq.89.1605082350955;
 Wed, 11 Nov 2020 00:12:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <pull.776.v2.git.1604520368.gitgitgadget@gmail.com> <0fafd75d100f343f7cff6471772ed9b12793f81e.1604520368.git.gitgitgadget@gmail.com>
In-Reply-To: <0fafd75d100f343f7cff6471772ed9b12793f81e.1604520368.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Nov 2020 03:12:19 -0500
Message-ID: <CAPig+cT=DytbMH6KkC6ipD3jbWNa7jgW9G0Q76rwJoEsLGn_ow@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] maintenance: use launchctl on macOS
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

On Wed, Nov 4, 2020 at 3:06 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> The solution is to switch from cron to the Apple-recommended [1]
> 'launchd' tool.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> +While macOS technically supports `cron`, using `crontab -e` requires
> +elevated privileges and the executed process do not have a full user

Either s/process/processes/ or s/do/does/

> +context. Without a full user context, Git and its credential helpers
> +cannot access stored credentials, so some maintenance tasks are not
> +functional.

Nicely explained.

> +Instead, `git maintenance start` interacts with the `launchctl` tool,
> +which is the recommended way to
> +https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html[schedule timed jobs in macOS].

Nit: I worry a bit about links to Apple documentation becoming
outdated. It might not hurt to omit this link altogether, or perhaps
demote it to a footnote (which might allow it to be somewhat usable
even when Git documentation is rendered into something other than
HTML).

> +Scheduling maintenance through `git maintenance (start|stop)` requires
> +some `launchctl` features available only in macOS 10.11 or later.

Nit: This leaves the reader wondering what modern features are needed.
Would it make sense to mention that "bootstrap" is used in place of
"load" in older versions of 'launchctl'?

> +Your user-specific scheduled tasks are stored as XML-formatted `.plist`
> +files in `~/Library/LaunchAgents/`. You can see the currently-registered
> +tasks using the following command:
> +
> +-----------------------------------------------------------------------
> +$ ls ~/Library/LaunchAgents/ | grep org.git-scm.git

Alternately (unimportant):

    ls ~/Library/LaunchAgents/org.git-scm.git.*

although that would emit "No such file" if you don't have any
registered, which might suggest:

    find ~/Library/LaunchAgents -name 'org.git-scm.git.*'

> +To create more advanced customizations to your background tasks, see
> +https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/TP40001762-104142[the `launchctl` documentation]
> +for more information.

I really worry about this sort of URL becoming outdated. Would it make
sense instead to just point the user at the man page,
launchd.plist(5)? It's not quite the same, as it doesn't provide the
range of examples as the URL you cite, but it should get the user
started.

> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -1491,6 +1491,214 @@ static int maintenance_unregister(void)
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
>
> +static int remove_plists(void)
> +{
> +       return remove_plist(SCHEDULE_HOURLY) ||
> +               remove_plist(SCHEDULE_DAILY) ||
> +               remove_plist(SCHEDULE_WEEKLY);
> +}

The new documentation you added says that the plist files will be
deleted after they are deregistered using launchctl, but I don't see
anything actually deleting them. Am I missing something obvious?

> +static int schedule_plist(const char *exec_path, enum schedule_priority schedule)
> +{
> +       plist = fopen(filename, "w");
> +       if (!plist)
> +               die(_("failed to open '%s'"), filename);

As mentioned previously, these could be replaced with a simple xfopen().

In fact, I'm having trouble seeing changes in this re-roll which you
had planned on making, such as consolidating the repeated code in
bootout() and bootstrap(), and ensuring that bootout() doesn't
complain if the plist files are already missing, and so forth. Did you
opt to not make those changes? (Which would be fine; they were minor
suggestions.)

> +       preamble = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
> +                  "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
> +                  "<plist version=\"1.0\">"
> +                  "<dict>\n"
> +                  "<key>Label</key><string>%s</string>\n"
> +                  "<key>ProgramArguments</key>\n"
> +                  "<array>\n"
> +                  "<string>%s/git</string>\n"
> +                  "<string>--exec-path=%s</string>\n"
> +                  "<string>for-each-repo</string>\n"
> +                  "<string>--config=maintenance.repo</string>\n"
> +                  "<string>maintenance</string>\n"
> +                  "<string>run</string>\n"
> +                  "<string>--schedule=%s</string>\n"
> +                  "</array>\n"
> +                  "<key>StartCalendarInterval</key>\n"
> +                  "<array>\n";
> +       fprintf(plist, preamble, name, exec_path, exec_path, frequency);

The Git test framework ensures that this will be written into the test
directory rather than the user's actual ~/Library/LaunchAgents
directory during testing. Okay.

> +test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
> +       echo "#!/bin/sh\necho \$@ >>args" >print-args &&
> +       chmod a+x print-args &&

Earlier review already mentioned write_script() and "$@". (Not
necessarily worth a re-roll.)

> +       for frequency in hourly daily weekly
> +       do
> +               PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
> +               xmllint "$PLIST" >/dev/null &&

Do we really need to suppress xmllint's stdout?

> +               grep schedule=$frequency "$PLIST" &&
> +               echo "bootout gui/$UID $PLIST" >>expect &&
> +               echo "bootstrap gui/$UID $PLIST" >>expect || return 1
> +       done &&
> +       test_cmp expect args &&
> +
> +       rm -f args &&
> +       GIT_TEST_CRONTAB="./print-args"  git maintenance stop &&

There is still an extra space between the closing quote and git
command (mentioned previously).

> +       # stop does not unregister the repo
> +       git config --get --global maintenance.repo "$(pwd)" &&
> +
> +       # stop does not remove plist files, but boots them out

Documentation added in this re-roll claims that the plist files do get deleted.
