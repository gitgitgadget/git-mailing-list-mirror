Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBD7C55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE64020B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgKMUob (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:44:31 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45105 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMUoa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 15:44:30 -0500
Received: by mail-ej1-f67.google.com with SMTP id dk16so15513995ejb.12
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 12:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9C/SCuiUxONXgomycVBKLfD6kfs8PJ/dke8A71L71k4=;
        b=F86n/DmQBDdL1HP/zSnZHwBoJhE5UjkAjoEVEuFYZSh7MyuIXSHstlfhIU1aNR5dkT
         cgFA3MWw8hTe7YGPHzihUNddy3BXxF55UhBQOIsEvERDZ/JwqYZ4lPWNSLyx0+b87s+O
         S+9SxtSQf3eohZdDrEQA2OFM5aulz6QMigf4KiorVw6MTqJ1pLh08bJQyfla+tTBKaC7
         cqgXrD97YpXte1dnbXexqMk062gvcWNKGWuiI1Zmkoy8C3ATApkwqWmNjw/BIfPuxDm8
         B2DKMr+0VMriU9j1VybsTR1E+nrgjqwTOLBcenMxqUcaCqHWGmH8XqbI+GsrVQy2GFFJ
         /hlA==
X-Gm-Message-State: AOAM53279o9xzv1RjFZnNnVIPvIAYj83lLp2OHtHdJGAp4WACZLRO5qD
        T7ad9RK7zO2rWOb6XGsmtZsGkTzZjQZE6n/H37c=
X-Google-Smtp-Source: ABdhPJydrY8g8KI7cIBxKHuzX40Fyp29Z1y3FbRt3Ew3ZkR/5G/IkZBD8XlpbsDFrpi4RXffq4TcXQzxE3ujP//Pl1I=
X-Received: by 2002:a17:906:6949:: with SMTP id c9mr3794130ejs.482.1605300267285;
 Fri, 13 Nov 2020 12:44:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com> <ed7a61978fe9dce26ca459b5a86490c15e470698.1605276024.git.gitgitgadget@gmail.com>
In-Reply-To: <ed7a61978fe9dce26ca459b5a86490c15e470698.1605276024.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Nov 2020 15:44:16 -0500
Message-ID: <CAPig+cS3YXH=SmTsRTOa5Cdppt9L=MbFRT+LWn9QE7aEqRiDqQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] maintenance: use Windows scheduled tasks
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
> Git's background maintenance uses cron by default, but this is not
> available on Windows. Instead, integrate with Task Scheduler.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -1684,6 +1684,190 @@ static int platform_update_schedule(int run_maintenance, int fd)
> +static int schedule_task(const char *exec_path, enum schedule_priority schedule)
> +{
> +       char *xmlpath, *tempDir;
> +       tempDir = xstrfmt("%s/temp", the_repository->objects->odb->path);
> +       xmlpath =  xstrfmt("%s/schedule-%s.xml", tempDir, frequency);

When I wondered aloud in my previous review whether writing these
throwaway files to a temporary directory would make sense, I was
thinking more along the lines of /tmp or $TEMP. More specifically, we
have xmkstemp() in wrapper.c which is good for this sort of thing (or
one of the other temporary-file-making functions in there). We also
have a more full-featured temporary-file API in tempfile.h which would
ensure that these throwaway files actually get thrown away when the
command finishes.

This is not necessarily worth a re-roll.

> +       if (start_command(&child))
> +               die(_("failed to start schtasks"));
> +       result = finish_command(&child);
> +
> +       unlink(xmlpath);
> +       rmdir(tempDir);

Neither xmlpath and tempDir get cleaned up from the filesystem if the
preceding die() is triggered (which may or may not make sense --
perhaps you want to keep them around if it helps with the diagnosis of
the failure). The functions in tempfile.h would ensure the temporary
file is cleaned up even if the program die()s, or you could manually
remove the temporary file before die()ing.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -437,6 +437,33 @@ test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
> +test_expect_success MINGW 'start and stop Windows maintenance' '
> +       write_script print-args <<-\EOF &&
> +       echo $* >>args
> +       EOF

Using `>>` here makes it harder to reason about the test than using
`>` would, especially since `>>` seems to be unnecessary in this case.

> +       rm -f args &&
> +       GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&

Is it a requirement on Windows to mention /bin/sh here? Specifically,
I'm wondering why a simple ./print-args doesn't work. (It's especially
unclear since write_script() is used heavily in the test suite and it
seems to work well enough on Windows without specifying /bin/sh.)
