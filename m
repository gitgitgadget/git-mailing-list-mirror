Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E62C6379F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 06:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDCC206B6
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 06:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgKTGtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 01:49:11 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38097 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgKTGtK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 01:49:10 -0500
Received: by mail-ej1-f66.google.com with SMTP id a16so11415369ejj.5
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 22:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc3FnZZCzjmIxLc9m4BJd8pmpGXRXq09p8IdDreGgQc=;
        b=Enh2ucrJN4PSote1sDe9OHk95cEeJl6UtVaN2D4xzN76oroS9jadYG+MZPpE7yFV5d
         V5k/AeCtGa/Q3/tzA9xtPI9wgKQQOWJUHLNYNRakWnDG8KjAnoW9aFFy/r3LSZ4/SAh4
         v/jmbk/A6gMd+R9Dqt7wuGfs3ceganU+3GFRhgWoJBvFp6EfNjKBsSzPV9vBCM5jfTJB
         YS/h78PU3NcS67Gt7nKvdCuQl3CEvLkelmO0xrVfF+AjD0DOch5NW8l9fYrN+tOapqBt
         oIg5dvjfRuQU9st2upUw2hLRGa9CD0ELxdy07xE78zY0r1sZGj09b3Sbtp7DPK9KsQm+
         KrNw==
X-Gm-Message-State: AOAM533L4zYIe++LFbibSjnysta2p4sORVU1WLi75vodh3dYc4XBxGn4
        Kx6PY7yI4Fwwa+ZrlpacpL3ONbJpvp5Vyi8tGXk=
X-Google-Smtp-Source: ABdhPJwp5GmvzfS3Y5vfuMG84DaFM6xDRWJ6pgY+c1IbyNRXqivyNz6vlQ6iLrH2zkiNi6L94siQed1KOhTtrppZcFI=
X-Received: by 2002:a17:906:3617:: with SMTP id q23mr32353705ejb.371.1605854948741;
 Thu, 19 Nov 2020 22:49:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
 <pull.790.v4.git.1605819390.gitgitgadget@gmail.com> <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
 <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com>
 <CAGHpTBKHmdjqrz1ABdGUUz7AwcixU_VBy1DQzybpFizqVo8C7A@mail.gmail.com> <CAPig+cS5BUCaFN=MN+7gSTbvskffRdTJOgck6TrRRacxCc_CwA@mail.gmail.com>
In-Reply-To: <CAPig+cS5BUCaFN=MN+7gSTbvskffRdTJOgck6TrRRacxCc_CwA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Nov 2020 01:48:57 -0500
Message-ID: <CAPig+cTaV-L_m3OFw=WAUKaiLqSVvhP7fjjFbE13QStibVmRjw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hooks: allow input from stdin for commit-related hooks
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 1:38 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> I do find it quite concerning that the way this series handles the
> stdin conflict between the hook and `-F -` can break the hook silently
> and mysteriously. How confusing for a user to write a hook which works
> with `git commit -m msg` and `git commit -F file` but breaks silently
> with `git commit -F -`. What is worse is that this breakage may be
> outside the user's control. For instance, it is easy to imagine some
> IDE passing the commit message to git-commit via stdin (using `-F -`)
> rather than via a file (using `-F file`).
>
> At the very least, this change deserves a documentation update, both
> to explain that the prepare-commit-msg hook has a valid stdin, and
> (importantly) that it won't be able to rely upon stdin in conjunction
> with `-F -`.

What I forgot to say here was that this patch series doesn't help
users at all if their IDE passes the commit message to git-commit via
stdin using `-F -`. In such a case, their hook will _never_ see a
valid stdin coming from Git, no matter what their script does. So, the
change made by this patch series may help some users but not others,
and this is a limitation that should be stated in the commit message
(and perhaps mentioned in the documentation, though that may be
difficult to do in a general way).
