Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5EB1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934514AbeF1RaR (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:30:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:58594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933596AbeF1RaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:30:16 -0400
Received: (qmail 21467 invoked by uid 109); 28 Jun 2018 17:30:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 17:30:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23175 invoked by uid 111); 28 Jun 2018 17:30:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 13:30:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 13:30:14 -0400
Date:   Thu, 28 Jun 2018 13:30:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
Message-ID: <20180628173014.GB31766@sigill.intra.peff.net>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <xmqqr2kqyies.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2kqyies.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 09:39:39AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, this solution seems sensible. Given that we would never report any
> > error for that blob, there is no point in even looking at it. I wonder
> > if we ought to do the same for other types, too. Is there any point in
> > opening a tree that is in the skiplist?
> 
> Suppose the tree is listed there only because it has one entry for a
> subtree with leading 0 in its mode.  We do want to ignore that
> format violation, but we still want to learn the fact that the
> subtree it points at and its contents are connected and not
> dangling, so we do need to open it.  Is that open done in a separate
> phase?

To be honest, I'm not sure. There _is_ a separate phase for checking
reachability, but I think there may be some dependencies between the
phases. Once upon a time they were communicated by the existence of
entries in obj_hash (blech!) but I think these days it happens using a
a bit in object->flags.

There is at least one case of interest just in this phase, though: we
have to read the surrounding tree to find out that a particular blob is
a .gitmodules file. So if you skiplist'd a tree, that would also mean we
fail to mark its .gitmodules (if any) as such. I'm not sure if that
would be a bug or a feature, though.

-Peff
