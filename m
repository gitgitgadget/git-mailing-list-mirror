Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55127C55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D941E20791
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKMUTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:19:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33391 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMUTj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 15:19:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id v4so12228816edi.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 12:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFj+BllDmz9pCq1tgZS8OFjhLQZQTH/VYOx5aZy6wWg=;
        b=fO6LFWoKK6bp7NLmfr/f8NxTyAW1bRmsbz6+FBUggCollOjLyFaCJzRlG7JxQ3wniC
         xWRFodcB6w+O78LpIZw+6d8HvQNWPvf/5gb1H+C+l38QQGZ6ZcP8ES6PL8JrHIgkZfK7
         XQdjF1aKkoARsIWqPF45aAUGhQZkWIH/RoLyRhaxKrAjlh1+0YkpHV58etm5n+6a/9J7
         IGsKzvI6XKVDRiSktF/uxBLz0JUCfKCzTIFYUtB/Ul9yb8zAh97zTYIaW9QqyNzSMh5r
         be6fE5eb68M0D4DpenNtMZZonXJh+3KFlBqgnrfYFdaZRUH3JUYnRbvb2JawWsb1kB6s
         xx0w==
X-Gm-Message-State: AOAM531OlBM/XIhrtGXbsK3A1LSkQk1l3NB0f37f7xxgxv1D12DjnAKT
        7Fu4ZCRT9vR7d5SZ90zQGO+vK/FJOF9Pd1gmL3c=
X-Google-Smtp-Source: ABdhPJzt3A0w/FCXF83HsNGuY5JcmLzDaqWURjjyXI2JEAHhmtzx2JJqKgfyLqvS2vvYzIfYBmU/IEzYK8DfNWGJ5a8=
X-Received: by 2002:a50:d616:: with SMTP id x22mr4322733edi.221.1605298777412;
 Fri, 13 Nov 2020 12:19:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com> <1629bcfcf82dbc2ed9889a0e9ea2d08427901c4e.1605276024.git.gitgitgadget@gmail.com>
In-Reply-To: <1629bcfcf82dbc2ed9889a0e9ea2d08427901c4e.1605276024.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Nov 2020 15:19:25 -0500
Message-ID: <CAPig+cQQrucwE-KSndQ5kCjG9Q1MtjxraAmA95+OQe=6bdks-Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] maintenance: use launchctl on macOS
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 9:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> The solution is to switch from cron to the Apple-recommended [1]
> 'launchd' tool.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -1491,6 +1491,200 @@ static int maintenance_unregister(void)
> +static int boot_plist(int enable, const char *filename)
> +{
> +       struct child_process child = CHILD_PROCESS_INIT;
> +       child.no_stderr = 1;
> +       child.no_stdout = 1;
> +       if (start_command(&child))
> +               die(_("failed to start launchctl"));

Not necessarily worth a re-roll -- in fact, it could be done atop this
series to avoid holding this series up -- but this too-succinct error
reporting won't help users diagnose the failure. An alternative would
be to capture stdout and stderr and only print them if the command
fails. Perhaps something like this:

    struct strbuf out = STRBUF_INIT;
    struct strbuf err = STRBUF_INIT;
    ...
    if (pipe_command(child, NULL, 0, &out, 0, &err, 0) {
        if (out.len && err.len)
            strbuf_addstr(&out, "; ");
        strbuf_addbuf(&out, &err);
        die(_("launchctl failed: %s"), out.buf);
    }

By the way, won't this die() be a problem when schedule_plist() calls
boot_plist() to remove the old scheduled tasks before calling it again
to register the new ones? If the old ones don't exist, then it will
die() unnecessarily and never register the new ones. Or am I
misunderstanding? (I'm guessing that I must be misunderstanding since
the test script presumably passes.)

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -389,12 +389,54 @@ test_expect_success 'stop from existing schedule' '
> +test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
> +       write_script print-args "#!/bin/sh\necho \$* >>args" &&

write_script() takes the script body as stdin, not as an argument, and
you don't need to specify /bin/sh. What you have here works by
accident only because write_script() takes an optional second argument
specifying the shell to use in place of the default /bin/sh.
Nevertheless, it should really be written:

    write_script print-args <<-\EOF
    echo $*
    EOF

Patch [4/4] uses write_script() correctly.

> +       rm -f args &&
> +       GIT_TEST_CRONTAB="./print-args" git maintenance start &&
> +
> +       # start registers the repo
> +       git config --get --global maintenance.repo "$(pwd)" &&
> +
> +       # ~/Library/LaunchAgents
> +       ls "$HOME/Library/LaunchAgents" >actual &&

Not sure what the comment above the `ls` is meant to be conveying.
Could be dropped but not itself worth a re-roll.

> +       cat >expect <<-\EOF &&
> +       org.git-scm.git.daily.plist
> +       org.git-scm.git.hourly.plist
> +       org.git-scm.git.weekly.plist
> +       EOF
> +       test_cmp expect actual &&
> +
> +       rm expect &&
> +       for frequency in hourly daily weekly
> +       do
> +               PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
> +               xmllint --noout "$PLIST" &&
> +               grep schedule=$frequency "$PLIST" &&
> +               echo "bootout gui/$UID $PLIST" >>expect &&
> +               echo "bootstrap gui/$UID $PLIST" >>expect || return 1
> +       done &&

This is still relying upon $UID picked up from the users environment
(as far as I can tell), which seems fragile. As mentioned in my first
review, it probably would be more robust to compute UID manually the
same way git-maintenance itself does.

> +       test_cmp expect args &&
> +
> +       rm -f args &&
> +       GIT_TEST_CRONTAB="./print-args" git maintenance stop &&

Minor: No need for the quotes around ./print-args (though they don't
hurt either, and certainly not worth re-rolling just to drop them, and
it's subjective so don't drop them just for my sake).

> +       # stop does not unregister the repo
> +       git config --get --global maintenance.repo "$(pwd)" &&
> +
> +       printf "bootout gui/$UID $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
> +               hourly daily weekly >expect &&
> +       test_cmp expect args &&
> +       ls "$HOME/Library/LaunchAgents" >actual &&
> +       test_line_count = 0 actual
> +'
