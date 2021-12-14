Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C7C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 07:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhLNHoj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Dec 2021 02:44:39 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:44806 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhLNHoi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 02:44:38 -0500
Received: by mail-pl1-f169.google.com with SMTP id q17so12955084plr.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 23:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M7va9J5riyPbX52KLNVxI5VQLv9UnO8fHu6Ku7fTCUI=;
        b=6VKxKLdwnn4OoPj6yB8AU/hcHn5bvjlQ6JY54KnNkZa5jOWlVEgvzQEAEp/iP0MO50
         o0sWZDUegyu1Vc6nIUo42nquR4c7C6+oNpwbyv/X9qMNcVlFgippBNf+Nzr1xOU7EQX6
         tLVnvXC0Fuc6QJg5Jl+bKjBasp8KwLNWSUMMUNkR2m6HleAQqSiIdBPMTFYtFFhFZ4kr
         s8BwXNXgUak28KJeowyIey7Q44nTeXrOgCEWlBCJNEoiTZ9uNQDfl9RPtqvmXIZb8mEI
         8RJNTym6LmWYaBVC0Yy1mArZU/ihixPoRIzrQmA9/kNDrVcI0ngpnyG2GHiDWNoAGSM7
         trRA==
X-Gm-Message-State: AOAM5335VRTN7cYxVrUI9tbVC92uhJb+8t+7t/RFFbUHhR4Ru6uWRUav
        1AeQPB6JIbWBAgA0a15OWxW+BH7AozbJKNWuL0c=
X-Google-Smtp-Source: ABdhPJxzfxQmbGezVhkrWw7SNHqI/n82dIgT2PkdUiLcgRmnF7suk8J93ZS5i2b7dLXuDRPAiRVdxdrz4P9+Lg0YRyo=
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr4038860pjb.236.1639467878131;
 Mon, 13 Dec 2021 23:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20211213063059.19424-6-sunshine@sunshineco.com> <RFC-patch-1.1-bb3f1577829-20211213T095456Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-1.1-bb3f1577829-20211213T095456Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Dec 2021 02:44:25 -0500
Message-ID: <CAPig+cSFtpt6ExbVDbcx3tZodrKFuM-r2GMW4TQ2tJmLvHBFtQ@mail.gmail.com>
Subject: Re: [RFC PATCH] t/Makefile: use dependency graph for "check-chainlint"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 5:09 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Dec 13 2021, Eric Sunshine wrote:
> > Rather than running `chainlint` and `diff` once per self-test -- which
> > may become expensive as more tests are added -- instead run `chainlint`
> > a single time over all tests bodies collectively and compare the result
> > to the collective "expected" output.
>
> I think that "optimizing" things like this is an anti-pattern. I.e. we
> have N chainlint test files, and N potential outputs from that (ok or
> not, and with/without error). If one of the chainlint tests changes
> we'd like to re-run it, if not we can re-use an earlier run.

As mentioned in a reply elsewhere, the commit message sells this as an
optimization, but that's not the real reason for the change, which is
that the rewritten `check-chainlint` target for the upcoming new
chainlint really wants to have a composite file of the "test" input
and a composite of the "expect" output. I didn't know how to sell that
change in this preparatory patch series, so I weakly framed it as an
optimization. The reason for making this a preparatory step is that it
makes for a less noisy patch later on when the new chainlint is
actually plugged into the `check-chainlint` target. At least, it was
less noisy originally... in the final implementation, I think it ends
up being noisy anyhow. So, maybe it makes sense to drop this patch
altogether(?).

> This is something make's dependency logic is perfectly suited for, and
> will be faster than any optimization of turning a for-loop into a
> "sed" command we run every time, since we'll only need to "stat" a few
> things to see that there's nothing to do.
>
> +BUILT_CHAINLINTTESTS = $(patsubst %,.build/%.actual,$(CHAINLINTTESTS))
> +
> +.build/chainlint:
> +       mkdir -p $@
> +
> +$(BUILT_CHAINLINTTESTS): | .build/chainlint
> +$(BUILT_CHAINLINTTESTS): .build/%.actual: %
> +       $(CHAINLINT) <$< | \
> +       sed -e '/^# LINT: /d' >$@ && \
> +       diff -u $(basename $<).expect $@
> +
> +check-chainlint: $(BUILT_CHAINLINTTESTS)

This sort of optimization makes sense (I think) even with the new
chainlint preferring to see composite "test" and "expect" files rather
than the individual files. The individual files would be prerequisites
of the composite files, thus the composites would only be regenerated
if the individual files change. And the composite files would be
prerequisites of the `check-chainlint` target, so it would only run if
the composite files change (or if chainlint itself changes).

In fact, with the new chainlint checking all tests in all scripts at
once, this technique should apply nicely to it, as well, since the
names of test scripts (t????-*.sh) are fed to it as command-line
arguments. Thus, the t????-*.sh files could be prerequisites of the
chainlint rule which would use $? to check only test scripts which
have changed since the previous run.

Having said all that, I don't think think the changes in this series
or the upcoming new chainlint series make the situation any worse
(Makefile-wise) than its current state, and the sort of optimizations
discussed here can easily be made after those series land. (And, as my
Git time is rather limited these days, I'd really like to focus on
getting the core components landed.)
