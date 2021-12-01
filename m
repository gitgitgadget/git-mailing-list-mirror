Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E789C43217
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 17:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351821AbhLARUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 12:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351657AbhLARUC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 12:20:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4780FC061748
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 09:16:41 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so104693514edd.13
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 09:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ij4dlwidk38wTefaeKyc25ge30WnxdiwF/Zp+QOntNY=;
        b=Zk0diMgjwVKuiUQtF9URgL8hWLDmbR6W6KeYukD9CQe+WMZ98xRRjrjFvTHVnwkcNb
         +nSt2gGOWFBHUBSwHXJAViDxHJRZam2TIHTX08RoL0TRPkJm1CbBIYWEcM2bRpbt7eis
         869zD0nljAlDLQCy/blPzbprauipzDmgCHeIafiDgdrUKDS3uBtgqxBxt86X8AlTdNI/
         WKWvXcHDu07pkfJMGXwH864m9278SvgjMiesoUGxlrYlTVtnADhJhGCJraDHNtWAPyUg
         f0CqihyOkQCOEi0M972WEOgHG4JRPg99h/Jtf6WGssk18vgb0t8hxVj0oUR/ZumIsxCy
         JfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ij4dlwidk38wTefaeKyc25ge30WnxdiwF/Zp+QOntNY=;
        b=UtSDj/NesidzbL7QdpGO1JtBH2PXiqSUQgFdH4vaj+kIVinFaAHeUgySac3QlLGHL0
         aBQIpA6WPJUsawjIDUwDsrVpwGqs63qeyaeOymgFVgWePxZs2QCkhoO2xIgYYsYXCICx
         rBbhC28DLAxCDlf0ZMbMdw8JF45iOsnnqAz1S5YuIVBZdVio5/zS51lMPf5O82Qjd6ED
         4q9rLuk4iucOwJ3MjUmnZSJsDZJVd44J/J50NZ7UllVPgqYTsNLsPTIKzC5eWP5jfCBq
         iiy2dSQM3tv2tWTbvEiHbxC/4mmSsfUoDFBKHMce63bl/SRnV2giDbKAk+lrBPT0nQLZ
         VB1Q==
X-Gm-Message-State: AOAM5314nhRIO6ngH952SSO7l0ES/WCr2t8Ib/ePa6Pr6+pURojS2khU
        dTcZl2Jt7oOWrYVZKBV2ly1/harfe3mVXFXSsJt2iPfuils=
X-Google-Smtp-Source: ABdhPJwVtraEUsd/jDvd+0nPoqaqwAqz+oONXYNA5ZCp5KIywxmDyWM1vzsWaLhtn83qq8fhjYaPLx1QId35A1hXYUk=
X-Received: by 2002:a17:906:3a4a:: with SMTP id a10mr8557605ejf.253.1638378999775;
 Wed, 01 Dec 2021 09:16:39 -0800 (PST)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Dec 2021 09:16:28 -0800
Message-ID: <CABPp-BE8TJ8QGAQWsSGT7S+9Xp-XmApcC9PSw3K=RQOP0rt+PQ@mail.gmail.com>
Subject: 2.34 regression (and workaround): deleting untracked files both
 outside *and inside* desired sparsity cone
To:     Derrick Stolee <stolee@gmail.com>, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've got a proposal for changing the sparse-checkout command slightly;
but it probably doesn't make sense without the context of the bugs
(old and new) we are facing.  Consider this an RFC, with the final
bullet point particularly in need of comment and ideas.

== Background ==

sparse-checkouts in cone mode are documented as being obtained either
by using the `--sparse` flag to `git clone`, or by running the
sequence:

    git sparse-checkout init --cone [--sparse-index]
    git sparse-checkout set ...

The first step has traditionally deleted all the tracked files from
the working tree, except in the toplevel directory, and the second
restores all the tracked files that are wanted.

(Usage context:)
My understanding is Microsoft never uses this sequence, instead using
the --sparse flag to `git clone`.  In contrast, at Palantir the
--sparse flag to clone is rarely used.

(An aside on pre-existing bugs/warts of the above sequence:)
This has always been bad from a performance point of view (especially
in more extreme not-so-sparse cases when the desired sparsity paths
represent roughly half of all paths), and has been suboptimal from a
UI point of view due to the dual progress meters (other wrappers, such
as an in-house `sparsify`, can have a single user-facing command for
switching to a sparse-checkout that has to call both of these git
commands under the hood; that wrapper would prefer one progress meter
to two).  But it never quite arose to the level of needing to be
fixed.

== The (New) Bug ==

Starting with Git 2.34, each step will delete all ignored files
outside the sparsity paths specified to the individual command in
question.  We are totally onboard with deleting ignored files outside
the sparsity paths the user wants, but the first command is required
according to the documentation and does not allow specifying any
sparsity paths.  Since it does not allow specifying any sparsity
paths, it treats *everything* as outside and essentially deletes all
ignored files everywhere.  That's not workable for us.  We want a
single command for changing to a sparse-checkout.

== The Current Workaround ==

Luckily, having these two commands separate isn't enforced, and the
first command is basically roughly equivalent to setting a few config
variables and then running `sparse-checkout set` with an empty set of
paths.  So, currently, we can just do the config setting part of init
manually, and then skip the rest of init, and then call our desired
`set` command:
    git config extensions.worktreeConfig true
    git config --worktree core.sparseCheckout true
    git config --worktree core.sparseCheckoutCone true
    git sparse-checkout set ...

Since we're using a wrapper anyway (for computing dependencies and
determining the list of directories to include), it was relatively
easy for us to add this workaround.

However, it is not clear that our current workaround will continue
functioning with future versions of git, particularly if
`sparse-checkout init` gains more options.  In fact, it already
doesn't handle --sparse-index.

== Long term proposal ==

Make `set` do both the work of `init` and `set`.

This means:
  * `set` gains the ability to parse both --cone and --sparse-index
(in addition to --stdin, etc.)
  * If the sparse-index is not initialized, `set` does the
initialization work of `init`.
  * Modify the `init` documentation to mark it as deprecated,
mentioning the 2-3 bugs above as reasons why.
  * We could effectively just turn `git sparse-checkout init ...` into
an alias for `git sparse-checkout set ...`, since init's parameters
would be a subset of those that `set` accepts.  However, the latter
might interact badly with allowing a user to toggle sparse-index on
and off in the middle of a sparse-checkout...so maybe we need
something more?  Alternatively, we could leave `init` as-is and just
consider it set in concrete, possibly risking it becoming
non-functional in a future upgrade.  Hmm...


Thoughts?
