Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95812C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A996613EB
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhE0OkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:40:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:38838 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234394AbhE0OkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:40:20 -0400
Received: (qmail 4888 invoked by uid 109); 27 May 2021 14:38:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 May 2021 14:38:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3375 invoked by uid 111); 27 May 2021 14:38:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 May 2021 10:38:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 May 2021 10:38:45 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 7/8] receive-pack: skip connectivity checks on
 delete-only commands
Message-ID: <YK+u9SWQrnJe51Gq@coredump.intra.peff.net>
References: <cover.1621451532.git.ps@pks.im>
 <68c60aff0c77c562aba5613ccbb9ab33ad8e0e08.1621451532.git.ps@pks.im>
 <60a801bdd1b4b_5580620828@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a801bdd1b4b_5580620828@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 01:53:49PM -0500, Felipe Contreras wrote:

> Patrick Steinhardt wrote:
> > In the case where git-receive-pack(1) receives only commands which
> > delete references, then per technical specification the client MUST NOT
> > send a packfile. As a result, we know that no new objects have been
> > received, which makes it a moot point to check whether all received
> > objects are fully connected.
> 
> I don't know if this is related but yesterday I decided to delete a
> bunch of refs from a forked repo in GitHub. I did it naively with a for
> loop and so it was doing a bunch of `git push myrepo :ref`.
> 
> It was unbearably slow.
> 
> Sure, it was a stupid thing to do, but maybe it can help you do some
> tests.

Patrick's patch might help some, as it would avoid calling rev-list at
all. But we wouldn't do any traversal in that command if there are no
positive tips anyway, so it is really just saving the startup overhead
of iterating the ref tips to add them to the traversal.

In the case of GitHub, the problem is much more likely outside of Git's
immediate control. Every push will run GitHub-specific hooks for things
like branch protections, etc, and there's a lot of overhead there.

-Peff
