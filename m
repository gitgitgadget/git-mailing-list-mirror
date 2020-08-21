Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6EBC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066F220738
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgHURVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:21:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgHURVj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:21:39 -0400
Received: (qmail 18743 invoked by uid 109); 21 Aug 2020 17:21:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 17:21:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29848 invoked by uid 111); 21 Aug 2020 17:21:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 13:21:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 13:21:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] refs: remove lookup cache for reference-transaction hook
Message-ID: <20200821172137.GA3261095@coredump.intra.peff.net>
References: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
 <20200821143727.GA3241139@coredump.intra.peff.net>
 <xmqqeeo09chm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeeo09chm.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 09:42:45AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > However, I wondered...
> >
> >> +test_perf "nonatomic push" '
> >> +	git push ./target-repo.git branch-{1..1000} &&
> >> +	git push --delete ./target-repo.git branch-{1..1000}
> >> +'
> 
> Is this a bash-and-ksh-only test?  At least, the above would not try
> to push 1000 branches with the version of dash I have.

Heh, I was so focused on the "push" part of it that I didn't even look
carefully at the second half of the command-line. ;)

I think pushing "refs/heads/branch-*" would work for pushing. For
deletion, though, I don't think we allow wildcards in the refspecs.
You could abuse pruning:

  git push --prune ../dst.git refs/heads/does-not-exist/*:refs/heads/*

It also may be OK to just omit that half of the test. I think the
initial push exercises the case we care about. Though I guess we do run
the test repeatedly, so we might have to do:

  rm -rf dst.git &&
  git init dst.git &&
  git push dst.git refs/heads/branch-*

-Peff
