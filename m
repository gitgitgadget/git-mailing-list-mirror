Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB14C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 05:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiK2FOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 00:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiK2FOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 00:14:07 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FDA419BF
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 21:14:05 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z24so15578102ljn.4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 21:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9o/tM7yF70ZPw8D0BmR8ssawIDQxAIH+GNfNgZe82g=;
        b=XlVe4i3tztSwzRX9pfm+XPkbwzRd0906TrcikNwlNi4hwKr2xoL9dxrQmRtXBkjQlr
         UIdzpGFxaE8BqEetz4h+bz/f3nm2xLMGkWIOkaU2+VV9lZKaH4WU3F6I8KYRh7vKYTBf
         NzF2ZyXMNXYxj2VnVLKhfUdqZ90yIBA3dHJidXtC6mERvLwmFYk7BrErcd53nknbaoGm
         BSjrtHpjmM1x7ovXEk7LnuXxZoTOs67jsQQ/gJxsyOueTezXZftxf2Au7BGK3rXNG8YE
         dVhOxgh9CHX4mJjzmOasr6saO0pkLPNhUx4M1dS5ayV2Pk7nZOJ9Hcdp9PnFOYql/Jxq
         XzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9o/tM7yF70ZPw8D0BmR8ssawIDQxAIH+GNfNgZe82g=;
        b=pKRf6DQ2DEQGVp7hzr1/oOOoRZB6LbMBEu+7Woo5/OTReUSzv53oEKKEws7BfnjM16
         pwozRTJh0BY3diChvYaCvwHMOnFhEtTcRYP69gY+AbZnD+H7EXX3v0glL1PEeoAIY2aY
         rMXfOX9IPvnC58j38HjS3c30wGOWSJsCrFsGASvEjnSny4OMZTtL6UiPeW5Z1X7bFDRO
         PlTxqOImTbWJtA9otkPAtiLeDcsCGR6221viw+09wHT9ojSf5VXMPkOse2r6QDIILa/g
         EgHGmY4dkRxlHMTe5y5cnPL1RtPzLitEVSPZkbGSXphVyKNQV5TCPHCch2lr3QtXcBrp
         jIGw==
X-Gm-Message-State: ANoB5pmpt6PTenEo2SpDoKOERIKfZt2mt7gpjydfncWLaD2DMgAY3Xaj
        4oqGcokvAxi7kK2yEGTGiN/Iucyl/eEG6FLLmvk=
X-Google-Smtp-Source: AA0mqf4U4CN9UYGkI50V0FSYKb1Ps7BHQV7DgiUBtT2ea5ctNnFPgzllltX/2RYH489mhZdXDNIGPMFxd4g3hU3OsXo=
X-Received: by 2002:a05:651c:12c1:b0:277:2fd5:482 with SMTP id
 1-20020a05651c12c100b002772fd50482mr13375214lje.194.1669698844208; Mon, 28
 Nov 2022 21:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20221108184200.2813458-6-calvinwan@google.com>
In-Reply-To: <20221108184200.2813458-6-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 Nov 2022 21:13:52 -0800
Message-ID: <CABPp-BH3hxXhAGeHJ56m=S+GknsVqYExdJ7eKs3bJYkiMaWukQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] diff-lib: parallelize run_diff_files for submodules
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2022 at 11:32 AM Calvin Wan <calvinwan@google.com> wrote:
>
> During the iteration of the index entries in run_diff_files, whenever
> a submodule is found and needs its status checked, a subprocess is
> spawned for it. Instead of spawning the subprocess immediately and
> waiting for its completion to continue, hold onto all submodules and
> relevant information in a list. Then use that list to create tasks for
> run_processes_parallel. Subprocess output is duplicated and passed to
> status_pipe_output which parses it.
>
> Add config option submodule.diffJobs to set the maximum number
> of parallel jobs. The option defaults to 1 if unset. If set to 0, the
> number of jobs is set to online_cpus().
>
> Since run_diff_files is called from many different commands, I chose
> to grab the config option in the function rather than adding variables
> to every git command and then figuring out how to pass them all in.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  Documentation/config/submodule.txt |  12 +++
>  diff-lib.c                         |  80 +++++++++++++--
>  submodule.c                        | 154 +++++++++++++++++++++++++++++
>  submodule.h                        |   9 ++
>  t/t4027-diff-submodule.sh          |  19 ++++
>  t/t7506-status-submodule.sh        |  19 ++++
>  6 files changed, 287 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> index 6490527b45..1144a5ad74 100644
> --- a/Documentation/config/submodule.txt
> +++ b/Documentation/config/submodule.txt
> @@ -93,6 +93,18 @@ submodule.fetchJobs::
>         in parallel. A value of 0 will give some reasonable default.
>         If unset, it defaults to 1.
>
> +submodule.diffJobs::
> +       Specifies how many submodules are diffed at the same time. A
> +       positive integer allows up to that number of submodules diffed
> +       in parallel. A value of 0 will give the number of logical cores.

Why hardcode that 0 gives the number of logical cores?  Why not just
state that a value of 0 "gives a guess at optimal parallelism",
allowing us to adjust it in the future if we can do some smart
heuristics?  It'd be nice to not have us tied down and prevented from
taking a smarter approach.

> +       If unset, it defaults to 1. The diff operation is used by many
> +       other git commands such as add, merge, diff, status, stash and
> +       more. Note that the expensive part of the diff operation is
> +       reading the index from cache or memory. Therefore multiple jobs
> +       may be detrimental to performance if your hardware does not
> +       support parallel reads or if the number of jobs greatly exceeds
> +       the amount of supported reads.

So, in the future, someone who wants to speed things up is going to
need to configure submodule.diffJobs, submodule.fetchJobs,
submodule.checkoutJobs, submodule.grepJobs, submodule.mergeJobs, etc.?
 I worry that we're headed towards a bit of a suboptimal user
experience here.  It'd be nice to have a more central configuration of
"yes, I want parallelism; please don't make me benchmark things in
order to take advantage of it", if that's possible.  It may just be
that the "optimal" parallelism varies significantly between commands,
and also varies a lot based on hardware, repository sizes, background
load on the system, etc. such that we can't provide a reasonable
suggestion for those that want a value greater than 1.  Or maybe in
the future we allow folks somehow to request our best guess at a good
parallelization level and then let users override with these
individual flags.  I'm just a little worried we might be making users
do work that we should somehow figure out.
