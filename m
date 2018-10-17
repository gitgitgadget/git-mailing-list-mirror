Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508BD1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeJRB5F (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 21:57:05 -0400
Received: from mail-vk1-f179.google.com ([209.85.221.179]:42512 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRB5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 21:57:04 -0400
Received: by mail-vk1-f179.google.com with SMTP id s129so1555588vke.9
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=a46+z7F4ZHo8XqgIGiy2r1bYnYXxW29rItKXc33ZRqs=;
        b=LeFsWMD2Uzj0ZgL/US4BKnhTxf2a1QePHojtzZu931hiI04wfD0XepB21QJDH0bmaR
         CA5Nlhir6GQiUUh5t2miXVNXseucU038Ie1D1u9udSseLeqGlOxXG24MbRYZ7Qhl9lIR
         WQw9WZdKegprCrVaqWURkhKU3TdeYXZ3xJ3GArxZqOaRs6pOmYSpYvP9Sjw+yG9R8Mcw
         f7lEAp7++XTUvSw6VoHtSexPenmz25H/kjrV79W+LZz93SjQ4NnlIxu+qHXCXI2w+on8
         UGzdtkfVDtT4Y02v/9E3sNeoy9owCWAsgiCAhVZPibDtTEnffEtaZOnY980zWAjGETjH
         c6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a46+z7F4ZHo8XqgIGiy2r1bYnYXxW29rItKXc33ZRqs=;
        b=q8G2HvwSmYQWPNgJoSwQbPnDnTRWXCNGWi1ugWc2usT8OHiZAauS+INeQSXTvKNQsE
         9r162yFFOlNtnx3b5z40lbq4ZFJMmDY6rUjqKrcdinv3NR6JQPwm/2lCVbd65FiJkMb/
         8UhIrMApcBrEby/q8jWLjPv3Dg5dTgiPYCGCwMXks5LBDNzZZR4oMtxmxHdrQdiejQga
         y+VRkMVvU05dUNraXCLZ37U4pwwcdbDb+GXllh2lMIxmBJ7LqBk0Mr8GEhwnJIZ70DR2
         3fK57I+MuQNTxbXFnTsMurgskV5qbpP7mk8aYd2aDZw8u/UiNn3P6VQWSnBJQ9mPbihr
         vBNg==
X-Gm-Message-State: ABuFfojyk4zpabD5ksEcORSth/olQC71rcMtWuaWboBe2e5VIxs0DnLm
        QMJdw+eAZX9/Xe+2SfmXrd1FgqRX6bq8uK0wZd8=
X-Google-Smtp-Source: ACcGV62K8/2FWH5+AjTiBt7qnOWbTYLD+hKjpNWvmYFC9n2MOj8nqWMDAJrYk2DTh1Ql30JBpm6EcArzaqBJYXZVSsw=
X-Received: by 2002:a1f:5e13:: with SMTP id s19mr10977250vkb.27.1539799215433;
 Wed, 17 Oct 2018 11:00:15 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Oct 2018 11:00:03 -0700
Message-ID: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
Subject: commit-graph is cool (overcoming add_missing_tags() perf issues)
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just wanted to give a shout-out for the commit-graph work and how
impressive it is.  I had an internal report from a user that git
pushes containing only one new tiny commit were taking over a minute
(in a moderate size repo with good network connectivity). After
digging for a while, I noticed three unusual things about the repo[1]:
  * he had push.followTags set to true
  * upstream repo had about 20k tags (despite only 55k commits)
  * his repo had an additional 2.5k tags, but none of these were in
    the history of the branches he was pushing and thus would not be
    included in any pushes.

Digging in, almost all the time was CPU-bound and spent in
add_missing_tags()[2].  If I'm reading the code correctly, it appears
that function loops over each tag, calling in_merge_bases_many() once
per tag.  Thus, for his case, we were potentially walking all of
history of the main branch 2.5k times.  That seemed rather suboptimal.

Before attempting to optimize, I decided to try out the commit-graph
with a version of git from pu.  While I expected a speed-up, I was a
bit suprised that it was a factor of over 100; dropping the time for
local dry-run push[2] to sub-second.  A quick look suggests that
commit-graph doesn't fix the fact that we call in_merge_bases_many() N
times from add_missing_tags() and thus likely need to do N merge base
computations, it just makes each of the N much faster.  So, perhaps
there's still another scaling issue we'll eventually need to address,
but for now, I'm pretty excited about commit-graph.

(And in the mean time I gave the user a one-liner to nuke his
local-only tags that I suspect he doesn't need.)

Thanks,
Elijah


[1] lerna seems to scale horribly, especially when you suddenly
transition dozens of web developers and even more independent
repositories into a single large monorepo.  Usage of lerna was
thankfully ripped out at some point, but the crazy number of
historical tags remain.  Also, this user did a bunch of the
filter-branch'ing to suck extra repos into the monorepo, likely
involved somehow in the many extra tags he had.

[2] In fact, I still had timings of over a minute when adjusting the command to:
  git push --follow-tags --dry-run /PATH/TO/LOCAL-MIRROR $BRANCH
