Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F62C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 01:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CE221744
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 01:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgAMB7R convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 12 Jan 2020 20:59:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38476 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732487AbgAMB7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 20:59:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so6986032wrh.5
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 17:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dJHlc8RQZ1LI4+llMrU1BQr1naQjePqucKNraDQ1sn4=;
        b=RyuK/Vk11Opz7ui4LtvuGuGJVMZFRBT5QQarZ5lgx2azolyIb6PuFZAOoBPtRIvkQF
         C3CADIjl8q/qc9ZOrXjrAaiF9er4kp9CJB3WSjbL+sK3hlIerX7S1qbZVPF8bPZMd9R/
         Rlr5rJ3mXrDzoqUFnXPSYyzNlacjWOEQoMPJullizYqJS/9cOac8Hfe+vatTeH2q4UzM
         wS5/ksO3/Xy7vuAGOhqXJPh+NU6pE0DUOqv4yJooaZ3RkswWHtpygClI38botytnhdWC
         uHgthOkZW+PB09suQS0TetEBPiwvOoyG2sqQvoSEnCS13mDn26xo/WUkWzZ6+123E7wf
         vmdg==
X-Gm-Message-State: APjAAAWAbL1dR6Hs5WF+UK05om6Q01ZE9ZurGrRIHVQAEplqBbz2EyLc
        GNO9S99v3KX98y2E51yHVplMf2IM1VjYHH+UBz74nY0I
X-Google-Smtp-Source: APXvYqyV5ydJf/PNrf9kb3OswbtVld/S2s17qoVZt89zlN0MKpYB6Ax+AEk0EPl6rl4WV2JVg9cjBr/hsOxsGRxdiFE=
X-Received: by 2002:adf:b193:: with SMTP id q19mr15571216wra.78.1578880755187;
 Sun, 12 Jan 2020 17:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
 <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com> <20200112121402.GH32750@szeder.dev>
In-Reply-To: <20200112121402.GH32750@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Jan 2020 20:59:04 -0500
Message-ID: <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 12, 2020 at 7:14 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine wrote:
> > Taking a deeper look at the code, I'm wondering it would make more
> > sense to call wt_status_get_state(), which handles 'rebase' and
> > 'bisect'. Is there a reason that you limited this check to only
> > 'rebase'?
>
> What branch name does wt_status_get_state() return while bisecting?
> The branch where I started from?  Because that's what 'git status'
> shows:
> But am I really on that branch?  Does it really makes sense to edit
> the description of 'mybranch' by default while bisecting through an
> old revision range?  I do not think so.

It's not clear what downside you are pointing out; i.e. why would it
be a bad thing to be able to set the branch description even while
bisecting -- especially since `git status` affirms that it knows the
branch?

> > Looking at the code itself (rather than consulting only the patch), I
> > see that there are a couple more early returns leaking 'branch_name',
> > so they need to be handled, as well.
>
> 'git branch --edit-description' is a one-shot operation: it allows to
> edit only one branch description per invocation, and then the process
> exits right away, whether the operation was successful or some error
> occurred.

It is one-shot, but the existing `--edit-description` code already
cleans up after itself by releasing resources it allocated (as do
other one-shot parts of cmd_branch()), so it would be odd and
inconsistent for this new code to not clean up after itself, as well
(or, more accurately, to only clean up after itself in some branches
but not others).

> I'm not sure free()ing 'branch_name' is worth the effort
> (and even if it does, I think it should be a separate preparatory
> patch).

A separate preparatory patch doesn't make sense in this case since
'branch_name' becomes "freeable" with this patch itself (prior to
that, it was `const char *`).

Anyhow, a different approach was later proposed[1] which eliminates
some of the ugliness.

[1]: https://lore.kernel.org/git/20200112101735.GA19676@flurp.local/
