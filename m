Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA611F45F
	for <e@80x24.org>; Tue,  7 May 2019 22:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEGWZd (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 18:25:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40637 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEGWZc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 18:25:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id h11so547743wmb.5
        for <git@vger.kernel.org>; Tue, 07 May 2019 15:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1TUEo/q970QLmW8NfkDkUO1wkk3CE3f3qFBbixF9m4=;
        b=QYHDUEddi5gllL+MjotvTSBSiNU68sZeWkRnHttotYZgKII7F0msNmwAmgK4SYjbYl
         X8YnflC2lsUH5eN0MwRB7Bz8o4oP1ob05B0p1k8OmREd0DKcVJVTLtiH9riW9MUX2zQE
         JB2ZGPNMvyUonFXjaN6NXZJ3UAv6rZnHuYgpwkizb5w0kXAjUXVsfU6cd5an8SrrB32n
         Hwvjh9GKxU7C41quXfm2aF9FGppWLR/wdA7ry+/78jUBZ8x36GtSdCjMfcCikdW4aXFq
         TPEI9v+ByxoJVpI7LFQ+PqCiBVWbngiFCMzEznf2sy1UGBTEsAsUixZ+/l7NHzBR38pp
         1uOg==
X-Gm-Message-State: APjAAAX/XE6BY5bpbEsvAPixjBQa4R4fKY3FvLIUuDROPntH2z5HeUDG
        oeRdkAFr2oSIQcyrHyyjgr471qsUd/LgemmeB3I=
X-Google-Smtp-Source: APXvYqw4lU5J2exPZB4WduIYIoE/3HQ0thSA42bB5lnmCL+imuE0L4LmZ1cdwFC5vZCN6dSodllbR7jpEuss8viEtbc=
X-Received: by 2002:a1c:b789:: with SMTP id h131mr453878wmf.71.1557267931296;
 Tue, 07 May 2019 15:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.185.git.gitgitgadget@gmail.com> <ba78a47b873c5f044cbfb147b30a801cc90fb0ac.1557265888.git.gitgitgadget@gmail.com>
In-Reply-To: <ba78a47b873c5f044cbfb147b30a801cc90fb0ac.1557265888.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 May 2019 18:25:20 -0400
Message-ID: <CAPig+cQG4+A+G+i+8RqpDAY2PveULVJ5iNR4HYEUPAd_4Ub04w@mail.gmail.com>
Subject: Re: [PATCH 1/1] t6500(mingw): use the Windows PID of the shell
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 7, 2019 at 5:51 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> Let's fix this by making sure that the Windows PID is written into
> `gc.pid` in this test script soo that `git.exe` is able to understand
> that that process does indeed still exist.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> @@ -162,7 +162,15 @@ test_expect_success 'background auto gc respects lock for all operations' '
> +       shell_pid=$$ &&
> +       if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
> +       then
> +               # In Git for Windows, Bash (actually, the MSYS2 runtime) has a
> +               # different idea of PIDs than git.exe (actually Windows). Use
> +               # the Windows PID in this case.
> +               shell_pid=$(cat /proc/$shell_pid/winpid)
> +       fi &&
> +       printf "%d %s" "$shell_pid" "$hostname" >.git/gc.pid &&

I wonder if it would make sense to abstract this away behind a shell
function named shell_pid() which can be specialized for MINGW, much
like the shell function pwd() is specialized on Windows.
