Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD001F404
	for <e@80x24.org>; Fri, 23 Feb 2018 03:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBWDlK (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 22:41:10 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:35076 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBWDlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 22:41:09 -0500
Received: from homiemail-a99.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 453E0863DA
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 19:41:09 -0800 (PST)
Received: from homiemail-a99.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a99.g.dreamhost.com (Postfix) with ESMTP id A954ED3E06A
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 19:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mergebase.com; h=
        mime-version:from:date:message-id:subject:to:content-type; s=
        mergebase.com; bh=bE2iTcRgm8FFGsF9DZBfAAG/dnQ=; b=HYIfbWC4ZdOMFI
        Mxe4BTiZDO2d6SHsKK7jmLme4tjbTl04+dk6PzTNl9ERhFJcgHTK9KpjQnvQ4FRz
        O9oneHR2PwkvTXsDpg4d707YPQ7N/VV8YJoTj9p4XL5oo265j0CbVueKVBMWUFX5
        rLaM1XXI3nPaqkrlKWmVT7m5DPUsE=
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com [209.85.214.46])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: julius@mergebase.com)
        by homiemail-a99.g.dreamhost.com (Postfix) with ESMTPSA id 17F14D3E068
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 19:41:08 -0800 (PST)
Received: by mail-it0-f46.google.com with SMTP id a75so1517484itd.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 19:41:08 -0800 (PST)
X-Gm-Message-State: APf1xPCJ4IVAzFC3aPezq3oD24qN6s+YrbmAygOB50odVO7fKxn2TkAc
        mSmGclb0kIpSTZ+d17IHA7QrmQLKFyxOZQAd0A==
X-Google-Smtp-Source: AG47ELuqMjOuy7gKms9a4R48e0FLWB1LZ9UhJA1oboV52OalFJNq8D21ktQk0Tpb+mqjGGr0tkkoSjD6NpE9j72Qphs=
X-Received: by 10.36.90.5 with SMTP id v5mr776800ita.138.1519357267420; Thu,
 22 Feb 2018 19:41:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.1.69 with HTTP; Thu, 22 Feb 2018 19:41:06 -0800 (PST)
From:   Julius Musseau <julius@mergebase.com>
Date:   Thu, 22 Feb 2018 19:41:06 -0800
X-Gmail-Original-Message-ID: <CAA7Zk=tMMPE_Ov6cSJuzgYwWmTuMTSd_909c5JY3a2k5KFzHgQ@mail.gmail.com>
Message-ID: <CAA7Zk=tMMPE_Ov6cSJuzgYwWmTuMTSd_909c5JY3a2k5KFzHgQ@mail.gmail.com>
Subject: RFC: git squash
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Git Developers,

Thanks for your help regarding my earlier email (trying to break git
pull --rebase).

I just wanted to warn you all that my first attempt at a patch is
imminent.  I'm working on a "git squash" command.  Here's a quick
summary:

------
git squash [<commit>]

Squashes <commit>..HEAD into a single commit. Replaces HEAD with the
result.  If not specified, <commit> defaults to the current branch's
upstream (a.k.a. @{upstream}).

Rationale:

This command provides an intuitive mechanism for in-place squash that
doesn't drop dirty merge results.

We call this an in-place squash because the state of all files and
directories at HEAD does not change. Only the ancestory of HEAD
changes: its (only) parent becomes the merge-base of <commit> and
HEAD, removing all intermediate commits.

Alternatives:

- "git merge --squash master" correctly preserves dirty merge results,
but it's tricky to achieve an in-place squash with this command, since
it requires the following sequence of commands (these assume the
current branch is "feature" and we want to squash it relative to
"master"):

    git checkout $(git merge-base HEAD master)
    git merge --squash feature
    git commit
    git branch -f feature
    git checkout feature

- "git rebase --interactive HEAD~N" with commits set to "squash" (or
"fixup") is very popular in industry.  But it has some tricky edge
cases: drops dirty merge results, can run into conflicts, and can be
confusing if HEAD~N spans any merges (including clean merges).
-----


I expect I'll have the patch finished this weekend, and ready for
everyone to look at by Monday (Feb 26th).

Note:  I'm not 100% sure "git rebase --interactive" would drop dirty
merge results (e.g., the dirty parts from conflict-resolving merges).
That's speculation on my part.  I'll confirm this before I finish and
submit the patch.


yours sincerely,

Julius Musseau
