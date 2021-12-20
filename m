Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B831BC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 12:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhLTMiD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 20 Dec 2021 07:38:03 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:44807 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhLTMiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 07:38:02 -0500
Received: by mail-il1-f172.google.com with SMTP id f17so7452925ilj.11
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 04:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1NwC15xyqcUz1SHpdGK1w5tqVxbQuOFjV6xhVs60MM8=;
        b=jUli3M64hpJdHwg10/EGgw0hsleqy1aJRERyKy3srf1yyJ+3P1ueqI7CWl6/PlXgJ/
         hJANsIws2YomQr5J+pd3CdixNSpO6fEKNzpc3OAId1bfF6N2yLkl1i1SlQl/FvXL+0wE
         nC5un30rnlk0dgeJakVBR3MknbbHV9mRKZe7dHlz4Ix0+NW9bF5cSoVzL/PSGYm5+sf1
         arry0Lv4CY+FQTdasInJg/xtBUBYpmScpVFOQrtplo7sjCeCXGbF8qpZ4SfoszAiHryL
         WL5UtqZuicJAJbrk+wtrWFvG982O1X28+B/B423TvOC38fj4KaX1gEp6kDAoVdGIOGh+
         +lFw==
X-Gm-Message-State: AOAM531oBmNP8kxlNBzSHRUoznczWegl1zKtNhX8qQv41Yoi/qHtqJmA
        DvhzYYxxPP+zxClW2uCpjH7dbVM8I93dw+5mKevCDox3J1s=
X-Google-Smtp-Source: ABdhPJzBOq2+pSQyoPWSifk4L9v25Cph+tDK+zXyxsLvF4PQXi54DswPrbx9sVMFnLmU/ha0nH9MUB9vSkW/H867Hho=
X-Received: by 2002:a92:c609:: with SMTP id p9mr7988363ilm.49.1640003882004;
 Mon, 20 Dec 2021 04:38:02 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
In-Reply-To: <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Mon, 20 Dec 2021 13:37:26 +0100
Message-ID: <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
Subject: Re: Custom subcommand help handlers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like any git cmd --help is transformed into
"git help --exclude-guides cmd"
This is used to differentiate "git cmd --help" and "git help cmd".

It's used with aliases to print the alias as well as execute "git help cmd"
Maybe something similar can be done for non built-ins that are missing
man-pages / html-docs

Currently, you may "git-foo --help" directly or use "git foo -h"
instead of "git foo --help" but this may be confusing to users

On Mon, Dec 20, 2021 at 12:54 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sat, Dec 18 2021, Sean Allred wrote:
>
> > Hi folks,
> >
> > I've got a custom subcommand I'm distributing in my company to
> > integrate with our bug-tracker. It's a pretty robust utility and has
> > its own help function, but running `git foo --help` doesn't pass
> > --help to my git-foo utility. I asked a question[1] about this
> > scenario on the Windows fork and they directed me upstream.
> >
> > It sounds like `git foo --help` is internally consumed as `git help
> > foo`, which forwards requests to info/man/web handlers per config.
> > Being on Windows and knowing my peers as I do, the vast majority of my
> > users won't be familiar with info or man. The HTML documentation used
> > by the web handler is in a Git4Win-controlled installation directory
> > that I'd really rather not touch/maintain. I really just want `git foo
> > --help` to call `git-foo --help`.
> >
> > What's the best way to go about this?
> >
> > In the event the best next step is to start a patch, does it sound
> > reasonable to simply not perform this `git foo --help` -> `git help
> > foo` transformation for non-builtins? Or, while I don't relish the
> > idea, would some kind of config option be needed?
> >
> > Best,
> > Sean Allred
> >
> > [1]: https://github.com/git-for-windows/git/discussions/3553
>
> I don't know if there's a solution that'll please everyone here, but
> it's definitely not narrowing this to built-ins. E.g. "git send-email
> --help" will expect to show the manual, so will "git annex --help".

-- 
Erik Cervin-Edin
