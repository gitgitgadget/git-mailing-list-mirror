Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564A71F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 02:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfDWCHw (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 22:07:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37578 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729596AbfDWCHv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 22:07:51 -0400
Received: (qmail 13865 invoked by uid 109); 23 Apr 2019 02:07:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 02:07:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4616 invoked by uid 111); 23 Apr 2019 02:08:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 22:08:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 22:07:50 -0400
Date:   Mon, 22 Apr 2019 22:07:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] p5302: create the repo in each index-pack test
Message-ID: <20190423020749.GB16369@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <20190420035825.GB3559@sigill.intra.peff.net>
 <16052712.dFCfNLlQnN@mfick-lnx>
 <20190422205653.GA30286@sigill.intra.peff.net>
 <20190422211952.GA4728@sigill.intra.peff.net>
 <xmqqef5t7cil.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqef5t7cil.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 10:09:54AM +0900, Junio C Hamano wrote:

> The above is very cleanly written to convince anybody that what the
> current test does contradicts with wish #2 above, and that the two
> wishes #1 and #2 are probably mutually incompatible.
> 
> But isn't the collision check a part of the real-life workload that
> Git users are made waiting for and care about the performance of?
> Or are we purely interested in the cost of resolving delta,
> computing the object name, and writing the result out to the disk in
> this test and the "overall experience" benchmark is left elsewhere?

I think we _are_ just interested in the resolving delta cost (after all,
we're testing it with various thread levels). What's more, the old code
would run the test $GIT_PERF_COUNT times, once without any objects, and
then the other N-1 times with objects. And then take the smallest time,
which would generally be the one-off!  So we're really just measuring
that case more consistently now.

But even if you left all of that aside, I think the case without objects
is actually the realistic one. It represents the equivalent a full
clone, where we would not have any objects already.

The case where we are fetching into a repository with objects already is
also potentially of interest, but this test wouldn't show that very
well. Because there the main added cost is looking up each object and
saying "ah, we do not have it; no need to do a collision check", because
we'd generally not expect the other side to be sending us duplicates.

But because this test would be repeating itself on the same pack each
time, we'd be seeing a collision on _every_ object. And the added time
would be dominated by us saying "oops, a collision; let's take the slow
path and reconstruct that object from disk so we can compare its bytes".

> The reason why I got confused is because the test_description of the
> script leaves "the actual effects we're interested in measuring"
> unsaid, I think.  The log message of b8a2486f ("index-pack: support
> multithreaded delta resolving", 2012-05-06) that created this test
> does not help that much, either.
> 
> In any case, the above "this forgets one thing" makes it clear that
> we at this point in time declare what we are interested in very
> clearly, and I agree that the solution described in the paragraph
> below clearly matches the goal.  Looks good.

So I think you convinced yourself even before my email that this was the
right path, but let me know if you think it's worth trying to revise the
commit message to include some of the above reasoning.

> > -	GIT_DIR=t1 git index-pack --threads=1 --stdin < $PACK
> > +	rm -rf repo.git &&
> > +	git init --bare repo.git &&
> > +	GIT_DIR=repo.git git index-pack --threads=1 --stdin < $PACK
> 
> This is obviously inherited from the original, but do we get scolded
> by some versions of bash for this line, without quoting the source path
> of the redirection, i.e.
> 
> 	... --stdin <"$PACK"

In general, yes, but I think we are OK in this instance because we
generated $PACK ourselves in the setup step, and we know that it is just
a relative .git/objects/pack/xyz.pack with no spaces. I almost touched
it just to get rid of the style-violating space after the "<" though. ;)

-Peff
