Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59FCC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiIZTNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiIZTM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:12:59 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6439395518
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:12:58 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3450a7358baso78521397b3.13
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hF8ihv3Fk5LpWc0iTVOQGmfR9sQ/ZOteZ3PD6po9G0I=;
        b=m5V2gXeXlMxBphxxdlyi/oZrTdfHXtazu+FHGixNkXH05GQ+Wg6ZwJSadHtpGpyhtv
         RaIkJKwEAvAj7vvkXk0boQZ9JteSDw7qxVOYsXl4GdRn7p+hpr31lzl9ZeiEj0/Xgkgp
         JSC3jrHYW+0ffiMIbYb1xV914PDzmrJ2wRVFGr85VyZigKROtHRhgMsz1C4tVeTLX08+
         JRC8jIBrgoYN0BvMOoKXiWg9jOddP14T3Or0HVl4+UPAqIUTvbPpxq+O44BLXEMFQaAt
         prsckhrlbSc8fiO4wld6MGXM2C+9b0ty5k5EJnwyzCc+3UxzMZENACbi9JyIRTo5Y1D3
         AT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hF8ihv3Fk5LpWc0iTVOQGmfR9sQ/ZOteZ3PD6po9G0I=;
        b=P2kvOdOltbae799uo955X9x8sQz7ycSG06mKkhw/oFVRgo1xS6NYg46KL7BJ6yFtHG
         MliOV3ro5S94+Lv1lGDEubPKEBrAaiNhHeD0wU+7lsh02EKnp0v2fIsrGIVT2jerYCAp
         bg/HbTjZhwcTGNImoj+Y70EAe+v7Qcp/gBj8xwmJbzjC9mjHaHkxxezkNgze9XavfsDI
         gv+MfE9jPq+HRxmkcRuE+qZp/51+RrWVy2ZhPVnOk/1k/sSUgsHx9fia9TwUzXxL3Ywj
         G8VBrNYoqUJHNFDbVf+sSGrkjEjzt2ZLQwFC/eA9t6rmr/chUV1QhVVtG4y/pEO24618
         Gy4Q==
X-Gm-Message-State: ACrzQf0P85Y9uKQSKKl9DvCzXcuxE+i4bwCkyrJsaV4s+9SVWbozqiHq
        JAkyO+HgCfgeBl6jAwX4rCNTPM5w6hBGhQ3SYK4nzg==
X-Google-Smtp-Source: AMsMyM7Y+sKDatSOsOfXtvrnJgBdyL/ADW9Huqyh0kn9k2o1qr7LlOw373LH0j9l75cbOJ0KGcK2LkW57b1kmXDS+dU=
X-Received: by 2002:a81:7182:0:b0:349:de4c:7a00 with SMTP id
 m124-20020a817182000000b00349de4c7a00mr21939701ywc.385.1664219577464; Mon, 26
 Sep 2022 12:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-5-calvinwan@google.com>
 <xmqqy1u9sr3a.fsf@gitster.g>
In-Reply-To: <xmqqy1u9sr3a.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 26 Sep 2022 12:12:46 -0700
Message-ID: <CAFySSZBCaAUGZuEdxSJEW_7tEcOVJfnkA_nY6BTkTQ1s3xGd5g@mail.gmail.com>
Subject: Re: [PATCH 4/4] diff-lib: parallelize run_diff_files for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> You make it sound as if this is only for "git status", but shouldn't
> it benefit the usual "git diff" the same way when you have
> submodules that can be dirty?

It should also! I'll reword the commit message.

> > Add config option status.parallelSubmodules to set the maximum number
> > of parallel jobs.
>
> Configuration is fine, but I am having a hard time justifying the
> addition of an extra parameter to run_diff_files().  It might be
> more palatable to give a new bit (default off) in the rev structure
> that tells it that it is OK to go into the "defer_submodule_status"
> mode, if we absolutely want to change the behaviour of
> run_diff_files() only for a single caller or something, but I doubt
> it should even be needed.
>
> I cannot think of a sane user interface that says "when
> run_diff_files() is invoked as an implementation detail of 'status',
> use this value, and when it is running for another command 'foo',
> use this other value".  How would a user decide to pick a different
> value for different commands?
>
> Letting a single configuration variable to decide the degree of
> parallelism inside run_diff_files() would be sufficient, and we
> shouldn't have to touch all the existing calling sites of
> run_diff_files() all over the place.  If you absolutely want to do
> this, I'd rather see the new member for the configuration variable
> not in wt_status but in rev_info.

I agree the configuration variable should be in rev_info and not
be specific to status since other callers can take advantage of it.

>
> > +status.parallelSubmodules::
> > +     When linkgit:git-status[1] is run in a superproject with
> > +     submodules, a status subprocess is spawned for every submodule.
> > +     This option specifies the number of submodule status subprocesses
> > +     to run in parallel. If unset, it defaults to 1.
>
> As I said, I am not sure <cmd>.parallelSubmodules per command makes
> much sense.  "If unset, it defaults to" sounds a bit redundant (if
> it is explicitly set, the default value should not matter).

ack.

> > @@ -138,6 +153,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
> >               struct cache_entry *ce = istate->cache[i];
> >               int changed;
> >               unsigned dirty_submodule = 0;
> > +             int defer_submodule_status = revs && revs->repo &&
> > +                                                     !strcmp(revs->repo->gitdir, ".git");
>
> What is this overly deeply indented comparison with ".git" doing?
> What are we checking and why?  Is that something we need to do for
> each and every active_cache[] entry, or isn't it constant over the
> loop?

It is checking to see whether we are in the superproject or not, since
it doesn't make sense to parallelize status in a submodule subprocess.
It doesn't need to be in the loop though -- will move out.

> > +             int ignore_untracked_in_submodules;
> >
> >               if (diff_can_quit_early(&revs->diffopt))
> >                       break;
> > @@ -269,11 +287,36 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
> >                       }
> >
> >                       changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
> > +                                                     ce_option, &dirty_submodule,
> > +                                                     &defer_submodule_status,
> > +                                                     &ignore_untracked_in_submodules);
> >                       newmode = ce_mode_from_stat(ce, st.st_mode);
> > +                     if (defer_submodule_status) {
> > +                             struct string_list_item *item =
> > +                                                             string_list_append(&submodules, ce->name);
> > +                             struct submodule_status_util *util = xmalloc(sizeof(*util));
> > +                             util->changed = changed;
> > +                             util->dirty_submodule = 0;
> > +                             util->ignore_untracked = ignore_untracked_in_submodules;
> > +                             util->newmode = newmode;
> > +                             util->ce = ce;
> > +                             item->util = util;
> > +                             continue;
>
> This makes me wonder if defer_submodule_status should be a string
> list that receives the punted submodules---iow, don't these details
> belong to match_stat_with_submodule() rather than its caller here?

That makes sense. I can definitely clean up this section and
match_stat_with_submodules() more.

>
> Even better may be to start a new child task for the submodule here,
> letting it work while the parent process moves on to the next entry
> in the active_cache[].  I do not know if you thought about doing it
> that way.

I think the implementation complexity of doing it this way would be
very high -- basically reimplementing run_processes_parallel(), but
within this loop. And the benefit of doing so I think is not worth it -- at
that point, I might as well parallelize the entire function.

> > +             for (int i = 0; i < submodules.nr; i++) {
>
> We still do not allow "for (type var = init; ...)" if I am not
> mistaken.  Check the coding guidelines.

ack.
