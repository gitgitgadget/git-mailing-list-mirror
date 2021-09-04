Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C42C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 10:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27DF60FA0
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 10:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhIDKTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 06:19:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:39280 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhIDKTE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 06:19:04 -0400
Received: (qmail 32159 invoked by uid 109); 4 Sep 2021 10:18:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Sep 2021 10:18:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10127 invoked by uid 111); 4 Sep 2021 10:18:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Sep 2021 06:18:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Sep 2021 06:18:02 -0400
From:   Jeff King <peff@peff.net>
To:     Fedor Biryukov <fedor.birjukov@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: Aborting 'rebase main feat' removes unversioned files
Message-ID: <YTNH2vMPuEW4SBMo@coredump.intra.peff.net>
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com>
 <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net>
 <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 04, 2021 at 11:51:19AM +0200, Fedor Biryukov wrote:

> There is no way this could be the intended behavior, but the good news
> is that I cannot reproduce it...
> Looks like it occurs only in one git version (2.31.0.windows.1, IIRC).
> And it does not occur in the latest git version: git version 2.33.0.windows.2.

I think it is a bug, and it seems to reproduce easily for me (with both
the current tip of master, and with v2.33.0). Here's the recipe you
showed, with a little debugging at the end:

  set -x
  git init repo
  cd repo
  git commit -m base --allow-empty
  git checkout -b feat
  echo feat >readme.txt
  git add readme.txt
  git commit -m txt=feat
  git checkout main
  echo precious >readme.txt

  cat readme.txt
  git checkout feat
  cat readme.txt
  git rebase main feat
  cat readme.txt

This produces:

  + cat readme.txt
  precious
  + git checkout feat
  error: The following untracked working tree files would be overwritten by checkout:
  	readme.txt
  Please move or remove them before you switch branches.
  Aborting
  + cat readme.txt
  precious
  + git rebase main feat
  Current branch feat is up to date.
  + cat readme.txt
  feat

So git-checkout was not willing to overwrite the untracked content, but
rebase was happy to obliterate it.

It does the right thing in very old versions. Bisecting, it looks like
the problem arrived in 5541bd5b8f (rebase: default to using the builtin
rebase, 2018-08-08). So the bug is in the conversion from the legacy
shell script to C (which makes sense; the shell version was just calling
"git checkout", which we know does the right thing).

-Peff
