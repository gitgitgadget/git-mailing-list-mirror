Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD9C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiK3SEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiK3SEN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:04:13 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180E66C72B
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:04:12 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3b10392c064so179758437b3.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yopEHLV2QMy+aasWtc7lZ/JPy46gPyRvefGlE6kFE2A=;
        b=IeSxID7o9mDP8SpVXygklmp7G8DKRQ2hmf0bM7aT4yMkt7NmRZxD+985TBAbFZ+wh5
         YZ978sqAMHOZT8LQp2EzzninDSRC8FboV9Ca9MKZS5UwgIOk+wn41L6RSULr5JssFUdF
         Qz2sE2DEtTPWKW1NvDQURYht/3R7eCfPGrvT8Lewl8IKndg1i9tmvSg/Xakt3i7dSz8g
         Plf5hHOVmzMdpJnUqedumY7kVcXfQuyvgU/Sls2VeUCygHymfRaPDqxWNIqJTQZnrxCO
         wrYGg5kmZmRu9EU3D2M1ienjScnzj7dVSN4SCQEAjxwUZz6r3ev3VEl4iPS5W+r7wtUS
         fpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yopEHLV2QMy+aasWtc7lZ/JPy46gPyRvefGlE6kFE2A=;
        b=SrfgCcZORx/R5UjnIqRl6ugG9Ue+8FPIWx4YJnLe8kNivQ/KkrAmd+oyC56yG95b3O
         7fqp4cJ2zEd/NgzPpTJgZREdTZToU0PtuzSOxmfuAkEVYWi97SF98UMZYVWCgodeWt7l
         DaSbRUEA4fK6VT2cYu2hratk/F92K2OAijSpAkvLu8dgJEehVy1prVcNpaJAxYxsuY1E
         l1fO1YuovgwcS2Umww3gACWWJue7DGDXqhsgs9o5/9VFCuBbeVBghEJZDCIo+k30KphB
         KiFzGEcV/eDyp701qGZZ9h88euCTXYiKNFPLngul0iTMu09Tdj/P7yC59Y6+7dC5u8Fx
         3sjw==
X-Gm-Message-State: ANoB5pmEna7ji1KcUg0Zq943tScUhpSXS8Bw2eVnF77Ejp72fyYYtvJR
        TjYJ9AYf5C8S9Ugp7fq03nxNyp6rbVuOR/pmju9l4w==
X-Google-Smtp-Source: AA0mqf5y7l8TvtSbF8Ik2Z0JGoEOsXsZT2qJa9WC5TGAl2de8XNHetXdUZZ0X6eWJIhDt7IlON/tIBgvOQAs/W9fznw=
X-Received: by 2002:a81:5345:0:b0:399:36f1:d851 with SMTP id
 h66-20020a815345000000b0039936f1d851mr40621397ywb.369.1669831451141; Wed, 30
 Nov 2022 10:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20221108184200.2813458-6-calvinwan@google.com> <CABPp-BH3hxXhAGeHJ56m=S+GknsVqYExdJ7eKs3bJYkiMaWukQ@mail.gmail.com>
In-Reply-To: <CABPp-BH3hxXhAGeHJ56m=S+GknsVqYExdJ7eKs3bJYkiMaWukQ@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 30 Nov 2022 10:04:00 -0800
Message-ID: <CAFySSZBJ1tQk0n+GEW-6MBDafGmTy75QS41oriwGFKiq8McR=Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] diff-lib: parallelize run_diff_files for submodules
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> > index 6490527b45..1144a5ad74 100644
> > --- a/Documentation/config/submodule.txt
> > +++ b/Documentation/config/submodule.txt
> > @@ -93,6 +93,18 @@ submodule.fetchJobs::
> >         in parallel. A value of 0 will give some reasonable default.
> >         If unset, it defaults to 1.
> >
> > +submodule.diffJobs::
> > +       Specifies how many submodules are diffed at the same time. A
> > +       positive integer allows up to that number of submodules diffed
> > +       in parallel. A value of 0 will give the number of logical cores.
>
> Why hardcode that 0 gives the number of logical cores?  Why not just
> state that a value of 0 "gives a guess at optimal parallelism",
> allowing us to adjust it in the future if we can do some smart
> heuristics?  It'd be nice to not have us tied down and prevented from
> taking a smarter approach.

I was unaware that the original intention of "reasonable default" was for
flexibility (I have a WIP series standardizing these parallelism config
options that also used "number of logical cores" but I think that should
probably change now). There are other parallel config options that
hardcode 0 as well, so my initial thought was that we should be using
the more precise wording -- the argument for flexibility now seems
more preferable, however.

>
> > +       If unset, it defaults to 1. The diff operation is used by many
> > +       other git commands such as add, merge, diff, status, stash and
> > +       more. Note that the expensive part of the diff operation is
> > +       reading the index from cache or memory. Therefore multiple jobs
> > +       may be detrimental to performance if your hardware does not
> > +       support parallel reads or if the number of jobs greatly exceeds
> > +       the amount of supported reads.
>
> So, in the future, someone who wants to speed things up is going to
> need to configure submodule.diffJobs, submodule.fetchJobs,
> submodule.checkoutJobs, submodule.grepJobs, submodule.mergeJobs, etc.?
>  I worry that we're headed towards a bit of a suboptimal user
> experience here.  It'd be nice to have a more central configuration of
> "yes, I want parallelism; please don't make me benchmark things in
> order to take advantage of it", if that's possible.  It may just be
> that the "optimal" parallelism varies significantly between commands,
> and also varies a lot based on hardware, repository sizes, background
> load on the system, etc. such that we can't provide a reasonable
> suggestion for those that want a value greater than 1.  Or maybe in
> the future we allow folks somehow to request our best guess at a good
> parallelization level and then let users override with these
> individual flags.  I'm just a little worried we might be making users
> do work that we should somehow figure out.

I had the same worry as well -- see the discussion I had here:
https://lore.kernel.org/git/CAFySSZAbsPuyPVX0+DQzArny2CEWs+GpQqJ3AOxUB_ffo8B3SQ@mail.gmail.com/
I would like to also eventually solve this problem, but this patch
won't be the one to do so.
