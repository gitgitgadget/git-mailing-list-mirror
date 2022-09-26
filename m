Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5A5C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIZTWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIZTWR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:22:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F36B173
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:22:17 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3321c2a8d4cso79278687b3.5
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=erEpEN9/sGmWKDGXo28uz7QE6wb3hu52Bc9TE8tb/Os=;
        b=EMdMxAyMqX0VKJ7GEPC6jFCZhV+wMtlJIDUhGQW6UmDuCiRwfVP17f1zkQId15qfoL
         zzHNtmSpsKaQ8/C7UAQeucZzXIvXYYyVJFXnR77I9thwx3DrnPFZWahZHc3R+nO1F7fH
         V3mDd3wBLUpUwfV6o+udJCOk/dp0sCBK6lZA9Ol+/W+qBR/AyPV/C1ovvGpxoLUWfwFO
         qbYoBe40ZEep8JlV2Hc/wr2flozJtWkwyephGanLNhmE8uHtj/C3wfhXx4+BDs5CM2m7
         vtQDNnMj2Ex6472rOUj6E6nGvBLtcWyGZ/4AcqseZ4TdWzvKeM7pjxsvINPqe0qnYDn8
         QsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=erEpEN9/sGmWKDGXo28uz7QE6wb3hu52Bc9TE8tb/Os=;
        b=hsmg+DaXSHQY6rHcz1SmP/KVcGY3AG1MRZR6Lx2NFsympACb499MOP2jJhilapDmrC
         +BBpMKF1w+ZVtjP1Aa469oz+GGgDV7F2NmQ7RVi2flLVPz1B6FwTqY50+z5m37AP0Z0l
         j29y2wxiHQ9qfEJUl5/WYpjliRXBkFn1r3tyAtQ7DfoVvQ9Dvv0wvsZznOFzlz4XAVtM
         Do4vsnRTRGKbPw/PsO/ScJ/pwHhUt3QEOjoze6uQWQMvGBfAyggpG+Oq7sN7Rka072t9
         9+Cyr/gWWnLQXOGO+KuO4np4119zSG7UaMFQ4b7C+fm/FrQI+Q6i8/gmO92tawgXJL2Z
         epaQ==
X-Gm-Message-State: ACrzQf2kuJb+cBiSnX+2wck/rMODLN5ozuWTYAeonnLrLRngxce2tHUE
        c/OjJifb2Nn6QUTiIY0FlQvWugEIL9kwCtPAIupkXA==
X-Google-Smtp-Source: AMsMyM4uuUjYI+4UcYgKLESKs9ccujDgwmoenmjRPWtCerdlWKLas6eu5cOKOjTCB7VS4++1gUdozV8qirDYbnJCrS8=
X-Received: by 2002:a81:7346:0:b0:34d:8987:26e6 with SMTP id
 o67-20020a817346000000b0034d898726e6mr22724186ywc.379.1664220136148; Mon, 26
 Sep 2022 12:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-5-calvinwan@google.com>
 <88b194d9-7c78-c12e-1c29-95f768db7772@gmail.com>
In-Reply-To: <88b194d9-7c78-c12e-1c29-95f768db7772@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 26 Sep 2022 12:22:05 -0700
Message-ID: <CAFySSZAM4Ae2AoBMj1BLdpdaNkfTQkFdT--QBc6T=4VcrcnJDQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] diff-lib: parallelize run_diff_files for submodules
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I suspect in the future we may want to parallelize other commands for
> submodules in which case a more general name such as submodules.threads
> might be a better choice. The speed up in the cover letter is
> impressive, could this be safely enabled by default?

Unfortunately not. To reiterate the answer I gave to Avar:
In my cover letter, I noted that with too many processes, status starts to
slow down (but is still better than the baseline). This is because the
expensive part of status is IO, specifically reading objects from the index.
Much of the speedup of this patch comes from taking advantage of the
ability to do parallel reads on an SSD, rather than splitting up the work
of status. However, this doesn't work with an HDD, so status may
actually be slower than baseline with multiple processes since there is
now scheduling/switching overhead.

>
> > index fcf9c85947..c5147a7952 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1468,6 +1468,12 @@ static int git_status_config(const char *k, const char *v, void *cb)
> >               s->detect_rename = git_config_rename(k, v);
> >               return 0;
> >       }
> > +     if (!strcmp(k, "status.parallelsubmodules")) {
> > +             s->parallel_jobs_submodules = git_config_int(k, v);
> > +             if (s->parallel_jobs_submodules < 0)
> > +                     die(_("status.parallelsubmodules cannot be negative"));
>
> What does a value of zero mean?

Looking at my code I set it to 1 if it's zero, but I should update the logic to
something more reasonable as Junio suggested.

>
> > diff --git a/diff-lib.c b/diff-lib.c
> > index 2e148b79e6..ec745755fc 100644
> > --- a/diff-lib.c
> > +++ b/diff-lib.c
>
> > -int run_diff_files(struct rev_info *revs, unsigned int option)
> > +int run_diff_files(struct rev_info *revs, unsigned int option, int parallel_jobs)
>
> Another possibility would be to add a member to struct diff_opts, rather
> than changing the function signature here, I'm wondering what the trade
> offs of the two approaches are. Also seeing all the callers from other
> commands being changed made me wonder if they would benefit from
> parallelizing submodules as well. There aren't any tests - could we use
> GIT_TRACE2 to check that we are running the submodule diffs in parallel?

Adding the option to rev_info seems like the best way forward. I neglected to
write tests for this patch since the parallelism comes from
run_processes_parallel() which already has tests for that. But maybe it is a
good idea to also add a test with GIT_TRACE2 for a sanity check.

Thanks!
