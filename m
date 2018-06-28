Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3200A1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967553AbeF1RpE (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:45:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:58626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966022AbeF1RpD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:45:03 -0400
Received: (qmail 22046 invoked by uid 109); 28 Jun 2018 17:45:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 17:45:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23386 invoked by uid 111); 28 Jun 2018 17:45:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 13:45:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 13:45:01 -0400
Date:   Thu, 28 Jun 2018 13:45:01 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
Message-ID: <20180628174501.GC31766@sigill.intra.peff.net>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 05:56:18PM +0100, Ramsay Jones wrote:

> > Yeah, this solution seems sensible. Given that we would never report any
> > error for that blob, there is no point in even looking at it. I wonder
> > if we ought to do the same for other types, too. Is there any point in
> > opening a tree that is in the skiplist?
> 
> Note that the 'blob' object has already been 'loaded' at this
> point anyway (and the basic 'object' checks have been done).

Yeah, you're right. If we wanted to avoid that, we should prevent it
from entering the gitmodules_found list in the first place.

Of course, we'd generally still load it once anyway in order to check
the sha1. So really, the most we could do is prevent it from being
loaded a _second_ time for no reason during the fsck_finish() stage.

But for the reasons I gave in the fsck_finish() patches (like pack
ordering), we will quite often end up hitting it in the first pass
anyway. So it's probably not worth spending too much time trying to
optimize it.

And thinking on that, my "should we do this for trees" is pretty dumb,
too. We load them and compute their sha1 anyway (I _think_ bitrot checks
like that are totally independent of skiplist). So all we'd be saving is
walking the buffer entries.

> I did think about this, briefly, but decided that we should
> only 'skip' the leaf nodes (blobs). (So, when processing
> commits, trees and tags, we should not report an error for
> that object-id, but that should not stop us from checking
> the tree object associated with a commit, just because of
> a problem with the commit message).
> 
> [Oh, wait - Hmm, each object could be checked independently
> of all others and not used for any object traversal right?
> (e.g. using packfile index). I saw fsck_walk() and didn't
> look any further ... Ah, broken link check, ... I obviously
> need to read the code some more ... :-D ]

Yes, I've been confused by this code before. I'm still not sure I
totally understand it. ;)

> > One thing we could do is turn the parse failure into a noop. The main
> > point of the check is to protect people against the malicious
> > .gitmodules bug. If the file can't be parsed, then it also can't be an
> > attack vector (assuming the parser used for the fsck check and the
> > parser used by the victim behave identically).
> 
> Hmm, yeah, but I would have to provide a means of suppressing
> the config parser error messages. Something I wanted to avoid. :(

Yes, though I don't think it's too bad. We already have a "die_on_error"
flag in the config code. I think it just needs to become a tristate:
die/error/silent (and probably get passed in via config_options, since I
think we tie it right now to the file/blob source).

> Junio, do you want me to address the above 'rejected push'
> issue in this patch, or with a follow-up patch? (It should
> be a pretty rare problem - famous last words!)

Hmm, if we end up doing the config thing above, then this patch would
become unnecessary.

And I think doing that would help _all_ cases, even ones without a
skiplist. They don't need to see random config error messages either,
even if we do eventually report an fsck error.

-Peff
