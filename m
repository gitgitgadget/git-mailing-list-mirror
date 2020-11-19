Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C4FC388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B1D20B80
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 21:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKSVXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 16:23:24 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:46287 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKSVXY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 16:23:24 -0500
Received: by mail-ej1-f68.google.com with SMTP id bo9so4215372ejb.13
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 13:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQrOjFHdF/E7zcAnL16Q9Bm+CkHhb1IV7sRmZOKXI9c=;
        b=eYOWVs010E6/KOqqv2oDzTuF3GdkO2TwVGQC1UKWJhmzhpY9Blb6nzn0ikprpdonqQ
         XIWFY2HVqcJ/AMl/662S+Dpax7jDKf0Kb4NnExL/Zmj9eTRFZADOcS+toNca7VSJix8m
         YLfQb9Mg7D6pKy4QjxHPaQ0lR7iii/cyBLpmkQg6p9lSlvB5JhBbCbSQdgnNCGf6qFe0
         nR5zORvHrPU/9BNNwP/FCH318PLxToN47NmrU0PLJW58ETC8N/DRiagML4L+IFCjMghe
         jkdJEGHPvewoQbO+xEjZGVY5l9EGEHAbYK9Yq7iRYxh2eRXN5BKedwLyYN2qgGxVJ6F1
         8ZWw==
X-Gm-Message-State: AOAM533PwmwzZ9OCJHUdw6picjEOk4M5hSHcOWMeOmXUrKQB8M4mGCHH
        iqczo2Jccq/wtspY7R5TNImDI1n/UpdkbieEwZTCGr5o
X-Google-Smtp-Source: ABdhPJyM4KUgwr43LsM/RB0c58OXyPDqE0BAEcUysfc3ewhRfdOfmYhs/lBl7KaUJcgTo95HyYXHuNlpnNPQnD7wR8E=
X-Received: by 2002:a17:906:5587:: with SMTP id y7mr7908718ejp.138.1605821002446;
 Thu, 19 Nov 2020 13:23:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
 <pull.790.v4.git.1605819390.gitgitgadget@gmail.com> <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
In-Reply-To: <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Nov 2020 16:23:11 -0500
Message-ID: <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hooks: allow input from stdin for commit-related hooks
To:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 3:57 PM Orgad Shaneh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Let hooks receive user input if applicable.
> [...]
> This allows for example prompting the user to choose an issue
> in prepare-commit-msg, and add "Fixes #123" to the commit message.
>
> Another possible use-case is running sanity test on pre-commit,
> and having a prompt like "This and that issue were found in your
> changes. Are you sure you want to commit? [Y/N]".

These use-cases really help readers understand the motivation for this
change. Good.

> Allow stdin only for commit-related hooks. Some of the other
> hooks pass their own input to the hook, so don't change them.
>
> Note: If pre-commit reads from stdin, and git commit is executed
> with -F - (read message from stdin), the message is not read
> correctly. This is fixed in the follow-up commit.

Rather than making such a fundamental change and having to deal with
the fallout by introducing complexity to handle various special-cases
which pop up now and in the future, I wonder if it makes more sense to
instead just update documentation to tell hook authors to read
explicitly from the console rather than expecting stdin to be
available (since stdin may already be consumed for other purposes when
dealing with hooks or commands which invoke the hooks).
