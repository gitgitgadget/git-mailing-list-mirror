Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F78C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 13:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjFANbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjFANbf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 09:31:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E2410C6
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 06:31:08 -0700 (PDT)
Received: (qmail 4750 invoked by uid 109); 1 Jun 2023 13:31:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 13:31:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23271 invoked by uid 111); 1 Jun 2023 13:30:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 09:30:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 09:30:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jim Pryor <dubiousjim@gmail.com>, git@vger.kernel.org
Subject: Re: git 2.40.1 tree-diff crashes with (glob) magic on pathspecs
Message-ID: <20230601133057.GA2458601@coredump.intra.peff.net>
References: <c2b73d05-1214-4e30-bab6-14e0b8d69773@app.fastmail.com>
 <20230527173903.GB1460206@coredump.intra.peff.net>
 <xmqqsfbbd9oi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfbbd9oi.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2023 at 02:38:05PM +0900, Junio C Hamano wrote:

> > So follow-mode does not actually work with wildcards, but we err on the
> > side of not rejecting them outright. In that sense, the simplest "fix"
> > here would be to allow :(glob) to match the '#if 0' section, like:
> 
> Is it "fix" or widening the wound, though?  The runtime BUG is very
> unpleasant to see, but silently giving a possibly wrong result would
> be even worse, I am afraid.

I think it's the same wrong result we'd give in other circumstances,
which in some ways makes it orthogonal. I.e., this is already wrong:

  git log --follow 'foo*'

Doing:

  git --noglob-pathspecs --follow 'foo*'

makes it right (assuming you really have a literal '*' in your
pathname). And then doing:

  git --noglob-pathspecs --follow ':(glob)foo*'

makes it wrong again, but in exactly the same way as the first case.
Which is why I said "orthogonal" above, because it is really just
twiddling options to cancel each other out and reach the same broken
state. ;)

All of that said, I do think the patch I showed earlier is pretty ugly,
and it is not even fixing all of the problems (you can trigger the same
BUG() for ":(icase)", etc). I have a series which moves us in a better
direction, but I need to put a few finishing touches on it. I'll
hopefully send it later today.

> If somebody cares about the "--follow" mode very deeply, the "upon
> finding that the path disappears, run the rename detection with the
> parent and switch the (single) path to follow to the old path in the
> parent" logic must be updated to keep track of these pathspecs per
> traversal paths.  If false positives are allowed, an approximation
> that may be easier to implement is to add paths to the set of paths
> to be followed every time such a rename is found.

Yes, it would be nice to fix all of these --follow bugs once and for
all. But that's a pretty big task. I think in the meantime, it is not
too hard to make Jim's case behave more sensibly.

-Peff
