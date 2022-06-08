Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8050AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiFHUgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiFHUgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:36:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C837928E34
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:36:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so24974897pjo.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KNTM1q9CQmrkcYZal2XpmGrgIA1lTa7tUhqDWgBT0ps=;
        b=W5HJcAqIOGa6QNvAxVxk9pbAjuNrnYUSXjPYgj+STnQcGbYORZ3oggJAngIVHDPvzU
         7bWpwl8XeKTLjXs6/yF61AyjYWu0osa+7l3fFg7QEvH6pSkAF6V7gX58el7f0T6MCrV9
         zF+dVC7dk8S0mvUxRyonNa+271oxwQJ0yg5vf/la1NbnlYLtCQD6RxsMY//pAzQfb3xl
         KWwIRkMm3oJwt24eIDKeSiutS5DV/WUFffKdk8S9jN7ibrK/ClBLsYFkNzyvW4FyjHO2
         JMAqeQkqbm0iH4aTtAwCuNc9SlPUn5IurtRwqb4d3POLKfKPb52QduhjmjFA4ysa/MyJ
         wDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KNTM1q9CQmrkcYZal2XpmGrgIA1lTa7tUhqDWgBT0ps=;
        b=Uas1r/z5DBxnST5TC+Z3FYNH26eM/sl9q6YrxWkn2XjwzzPN3nHONAnRSsdDTNleGE
         /fyt7si6X6R5kZftJZK/rRMbBihzpd5j025aH8r9nsF99vIub90wPscot1cgTWJdBUel
         iM+cCalOmLEcoH+ZPHl6Zm4cjJwgKkzXk72ExKgvHNsROrNCro1aArptGhR6w1T5PrP+
         dRTnYkUgqB851dudwq48iRTNFhqkzSMdYoj0dfD5wVxqFvl+YO6JKuK79m31vh9sSVTQ
         9radD06YDdmkEx8wIvNU+Uislm7MCGNjYQngw69nWQi6GScamxFt5TMpPUm4Y269qsqV
         7SIg==
X-Gm-Message-State: AOAM532nuo20Cw+8DZDgK2R2pNaAbDMjirWSwTh41cDdEAoDkeZd3xc/
        Z7ZxytfRFRqHg6ct1/+Em5RyBdA69zNlZQCwZlR0ihf7ti4=
X-Google-Smtp-Source: ABdhPJzWUnU0I+ObMcJ3as4ApNWLFmab0UFo3gnsR5xScbt6wrNgvMis3kuhiXpw2czSyBHn793TsECf1SD481DSyp8=
X-Received: by 2002:a17:902:d409:b0:167:7425:caa8 with SMTP id
 b9-20020a170902d40900b001677425caa8mr18824518ple.72.1654720573131; Wed, 08
 Jun 2022 13:36:13 -0700 (PDT)
MIME-Version: 1.0
From:   Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com>
Date:   Wed, 8 Jun 2022 13:36:02 -0700
Message-ID: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
Subject: Best way to update `HEAD` in mirrored repos
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Given a repo cloned like so:
`git clone --mirror someRemote`

And then with its origin updated like so
`git remote set-url origin someRemote`

What would be the best way to update the `HEAD` ref in the clone, if
some change happens to the remote HEAD? Like say, the default branch
changing from `main` to `dev` or being renamed from `main` to
`main_2`.

What I've got that I think works
1. Get the ref from the origin that points to `HEAD`. Extract the ref
from the output.
2. Manually update the `HEAD` ref with the extracted output prior step

Like so:
```
$ git ls-remote --symref origin HEAD
ref: refs/heads/good_main_3     HEAD
0666a519f94b8500ab6f14bdf7c9c2e5ca7d5821        HEAD

$ git symbolic-ref HEAD refs/heads/good_main_3
```

Does this make sense?

The following are some of the things I've tried - they all fail to
update the `HEAD` file, or fail for some other reason.
`git fetch -p`
`git fetch -p -a`
`get fetch -p -a -u`
`git remote set-head origin -a`
   Fails with "error: Not a valid ref:
refs/remotes/origin/good_main_3". The ref it fails with is whatever
the remote HEAD is.
`git remote update --prune`

And my use case:
I have a set of git repos cloned/mirrored. They are then indexed for
search, using the `HEAD` ref. The indexer runs periodically, and
before indexing it always runs `get fetch -p` to update repos. For
each repo, to get the latest commit to index, I use the libgit2
equivalent of `git rev-parse HEAD^0`. Right now, previously cloned
repos whose HEAD is updated after the initial clone will fail at this
step, which causes them to not get indexed. Here's an example run, all
for the same repo `x`.

1. `git clone & set origin for repo x` (indexer first clones repo if
it doesn't exist)
2. `git rev-parse HEAD^0` - successfully outputs some commit sha
3. Github default branch is renamed from `main` to `main_3`
4. `git fetch -p` - indexer runs this to update
5. `git rev-parse HEAD^0` - now outputs "fatal: ambiguous argument
'HEAD^0': unknown revision or path not in the working tree."

Thanks for your time,

Rodrigo
