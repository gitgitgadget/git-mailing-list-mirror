Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA501F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758019AbcIGSq7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:46:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:39514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1758009AbcIGSq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:46:57 -0400
Received: (qmail 16943 invoked by uid 109); 7 Sep 2016 18:46:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 18:46:56 +0000
Received: (qmail 6543 invoked by uid 111); 7 Sep 2016 18:47:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 14:47:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 14:46:53 -0400
Date:   Wed, 7 Sep 2016 14:46:53 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 2/2] patch-ids: skip merge commits
Message-ID: <20160907184653.ed5c4oklyywjj2gp@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
 <20160907075425.6jgamuwm66xbklu3@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609071338310.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609071338310.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 02:52:04PM +0200, Johannes Schindelin wrote:

> > diff --git a/patch-ids.c b/patch-ids.c
> > index 77e4663..b1f8514 100644
> > --- a/patch-ids.c
> > +++ b/patch-ids.c
> > @@ -7,10 +7,12 @@
> >  int commit_patch_id(struct commit *commit, struct diff_options *options,
> >  		    unsigned char *sha1, int diff_header_only)
> >  {
> > -	if (commit->parents)
> > +	if (commit->parents) {
> > +		if (commit->parents->next)
> > +			return 0;
> >  		diff_tree_sha1(commit->parents->item->object.oid.hash,
> >  			       commit->object.oid.hash, "", options);
> > -	else
> > +	} else
> 
> With this change, commit_patch_id() will return 0 for merge commits
> (indicating success) but it will not have touched the sha1! Which means it
> may very well have all kinds of crap in the sha1 that may, or may not,
> match another, real patch ID randomly.

Eek, thanks. Somehow I got it into my head that diff_flush_patch_id()
below was what added it to the list, but clearly that is not the case.
Looking at it again, I can't imagine how that is the case.

> I would suggest to simply copy the merge commit's SHA-1. It is no patch
> ID, of course, but collisions are as unlikely as commit name collisions,
> and it would make the "patch ID" of a merge commit deterministic again.

I agree that would work, though it does mean carrying extra useless
entries in the patch_id hash. I'll see how bad it would be to simply
omit them entirely, but this seems like a good fallback plan.

Thanks, and sorry for the obviously braindead patch.

-Peff
