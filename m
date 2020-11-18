Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605C8C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 06:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136A824655
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 06:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKRGpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 01:45:51 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:35664 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgKRGpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 01:45:50 -0500
Received: by mail-ej1-f65.google.com with SMTP id f23so1211735ejk.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 22:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpBL0LzzGJgkHrFkLxeTxRcrz4+L70e3Q1hIHaz0wME=;
        b=G1NcnR66Ny6OzofLuE+CMMP/+6DcuCK0fy7+lrfj4nPelWXrtK3mDkiKA0k7iuEo4G
         o2+wLgC3bSpI6Wty1VTaG4rySkQit2g8YJKmBIeweva/8vtt+W3K/Cu+4zBp493KSxQx
         8+MluqET0kaAAfgUHWydBFy98kgdP0AKbA2rKLKL1insVApIySw0l6SSCx9HKluJdy0a
         SytLYV+Rcbk29EaeXGWZBFEW6r4eXw9MJbFHPfyq30bBeYn4mVEL9zCbcym1Zd9nKnUz
         H+nB/GidsQf8XyxwjIsplkQrKNq1siq10BBx2jVkhOigvNk1JENWdFNz8lpwqjDAgNwb
         kh9A==
X-Gm-Message-State: AOAM533D4TxjoenFOVObqFUwdhiHMhsiicMbRqMyd5iGqPSC9ArlsQJW
        oQoCUEGDbRLd/puaV6w5pG3vOsx8ejS2DNkly54=
X-Google-Smtp-Source: ABdhPJzLdOq3vfH96OB9SpVgOxnd6qv60qAq/c7zld90kSz/2qgJ2rvBCCHpKA68vy2bHiGhpFkrJStbdpQ9E7sU41w=
X-Received: by 2002:a17:907:1688:: with SMTP id hc8mr9620378ejc.168.1605681948997;
 Tue, 17 Nov 2020 22:45:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com> <ed0a0011fb0b06780bc6ce2920f17cad46eccdf9.1605647598.git.gitgitgadget@gmail.com>
In-Reply-To: <ed0a0011fb0b06780bc6ce2920f17cad46eccdf9.1605647598.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Nov 2020 01:45:37 -0500
Message-ID: <CAPig+cRQJ9VpRk_0oz4BP3GF7dtsHtE3Qcd=nGsS26=JZvps7g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] maintenance: use launchctl on macOS
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
> +static int launchctl_boot_plist(int enable, const char *filename, const char *cmd)
> +{
> +       child.no_stderr = 1;
> +       child.no_stdout = 1;
> +       if (start_command(&child))
> +               die(_("failed to start launchctl"));

Did you have any thoughts on the observation I made in a followup
response[1] during review of v3 in which I suggested that we might be
able to avoid suppressing stderr (and stdout) here? In particular, the
idea was that if, in launchctl_schedule_plist(), we do a simple
existence check for the .plist file and only call
launchctl_boot_plist(0,...) to `bootout` the .plist file if it exists,
then we shouldn't need to muck with stderr/stdout suppression. The
benefit is that if `bootout` fails for some reason, then the user
would see the (hopefully) meaningful error message emitted `launchctl
bootout`.

The same .plist existence check could be done in
launchctl_remove_plist() before trying to `bootout` the file.

Anyhow, such refinement can be done later is desired, so not worth a
re-roll, but I was curious about your thoughts on the issue.

[1]: https://lore.kernel.org/git/CAPig+cTRJb-fn2R6rJO1hkeCc_ehVhkNufO4=LhtPQudVeonnA@mail.gmail.com/
