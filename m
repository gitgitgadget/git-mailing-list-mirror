Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD2C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DD020721
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgECJJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 05:09:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:34994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727946AbgECJJx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 05:09:53 -0400
Received: (qmail 21698 invoked by uid 109); 3 May 2020 09:09:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 09:09:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4767 invoked by uid 111); 3 May 2020 09:09:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 05:09:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 05:09:52 -0400
From:   Jeff King <peff@peff.net>
To:     clime <clime7@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git for-each-ref - sorting by multiple keys
Message-ID: <20200503090952.GA170768@coredump.intra.peff.net>
References: <CAGqZTUvuJgZH-YUxDTYunng3QD4-wwPgquZX1P=1P1R=Ku0s2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGqZTUvuJgZH-YUxDTYunng3QD4-wwPgquZX1P=1P1R=Ku0s2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 10:31:50PM +0200, clime wrote:

> I have the following command:
> 
> /usr/bin/git for-each-ref --merged="${GIT_HEAD-HEAD}"
> --sort='-taggerdate' --sort='-*committerdate'
> --format="%(*committerdate)|%(taggerdate)|%(tag)" refs/tags
> 
> I thought this will use: -*commiterdate as a primary key and
> -taggerdate as a secondary. According to man page for --sort: "You may
> use the --sort=<key> option multiple times, in which case the last key
> becomes the primary key."
> 
> But that doesn't seem to be the case. I created a repo with a single
> commit and created annotated tags on the commit in the following
> order:

It looks like this has been quite broken since 2015 and nobody noticed. :(

Thanks for your reproduction recipe; using times is a critical part of
the bug. Here's a fix, plus a fix for a related bug I noticed while
working on it (the second one fixes your bug).

  [1/2]: ref-filter: apply --ignore-case to all sorting keys
  [2/2]: ref-filter: apply fallback refname sort only after all user sorts

 builtin/branch.c        |  2 +-
 builtin/for-each-ref.c  |  2 +-
 builtin/tag.c           |  2 +-
 ref-filter.c            | 13 +++++-
 ref-filter.h            |  2 +
 t/t6300-for-each-ref.sh | 94 ++++++++++++++++++++++++++++++++++++++---
 6 files changed, 104 insertions(+), 11 deletions(-)

-Peff
