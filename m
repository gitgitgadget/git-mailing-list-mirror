Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213E3C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 07:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhL3Hlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:41:51 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:40842 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhL3Hlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 02:41:50 -0500
Received: by mail-pf1-f173.google.com with SMTP id q3so16415772pfs.7
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 23:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0neF1EG0Q3yeWJnX3+Eet19/FCDX33Xbb3syOoVtTU=;
        b=hvkND/G5vVsjo4TU5Bhje8HN315TQJusj/C7DYU+IuleBeyOqjxaRAHx8XoNocaIf3
         MUAMOMqAtO76kTKEoeU+JIu7HIPOUPtRjExeIEjivTWoTXANy1W/3Y3Dxh31iv3Xl8y7
         z5ai1WU4QObKEIbKXa0HHyshVAWo4N2IQOTn+34LRnffKxRGFUIfeRP73gNJQs5rsGsg
         Ml5aKZGTvTeoJW2PU9o64mgNtaC5T+yC6HWSjqPyRpDqsrimWVS4sVZnP21VpirWYZut
         papTemRAizkWQUL75X8P+m05V30uBq3LxYaOOjbHT841u5TnZkoFAyn6y8IJFKfZGlc8
         jluQ==
X-Gm-Message-State: AOAM533eji9awzZsLWWxEuY0vSVgEealx44E6YRjGXDS8CMFIpu0vv6D
        MrpGe7emeL06qhVTQyjB/3bDrYNipqi/b51Nzrw=
X-Google-Smtp-Source: ABdhPJyVlflbXaP0zknmTiCHJ2Fpf5jFaA1oh+RvF56gX2aYdFqZlZR2T6tJV3zEde6FD7r+GDsMCITWHnpyn3xK+P8=
X-Received: by 2002:a63:380e:: with SMTP id f14mr26482787pga.227.1640850110420;
 Wed, 29 Dec 2021 23:41:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
 <1db0f601-4769-15c0-cd58-ecddfa1fc9d5@gmail.com>
In-Reply-To: <1db0f601-4769-15c0-cd58-ecddfa1fc9d5@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Dec 2021 02:41:39 -0500
Message-ID: <CAPig+cS3GcOdk_tGNb7V64syUajfO40e_4uXWmYYo9=nU-1ezw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 12:39 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 12/29/2021 4:39 AM, Elijah Newren wrote:
> > No, it's not even rare, let alone very rare.  I'd actually call it
> > common.  Since 'sparse-checkout disable' does not delete the
> > sparse-checkout file, and we've encouraged folks to use the
> > sparse-checkout command (or a wrapper thereof) instead of direct
> > editing of the sparse-checkout file (and indeed, the sparse-checkout
> > command will overwrite the sparse-checkout file which further
> > discourages users from feeling they own it), having the file left
> > around after disabling is the common case.  So, the only question is,
> > how often do users disable and re-enable sparse-checkout, and
> > potentially only do so in some of their worktrees?  At my $DAYJOB,
> > that's actually quite common.  I got multiple reports quite soon after
> > introducing our `sparsify` tool about users doing something like this;
> > this is what led me to learn of the extensions.worktreeConfig, and why
> > I pointed it out to you on your first submission of
> > git-sparse-checkout[1]
> > (https://lore.kernel.org/git/CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com/)
>
> Thank you for these comments and the detailed descriptions of things
> from your $DAYJOB. That's helpful context and I'm happy to switch back
> to enabling the extension in the sparse-checkout builtin. I might need
> to rearrange the code so there is an API in worktree.c instead of just
> the subcommand in builtin/worktree.c, but that's pretty minor. I'll
> keep Eric's earlier suggestion to have the upgrade be a separate call
> from the repo_config_set_worktree_gently().

Thanks.
