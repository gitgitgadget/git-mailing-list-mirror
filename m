Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4D21FAE4
	for <e@80x24.org>; Thu, 15 Mar 2018 14:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeCOOJY (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 10:09:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57918 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751535AbeCOOJX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 10:09:23 -0400
Received: (qmail 26163 invoked by uid 109); 15 Mar 2018 14:09:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Mar 2018 14:09:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14897 invoked by uid 111); 15 Mar 2018 14:10:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Mar 2018 10:10:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2018 10:09:21 -0400
Date:   Thu, 15 Mar 2018 10:09:21 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: How to debug a "git merge"?
Message-ID: <20180315140921.GA27748@sigill.intra.peff.net>
References: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com>
 <20180314222028.GA20977@sigill.intra.peff.net>
 <1632E897-B434-4ECC-A236-49C03398DF55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1632E897-B434-4ECC-A236-49C03398DF55@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 10:51:27AM +0100, Lars Schneider wrote:

> > Maybe a stupid question, but: did you make sure that the merge does
> > indeed pick the wrong version of the file? The other option is that
> > somebody mistakenly did a "checkout --ours" or similar while resolving
> > the conflict.
> 
> No stupid question at all. That's exactly what they did and I did not
> realize it! Thank you!

Oh good. :) I have run across this same situation before myself, which
is why I thought to ask about it.

> Next time I won't stumble over this. I wonder if this is a common enough
> problem to do something about it? For instance what if `git log` (or just
> `git show`) has an option `--verify-merges` or `--reenact-merges` or 
> something? This option would perform a "default recursive merge" and 
> show the diff between the actual merge and the default merge?
> 
> In the most common case there is no diff. If there are merge conflicts
> then we would just show the conflicting files. If there is no merge
> conflict for a file *but* a difference then we would show it. I think
> this would have helped me to realize this kind of problem earlier.
> 
> Would that option make sense to you?

Yes, it's absolutely a good idea, and a frequent wish-list item. The
problem is that it's tricky to implement. The only working patches I
know of were Thomas Rast's "--remerge-diff" from 2014:

  https://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/

The tricky thing is that you have to actually re-run the diff, and we
don't know what options were used for the original diff (e.g., what
strategy). And also, merge-recursive really wants to have a valid
working tree (though I think maybe that has gotten better over the
years).

But even with those warts, I still found it useful in many cases.

-Peff
