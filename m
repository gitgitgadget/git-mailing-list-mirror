Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2181DC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 20:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91AA239ED
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 20:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgLQUDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 15:03:51 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:45292 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQUDu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 15:03:50 -0500
Received: by mail-ej1-f44.google.com with SMTP id qw4so39648286ejb.12
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 12:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmuVwGnXrjUkP5S+IsibPnxLuDOMV45IhxxYav9W8mk=;
        b=W3hvsKZdnRMimzWyKsiBn9XZwEEc7tEb1NbaY5RpcDkSHn/wO6wfBgzees0jXd5/y0
         skaHWedK+UaqPZjnsFyZ2gEQQxJq4pvoltGjKPiV7Mrh1Mf6jT/XrfFkziHGcVZ7YouX
         uOyj7vvUzgjQS6zDfFNiyuue/cEf5ki1FlR2SPW+kXpYL922cVVYZFICp46Kp2O4BDhu
         tNqm8uR47K3ovxlICu0jn0EvC1RqUeB5ar+saigMTvTUgPODJ/GrHrpbw0Pw4IKt/HQo
         kwxIXr/t+tJqK+AgpJIztYpd1pafehwbCHQRuOmqMR2AzK7I5w+/XnikQGEgZx/uQ7gf
         3QVQ==
X-Gm-Message-State: AOAM531po9xB9gymaPdv+4feaBB+C1rTgIbYGwxMkJDQnQdexueC5ec4
        S6Z7pJgi+f4sCcrY8z6busAILUFzDzUCbVdnxL0=
X-Google-Smtp-Source: ABdhPJzji0drvJ3oLlutMuwGNRXbZp+rpFvJpilftfEHJSPLU4DVKJ4EATyyXktE+g+nuXO+YfskS/OlsHAOeRKs39w=
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr712184ejb.168.1608235388890;
 Thu, 17 Dec 2020 12:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20201208173705.5770-1-sunshine@sunshineco.com>
 <xmqqwnxs55rn.fsf@gitster.c.googlers.com> <CAPig+cQT2Cj4i=2kq_svMyKiFmNLxvpa5kG=XNeaT+8UD5238Q@mail.gmail.com>
 <xmqqwnxgxlfi.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnxgxlfi.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Dec 2020 15:02:57 -0500
Message-ID: <CAPig+cTpdp4fbzBo9ZWt85O_6e7q5br7CnsBp_ZwJLo02LOjcw@mail.gmail.com>
Subject: Re: [PATCH] worktree: teach `repair` to fix multi-directional breakage
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 17, 2020 at 2:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > The inference is intentionally simple-minded. There is no path-based
> > inference or other heuristic at play; the entire inference is based
> > upon <id>. The worktree's path is specified as an argument. `git
> > worktree repair` manually reads the ".git" gitfile at that location
> > and, if it is well-formed, extracts the <id>. It then searches for a
> > corresponding <id> in <repo>/worktrees/ and,...
>
> That is exactly the point I got confused.  The worktree's path comes
> as an argument from the user, so we'd trust it.  And it has ".git"
> that is a gitfile that used to point at <repo> but because we are
> trying to deal with a situation where both worktree and repo moved,
> it cannot be used to learn where <repo> is.  Then, even after
> learning what <id> to use, how would we know where to use that <id>
> to find <repo>/worktrees/<id>, when the location of <repo> is unknown?
>
> I think the answer is "where the user starts the 'git worktree'
> command has to be under control of some repository (perhaps found by
> a call to setup_git_directory()), and we'd use that one as <repo>".

Correct. This is why the documentation update:

    If both the main working tree and linked working trees have been
    moved manually, then running `repair` in the main working tree and
    specifying the new `<path>` of each linked working tree will
    reestablish all connections in both directions.

says explicitly that `git worktree repair` must be run in the main
worktree for this particular case. (For a bare repository, the command
would be run in the bare repository instead, but I omitted that bit to
avoid bogging down the documentation, and because the couple preceding
paragraphs already mention the bare repository case, so I figured the
reader would understand.)

I could also have mentioned in the commit message the requirement of
running `git worktree repair` in the main worktree (or bare repo), but
didn't want to repeat what the patch itself was already saying. But I
think I'll update the commit message to mention it when re-rolling
since it's important information for understanding how the repair
works.
