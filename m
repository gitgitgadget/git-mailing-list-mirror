Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442071F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390275AbfIFRei (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:34:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:42282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389723AbfIFRei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:34:38 -0400
Received: (qmail 21326 invoked by uid 109); 6 Sep 2019 17:34:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 17:34:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5269 invoked by uid 111); 6 Sep 2019 17:36:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 13:36:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 13:34:37 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
Message-ID: <20190906173436.GE23181@sigill.intra.peff.net>
References: <cover.1567720960.git.me@ttaylorr.com>
 <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
 <20190906061919.GA5122@sigill.intra.peff.net>
 <20190906154214.GA3657@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906154214.GA3657@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 11:42:14AM -0400, Taylor Blau wrote:

> > >  struct object_id *get_commit_tree_oid(const struct commit *commit)
> > >  {
> > > -	return &get_commit_tree(commit)->object.oid;
> > > +	struct tree *tree = get_commit_tree(commit);
> > > +	return tree ? &tree->object.oid : NULL;
> > >  }
> 
> You mentioned in the version of this series that is rebased on GitHub's
> fork that it may be worth putting this hunk in a separate commit
> entirely. I don't disagree, so if there are other comments that merit a
> reroll of this, I'm happy to pull this change out as 3/4.

Yeah, I could go either way on that, I think. I was thinking it might be
fixing other callsites, but it seems that nobody else bothers to check
for NULL anyway. But being in its own commit, we could explain that.

> > This one in theory benefits lots of other callsites, too, since it means
> > we'll actually return NULL instead of nonsense like "8". But grepping
> > around for calls to this function, I found literally zero of them
> > actually bother checking for a NULL result. So there are probably dozens
> > of similar segfaults waiting to happen in other code paths.
> > Discouraging.
> 
> Discouraging indeed. I think that you suggest it below, but perhaps the
> right thing to do here is implement 'get_commit_tree_oid()' as follows:
> 
>   struct object_id *get_commit_tree_oid(const struct commit *commit)
>   {
>     struct tree *tree = get_commit_tree(commit);
>     if (!tree)
>       die(_("unable to get tree from commit %s"),
>           oid_to_hex(&commit->object.oid));
>     return &tree->object.oid;
>   }
> 
> Which then puts the onus on the *caller* to check their commit pointer
> to make sure that it has a legit tree in it, unless they're OK with
> dying.

Yeah, I agree that would prevent segfaults (and is similar to what René
proposed for tags with a similar situation). It does feel like a step
backwards in terms of lib-ification. But maybe it's a
belt-and-suspenders on top of trying to catch this case at the parsing
stage, too.

> All of that said, I don't know if I think it's worth holding this series
> up on the above in the meantime. I do think that it (or something like
> it) is generally worth doing, but I'm not sure that now is the time to
> do it.

I'd agree with that, and I think it's sensible to take your patches with
the extra tree check. We can rip it out later if it becomes redundant.

-Peff
