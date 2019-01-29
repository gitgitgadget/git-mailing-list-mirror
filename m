Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE331F453
	for <e@80x24.org>; Tue, 29 Jan 2019 21:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfA2VjH (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 16:39:07 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33562 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfA2VjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 16:39:06 -0500
Received: by mail-ot1-f47.google.com with SMTP id i20so19328738otl.0
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 13:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neosmart.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=6ltYHD+hvWIdh14S4y5GRzw4klfZ0F0AUpZNqYOjR5Y=;
        b=kRYRw540/1hfrgYShI/T/Onenh6wxtggOepHuJTtTEOPdlqLJZo06+DWUcVhLOkML1
         JbEo7pMe4SR3MOlaq1vPW7kF6cNgZ48FWTsVBymHonAukdUmIIwJ5VBjJ/9b2Kh3z6th
         0Dy+1UUUIHXTxmgtt9ISnOB7e2dX4rur1b0So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6ltYHD+hvWIdh14S4y5GRzw4klfZ0F0AUpZNqYOjR5Y=;
        b=WdDjjMXmTZq520CMal7aqif5sDcUbAFmZwU6WHVOm+ShwT2M67gnA54QaxnoR4LQGJ
         cLKgjVWLIkArtcQCy8ppoxdrdaZaCv/NmblSI8E4ZkYMmwLgF+US936QEdlKD6zfzdy8
         P2I196WF4jEcTg7M1ZjygPnx8emQGU72LOIr4yjd0O6IoKvWuhbdiRLI+irhQKPJgsNh
         vphNhMF/SFbArOADriWY1OHQYsJBHDpfV1+cBQ77M3lRJb4QKNcFPv3SWbvWfePA2ATF
         1TIpsyQ2lqSs7jd+2cX6McNmBPUpHkbUcmx3w7Apo+WTMl+CYhFJX3QcDW/RqU4EEdcU
         Rswg==
X-Gm-Message-State: AJcUukcDSFLmmTagyue5Gvtbn53FHPqENRHq6WYdvpaZdpP8Y4nBTqS1
        fUGUDF9kIiHqp8ABJPttyLxMOCHGRsemYNnntjq8ZiLON+55cg==
X-Google-Smtp-Source: ALg8bN5vIffiRfY0EGl0jJF/hi2mgoj94phnpSO20bk5DFwlBI8ycQ/6HJQ6+8fm40xP3N6R/v48p/tGMdf1fg4svOw=
X-Received: by 2002:a9d:75c5:: with SMTP id c5mr15701462otl.356.1548797945488;
 Tue, 29 Jan 2019 13:39:05 -0800 (PST)
MIME-Version: 1.0
From:   Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Date:   Tue, 29 Jan 2019 15:38:51 -0600
Message-ID: <CACcTrKc_0vWzp3oskhBOQfxu97t=kmg=qeXq7Yg6L8bFvsyRFQ@mail.gmail.com>
Subject: Extending `git pull` to deal with unindexed changes that would be overwritten
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

A common point of friction when flipping back and forth between branches,
especially when dealing with build configurations/artifacts that were sometimes
included in the repository and sometimes not (e.g. the artifacts of an
`autoreconf` run) is when a file not in the index at all would be overridden by
the attempted checkout.

e.g. file `:/foo` is currently not in the index in any way, shape, or form (soft
or hard) and executing `git checkout bar` would result in a copy of `bar:/foo`
being checked out, which leads git to emit the following notice and abort the
checkout:

> error: The following untracked working tree files would be overwritten by
> checkout:
>    foo

When it's a single file like in the example above, it's easy enough to add it to
the index, stash your changes, then retry the checkout. But when there are
multiple files involved -- perhaps especially in the presence of other untracked
files you *don't* want to stash -- it's not as straightforward.

I would like to propose two changes extending current git actions to handle such
a scenario:

1) `git pull --autostash` (both with and without `--rebase`, the latter of which
   is currently not a valid option), which would do the equivalent of calling
   `git add` on each of the files that would be overwritten followed by `git
   stash`, and
2) Either extending `git pull --force` or introducing something along the lines
   of `git pull --reset` or similar which would forcibly drop the changes that
   would be overwritten (e.g. equivalent to extension 1 above followed by `git
   stash drop`) as an alternative to running `git reset --hard` before
   attempting to repeat the checkout operation but dropping only changes that
   explicitly conflict with the requested checkout operation (so somewhat less
   destructive).

(I believe the first proposal should be fairly straightforward and free of
controversy, the second might be a little too dramatic or dangerous to be
accepted.)

With regards to the first extension: as mentioned, it is currently an error to
run `git pull --autostash` without `--rebase` as well, but currently even the
accepted `git pull --autostash --rebase` does *not* stash changes to files not
in the index that would be overwritten by the checkout.

Of course there's an incredibly good chance that I'm missing a git action that
already does what's requested that I just don't know about -- in which case,
please do enlighten me!

Thank you for your consideration,

Mahmoud Al-Qudsi
NeoSmart Technologies
