Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077CAC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 09:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF84260231
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 09:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhIDJta (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 05:49:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:39256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhIDJt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 05:49:29 -0400
Received: (qmail 32052 invoked by uid 109); 4 Sep 2021 09:48:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Sep 2021 09:48:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9877 invoked by uid 111); 4 Sep 2021 09:48:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Sep 2021 05:48:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Sep 2021 05:48:25 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Fedor Biryukov <fedor.birjukov@gmail.com>, git@vger.kernel.org
Subject: Re: Aborting 'rebase main feat' removes unversioned files
Message-ID: <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net>
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com>
 <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 04, 2021 at 01:57:11PM +0700, Bagas Sanjaya wrote:

> On 04/09/21 03.33, Fedor Biryukov wrote:
> > Looks like a bug in git rebase main feat.
> > 
> > To reproduce:
> > git init
> > git commit -m 'init' --allow-empty
> > git checkout -b feat
> > echo 123 > readme.txt
> > git add readme.txt
> > git commit -m 'txt=123'
> > git checkout main
> > echo 012 > readme.txt
> > git rebase main feat
> > git rebase --abort
> > 
> 
> Did you forget committing?

I don't think so.

The point is that "readme.txt" is not a tracked file on the main branch,
and thus Git should consider it precious.

I don't think the "rebase --abort" is the problem here, though. It's the
command before:

  git rebase main feat

The "feat" branch is already ahead of "main" (which has no new commits),
and so it just says:

  Current branch feat is up to date.

and leaves us on the "feat" branch. But in doing so, it overwrites the
precious untracked content in the working tree.

The "git rebase --abort" command then does nothing, because there's no
rebase in progress.

-Peff
