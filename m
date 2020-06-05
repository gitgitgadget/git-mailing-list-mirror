Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC765C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 21:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E85B206DB
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 21:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgFEVNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:13:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34933 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgFEVNm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 17:13:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id x14so11099171wrp.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 14:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLCrETqGaYXZbehNdVc9pKQZASmpaSIRh4ExeVO8T2Y=;
        b=hul7Yk2S6Ghxg6xfvwzDJ90KSrLQoe+vkh8zPDvYTcrPh7vz9VMrtWXm+eFbIwSzlT
         vn94EPynZ7JnYiDQA/778XHQ2BCgWeIoRI3wjctKe0zucfmeCsulUCCMuMRGu2EqhagE
         NXhqY/ICjoH+gHh1hil1/+YFLOjx67OW87wZcGR0ZYe8441VN0mbjT1g4A+eIjtt/OWf
         u0id0KJ9b6V4vWR3laRaDvKcvHJev5uUMy6iNj8h+7Jz0H3Ku+oVxNwEarLsWRoAi57k
         E2R69nbCEmNj73mRE8e4qIKtpc/1AwfMt9Eq/QqxQMjEyM/rzLOZuXVXJ2J3UAdR1IC/
         xL5w==
X-Gm-Message-State: AOAM5324IkckdfeEpBZkb9ocBdeKeRO/0AgL2jWFskCeQyxj/7C5lTpO
        IRBAit9SYdG3eK0BmmQ3Vy/mseaYysInZI+Wl161a6Z+vlM=
X-Google-Smtp-Source: ABdhPJxdQiHo22RlFmQSEMtlM94eyxze3T06JERoh58c0pnpZPYGSXB2fbDrAT3JsmA77qQ8yWzAKXdknQJ4GFRBVgI=
X-Received: by 2002:adf:e648:: with SMTP id b8mr11914044wrn.386.1591391619916;
 Fri, 05 Jun 2020 14:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.644.git.1590507201474.gitgitgadget@gmail.com> <20200605204803.lbolbny5m5dczynn@yadavpratyush.com>
In-Reply-To: <20200605204803.lbolbny5m5dczynn@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Jun 2020 17:13:28 -0400
Message-ID: <CAPig+cQhm7XwKEJdjzmaG_gbOJZp1RbktJBeC0d8vTQfgLbydQ@mail.gmail.com>
Subject: Re: [PATCH] git-gui: allow opening work trees from the startup dialog
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Mikhail Terekhov via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Mikhail Terekhov <termim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 5, 2020 at 4:48 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> On 26/05/20 03:33PM, Mikhail Terekhov via GitGitGadget wrote:
> > From: Mikhail Terekhov <termim@gmail.com>
> > +                     if {[file exists [file join $path gitdir]]} {
> > +                             set fp [open [file join $path gitdir] r]
> > +                             gets $fp worktree_path
> > +                             close $fp
> > +                             if {[string equal $check_path $worktree_path]} {
> > +                                     set outdir $path
> > +                                     return 1
> > +                             }
> > +                     }
>
> I wonder if there is a way of finding if the path is a worktree path
> using a Git plumbing command. That IMO would be better than rolling our
> own logic to check if something is a worktree.

Perhaps use:

    (cd "$path" && git rev-parse --is-inside-work-tree)

That will return "true" for both the main worktree and a linked
worktree. You may need to suppress stderr if you expect to run the
command in an arbitrary directory since it will error out if the
directory is not under Git's control.
