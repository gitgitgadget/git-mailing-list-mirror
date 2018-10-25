Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402D71F453
	for <e@80x24.org>; Thu, 25 Oct 2018 19:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJZDsj (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:48:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43857 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeJZDsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:48:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id r71so2158464qkr.10
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 12:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSq75s7f8UNNxIZaV92G0YZcEdB0Muwr3sR99Qb8sSA=;
        b=TVqXDKuW3BGn56ERoEST+znLrhFfAZbQk9F2LBDtsNsnJ/+NEvDLjsDo9AQHiFOsgH
         owc6lmSQVSVzWUxQyQMvuJhkfnDH8Lx+eordAJol6thNFsBAnYWgi/vymhzxasoJSjUS
         vTfSWb9Vz49LKrMYgfZG1hQ7zHdfbNxyEcj2ekI4WmG+ki8BPg9Ckk1wlQuUj99H287c
         CCF22Bm45PBgPBcDgsyb/W5qI3YSupmW8pLZXjjPAj0EESHVgG1629XjMTzGutCTF+HS
         XBoNJHsm+VHifllffmbVL2VmCaYnq9UlYYeFTEB5VxRtBUixlFLCDKTl7KmqP8LZIznr
         kVPQ==
X-Gm-Message-State: AGRZ1gKMOJc9flUm+0yJKp+grWG+lS65UG/PAFDgPp38xRHDsZAP5WA5
        u64cH95tT6AHBsmkBf68k5u3oNUs4x7WhQDcGITGRg9b
X-Google-Smtp-Source: AJdET5cR2zAflF/VR3KEaD85XVd9Aan04kCamBuNHZ43BQcgSWDSw8rdc9AKz5xlAnA1JwB35AH/1vksumw8S45ShlE=
X-Received: by 2002:a37:a315:: with SMTP id m21mr458113qke.152.1540494876974;
 Thu, 25 Oct 2018 12:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181024063904.36096-1-nbelakovski@gmail.com> <CAPig+cRN_0VVe6dzhnmU73pgo-8ncPzmOx4bRrTBVvReLW6RfQ@mail.gmail.com>
 <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
In-Reply-To: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 25 Oct 2018 15:14:25 -0400
Message-ID: <CAPig+cTvKd2DVu7wW_A31p_o7BaNJszu14kNRz9sqk8h45H4-g@mail.gmail.com>
Subject: Re: [PATCH] worktree: populate lock_reason in get_worktrees and light
 refactor/cleanup in worktree files
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Mike Rappazzo <rappazzo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 1:47 AM Nickolai Belakovski
<nbelakovski@gmail.com> wrote:
> The motivation for the change is some work that I'm doing to add a
> worktree atom in ref-filter.c. I wanted that atom to be able to access
> all fields of the worktree struct and noticed that lock_reason wasn't
> getting populated so I figured I'd go and fix that.
>
> Reviewing this work in the context of your feedback and Junio's
> previous comments, I think it makes sense to only have a field in the
> struct indicating whether or not the worktree is locked, and have a
> separate function for getting the reason.

Is your new ref-filter atom going to be boolean-only or will it also
have a form (or a separate atom) for retrieving the lock-reason? I
imagine both could be desirable.

In any event, implementation-wise, I would think that such an atom (or
atoms) could be easily built with the existing worktree API (with its
lazy-loading and caching), which might be an easy way forward since
you wouldn't need this patch or the updated one you posted[1], thus no
need to justify such a change.

> Since the only cases in
> which the reason is retrieved in the current codebase are cases where
> the program immediately dies, caching seems a moot point.

If your new atom has a form for retrieving the lock reason, then
caching could potentially be beneficial(?).

[1]: https://public-inbox.org/git/20181025055142.38077-1-nbelakovski@gmail.com/
