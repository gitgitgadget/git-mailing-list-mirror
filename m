Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA668C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiK3SLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiK3SLn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:11:43 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643FF83E93
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:11:42 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3b56782b3f6so179233517b3.13
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fdEKr+/EcCus+9ZjPBtn0Fgia80Zl0imntctf65ipng=;
        b=IfYJ1X4ZsQGPf/6T8d3oJhFUgJdVkM9Db/4kyq3HJVgxl/ZQlDzGxTRD+H0koesHZx
         NcjhiDY7rCiTlMfQER+41EYMtkiHAlNlfAQFjs7FmzaxZKnrqrjVFaq7v3yuUCXJWvYG
         2A0HuYY/S5/egrltmB+sqaWQCQT+7YKmCxYRv5BHRSUK4RYl2zl4UmG/wJKbsY04MaIL
         JoxwL5olja8yjj3oyMrkONrKjuhmJXIBG9q8BSKdk8Yowkf3y8U0eXlpu1/or8vQ5LeH
         eY0Ky1rBInqlR0/OvLy+EjcPGK6bCDjZcDVxcyB5inS2nV4Jon3M2fLv1Z4uGjMPrqbw
         evCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdEKr+/EcCus+9ZjPBtn0Fgia80Zl0imntctf65ipng=;
        b=KMOVl8Dvnwudjj5N0Ci9asIObF0/Cjz4bM+o8kVM8owVl5EPl4F6ECD7AOtKMaS2Jg
         IkyEQyxOqsLKNoXhP5XiJXolcmKKMHblj3vHdoajwnWUtG2/zmJAFOp+DXqImPis+zqa
         r/S429i5MjrQWrldXl7MODKbuKlNR7eACjOauWhll8TA9a7kxi5t9IBctbWrlyIgCrhr
         iVrJHVvW0lEUmz3ZlQ5V8nyuOkxLZbgPj0ETPBFmfWw4yQ10JYQQSW9hvPDuaey/GFm2
         pnl0mLjdqqD+/SgDGcYvft+RC4oIywduO7UIBlz7ZNx9FQanp+bslqMZckknbFqJU2pe
         3HLA==
X-Gm-Message-State: ANoB5pnRrdz20SD6LLyMZ2G3rpKavNplV0jpCOT5OIbWujNHIuj8VVjd
        dinxJbYvFcPfJ987ln6zYO0sGFlyMvfuh/xAcM3u/Q==
X-Google-Smtp-Source: AA0mqf4zydyJz2FPSbAfmyL0ywwCW3mFlm+RRhKtdexT0JSD82HUe6m/OIZe4xx9koZZDgJlouz/oDBh/2Orz2svsR0=
X-Received: by 2002:a81:5345:0:b0:399:36f1:d851 with SMTP id
 h66-20020a815345000000b0039936f1d851mr40655713ywb.369.1669831901430; Wed, 30
 Nov 2022 10:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20221128210125.2751300-1-jonathantanmy@google.com> <kl6lr0xlqtrc.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lr0xlqtrc.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 30 Nov 2022 10:11:30 -0800
Message-ID: <CAFySSZD8NjOHpM6PBCVxBzB-m2WuBCTppZWB0waP9svo=O1C0A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] diff-lib: parallelize run_diff_files for submodules
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2022 at 2:29 PM Glen Choo <chooglen@google.com> wrote:
>
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > Calvin Wan <calvinwan@google.com> writes:
> >>  submodule.c                        | 154 +++++++++++++++++++++++++++++
> >
> > I think the way to implement this is to have a parallel implementation,
> > and then have the serial implementation call the parallel implementation's
> > functions, or have a common set of functions that both the parallel
> > implementation and the serial implementation call. Here, it seems that
> > the parallel implementation exists completely separate from the serial
> > implementation, with no code shared. That makes it both more difficult to
> > review, and also makes it difficult to make changes to how we diff submodules
> > in the future (since we would have to make changes in two parts of the code).
>
> It seems that most of the code is copied from is_submodule_modified(),
> so a possible way to do this would be:
>
> - Split is_submodule_modified() into 2 functions, one that sets up the
>   "git status --porcelain=2" process (named something like
>   setup_status_porcelain()) and one that parses its output (this is
>   parse_status_porcelain() in Patch 2). The serial implementation
>   (is_submodule_modified()) uses both of these and has some extra logic
>   to run the child process.
>
> - Refactor get_next_submodule_status() (from this patch) to use
>   setup_status_porcelain().

That sounds like a reasonable plan to me. Thanks!
