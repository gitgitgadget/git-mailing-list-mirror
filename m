Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB31CC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 07:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468402223D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 07:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgKRHPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 02:15:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43229 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRHPR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 02:15:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id q16so842782edv.10
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 23:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3+NTAGwmwDhgyaZCx7ONsfKaGZVKcBQ7jqTGBy2Pdk=;
        b=lrWmODx0nYLhkq4PdkO0HevAEj7l+8LmllVEOjycx+KWX2IZUQGc3z9/ankcoPHzFR
         K2hFHu2QftV+ikz/b1aPH1U3wmqm5CfgpjuRz62bHt+/zLGuy7FSA4FRjc0HGMYAI1iS
         nfShGC57/EcK2yb9ccGokxLsHHJByiV3jm3aItuuJAipPptEswJTz30bW/GBk3Cy0i8+
         RmQBYdUQn2/skXEAThXXvdP7KEgKrfmRWOIzsazPfIe2MYzW+QuEzg/glg/QnuVac7a+
         GIGBXQoXbhWHGWbFO8n+/QDs1loLO3KFD/wCUdRRLyWsoXQdo6F8gsS6eatgF4xNhlpE
         cLJQ==
X-Gm-Message-State: AOAM5337emRfr74JPfIeF9JvHTVlGsiAqWHPxHNMkQ3b+ijDdOnHbcrq
        HtQIb43NwErYU0cqco4hPiQHl+P9cGgP7eJin9A=
X-Google-Smtp-Source: ABdhPJxwLCK0a87d/o0vSf3SaU8EijCW98f3A6V3YSVYSQdPuhoPo4Mwc3Fnq8Y2uyolUJ5ieXgwVoBNPCFhdN9b6nc=
X-Received: by 2002:a05:6402:1644:: with SMTP id s4mr7078076edx.221.1605683715368;
 Tue, 17 Nov 2020 23:15:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com> <b8d86fb9832b59884d3d38791de252dcb71e3629.1605647598.git.gitgitgadget@gmail.com>
In-Reply-To: <b8d86fb9832b59884d3d38791de252dcb71e3629.1605647598.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Nov 2020 02:15:04 -0500
Message-ID: <CAPig+cRFQfg-NLx5dO+BjQpYduhOYs-_+ZRd=DhO8ebWjGB0iA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] maintenance: use Windows scheduled tasks
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 4:13 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> Since the GIT_TEST_MAINT_SCHEDULER environment variable allows us to
> specify 'schtasks' as the scheduler, we can test the Windows-specific
> logic on a macOS platform. Thus, add a check that the XML file written
> by Git is valid when xmllint exists on the system.

Nit: xmllint can be installed on Linux (and likely other platforms),
as well, so it's not clear why this calls out macOS specially. More
generally, it may not be important to call out xmllint at all in the
commit message; it's just _one_ thing being checked by a test which is
checking several other things not called out individually by the
commit message. Anyhow, this is minor; not worth a re-roll.

> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -1671,6 +1671,167 @@ static int launchctl_update_schedule(int run_maintenance, int fd, const char *cm
> +static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule, const char *cmd)
> +{
> +       xmlpath =  xstrfmt("%s/schedule-%s.xml",
> +                          the_repository->objects->odb->path,
> +                          frequency);

I missed this in the earlier rounds since I wasn't paying close enough
attention, but placing this XML file within the object database
directory (.git/objects/) feels rather odd, even if it is just a
temporary file. Using the .git/ directory itself might be better,
perhaps like this:

    struct strbuf xmlpath = STRBUF_INIT;
    strbuf_git_common_path(&xmlpath, the_repository,
        "schtasks-%s.xml", frequency);
    ...
    strbuf_release(&xmlpath);
